
_testuidgid:     file format elf32-i386


Disassembly of section .text:

00000000 <uidTest>:
#include "types.h"
#include "user.h"

static void
uidTest(uint nval)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  uint uid = getuid();
   6:	e8 79 07 00 00       	call   784 <getuid>
   b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1, "Current UID is: %d\n", uid);
   e:	83 ec 04             	sub    $0x4,%esp
  11:	ff 75 f4             	pushl  -0xc(%ebp)
  14:	68 44 0c 00 00       	push   $0xc44
  19:	6a 01                	push   $0x1
  1b:	e8 6b 08 00 00       	call   88b <printf>
  20:	83 c4 10             	add    $0x10,%esp
  printf(1, "Setting UID to %d\n", nval);
  23:	83 ec 04             	sub    $0x4,%esp
  26:	ff 75 08             	pushl  0x8(%ebp)
  29:	68 58 0c 00 00       	push   $0xc58
  2e:	6a 01                	push   $0x1
  30:	e8 56 08 00 00       	call   88b <printf>
  35:	83 c4 10             	add    $0x10,%esp
  if (setuid(nval) < 0)
  38:	83 ec 0c             	sub    $0xc,%esp
  3b:	ff 75 08             	pushl  0x8(%ebp)
  3e:	e8 59 07 00 00       	call   79c <setuid>
  43:	83 c4 10             	add    $0x10,%esp
  46:	85 c0                	test   %eax,%eax
  48:	79 15                	jns    5f <uidTest+0x5f>
    printf(2, "Error. Invalid UID: %d\n", nval);
  4a:	83 ec 04             	sub    $0x4,%esp
  4d:	ff 75 08             	pushl  0x8(%ebp)
  50:	68 6b 0c 00 00       	push   $0xc6b
  55:	6a 02                	push   $0x2
  57:	e8 2f 08 00 00       	call   88b <printf>
  5c:	83 c4 10             	add    $0x10,%esp
  uid = getuid();
  5f:	e8 20 07 00 00       	call   784 <getuid>
  64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1, "Current UID is: %d\n", uid);
  67:	83 ec 04             	sub    $0x4,%esp
  6a:	ff 75 f4             	pushl  -0xc(%ebp)
  6d:	68 44 0c 00 00       	push   $0xc44
  72:	6a 01                	push   $0x1
  74:	e8 12 08 00 00       	call   88b <printf>
  79:	83 c4 10             	add    $0x10,%esp
  sleep(5 * TPS);  // now type control-p
  7c:	83 ec 0c             	sub    $0xc,%esp
  7f:	68 88 13 00 00       	push   $0x1388
  84:	e8 db 06 00 00       	call   764 <sleep>
  89:	83 c4 10             	add    $0x10,%esp
}
  8c:	90                   	nop
  8d:	c9                   	leave  
  8e:	c3                   	ret    

0000008f <gidTest>:

static void
gidTest(uint nval)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	83 ec 18             	sub    $0x18,%esp
  uint gid = getgid();
  95:	e8 f2 06 00 00       	call   78c <getgid>
  9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1, "Current GID is: %d\n", gid);
  9d:	83 ec 04             	sub    $0x4,%esp
  a0:	ff 75 f4             	pushl  -0xc(%ebp)
  a3:	68 83 0c 00 00       	push   $0xc83
  a8:	6a 01                	push   $0x1
  aa:	e8 dc 07 00 00       	call   88b <printf>
  af:	83 c4 10             	add    $0x10,%esp
  printf(1, "Setting GID to %d\n", nval);
  b2:	83 ec 04             	sub    $0x4,%esp
  b5:	ff 75 08             	pushl  0x8(%ebp)
  b8:	68 97 0c 00 00       	push   $0xc97
  bd:	6a 01                	push   $0x1
  bf:	e8 c7 07 00 00       	call   88b <printf>
  c4:	83 c4 10             	add    $0x10,%esp
  if (setgid(nval) < 0)
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	ff 75 08             	pushl  0x8(%ebp)
  cd:	e8 d2 06 00 00       	call   7a4 <setgid>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	79 15                	jns    ee <gidTest+0x5f>
    printf(2, "Error. Invalid GID: %d\n", nval);
  d9:	83 ec 04             	sub    $0x4,%esp
  dc:	ff 75 08             	pushl  0x8(%ebp)
  df:	68 aa 0c 00 00       	push   $0xcaa
  e4:	6a 02                	push   $0x2
  e6:	e8 a0 07 00 00       	call   88b <printf>
  eb:	83 c4 10             	add    $0x10,%esp
  setgid(nval);
  ee:	83 ec 0c             	sub    $0xc,%esp
  f1:	ff 75 08             	pushl  0x8(%ebp)
  f4:	e8 ab 06 00 00       	call   7a4 <setgid>
  f9:	83 c4 10             	add    $0x10,%esp
  gid = getgid();
  fc:	e8 8b 06 00 00       	call   78c <getgid>
 101:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1, "Current GID is: %d\n", gid);
 104:	83 ec 04             	sub    $0x4,%esp
 107:	ff 75 f4             	pushl  -0xc(%ebp)
 10a:	68 83 0c 00 00       	push   $0xc83
 10f:	6a 01                	push   $0x1
 111:	e8 75 07 00 00       	call   88b <printf>
 116:	83 c4 10             	add    $0x10,%esp
  sleep(5 * TPS);  // now type control-p
 119:	83 ec 0c             	sub    $0xc,%esp
 11c:	68 88 13 00 00       	push   $0x1388
 121:	e8 3e 06 00 00       	call   764 <sleep>
 126:	83 c4 10             	add    $0x10,%esp
}
 129:	90                   	nop
 12a:	c9                   	leave  
 12b:	c3                   	ret    

0000012c <forkTest>:

static void
forkTest(uint nval)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	53                   	push   %ebx
 130:	83 ec 14             	sub    $0x14,%esp
  uint uid, gid;
  int pid;

  printf(1, "Setting UID to %d and GID to %d before fork(). Value"
 133:	ff 75 08             	pushl  0x8(%ebp)
 136:	ff 75 08             	pushl  0x8(%ebp)
 139:	68 c4 0c 00 00       	push   $0xcc4
 13e:	6a 01                	push   $0x1
 140:	e8 46 07 00 00       	call   88b <printf>
 145:	83 c4 10             	add    $0x10,%esp
         " should be inherited\n", nval, nval);

  if (setuid(nval) < 0)
 148:	83 ec 0c             	sub    $0xc,%esp
 14b:	ff 75 08             	pushl  0x8(%ebp)
 14e:	e8 49 06 00 00       	call   79c <setuid>
 153:	83 c4 10             	add    $0x10,%esp
 156:	85 c0                	test   %eax,%eax
 158:	79 15                	jns    16f <forkTest+0x43>
    printf(2, "Error. Invalid UID: %d\n", nval);
 15a:	83 ec 04             	sub    $0x4,%esp
 15d:	ff 75 08             	pushl  0x8(%ebp)
 160:	68 6b 0c 00 00       	push   $0xc6b
 165:	6a 02                	push   $0x2
 167:	e8 1f 07 00 00       	call   88b <printf>
 16c:	83 c4 10             	add    $0x10,%esp
  if (setgid(nval) < 0)
 16f:	83 ec 0c             	sub    $0xc,%esp
 172:	ff 75 08             	pushl  0x8(%ebp)
 175:	e8 2a 06 00 00       	call   7a4 <setgid>
 17a:	83 c4 10             	add    $0x10,%esp
 17d:	85 c0                	test   %eax,%eax
 17f:	79 15                	jns    196 <forkTest+0x6a>
    printf(2, "Error. Invalid UID: %d\n", nval);
 181:	83 ec 04             	sub    $0x4,%esp
 184:	ff 75 08             	pushl  0x8(%ebp)
 187:	68 6b 0c 00 00       	push   $0xc6b
 18c:	6a 02                	push   $0x2
 18e:	e8 f8 06 00 00       	call   88b <printf>
 193:	83 c4 10             	add    $0x10,%esp

  printf(1, "Before fork(), UID = %d, GID = %d\n", getuid(), getgid());
 196:	e8 f1 05 00 00       	call   78c <getgid>
 19b:	89 c3                	mov    %eax,%ebx
 19d:	e8 e2 05 00 00       	call   784 <getuid>
 1a2:	53                   	push   %ebx
 1a3:	50                   	push   %eax
 1a4:	68 10 0d 00 00       	push   $0xd10
 1a9:	6a 01                	push   $0x1
 1ab:	e8 db 06 00 00       	call   88b <printf>
 1b0:	83 c4 10             	add    $0x10,%esp
  pid = fork();
 1b3:	e8 14 05 00 00       	call   6cc <fork>
 1b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (pid == 0) {  // child
 1bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1bf:	75 3a                	jne    1fb <forkTest+0xcf>
    uid = getuid();
 1c1:	e8 be 05 00 00       	call   784 <getuid>
 1c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    gid = getgid();
 1c9:	e8 be 05 00 00       	call   78c <getgid>
 1ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    printf(1, "Child: UID is: %d, GID is: %d\n", uid, gid);
 1d1:	ff 75 ec             	pushl  -0x14(%ebp)
 1d4:	ff 75 f0             	pushl  -0x10(%ebp)
 1d7:	68 34 0d 00 00       	push   $0xd34
 1dc:	6a 01                	push   $0x1
 1de:	e8 a8 06 00 00       	call   88b <printf>
 1e3:	83 c4 10             	add    $0x10,%esp
    sleep(5 * TPS);  // now type control-p
 1e6:	83 ec 0c             	sub    $0xc,%esp
 1e9:	68 88 13 00 00       	push   $0x1388
 1ee:	e8 71 05 00 00       	call   764 <sleep>
 1f3:	83 c4 10             	add    $0x10,%esp
    exit();
 1f6:	e8 d9 04 00 00       	call   6d4 <exit>
  }
  else
    sleep(10 * TPS); // wait for child to exit before proceeding
 1fb:	83 ec 0c             	sub    $0xc,%esp
 1fe:	68 10 27 00 00       	push   $0x2710
 203:	e8 5c 05 00 00       	call   764 <sleep>
 208:	83 c4 10             	add    $0x10,%esp

}
 20b:	90                   	nop
 20c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 20f:	c9                   	leave  
 210:	c3                   	ret    

00000211 <invalidTest>:

static void
invalidTest(uint nval)
{
 211:	55                   	push   %ebp
 212:	89 e5                	mov    %esp,%ebp
 214:	83 ec 08             	sub    $0x8,%esp
  printf(1, "Setting UID to %d. This test should FAIL\n", nval);
 217:	83 ec 04             	sub    $0x4,%esp
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	68 54 0d 00 00       	push   $0xd54
 222:	6a 01                	push   $0x1
 224:	e8 62 06 00 00       	call   88b <printf>
 229:	83 c4 10             	add    $0x10,%esp
  if (setuid(nval) < 0)
 22c:	83 ec 0c             	sub    $0xc,%esp
 22f:	ff 75 08             	pushl  0x8(%ebp)
 232:	e8 65 05 00 00       	call   79c <setuid>
 237:	83 c4 10             	add    $0x10,%esp
 23a:	85 c0                	test   %eax,%eax
 23c:	79 14                	jns    252 <invalidTest+0x41>
    printf(1, "SUCCESS! The setuid sytem call indicated failure\n");
 23e:	83 ec 08             	sub    $0x8,%esp
 241:	68 80 0d 00 00       	push   $0xd80
 246:	6a 01                	push   $0x1
 248:	e8 3e 06 00 00       	call   88b <printf>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	eb 12                	jmp    264 <invalidTest+0x53>
  else
    printf(2, "FAILURE! The setuid system call indicates success\n");
 252:	83 ec 08             	sub    $0x8,%esp
 255:	68 b4 0d 00 00       	push   $0xdb4
 25a:	6a 02                	push   $0x2
 25c:	e8 2a 06 00 00       	call   88b <printf>
 261:	83 c4 10             	add    $0x10,%esp

  printf(1, "Setting GID to %d. This test should FAIL\n", nval);
 264:	83 ec 04             	sub    $0x4,%esp
 267:	ff 75 08             	pushl  0x8(%ebp)
 26a:	68 e8 0d 00 00       	push   $0xde8
 26f:	6a 01                	push   $0x1
 271:	e8 15 06 00 00       	call   88b <printf>
 276:	83 c4 10             	add    $0x10,%esp
  if (setgid(nval) < 0)
 279:	83 ec 0c             	sub    $0xc,%esp
 27c:	ff 75 08             	pushl  0x8(%ebp)
 27f:	e8 20 05 00 00       	call   7a4 <setgid>
 284:	83 c4 10             	add    $0x10,%esp
 287:	85 c0                	test   %eax,%eax
 289:	79 14                	jns    29f <invalidTest+0x8e>
    printf(1, "SUCCESS! The setgid sytem call indicated failure\n");
 28b:	83 ec 08             	sub    $0x8,%esp
 28e:	68 14 0e 00 00       	push   $0xe14
 293:	6a 01                	push   $0x1
 295:	e8 f1 05 00 00       	call   88b <printf>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	eb 12                	jmp    2b1 <invalidTest+0xa0>
  else
    printf(2, "FAILURE! The setgid system call indicates success\n");
 29f:	83 ec 08             	sub    $0x8,%esp
 2a2:	68 48 0e 00 00       	push   $0xe48
 2a7:	6a 02                	push   $0x2
 2a9:	e8 dd 05 00 00       	call   88b <printf>
 2ae:	83 c4 10             	add    $0x10,%esp

  printf(1, "Setting UID to %d. This test should FAIL\n", -1);
 2b1:	83 ec 04             	sub    $0x4,%esp
 2b4:	6a ff                	push   $0xffffffff
 2b6:	68 54 0d 00 00       	push   $0xd54
 2bb:	6a 01                	push   $0x1
 2bd:	e8 c9 05 00 00       	call   88b <printf>
 2c2:	83 c4 10             	add    $0x10,%esp
  if (setgid(-1) < 0)
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	6a ff                	push   $0xffffffff
 2ca:	e8 d5 04 00 00       	call   7a4 <setgid>
 2cf:	83 c4 10             	add    $0x10,%esp
 2d2:	85 c0                	test   %eax,%eax
 2d4:	79 14                	jns    2ea <invalidTest+0xd9>
    printf(1, "SUCCESS! The setgid sytem call indicated failure\n");
 2d6:	83 ec 08             	sub    $0x8,%esp
 2d9:	68 14 0e 00 00       	push   $0xe14
 2de:	6a 01                	push   $0x1
 2e0:	e8 a6 05 00 00       	call   88b <printf>
 2e5:	83 c4 10             	add    $0x10,%esp
  else
    printf(2, "FAILURE! The setgid system call indicates success\n");
}
 2e8:	eb 12                	jmp    2fc <invalidTest+0xeb>

  printf(1, "Setting UID to %d. This test should FAIL\n", -1);
  if (setgid(-1) < 0)
    printf(1, "SUCCESS! The setgid sytem call indicated failure\n");
  else
    printf(2, "FAILURE! The setgid system call indicates success\n");
 2ea:	83 ec 08             	sub    $0x8,%esp
 2ed:	68 48 0e 00 00       	push   $0xe48
 2f2:	6a 02                	push   $0x2
 2f4:	e8 92 05 00 00       	call   88b <printf>
 2f9:	83 c4 10             	add    $0x10,%esp
}
 2fc:	90                   	nop
 2fd:	c9                   	leave  
 2fe:	c3                   	ret    

