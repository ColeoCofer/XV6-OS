
_p2testsuite:     file format elf32-i386


Disassembly of section .text:

00000000 <testppid>:
#include "uproc.h"
#endif

#ifdef UIDGIDPPID_TEST
static void
testppid(void){
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int ret, pid, ppid;

  printf(1, "\n----------\nRunning PPID Test\n----------\n");
       6:	83 ec 08             	sub    $0x8,%esp
       9:	68 40 11 00 00       	push   $0x1140
       e:	6a 01                	push   $0x1
      10:	e8 73 0d 00 00       	call   d88 <printf>
      15:	83 c4 10             	add    $0x10,%esp
  pid = getpid();
      18:	e8 34 0c 00 00       	call   c51 <getpid>
      1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ret = fork();
      20:	e8 a4 0b 00 00       	call   bc9 <fork>
      25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
      28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      2c:	75 3e                	jne    6c <testppid+0x6c>
    ppid = getppid();
      2e:	e8 5e 0c 00 00       	call   c91 <getppid>
      33:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(ppid != pid)
      36:	8b 45 ec             	mov    -0x14(%ebp),%eax
      39:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      3c:	74 17                	je     55 <testppid+0x55>
      printf(2, "FAILED: Parent PID is %d, Child's PPID is %d\n", pid, ppid);
      3e:	ff 75 ec             	pushl  -0x14(%ebp)
      41:	ff 75 f4             	pushl  -0xc(%ebp)
      44:	68 6c 11 00 00       	push   $0x116c
      49:	6a 02                	push   $0x2
      4b:	e8 38 0d 00 00       	call   d88 <printf>
      50:	83 c4 10             	add    $0x10,%esp
      53:	eb 12                	jmp    67 <testppid+0x67>
    else
      printf(1, "** Test passed! **\n");
      55:	83 ec 08             	sub    $0x8,%esp
      58:	68 9a 11 00 00       	push   $0x119a
      5d:	6a 01                	push   $0x1
      5f:	e8 24 0d 00 00       	call   d88 <printf>
      64:	83 c4 10             	add    $0x10,%esp
    exit();
      67:	e8 65 0b 00 00       	call   bd1 <exit>
  }
  else
    wait();
      6c:	e8 68 0b 00 00       	call   bd9 <wait>
}
      71:	90                   	nop
      72:	c9                   	leave  
      73:	c3                   	ret    

00000074 <testgid>:

static int
testgid(uint new_val, uint expected_get_val, int expected_set_ret){
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_gid, pre_gid;
  int success = 0;
      7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_gid = getgid();
      81:	e8 03 0c 00 00       	call   c89 <getgid>
      86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setgid(new_val);
      89:	83 ec 0c             	sub    $0xc,%esp
      8c:	ff 75 08             	pushl  0x8(%ebp)
      8f:	e8 0d 0c 00 00       	call   ca1 <setgid>
      94:	83 c4 10             	add    $0x10,%esp
      97:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
      9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      9e:	79 06                	jns    a6 <testgid+0x32>
      a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      a4:	79 0c                	jns    b2 <testgid+0x3e>
      a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      aa:	78 28                	js     d4 <testgid+0x60>
      ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
      b0:	79 22                	jns    d4 <testgid+0x60>
    printf(2, "FAILED: setgid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
      b2:	83 ec 0c             	sub    $0xc,%esp
      b5:	ff 75 10             	pushl  0x10(%ebp)
      b8:	ff 75 ec             	pushl  -0x14(%ebp)
      bb:	ff 75 08             	pushl  0x8(%ebp)
      be:	68 b0 11 00 00       	push   $0x11b0
      c3:	6a 02                	push   $0x2
      c5:	e8 be 0c 00 00       	call   d88 <printf>
      ca:	83 c4 20             	add    $0x20,%esp
    success = -1;
      cd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_gid = getgid();
      d4:	e8 b0 0b 00 00       	call   c89 <getgid>
      d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_gid != expected_get_val){
      dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
      df:	3b 45 0c             	cmp    0xc(%ebp),%eax
      e2:	74 25                	je     109 <testgid+0x95>
    printf(2, "FAILED: UID was %d. After setgid(%d), getgid() returned %d, expected %d\n",
      e4:	83 ec 08             	sub    $0x8,%esp
      e7:	ff 75 0c             	pushl  0xc(%ebp)
      ea:	ff 75 e8             	pushl  -0x18(%ebp)
      ed:	ff 75 08             	pushl  0x8(%ebp)
      f0:	ff 75 f0             	pushl  -0x10(%ebp)
      f3:	68 e0 11 00 00       	push   $0x11e0
      f8:	6a 02                	push   $0x2
      fa:	e8 89 0c 00 00       	call   d88 <printf>
      ff:	83 c4 20             	add    $0x20,%esp
           pre_gid, new_val, post_gid, expected_get_val);
    success = -1;
     102:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     109:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     10c:	c9                   	leave  
     10d:	c3                   	ret    

0000010e <testuid>:

static int
testuid(uint new_val, uint expected_get_val, int expected_set_ret){
     10e:	55                   	push   %ebp
     10f:	89 e5                	mov    %esp,%ebp
     111:	83 ec 18             	sub    $0x18,%esp
  int ret;
  uint post_uid, pre_uid;
  int success = 0;
     114:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  pre_uid = getuid();
     11b:	e8 61 0b 00 00       	call   c81 <getuid>
     120:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = setuid(new_val);
     123:	83 ec 0c             	sub    $0xc,%esp
     126:	ff 75 08             	pushl  0x8(%ebp)
     129:	e8 6b 0b 00 00       	call   c99 <setuid>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((ret < 0 && expected_set_ret >= 0) || (ret >= 0 && expected_set_ret < 0)){
     134:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     138:	79 06                	jns    140 <testuid+0x32>
     13a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     13e:	79 0c                	jns    14c <testuid+0x3e>
     140:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     144:	78 28                	js     16e <testuid+0x60>
     146:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     14a:	79 22                	jns    16e <testuid+0x60>
    printf(2, "FAILED: setuid(%d) returned %d, expected %d\n", new_val, ret, expected_set_ret);
     14c:	83 ec 0c             	sub    $0xc,%esp
     14f:	ff 75 10             	pushl  0x10(%ebp)
     152:	ff 75 ec             	pushl  -0x14(%ebp)
     155:	ff 75 08             	pushl  0x8(%ebp)
     158:	68 2c 12 00 00       	push   $0x122c
     15d:	6a 02                	push   $0x2
     15f:	e8 24 0c 00 00       	call   d88 <printf>
     164:	83 c4 20             	add    $0x20,%esp
    success = -1;
     167:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  post_uid = getuid();
     16e:	e8 0e 0b 00 00       	call   c81 <getuid>
     173:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(post_uid != expected_get_val){
     176:	8b 45 e8             	mov    -0x18(%ebp),%eax
     179:	3b 45 0c             	cmp    0xc(%ebp),%eax
     17c:	74 25                	je     1a3 <testuid+0x95>
    printf(2, "FAILED: UID was %d. After setuid(%d), getuid() returned %d, expected %d\n",
     17e:	83 ec 08             	sub    $0x8,%esp
     181:	ff 75 0c             	pushl  0xc(%ebp)
     184:	ff 75 e8             	pushl  -0x18(%ebp)
     187:	ff 75 08             	pushl  0x8(%ebp)
     18a:	ff 75 f0             	pushl  -0x10(%ebp)
     18d:	68 5c 12 00 00       	push   $0x125c
     192:	6a 02                	push   $0x2
     194:	e8 ef 0b 00 00       	call   d88 <printf>
     199:	83 c4 20             	add    $0x20,%esp
           pre_uid, new_val, post_uid, expected_get_val);
    success = -1;
     19c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  return success;
     1a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     1a6:	c9                   	leave  
     1a7:	c3                   	ret    

000001a8 <testuidgid>:

static void
testuidgid(void)
{
     1a8:	55                   	push   %ebp
     1a9:	89 e5                	mov    %esp,%ebp
     1ab:	83 ec 18             	sub    $0x18,%esp
  int uid, gid;
  int success = 0;
     1ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Tests\n----------\n");
     1b5:	83 ec 08             	sub    $0x8,%esp
     1b8:	68 a8 12 00 00       	push   $0x12a8
     1bd:	6a 01                	push   $0x1
     1bf:	e8 c4 0b 00 00       	call   d88 <printf>
     1c4:	83 c4 10             	add    $0x10,%esp
  uid = getuid();
     1c7:	e8 b5 0a 00 00       	call   c81 <getuid>
     1cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(uid < 0 || uid > 32767){
     1cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1d3:	78 09                	js     1de <testuidgid+0x36>
     1d5:	81 7d f0 ff 7f 00 00 	cmpl   $0x7fff,-0x10(%ebp)
     1dc:	7e 1c                	jle    1fa <testuidgid+0x52>
    printf(1, "FAILED: Default UID %d, out of range\n", uid);
     1de:	83 ec 04             	sub    $0x4,%esp
     1e1:	ff 75 f0             	pushl  -0x10(%ebp)
     1e4:	68 d8 12 00 00       	push   $0x12d8
     1e9:	6a 01                	push   $0x1
     1eb:	e8 98 0b 00 00       	call   d88 <printf>
     1f0:	83 c4 10             	add    $0x10,%esp
    success = -1;
     1f3:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testuid(0, 0, 0))
     1fa:	83 ec 04             	sub    $0x4,%esp
     1fd:	6a 00                	push   $0x0
     1ff:	6a 00                	push   $0x0
     201:	6a 00                	push   $0x0
     203:	e8 06 ff ff ff       	call   10e <testuid>
     208:	83 c4 10             	add    $0x10,%esp
     20b:	85 c0                	test   %eax,%eax
     20d:	74 07                	je     216 <testuidgid+0x6e>
    success = -1;
     20f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(5, 5, 0))
     216:	83 ec 04             	sub    $0x4,%esp
     219:	6a 00                	push   $0x0
     21b:	6a 05                	push   $0x5
     21d:	6a 05                	push   $0x5
     21f:	e8 ea fe ff ff       	call   10e <testuid>
     224:	83 c4 10             	add    $0x10,%esp
     227:	85 c0                	test   %eax,%eax
     229:	74 07                	je     232 <testuidgid+0x8a>
    success = -1;
     22b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32767, 32767, 0))
     232:	83 ec 04             	sub    $0x4,%esp
     235:	6a 00                	push   $0x0
     237:	68 ff 7f 00 00       	push   $0x7fff
     23c:	68 ff 7f 00 00       	push   $0x7fff
     241:	e8 c8 fe ff ff       	call   10e <testuid>
     246:	83 c4 10             	add    $0x10,%esp
     249:	85 c0                	test   %eax,%eax
     24b:	74 07                	je     254 <testuidgid+0xac>
    success = -1;
     24d:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(32768, 32767, -1))
     254:	83 ec 04             	sub    $0x4,%esp
     257:	6a ff                	push   $0xffffffff
     259:	68 ff 7f 00 00       	push   $0x7fff
     25e:	68 00 80 00 00       	push   $0x8000
     263:	e8 a6 fe ff ff       	call   10e <testuid>
     268:	83 c4 10             	add    $0x10,%esp
     26b:	85 c0                	test   %eax,%eax
     26d:	74 07                	je     276 <testuidgid+0xce>
    success = -1;
     26f:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testuid(-1, 32767, -1))
     276:	83 ec 04             	sub    $0x4,%esp
     279:	6a ff                	push   $0xffffffff
     27b:	68 ff 7f 00 00       	push   $0x7fff
     280:	6a ff                	push   $0xffffffff
     282:	e8 87 fe ff ff       	call   10e <testuid>
     287:	83 c4 10             	add    $0x10,%esp
     28a:	85 c0                	test   %eax,%eax
     28c:	74 07                	je     295 <testuidgid+0xed>
    success = -1;
     28e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

  gid = getgid();
     295:	e8 ef 09 00 00       	call   c89 <getgid>
     29a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(gid < 0 || gid > 32767){
     29d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2a1:	78 09                	js     2ac <testuidgid+0x104>
     2a3:	81 7d ec ff 7f 00 00 	cmpl   $0x7fff,-0x14(%ebp)
     2aa:	7e 1c                	jle    2c8 <testuidgid+0x120>
    printf(1, "FAILED: Default GID %d, out of range\n", gid);
     2ac:	83 ec 04             	sub    $0x4,%esp
     2af:	ff 75 ec             	pushl  -0x14(%ebp)
     2b2:	68 00 13 00 00       	push   $0x1300
     2b7:	6a 01                	push   $0x1
     2b9:	e8 ca 0a 00 00       	call   d88 <printf>
     2be:	83 c4 10             	add    $0x10,%esp
    success = -1;
     2c1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  }
  if (testgid(0, 0, 0))
     2c8:	83 ec 04             	sub    $0x4,%esp
     2cb:	6a 00                	push   $0x0
     2cd:	6a 00                	push   $0x0
     2cf:	6a 00                	push   $0x0
     2d1:	e8 9e fd ff ff       	call   74 <testgid>
     2d6:	83 c4 10             	add    $0x10,%esp
     2d9:	85 c0                	test   %eax,%eax
     2db:	74 07                	je     2e4 <testuidgid+0x13c>
    success = -1;
     2dd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(5, 5, 0))
     2e4:	83 ec 04             	sub    $0x4,%esp
     2e7:	6a 00                	push   $0x0
     2e9:	6a 05                	push   $0x5
     2eb:	6a 05                	push   $0x5
     2ed:	e8 82 fd ff ff       	call   74 <testgid>
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	85 c0                	test   %eax,%eax
     2f7:	74 07                	je     300 <testuidgid+0x158>
    success = -1;
     2f9:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32767, 32767, 0))
     300:	83 ec 04             	sub    $0x4,%esp
     303:	6a 00                	push   $0x0
     305:	68 ff 7f 00 00       	push   $0x7fff
     30a:	68 ff 7f 00 00       	push   $0x7fff
     30f:	e8 60 fd ff ff       	call   74 <testgid>
     314:	83 c4 10             	add    $0x10,%esp
     317:	85 c0                	test   %eax,%eax
     319:	74 07                	je     322 <testuidgid+0x17a>
    success = -1;
     31b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(-1, 32767, -1))
     322:	83 ec 04             	sub    $0x4,%esp
     325:	6a ff                	push   $0xffffffff
     327:	68 ff 7f 00 00       	push   $0x7fff
     32c:	6a ff                	push   $0xffffffff
     32e:	e8 41 fd ff ff       	call   74 <testgid>
     333:	83 c4 10             	add    $0x10,%esp
     336:	85 c0                	test   %eax,%eax
     338:	74 07                	je     341 <testuidgid+0x199>
    success = -1;
     33a:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(32768, 32767, -1))
     341:	83 ec 04             	sub    $0x4,%esp
     344:	6a ff                	push   $0xffffffff
     346:	68 ff 7f 00 00       	push   $0x7fff
     34b:	68 00 80 00 00       	push   $0x8000
     350:	e8 1f fd ff ff       	call   74 <testgid>
     355:	83 c4 10             	add    $0x10,%esp
     358:	85 c0                	test   %eax,%eax
     35a:	74 07                	je     363 <testuidgid+0x1bb>
    success = -1;
     35c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)

  if (success == 0)
     363:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     367:	75 12                	jne    37b <testuidgid+0x1d3>
    printf(1, "** All tests passed! **\n");
     369:	83 ec 08             	sub    $0x8,%esp
     36c:	68 26 13 00 00       	push   $0x1326
     371:	6a 01                	push   $0x1
     373:	e8 10 0a 00 00       	call   d88 <printf>
     378:	83 c4 10             	add    $0x10,%esp
}
     37b:	90                   	nop
     37c:	c9                   	leave  
     37d:	c3                   	ret    

