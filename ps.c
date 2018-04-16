#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "uproc.h"
#include "param.h"

static void printAsFloat(int elapsedTime);

int
main(int argc, char * argv[])
{
  int maxSize = NPROC; //Default max size for data structure
  int tableSize, i;

  //Check if the passed argument is within bounds
  if (argc > 1)
  {
    if (atoi(argv[1]) <= NPROC)
      maxSize = atoi(argv[1]);
    else
      maxSize = NPROC;
  }

  struct uproc *ptable;
  ptable = malloc(maxSize * sizeof(struct uproc));
  if (!ptable)
  {
    printf(2, "Error: The ptable has no size.");
    exit();
  }
  
  tableSize = getprocs(maxSize, ptable);
  if (!tableSize)
  {
    printf(2, "Error: The ptable has no size.");
    exit();
  }
  
  //  uint elapsedTime, elapsedNum, elapsedRemainder;
  //uint cpuTime, cpuNum, cpuRemainder;
  uint elapsedTime, cpuTime;
  
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  for (i = 0; i < tableSize; ++i)
  {
    
    elapsedTime = ptable[i].elapsed_ticks;
    cpuTime = ptable[i].CPU_total_ticks;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);

    printAsFloat(elapsedTime); printf(1, "\t");    
    printAsFloat(cpuTime); printf(1, "\t");    
    printf(1, "%s\t%d\t\n",ptable[i].state, ptable[i].size); 
    
  }
  
  free(ptable);  
  exit();
}

//Prints an integer as a floating point number
static void
printAsFloat(int totalTime)
{

  uint timeNum, timeRemainder;
  
  timeNum = totalTime / 1000;
  timeRemainder = totalTime % 1000;
  
  if (timeRemainder == 0)
    printf(1, "%d.000", timeNum);
  else if (timeRemainder < 10)
    printf(1, "%d.00%d", timeNum, timeRemainder);
  else if (timeRemainder < 100)
    printf(1, "%d.0%d", timeNum, timeRemainder);
  else
    printf(1, "%d.%d", timeNum, timeRemainder);
}

#endif
