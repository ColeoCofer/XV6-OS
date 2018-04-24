#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#ifdef CS333_P2
#include "uproc.h"
#endif

#ifdef CS333_P3P4
struct StateLists {
  struct proc* ready;        //Able to be scheduled on processor
  struct proc* readyTail;
  struct proc* free;         //Unused and able to be allocated into a new process
  struct proc* freeTail;
  struct proc* sleep;        //Waiting on some future even
  struct proc* sleepTail;
  struct proc* zombie;       //Waiting to be "reaped" by their parent proc or init proc
  struct proc* zombieTail;
  struct proc* running;      //Currently executing on the CPU
  struct proc* runningTail;
  struct proc* embryo;       //Currently being initialized
  struct proc* embryoTail;
};
#endif

struct { 
  struct spinlock lock;   
  struct proc proc[NPROC];
  #ifdef CS333_P3P4
  struct StateLists pLists; 
  #endif
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);
static void wakeup1(void *chan);

#if defined CS333_P3P4
static void initProcessLists(void);
static void initFreeList(void);
static int stateListAdd(struct proc** head, struct proc** tail, struct proc* p);
static int stateListRemove(struct proc** head, struct proc** tail, struct proc* p);
static void procDumpP3P4();
static void assertState(struct proc * p, enum procstate state);
extern int strcmp(const char *p, const char *q);
#elif defined CS333_P2
static void procDumpP2(struct proc *p, char *state, int elapsedTime);

#elif CS333_P1
static void procDumpP1(struct proc *p, char *state, int elapsed_time);

#else
static void procDump0(struct proc *p, char * state);
#endif

#if defined(CS333_P3P4) || defined(CS333_P2)
static void printAsFloat(int totalTime);
#endif


void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.

// jallocproc //

static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;
  
  acquire(&ptable.lock);

  #ifndef CS333_P3P4
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  #endif


  #ifdef CS333_P3P4
  if (ptable.pLists.free) {
    p = ptable.pLists.free;
    goto found;
  }
  #endif

  release(&ptable.lock);
  return 0;

 found:

  #ifdef CS333_P3P4
  //State Transition UNUSED -> EMBRYO
  if (stateListRemove(&ptable.pLists.free, &ptable.pLists.freeTail, p) == -1)
    panic("Called in allocproc(): stateListRemove failed");
  assertState(p, UNUSED);
  p->state = EMBRYO;
  if (stateListAdd(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) == -1)
    panic("Called in allocproc(): stateListAdd failed");
  #endif

  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){

    #ifdef CS333_P3P4
    acquire(&ptable.lock);
    //State Transition EMBRYO -> UNUSED
    if (stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) == -1)
      panic("Called in allocproc(): stateListRemove returned -1 (couldn't remove)");
    assertState(p, EMBRYO);
    p->state = UNUSED;
    if (stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p) == -1)
      panic("Called in allocproc(): stateListAdd failed");
    release(&ptable.lock);
    #endif

    #ifndef CS333_P3P4
    p->state = UNUSED;
    #endif

    return 0;
  }

  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  
  #ifdef CS333_P1
  p->start_ticks = ticks; //Set the starting ticks on alloc
  #endif

  #ifdef CS333_P2 
  p->cpu_ticks_total = 0; //Total elapsed ticks
  p->cpu_ticks_in = 0;    //Ticks when scheduled
  #endif
    
  return p;
}

//PAGEBREAK: 32
// Set up first user process.

// juserinit //