0000037e <testuidgidinheritance>:

static void
testuidgidinheritance(void){
     37e:	55                   	push   %ebp
     37f:	89 e5                	mov    %esp,%ebp
     381:	83 ec 18             	sub    $0x18,%esp
  int ret, success, uid, gid;
  success = 0;
     384:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  printf(1, "\n----------\nRunning UID / GID Inheritance Test\n----------\n");
     38b:	83 ec 08             	sub    $0x8,%esp
     38e:	68 40 13 00 00       	push   $0x1340
     393:	6a 01                	push   $0x1
     395:	e8 ee 09 00 00       	call   d88 <printf>
     39a:	83 c4 10             	add    $0x10,%esp
  if (testuid(12345, 12345, 0))
     39d:	83 ec 04             	sub    $0x4,%esp
     3a0:	6a 00                	push   $0x0
     3a2:	68 39 30 00 00       	push   $0x3039
     3a7:	68 39 30 00 00       	push   $0x3039
     3ac:	e8 5d fd ff ff       	call   10e <testuid>
     3b1:	83 c4 10             	add    $0x10,%esp
     3b4:	85 c0                	test   %eax,%eax
     3b6:	74 07                	je     3bf <testuidgidinheritance+0x41>
    success = -1;
     3b8:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if (testgid(12345, 12345, 0))
     3bf:	83 ec 04             	sub    $0x4,%esp
     3c2:	6a 00                	push   $0x0
     3c4:	68 39 30 00 00       	push   $0x3039
     3c9:	68 39 30 00 00       	push   $0x3039
     3ce:	e8 a1 fc ff ff       	call   74 <testgid>
     3d3:	83 c4 10             	add    $0x10,%esp
     3d6:	85 c0                	test   %eax,%eax
     3d8:	74 07                	je     3e1 <testuidgidinheritance+0x63>
    success = -1;
     3da:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if(success != 0)
     3e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e5:	75 7c                	jne    463 <testuidgidinheritance+0xe5>
    return;

  ret = fork();
     3e7:	e8 dd 07 00 00       	call   bc9 <fork>
     3ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(ret == 0){
     3ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3f3:	75 67                	jne    45c <testuidgidinheritance+0xde>
    uid = getuid();
     3f5:	e8 87 08 00 00       	call   c81 <getuid>
     3fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    gid = getgid();
     3fd:	e8 87 08 00 00       	call   c89 <getgid>
     402:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(uid != 12345){
     405:	81 7d ec 39 30 00 00 	cmpl   $0x3039,-0x14(%ebp)
     40c:	74 17                	je     425 <testuidgidinheritance+0xa7>
      printf(2, "FAILED: Parent UID is 12345, child UID is %d\n", uid);
     40e:	83 ec 04             	sub    $0x4,%esp
     411:	ff 75 ec             	pushl  -0x14(%ebp)
     414:	68 7c 13 00 00       	push   $0x137c
     419:	6a 02                	push   $0x2
     41b:	e8 68 09 00 00       	call   d88 <printf>
     420:	83 c4 10             	add    $0x10,%esp
     423:	eb 32                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else if(gid != 12345){
     425:	81 7d e8 39 30 00 00 	cmpl   $0x3039,-0x18(%ebp)
     42c:	74 17                	je     445 <testuidgidinheritance+0xc7>
      printf(2, "FAILED: Parent GID is 12345, child GID is %d\n", gid);
     42e:	83 ec 04             	sub    $0x4,%esp
     431:	ff 75 e8             	pushl  -0x18(%ebp)
     434:	68 ac 13 00 00       	push   $0x13ac
     439:	6a 02                	push   $0x2
     43b:	e8 48 09 00 00       	call   d88 <printf>
     440:	83 c4 10             	add    $0x10,%esp
     443:	eb 12                	jmp    457 <testuidgidinheritance+0xd9>
    }
    else
      printf(1, "** Test Passed! **\n");
     445:	83 ec 08             	sub    $0x8,%esp
     448:	68 da 13 00 00       	push   $0x13da
     44d:	6a 01                	push   $0x1
     44f:	e8 34 09 00 00       	call   d88 <printf>
     454:	83 c4 10             	add    $0x10,%esp
    exit();
     457:	e8 75 07 00 00       	call   bd1 <exit>
  }
  else {
    wait();
     45c:	e8 78 07 00 00       	call   bd9 <wait>
     461:	eb 01                	jmp    464 <testuidgidinheritance+0xe6>
  if (testuid(12345, 12345, 0))
    success = -1;
  if (testgid(12345, 12345, 0))
    success = -1;
  if(success != 0)
    return;
     463:	90                   	nop
    exit();
  }
  else {
    wait();
  }
}
     464:	c9                   	leave  
     465:	c3                   	ret    

00000466 <testtimewitharg>:
#endif

#ifdef TIME_TEST
// Forks a process and execs with time + args to see how it handles no args, invalid args, mulitple args
void
testtimewitharg(char **arg){
     466:	55                   	push   %ebp
     467:	89 e5                	mov    %esp,%ebp
     469:	83 ec 18             	sub    $0x18,%esp
  int ret;

  ret = fork();
     46c:	e8 58 07 00 00       	call   bc9 <fork>
     471:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (ret == 0){
     474:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     478:	75 31                	jne    4ab <testtimewitharg+0x45>
    exec(arg[0], arg);
     47a:	8b 45 08             	mov    0x8(%ebp),%eax
     47d:	8b 00                	mov    (%eax),%eax
     47f:	83 ec 08             	sub    $0x8,%esp
     482:	ff 75 08             	pushl  0x8(%ebp)
     485:	50                   	push   %eax
     486:	e8 7e 07 00 00       	call   c09 <exec>
     48b:	83 c4 10             	add    $0x10,%esp
    printf(2, "FAILED: exec failed to execute %s\n", arg[0]);
     48e:	8b 45 08             	mov    0x8(%ebp),%eax
     491:	8b 00                	mov    (%eax),%eax
     493:	83 ec 04             	sub    $0x4,%esp
     496:	50                   	push   %eax
     497:	68 f0 13 00 00       	push   $0x13f0
     49c:	6a 02                	push   $0x2
     49e:	e8 e5 08 00 00       	call   d88 <printf>
     4a3:	83 c4 10             	add    $0x10,%esp
    exit();
     4a6:	e8 26 07 00 00       	call   bd1 <exit>
  }
  else if(ret == -1){
     4ab:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     4af:	75 14                	jne    4c5 <testtimewitharg+0x5f>
    printf(2, "FAILED: fork failed\n");
     4b1:	83 ec 08             	sub    $0x8,%esp
     4b4:	68 13 14 00 00       	push   $0x1413
     4b9:	6a 02                	push   $0x2
     4bb:	e8 c8 08 00 00       	call   d88 <printf>
     4c0:	83 c4 10             	add    $0x10,%esp
  }
  else
    wait();
}
     4c3:	eb 05                	jmp    4ca <testtimewitharg+0x64>
  }
  else if(ret == -1){
    printf(2, "FAILED: fork failed\n");
  }
  else
    wait();
     4c5:	e8 0f 07 00 00       	call   bd9 <wait>
}
     4ca:	90                   	nop
     4cb:	c9                   	leave  
     4cc:	c3                   	ret    

