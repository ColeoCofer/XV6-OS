
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "uproc.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
  int maxSize = 16; //Max size of the data structure
  14:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%ebp)
  int tableSize, i;

  struct uproc *ptable;
  ptable = malloc(maxSize * sizeof(struct uproc));
  1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1e:	6b c0 5c             	imul   $0x5c,%eax,%eax
  21:	83 ec 0c             	sub    $0xc,%esp
  24:	50                   	push   %eax
  25:	e8 2d 0a 00 00       	call   a57 <malloc>
  2a:	83 c4 10             	add    $0x10,%esp
  2d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (!ptable)
  30:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  34:	75 17                	jne    4d <main+0x4d>
  {
    printf(2, "Error: The ptable has no size.");
  36:	83 ec 08             	sub    $0x8,%esp
  39:	68 3c 0b 00 00       	push   $0xb3c
  3e:	6a 02                	push   $0x2
  40:	e8 3f 07 00 00       	call   784 <printf>
  45:	83 c4 10             	add    $0x10,%esp
    exit();
  48:	e8 80 05 00 00       	call   5cd <exit>
  }
  
  tableSize = getprocs(maxSize, ptable);
  4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	ff 75 dc             	pushl  -0x24(%ebp)
  56:	50                   	push   %eax
  57:	e8 49 06 00 00       	call   6a5 <getprocs>
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (!tableSize)
  62:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  66:	75 17                	jne    7f <main+0x7f>
  {
    printf(2, "Error: The ptable has no size.");
  68:	83 ec 08             	sub    $0x8,%esp
  6b:	68 3c 0b 00 00       	push   $0xb3c
  70:	6a 02                	push   $0x2
  72:	e8 0d 07 00 00       	call   784 <printf>
  77:	83 c4 10             	add    $0x10,%esp
    exit();
  7a:	e8 4e 05 00 00       	call   5cd <exit>
  }
  
  uint elapsedTime, elapsedNum, elapsedRemainder;
  uint cpuTime, cpuNum, cpuRemainder;
  
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  7f:	83 ec 08             	sub    $0x8,%esp
  82:	68 5c 0b 00 00       	push   $0xb5c
  87:	6a 01                	push   $0x1
  89:	e8 f6 06 00 00       	call   784 <printf>
  8e:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < tableSize; ++i)
  91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  98:	e9 e7 01 00 00       	jmp    284 <main+0x284>
  {
    
    elapsedTime = ptable[i].elapsed_ticks;
  9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  a0:	6b d0 5c             	imul   $0x5c,%eax,%edx
  a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  a6:	01 d0                	add    %edx,%eax
  a8:	8b 40 10             	mov    0x10(%eax),%eax
  ab:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    elapsedNum =  elapsedTime / 1000;
  ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  b1:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  b6:	f7 e2                	mul    %edx
  b8:	89 d0                	mov    %edx,%eax
  ba:	c1 e8 06             	shr    $0x6,%eax
  bd:	89 45 d0             	mov    %eax,-0x30(%ebp)
    elapsedRemainder = elapsedTime % 1000;
  c0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  c3:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  c8:	89 c8                	mov    %ecx,%eax
  ca:	f7 e2                	mul    %edx
  cc:	89 d0                	mov    %edx,%eax
  ce:	c1 e8 06             	shr    $0x6,%eax
  d1:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
  d7:	29 c1                	sub    %eax,%ecx
  d9:	89 c8                	mov    %ecx,%eax
  db:	89 45 cc             	mov    %eax,-0x34(%ebp)
    cpuTime = ptable[i].CPU_total_ticks;
  de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  e1:	6b d0 5c             	imul   $0x5c,%eax,%edx
  e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  e7:	01 d0                	add    %edx,%eax
  e9:	8b 40 14             	mov    0x14(%eax),%eax
  ec:	89 45 c8             	mov    %eax,-0x38(%ebp)
    cpuNum = cpuTime / 1000;
  ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
  f2:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  f7:	f7 e2                	mul    %edx
  f9:	89 d0                	mov    %edx,%eax
  fb:	c1 e8 06             	shr    $0x6,%eax
  fe:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    cpuRemainder = cpuTime % 1000;
 101:	8b 4d c8             	mov    -0x38(%ebp),%ecx
 104:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 109:	89 c8                	mov    %ecx,%eax
 10b:	f7 e2                	mul    %edx
 10d:	89 d0                	mov    %edx,%eax
 10f:	c1 e8 06             	shr    $0x6,%eax
 112:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
 118:	29 c1                	sub    %eax,%ecx
 11a:	89 c8                	mov    %ecx,%eax
 11c:	89 45 c0             	mov    %eax,-0x40(%ebp)

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);
 11f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 122:	6b d0 5c             	imul   $0x5c,%eax,%edx
 125:	8b 45 dc             	mov    -0x24(%ebp),%eax
 128:	01 d0                	add    %edx,%eax
    elapsedRemainder = elapsedTime % 1000;
    cpuTime = ptable[i].CPU_total_ticks;
    cpuNum = cpuTime / 1000;
    cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
 12a:	8b 58 0c             	mov    0xc(%eax),%ebx
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);
 12d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 130:	6b d0 5c             	imul   $0x5c,%eax,%edx
 133:	8b 45 dc             	mov    -0x24(%ebp),%eax
 136:	01 d0                	add    %edx,%eax
    elapsedRemainder = elapsedTime % 1000;
    cpuTime = ptable[i].CPU_total_ticks;
    cpuNum = cpuTime / 1000;
    cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
 138:	8b 48 08             	mov    0x8(%eax),%ecx
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);
 13b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 13e:	6b d0 5c             	imul   $0x5c,%eax,%edx
 141:	8b 45 dc             	mov    -0x24(%ebp),%eax
 144:	01 d0                	add    %edx,%eax
    elapsedRemainder = elapsedTime % 1000;
    cpuTime = ptable[i].CPU_total_ticks;
    cpuNum = cpuTime / 1000;
    cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
 146:	8b 50 04             	mov    0x4(%eax),%edx
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);
 149:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 14c:	6b f0 5c             	imul   $0x5c,%eax,%esi
 14f:	8b 45 dc             	mov    -0x24(%ebp),%eax
 152:	01 f0                	add    %esi,%eax
 154:	8d 70 3c             	lea    0x3c(%eax),%esi
 157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 15a:	6b f8 5c             	imul   $0x5c,%eax,%edi
 15d:	8b 45 dc             	mov    -0x24(%ebp),%eax
 160:	01 f8                	add    %edi,%eax
    elapsedRemainder = elapsedTime % 1000;
    cpuTime = ptable[i].CPU_total_ticks;
    cpuNum = cpuTime / 1000;
    cpuRemainder = cpuTime % 1000;

    printf(1, "%d\t%s\t%d\t%d\t%d\t",
 162:	8b 00                	mov    (%eax),%eax
 164:	83 ec 04             	sub    $0x4,%esp
 167:	53                   	push   %ebx
 168:	51                   	push   %ecx
 169:	52                   	push   %edx
 16a:	56                   	push   %esi
 16b:	50                   	push   %eax
 16c:	68 8a 0b 00 00       	push   $0xb8a
 171:	6a 01                	push   $0x1
 173:	e8 0c 06 00 00       	call   784 <printf>
 178:	83 c4 20             	add    $0x20,%esp
           ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid);

    //Elapsed time formatting and padding
    if (elapsedRemainder == 0)
 17b:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
 17f:	75 17                	jne    198 <main+0x198>
      printf(1, "%d.000\t", elapsedNum);
 181:	83 ec 04             	sub    $0x4,%esp
 184:	ff 75 d0             	pushl  -0x30(%ebp)
 187:	68 9a 0b 00 00       	push   $0xb9a
 18c:	6a 01                	push   $0x1
 18e:	e8 f1 05 00 00       	call   784 <printf>
 193:	83 c4 10             	add    $0x10,%esp
 196:	eb 4f                	jmp    1e7 <main+0x1e7>
    else if (elapsedRemainder < 10)
 198:	83 7d cc 09          	cmpl   $0x9,-0x34(%ebp)
 19c:	77 17                	ja     1b5 <main+0x1b5>
      printf(1, "%d.00%d\t", elapsedNum, elapsedRemainder);
 19e:	ff 75 cc             	pushl  -0x34(%ebp)
 1a1:	ff 75 d0             	pushl  -0x30(%ebp)
 1a4:	68 a2 0b 00 00       	push   $0xba2
 1a9:	6a 01                	push   $0x1
 1ab:	e8 d4 05 00 00       	call   784 <printf>
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	eb 32                	jmp    1e7 <main+0x1e7>
    else if (elapsedRemainder < 100)
 1b5:	83 7d cc 63          	cmpl   $0x63,-0x34(%ebp)
 1b9:	77 17                	ja     1d2 <main+0x1d2>
      printf(1, "%d.0%d\t", elapsedNum, elapsedRemainder);
 1bb:	ff 75 cc             	pushl  -0x34(%ebp)
 1be:	ff 75 d0             	pushl  -0x30(%ebp)
 1c1:	68 ab 0b 00 00       	push   $0xbab
 1c6:	6a 01                	push   $0x1
 1c8:	e8 b7 05 00 00       	call   784 <printf>
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	eb 15                	jmp    1e7 <main+0x1e7>
    else
      printf(1, "%d.%d\t", elapsedNum, elapsedRemainder);
 1d2:	ff 75 cc             	pushl  -0x34(%ebp)
 1d5:	ff 75 d0             	pushl  -0x30(%ebp)
 1d8:	68 b3 0b 00 00       	push   $0xbb3
 1dd:	6a 01                	push   $0x1
 1df:	e8 a0 05 00 00       	call   784 <printf>
 1e4:	83 c4 10             	add    $0x10,%esp

    //CPU time
    if (cpuRemainder == 0)
 1e7:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 1eb:	75 17                	jne    204 <main+0x204>
      printf(1, "%d.000\t", cpuNum);
 1ed:	83 ec 04             	sub    $0x4,%esp
 1f0:	ff 75 c4             	pushl  -0x3c(%ebp)
 1f3:	68 9a 0b 00 00       	push   $0xb9a
 1f8:	6a 01                	push   $0x1
 1fa:	e8 85 05 00 00       	call   784 <printf>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	eb 4f                	jmp    253 <main+0x253>
    else if (cpuRemainder < 10)
 204:	83 7d c0 09          	cmpl   $0x9,-0x40(%ebp)
 208:	77 17                	ja     221 <main+0x221>
      printf(1, "%d.00%d\t", cpuNum, cpuRemainder);
 20a:	ff 75 c0             	pushl  -0x40(%ebp)
 20d:	ff 75 c4             	pushl  -0x3c(%ebp)
 210:	68 a2 0b 00 00       	push   $0xba2
 215:	6a 01                	push   $0x1
 217:	e8 68 05 00 00       	call   784 <printf>
 21c:	83 c4 10             	add    $0x10,%esp
 21f:	eb 32                	jmp    253 <main+0x253>
    else if (cpuRemainder < 100)
 221:	83 7d c0 63          	cmpl   $0x63,-0x40(%ebp)
 225:	77 17                	ja     23e <main+0x23e>
      printf(1, "%d.0%d\t", cpuNum, cpuRemainder);
 227:	ff 75 c0             	pushl  -0x40(%ebp)
 22a:	ff 75 c4             	pushl  -0x3c(%ebp)
 22d:	68 ab 0b 00 00       	push   $0xbab
 232:	6a 01                	push   $0x1
 234:	e8 4b 05 00 00       	call   784 <printf>
 239:	83 c4 10             	add    $0x10,%esp
 23c:	eb 15                	jmp    253 <main+0x253>
    else
      printf(1, "%d.%d\t", cpuNum, cpuRemainder);
 23e:	ff 75 c0             	pushl  -0x40(%ebp)
 241:	ff 75 c4             	pushl  -0x3c(%ebp)
 244:	68 b3 0b 00 00       	push   $0xbb3
 249:	6a 01                	push   $0x1
 24b:	e8 34 05 00 00       	call   784 <printf>
 250:	83 c4 10             	add    $0x10,%esp

    
    printf(1, "%s\t%d\t\n",ptable[i].state, ptable[i].size);
 253:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 256:	6b d0 5c             	imul   $0x5c,%eax,%edx
 259:	8b 45 dc             	mov    -0x24(%ebp),%eax
 25c:	01 d0                	add    %edx,%eax
 25e:	8b 40 38             	mov    0x38(%eax),%eax
 261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 264:	6b ca 5c             	imul   $0x5c,%edx,%ecx
 267:	8b 55 dc             	mov    -0x24(%ebp),%edx
 26a:	01 ca                	add    %ecx,%edx
 26c:	83 c2 18             	add    $0x18,%edx
 26f:	50                   	push   %eax
 270:	52                   	push   %edx
 271:	68 ba 0b 00 00       	push   $0xbba
 276:	6a 01                	push   $0x1
 278:	e8 07 05 00 00       	call   784 <printf>
 27d:	83 c4 10             	add    $0x10,%esp
  
  uint elapsedTime, elapsedNum, elapsedRemainder;
  uint cpuTime, cpuNum, cpuRemainder;
  
  printf(1, "PID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
  for (i = 0; i < tableSize; ++i)
 280:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 284:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 287:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 28a:	0f 8c 0d fe ff ff    	jl     9d <main+0x9d>


  }

  
  free(ptable);  
 290:	83 ec 0c             	sub    $0xc,%esp
 293:	ff 75 dc             	pushl  -0x24(%ebp)
 296:	e8 7a 06 00 00       	call   915 <free>
 29b:	83 c4 10             	add    $0x10,%esp
  exit();
 29e:	e8 2a 03 00 00       	call   5cd <exit>