void
userinit(void)
{  

  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  #ifdef CS333_P3P4
  acquire(&ptable.lock);

  initProcessLists(); 
  initFreeList();       

  release(&ptable.lock);
  #endif

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S
  
  safestrcpy(p->name, "initcode", sizeof(p->name));  
  p->cwd = namei("/");

  #ifdef CS333_P3P4
  acquire(&ptable.lock);

  //State Transition
  if (stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, p) == -1)
    panic("Called in userinit: stateListRemove failed");

  assertState(p, EMBRYO);  
  p->state = RUNNABLE;
  
  ptable.pLists.ready = p;         //Since this is the first proc, put it on the ready list
  ptable.pLists.readyTail = p;
  ptable.pLists.ready->next = 0;   //Set the next pointer to null
  release(&ptable.lock); 
  #endif


  #ifdef CS333_P2
  p->uid = DEFAULT_UID;
  p->gid = DEFAULT_GID;
  #endif

}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n) 
{
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){ 
    kfree(np->kstack);
    np->kstack = 0;

    //State Transition embro -> free
    #ifdef CS333_P3P4
    acquire(&ptable.lock);
    if (stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, np) == -1)
      panic("Called from fork: stateListRemove failed");

    assertState(np, EMBRYO);
    np->state = UNUSED;
    
    if (stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, np) == -1)
      panic("Called from fork: stateListAdd failed");
    release(&ptable.lock);
    #endif

    return -1;
  }

  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);

  //State Transition embryo -> ready
  #ifdef CS333_P3P4
  if (stateListRemove(&ptable.pLists.embryo, &ptable.pLists.embryoTail, np) == -1)
    panic("Called from fork: stateListRemove failed (line 283 ish)");
  assertState(np, EMBRYO);
  np->state = RUNNABLE;
  if (stateListAdd(&ptable.pLists.ready, &ptable.pLists.readyTail, np) == -1)
    panic("Called from fork: stateListAdd failed");  
  #endif

  #ifndef CS333_P3P4
  np->state = RUNNABLE;
  #endif

  release(&ptable.lock);

  #ifdef CS333_P2
  //Give the new process the old old process's uid and gid
  np->uid = proc->uid;
  np->gid = proc->gid;
  #endif

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
#ifndef CS333_P3P4
void
exit(void)
{
  //Would have to be coing from the running state
  //So it's running to zombie transition
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}
#else

// jexit //
 
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  for (p = ptable.pLists.embryo; p; p = p->next) {
    if (p->parent == proc)
      p->parent = initproc;
  }

  for (p = ptable.pLists.ready; p; p = p->next) {
    if (p->parent == proc)
      p->parent = initproc;
  }

  for (p = ptable.pLists.sleep; p; p = p->next) {
    if (p->parent == proc)
      p->parent = initproc;
  }

  for (p = ptable.pLists.running; p; p = p->next) {
    if (p->parent == proc)
      p->parent = initproc;
  }

  for (p = ptable.pLists.zombie; p; p = p->next) {
      if (p->parent == proc) {
      p->parent = initproc;
      wakeup1(initproc);
      }
  }

  if (ptable.pLists.running)
    cprintf("state: %d", ptable.pLists.running->state);

  if (stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, p) == -1)
    panic("Called from exit(): stateListRemove failed");
  assertState(p, RUNNING);
  p->state = ZOMBIE;
  if (stateListAdd(&ptable.pLists.zombie, &ptable.pLists.zombieTail, p) == -1)
    panic("Called from exit(): stateListAdd failed");

  sched();
  panic("zombie exit");
}
#endif

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
#ifndef CS333_P3P4
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
#else
// jwait //
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for (p = ptable.pLists.zombie; p; p = p->next) {
      if(p->parent != proc)
        continue;
      havekids = 1;

      // Found one.
      pid = p->pid;
      kfree(p->kstack);
      p->kstack = 0;
      freevm(p->pgdir);

      //State Transition
      if (stateListRemove(&ptable.pLists.zombie, &ptable.pLists.zombieTail, p) == -1)
        panic("Called from wait(): stateListRemove failed");
      p->state = UNUSED;
      if (stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p) == -1)
        panic("Called from wait(): stateListAdd failed");

      p->pid = 0;
      p->parent = 0;
      p->name[0] = 0;
      p->killed = 0;
      release(&ptable.lock);
      return pid;        
    }

    for (p = ptable.pLists.ready; p; p = p->next) {
      if (p->parent == proc) {
        havekids = 1;
        goto checkKids;
      }
    }

    for (p = ptable.pLists.sleep; p; p = p->next) {
      if (p->parent == proc) {
        havekids = 1;
        goto checkKids;
      }
    }

    for (p = ptable.pLists.embryo; p; p = p->next) {
      if (p->parent == proc) {
        havekids = 1;
        goto checkKids;
      }
    }

    for (p = ptable.pLists.running; p; p = p->next) {
      if (p->parent == proc) {
        havekids = 1;
        goto checkKids;
      }
    }


  checkKids:
    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
#endif

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
#ifndef CS333_P3P4
// original xv6 scheduler. Use if CS333_P3P4 NOT defined.
void
scheduler(void)
{
  struct proc *p;
  int idle;  // for checking if processor is idle

  for(;;){
    // Enable interrupts on this processor.
    sti();

    //************ THIS IS OLD SCHEDULER *************************************/

    idle = 1;  // assume idle unless we schedule a process
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      idle = 0;  // not idle this timeslice
      proc = p;
      switchuvm(p);
      p->state = RUNNING;

      #ifdef CS333_P2
      proc->cpu_ticks_in = ticks; 
      #endif

      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      //************ THIS IS OLD SCHEDULER *************************************/

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
  }
}

