#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "testprocs.h"

//This function will take an argument
//and fork / execs it.
//This code was written with the modivation 
//from the testtimewitharg function in
//p2testsuite.c (lines 307-322) which was
//provided by Mark Morrissey
void runWithArg(char **arg)
{

  int forkRet;

  forkRet = fork();  
 
  //Check if its the child
  if (forkRet == 0) {   
    if (exec(arg[0], arg) < 0) {
      printf(2, "Error: Exec failed to execute.\n");
      exit();
    }
  }
  else if (forkRet == -1)
    printf(2, "Error: Fork failed.\n");
  else
    wait();
}

//Forks 
void forkMultipleChildren(int amountToFork)
{
  int i, j;
  uint pids[amountToFork]; //Holds the pids that fork returns
  char **arg2 = malloc(sizeof(char *));

  for (i = 0; i < amountToFork; ++i)
  {
    pids[i] = fork();    
    if (pids[i] < 0) {
      printf(2, "Error: Fork failed");
      exit();
    } else if (pids[i] == 0) {
        
        
      //Do stuff here? Execute ps? I don't know
      exit();
    }
  }

  //Call ps here maybe?
  arg2[0] = malloc(sizeof(char) * 9);
  strcpy(arg2[0], "forktest");
  runWithArg(arg2);

  //Wait for the children to finish up
  for (j = (amountToFork - 1); j >= 0; --j)
    wait();

  free(arg2[0]);
  free(arg2);
}

//Tests ps with a given amount of
//processes passed in as an argument
void test1(int amountOfProcs)
{

  char **arg1 = malloc(sizeof(char *));
  char **arg2 = malloc(sizeof(char *));

  arg1[0] = malloc(sizeof(char) * 5);
  strcpy(arg1[0], "time");

  arg2[0] = malloc(sizeof(char) * 3);
  strcpy(arg2[0], "ps");


  //runWithArg(arg1);

  // int i;
  // for (i = 0; i < amountOfProcs; ++i)  
  //   runWithArg(arg1);

 runWithArg(arg2);    

  free(arg1[0]);
  free(arg1);

  free(arg2[0]);
  free(arg2);
  
}

int main()
{
  //test1(10);
  forkMultipleChildren(20);
  exit();
}

#endif
