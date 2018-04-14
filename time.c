//Fix all of this jazz dude. Ughz what is going on 

#ifdef CS333_P2
#include "types.h"
#include "user.h"

void printAsFloat(int num);

int
main(int argc, char * argv[])
{






  //Time was ran without a parameter
  if (argc == 1) 
  {
    printf(1, "\n%s ran in 0.000", argv[0]); 
  }
  else
  {

    uint startTime, endTime, totalTime;
    int pid; // = getpid();    
    
    startTime = uptime(); //Hopefully this is correct? 
    pid = fork();


    //Child
    //Just run the console command 
    if (pid == 0)
    {
      //  exec(argv[0], &argv[0]); //Execute the process with any arguments it has
      exec(argv[1], argv); //Execute the process with any arguments it has
      printf(2, "That is not a valid command.");
    }
    
    //Parent
    else
    {
      wait(); //Wait for the child process to finish
      endTime = uptime(); //Grab the ending time
      totalTime = endTime - startTime;
      printf(1, "\n%s ran in ", argv[1]);
      printAsFloat(totalTime);
      printf(1, " seconds\n");      
    }
  }
  exit();
}

//Prints an integer as a floating point number
void
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