// jscheduler //

#else
void
scheduler(void)
{
  struct proc *p;
  int idle;  // for checking if processor is idle

  for(;;){
    // Enable interrupts on this processor.
    sti();

    idle = 1;  // assume idle unless we schedule a process
    
    acquire(&ptable.lock);
    for (p = ptable.pLists.ready; p; p = p->next) {
      idle = 0;  
      proc = p;
      switchuvm(p);
      
      //Remove the proc from the ready list
      if (stateListRemove(&ptable.pLists.ready, &ptable.pLists.readyTail, p) == -1)
        panic("Called in scheduler: stateListRemove failed to remove process");

      assertState(p, RUNNABLE);
      p->state = RUNNING; //Change state to running
      
      //Put the proc onto the running list
      if (stateListAdd(&ptable.pLists.running, &ptable.pLists.runningTail, p) == -1)
        panic("Called in scheduler: stateListAdd() returned non-zero value");
      
      #ifdef CS333_P2
      proc->cpu_ticks_in = ticks; 
      #endif              
      
      swtch(&cpu->scheduler, proc->context);
      switchkvm();
      
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
  }
  
  // if idle, wait for next interrupt
  if (idle) {
    sti();
    hlt();
  }
}
#endif

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;

#ifdef CS333_P2
  proc->cpu_ticks_total += ticks - proc->cpu_ticks_in;
#endif

  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  #ifdef CS333_P3P4
  if (stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) == -1)
    panic("Called in yield: stateListRemove failed");
  assertState(proc, RUNNING);
  proc->state = RUNNABLE;
  if (stateListAdd(&ptable.pLists.ready, &ptable.pLists.readyTail, proc) == -1)
    panic("Called in yield: stateListAdd failed");
  #endif

  #ifndef CS333_P3P4
  proc->state = RUNNABLE;
  #endif

  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
// 2016/12/28: ticklock removed from xv6. sleep() changed to
// accept a NULL lock to accommodate.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){
    acquire(&ptable.lock);
    if (lk) release(lk);
  }

  // Go to sleep.
  proc->chan = chan;

  //State Transition RUNNING -> SLEEPING
  #ifdef CS333_P3P4
  if (stateListRemove(&ptable.pLists.running, &ptable.pLists.runningTail, proc) == -1)
    panic("Called in sleep: stateListRemove failed");

  assertState(proc, RUNNING);
  proc->state = SLEEPING;

  if (stateListAdd(&ptable.pLists.sleep, &ptable.pLists.sleepTail, proc) == -1)
    panic("Called in sleep: stateListAdd failed");
  
  #endif

  #ifndef CS333_P3P4
  proc->state = SLEEPING;
  #endif
  sched();

  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}

//PAGEBREAK!
#ifndef CS333_P3P4

// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
#else

// jwakeup1 //

static void
wakeup1(void *chan) 
{
  struct proc * p;

  //Traverse the sleep list
  for (p = ptable.pLists.sleep; p; p = p->next) {
    if (p->chan == chan) {            
      //State Transition SLEEPING -> RUNNABLE
      if (stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) == -1)
        panic("Called from wakeup1: stateListsRemove failed");

      assertState(p, SLEEPING);
      p->state = RUNNABLE;

      //Add to the ready list
      if (stateListAdd(&ptable.pLists.ready, &ptable.pLists.readyTail, p) == -1) 
        panic("Called from wakeup1: stateListsAdd failed");
    }
  }
}
#endif

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
#ifndef CS333_P3P4
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
#else

// jkill //