000004cd <testtime>:
void
testtime(void){
     4cd:	55                   	push   %ebp
     4ce:	89 e5                	mov    %esp,%ebp
     4d0:	53                   	push   %ebx
     4d1:	83 ec 14             	sub    $0x14,%esp
  char **arg1 = malloc(sizeof(char *));
     4d4:	83 ec 0c             	sub    $0xc,%esp
     4d7:	6a 04                	push   $0x4
     4d9:	e8 7d 0b 00 00       	call   105b <malloc>
     4de:	83 c4 10             	add    $0x10,%esp
     4e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char **arg2 = malloc(sizeof(char *)*2);
     4e4:	83 ec 0c             	sub    $0xc,%esp
     4e7:	6a 08                	push   $0x8
     4e9:	e8 6d 0b 00 00       	call   105b <malloc>
     4ee:	83 c4 10             	add    $0x10,%esp
     4f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char **arg3 = malloc(sizeof(char *)*2);
     4f4:	83 ec 0c             	sub    $0xc,%esp
     4f7:	6a 08                	push   $0x8
     4f9:	e8 5d 0b 00 00       	call   105b <malloc>
     4fe:	83 c4 10             	add    $0x10,%esp
     501:	89 45 ec             	mov    %eax,-0x14(%ebp)
  char **arg4 = malloc(sizeof(char *)*4);
     504:	83 ec 0c             	sub    $0xc,%esp
     507:	6a 10                	push   $0x10
     509:	e8 4d 0b 00 00       	call   105b <malloc>
     50e:	83 c4 10             	add    $0x10,%esp
     511:	89 45 e8             	mov    %eax,-0x18(%ebp)

  arg1[0] = malloc(sizeof(char) * 5);
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	6a 05                	push   $0x5
     519:	e8 3d 0b 00 00       	call   105b <malloc>
     51e:	83 c4 10             	add    $0x10,%esp
     521:	89 c2                	mov    %eax,%edx
     523:	8b 45 f4             	mov    -0xc(%ebp),%eax
     526:	89 10                	mov    %edx,(%eax)
  strcpy(arg1[0], "time");
     528:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52b:	8b 00                	mov    (%eax),%eax
     52d:	83 ec 08             	sub    $0x8,%esp
     530:	68 28 14 00 00       	push   $0x1428
     535:	50                   	push   %eax
     536:	e8 92 03 00 00       	call   8cd <strcpy>
     53b:	83 c4 10             	add    $0x10,%esp

  arg2[0] = malloc(sizeof(char) * 5);
     53e:	83 ec 0c             	sub    $0xc,%esp
     541:	6a 05                	push   $0x5
     543:	e8 13 0b 00 00       	call   105b <malloc>
     548:	83 c4 10             	add    $0x10,%esp
     54b:	89 c2                	mov    %eax,%edx
     54d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     550:	89 10                	mov    %edx,(%eax)
  strcpy(arg2[0], "time");
     552:	8b 45 f0             	mov    -0x10(%ebp),%eax
     555:	8b 00                	mov    (%eax),%eax
     557:	83 ec 08             	sub    $0x8,%esp
     55a:	68 28 14 00 00       	push   $0x1428
     55f:	50                   	push   %eax
     560:	e8 68 03 00 00       	call   8cd <strcpy>
     565:	83 c4 10             	add    $0x10,%esp
  arg2[1] = malloc(sizeof(char) * 4);
     568:	8b 45 f0             	mov    -0x10(%ebp),%eax
     56b:	8d 58 04             	lea    0x4(%eax),%ebx
     56e:	83 ec 0c             	sub    $0xc,%esp
     571:	6a 04                	push   $0x4
     573:	e8 e3 0a 00 00       	call   105b <malloc>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	89 03                	mov    %eax,(%ebx)
  strcpy(arg2[1], "abc");
     57d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     580:	83 c0 04             	add    $0x4,%eax
     583:	8b 00                	mov    (%eax),%eax
     585:	83 ec 08             	sub    $0x8,%esp
     588:	68 2d 14 00 00       	push   $0x142d
     58d:	50                   	push   %eax
     58e:	e8 3a 03 00 00       	call   8cd <strcpy>
     593:	83 c4 10             	add    $0x10,%esp

  arg3[0] = malloc(sizeof(char) * 5);
     596:	83 ec 0c             	sub    $0xc,%esp
     599:	6a 05                	push   $0x5
     59b:	e8 bb 0a 00 00       	call   105b <malloc>
     5a0:	83 c4 10             	add    $0x10,%esp
     5a3:	89 c2                	mov    %eax,%edx
     5a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5a8:	89 10                	mov    %edx,(%eax)
  strcpy(arg3[0], "time");
     5aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5ad:	8b 00                	mov    (%eax),%eax
     5af:	83 ec 08             	sub    $0x8,%esp
     5b2:	68 28 14 00 00       	push   $0x1428
     5b7:	50                   	push   %eax
     5b8:	e8 10 03 00 00       	call   8cd <strcpy>
     5bd:	83 c4 10             	add    $0x10,%esp
  arg3[1] = malloc(sizeof(char) * 5);
     5c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5c3:	8d 58 04             	lea    0x4(%eax),%ebx
     5c6:	83 ec 0c             	sub    $0xc,%esp
     5c9:	6a 05                	push   $0x5
     5cb:	e8 8b 0a 00 00       	call   105b <malloc>
     5d0:	83 c4 10             	add    $0x10,%esp
     5d3:	89 03                	mov    %eax,(%ebx)
  strcpy(arg3[1], "date");
     5d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5d8:	83 c0 04             	add    $0x4,%eax
     5db:	8b 00                	mov    (%eax),%eax
     5dd:	83 ec 08             	sub    $0x8,%esp
     5e0:	68 31 14 00 00       	push   $0x1431
     5e5:	50                   	push   %eax
     5e6:	e8 e2 02 00 00       	call   8cd <strcpy>
     5eb:	83 c4 10             	add    $0x10,%esp

  arg4[0] = malloc(sizeof(char) * 5);
     5ee:	83 ec 0c             	sub    $0xc,%esp
     5f1:	6a 05                	push   $0x5
     5f3:	e8 63 0a 00 00       	call   105b <malloc>
     5f8:	83 c4 10             	add    $0x10,%esp
     5fb:	89 c2                	mov    %eax,%edx
     5fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     600:	89 10                	mov    %edx,(%eax)
  strcpy(arg4[0], "time");
     602:	8b 45 e8             	mov    -0x18(%ebp),%eax
     605:	8b 00                	mov    (%eax),%eax
     607:	83 ec 08             	sub    $0x8,%esp
     60a:	68 28 14 00 00       	push   $0x1428
     60f:	50                   	push   %eax
     610:	e8 b8 02 00 00       	call   8cd <strcpy>
     615:	83 c4 10             	add    $0x10,%esp
  arg4[1] = malloc(sizeof(char) * 5);
     618:	8b 45 e8             	mov    -0x18(%ebp),%eax
     61b:	8d 58 04             	lea    0x4(%eax),%ebx
     61e:	83 ec 0c             	sub    $0xc,%esp
     621:	6a 05                	push   $0x5
     623:	e8 33 0a 00 00       	call   105b <malloc>
     628:	83 c4 10             	add    $0x10,%esp
     62b:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[1], "time");
     62d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     630:	83 c0 04             	add    $0x4,%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	83 ec 08             	sub    $0x8,%esp
     638:	68 28 14 00 00       	push   $0x1428
     63d:	50                   	push   %eax
     63e:	e8 8a 02 00 00       	call   8cd <strcpy>
     643:	83 c4 10             	add    $0x10,%esp
  arg4[2] = malloc(sizeof(char) * 5);
     646:	8b 45 e8             	mov    -0x18(%ebp),%eax
     649:	8d 58 08             	lea    0x8(%eax),%ebx
     64c:	83 ec 0c             	sub    $0xc,%esp
     64f:	6a 05                	push   $0x5
     651:	e8 05 0a 00 00       	call   105b <malloc>
     656:	83 c4 10             	add    $0x10,%esp
     659:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[2], "echo");
     65b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     65e:	83 c0 08             	add    $0x8,%eax
     661:	8b 00                	mov    (%eax),%eax
     663:	83 ec 08             	sub    $0x8,%esp
     666:	68 36 14 00 00       	push   $0x1436
     66b:	50                   	push   %eax
     66c:	e8 5c 02 00 00       	call   8cd <strcpy>
     671:	83 c4 10             	add    $0x10,%esp
  arg4[3] = malloc(sizeof(char) * 6);
     674:	8b 45 e8             	mov    -0x18(%ebp),%eax
     677:	8d 58 0c             	lea    0xc(%eax),%ebx
     67a:	83 ec 0c             	sub    $0xc,%esp
     67d:	6a 06                	push   $0x6
     67f:	e8 d7 09 00 00       	call   105b <malloc>
     684:	83 c4 10             	add    $0x10,%esp
     687:	89 03                	mov    %eax,(%ebx)
  strcpy(arg4[3], "\"abc\"");
     689:	8b 45 e8             	mov    -0x18(%ebp),%eax
     68c:	83 c0 0c             	add    $0xc,%eax
     68f:	8b 00                	mov    (%eax),%eax
     691:	83 ec 08             	sub    $0x8,%esp
     694:	68 3b 14 00 00       	push   $0x143b
     699:	50                   	push   %eax
     69a:	e8 2e 02 00 00       	call   8cd <strcpy>
     69f:	83 c4 10             	add    $0x10,%esp

  printf(1, "\n----------\nRunning Time Test\n----------\n");
     6a2:	83 ec 08             	sub    $0x8,%esp
     6a5:	68 44 14 00 00       	push   $0x1444
     6aa:	6a 01                	push   $0x1
     6ac:	e8 d7 06 00 00       	call   d88 <printf>
     6b1:	83 c4 10             	add    $0x10,%esp
  printf(1, "You will need to verify these tests passed\n");
     6b4:	83 ec 08             	sub    $0x8,%esp
     6b7:	68 70 14 00 00       	push   $0x1470
     6bc:	6a 01                	push   $0x1
     6be:	e8 c5 06 00 00       	call   d88 <printf>
     6c3:	83 c4 10             	add    $0x10,%esp

  printf(1,"\n%s\n", arg1[0]);
     6c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c9:	8b 00                	mov    (%eax),%eax
     6cb:	83 ec 04             	sub    $0x4,%esp
     6ce:	50                   	push   %eax
     6cf:	68 9c 14 00 00       	push   $0x149c
     6d4:	6a 01                	push   $0x1
     6d6:	e8 ad 06 00 00       	call   d88 <printf>
     6db:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg1);
     6de:	83 ec 0c             	sub    $0xc,%esp
     6e1:	ff 75 f4             	pushl  -0xc(%ebp)
     6e4:	e8 7d fd ff ff       	call   466 <testtimewitharg>
     6e9:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg2[0], arg2[1]);
     6ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6ef:	83 c0 04             	add    $0x4,%eax
     6f2:	8b 10                	mov    (%eax),%edx
     6f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6f7:	8b 00                	mov    (%eax),%eax
     6f9:	52                   	push   %edx
     6fa:	50                   	push   %eax
     6fb:	68 a1 14 00 00       	push   $0x14a1
     700:	6a 01                	push   $0x1
     702:	e8 81 06 00 00       	call   d88 <printf>
     707:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg2);
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	ff 75 f0             	pushl  -0x10(%ebp)
     710:	e8 51 fd ff ff       	call   466 <testtimewitharg>
     715:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s\n", arg3[0], arg3[1]);
     718:	8b 45 ec             	mov    -0x14(%ebp),%eax
     71b:	83 c0 04             	add    $0x4,%eax
     71e:	8b 10                	mov    (%eax),%edx
     720:	8b 45 ec             	mov    -0x14(%ebp),%eax
     723:	8b 00                	mov    (%eax),%eax
     725:	52                   	push   %edx
     726:	50                   	push   %eax
     727:	68 a1 14 00 00       	push   $0x14a1
     72c:	6a 01                	push   $0x1
     72e:	e8 55 06 00 00       	call   d88 <printf>
     733:	83 c4 10             	add    $0x10,%esp
  testtimewitharg(arg3);
     736:	83 ec 0c             	sub    $0xc,%esp
     739:	ff 75 ec             	pushl  -0x14(%ebp)
     73c:	e8 25 fd ff ff       	call   466 <testtimewitharg>
     741:	83 c4 10             	add    $0x10,%esp
  printf(1,"\n%s %s %s %s\n", arg4[0], arg4[1], arg4[2], arg4[3]);
     744:	8b 45 e8             	mov    -0x18(%ebp),%eax
     747:	83 c0 0c             	add    $0xc,%eax
     74a:	8b 18                	mov    (%eax),%ebx
     74c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     74f:	83 c0 08             	add    $0x8,%eax
     752:	8b 08                	mov    (%eax),%ecx
     754:	8b 45 e8             	mov    -0x18(%ebp),%eax
     757:	83 c0 04             	add    $0x4,%eax
     75a:	8b 10                	mov    (%eax),%edx
     75c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     75f:	8b 00                	mov    (%eax),%eax
     761:	83 ec 08             	sub    $0x8,%esp
     764:	53                   	push   %ebx
     765:	51                   	push   %ecx
     766:	52                   	push   %edx
     767:	50                   	push   %eax
     768:	68 a9 14 00 00       	push   $0x14a9
     76d:	6a 01                	push   $0x1
     76f:	e8 14 06 00 00       	call   d88 <printf>
     774:	83 c4 20             	add    $0x20,%esp
  testtimewitharg(arg4);
     777:	83 ec 0c             	sub    $0xc,%esp
     77a:	ff 75 e8             	pushl  -0x18(%ebp)
     77d:	e8 e4 fc ff ff       	call   466 <testtimewitharg>
     782:	83 c4 10             	add    $0x10,%esp

  free(arg1[0]);
     785:	8b 45 f4             	mov    -0xc(%ebp),%eax
     788:	8b 00                	mov    (%eax),%eax
     78a:	83 ec 0c             	sub    $0xc,%esp
     78d:	50                   	push   %eax
     78e:	e8 86 07 00 00       	call   f19 <free>
     793:	83 c4 10             	add    $0x10,%esp
  free(arg1);
     796:	83 ec 0c             	sub    $0xc,%esp
     799:	ff 75 f4             	pushl  -0xc(%ebp)
     79c:	e8 78 07 00 00       	call   f19 <free>
     7a1:	83 c4 10             	add    $0x10,%esp
  free(arg2[0]); free(arg2[1]);
     7a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a7:	8b 00                	mov    (%eax),%eax
     7a9:	83 ec 0c             	sub    $0xc,%esp
     7ac:	50                   	push   %eax
     7ad:	e8 67 07 00 00       	call   f19 <free>
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b8:	83 c0 04             	add    $0x4,%eax
     7bb:	8b 00                	mov    (%eax),%eax
     7bd:	83 ec 0c             	sub    $0xc,%esp
     7c0:	50                   	push   %eax
     7c1:	e8 53 07 00 00       	call   f19 <free>
     7c6:	83 c4 10             	add    $0x10,%esp
  free(arg2);
     7c9:	83 ec 0c             	sub    $0xc,%esp
     7cc:	ff 75 f0             	pushl  -0x10(%ebp)
     7cf:	e8 45 07 00 00       	call   f19 <free>
     7d4:	83 c4 10             	add    $0x10,%esp
  free(arg3[0]); free(arg3[1]);
     7d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7da:	8b 00                	mov    (%eax),%eax
     7dc:	83 ec 0c             	sub    $0xc,%esp
     7df:	50                   	push   %eax
     7e0:	e8 34 07 00 00       	call   f19 <free>
     7e5:	83 c4 10             	add    $0x10,%esp
     7e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7eb:	83 c0 04             	add    $0x4,%eax
     7ee:	8b 00                	mov    (%eax),%eax
     7f0:	83 ec 0c             	sub    $0xc,%esp
     7f3:	50                   	push   %eax
     7f4:	e8 20 07 00 00       	call   f19 <free>
     7f9:	83 c4 10             	add    $0x10,%esp
  free(arg3);
     7fc:	83 ec 0c             	sub    $0xc,%esp
     7ff:	ff 75 ec             	pushl  -0x14(%ebp)
     802:	e8 12 07 00 00       	call   f19 <free>
     807:	83 c4 10             	add    $0x10,%esp
  free(arg4[0]); free(arg4[1]); free(arg4[2]); free(arg4[3]);
     80a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80d:	8b 00                	mov    (%eax),%eax
     80f:	83 ec 0c             	sub    $0xc,%esp
     812:	50                   	push   %eax
     813:	e8 01 07 00 00       	call   f19 <free>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     81e:	83 c0 04             	add    $0x4,%eax
     821:	8b 00                	mov    (%eax),%eax
     823:	83 ec 0c             	sub    $0xc,%esp
     826:	50                   	push   %eax
     827:	e8 ed 06 00 00       	call   f19 <free>
     82c:	83 c4 10             	add    $0x10,%esp
     82f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     832:	83 c0 08             	add    $0x8,%eax
     835:	8b 00                	mov    (%eax),%eax
     837:	83 ec 0c             	sub    $0xc,%esp
     83a:	50                   	push   %eax
     83b:	e8 d9 06 00 00       	call   f19 <free>
     840:	83 c4 10             	add    $0x10,%esp
     843:	8b 45 e8             	mov    -0x18(%ebp),%eax
     846:	83 c0 0c             	add    $0xc,%eax
     849:	8b 00                	mov    (%eax),%eax
     84b:	83 ec 0c             	sub    $0xc,%esp
     84e:	50                   	push   %eax
     84f:	e8 c5 06 00 00       	call   f19 <free>
     854:	83 c4 10             	add    $0x10,%esp
  free(arg4);
     857:	83 ec 0c             	sub    $0xc,%esp
     85a:	ff 75 e8             	pushl  -0x18(%ebp)
     85d:	e8 b7 06 00 00       	call   f19 <free>
     862:	83 c4 10             	add    $0x10,%esp
}
     865:	90                   	nop
     866:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     869:	c9                   	leave  
     86a:	c3                   	ret    

