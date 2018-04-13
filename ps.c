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
  
  tableSize = getprocs(maxSize, ptable);
  if (!tableSize)
  {
    printf(2, "Error: The ptable has no size.");
    exit();
  }
  
  uint elapsedTime, elapsedNum, elapsedRemainder;
  uint cpuTime, cpuNum, cpuRemainder;
  
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  for (i = 0; i < tableSize; ++i)
  {
    //    if (ptable[i].pid != 0)
    //    {
    
    elapsedTime = ptable[i].elapsed_ticks;
    elapsedNum =  elapsedTime / 1000;
    elapsedRemainder = elapsedTime % 1000;
    cpuTime = ptable[i].CPU_total_ticks;
    cpuNum = cpuTime / 1000;
    cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);

    //Elapsed time formatting and padding
    if (elapsedRemainder == 0)
      printf(1, "%d.000\t", elapsedNum);
    else if (elapsedRemainder < 10)
      printf(1, "%d.00%d\t", elapsedNum, elapsedRemainder);
    else if (elapsedRemainder < 100)
      printf(1, "%d.0%d\t", elapsedNum, elapsedRemainder);
    else
      printf(1, "%d.%d\t", elapsedNum, elapsedRemainder);

    //CPU time
    if (cpuRemainder == 0)
      printf(1, "%d.000\t", cpuNum);
    else if (cpuRemainder < 10)
      printf(1, "%d.00%d\t", cpuNum, cpuRemainder);
    else if (cpuRemainder < 100)
      printf(1, "%d.0%d\t", cpuNum, cpuRemainder);
    else
      printf(1, "%d.%d\t", cpuNum, cpuRemainder);

    
    printf(1, "%s\t%d\t\n",ptable[i].state, ptable[i].size);
    //    }

  }

  
  free(ptable);  
  exit();
}
#endif
