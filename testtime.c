#ifdef CS333_P2
#include "types.h"
#include "user.h"
#include "testtime.h"

void test2();

void test1()
{

  printf(1, "time forktest\n");
  char *args1[20] = {"time", "forktest"};
  exec(args1[0], args1);

  printf(1, "time echo abc\n");
  char *args2[20] = {"time", "echo", "abc"};
  exec(args2[0], args2);

  printf(1, "time time echo abc\n");
  char *args3[20] = {"time", "time", "echo", "abc"};
  exec(args3[0], args3);

  printf(1, "time echo abc time\n");
  char *args4[20] = {"time", "ehco", "abc", "time"};
  exec(args4[0], args4);

  printf(1, "time\n");
  char *args5[20] = {"time"};
  exec(args5[0], args5);

}

int main()
{
  test1();

  exit();
}

#endif
