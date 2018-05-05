#ifdef CS333_P3P4

#include "types.h"
#include "user.h"
#include "uproc.h"


enum tests { FREE_TEST, SLEEP_TEST, KILL_TEST, EXIT_TEST, WAIT_TEST, ROUNDROBIN_TEST};
const int SLEEP_TIME = 3000; 

//Set the test that you want to run
enum tests testToRun = SLEEP_TEST;

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

//This function creates a process and then calls exit on the
//child process to show that it correctly transitions the
//process into the zombie list. This code also used Jordan
//Green's shared code to help guide me while writing. 
static void
testExit() {
  int rc = fork();
  if (rc == 0) {
    printf(1, "Run control-z and control-p to show state before calling exit()\n");
    sleep(SLEEP_TIME);        
    printf(1, "Run control-z and control-p to show state after calling exit() in parent\n");
    exit();
  } else {  
    sleep(SLEEP_TIME * 2);  //Needs a little extra time, otherwise it's too fast to catch
    printf(1, "Run contorl-z and contorl-p to show state after reaping child zombie.\n");
    wait();    
    sleep(SLEEP_TIME * 2);  
  }
}

//This function forks a process and calls wait on the child. This allows
//the user to display the current state of the free state list to show
//that the process has correctly moved into the free list. 
static void
testWait() { 
  int rc = fork();
  if (rc == 0) {
    printf(1, "Run control-f and control-p to show the initial state after forking process\n");
    sleep(SLEEP_TIME);
    exit();
  } else {
    wait();
    printf(1, "Run control-f and control-p to show state after running wait()\n");
    sleep(SLEEP_TIME);
  }
}

//Runs an amount of processes based off of amtOfProcs passed in
//This function is based off of Jordan Green's round robin function,
//but slightly altered to take a specific amount of processes to generate. 
static void
testRoundRobin(int amtOfProcs) { 

  int processes[amtOfProcs];  
  int count = 0;
  int rc = 0;
  
  memset(&processes, 0, sizeof(processes)); //Allocate memory

  printf(1, "Begin to run control-r multiple times:\n");
  while (((processes[count++] = rc = fork()) > 0) && count < amtOfProcs); 
  
  if (rc == 0) {
    while(1);
  } else {
    sleep(SLEEP_TIME);
    printf(1, "Cleaning up children..\n");
    count = 0;
    while (processes[count] > 0) {
      kill(processes[count++]);
      wait();
    }
  }
}

int
main(int argc, char * argv[]) {

  //To run a specific test set the value of testToRun (defined above)
  //to the test wished to execute. 
    
  switch(testToRun) {
  case FREE_TEST:
    printf(1, "=> Running FREE Test\n");
    testFreeListAlloc();
    break;
  case SLEEP_TEST:
    printf(1, "=> Running SLEEP Test\n");
    testSleepList();
    break;
  case KILL_TEST:
    printf(1, "=> Running KILL Test\n");
    testKill();
  case EXIT_TEST:
    printf(1, "=> Running EXIT Test\n");
    testExit();
  case WAIT_TEST:
    printf(1, "=> Running WAIT Test\n");
    testWait();
  case ROUNDROBIN_TEST:
    printf(1, "=> Running ROUND ROBIN Test\n");    
    testRoundRobin(20);
  default:
    break;
  }
  
  exit();
}


#endif
