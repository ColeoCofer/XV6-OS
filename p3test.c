#ifdef CS333_P3P4

#include "types.h"
#include "user.h"
#include "uproc.h"


enum tests { FREE_TEST, SLEEP_TEST, KILL_TEST, EXIT_TEST};
const int SLEEP_TIME = 3000; 

//Set the test that you want to run
enum tests testToRun = EXIT_TEST;

//Allows the user to display the free list during both
//alocation and deallocation of a process. 
static void
testFreeListAlloc() { 
  printf(1, "Run control-f to get inital processes\n"); 
  sleep(SLEEP_TIME);
  if (fork() == 0) {
    printf(1, "Process allocated, run control-f\n");
    sleep(SLEEP_TIME);
    exit();
  } else {
    wait();
    printf(1, "Process deallocated, run control-f\n");
    sleep(SLEEP_TIME);
  }
}

//Runs a process for 3 seconds and waits for the user to display the sleep list.
//Then forks and sleeps the program, allowing the user to display the list again,
//and one last time once the process has been deallocated. 
static void
testSleepList() {   


  int currentTime = uptime();
  int timeRunning = currentTime + SLEEP_TIME;


  //Run the process to give the user time to display the sleep list
  printf(1, "Run control-s to get inital processes that are sleeping\n"); 
  while (uptime() < timeRunning);

  printf(1, "Process now sleeping, run control-s\n");
  sleep(SLEEP_TIME);
  
  printf(1, "Process deallocated, run control-s\n");
}

//This test function is based off a function shared from
//Jordan Green (classmate).
//I changed it to my liking, but the logic is similar. 
static void
testKill() {
  printf(1, "Run control-z and control-p to get inital state\n"); 
  sleep(SLEEP_TIME);
  
  int rc = fork();
  if (rc == 0) {
    while(1)
      sleep(1000);
  } else {
    int rc2 = fork(); 
    if (rc2 == 0) {
      printf(1, "Killing child process of pid: %d...\n", rc); 
      kill(rc);
    } else {
      wait();
      printf(1, "Run control-z and control-p to show zombie proccess\n");
      sleep(SLEEP_TIME);
      while(wait() != -1); //Wait for the zombie to be reaped
      printf(1, "Process was reaped by calling wait() (Run control-z and control-p to show the empty list)\n");
      sleep(SLEEP_TIME);
    }
  }
}


static void
testExit() {

  //Probably do simmmilar things as in testKill, except all you have to do is call exit,
  //rather than all the other stuffs. 

  printf(1, "Run contorl-z and contorl-p to get inital state\n");
  sleep(SLEEP_TIME);

  int rc = fork();
  if (rc == 0) {
    printf(1, "Before exit:\n");
    sleep(SLEEP_TIME);
    exit();
    printf(1, "After exit in child:\n");
    sleep(SLEEP_TIME);
  } else {
    printf(1, "Run contorl-z and contorl-p in Parent\n");
    sleep(SLEEP_TIME); 
  }
  
}

int
main(int argc, char * argv[]) {
    
  switch(testToRun) {
  case FREE_TEST:
    testFreeListAlloc();
    break;
  case SLEEP_TEST:
    testSleepList();
    break;
  case KILL_TEST:
    testKill();
  case EXIT_TEST:
    testExit();
  default:
    break;
  }
  
  exit();
}


#endif