000002ff <testuidgid>:

static int
testuidgid(void)
{
 2ff:	55                   	push   %ebp
 300:	89 e5                	mov    %esp,%ebp
 302:	83 ec 18             	sub    $0x18,%esp
  uint nval, ppid;

  // get/set uid test
  nval = 100;
 305:	c7 45 f4 64 00 00 00 	movl   $0x64,-0xc(%ebp)
  uidTest(nval);
 30c:	83 ec 0c             	sub    $0xc,%esp
 30f:	ff 75 f4             	pushl  -0xc(%ebp)
 312:	e8 e9 fc ff ff       	call   0 <uidTest>
 317:	83 c4 10             	add    $0x10,%esp

  // get/set gid test
  nval = 200;
 31a:	c7 45 f4 c8 00 00 00 	movl   $0xc8,-0xc(%ebp)
  gidTest(nval);
 321:	83 ec 0c             	sub    $0xc,%esp
 324:	ff 75 f4             	pushl  -0xc(%ebp)
 327:	e8 63 fd ff ff       	call   8f <gidTest>
 32c:	83 c4 10             	add    $0x10,%esp

  // getppid test
  ppid = getppid();
 32f:	e8 60 04 00 00       	call   794 <getppid>
 334:	89 45 f0             	mov    %eax,-0x10(%ebp)
  printf(1, "My parent process is: %d\n", ppid);
 337:	83 ec 04             	sub    $0x4,%esp
 33a:	ff 75 f0             	pushl  -0x10(%ebp)
 33d:	68 7b 0e 00 00       	push   $0xe7b
 342:	6a 01                	push   $0x1
 344:	e8 42 05 00 00       	call   88b <printf>
 349:	83 c4 10             	add    $0x10,%esp

  // fork tests to demonstrate UID/GID inheritance
  nval = 111;
 34c:	c7 45 f4 6f 00 00 00 	movl   $0x6f,-0xc(%ebp)
  forkTest(nval);
 353:	83 ec 0c             	sub    $0xc,%esp
 356:	ff 75 f4             	pushl  -0xc(%ebp)
 359:	e8 ce fd ff ff       	call   12c <forkTest>
 35e:	83 c4 10             	add    $0x10,%esp

  // tests for invalid values for uid and gid
  nval = 32800;   // 32767 is max value
 361:	c7 45 f4 20 80 00 00 	movl   $0x8020,-0xc(%ebp)
  invalidTest(nval);
 368:	83 ec 0c             	sub    $0xc,%esp
 36b:	ff 75 f4             	pushl  -0xc(%ebp)
 36e:	e8 9e fe ff ff       	call   211 <invalidTest>
 373:	83 c4 10             	add    $0x10,%esp

  printf(1, "Done!\n");
 376:	83 ec 08             	sub    $0x8,%esp
 379:	68 95 0e 00 00       	push   $0xe95
 37e:	6a 01                	push   $0x1
 380:	e8 06 05 00 00       	call   88b <printf>
 385:	83 c4 10             	add    $0x10,%esp
  return 0;
 388:	b8 00 00 00 00       	mov    $0x0,%eax
}
 38d:	c9                   	leave  
 38e:	c3                   	ret    

0000038f <main>:

int
main() {
 38f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 393:	83 e4 f0             	and    $0xfffffff0,%esp
 396:	ff 71 fc             	pushl  -0x4(%ecx)
 399:	55                   	push   %ebp
 39a:	89 e5                	mov    %esp,%ebp
 39c:	51                   	push   %ecx
 39d:	83 ec 04             	sub    $0x4,%esp
  testuidgid();
 3a0:	e8 5a ff ff ff       	call   2ff <testuidgid>
  exit();
 3a5:	e8 2a 03 00 00       	call   6d4 <exit>

000003aa <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3aa:	55                   	push   %ebp
 3ab:	89 e5                	mov    %esp,%ebp
 3ad:	57                   	push   %edi
 3ae:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 3af:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3b2:	8b 55 10             	mov    0x10(%ebp),%edx
 3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b8:	89 cb                	mov    %ecx,%ebx
 3ba:	89 df                	mov    %ebx,%edi
 3bc:	89 d1                	mov    %edx,%ecx
 3be:	fc                   	cld    
 3bf:	f3 aa                	rep stos %al,%es:(%edi)
 3c1:	89 ca                	mov    %ecx,%edx
 3c3:	89 fb                	mov    %edi,%ebx
 3c5:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3c8:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3cb:	90                   	nop
 3cc:	5b                   	pop    %ebx
 3cd:	5f                   	pop    %edi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 3dc:	90                   	nop
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	8d 50 01             	lea    0x1(%eax),%edx
 3e3:	89 55 08             	mov    %edx,0x8(%ebp)
 3e6:	8b 55 0c             	mov    0xc(%ebp),%edx
 3e9:	8d 4a 01             	lea    0x1(%edx),%ecx
 3ec:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 3ef:	0f b6 12             	movzbl (%edx),%edx
 3f2:	88 10                	mov    %dl,(%eax)
 3f4:	0f b6 00             	movzbl (%eax),%eax
 3f7:	84 c0                	test   %al,%al
 3f9:	75 e2                	jne    3dd <strcpy+0xd>
    ;
  return os;
 3fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fe:	c9                   	leave  
 3ff:	c3                   	ret    

00000400 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 403:	eb 08                	jmp    40d <strcmp+0xd>
    p++, q++;
 405:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 409:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 40d:	8b 45 08             	mov    0x8(%ebp),%eax
 410:	0f b6 00             	movzbl (%eax),%eax
 413:	84 c0                	test   %al,%al
 415:	74 10                	je     427 <strcmp+0x27>
 417:	8b 45 08             	mov    0x8(%ebp),%eax
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	8b 45 0c             	mov    0xc(%ebp),%eax
 420:	0f b6 00             	movzbl (%eax),%eax
 423:	38 c2                	cmp    %al,%dl
 425:	74 de                	je     405 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	0f b6 00             	movzbl (%eax),%eax
 42d:	0f b6 d0             	movzbl %al,%edx
 430:	8b 45 0c             	mov    0xc(%ebp),%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	0f b6 c0             	movzbl %al,%eax
 439:	29 c2                	sub    %eax,%edx
 43b:	89 d0                	mov    %edx,%eax
}
 43d:	5d                   	pop    %ebp
 43e:	c3                   	ret    