int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  
  for (p = ptable.pLists.sleep; p; p = p->next) {
    if(p->pid == pid) { 
      p->killed = 1;

      #ifdef CS333_P3P4
      //State Transition SLEEPING -> RUNNABLE
      if (stateListRemove(&ptable.pLists.sleep, &ptable.pLists.sleepTail, p) == -1)
        panic("Called from kill: stateListsRemove failed");

      assertState(p, SLEEPING);
      p->state = RUNNABLE;

      if (stateListAdd(&ptable.pLists.ready, &ptable.pLists.readyTail, p) == -1)
        panic("Called from kill: stateListsAdd failed");
      #endif

      release(&ptable.lock);
      return 0;
    }
  }

  for (p = ptable.pLists.embryo; p; p = p->next) {
    if (p->pid == pid) {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
  }

  for (p = ptable.pLists.ready; p; p = p->next) {
    if (p->pid == pid) {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
  }

  for (p = ptable.pLists.running; p; p = p->next) {
    if (p->pid == pid) {
      p->killed = 1;
      release(&ptable.lock);
      return 0;
    }
  }

  release(&ptable.lock);
  return -1;
}
#endif

static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
};

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) 
{
  int i;
  
  struct proc *p;
  char *state; 
  uint pc[10];

  //This code was provided by Mark Morrissey (but was altered)
#if defined (CS333_P3P4)
#define HEADER "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined (CS333_P2)
#define HEADER "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\t PCs\n"
#elif defined (CS333_P1)
#define HEADER "PID\tState\tName\tElapsed\t PCs\n"
#else
#define HEADER "PID\tState\tName\t PCs\n"
#endif

  cprintf(HEADER);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";

#if defined (CS333_P3P4)
    procDumpP3P4(p, state, ticks - p->start_ticks);
#elif defined (CS333_P2) 
    procDumpP2(p, state, ticks - p->start_ticks); 
#elif defined (CS333_P1)
    procDumpP1(p, state, ticks - p->start_ticks);
#else
    procDump0(p, state);
#endif
    
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);

      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

#if defined CS333_P3P4
static void
procDumpP3P4(struct proc *p, char *state, int elapsedTime) 
{
  //Find out the ppid
  uint ppid = 0;
  if (!p->parent)
    ppid = 1;
  else
    ppid = p->parent->pid;

  cprintf("%d\t%s\t%d\t%d\t%d\t", p->pid, p->name, p->uid, p->gid, ppid);
  printAsFloat(elapsedTime); cprintf("\t");
  printAsFloat(p->cpu_ticks_total); cprintf("\t");
  cprintf("%s\t%d\t", state, p->sz);
}
#elif defined CS333_P2

static void
procDumpP2(struct proc *p, char *state, int elapsedTime) 
{
  //Find out the ppid
  uint ppid = 0;
  if (!p->parent)
    ppid = 1;
  else
    ppid = p->parent->pid;
  
  cprintf("%d\t%s\t%d\t%d\t%d\t", p->pid, p->name, p->uid, p->gid, ppid);
  printAsFloat(elapsedTime); cprintf("\t");
  printAsFloat(p->cpu_ticks_total); cprintf("\t");
  cprintf("%s\t%d\t", state, p->sz);
}


int
getprocs(uint max, struct uproc* table)
{
  
  //Max is above the maximum amount of processes
  if (max > NPROC)
    return -1;

  struct proc * currProc;
  acquire(&ptable.lock);

  //Traverse the ptable of size uproc * max
  int i = 0;
  for (currProc = ptable.proc; currProc < &ptable.proc[NPROC] && i < max; ++currProc)
  {

    //Make sure currProc exists
    if (currProc->state != UNUSED && currProc->state != EMBRYO)
    {      
      table[i].pid = currProc->pid;
      table[i].uid = currProc->uid;
      table[i].gid = currProc->gid;
      !currProc->parent ? (table[i].ppid = currProc->pid) : (table[i].ppid = currProc->parent->pid);
      
      table[i].elapsed_ticks = ticks - currProc->start_ticks;
      table[i].CPU_total_ticks = currProc->cpu_ticks_total;
      safestrcpy(table[i].name, currProc->name, sizeof(currProc->name));
      table[i].size = currProc->sz;

      //Assign the correct state
      if (currProc->state == UNUSED)
        safestrcpy(table[i].state, states[UNUSED], sizeof("unused")); 
      else if (currProc->state == EMBRYO)
        safestrcpy(table[i].state, states[EMBRYO], sizeof("embryo")); 
      else if (currProc->state == SLEEPING)
        safestrcpy(table[i].state, states[SLEEPING], sizeof("sleep ")); 
      else if (currProc->state == RUNNABLE)
        safestrcpy(table[i].state, states[RUNNABLE], sizeof("runble")); 
      else if (currProc->state == RUNNING)
        safestrcpy(table[i].state, states[RUNNING], sizeof("run   ")); 
      else if (currProc->state == ZOMBIE)
        safestrcpy(table[i].state, states[ZOMBIE], sizeof("zombie")); 

      ++i;
    }
  }
  
  release(&ptable.lock);

  return i;
}

