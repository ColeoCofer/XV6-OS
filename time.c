#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "testtime.h"

static void printAsFloat(int num);

int
main(int argc, char * argv[])
{
  
  //Time was ran without a parameter
  if (argc == 1) 
  {
    printf(1, "\n%s ran in 0.000\n", argv[0]); 
  }
  else
  {

    int startTime = uptime(); 
    int pid = fork();;    

    if (pid == 0)
    {
      //Execute the process with any arguments it has
      if (exec(argv[1], argv + 1) < 0)
      {
        printf(2, "Error: Invalid Command.\n");
        exit();
      }
    } 

    //Wait for the child process to finish
    if (pid > 0) {
      wait();
    } 

    //Fork returned negative PID
    if (pid < 0)
    {
      printf(2, "Error: Fork failed");
    }

    printf(1, "%s ran in ", argv[1]);
    printAsFloat(uptime() - startTime); 
    printf(1, " seconds\n");      

  }
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