0000043f <strlen>:

uint
strlen(char *s)
{
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 445:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 44c:	eb 04                	jmp    452 <strlen+0x13>
 44e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 452:	8b 55 fc             	mov    -0x4(%ebp),%edx
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	01 d0                	add    %edx,%eax
 45a:	0f b6 00             	movzbl (%eax),%eax
 45d:	84 c0                	test   %al,%al
 45f:	75 ed                	jne    44e <strlen+0xf>
    ;
  return n;
 461:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 464:	c9                   	leave  
 465:	c3                   	ret    

00000466 <memset>:

void*
memset(void *dst, int c, uint n)
{
 466:	55                   	push   %ebp
 467:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 469:	8b 45 10             	mov    0x10(%ebp),%eax
 46c:	50                   	push   %eax
 46d:	ff 75 0c             	pushl  0xc(%ebp)
 470:	ff 75 08             	pushl  0x8(%ebp)
 473:	e8 32 ff ff ff       	call   3aa <stosb>
 478:	83 c4 0c             	add    $0xc,%esp
  return dst;
 47b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 47e:	c9                   	leave  
 47f:	c3                   	ret    

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	83 ec 04             	sub    $0x4,%esp
 486:	8b 45 0c             	mov    0xc(%ebp),%eax
 489:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 48c:	eb 14                	jmp    4a2 <strchr+0x22>
    if(*s == c)
 48e:	8b 45 08             	mov    0x8(%ebp),%eax
 491:	0f b6 00             	movzbl (%eax),%eax
 494:	3a 45 fc             	cmp    -0x4(%ebp),%al
 497:	75 05                	jne    49e <strchr+0x1e>
      return (char*)s;
 499:	8b 45 08             	mov    0x8(%ebp),%eax
 49c:	eb 13                	jmp    4b1 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 49e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4a2:	8b 45 08             	mov    0x8(%ebp),%eax
 4a5:	0f b6 00             	movzbl (%eax),%eax
 4a8:	84 c0                	test   %al,%al
 4aa:	75 e2                	jne    48e <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 4ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
 4b1:	c9                   	leave  
 4b2:	c3                   	ret    

000004b3 <gets>:

char*
gets(char *buf, int max)
{
 4b3:	55                   	push   %ebp
 4b4:	89 e5                	mov    %esp,%ebp
 4b6:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 4c0:	eb 42                	jmp    504 <gets+0x51>
    cc = read(0, &c, 1);
 4c2:	83 ec 04             	sub    $0x4,%esp
 4c5:	6a 01                	push   $0x1
 4c7:	8d 45 ef             	lea    -0x11(%ebp),%eax
 4ca:	50                   	push   %eax
 4cb:	6a 00                	push   $0x0
 4cd:	e8 1a 02 00 00       	call   6ec <read>
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 4d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4dc:	7e 33                	jle    511 <gets+0x5e>
      break;
    buf[i++] = c;
 4de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e1:	8d 50 01             	lea    0x1(%eax),%edx
 4e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4e7:	89 c2                	mov    %eax,%edx
 4e9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ec:	01 c2                	add    %eax,%edx
 4ee:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4f2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 4f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4f8:	3c 0a                	cmp    $0xa,%al
 4fa:	74 16                	je     512 <gets+0x5f>
 4fc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 500:	3c 0d                	cmp    $0xd,%al
 502:	74 0e                	je     512 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 504:	8b 45 f4             	mov    -0xc(%ebp),%eax
 507:	83 c0 01             	add    $0x1,%eax
 50a:	3b 45 0c             	cmp    0xc(%ebp),%eax
 50d:	7c b3                	jl     4c2 <gets+0xf>
 50f:	eb 01                	jmp    512 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 511:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 512:	8b 55 f4             	mov    -0xc(%ebp),%edx
 515:	8b 45 08             	mov    0x8(%ebp),%eax
 518:	01 d0                	add    %edx,%eax
 51a:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 520:	c9                   	leave  
 521:	c3                   	ret    

00000522 <stat>:

int
stat(char *n, struct stat *st)
{
 522:	55                   	push   %ebp
 523:	89 e5                	mov    %esp,%ebp
 525:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 528:	83 ec 08             	sub    $0x8,%esp
 52b:	6a 00                	push   $0x0
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 df 01 00 00       	call   714 <open>
 535:	83 c4 10             	add    $0x10,%esp
 538:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 53b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53f:	79 07                	jns    548 <stat+0x26>
    return -1;
 541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 546:	eb 25                	jmp    56d <stat+0x4b>
  r = fstat(fd, st);
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	ff 75 0c             	pushl  0xc(%ebp)
 54e:	ff 75 f4             	pushl  -0xc(%ebp)
 551:	e8 d6 01 00 00       	call   72c <fstat>
 556:	83 c4 10             	add    $0x10,%esp
 559:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 55c:	83 ec 0c             	sub    $0xc,%esp
 55f:	ff 75 f4             	pushl  -0xc(%ebp)
 562:	e8 95 01 00 00       	call   6fc <close>
 567:	83 c4 10             	add    $0x10,%esp
  return r;
 56a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 56d:	c9                   	leave  
 56e:	c3                   	ret    

0000056f <atoi>:

int
atoi(const char *s)
{
 56f:	55                   	push   %ebp
 570:	89 e5                	mov    %esp,%ebp
 572:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 575:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 57c:	eb 04                	jmp    582 <atoi+0x13>
 57e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 582:	8b 45 08             	mov    0x8(%ebp),%eax
 585:	0f b6 00             	movzbl (%eax),%eax
 588:	3c 20                	cmp    $0x20,%al
 58a:	74 f2                	je     57e <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	3c 2d                	cmp    $0x2d,%al
 594:	75 07                	jne    59d <atoi+0x2e>
 596:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 59b:	eb 05                	jmp    5a2 <atoi+0x33>
 59d:	b8 01 00 00 00       	mov    $0x1,%eax
 5a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	0f b6 00             	movzbl (%eax),%eax
 5ab:	3c 2b                	cmp    $0x2b,%al
 5ad:	74 0a                	je     5b9 <atoi+0x4a>
 5af:	8b 45 08             	mov    0x8(%ebp),%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	3c 2d                	cmp    $0x2d,%al
 5b7:	75 2b                	jne    5e4 <atoi+0x75>
    s++;
 5b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 5bd:	eb 25                	jmp    5e4 <atoi+0x75>
    n = n*10 + *s++ - '0';
 5bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
 5c2:	89 d0                	mov    %edx,%eax
 5c4:	c1 e0 02             	shl    $0x2,%eax
 5c7:	01 d0                	add    %edx,%eax
 5c9:	01 c0                	add    %eax,%eax
 5cb:	89 c1                	mov    %eax,%ecx
 5cd:	8b 45 08             	mov    0x8(%ebp),%eax
 5d0:	8d 50 01             	lea    0x1(%eax),%edx
 5d3:	89 55 08             	mov    %edx,0x8(%ebp)
 5d6:	0f b6 00             	movzbl (%eax),%eax
 5d9:	0f be c0             	movsbl %al,%eax
 5dc:	01 c8                	add    %ecx,%eax
 5de:	83 e8 30             	sub    $0x30,%eax
 5e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 5e4:	8b 45 08             	mov    0x8(%ebp),%eax
 5e7:	0f b6 00             	movzbl (%eax),%eax
 5ea:	3c 2f                	cmp    $0x2f,%al
 5ec:	7e 0a                	jle    5f8 <atoi+0x89>
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	0f b6 00             	movzbl (%eax),%eax
 5f4:	3c 39                	cmp    $0x39,%al
 5f6:	7e c7                	jle    5bf <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 5f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fb:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 5ff:	c9                   	leave  
 600:	c3                   	ret    

00000601 <atoo>:

int
atoo(const char *s)
{
 601:	55                   	push   %ebp
 602:	89 e5                	mov    %esp,%ebp
 604:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 607:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 60e:	eb 04                	jmp    614 <atoo+0x13>
 610:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	0f b6 00             	movzbl (%eax),%eax
 61a:	3c 20                	cmp    $0x20,%al
 61c:	74 f2                	je     610 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 61e:	8b 45 08             	mov    0x8(%ebp),%eax
 621:	0f b6 00             	movzbl (%eax),%eax
 624:	3c 2d                	cmp    $0x2d,%al
 626:	75 07                	jne    62f <atoo+0x2e>
 628:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 62d:	eb 05                	jmp    634 <atoo+0x33>
 62f:	b8 01 00 00 00       	mov    $0x1,%eax
 634:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 637:	8b 45 08             	mov    0x8(%ebp),%eax
 63a:	0f b6 00             	movzbl (%eax),%eax
 63d:	3c 2b                	cmp    $0x2b,%al
 63f:	74 0a                	je     64b <atoo+0x4a>
 641:	8b 45 08             	mov    0x8(%ebp),%eax
 644:	0f b6 00             	movzbl (%eax),%eax
 647:	3c 2d                	cmp    $0x2d,%al
 649:	75 27                	jne    672 <atoo+0x71>
    s++;
 64b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 64f:	eb 21                	jmp    672 <atoo+0x71>
    n = n*8 + *s++ - '0';
 651:	8b 45 fc             	mov    -0x4(%ebp),%eax
 654:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 65b:	8b 45 08             	mov    0x8(%ebp),%eax
 65e:	8d 50 01             	lea    0x1(%eax),%edx
 661:	89 55 08             	mov    %edx,0x8(%ebp)
 664:	0f b6 00             	movzbl (%eax),%eax
 667:	0f be c0             	movsbl %al,%eax
 66a:	01 c8                	add    %ecx,%eax
 66c:	83 e8 30             	sub    $0x30,%eax
 66f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	0f b6 00             	movzbl (%eax),%eax
 678:	3c 2f                	cmp    $0x2f,%al
 67a:	7e 0a                	jle    686 <atoo+0x85>
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	0f b6 00             	movzbl (%eax),%eax
 682:	3c 37                	cmp    $0x37,%al
 684:	7e cb                	jle    651 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 686:	8b 45 f8             	mov    -0x8(%ebp),%eax
 689:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 68d:	c9                   	leave  
 68e:	c3                   	ret    

0000068f <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 68f:	55                   	push   %ebp
 690:	89 e5                	mov    %esp,%ebp
 692:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 695:	8b 45 08             	mov    0x8(%ebp),%eax
 698:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 69b:	8b 45 0c             	mov    0xc(%ebp),%eax
 69e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 6a1:	eb 17                	jmp    6ba <memmove+0x2b>
    *dst++ = *src++;
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	8d 50 01             	lea    0x1(%eax),%edx
 6a9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6af:	8d 4a 01             	lea    0x1(%edx),%ecx
 6b2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 6b5:	0f b6 12             	movzbl (%edx),%edx
 6b8:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ba:	8b 45 10             	mov    0x10(%ebp),%eax
 6bd:	8d 50 ff             	lea    -0x1(%eax),%edx
 6c0:	89 55 10             	mov    %edx,0x10(%ebp)
 6c3:	85 c0                	test   %eax,%eax
 6c5:	7f dc                	jg     6a3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 6c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 6ca:	c9                   	leave  
 6cb:	c3                   	ret    

000006cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6cc:	b8 01 00 00 00       	mov    $0x1,%eax
 6d1:	cd 40                	int    $0x40
 6d3:	c3                   	ret    

000006d4 <exit>:
SYSCALL(exit)
 6d4:	b8 02 00 00 00       	mov    $0x2,%eax
 6d9:	cd 40                	int    $0x40
 6db:	c3                   	ret    

000006dc <wait>:
SYSCALL(wait)
 6dc:	b8 03 00 00 00       	mov    $0x3,%eax
 6e1:	cd 40                	int    $0x40
 6e3:	c3                   	ret    

000006e4 <pipe>:
SYSCALL(pipe)
 6e4:	b8 04 00 00 00       	mov    $0x4,%eax
 6e9:	cd 40                	int    $0x40
 6eb:	c3                   	ret    

000006ec <read>:
SYSCALL(read)
 6ec:	b8 05 00 00 00       	mov    $0x5,%eax
 6f1:	cd 40                	int    $0x40
 6f3:	c3                   	ret    

000006f4 <write>:
SYSCALL(write)
 6f4:	b8 10 00 00 00       	mov    $0x10,%eax
 6f9:	cd 40                	int    $0x40
 6fb:	c3                   	ret    

000006fc <close>:
SYSCALL(close)
 6fc:	b8 15 00 00 00       	mov    $0x15,%eax
 701:	cd 40                	int    $0x40
 703:	c3                   	ret    

00000704 <kill>:
SYSCALL(kill)
 704:	b8 06 00 00 00       	mov    $0x6,%eax
 709:	cd 40                	int    $0x40
 70b:	c3                   	ret    

0000070c <exec>:
SYSCALL(exec)
 70c:	b8 07 00 00 00       	mov    $0x7,%eax
 711:	cd 40                	int    $0x40
 713:	c3                   	ret    

00000714 <open>:
SYSCALL(open)
 714:	b8 0f 00 00 00       	mov    $0xf,%eax
 719:	cd 40                	int    $0x40
 71b:	c3                   	ret    

0000071c <mknod>:
SYSCALL(mknod)
 71c:	b8 11 00 00 00       	mov    $0x11,%eax
 721:	cd 40                	int    $0x40
 723:	c3                   	ret    

00000724 <unlink>:
SYSCALL(unlink)
 724:	b8 12 00 00 00       	mov    $0x12,%eax
 729:	cd 40                	int    $0x40
 72b:	c3                   	ret    

0000072c <fstat>:
SYSCALL(fstat)
 72c:	b8 08 00 00 00       	mov    $0x8,%eax
 731:	cd 40                	int    $0x40
 733:	c3                   	ret    

00000734 <link>:
SYSCALL(link)
 734:	b8 13 00 00 00       	mov    $0x13,%eax
 739:	cd 40                	int    $0x40
 73b:	c3                   	ret    

0000073c <mkdir>:
SYSCALL(mkdir)
 73c:	b8 14 00 00 00       	mov    $0x14,%eax
 741:	cd 40                	int    $0x40
 743:	c3                   	ret    

00000744 <chdir>:
SYSCALL(chdir)
 744:	b8 09 00 00 00       	mov    $0x9,%eax
 749:	cd 40                	int    $0x40
 74b:	c3                   	ret    

0000074c <dup>:
SYSCALL(dup)
 74c:	b8 0a 00 00 00       	mov    $0xa,%eax
 751:	cd 40                	int    $0x40
 753:	c3                   	ret    

00000754 <getpid>:
SYSCALL(getpid)
 754:	b8 0b 00 00 00       	mov    $0xb,%eax
 759:	cd 40                	int    $0x40
 75b:	c3                   	ret    

0000075c <sbrk>:
SYSCALL(sbrk)
 75c:	b8 0c 00 00 00       	mov    $0xc,%eax
 761:	cd 40                	int    $0x40
 763:	c3                   	ret    

00000764 <sleep>:
SYSCALL(sleep)
 764:	b8 0d 00 00 00       	mov    $0xd,%eax
 769:	cd 40                	int    $0x40
 76b:	c3                   	ret    

0000076c <uptime>:
SYSCALL(uptime)
 76c:	b8 0e 00 00 00       	mov    $0xe,%eax
 771:	cd 40                	int    $0x40
 773:	c3                   	ret    

00000774 <halt>:
SYSCALL(halt)
 774:	b8 16 00 00 00       	mov    $0x16,%eax
 779:	cd 40                	int    $0x40
 77b:	c3                   	ret    

0000077c <date>:
SYSCALL(date)
 77c:	b8 17 00 00 00       	mov    $0x17,%eax
 781:	cd 40                	int    $0x40
 783:	c3                   	ret    

00000784 <getuid>:
SYSCALL(getuid) 
 784:	b8 18 00 00 00       	mov    $0x18,%eax
 789:	cd 40                	int    $0x40
 78b:	c3                   	ret    

0000078c <getgid>:
SYSCALL(getgid)
 78c:	b8 19 00 00 00       	mov    $0x19,%eax
 791:	cd 40                	int    $0x40
 793:	c3                   	ret    

00000794 <getppid>:
SYSCALL(getppid)
 794:	b8 1a 00 00 00       	mov    $0x1a,%eax
 799:	cd 40                	int    $0x40
 79b:	c3                   	ret    

0000079c <setuid>:
SYSCALL(setuid)
 79c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 7a1:	cd 40                	int    $0x40
 7a3:	c3                   	ret    

000007a4 <setgid>:
SYSCALL(setgid)
 7a4:	b8 1c 00 00 00       	mov    $0x1c,%eax
 7a9:	cd 40                	int    $0x40
 7ab:	c3                   	ret    

000007ac <getprocs>:
SYSCALL(getprocs)
 7ac:	b8 1d 00 00 00       	mov    $0x1d,%eax
 7b1:	cd 40                	int    $0x40
 7b3:	c3                   	ret    

000007b4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7b4:	55                   	push   %ebp
 7b5:	89 e5                	mov    %esp,%ebp
 7b7:	83 ec 18             	sub    $0x18,%esp
 7ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 7bd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	6a 01                	push   $0x1
 7c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
 7c8:	50                   	push   %eax
 7c9:	ff 75 08             	pushl  0x8(%ebp)
 7cc:	e8 23 ff ff ff       	call   6f4 <write>
 7d1:	83 c4 10             	add    $0x10,%esp
}
 7d4:	90                   	nop
 7d5:	c9                   	leave  
 7d6:	c3                   	ret    

000007d7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7d7:	55                   	push   %ebp
 7d8:	89 e5                	mov    %esp,%ebp
 7da:	53                   	push   %ebx
 7db:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7de:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 7e5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 7e9:	74 17                	je     802 <printint+0x2b>
 7eb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 7ef:	79 11                	jns    802 <printint+0x2b>
    neg = 1;
 7f1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 7f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 7fb:	f7 d8                	neg    %eax
 7fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 800:	eb 06                	jmp    808 <printint+0x31>
  } else {
    x = xx;
 802:	8b 45 0c             	mov    0xc(%ebp),%eax
 805:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 80f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 812:	8d 41 01             	lea    0x1(%ecx),%eax
 815:	89 45 f4             	mov    %eax,-0xc(%ebp)
 818:	8b 5d 10             	mov    0x10(%ebp),%ebx
 81b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 81e:	ba 00 00 00 00       	mov    $0x0,%edx
 823:	f7 f3                	div    %ebx
 825:	89 d0                	mov    %edx,%eax
 827:	0f b6 80 b0 11 00 00 	movzbl 0x11b0(%eax),%eax
 82e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 832:	8b 5d 10             	mov    0x10(%ebp),%ebx
 835:	8b 45 ec             	mov    -0x14(%ebp),%eax
 838:	ba 00 00 00 00       	mov    $0x0,%edx
 83d:	f7 f3                	div    %ebx
 83f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 842:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 846:	75 c7                	jne    80f <printint+0x38>
  if(neg)
 848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 84c:	74 2d                	je     87b <printint+0xa4>
    buf[i++] = '-';
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	8d 50 01             	lea    0x1(%eax),%edx
 854:	89 55 f4             	mov    %edx,-0xc(%ebp)
 857:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 85c:	eb 1d                	jmp    87b <printint+0xa4>
    putc(fd, buf[i]);
 85e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 861:	8b 45 f4             	mov    -0xc(%ebp),%eax
 864:	01 d0                	add    %edx,%eax
 866:	0f b6 00             	movzbl (%eax),%eax
 869:	0f be c0             	movsbl %al,%eax
 86c:	83 ec 08             	sub    $0x8,%esp
 86f:	50                   	push   %eax
 870:	ff 75 08             	pushl  0x8(%ebp)
 873:	e8 3c ff ff ff       	call   7b4 <putc>
 878:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 87b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 87f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 883:	79 d9                	jns    85e <printint+0x87>
    putc(fd, buf[i]);
}
 885:	90                   	nop
 886:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 889:	c9                   	leave  
 88a:	c3                   	ret    

0000088b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 88b:	55                   	push   %ebp
 88c:	89 e5                	mov    %esp,%ebp
 88e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 891:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 898:	8d 45 0c             	lea    0xc(%ebp),%eax
 89b:	83 c0 04             	add    $0x4,%eax
 89e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 8a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 8a8:	e9 59 01 00 00       	jmp    a06 <printf+0x17b>
    c = fmt[i] & 0xff;
 8ad:	8b 55 0c             	mov    0xc(%ebp),%edx
 8b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b3:	01 d0                	add    %edx,%eax
 8b5:	0f b6 00             	movzbl (%eax),%eax
 8b8:	0f be c0             	movsbl %al,%eax
 8bb:	25 ff 00 00 00       	and    $0xff,%eax
 8c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 8c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 8c7:	75 2c                	jne    8f5 <printf+0x6a>
      if(c == '%'){
 8c9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8cd:	75 0c                	jne    8db <printf+0x50>
        state = '%';
 8cf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 8d6:	e9 27 01 00 00       	jmp    a02 <printf+0x177>
      } else {
        putc(fd, c);
 8db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8de:	0f be c0             	movsbl %al,%eax
 8e1:	83 ec 08             	sub    $0x8,%esp
 8e4:	50                   	push   %eax
 8e5:	ff 75 08             	pushl  0x8(%ebp)
 8e8:	e8 c7 fe ff ff       	call   7b4 <putc>
 8ed:	83 c4 10             	add    $0x10,%esp
 8f0:	e9 0d 01 00 00       	jmp    a02 <printf+0x177>
      }
    } else if(state == '%'){
 8f5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 8f9:	0f 85 03 01 00 00    	jne    a02 <printf+0x177>
      if(c == 'd'){
 8ff:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 903:	75 1e                	jne    923 <printf+0x98>
        printint(fd, *ap, 10, 1);
 905:	8b 45 e8             	mov    -0x18(%ebp),%eax
 908:	8b 00                	mov    (%eax),%eax
 90a:	6a 01                	push   $0x1
 90c:	6a 0a                	push   $0xa
 90e:	50                   	push   %eax
 90f:	ff 75 08             	pushl  0x8(%ebp)
 912:	e8 c0 fe ff ff       	call   7d7 <printint>
 917:	83 c4 10             	add    $0x10,%esp
        ap++;
 91a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 91e:	e9 d8 00 00 00       	jmp    9fb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 923:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 927:	74 06                	je     92f <printf+0xa4>
 929:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 92d:	75 1e                	jne    94d <printf+0xc2>
        printint(fd, *ap, 16, 0);
 92f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 932:	8b 00                	mov    (%eax),%eax
 934:	6a 00                	push   $0x0
 936:	6a 10                	push   $0x10
 938:	50                   	push   %eax
 939:	ff 75 08             	pushl  0x8(%ebp)
 93c:	e8 96 fe ff ff       	call   7d7 <printint>
 941:	83 c4 10             	add    $0x10,%esp
        ap++;
 944:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 948:	e9 ae 00 00 00       	jmp    9fb <printf+0x170>
      } else if(c == 's'){
 94d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 951:	75 43                	jne    996 <printf+0x10b>
        s = (char*)*ap;
 953:	8b 45 e8             	mov    -0x18(%ebp),%eax
 956:	8b 00                	mov    (%eax),%eax
 958:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 95b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 95f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 963:	75 25                	jne    98a <printf+0xff>
          s = "(null)";
 965:	c7 45 f4 9c 0e 00 00 	movl   $0xe9c,-0xc(%ebp)
        while(*s != 0){
 96c:	eb 1c                	jmp    98a <printf+0xff>
          putc(fd, *s);
 96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 971:	0f b6 00             	movzbl (%eax),%eax
 974:	0f be c0             	movsbl %al,%eax
 977:	83 ec 08             	sub    $0x8,%esp
 97a:	50                   	push   %eax
 97b:	ff 75 08             	pushl  0x8(%ebp)
 97e:	e8 31 fe ff ff       	call   7b4 <putc>
 983:	83 c4 10             	add    $0x10,%esp
          s++;
 986:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98d:	0f b6 00             	movzbl (%eax),%eax
 990:	84 c0                	test   %al,%al
 992:	75 da                	jne    96e <printf+0xe3>
 994:	eb 65                	jmp    9fb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 996:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 99a:	75 1d                	jne    9b9 <printf+0x12e>
        putc(fd, *ap);
 99c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 99f:	8b 00                	mov    (%eax),%eax
 9a1:	0f be c0             	movsbl %al,%eax
 9a4:	83 ec 08             	sub    $0x8,%esp
 9a7:	50                   	push   %eax
 9a8:	ff 75 08             	pushl  0x8(%ebp)
 9ab:	e8 04 fe ff ff       	call   7b4 <putc>
 9b0:	83 c4 10             	add    $0x10,%esp
        ap++;
 9b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 9b7:	eb 42                	jmp    9fb <printf+0x170>
      } else if(c == '%'){
 9b9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 9bd:	75 17                	jne    9d6 <printf+0x14b>
        putc(fd, c);
 9bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9c2:	0f be c0             	movsbl %al,%eax
 9c5:	83 ec 08             	sub    $0x8,%esp
 9c8:	50                   	push   %eax
 9c9:	ff 75 08             	pushl  0x8(%ebp)
 9cc:	e8 e3 fd ff ff       	call   7b4 <putc>
 9d1:	83 c4 10             	add    $0x10,%esp
 9d4:	eb 25                	jmp    9fb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9d6:	83 ec 08             	sub    $0x8,%esp
 9d9:	6a 25                	push   $0x25
 9db:	ff 75 08             	pushl  0x8(%ebp)
 9de:	e8 d1 fd ff ff       	call   7b4 <putc>
 9e3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 9e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9e9:	0f be c0             	movsbl %al,%eax
 9ec:	83 ec 08             	sub    $0x8,%esp
 9ef:	50                   	push   %eax
 9f0:	ff 75 08             	pushl  0x8(%ebp)
 9f3:	e8 bc fd ff ff       	call   7b4 <putc>
 9f8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 9fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a02:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a06:	8b 55 0c             	mov    0xc(%ebp),%edx
 a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a0c:	01 d0                	add    %edx,%eax
 a0e:	0f b6 00             	movzbl (%eax),%eax
 a11:	84 c0                	test   %al,%al
 a13:	0f 85 94 fe ff ff    	jne    8ad <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a19:	90                   	nop
 a1a:	c9                   	leave  
 a1b:	c3                   	ret    

00000a1c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a1c:	55                   	push   %ebp
 a1d:	89 e5                	mov    %esp,%ebp
 a1f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a22:	8b 45 08             	mov    0x8(%ebp),%eax
 a25:	83 e8 08             	sub    $0x8,%eax
 a28:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a2b:	a1 cc 11 00 00       	mov    0x11cc,%eax
 a30:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a33:	eb 24                	jmp    a59 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a38:	8b 00                	mov    (%eax),%eax
 a3a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a3d:	77 12                	ja     a51 <free+0x35>
 a3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a42:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a45:	77 24                	ja     a6b <free+0x4f>
 a47:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a4a:	8b 00                	mov    (%eax),%eax
 a4c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a4f:	77 1a                	ja     a6b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a51:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a54:	8b 00                	mov    (%eax),%eax
 a56:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a59:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a5c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a5f:	76 d4                	jbe    a35 <free+0x19>
 a61:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a64:	8b 00                	mov    (%eax),%eax
 a66:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a69:	76 ca                	jbe    a35 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a6e:	8b 40 04             	mov    0x4(%eax),%eax
 a71:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a78:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a7b:	01 c2                	add    %eax,%edx
 a7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a80:	8b 00                	mov    (%eax),%eax
 a82:	39 c2                	cmp    %eax,%edx
 a84:	75 24                	jne    aaa <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 a86:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a89:	8b 50 04             	mov    0x4(%eax),%edx
 a8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a8f:	8b 00                	mov    (%eax),%eax
 a91:	8b 40 04             	mov    0x4(%eax),%eax
 a94:	01 c2                	add    %eax,%edx
 a96:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a99:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a9f:	8b 00                	mov    (%eax),%eax
 aa1:	8b 10                	mov    (%eax),%edx
 aa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 aa6:	89 10                	mov    %edx,(%eax)
 aa8:	eb 0a                	jmp    ab4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 aaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 aad:	8b 10                	mov    (%eax),%edx
 aaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ab2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ab7:	8b 40 04             	mov    0x4(%eax),%eax
 aba:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 ac1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ac4:	01 d0                	add    %edx,%eax
 ac6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 ac9:	75 20                	jne    aeb <free+0xcf>
    p->s.size += bp->s.size;
 acb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ace:	8b 50 04             	mov    0x4(%eax),%edx
 ad1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ad4:	8b 40 04             	mov    0x4(%eax),%eax
 ad7:	01 c2                	add    %eax,%edx
 ad9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 adc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 adf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ae2:	8b 10                	mov    (%eax),%edx
 ae4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ae7:	89 10                	mov    %edx,(%eax)
 ae9:	eb 08                	jmp    af3 <free+0xd7>
  } else
    p->s.ptr = bp;
 aeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 aee:	8b 55 f8             	mov    -0x8(%ebp),%edx
 af1:	89 10                	mov    %edx,(%eax)
  freep = p;
 af3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 af6:	a3 cc 11 00 00       	mov    %eax,0x11cc
}
 afb:	90                   	nop
 afc:	c9                   	leave  
 afd:	c3                   	ret    

00000afe <morecore>:

static Header*
morecore(uint nu)
{
 afe:	55                   	push   %ebp
 aff:	89 e5                	mov    %esp,%ebp
 b01:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 b04:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 b0b:	77 07                	ja     b14 <morecore+0x16>
    nu = 4096;
 b0d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 b14:	8b 45 08             	mov    0x8(%ebp),%eax
 b17:	c1 e0 03             	shl    $0x3,%eax
 b1a:	83 ec 0c             	sub    $0xc,%esp
 b1d:	50                   	push   %eax
 b1e:	e8 39 fc ff ff       	call   75c <sbrk>
 b23:	83 c4 10             	add    $0x10,%esp
 b26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 b29:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 b2d:	75 07                	jne    b36 <morecore+0x38>
    return 0;
 b2f:	b8 00 00 00 00       	mov    $0x0,%eax
 b34:	eb 26                	jmp    b5c <morecore+0x5e>
  hp = (Header*)p;
 b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b3f:	8b 55 08             	mov    0x8(%ebp),%edx
 b42:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 b45:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b48:	83 c0 08             	add    $0x8,%eax
 b4b:	83 ec 0c             	sub    $0xc,%esp
 b4e:	50                   	push   %eax
 b4f:	e8 c8 fe ff ff       	call   a1c <free>
 b54:	83 c4 10             	add    $0x10,%esp
  return freep;
 b57:	a1 cc 11 00 00       	mov    0x11cc,%eax
}
 b5c:	c9                   	leave  
 b5d:	c3                   	ret    

00000b5e <malloc>:

void*
malloc(uint nbytes)
{
 b5e:	55                   	push   %ebp
 b5f:	89 e5                	mov    %esp,%ebp
 b61:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b64:	8b 45 08             	mov    0x8(%ebp),%eax
 b67:	83 c0 07             	add    $0x7,%eax
 b6a:	c1 e8 03             	shr    $0x3,%eax
 b6d:	83 c0 01             	add    $0x1,%eax
 b70:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b73:	a1 cc 11 00 00       	mov    0x11cc,%eax
 b78:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b7b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b7f:	75 23                	jne    ba4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 b81:	c7 45 f0 c4 11 00 00 	movl   $0x11c4,-0x10(%ebp)
 b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b8b:	a3 cc 11 00 00       	mov    %eax,0x11cc
 b90:	a1 cc 11 00 00       	mov    0x11cc,%eax
 b95:	a3 c4 11 00 00       	mov    %eax,0x11c4
    base.s.size = 0;
 b9a:	c7 05 c8 11 00 00 00 	movl   $0x0,0x11c8
 ba1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ba7:	8b 00                	mov    (%eax),%eax
 ba9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 baf:	8b 40 04             	mov    0x4(%eax),%eax
 bb2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 bb5:	72 4d                	jb     c04 <malloc+0xa6>
      if(p->s.size == nunits)
 bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bba:	8b 40 04             	mov    0x4(%eax),%eax
 bbd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 bc0:	75 0c                	jne    bce <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bc5:	8b 10                	mov    (%eax),%edx
 bc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bca:	89 10                	mov    %edx,(%eax)
 bcc:	eb 26                	jmp    bf4 <malloc+0x96>
      else {
        p->s.size -= nunits;
 bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd1:	8b 40 04             	mov    0x4(%eax),%eax
 bd4:	2b 45 ec             	sub    -0x14(%ebp),%eax
 bd7:	89 c2                	mov    %eax,%edx
 bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bdc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 be2:	8b 40 04             	mov    0x4(%eax),%eax
 be5:	c1 e0 03             	shl    $0x3,%eax
 be8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bee:	8b 55 ec             	mov    -0x14(%ebp),%edx
 bf1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 bf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bf7:	a3 cc 11 00 00       	mov    %eax,0x11cc
      return (void*)(p + 1);
 bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bff:	83 c0 08             	add    $0x8,%eax
 c02:	eb 3b                	jmp    c3f <malloc+0xe1>
    }
    if(p == freep)
 c04:	a1 cc 11 00 00       	mov    0x11cc,%eax
 c09:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 c0c:	75 1e                	jne    c2c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 c0e:	83 ec 0c             	sub    $0xc,%esp
 c11:	ff 75 ec             	pushl  -0x14(%ebp)
 c14:	e8 e5 fe ff ff       	call   afe <morecore>
 c19:	83 c4 10             	add    $0x10,%esp
 c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 c1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c23:	75 07                	jne    c2c <malloc+0xce>
        return 0;
 c25:	b8 00 00 00 00       	mov    $0x0,%eax
 c2a:	eb 13                	jmp    c3f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c35:	8b 00                	mov    (%eax),%eax
 c37:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 c3a:	e9 6d ff ff ff       	jmp    bac <malloc+0x4e>
}
 c3f:	c9                   	leave  
 c40:	c3                   	ret    