0000086b <main>:
#endif

int
main(int argc, char *argv[])
{
     86b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     86f:	83 e4 f0             	and    $0xfffffff0,%esp
     872:	ff 71 fc             	pushl  -0x4(%ecx)
     875:	55                   	push   %ebp
     876:	89 e5                	mov    %esp,%ebp
     878:	51                   	push   %ecx
     879:	83 ec 04             	sub    $0x4,%esp
    #ifdef CPUTIME_TEST
  testcputime(argv[0]);
    #endif
    #ifdef UIDGIDPPID_TEST
  testuidgid();
     87c:	e8 27 f9 ff ff       	call   1a8 <testuidgid>
  testuidgidinheritance();
     881:	e8 f8 fa ff ff       	call   37e <testuidgidinheritance>
  testppid();
     886:	e8 75 f7 ff ff       	call   0 <testppid>
    #endif
    #ifdef GETPROCS_TEST
  testgetprocs(argv[0]);
    #endif
    #ifdef TIME_TEST
  testtime();
     88b:	e8 3d fc ff ff       	call   4cd <testtime>
    #endif
  printf(1, "\n** End of Tests **\n");
     890:	83 ec 08             	sub    $0x8,%esp
     893:	68 b7 14 00 00       	push   $0x14b7
     898:	6a 01                	push   $0x1
     89a:	e8 e9 04 00 00       	call   d88 <printf>
     89f:	83 c4 10             	add    $0x10,%esp
  exit();
     8a2:	e8 2a 03 00 00       	call   bd1 <exit>

000008a7 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     8a7:	55                   	push   %ebp
     8a8:	89 e5                	mov    %esp,%ebp
     8aa:	57                   	push   %edi
     8ab:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     8ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
     8af:	8b 55 10             	mov    0x10(%ebp),%edx
     8b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b5:	89 cb                	mov    %ecx,%ebx
     8b7:	89 df                	mov    %ebx,%edi
     8b9:	89 d1                	mov    %edx,%ecx
     8bb:	fc                   	cld    
     8bc:	f3 aa                	rep stos %al,%es:(%edi)
     8be:	89 ca                	mov    %ecx,%edx
     8c0:	89 fb                	mov    %edi,%ebx
     8c2:	89 5d 08             	mov    %ebx,0x8(%ebp)
     8c5:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     8c8:	90                   	nop
     8c9:	5b                   	pop    %ebx
     8ca:	5f                   	pop    %edi
     8cb:	5d                   	pop    %ebp
     8cc:	c3                   	ret    

000008cd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     8cd:	55                   	push   %ebp
     8ce:	89 e5                	mov    %esp,%ebp
     8d0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     8d3:	8b 45 08             	mov    0x8(%ebp),%eax
     8d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     8d9:	90                   	nop
     8da:	8b 45 08             	mov    0x8(%ebp),%eax
     8dd:	8d 50 01             	lea    0x1(%eax),%edx
     8e0:	89 55 08             	mov    %edx,0x8(%ebp)
     8e3:	8b 55 0c             	mov    0xc(%ebp),%edx
     8e6:	8d 4a 01             	lea    0x1(%edx),%ecx
     8e9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     8ec:	0f b6 12             	movzbl (%edx),%edx
     8ef:	88 10                	mov    %dl,(%eax)
     8f1:	0f b6 00             	movzbl (%eax),%eax
     8f4:	84 c0                	test   %al,%al
     8f6:	75 e2                	jne    8da <strcpy+0xd>
    ;
  return os;
     8f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     8fb:	c9                   	leave  
     8fc:	c3                   	ret    

000008fd <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8fd:	55                   	push   %ebp
     8fe:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     900:	eb 08                	jmp    90a <strcmp+0xd>
    p++, q++;
     902:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     906:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     90a:	8b 45 08             	mov    0x8(%ebp),%eax
     90d:	0f b6 00             	movzbl (%eax),%eax
     910:	84 c0                	test   %al,%al
     912:	74 10                	je     924 <strcmp+0x27>
     914:	8b 45 08             	mov    0x8(%ebp),%eax
     917:	0f b6 10             	movzbl (%eax),%edx
     91a:	8b 45 0c             	mov    0xc(%ebp),%eax
     91d:	0f b6 00             	movzbl (%eax),%eax
     920:	38 c2                	cmp    %al,%dl
     922:	74 de                	je     902 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     924:	8b 45 08             	mov    0x8(%ebp),%eax
     927:	0f b6 00             	movzbl (%eax),%eax
     92a:	0f b6 d0             	movzbl %al,%edx
     92d:	8b 45 0c             	mov    0xc(%ebp),%eax
     930:	0f b6 00             	movzbl (%eax),%eax
     933:	0f b6 c0             	movzbl %al,%eax
     936:	29 c2                	sub    %eax,%edx
     938:	89 d0                	mov    %edx,%eax
}
     93a:	5d                   	pop    %ebp
     93b:	c3                   	ret    