#elif defined CS333_P1
//Prints the elapsed time in seconds
//accurate to the millisecond
static void
procDumpP1(struct proc *p, char *state, int elapsed_time)
{
  int decimalNum = elapsed_time / 1000;

  int remainder = elapsed_time % 1000;

  cprintf("%d\t%s\t%s", p->pid, state, p->name); 

  if (remainder == 0)
    cprintf("\t%d.000\t", decimalNum);
  else if (remainder < 10)
    cprintf("\t%d.00%d\t", decimalNum, remainder);
  else if (remainder < 100)
    cprintf("\t%d.0%d\t", decimalNum, remainder);
  else
    cprintf("\t%d.%d\t", decimalNum, remainder);
}

#else
static void
procDump0(struct proc *p, char * state)
{
  cprintf("%d\t%s\t%s", p->pid, state, p->name); 
}
#endif

#if defined(CS333_P3P4) || defined(CS333_P2)
//Prints an integer as a floating point number
static void
printAsFloat(int totalTime)
{   
  uint timeNum, timeRemainder;
  
  timeNum = totalTime / 1000;
  timeRemainder = totalTime % 1000;
  
  if (timeRemainder == 0)
    cprintf("%d.000", timeNum);
  else if (timeRemainder < 10)
    cprintf("%d.00%d", timeNum, timeRemainder);
  else if (timeRemainder < 100)
    cprintf("%d.0%d", timeNum, timeRemainder);
  else
    cprintf("%d.%d", timeNum, timeRemainder);
}
#endif

#ifdef CS333_P3P4

//Checks if the state is correct,
//if not it panics
static void
assertState(struct proc * p, enum procstate state)
{
  if (p->state != state) {
    cprintf("States not the same: p->state = %s, state = %s", p->state, state);
    panic("Assert Failed");
  }
}

/*
//Transitions state from one list to another list
static int
transitionStateTo(struct proc ** fromHead, struct proc ** fromTail,
                  struct proc ** toHead, struct proc ** toTail,
                  struct proc * p,
                  enum procstate oldState, enum procstate newState,
                  char * panicMessage)
{
  if (stateListRemove(&fromHead, &fromTail, p) == -1) {
    //    cprintf();
    //panic("Called from kill: stateListsRemove failed");
  }

  assertState(p, oldState);
  p->state = newState;

  //Add to the ready list
  if (stateListAdd(&toHead, &toTail, p) == -1) {
    
    //    panic("Called from kill: stateListsAdd failed");
  }

}
*/


static int
stateListAdd(struct proc** head, struct proc** tail, struct proc* p)
{
  if (*head == 0) {
    *head = p;
    *tail = p;
    p->next = 0;
  } else {
    (*tail)->next = p;
    *tail = (*tail)->next;
    (*tail)->next = 0;
  }

  return 0;
}

static int
stateListRemove(struct proc** head, struct proc** tail, struct proc* p)
{
  if (*head == 0 || *tail == 0 || p == 0) {
    return -1;
  }

  struct proc* current = *head;
  struct proc* previous = 0;

  if (current == p) {
    *head = (*head)->next;
    return 0;
  }

  while(current) {
    if (current == p) {
      break;
    }

    previous = current;
    current = current->next;
  }

  // Process not found, hit eject.
  if (current == 0) {
    return -1;
  }

  // Process found. Set the appropriate next pointer.
  if (current == *tail) {
    *tail = previous;
    (*tail)->next = 0;
  } else {
    previous->next = current->next;
  }

  // Make sure p->next doesn't point into the list.
  p->next = 0;

  return 0;
}

static void
initProcessLists(void) {
  ptable.pLists.ready = 0;
  ptable.pLists.readyTail = 0;
  ptable.pLists.free = 0;
  ptable.pLists.freeTail = 0;
  ptable.pLists.sleep = 0;
  ptable.pLists.sleepTail = 0;
  ptable.pLists.zombie = 0;
  ptable.pLists.zombieTail = 0;
  ptable.pLists.running = 0;
  ptable.pLists.runningTail = 0;
  ptable.pLists.embryo = 0;
  ptable.pLists.embryoTail = 0;
}

static void
initFreeList(void) {
  if (!holding(&ptable.lock)) {
    panic("acquire the ptable lock before calling initFreeList\n");
  }

  struct proc* p;

  for (p = ptable.proc; p < ptable.proc + NPROC; ++p) {
    p->state = UNUSED;
    stateListAdd(&ptable.pLists.free, &ptable.pLists.freeTail, p);
  }
}
#endif
