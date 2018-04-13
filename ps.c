#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "uproc.h"

int
main(void)
{
  int maxSize = 16; //Max size of the data structure
  int tableSize, i;

  struct uproc *ptable;
  ptable = malloc(maxSize * sizeof(struct uproc));
  if (!ptable)
  {
    printf(2, "Error: The ptable has no size.");
    exit();
  }

  //Check if there is actually a table there? I don't know
  
  
  tableSize = getprocs(maxSize, ptable);
  if (!tableSize)
  {
    printf(2, "Error: The ptable has no size.");
    exit();
  }
  
  //uint elapsedTime, elapsedNum, elapsedRemainder;
  //uint cpuTime, cpuNum, cpuRemainder;
  
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  for (i = 0; i < tableSize; ++i)
  {

    //elapsedTime = ptable[i].elapsed_ticks;
    //elapsedNum =  elapsedTime / 1000;
    //elapsedRemainder = elapsedTime % 1000;
    //cpuTime = ptable[i].CPU_total_ticks;
    //cpuNum = cpuTime / 1000;
    //cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);

    printf(1, "%d\t", ptable[i].elapsed_ticks);
    printf(1, "%d\t", ptable[i].CPU_total_ticks);

    printf(1, "%s\t%d\t\n",ptable[i].state, ptable[i].size);

    

  }

  
  
  exit();
}
#endif