000002a3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	57                   	push   %edi
 2a7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 2a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2ab:	8b 55 10             	mov    0x10(%ebp),%edx
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 cb                	mov    %ecx,%ebx
 2b3:	89 df                	mov    %ebx,%edi
 2b5:	89 d1                	mov    %edx,%ecx
 2b7:	fc                   	cld    
 2b8:	f3 aa                	rep stos %al,%es:(%edi)
 2ba:	89 ca                	mov    %ecx,%edx
 2bc:	89 fb                	mov    %edi,%ebx
 2be:	89 5d 08             	mov    %ebx,0x8(%ebp)
 2c1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 2c4:	90                   	nop
 2c5:	5b                   	pop    %ebx
 2c6:	5f                   	pop    %edi
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    

000002c9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2c9:	55                   	push   %ebp
 2ca:	89 e5                	mov    %esp,%ebp
 2cc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 2d5:	90                   	nop
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	8d 50 01             	lea    0x1(%eax),%edx
 2dc:	89 55 08             	mov    %edx,0x8(%ebp)
 2df:	8b 55 0c             	mov    0xc(%ebp),%edx
 2e2:	8d 4a 01             	lea    0x1(%edx),%ecx
 2e5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 2e8:	0f b6 12             	movzbl (%edx),%edx
 2eb:	88 10                	mov    %dl,(%eax)
 2ed:	0f b6 00             	movzbl (%eax),%eax
 2f0:	84 c0                	test   %al,%al
 2f2:	75 e2                	jne    2d6 <strcpy+0xd>
    ;
  return os;
 2f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2f7:	c9                   	leave  
 2f8:	c3                   	ret    