0000093c <strlen>:

uint
strlen(char *s)
{
     93c:	55                   	push   %ebp
     93d:	89 e5                	mov    %esp,%ebp
     93f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     942:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     949:	eb 04                	jmp    94f <strlen+0x13>
     94b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     94f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     952:	8b 45 08             	mov    0x8(%ebp),%eax
     955:	01 d0                	add    %edx,%eax
     957:	0f b6 00             	movzbl (%eax),%eax
     95a:	84 c0                	test   %al,%al
     95c:	75 ed                	jne    94b <strlen+0xf>
    ;
  return n;
     95e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     961:	c9                   	leave  
     962:	c3                   	ret    

00000963 <memset>:

void*
memset(void *dst, int c, uint n)
{
     963:	55                   	push   %ebp
     964:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     966:	8b 45 10             	mov    0x10(%ebp),%eax
     969:	50                   	push   %eax
     96a:	ff 75 0c             	pushl  0xc(%ebp)
     96d:	ff 75 08             	pushl  0x8(%ebp)
     970:	e8 32 ff ff ff       	call   8a7 <stosb>
     975:	83 c4 0c             	add    $0xc,%esp
  return dst;
     978:	8b 45 08             	mov    0x8(%ebp),%eax
}
     97b:	c9                   	leave  
     97c:	c3                   	ret    

0000097d <strchr>:

char*
strchr(const char *s, char c)
{
     97d:	55                   	push   %ebp
     97e:	89 e5                	mov    %esp,%ebp
     980:	83 ec 04             	sub    $0x4,%esp
     983:	8b 45 0c             	mov    0xc(%ebp),%eax
     986:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     989:	eb 14                	jmp    99f <strchr+0x22>
    if(*s == c)
     98b:	8b 45 08             	mov    0x8(%ebp),%eax
     98e:	0f b6 00             	movzbl (%eax),%eax
     991:	3a 45 fc             	cmp    -0x4(%ebp),%al
     994:	75 05                	jne    99b <strchr+0x1e>
      return (char*)s;
     996:	8b 45 08             	mov    0x8(%ebp),%eax
     999:	eb 13                	jmp    9ae <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     99b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     99f:	8b 45 08             	mov    0x8(%ebp),%eax
     9a2:	0f b6 00             	movzbl (%eax),%eax
     9a5:	84 c0                	test   %al,%al
     9a7:	75 e2                	jne    98b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     9a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     9ae:	c9                   	leave  
     9af:	c3                   	ret    

000009b0 <gets>:

char*
gets(char *buf, int max)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9bd:	eb 42                	jmp    a01 <gets+0x51>
    cc = read(0, &c, 1);
     9bf:	83 ec 04             	sub    $0x4,%esp
     9c2:	6a 01                	push   $0x1
     9c4:	8d 45 ef             	lea    -0x11(%ebp),%eax
     9c7:	50                   	push   %eax
     9c8:	6a 00                	push   $0x0
     9ca:	e8 1a 02 00 00       	call   be9 <read>
     9cf:	83 c4 10             	add    $0x10,%esp
     9d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     9d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9d9:	7e 33                	jle    a0e <gets+0x5e>
      break;
    buf[i++] = c;
     9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9de:	8d 50 01             	lea    0x1(%eax),%edx
     9e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     9e4:	89 c2                	mov    %eax,%edx
     9e6:	8b 45 08             	mov    0x8(%ebp),%eax
     9e9:	01 c2                	add    %eax,%edx
     9eb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9ef:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     9f1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9f5:	3c 0a                	cmp    $0xa,%al
     9f7:	74 16                	je     a0f <gets+0x5f>
     9f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9fd:	3c 0d                	cmp    $0xd,%al
     9ff:	74 0e                	je     a0f <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a04:	83 c0 01             	add    $0x1,%eax
     a07:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a0a:	7c b3                	jl     9bf <gets+0xf>
     a0c:	eb 01                	jmp    a0f <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     a0e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     a0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a12:	8b 45 08             	mov    0x8(%ebp),%eax
     a15:	01 d0                	add    %edx,%eax
     a17:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     a1a:	8b 45 08             	mov    0x8(%ebp),%eax
}
     a1d:	c9                   	leave  
     a1e:	c3                   	ret    

00000a1f <stat>:

int
stat(char *n, struct stat *st)
{
     a1f:	55                   	push   %ebp
     a20:	89 e5                	mov    %esp,%ebp
     a22:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a25:	83 ec 08             	sub    $0x8,%esp
     a28:	6a 00                	push   $0x0
     a2a:	ff 75 08             	pushl  0x8(%ebp)
     a2d:	e8 df 01 00 00       	call   c11 <open>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     a38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a3c:	79 07                	jns    a45 <stat+0x26>
    return -1;
     a3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a43:	eb 25                	jmp    a6a <stat+0x4b>
  r = fstat(fd, st);
     a45:	83 ec 08             	sub    $0x8,%esp
     a48:	ff 75 0c             	pushl  0xc(%ebp)
     a4b:	ff 75 f4             	pushl  -0xc(%ebp)
     a4e:	e8 d6 01 00 00       	call   c29 <fstat>
     a53:	83 c4 10             	add    $0x10,%esp
     a56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     a59:	83 ec 0c             	sub    $0xc,%esp
     a5c:	ff 75 f4             	pushl  -0xc(%ebp)
     a5f:	e8 95 01 00 00       	call   bf9 <close>
     a64:	83 c4 10             	add    $0x10,%esp
  return r;
     a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     a6a:	c9                   	leave  
     a6b:	c3                   	ret    

00000a6c <atoi>:

int
atoi(const char *s)
{
     a6c:	55                   	push   %ebp
     a6d:	89 e5                	mov    %esp,%ebp
     a6f:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     a72:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     a79:	eb 04                	jmp    a7f <atoi+0x13>
     a7b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     a7f:	8b 45 08             	mov    0x8(%ebp),%eax
     a82:	0f b6 00             	movzbl (%eax),%eax
     a85:	3c 20                	cmp    $0x20,%al
     a87:	74 f2                	je     a7b <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
     a89:	8b 45 08             	mov    0x8(%ebp),%eax
     a8c:	0f b6 00             	movzbl (%eax),%eax
     a8f:	3c 2d                	cmp    $0x2d,%al
     a91:	75 07                	jne    a9a <atoi+0x2e>
     a93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a98:	eb 05                	jmp    a9f <atoi+0x33>
     a9a:	b8 01 00 00 00       	mov    $0x1,%eax
     a9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     aa2:	8b 45 08             	mov    0x8(%ebp),%eax
     aa5:	0f b6 00             	movzbl (%eax),%eax
     aa8:	3c 2b                	cmp    $0x2b,%al
     aaa:	74 0a                	je     ab6 <atoi+0x4a>
     aac:	8b 45 08             	mov    0x8(%ebp),%eax
     aaf:	0f b6 00             	movzbl (%eax),%eax
     ab2:	3c 2d                	cmp    $0x2d,%al
     ab4:	75 2b                	jne    ae1 <atoi+0x75>
    s++;
     ab6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     aba:	eb 25                	jmp    ae1 <atoi+0x75>
    n = n*10 + *s++ - '0';
     abc:	8b 55 fc             	mov    -0x4(%ebp),%edx
     abf:	89 d0                	mov    %edx,%eax
     ac1:	c1 e0 02             	shl    $0x2,%eax
     ac4:	01 d0                	add    %edx,%eax
     ac6:	01 c0                	add    %eax,%eax
     ac8:	89 c1                	mov    %eax,%ecx
     aca:	8b 45 08             	mov    0x8(%ebp),%eax
     acd:	8d 50 01             	lea    0x1(%eax),%edx
     ad0:	89 55 08             	mov    %edx,0x8(%ebp)
     ad3:	0f b6 00             	movzbl (%eax),%eax
     ad6:	0f be c0             	movsbl %al,%eax
     ad9:	01 c8                	add    %ecx,%eax
     adb:	83 e8 30             	sub    $0x30,%eax
     ade:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
     ae1:	8b 45 08             	mov    0x8(%ebp),%eax
     ae4:	0f b6 00             	movzbl (%eax),%eax
     ae7:	3c 2f                	cmp    $0x2f,%al
     ae9:	7e 0a                	jle    af5 <atoi+0x89>
     aeb:	8b 45 08             	mov    0x8(%ebp),%eax
     aee:	0f b6 00             	movzbl (%eax),%eax
     af1:	3c 39                	cmp    $0x39,%al
     af3:	7e c7                	jle    abc <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
     af5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     af8:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     afc:	c9                   	leave  
     afd:	c3                   	ret    

00000afe <atoo>:

int
atoo(const char *s)
{
     afe:	55                   	push   %ebp
     aff:	89 e5                	mov    %esp,%ebp
     b01:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     b04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     b0b:	eb 04                	jmp    b11 <atoo+0x13>
     b0d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     b11:	8b 45 08             	mov    0x8(%ebp),%eax
     b14:	0f b6 00             	movzbl (%eax),%eax
     b17:	3c 20                	cmp    $0x20,%al
     b19:	74 f2                	je     b0d <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
     b1b:	8b 45 08             	mov    0x8(%ebp),%eax
     b1e:	0f b6 00             	movzbl (%eax),%eax
     b21:	3c 2d                	cmp    $0x2d,%al
     b23:	75 07                	jne    b2c <atoo+0x2e>
     b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b2a:	eb 05                	jmp    b31 <atoo+0x33>
     b2c:	b8 01 00 00 00       	mov    $0x1,%eax
     b31:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     b34:	8b 45 08             	mov    0x8(%ebp),%eax
     b37:	0f b6 00             	movzbl (%eax),%eax
     b3a:	3c 2b                	cmp    $0x2b,%al
     b3c:	74 0a                	je     b48 <atoo+0x4a>
     b3e:	8b 45 08             	mov    0x8(%ebp),%eax
     b41:	0f b6 00             	movzbl (%eax),%eax
     b44:	3c 2d                	cmp    $0x2d,%al
     b46:	75 27                	jne    b6f <atoo+0x71>
    s++;
     b48:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     b4c:	eb 21                	jmp    b6f <atoo+0x71>
    n = n*8 + *s++ - '0';
     b4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b51:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     b58:	8b 45 08             	mov    0x8(%ebp),%eax
     b5b:	8d 50 01             	lea    0x1(%eax),%edx
     b5e:	89 55 08             	mov    %edx,0x8(%ebp)
     b61:	0f b6 00             	movzbl (%eax),%eax
     b64:	0f be c0             	movsbl %al,%eax
     b67:	01 c8                	add    %ecx,%eax
     b69:	83 e8 30             	sub    $0x30,%eax
     b6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
     b6f:	8b 45 08             	mov    0x8(%ebp),%eax
     b72:	0f b6 00             	movzbl (%eax),%eax
     b75:	3c 2f                	cmp    $0x2f,%al
     b77:	7e 0a                	jle    b83 <atoo+0x85>
     b79:	8b 45 08             	mov    0x8(%ebp),%eax
     b7c:	0f b6 00             	movzbl (%eax),%eax
     b7f:	3c 37                	cmp    $0x37,%al
     b81:	7e cb                	jle    b4e <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
     b83:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b86:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     b8a:	c9                   	leave  
     b8b:	c3                   	ret    

00000b8c <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     b8c:	55                   	push   %ebp
     b8d:	89 e5                	mov    %esp,%ebp
     b8f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     b92:	8b 45 08             	mov    0x8(%ebp),%eax
     b95:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     b98:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     b9e:	eb 17                	jmp    bb7 <memmove+0x2b>
    *dst++ = *src++;
     ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ba3:	8d 50 01             	lea    0x1(%eax),%edx
     ba6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ba9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bac:	8d 4a 01             	lea    0x1(%edx),%ecx
     baf:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     bb2:	0f b6 12             	movzbl (%edx),%edx
     bb5:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     bb7:	8b 45 10             	mov    0x10(%ebp),%eax
     bba:	8d 50 ff             	lea    -0x1(%eax),%edx
     bbd:	89 55 10             	mov    %edx,0x10(%ebp)
     bc0:	85 c0                	test   %eax,%eax
     bc2:	7f dc                	jg     ba0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     bc4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     bc7:	c9                   	leave  
     bc8:	c3                   	ret    

00000bc9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     bc9:	b8 01 00 00 00       	mov    $0x1,%eax
     bce:	cd 40                	int    $0x40
     bd0:	c3                   	ret    

00000bd1 <exit>:
SYSCALL(exit)
     bd1:	b8 02 00 00 00       	mov    $0x2,%eax
     bd6:	cd 40                	int    $0x40
     bd8:	c3                   	ret    

00000bd9 <wait>:
SYSCALL(wait)
     bd9:	b8 03 00 00 00       	mov    $0x3,%eax
     bde:	cd 40                	int    $0x40
     be0:	c3                   	ret    

00000be1 <pipe>:
SYSCALL(pipe)
     be1:	b8 04 00 00 00       	mov    $0x4,%eax
     be6:	cd 40                	int    $0x40
     be8:	c3                   	ret    

00000be9 <read>:
SYSCALL(read)
     be9:	b8 05 00 00 00       	mov    $0x5,%eax
     bee:	cd 40                	int    $0x40
     bf0:	c3                   	ret    

00000bf1 <write>:
SYSCALL(write)
     bf1:	b8 10 00 00 00       	mov    $0x10,%eax
     bf6:	cd 40                	int    $0x40
     bf8:	c3                   	ret    

00000bf9 <close>:
SYSCALL(close)
     bf9:	b8 15 00 00 00       	mov    $0x15,%eax
     bfe:	cd 40                	int    $0x40
     c00:	c3                   	ret    

00000c01 <kill>:
SYSCALL(kill)
     c01:	b8 06 00 00 00       	mov    $0x6,%eax
     c06:	cd 40                	int    $0x40
     c08:	c3                   	ret    

00000c09 <exec>:
SYSCALL(exec)
     c09:	b8 07 00 00 00       	mov    $0x7,%eax
     c0e:	cd 40                	int    $0x40
     c10:	c3                   	ret    

00000c11 <open>:
SYSCALL(open)
     c11:	b8 0f 00 00 00       	mov    $0xf,%eax
     c16:	cd 40                	int    $0x40
     c18:	c3                   	ret    

00000c19 <mknod>:
SYSCALL(mknod)
     c19:	b8 11 00 00 00       	mov    $0x11,%eax
     c1e:	cd 40                	int    $0x40
     c20:	c3                   	ret    

00000c21 <unlink>:
SYSCALL(unlink)
     c21:	b8 12 00 00 00       	mov    $0x12,%eax
     c26:	cd 40                	int    $0x40
     c28:	c3                   	ret    

00000c29 <fstat>:
SYSCALL(fstat)
     c29:	b8 08 00 00 00       	mov    $0x8,%eax
     c2e:	cd 40                	int    $0x40
     c30:	c3                   	ret    

00000c31 <link>:
SYSCALL(link)
     c31:	b8 13 00 00 00       	mov    $0x13,%eax
     c36:	cd 40                	int    $0x40
     c38:	c3                   	ret    

00000c39 <mkdir>:
SYSCALL(mkdir)
     c39:	b8 14 00 00 00       	mov    $0x14,%eax
     c3e:	cd 40                	int    $0x40
     c40:	c3                   	ret    

00000c41 <chdir>:
SYSCALL(chdir)
     c41:	b8 09 00 00 00       	mov    $0x9,%eax
     c46:	cd 40                	int    $0x40
     c48:	c3                   	ret    

00000c49 <dup>:
SYSCALL(dup)
     c49:	b8 0a 00 00 00       	mov    $0xa,%eax
     c4e:	cd 40                	int    $0x40
     c50:	c3                   	ret    

00000c51 <getpid>:
SYSCALL(getpid)
     c51:	b8 0b 00 00 00       	mov    $0xb,%eax
     c56:	cd 40                	int    $0x40
     c58:	c3                   	ret    

00000c59 <sbrk>:
SYSCALL(sbrk)
     c59:	b8 0c 00 00 00       	mov    $0xc,%eax
     c5e:	cd 40                	int    $0x40
     c60:	c3                   	ret    

00000c61 <sleep>:
SYSCALL(sleep)
     c61:	b8 0d 00 00 00       	mov    $0xd,%eax
     c66:	cd 40                	int    $0x40
     c68:	c3                   	ret    

00000c69 <uptime>:
SYSCALL(uptime)
     c69:	b8 0e 00 00 00       	mov    $0xe,%eax
     c6e:	cd 40                	int    $0x40
     c70:	c3                   	ret    

00000c71 <halt>:
SYSCALL(halt)
     c71:	b8 16 00 00 00       	mov    $0x16,%eax
     c76:	cd 40                	int    $0x40
     c78:	c3                   	ret    

00000c79 <date>:
SYSCALL(date)
     c79:	b8 17 00 00 00       	mov    $0x17,%eax
     c7e:	cd 40                	int    $0x40
     c80:	c3                   	ret    

00000c81 <getuid>:
SYSCALL(getuid) 
     c81:	b8 18 00 00 00       	mov    $0x18,%eax
     c86:	cd 40                	int    $0x40
     c88:	c3                   	ret    

00000c89 <getgid>:
SYSCALL(getgid)
     c89:	b8 19 00 00 00       	mov    $0x19,%eax
     c8e:	cd 40                	int    $0x40
     c90:	c3                   	ret    

00000c91 <getppid>:
SYSCALL(getppid)
     c91:	b8 1a 00 00 00       	mov    $0x1a,%eax
     c96:	cd 40                	int    $0x40
     c98:	c3                   	ret    

00000c99 <setuid>:
SYSCALL(setuid)
     c99:	b8 1b 00 00 00       	mov    $0x1b,%eax
     c9e:	cd 40                	int    $0x40
     ca0:	c3                   	ret    

00000ca1 <setgid>:
SYSCALL(setgid)
     ca1:	b8 1c 00 00 00       	mov    $0x1c,%eax
     ca6:	cd 40                	int    $0x40
     ca8:	c3                   	ret    

00000ca9 <getprocs>:
SYSCALL(getprocs)
     ca9:	b8 1a 00 00 00       	mov    $0x1a,%eax
     cae:	cd 40                	int    $0x40
     cb0:	c3                   	ret    

00000cb1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     cb1:	55                   	push   %ebp
     cb2:	89 e5                	mov    %esp,%ebp
     cb4:	83 ec 18             	sub    $0x18,%esp
     cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     cba:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     cbd:	83 ec 04             	sub    $0x4,%esp
     cc0:	6a 01                	push   $0x1
     cc2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     cc5:	50                   	push   %eax
     cc6:	ff 75 08             	pushl  0x8(%ebp)
     cc9:	e8 23 ff ff ff       	call   bf1 <write>
     cce:	83 c4 10             	add    $0x10,%esp
}
     cd1:	90                   	nop
     cd2:	c9                   	leave  
     cd3:	c3                   	ret    

00000cd4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     cd4:	55                   	push   %ebp
     cd5:	89 e5                	mov    %esp,%ebp
     cd7:	53                   	push   %ebx
     cd8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     cdb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     ce2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     ce6:	74 17                	je     cff <printint+0x2b>
     ce8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     cec:	79 11                	jns    cff <printint+0x2b>
    neg = 1;
     cee:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     cf5:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf8:	f7 d8                	neg    %eax
     cfa:	89 45 ec             	mov    %eax,-0x14(%ebp)
     cfd:	eb 06                	jmp    d05 <printint+0x31>
  } else {
    x = xx;
     cff:	8b 45 0c             	mov    0xc(%ebp),%eax
     d02:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     d05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     d0c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     d0f:	8d 41 01             	lea    0x1(%ecx),%eax
     d12:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d15:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d18:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d1b:	ba 00 00 00 00       	mov    $0x0,%edx
     d20:	f7 f3                	div    %ebx
     d22:	89 d0                	mov    %edx,%eax
     d24:	0f b6 80 20 18 00 00 	movzbl 0x1820(%eax),%eax
     d2b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     d2f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d32:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d35:	ba 00 00 00 00       	mov    $0x0,%edx
     d3a:	f7 f3                	div    %ebx
     d3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     d3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     d43:	75 c7                	jne    d0c <printint+0x38>
  if(neg)
     d45:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d49:	74 2d                	je     d78 <printint+0xa4>
    buf[i++] = '-';
     d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4e:	8d 50 01             	lea    0x1(%eax),%edx
     d51:	89 55 f4             	mov    %edx,-0xc(%ebp)
     d54:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     d59:	eb 1d                	jmp    d78 <printint+0xa4>
    putc(fd, buf[i]);
     d5b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d61:	01 d0                	add    %edx,%eax
     d63:	0f b6 00             	movzbl (%eax),%eax
     d66:	0f be c0             	movsbl %al,%eax
     d69:	83 ec 08             	sub    $0x8,%esp
     d6c:	50                   	push   %eax
     d6d:	ff 75 08             	pushl  0x8(%ebp)
     d70:	e8 3c ff ff ff       	call   cb1 <putc>
     d75:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     d78:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     d7c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d80:	79 d9                	jns    d5b <printint+0x87>
    putc(fd, buf[i]);
}
     d82:	90                   	nop
     d83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d86:	c9                   	leave  
     d87:	c3                   	ret    

00000d88 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     d88:	55                   	push   %ebp
     d89:	89 e5                	mov    %esp,%ebp
     d8b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     d8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     d95:	8d 45 0c             	lea    0xc(%ebp),%eax
     d98:	83 c0 04             	add    $0x4,%eax
     d9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     d9e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     da5:	e9 59 01 00 00       	jmp    f03 <printf+0x17b>
    c = fmt[i] & 0xff;
     daa:	8b 55 0c             	mov    0xc(%ebp),%edx
     dad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     db0:	01 d0                	add    %edx,%eax
     db2:	0f b6 00             	movzbl (%eax),%eax
     db5:	0f be c0             	movsbl %al,%eax
     db8:	25 ff 00 00 00       	and    $0xff,%eax
     dbd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     dc0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     dc4:	75 2c                	jne    df2 <printf+0x6a>
      if(c == '%'){
     dc6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     dca:	75 0c                	jne    dd8 <printf+0x50>
        state = '%';
     dcc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     dd3:	e9 27 01 00 00       	jmp    eff <printf+0x177>
      } else {
        putc(fd, c);
     dd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ddb:	0f be c0             	movsbl %al,%eax
     dde:	83 ec 08             	sub    $0x8,%esp
     de1:	50                   	push   %eax
     de2:	ff 75 08             	pushl  0x8(%ebp)
     de5:	e8 c7 fe ff ff       	call   cb1 <putc>
     dea:	83 c4 10             	add    $0x10,%esp
     ded:	e9 0d 01 00 00       	jmp    eff <printf+0x177>
      }
    } else if(state == '%'){
     df2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     df6:	0f 85 03 01 00 00    	jne    eff <printf+0x177>
      if(c == 'd'){
     dfc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     e00:	75 1e                	jne    e20 <printf+0x98>
        printint(fd, *ap, 10, 1);
     e02:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e05:	8b 00                	mov    (%eax),%eax
     e07:	6a 01                	push   $0x1
     e09:	6a 0a                	push   $0xa
     e0b:	50                   	push   %eax
     e0c:	ff 75 08             	pushl  0x8(%ebp)
     e0f:	e8 c0 fe ff ff       	call   cd4 <printint>
     e14:	83 c4 10             	add    $0x10,%esp
        ap++;
     e17:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     e1b:	e9 d8 00 00 00       	jmp    ef8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     e20:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     e24:	74 06                	je     e2c <printf+0xa4>
     e26:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     e2a:	75 1e                	jne    e4a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     e2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e2f:	8b 00                	mov    (%eax),%eax
     e31:	6a 00                	push   $0x0
     e33:	6a 10                	push   $0x10
     e35:	50                   	push   %eax
     e36:	ff 75 08             	pushl  0x8(%ebp)
     e39:	e8 96 fe ff ff       	call   cd4 <printint>
     e3e:	83 c4 10             	add    $0x10,%esp
        ap++;
     e41:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     e45:	e9 ae 00 00 00       	jmp    ef8 <printf+0x170>
      } else if(c == 's'){
     e4a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     e4e:	75 43                	jne    e93 <printf+0x10b>
        s = (char*)*ap;
     e50:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e53:	8b 00                	mov    (%eax),%eax
     e55:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     e58:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     e5c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e60:	75 25                	jne    e87 <printf+0xff>
          s = "(null)";
     e62:	c7 45 f4 cc 14 00 00 	movl   $0x14cc,-0xc(%ebp)
        while(*s != 0){
     e69:	eb 1c                	jmp    e87 <printf+0xff>
          putc(fd, *s);
     e6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6e:	0f b6 00             	movzbl (%eax),%eax
     e71:	0f be c0             	movsbl %al,%eax
     e74:	83 ec 08             	sub    $0x8,%esp
     e77:	50                   	push   %eax
     e78:	ff 75 08             	pushl  0x8(%ebp)
     e7b:	e8 31 fe ff ff       	call   cb1 <putc>
     e80:	83 c4 10             	add    $0x10,%esp
          s++;
     e83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     e87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8a:	0f b6 00             	movzbl (%eax),%eax
     e8d:	84 c0                	test   %al,%al
     e8f:	75 da                	jne    e6b <printf+0xe3>
     e91:	eb 65                	jmp    ef8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e93:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     e97:	75 1d                	jne    eb6 <printf+0x12e>
        putc(fd, *ap);
     e99:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e9c:	8b 00                	mov    (%eax),%eax
     e9e:	0f be c0             	movsbl %al,%eax
     ea1:	83 ec 08             	sub    $0x8,%esp
     ea4:	50                   	push   %eax
     ea5:	ff 75 08             	pushl  0x8(%ebp)
     ea8:	e8 04 fe ff ff       	call   cb1 <putc>
     ead:	83 c4 10             	add    $0x10,%esp
        ap++;
     eb0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     eb4:	eb 42                	jmp    ef8 <printf+0x170>
      } else if(c == '%'){
     eb6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     eba:	75 17                	jne    ed3 <printf+0x14b>
        putc(fd, c);
     ebc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ebf:	0f be c0             	movsbl %al,%eax
     ec2:	83 ec 08             	sub    $0x8,%esp
     ec5:	50                   	push   %eax
     ec6:	ff 75 08             	pushl  0x8(%ebp)
     ec9:	e8 e3 fd ff ff       	call   cb1 <putc>
     ece:	83 c4 10             	add    $0x10,%esp
     ed1:	eb 25                	jmp    ef8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ed3:	83 ec 08             	sub    $0x8,%esp
     ed6:	6a 25                	push   $0x25
     ed8:	ff 75 08             	pushl  0x8(%ebp)
     edb:	e8 d1 fd ff ff       	call   cb1 <putc>
     ee0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     ee3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ee6:	0f be c0             	movsbl %al,%eax
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	50                   	push   %eax
     eed:	ff 75 08             	pushl  0x8(%ebp)
     ef0:	e8 bc fd ff ff       	call   cb1 <putc>
     ef5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     ef8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     eff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f03:	8b 55 0c             	mov    0xc(%ebp),%edx
     f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f09:	01 d0                	add    %edx,%eax
     f0b:	0f b6 00             	movzbl (%eax),%eax
     f0e:	84 c0                	test   %al,%al
     f10:	0f 85 94 fe ff ff    	jne    daa <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     f16:	90                   	nop
     f17:	c9                   	leave  
     f18:	c3                   	ret    

00000f19 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f19:	55                   	push   %ebp
     f1a:	89 e5                	mov    %esp,%ebp
     f1c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f1f:	8b 45 08             	mov    0x8(%ebp),%eax
     f22:	83 e8 08             	sub    $0x8,%eax
     f25:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f28:	a1 3c 18 00 00       	mov    0x183c,%eax
     f2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     f30:	eb 24                	jmp    f56 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f32:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f35:	8b 00                	mov    (%eax),%eax
     f37:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f3a:	77 12                	ja     f4e <free+0x35>
     f3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f3f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f42:	77 24                	ja     f68 <free+0x4f>
     f44:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f47:	8b 00                	mov    (%eax),%eax
     f49:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     f4c:	77 1a                	ja     f68 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f51:	8b 00                	mov    (%eax),%eax
     f53:	89 45 fc             	mov    %eax,-0x4(%ebp)
     f56:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f59:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     f5c:	76 d4                	jbe    f32 <free+0x19>
     f5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f61:	8b 00                	mov    (%eax),%eax
     f63:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     f66:	76 ca                	jbe    f32 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     f68:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f6b:	8b 40 04             	mov    0x4(%eax),%eax
     f6e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     f75:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f78:	01 c2                	add    %eax,%edx
     f7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f7d:	8b 00                	mov    (%eax),%eax
     f7f:	39 c2                	cmp    %eax,%edx
     f81:	75 24                	jne    fa7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     f83:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f86:	8b 50 04             	mov    0x4(%eax),%edx
     f89:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f8c:	8b 00                	mov    (%eax),%eax
     f8e:	8b 40 04             	mov    0x4(%eax),%eax
     f91:	01 c2                	add    %eax,%edx
     f93:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f96:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     f99:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f9c:	8b 00                	mov    (%eax),%eax
     f9e:	8b 10                	mov    (%eax),%edx
     fa0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fa3:	89 10                	mov    %edx,(%eax)
     fa5:	eb 0a                	jmp    fb1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     fa7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     faa:	8b 10                	mov    (%eax),%edx
     fac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     faf:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     fb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fb4:	8b 40 04             	mov    0x4(%eax),%eax
     fb7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     fbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fc1:	01 d0                	add    %edx,%eax
     fc3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fc6:	75 20                	jne    fe8 <free+0xcf>
    p->s.size += bp->s.size;
     fc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fcb:	8b 50 04             	mov    0x4(%eax),%edx
     fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fd1:	8b 40 04             	mov    0x4(%eax),%eax
     fd4:	01 c2                	add    %eax,%edx
     fd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fd9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     fdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fdf:	8b 10                	mov    (%eax),%edx
     fe1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fe4:	89 10                	mov    %edx,(%eax)
     fe6:	eb 08                	jmp    ff0 <free+0xd7>
  } else
    p->s.ptr = bp;
     fe8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     feb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     fee:	89 10                	mov    %edx,(%eax)
  freep = p;
     ff0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ff3:	a3 3c 18 00 00       	mov    %eax,0x183c
}
     ff8:	90                   	nop
     ff9:	c9                   	leave  
     ffa:	c3                   	ret    

00000ffb <morecore>:

static Header*
morecore(uint nu)
{
     ffb:	55                   	push   %ebp
     ffc:	89 e5                	mov    %esp,%ebp
     ffe:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1001:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1008:	77 07                	ja     1011 <morecore+0x16>
    nu = 4096;
    100a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1011:	8b 45 08             	mov    0x8(%ebp),%eax
    1014:	c1 e0 03             	shl    $0x3,%eax
    1017:	83 ec 0c             	sub    $0xc,%esp
    101a:	50                   	push   %eax
    101b:	e8 39 fc ff ff       	call   c59 <sbrk>
    1020:	83 c4 10             	add    $0x10,%esp
    1023:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1026:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    102a:	75 07                	jne    1033 <morecore+0x38>
    return 0;
    102c:	b8 00 00 00 00       	mov    $0x0,%eax
    1031:	eb 26                	jmp    1059 <morecore+0x5e>
  hp = (Header*)p;
    1033:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1036:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1039:	8b 45 f0             	mov    -0x10(%ebp),%eax
    103c:	8b 55 08             	mov    0x8(%ebp),%edx
    103f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1042:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1045:	83 c0 08             	add    $0x8,%eax
    1048:	83 ec 0c             	sub    $0xc,%esp
    104b:	50                   	push   %eax
    104c:	e8 c8 fe ff ff       	call   f19 <free>
    1051:	83 c4 10             	add    $0x10,%esp
  return freep;
    1054:	a1 3c 18 00 00       	mov    0x183c,%eax
}
    1059:	c9                   	leave  
    105a:	c3                   	ret    

0000105b <malloc>:

void*
malloc(uint nbytes)
{
    105b:	55                   	push   %ebp
    105c:	89 e5                	mov    %esp,%ebp
    105e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1061:	8b 45 08             	mov    0x8(%ebp),%eax
    1064:	83 c0 07             	add    $0x7,%eax
    1067:	c1 e8 03             	shr    $0x3,%eax
    106a:	83 c0 01             	add    $0x1,%eax
    106d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1070:	a1 3c 18 00 00       	mov    0x183c,%eax
    1075:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1078:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    107c:	75 23                	jne    10a1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    107e:	c7 45 f0 34 18 00 00 	movl   $0x1834,-0x10(%ebp)
    1085:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1088:	a3 3c 18 00 00       	mov    %eax,0x183c
    108d:	a1 3c 18 00 00       	mov    0x183c,%eax
    1092:	a3 34 18 00 00       	mov    %eax,0x1834
    base.s.size = 0;
    1097:	c7 05 38 18 00 00 00 	movl   $0x0,0x1838
    109e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10a4:	8b 00                	mov    (%eax),%eax
    10a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    10a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ac:	8b 40 04             	mov    0x4(%eax),%eax
    10af:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    10b2:	72 4d                	jb     1101 <malloc+0xa6>
      if(p->s.size == nunits)
    10b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b7:	8b 40 04             	mov    0x4(%eax),%eax
    10ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    10bd:	75 0c                	jne    10cb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    10bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c2:	8b 10                	mov    (%eax),%edx
    10c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c7:	89 10                	mov    %edx,(%eax)
    10c9:	eb 26                	jmp    10f1 <malloc+0x96>
      else {
        p->s.size -= nunits;
    10cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ce:	8b 40 04             	mov    0x4(%eax),%eax
    10d1:	2b 45 ec             	sub    -0x14(%ebp),%eax
    10d4:	89 c2                	mov    %eax,%edx
    10d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    10dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10df:	8b 40 04             	mov    0x4(%eax),%eax
    10e2:	c1 e0 03             	shl    $0x3,%eax
    10e5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    10e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10eb:	8b 55 ec             	mov    -0x14(%ebp),%edx
    10ee:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    10f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10f4:	a3 3c 18 00 00       	mov    %eax,0x183c
      return (void*)(p + 1);
    10f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10fc:	83 c0 08             	add    $0x8,%eax
    10ff:	eb 3b                	jmp    113c <malloc+0xe1>
    }
    if(p == freep)
    1101:	a1 3c 18 00 00       	mov    0x183c,%eax
    1106:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1109:	75 1e                	jne    1129 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    110b:	83 ec 0c             	sub    $0xc,%esp
    110e:	ff 75 ec             	pushl  -0x14(%ebp)
    1111:	e8 e5 fe ff ff       	call   ffb <morecore>
    1116:	83 c4 10             	add    $0x10,%esp
    1119:	89 45 f4             	mov    %eax,-0xc(%ebp)
    111c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1120:	75 07                	jne    1129 <malloc+0xce>
        return 0;
    1122:	b8 00 00 00 00       	mov    $0x0,%eax
    1127:	eb 13                	jmp    113c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1129:	8b 45 f4             	mov    -0xc(%ebp),%eax
    112c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    112f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1132:	8b 00                	mov    (%eax),%eax
    1134:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1137:	e9 6d ff ff ff       	jmp    10a9 <malloc+0x4e>
}
    113c:	c9                   	leave  
    113d:	c3                   	ret    
