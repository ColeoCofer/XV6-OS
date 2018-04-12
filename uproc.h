#ifdef CS333_P2

#define STRMAX 32

struct uproc {
  uint pid;
  uint uid;
  uint gid;
  uint ppid;
  uint elapsed_ticks;    //As a floating point number
  uint CPU_total_ticks;  //As a floating point number
  char state[STRMAX];
  uint size;
  char name[STRMAX];
};

#endif