000002f9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f9:	55                   	push   %ebp
 2fa:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 2fc:	eb 08                	jmp    306 <strcmp+0xd>
    p++, q++;
 2fe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 302:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	0f b6 00             	movzbl (%eax),%eax
 30c:	84 c0                	test   %al,%al
 30e:	74 10                	je     320 <strcmp+0x27>
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	0f b6 10             	movzbl (%eax),%edx
 316:	8b 45 0c             	mov    0xc(%ebp),%eax
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	38 c2                	cmp    %al,%dl
 31e:	74 de                	je     2fe <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	0f b6 00             	movzbl (%eax),%eax
 326:	0f b6 d0             	movzbl %al,%edx
 329:	8b 45 0c             	mov    0xc(%ebp),%eax
 32c:	0f b6 00             	movzbl (%eax),%eax
 32f:	0f b6 c0             	movzbl %al,%eax
 332:	29 c2                	sub    %eax,%edx
 334:	89 d0                	mov    %edx,%eax
}
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    

00000338 <strlen>:

uint
strlen(char *s)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 33e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 345:	eb 04                	jmp    34b <strlen+0x13>
 347:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 34b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	01 d0                	add    %edx,%eax
 353:	0f b6 00             	movzbl (%eax),%eax
 356:	84 c0                	test   %al,%al
 358:	75 ed                	jne    347 <strlen+0xf>
    ;
  return n;
 35a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 35d:	c9                   	leave  
 35e:	c3                   	ret    

0000035f <memset>:

void*
memset(void *dst, int c, uint n)
{
 35f:	55                   	push   %ebp
 360:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 362:	8b 45 10             	mov    0x10(%ebp),%eax
 365:	50                   	push   %eax
 366:	ff 75 0c             	pushl  0xc(%ebp)
 369:	ff 75 08             	pushl  0x8(%ebp)
 36c:	e8 32 ff ff ff       	call   2a3 <stosb>
 371:	83 c4 0c             	add    $0xc,%esp
  return dst;
 374:	8b 45 08             	mov    0x8(%ebp),%eax
}
 377:	c9                   	leave  
 378:	c3                   	ret    

00000379 <strchr>:

char*
strchr(const char *s, char c)
{
 379:	55                   	push   %ebp
 37a:	89 e5                	mov    %esp,%ebp
 37c:	83 ec 04             	sub    $0x4,%esp
 37f:	8b 45 0c             	mov    0xc(%ebp),%eax
 382:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 385:	eb 14                	jmp    39b <strchr+0x22>
    if(*s == c)
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	0f b6 00             	movzbl (%eax),%eax
 38d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 390:	75 05                	jne    397 <strchr+0x1e>
      return (char*)s;
 392:	8b 45 08             	mov    0x8(%ebp),%eax
 395:	eb 13                	jmp    3aa <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 397:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	84 c0                	test   %al,%al
 3a3:	75 e2                	jne    387 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 3a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3aa:	c9                   	leave  
 3ab:	c3                   	ret    

000003ac <gets>:

char*
gets(char *buf, int max)
{
 3ac:	55                   	push   %ebp
 3ad:	89 e5                	mov    %esp,%ebp
 3af:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3b9:	eb 42                	jmp    3fd <gets+0x51>
    cc = read(0, &c, 1);
 3bb:	83 ec 04             	sub    $0x4,%esp
 3be:	6a 01                	push   $0x1
 3c0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 3c3:	50                   	push   %eax
 3c4:	6a 00                	push   $0x0
 3c6:	e8 1a 02 00 00       	call   5e5 <read>
 3cb:	83 c4 10             	add    $0x10,%esp
 3ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 3d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d5:	7e 33                	jle    40a <gets+0x5e>
      break;
    buf[i++] = c;
 3d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3da:	8d 50 01             	lea    0x1(%eax),%edx
 3dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e0:	89 c2                	mov    %eax,%edx
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	01 c2                	add    %eax,%edx
 3e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 3ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3f1:	3c 0a                	cmp    $0xa,%al
 3f3:	74 16                	je     40b <gets+0x5f>
 3f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3f9:	3c 0d                	cmp    $0xd,%al
 3fb:	74 0e                	je     40b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 400:	83 c0 01             	add    $0x1,%eax
 403:	3b 45 0c             	cmp    0xc(%ebp),%eax
 406:	7c b3                	jl     3bb <gets+0xf>
 408:	eb 01                	jmp    40b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 40a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 40b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 40e:	8b 45 08             	mov    0x8(%ebp),%eax
 411:	01 d0                	add    %edx,%eax
 413:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 416:	8b 45 08             	mov    0x8(%ebp),%eax
}
 419:	c9                   	leave  
 41a:	c3                   	ret    

0000041b <stat>:

int
stat(char *n, struct stat *st)
{
 41b:	55                   	push   %ebp
 41c:	89 e5                	mov    %esp,%ebp
 41e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 421:	83 ec 08             	sub    $0x8,%esp
 424:	6a 00                	push   $0x0
 426:	ff 75 08             	pushl  0x8(%ebp)
 429:	e8 df 01 00 00       	call   60d <open>
 42e:	83 c4 10             	add    $0x10,%esp
 431:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 434:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 438:	79 07                	jns    441 <stat+0x26>
    return -1;
 43a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 43f:	eb 25                	jmp    466 <stat+0x4b>
  r = fstat(fd, st);
 441:	83 ec 08             	sub    $0x8,%esp
 444:	ff 75 0c             	pushl  0xc(%ebp)
 447:	ff 75 f4             	pushl  -0xc(%ebp)
 44a:	e8 d6 01 00 00       	call   625 <fstat>
 44f:	83 c4 10             	add    $0x10,%esp
 452:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 455:	83 ec 0c             	sub    $0xc,%esp
 458:	ff 75 f4             	pushl  -0xc(%ebp)
 45b:	e8 95 01 00 00       	call   5f5 <close>
 460:	83 c4 10             	add    $0x10,%esp
  return r;
 463:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 466:	c9                   	leave  
 467:	c3                   	ret    

00000468 <atoi>:

int
atoi(const char *s)
{
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 46e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 475:	eb 04                	jmp    47b <atoi+0x13>
 477:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 47b:	8b 45 08             	mov    0x8(%ebp),%eax
 47e:	0f b6 00             	movzbl (%eax),%eax
 481:	3c 20                	cmp    $0x20,%al
 483:	74 f2                	je     477 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 485:	8b 45 08             	mov    0x8(%ebp),%eax
 488:	0f b6 00             	movzbl (%eax),%eax
 48b:	3c 2d                	cmp    $0x2d,%al
 48d:	75 07                	jne    496 <atoi+0x2e>
 48f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 494:	eb 05                	jmp    49b <atoi+0x33>
 496:	b8 01 00 00 00       	mov    $0x1,%eax
 49b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 49e:	8b 45 08             	mov    0x8(%ebp),%eax
 4a1:	0f b6 00             	movzbl (%eax),%eax
 4a4:	3c 2b                	cmp    $0x2b,%al
 4a6:	74 0a                	je     4b2 <atoi+0x4a>
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	0f b6 00             	movzbl (%eax),%eax
 4ae:	3c 2d                	cmp    $0x2d,%al
 4b0:	75 2b                	jne    4dd <atoi+0x75>
    s++;
 4b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 4b6:	eb 25                	jmp    4dd <atoi+0x75>
    n = n*10 + *s++ - '0';
 4b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4bb:	89 d0                	mov    %edx,%eax
 4bd:	c1 e0 02             	shl    $0x2,%eax
 4c0:	01 d0                	add    %edx,%eax
 4c2:	01 c0                	add    %eax,%eax
 4c4:	89 c1                	mov    %eax,%ecx
 4c6:	8b 45 08             	mov    0x8(%ebp),%eax
 4c9:	8d 50 01             	lea    0x1(%eax),%edx
 4cc:	89 55 08             	mov    %edx,0x8(%ebp)
 4cf:	0f b6 00             	movzbl (%eax),%eax
 4d2:	0f be c0             	movsbl %al,%eax
 4d5:	01 c8                	add    %ecx,%eax
 4d7:	83 e8 30             	sub    $0x30,%eax
 4da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 4dd:	8b 45 08             	mov    0x8(%ebp),%eax
 4e0:	0f b6 00             	movzbl (%eax),%eax
 4e3:	3c 2f                	cmp    $0x2f,%al
 4e5:	7e 0a                	jle    4f1 <atoi+0x89>
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ea:	0f b6 00             	movzbl (%eax),%eax
 4ed:	3c 39                	cmp    $0x39,%al
 4ef:	7e c7                	jle    4b8 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 4f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 4f4:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 4f8:	c9                   	leave  
 4f9:	c3                   	ret    

000004fa <atoo>:

int
atoo(const char *s)
{
 4fa:	55                   	push   %ebp
 4fb:	89 e5                	mov    %esp,%ebp
 4fd:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 500:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 507:	eb 04                	jmp    50d <atoo+0x13>
 509:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 50d:	8b 45 08             	mov    0x8(%ebp),%eax
 510:	0f b6 00             	movzbl (%eax),%eax
 513:	3c 20                	cmp    $0x20,%al
 515:	74 f2                	je     509 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 517:	8b 45 08             	mov    0x8(%ebp),%eax
 51a:	0f b6 00             	movzbl (%eax),%eax
 51d:	3c 2d                	cmp    $0x2d,%al
 51f:	75 07                	jne    528 <atoo+0x2e>
 521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 526:	eb 05                	jmp    52d <atoo+0x33>
 528:	b8 01 00 00 00       	mov    $0x1,%eax
 52d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 530:	8b 45 08             	mov    0x8(%ebp),%eax
 533:	0f b6 00             	movzbl (%eax),%eax
 536:	3c 2b                	cmp    $0x2b,%al
 538:	74 0a                	je     544 <atoo+0x4a>
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	0f b6 00             	movzbl (%eax),%eax
 540:	3c 2d                	cmp    $0x2d,%al
 542:	75 27                	jne    56b <atoo+0x71>
    s++;
 544:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 548:	eb 21                	jmp    56b <atoo+0x71>
    n = n*8 + *s++ - '0';
 54a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 54d:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 554:	8b 45 08             	mov    0x8(%ebp),%eax
 557:	8d 50 01             	lea    0x1(%eax),%edx
 55a:	89 55 08             	mov    %edx,0x8(%ebp)
 55d:	0f b6 00             	movzbl (%eax),%eax
 560:	0f be c0             	movsbl %al,%eax
 563:	01 c8                	add    %ecx,%eax
 565:	83 e8 30             	sub    $0x30,%eax
 568:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	0f b6 00             	movzbl (%eax),%eax
 571:	3c 2f                	cmp    $0x2f,%al
 573:	7e 0a                	jle    57f <atoo+0x85>
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	0f b6 00             	movzbl (%eax),%eax
 57b:	3c 37                	cmp    $0x37,%al
 57d:	7e cb                	jle    54a <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 57f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 582:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 586:	c9                   	leave  
 587:	c3                   	ret    

00000588 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 588:	55                   	push   %ebp
 589:	89 e5                	mov    %esp,%ebp
 58b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 58e:	8b 45 08             	mov    0x8(%ebp),%eax
 591:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 594:	8b 45 0c             	mov    0xc(%ebp),%eax
 597:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 59a:	eb 17                	jmp    5b3 <memmove+0x2b>
    *dst++ = *src++;
 59c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59f:	8d 50 01             	lea    0x1(%eax),%edx
 5a2:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5a5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5a8:	8d 4a 01             	lea    0x1(%edx),%ecx
 5ab:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5ae:	0f b6 12             	movzbl (%edx),%edx
 5b1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b3:	8b 45 10             	mov    0x10(%ebp),%eax
 5b6:	8d 50 ff             	lea    -0x1(%eax),%edx
 5b9:	89 55 10             	mov    %edx,0x10(%ebp)
 5bc:	85 c0                	test   %eax,%eax
 5be:	7f dc                	jg     59c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5c3:	c9                   	leave  
 5c4:	c3                   	ret    

000005c5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5c5:	b8 01 00 00 00       	mov    $0x1,%eax
 5ca:	cd 40                	int    $0x40
 5cc:	c3                   	ret    

000005cd <exit>:
SYSCALL(exit)
 5cd:	b8 02 00 00 00       	mov    $0x2,%eax
 5d2:	cd 40                	int    $0x40
 5d4:	c3                   	ret    

000005d5 <wait>:
SYSCALL(wait)
 5d5:	b8 03 00 00 00       	mov    $0x3,%eax
 5da:	cd 40                	int    $0x40
 5dc:	c3                   	ret    

000005dd <pipe>:
SYSCALL(pipe)
 5dd:	b8 04 00 00 00       	mov    $0x4,%eax
 5e2:	cd 40                	int    $0x40
 5e4:	c3                   	ret    

000005e5 <read>:
SYSCALL(read)
 5e5:	b8 05 00 00 00       	mov    $0x5,%eax
 5ea:	cd 40                	int    $0x40
 5ec:	c3                   	ret    

000005ed <write>:
SYSCALL(write)
 5ed:	b8 10 00 00 00       	mov    $0x10,%eax
 5f2:	cd 40                	int    $0x40
 5f4:	c3                   	ret    

000005f5 <close>:
SYSCALL(close)
 5f5:	b8 15 00 00 00       	mov    $0x15,%eax
 5fa:	cd 40                	int    $0x40
 5fc:	c3                   	ret    

000005fd <kill>:
SYSCALL(kill)
 5fd:	b8 06 00 00 00       	mov    $0x6,%eax
 602:	cd 40                	int    $0x40
 604:	c3                   	ret    

00000605 <exec>:
SYSCALL(exec)
 605:	b8 07 00 00 00       	mov    $0x7,%eax
 60a:	cd 40                	int    $0x40
 60c:	c3                   	ret    

0000060d <open>:
SYSCALL(open)
 60d:	b8 0f 00 00 00       	mov    $0xf,%eax
 612:	cd 40                	int    $0x40
 614:	c3                   	ret    

00000615 <mknod>:
SYSCALL(mknod)
 615:	b8 11 00 00 00       	mov    $0x11,%eax
 61a:	cd 40                	int    $0x40
 61c:	c3                   	ret    

0000061d <unlink>:
SYSCALL(unlink)
 61d:	b8 12 00 00 00       	mov    $0x12,%eax
 622:	cd 40                	int    $0x40
 624:	c3                   	ret    

00000625 <fstat>:
SYSCALL(fstat)
 625:	b8 08 00 00 00       	mov    $0x8,%eax
 62a:	cd 40                	int    $0x40
 62c:	c3                   	ret    

0000062d <link>:
SYSCALL(link)
 62d:	b8 13 00 00 00       	mov    $0x13,%eax
 632:	cd 40                	int    $0x40
 634:	c3                   	ret    

00000635 <mkdir>:
SYSCALL(mkdir)
 635:	b8 14 00 00 00       	mov    $0x14,%eax
 63a:	cd 40                	int    $0x40
 63c:	c3                   	ret    

0000063d <chdir>:
SYSCALL(chdir)
 63d:	b8 09 00 00 00       	mov    $0x9,%eax
 642:	cd 40                	int    $0x40
 644:	c3                   	ret    

00000645 <dup>:
SYSCALL(dup)
 645:	b8 0a 00 00 00       	mov    $0xa,%eax
 64a:	cd 40                	int    $0x40
 64c:	c3                   	ret    

0000064d <getpid>:
SYSCALL(getpid)
 64d:	b8 0b 00 00 00       	mov    $0xb,%eax
 652:	cd 40                	int    $0x40
 654:	c3                   	ret    

00000655 <sbrk>:
SYSCALL(sbrk)
 655:	b8 0c 00 00 00       	mov    $0xc,%eax
 65a:	cd 40                	int    $0x40
 65c:	c3                   	ret    

0000065d <sleep>:
SYSCALL(sleep)
 65d:	b8 0d 00 00 00       	mov    $0xd,%eax
 662:	cd 40                	int    $0x40
 664:	c3                   	ret    

00000665 <uptime>:
SYSCALL(uptime)
 665:	b8 0e 00 00 00       	mov    $0xe,%eax
 66a:	cd 40                	int    $0x40
 66c:	c3                   	ret    

0000066d <halt>:
SYSCALL(halt)
 66d:	b8 16 00 00 00       	mov    $0x16,%eax
 672:	cd 40                	int    $0x40
 674:	c3                   	ret    

00000675 <date>:
SYSCALL(date)
 675:	b8 17 00 00 00       	mov    $0x17,%eax
 67a:	cd 40                	int    $0x40
 67c:	c3                   	ret    

0000067d <getuid>:
SYSCALL(getuid) 
 67d:	b8 18 00 00 00       	mov    $0x18,%eax
 682:	cd 40                	int    $0x40
 684:	c3                   	ret    

00000685 <getgid>:
SYSCALL(getgid)
 685:	b8 19 00 00 00       	mov    $0x19,%eax
 68a:	cd 40                	int    $0x40
 68c:	c3                   	ret    

0000068d <getppid>:
SYSCALL(getppid)
 68d:	b8 1a 00 00 00       	mov    $0x1a,%eax
 692:	cd 40                	int    $0x40
 694:	c3                   	ret    

00000695 <setuid>:
SYSCALL(setuid)
 695:	b8 1b 00 00 00       	mov    $0x1b,%eax
 69a:	cd 40                	int    $0x40
 69c:	c3                   	ret    

0000069d <setgid>:
SYSCALL(setgid)
 69d:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6a2:	cd 40                	int    $0x40
 6a4:	c3                   	ret    

000006a5 <getprocs>:
SYSCALL(getprocs)
 6a5:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6aa:	cd 40                	int    $0x40
 6ac:	c3                   	ret    

000006ad <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6ad:	55                   	push   %ebp
 6ae:	89 e5                	mov    %esp,%ebp
 6b0:	83 ec 18             	sub    $0x18,%esp
 6b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 6b6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6b9:	83 ec 04             	sub    $0x4,%esp
 6bc:	6a 01                	push   $0x1
 6be:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6c1:	50                   	push   %eax
 6c2:	ff 75 08             	pushl  0x8(%ebp)
 6c5:	e8 23 ff ff ff       	call   5ed <write>
 6ca:	83 c4 10             	add    $0x10,%esp
}
 6cd:	90                   	nop
 6ce:	c9                   	leave  
 6cf:	c3                   	ret    

000006d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	53                   	push   %ebx
 6d4:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6de:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6e2:	74 17                	je     6fb <printint+0x2b>
 6e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6e8:	79 11                	jns    6fb <printint+0x2b>
    neg = 1;
 6ea:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 6f4:	f7 d8                	neg    %eax
 6f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6f9:	eb 06                	jmp    701 <printint+0x31>
  } else {
    x = xx;
 6fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 6fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 701:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 708:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 70b:	8d 41 01             	lea    0x1(%ecx),%eax
 70e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 711:	8b 5d 10             	mov    0x10(%ebp),%ebx
 714:	8b 45 ec             	mov    -0x14(%ebp),%eax
 717:	ba 00 00 00 00       	mov    $0x0,%edx
 71c:	f7 f3                	div    %ebx
 71e:	89 d0                	mov    %edx,%eax
 720:	0f b6 80 40 0e 00 00 	movzbl 0xe40(%eax),%eax
 727:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 72b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 72e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 731:	ba 00 00 00 00       	mov    $0x0,%edx
 736:	f7 f3                	div    %ebx
 738:	89 45 ec             	mov    %eax,-0x14(%ebp)
 73b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 73f:	75 c7                	jne    708 <printint+0x38>
  if(neg)
 741:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 745:	74 2d                	je     774 <printint+0xa4>
    buf[i++] = '-';
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	8d 50 01             	lea    0x1(%eax),%edx
 74d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 750:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 755:	eb 1d                	jmp    774 <printint+0xa4>
    putc(fd, buf[i]);
 757:	8d 55 dc             	lea    -0x24(%ebp),%edx
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	01 d0                	add    %edx,%eax
 75f:	0f b6 00             	movzbl (%eax),%eax
 762:	0f be c0             	movsbl %al,%eax
 765:	83 ec 08             	sub    $0x8,%esp
 768:	50                   	push   %eax
 769:	ff 75 08             	pushl  0x8(%ebp)
 76c:	e8 3c ff ff ff       	call   6ad <putc>
 771:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 774:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 778:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 77c:	79 d9                	jns    757 <printint+0x87>
    putc(fd, buf[i]);
}
 77e:	90                   	nop
 77f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 782:	c9                   	leave  
 783:	c3                   	ret    

00000784 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 784:	55                   	push   %ebp
 785:	89 e5                	mov    %esp,%ebp
 787:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 78a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 791:	8d 45 0c             	lea    0xc(%ebp),%eax
 794:	83 c0 04             	add    $0x4,%eax
 797:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 79a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7a1:	e9 59 01 00 00       	jmp    8ff <printf+0x17b>
    c = fmt[i] & 0xff;
 7a6:	8b 55 0c             	mov    0xc(%ebp),%edx
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	01 d0                	add    %edx,%eax
 7ae:	0f b6 00             	movzbl (%eax),%eax
 7b1:	0f be c0             	movsbl %al,%eax
 7b4:	25 ff 00 00 00       	and    $0xff,%eax
 7b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7c0:	75 2c                	jne    7ee <printf+0x6a>
      if(c == '%'){
 7c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7c6:	75 0c                	jne    7d4 <printf+0x50>
        state = '%';
 7c8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7cf:	e9 27 01 00 00       	jmp    8fb <printf+0x177>
      } else {
        putc(fd, c);
 7d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7d7:	0f be c0             	movsbl %al,%eax
 7da:	83 ec 08             	sub    $0x8,%esp
 7dd:	50                   	push   %eax
 7de:	ff 75 08             	pushl  0x8(%ebp)
 7e1:	e8 c7 fe ff ff       	call   6ad <putc>
 7e6:	83 c4 10             	add    $0x10,%esp
 7e9:	e9 0d 01 00 00       	jmp    8fb <printf+0x177>
      }
    } else if(state == '%'){
 7ee:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7f2:	0f 85 03 01 00 00    	jne    8fb <printf+0x177>
      if(c == 'd'){
 7f8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7fc:	75 1e                	jne    81c <printf+0x98>
        printint(fd, *ap, 10, 1);
 7fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 801:	8b 00                	mov    (%eax),%eax
 803:	6a 01                	push   $0x1
 805:	6a 0a                	push   $0xa
 807:	50                   	push   %eax
 808:	ff 75 08             	pushl  0x8(%ebp)
 80b:	e8 c0 fe ff ff       	call   6d0 <printint>
 810:	83 c4 10             	add    $0x10,%esp
        ap++;
 813:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 817:	e9 d8 00 00 00       	jmp    8f4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 81c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 820:	74 06                	je     828 <printf+0xa4>
 822:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 826:	75 1e                	jne    846 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 828:	8b 45 e8             	mov    -0x18(%ebp),%eax
 82b:	8b 00                	mov    (%eax),%eax
 82d:	6a 00                	push   $0x0
 82f:	6a 10                	push   $0x10
 831:	50                   	push   %eax
 832:	ff 75 08             	pushl  0x8(%ebp)
 835:	e8 96 fe ff ff       	call   6d0 <printint>
 83a:	83 c4 10             	add    $0x10,%esp
        ap++;
 83d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 841:	e9 ae 00 00 00       	jmp    8f4 <printf+0x170>
      } else if(c == 's'){
 846:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 84a:	75 43                	jne    88f <printf+0x10b>
        s = (char*)*ap;
 84c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 84f:	8b 00                	mov    (%eax),%eax
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 854:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 858:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85c:	75 25                	jne    883 <printf+0xff>
          s = "(null)";
 85e:	c7 45 f4 c2 0b 00 00 	movl   $0xbc2,-0xc(%ebp)
        while(*s != 0){
 865:	eb 1c                	jmp    883 <printf+0xff>
          putc(fd, *s);
 867:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86a:	0f b6 00             	movzbl (%eax),%eax
 86d:	0f be c0             	movsbl %al,%eax
 870:	83 ec 08             	sub    $0x8,%esp
 873:	50                   	push   %eax
 874:	ff 75 08             	pushl  0x8(%ebp)
 877:	e8 31 fe ff ff       	call   6ad <putc>
 87c:	83 c4 10             	add    $0x10,%esp
          s++;
 87f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 883:	8b 45 f4             	mov    -0xc(%ebp),%eax
 886:	0f b6 00             	movzbl (%eax),%eax
 889:	84 c0                	test   %al,%al
 88b:	75 da                	jne    867 <printf+0xe3>
 88d:	eb 65                	jmp    8f4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 88f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 893:	75 1d                	jne    8b2 <printf+0x12e>
        putc(fd, *ap);
 895:	8b 45 e8             	mov    -0x18(%ebp),%eax
 898:	8b 00                	mov    (%eax),%eax
 89a:	0f be c0             	movsbl %al,%eax
 89d:	83 ec 08             	sub    $0x8,%esp
 8a0:	50                   	push   %eax
 8a1:	ff 75 08             	pushl  0x8(%ebp)
 8a4:	e8 04 fe ff ff       	call   6ad <putc>
 8a9:	83 c4 10             	add    $0x10,%esp
        ap++;
 8ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b0:	eb 42                	jmp    8f4 <printf+0x170>
      } else if(c == '%'){
 8b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8b6:	75 17                	jne    8cf <printf+0x14b>
        putc(fd, c);
 8b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8bb:	0f be c0             	movsbl %al,%eax
 8be:	83 ec 08             	sub    $0x8,%esp
 8c1:	50                   	push   %eax
 8c2:	ff 75 08             	pushl  0x8(%ebp)
 8c5:	e8 e3 fd ff ff       	call   6ad <putc>
 8ca:	83 c4 10             	add    $0x10,%esp
 8cd:	eb 25                	jmp    8f4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8cf:	83 ec 08             	sub    $0x8,%esp
 8d2:	6a 25                	push   $0x25
 8d4:	ff 75 08             	pushl  0x8(%ebp)
 8d7:	e8 d1 fd ff ff       	call   6ad <putc>
 8dc:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8e2:	0f be c0             	movsbl %al,%eax
 8e5:	83 ec 08             	sub    $0x8,%esp
 8e8:	50                   	push   %eax
 8e9:	ff 75 08             	pushl  0x8(%ebp)
 8ec:	e8 bc fd ff ff       	call   6ad <putc>
 8f1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8f4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8fb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8ff:	8b 55 0c             	mov    0xc(%ebp),%edx
 902:	8b 45 f0             	mov    -0x10(%ebp),%eax
 905:	01 d0                	add    %edx,%eax
 907:	0f b6 00             	movzbl (%eax),%eax
 90a:	84 c0                	test   %al,%al
 90c:	0f 85 94 fe ff ff    	jne    7a6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 912:	90                   	nop
 913:	c9                   	leave  
 914:	c3                   	ret    

00000915 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 915:	55                   	push   %ebp
 916:	89 e5                	mov    %esp,%ebp
 918:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91b:	8b 45 08             	mov    0x8(%ebp),%eax
 91e:	83 e8 08             	sub    $0x8,%eax
 921:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 924:	a1 5c 0e 00 00       	mov    0xe5c,%eax
 929:	89 45 fc             	mov    %eax,-0x4(%ebp)
 92c:	eb 24                	jmp    952 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 931:	8b 00                	mov    (%eax),%eax
 933:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 936:	77 12                	ja     94a <free+0x35>
 938:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 93e:	77 24                	ja     964 <free+0x4f>
 940:	8b 45 fc             	mov    -0x4(%ebp),%eax
 943:	8b 00                	mov    (%eax),%eax
 945:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 948:	77 1a                	ja     964 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94d:	8b 00                	mov    (%eax),%eax
 94f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 952:	8b 45 f8             	mov    -0x8(%ebp),%eax
 955:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 958:	76 d4                	jbe    92e <free+0x19>
 95a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95d:	8b 00                	mov    (%eax),%eax
 95f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 962:	76 ca                	jbe    92e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 964:	8b 45 f8             	mov    -0x8(%ebp),%eax
 967:	8b 40 04             	mov    0x4(%eax),%eax
 96a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 971:	8b 45 f8             	mov    -0x8(%ebp),%eax
 974:	01 c2                	add    %eax,%edx
 976:	8b 45 fc             	mov    -0x4(%ebp),%eax
 979:	8b 00                	mov    (%eax),%eax
 97b:	39 c2                	cmp    %eax,%edx
 97d:	75 24                	jne    9a3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 97f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 982:	8b 50 04             	mov    0x4(%eax),%edx
 985:	8b 45 fc             	mov    -0x4(%ebp),%eax
 988:	8b 00                	mov    (%eax),%eax
 98a:	8b 40 04             	mov    0x4(%eax),%eax
 98d:	01 c2                	add    %eax,%edx
 98f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 992:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 995:	8b 45 fc             	mov    -0x4(%ebp),%eax
 998:	8b 00                	mov    (%eax),%eax
 99a:	8b 10                	mov    (%eax),%edx
 99c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99f:	89 10                	mov    %edx,(%eax)
 9a1:	eb 0a                	jmp    9ad <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a6:	8b 10                	mov    (%eax),%edx
 9a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ab:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b0:	8b 40 04             	mov    0x4(%eax),%eax
 9b3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bd:	01 d0                	add    %edx,%eax
 9bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9c2:	75 20                	jne    9e4 <free+0xcf>
    p->s.size += bp->s.size;
 9c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c7:	8b 50 04             	mov    0x4(%eax),%edx
 9ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9cd:	8b 40 04             	mov    0x4(%eax),%eax
 9d0:	01 c2                	add    %eax,%edx
 9d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9db:	8b 10                	mov    (%eax),%edx
 9dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e0:	89 10                	mov    %edx,(%eax)
 9e2:	eb 08                	jmp    9ec <free+0xd7>
  } else
    p->s.ptr = bp;
 9e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9ea:	89 10                	mov    %edx,(%eax)
  freep = p;
 9ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ef:	a3 5c 0e 00 00       	mov    %eax,0xe5c
}
 9f4:	90                   	nop
 9f5:	c9                   	leave  
 9f6:	c3                   	ret    

000009f7 <morecore>:

static Header*
morecore(uint nu)
{
 9f7:	55                   	push   %ebp
 9f8:	89 e5                	mov    %esp,%ebp
 9fa:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9fd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a04:	77 07                	ja     a0d <morecore+0x16>
    nu = 4096;
 a06:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a0d:	8b 45 08             	mov    0x8(%ebp),%eax
 a10:	c1 e0 03             	shl    $0x3,%eax
 a13:	83 ec 0c             	sub    $0xc,%esp
 a16:	50                   	push   %eax
 a17:	e8 39 fc ff ff       	call   655 <sbrk>
 a1c:	83 c4 10             	add    $0x10,%esp
 a1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a22:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a26:	75 07                	jne    a2f <morecore+0x38>
    return 0;
 a28:	b8 00 00 00 00       	mov    $0x0,%eax
 a2d:	eb 26                	jmp    a55 <morecore+0x5e>
  hp = (Header*)p;
 a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a38:	8b 55 08             	mov    0x8(%ebp),%edx
 a3b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a41:	83 c0 08             	add    $0x8,%eax
 a44:	83 ec 0c             	sub    $0xc,%esp
 a47:	50                   	push   %eax
 a48:	e8 c8 fe ff ff       	call   915 <free>
 a4d:	83 c4 10             	add    $0x10,%esp
  return freep;
 a50:	a1 5c 0e 00 00       	mov    0xe5c,%eax
}
 a55:	c9                   	leave  
 a56:	c3                   	ret    

00000a57 <malloc>:

void*
malloc(uint nbytes)
{
 a57:	55                   	push   %ebp
 a58:	89 e5                	mov    %esp,%ebp
 a5a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5d:	8b 45 08             	mov    0x8(%ebp),%eax
 a60:	83 c0 07             	add    $0x7,%eax
 a63:	c1 e8 03             	shr    $0x3,%eax
 a66:	83 c0 01             	add    $0x1,%eax
 a69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a6c:	a1 5c 0e 00 00       	mov    0xe5c,%eax
 a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a74:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a78:	75 23                	jne    a9d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a7a:	c7 45 f0 54 0e 00 00 	movl   $0xe54,-0x10(%ebp)
 a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a84:	a3 5c 0e 00 00       	mov    %eax,0xe5c
 a89:	a1 5c 0e 00 00       	mov    0xe5c,%eax
 a8e:	a3 54 0e 00 00       	mov    %eax,0xe54
    base.s.size = 0;
 a93:	c7 05 58 0e 00 00 00 	movl   $0x0,0xe58
 a9a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa0:	8b 00                	mov    (%eax),%eax
 aa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa8:	8b 40 04             	mov    0x4(%eax),%eax
 aab:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aae:	72 4d                	jb     afd <malloc+0xa6>
      if(p->s.size == nunits)
 ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab3:	8b 40 04             	mov    0x4(%eax),%eax
 ab6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 ab9:	75 0c                	jne    ac7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abe:	8b 10                	mov    (%eax),%edx
 ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac3:	89 10                	mov    %edx,(%eax)
 ac5:	eb 26                	jmp    aed <malloc+0x96>
      else {
        p->s.size -= nunits;
 ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aca:	8b 40 04             	mov    0x4(%eax),%eax
 acd:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ad0:	89 c2                	mov    %eax,%edx
 ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adb:	8b 40 04             	mov    0x4(%eax),%eax
 ade:	c1 e0 03             	shl    $0x3,%eax
 ae1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aea:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af0:	a3 5c 0e 00 00       	mov    %eax,0xe5c
      return (void*)(p + 1);
 af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af8:	83 c0 08             	add    $0x8,%eax
 afb:	eb 3b                	jmp    b38 <malloc+0xe1>
    }
    if(p == freep)
 afd:	a1 5c 0e 00 00       	mov    0xe5c,%eax
 b02:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b05:	75 1e                	jne    b25 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 b07:	83 ec 0c             	sub    $0xc,%esp
 b0a:	ff 75 ec             	pushl  -0x14(%ebp)
 b0d:	e8 e5 fe ff ff       	call   9f7 <morecore>
 b12:	83 c4 10             	add    $0x10,%esp
 b15:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b18:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1c:	75 07                	jne    b25 <malloc+0xce>
        return 0;
 b1e:	b8 00 00 00 00       	mov    $0x0,%eax
 b23:	eb 13                	jmp    b38 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b28:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2e:	8b 00                	mov    (%eax),%eax
 b30:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b33:	e9 6d ff ff ff       	jmp    aa5 <malloc+0x4e>
}
 b38:	c9                   	leave  
 b39:	c3                   	ret    
