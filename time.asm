
_time:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

void printAsFloat(int num);

int
main(int argc, char * argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx

  //Time was ran without a parameter
  if (argc == 1) 
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	75 1d                	jne    36 <main+0x36>
  {
    printf(1, "\n%s ran in 0.000\n", argv[0]); 
  19:	8b 43 04             	mov    0x4(%ebx),%eax
  1c:	8b 00                	mov    (%eax),%eax
  1e:	83 ec 04             	sub    $0x4,%esp
  21:	50                   	push   %eax
  22:	68 38 0a 00 00       	push   $0xa38
  27:	6a 01                	push   $0x1
  29:	e8 53 06 00 00       	call   681 <printf>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	e9 b0 00 00 00       	jmp    e6 <main+0xe6>
  }
  else
  {

    int startTime = uptime(); 
  36:	e8 27 05 00 00       	call   562 <uptime>
  3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int pid = fork();;    
  3e:	e8 7f 04 00 00       	call   4c2 <fork>
  43:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if (pid == 0)
  46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  4a:	75 36                	jne    82 <main+0x82>
    {
      //Execute the process with any arguments it has
      if (exec(argv[1], argv + 1) < 0)
  4c:	8b 43 04             	mov    0x4(%ebx),%eax
  4f:	8d 50 04             	lea    0x4(%eax),%edx
  52:	8b 43 04             	mov    0x4(%ebx),%eax
  55:	83 c0 04             	add    $0x4,%eax
  58:	8b 00                	mov    (%eax),%eax
  5a:	83 ec 08             	sub    $0x8,%esp
  5d:	52                   	push   %edx
  5e:	50                   	push   %eax
  5f:	e8 9e 04 00 00       	call   502 <exec>
  64:	83 c4 10             	add    $0x10,%esp
  67:	85 c0                	test   %eax,%eax
  69:	79 17                	jns    82 <main+0x82>
      {
        printf(2, "Error: Invalid Command.");
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	68 4a 0a 00 00       	push   $0xa4a
  73:	6a 02                	push   $0x2
  75:	e8 07 06 00 00       	call   681 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
        exit();
  7d:	e8 48 04 00 00       	call   4ca <exit>
      }

    } 

    //Wait for the child process to finish
    if (pid > 0) {
  82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  86:	7e 05                	jle    8d <main+0x8d>
      wait();
  88:	e8 45 04 00 00       	call   4d2 <wait>
    } 

    //Fork returned negative PID
    if (pid < 0)
  8d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  91:	79 12                	jns    a5 <main+0xa5>
    {
      printf(2, "Error, Fork returned a negative pid");
  93:	83 ec 08             	sub    $0x8,%esp
  96:	68 64 0a 00 00       	push   $0xa64
  9b:	6a 02                	push   $0x2
  9d:	e8 df 05 00 00       	call   681 <printf>
  a2:	83 c4 10             	add    $0x10,%esp
    }

    printf(1, "%s ran in ", argv[1]);
  a5:	8b 43 04             	mov    0x4(%ebx),%eax
  a8:	83 c0 04             	add    $0x4,%eax
  ab:	8b 00                	mov    (%eax),%eax
  ad:	83 ec 04             	sub    $0x4,%esp
  b0:	50                   	push   %eax
  b1:	68 88 0a 00 00       	push   $0xa88
  b6:	6a 01                	push   $0x1
  b8:	e8 c4 05 00 00       	call   681 <printf>
  bd:	83 c4 10             	add    $0x10,%esp
    printAsFloat(uptime() - startTime); 
  c0:	e8 9d 04 00 00       	call   562 <uptime>
  c5:	2b 45 f4             	sub    -0xc(%ebp),%eax
  c8:	83 ec 0c             	sub    $0xc,%esp
  cb:	50                   	push   %eax
  cc:	e8 1a 00 00 00       	call   eb <printAsFloat>
  d1:	83 c4 10             	add    $0x10,%esp
    printf(1, " seconds\n");      
  d4:	83 ec 08             	sub    $0x8,%esp
  d7:	68 93 0a 00 00       	push   $0xa93
  dc:	6a 01                	push   $0x1
  de:	e8 9e 05 00 00       	call   681 <printf>
  e3:	83 c4 10             	add    $0x10,%esp

  }
  exit();
  e6:	e8 df 03 00 00       	call   4ca <exit>

000000eb <printAsFloat>:
}

//Prints an integer as a floating point number
void
printAsFloat(int totalTime) 
{
  eb:	55                   	push   %ebp
  ec:	89 e5                	mov    %esp,%ebp
  ee:	83 ec 18             	sub    $0x18,%esp
  uint timeNum, timeRemainder;

  timeNum = totalTime / 1000;         
  f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f4:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
  f9:	89 c8                	mov    %ecx,%eax
  fb:	f7 ea                	imul   %edx
  fd:	c1 fa 06             	sar    $0x6,%edx
 100:	89 c8                	mov    %ecx,%eax
 102:	c1 f8 1f             	sar    $0x1f,%eax
 105:	29 c2                	sub    %eax,%edx
 107:	89 d0                	mov    %edx,%eax
 109:	89 45 f4             	mov    %eax,-0xc(%ebp)
  timeRemainder = totalTime % 1000;
 10c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 10f:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
 114:	89 c8                	mov    %ecx,%eax
 116:	f7 ea                	imul   %edx
 118:	c1 fa 06             	sar    $0x6,%edx
 11b:	89 c8                	mov    %ecx,%eax
 11d:	c1 f8 1f             	sar    $0x1f,%eax
 120:	29 c2                	sub    %eax,%edx
 122:	89 d0                	mov    %edx,%eax
 124:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
 12a:	29 c1                	sub    %eax,%ecx
 12c:	89 c8                	mov    %ecx,%eax
 12e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (timeRemainder == 0)
 131:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 135:	75 17                	jne    14e <printAsFloat+0x63>
    printf(1, "%d.000", timeNum);
 137:	83 ec 04             	sub    $0x4,%esp
 13a:	ff 75 f4             	pushl  -0xc(%ebp)
 13d:	68 9d 0a 00 00       	push   $0xa9d
 142:	6a 01                	push   $0x1
 144:	e8 38 05 00 00       	call   681 <printf>
 149:	83 c4 10             	add    $0x10,%esp
    printf(1, "%d.00%d", timeNum, timeRemainder);
  else if (timeRemainder < 100)
    printf(1, "%d.0%d", timeNum, timeRemainder);
  else
    printf(1, "%d.%d", timeNum, timeRemainder);
}
 14c:	eb 4f                	jmp    19d <printAsFloat+0xb2>
  timeNum = totalTime / 1000;         
  timeRemainder = totalTime % 1000;

  if (timeRemainder == 0)
    printf(1, "%d.000", timeNum);
  else if (timeRemainder < 10)
 14e:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
 152:	77 17                	ja     16b <printAsFloat+0x80>
    printf(1, "%d.00%d", timeNum, timeRemainder);
 154:	ff 75 f0             	pushl  -0x10(%ebp)
 157:	ff 75 f4             	pushl  -0xc(%ebp)
 15a:	68 a4 0a 00 00       	push   $0xaa4
 15f:	6a 01                	push   $0x1
 161:	e8 1b 05 00 00       	call   681 <printf>
 166:	83 c4 10             	add    $0x10,%esp
  else if (timeRemainder < 100)
    printf(1, "%d.0%d", timeNum, timeRemainder);
  else
    printf(1, "%d.%d", timeNum, timeRemainder);
}
 169:	eb 32                	jmp    19d <printAsFloat+0xb2>

  if (timeRemainder == 0)
    printf(1, "%d.000", timeNum);
  else if (timeRemainder < 10)
    printf(1, "%d.00%d", timeNum, timeRemainder);
  else if (timeRemainder < 100)
 16b:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
 16f:	77 17                	ja     188 <printAsFloat+0x9d>
    printf(1, "%d.0%d", timeNum, timeRemainder);
 171:	ff 75 f0             	pushl  -0x10(%ebp)
 174:	ff 75 f4             	pushl  -0xc(%ebp)
 177:	68 ac 0a 00 00       	push   $0xaac
 17c:	6a 01                	push   $0x1
 17e:	e8 fe 04 00 00       	call   681 <printf>
 183:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "%d.%d", timeNum, timeRemainder);
}
 186:	eb 15                	jmp    19d <printAsFloat+0xb2>
  else if (timeRemainder < 10)
    printf(1, "%d.00%d", timeNum, timeRemainder);
  else if (timeRemainder < 100)
    printf(1, "%d.0%d", timeNum, timeRemainder);
  else
    printf(1, "%d.%d", timeNum, timeRemainder);
 188:	ff 75 f0             	pushl  -0x10(%ebp)
 18b:	ff 75 f4             	pushl  -0xc(%ebp)
 18e:	68 b3 0a 00 00       	push   $0xab3
 193:	6a 01                	push   $0x1
 195:	e8 e7 04 00 00       	call   681 <printf>
 19a:	83 c4 10             	add    $0x10,%esp
}
 19d:	90                   	nop
 19e:	c9                   	leave  
 19f:	c3                   	ret    

000001a0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a8:	8b 55 10             	mov    0x10(%ebp),%edx
 1ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ae:	89 cb                	mov    %ecx,%ebx
 1b0:	89 df                	mov    %ebx,%edi
 1b2:	89 d1                	mov    %edx,%ecx
 1b4:	fc                   	cld    
 1b5:	f3 aa                	rep stos %al,%es:(%edi)
 1b7:	89 ca                	mov    %ecx,%edx
 1b9:	89 fb                	mov    %edi,%ebx
 1bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1be:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1c1:	90                   	nop
 1c2:	5b                   	pop    %ebx
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    

000001c6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1c6:	55                   	push   %ebp
 1c7:	89 e5                	mov    %esp,%ebp
 1c9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1d2:	90                   	nop
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	8d 50 01             	lea    0x1(%eax),%edx
 1d9:	89 55 08             	mov    %edx,0x8(%ebp)
 1dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 1df:	8d 4a 01             	lea    0x1(%edx),%ecx
 1e2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1e5:	0f b6 12             	movzbl (%edx),%edx
 1e8:	88 10                	mov    %dl,(%eax)
 1ea:	0f b6 00             	movzbl (%eax),%eax
 1ed:	84 c0                	test   %al,%al
 1ef:	75 e2                	jne    1d3 <strcpy+0xd>
    ;
  return os;
 1f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1f4:	c9                   	leave  
 1f5:	c3                   	ret    

000001f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f6:	55                   	push   %ebp
 1f7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1f9:	eb 08                	jmp    203 <strcmp+0xd>
    p++, q++;
 1fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1ff:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 00             	movzbl (%eax),%eax
 209:	84 c0                	test   %al,%al
 20b:	74 10                	je     21d <strcmp+0x27>
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	0f b6 10             	movzbl (%eax),%edx
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	0f b6 00             	movzbl (%eax),%eax
 219:	38 c2                	cmp    %al,%dl
 21b:	74 de                	je     1fb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	0f b6 00             	movzbl (%eax),%eax
 223:	0f b6 d0             	movzbl %al,%edx
 226:	8b 45 0c             	mov    0xc(%ebp),%eax
 229:	0f b6 00             	movzbl (%eax),%eax
 22c:	0f b6 c0             	movzbl %al,%eax
 22f:	29 c2                	sub    %eax,%edx
 231:	89 d0                	mov    %edx,%eax
}
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    

00000235 <strlen>:

uint
strlen(char *s)
{
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
 238:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 23b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 242:	eb 04                	jmp    248 <strlen+0x13>
 244:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	8b 45 08             	mov    0x8(%ebp),%eax
 24e:	01 d0                	add    %edx,%eax
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	84 c0                	test   %al,%al
 255:	75 ed                	jne    244 <strlen+0xf>
    ;
  return n;
 257:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 25a:	c9                   	leave  
 25b:	c3                   	ret    

0000025c <memset>:

void*
memset(void *dst, int c, uint n)
{
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 25f:	8b 45 10             	mov    0x10(%ebp),%eax
 262:	50                   	push   %eax
 263:	ff 75 0c             	pushl  0xc(%ebp)
 266:	ff 75 08             	pushl  0x8(%ebp)
 269:	e8 32 ff ff ff       	call   1a0 <stosb>
 26e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 271:	8b 45 08             	mov    0x8(%ebp),%eax
}
 274:	c9                   	leave  
 275:	c3                   	ret    

00000276 <strchr>:

char*
strchr(const char *s, char c)
{
 276:	55                   	push   %ebp
 277:	89 e5                	mov    %esp,%ebp
 279:	83 ec 04             	sub    $0x4,%esp
 27c:	8b 45 0c             	mov    0xc(%ebp),%eax
 27f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 282:	eb 14                	jmp    298 <strchr+0x22>
    if(*s == c)
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	0f b6 00             	movzbl (%eax),%eax
 28a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 28d:	75 05                	jne    294 <strchr+0x1e>
      return (char*)s;
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	eb 13                	jmp    2a7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 294:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 298:	8b 45 08             	mov    0x8(%ebp),%eax
 29b:	0f b6 00             	movzbl (%eax),%eax
 29e:	84 c0                	test   %al,%al
 2a0:	75 e2                	jne    284 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2a7:	c9                   	leave  
 2a8:	c3                   	ret    

000002a9 <gets>:

char*
gets(char *buf, int max)
{
 2a9:	55                   	push   %ebp
 2aa:	89 e5                	mov    %esp,%ebp
 2ac:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2b6:	eb 42                	jmp    2fa <gets+0x51>
    cc = read(0, &c, 1);
 2b8:	83 ec 04             	sub    $0x4,%esp
 2bb:	6a 01                	push   $0x1
 2bd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2c0:	50                   	push   %eax
 2c1:	6a 00                	push   $0x0
 2c3:	e8 1a 02 00 00       	call   4e2 <read>
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2d2:	7e 33                	jle    307 <gets+0x5e>
      break;
    buf[i++] = c;
 2d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d7:	8d 50 01             	lea    0x1(%eax),%edx
 2da:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2dd:	89 c2                	mov    %eax,%edx
 2df:	8b 45 08             	mov    0x8(%ebp),%eax
 2e2:	01 c2                	add    %eax,%edx
 2e4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2ea:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ee:	3c 0a                	cmp    $0xa,%al
 2f0:	74 16                	je     308 <gets+0x5f>
 2f2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f6:	3c 0d                	cmp    $0xd,%al
 2f8:	74 0e                	je     308 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fd:	83 c0 01             	add    $0x1,%eax
 300:	3b 45 0c             	cmp    0xc(%ebp),%eax
 303:	7c b3                	jl     2b8 <gets+0xf>
 305:	eb 01                	jmp    308 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 307:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 308:	8b 55 f4             	mov    -0xc(%ebp),%edx
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	01 d0                	add    %edx,%eax
 310:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 313:	8b 45 08             	mov    0x8(%ebp),%eax
}
 316:	c9                   	leave  
 317:	c3                   	ret    

00000318 <stat>:

int
stat(char *n, struct stat *st)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31e:	83 ec 08             	sub    $0x8,%esp
 321:	6a 00                	push   $0x0
 323:	ff 75 08             	pushl  0x8(%ebp)
 326:	e8 df 01 00 00       	call   50a <open>
 32b:	83 c4 10             	add    $0x10,%esp
 32e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 331:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 335:	79 07                	jns    33e <stat+0x26>
    return -1;
 337:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33c:	eb 25                	jmp    363 <stat+0x4b>
  r = fstat(fd, st);
 33e:	83 ec 08             	sub    $0x8,%esp
 341:	ff 75 0c             	pushl  0xc(%ebp)
 344:	ff 75 f4             	pushl  -0xc(%ebp)
 347:	e8 d6 01 00 00       	call   522 <fstat>
 34c:	83 c4 10             	add    $0x10,%esp
 34f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 352:	83 ec 0c             	sub    $0xc,%esp
 355:	ff 75 f4             	pushl  -0xc(%ebp)
 358:	e8 95 01 00 00       	call   4f2 <close>
 35d:	83 c4 10             	add    $0x10,%esp
  return r;
 360:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 363:	c9                   	leave  
 364:	c3                   	ret    

00000365 <atoi>:

int
atoi(const char *s)
{
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 36b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 372:	eb 04                	jmp    378 <atoi+0x13>
 374:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	0f b6 00             	movzbl (%eax),%eax
 37e:	3c 20                	cmp    $0x20,%al
 380:	74 f2                	je     374 <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	0f b6 00             	movzbl (%eax),%eax
 388:	3c 2d                	cmp    $0x2d,%al
 38a:	75 07                	jne    393 <atoi+0x2e>
 38c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 391:	eb 05                	jmp    398 <atoi+0x33>
 393:	b8 01 00 00 00       	mov    $0x1,%eax
 398:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	3c 2b                	cmp    $0x2b,%al
 3a3:	74 0a                	je     3af <atoi+0x4a>
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	3c 2d                	cmp    $0x2d,%al
 3ad:	75 2b                	jne    3da <atoi+0x75>
    s++;
 3af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 3b3:	eb 25                	jmp    3da <atoi+0x75>
    n = n*10 + *s++ - '0';
 3b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3b8:	89 d0                	mov    %edx,%eax
 3ba:	c1 e0 02             	shl    $0x2,%eax
 3bd:	01 d0                	add    %edx,%eax
 3bf:	01 c0                	add    %eax,%eax
 3c1:	89 c1                	mov    %eax,%ecx
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	8d 50 01             	lea    0x1(%eax),%edx
 3c9:	89 55 08             	mov    %edx,0x8(%ebp)
 3cc:	0f b6 00             	movzbl (%eax),%eax
 3cf:	0f be c0             	movsbl %al,%eax
 3d2:	01 c8                	add    %ecx,%eax
 3d4:	83 e8 30             	sub    $0x30,%eax
 3d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	0f b6 00             	movzbl (%eax),%eax
 3e0:	3c 2f                	cmp    $0x2f,%al
 3e2:	7e 0a                	jle    3ee <atoi+0x89>
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	0f b6 00             	movzbl (%eax),%eax
 3ea:	3c 39                	cmp    $0x39,%al
 3ec:	7e c7                	jle    3b5 <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 3ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3f1:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3f5:	c9                   	leave  
 3f6:	c3                   	ret    

000003f7 <atoo>:

int
atoo(const char *s)
{
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 3fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 404:	eb 04                	jmp    40a <atoo+0x13>
 406:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 40a:	8b 45 08             	mov    0x8(%ebp),%eax
 40d:	0f b6 00             	movzbl (%eax),%eax
 410:	3c 20                	cmp    $0x20,%al
 412:	74 f2                	je     406 <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	0f b6 00             	movzbl (%eax),%eax
 41a:	3c 2d                	cmp    $0x2d,%al
 41c:	75 07                	jne    425 <atoo+0x2e>
 41e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 423:	eb 05                	jmp    42a <atoo+0x33>
 425:	b8 01 00 00 00       	mov    $0x1,%eax
 42a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 42d:	8b 45 08             	mov    0x8(%ebp),%eax
 430:	0f b6 00             	movzbl (%eax),%eax
 433:	3c 2b                	cmp    $0x2b,%al
 435:	74 0a                	je     441 <atoo+0x4a>
 437:	8b 45 08             	mov    0x8(%ebp),%eax
 43a:	0f b6 00             	movzbl (%eax),%eax
 43d:	3c 2d                	cmp    $0x2d,%al
 43f:	75 27                	jne    468 <atoo+0x71>
    s++;
 441:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 445:	eb 21                	jmp    468 <atoo+0x71>
    n = n*8 + *s++ - '0';
 447:	8b 45 fc             	mov    -0x4(%ebp),%eax
 44a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 451:	8b 45 08             	mov    0x8(%ebp),%eax
 454:	8d 50 01             	lea    0x1(%eax),%edx
 457:	89 55 08             	mov    %edx,0x8(%ebp)
 45a:	0f b6 00             	movzbl (%eax),%eax
 45d:	0f be c0             	movsbl %al,%eax
 460:	01 c8                	add    %ecx,%eax
 462:	83 e8 30             	sub    $0x30,%eax
 465:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	0f b6 00             	movzbl (%eax),%eax
 46e:	3c 2f                	cmp    $0x2f,%al
 470:	7e 0a                	jle    47c <atoo+0x85>
 472:	8b 45 08             	mov    0x8(%ebp),%eax
 475:	0f b6 00             	movzbl (%eax),%eax
 478:	3c 37                	cmp    $0x37,%al
 47a:	7e cb                	jle    447 <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 47c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 47f:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 483:	c9                   	leave  
 484:	c3                   	ret    

00000485 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 485:	55                   	push   %ebp
 486:	89 e5                	mov    %esp,%ebp
 488:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 48b:	8b 45 08             	mov    0x8(%ebp),%eax
 48e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 491:	8b 45 0c             	mov    0xc(%ebp),%eax
 494:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 497:	eb 17                	jmp    4b0 <memmove+0x2b>
    *dst++ = *src++;
 499:	8b 45 fc             	mov    -0x4(%ebp),%eax
 49c:	8d 50 01             	lea    0x1(%eax),%edx
 49f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 4a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 4a5:	8d 4a 01             	lea    0x1(%edx),%ecx
 4a8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 4ab:	0f b6 12             	movzbl (%edx),%edx
 4ae:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4b0:	8b 45 10             	mov    0x10(%ebp),%eax
 4b3:	8d 50 ff             	lea    -0x1(%eax),%edx
 4b6:	89 55 10             	mov    %edx,0x10(%ebp)
 4b9:	85 c0                	test   %eax,%eax
 4bb:	7f dc                	jg     499 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 4bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4c0:	c9                   	leave  
 4c1:	c3                   	ret    

000004c2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4c2:	b8 01 00 00 00       	mov    $0x1,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <exit>:
SYSCALL(exit)
 4ca:	b8 02 00 00 00       	mov    $0x2,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <wait>:
SYSCALL(wait)
 4d2:	b8 03 00 00 00       	mov    $0x3,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <pipe>:
SYSCALL(pipe)
 4da:	b8 04 00 00 00       	mov    $0x4,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <read>:
SYSCALL(read)
 4e2:	b8 05 00 00 00       	mov    $0x5,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <write>:
SYSCALL(write)
 4ea:	b8 10 00 00 00       	mov    $0x10,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <close>:
SYSCALL(close)
 4f2:	b8 15 00 00 00       	mov    $0x15,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <kill>:
SYSCALL(kill)
 4fa:	b8 06 00 00 00       	mov    $0x6,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <exec>:
SYSCALL(exec)
 502:	b8 07 00 00 00       	mov    $0x7,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <open>:
SYSCALL(open)
 50a:	b8 0f 00 00 00       	mov    $0xf,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <mknod>:
SYSCALL(mknod)
 512:	b8 11 00 00 00       	mov    $0x11,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <unlink>:
SYSCALL(unlink)
 51a:	b8 12 00 00 00       	mov    $0x12,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <fstat>:
SYSCALL(fstat)
 522:	b8 08 00 00 00       	mov    $0x8,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <link>:
SYSCALL(link)
 52a:	b8 13 00 00 00       	mov    $0x13,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <mkdir>:
SYSCALL(mkdir)
 532:	b8 14 00 00 00       	mov    $0x14,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <chdir>:
SYSCALL(chdir)
 53a:	b8 09 00 00 00       	mov    $0x9,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <dup>:
SYSCALL(dup)
 542:	b8 0a 00 00 00       	mov    $0xa,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <getpid>:
SYSCALL(getpid)
 54a:	b8 0b 00 00 00       	mov    $0xb,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <sbrk>:
SYSCALL(sbrk)
 552:	b8 0c 00 00 00       	mov    $0xc,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <sleep>:
SYSCALL(sleep)
 55a:	b8 0d 00 00 00       	mov    $0xd,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <uptime>:
SYSCALL(uptime)
 562:	b8 0e 00 00 00       	mov    $0xe,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <halt>:
SYSCALL(halt)
 56a:	b8 16 00 00 00       	mov    $0x16,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <date>:
SYSCALL(date)
 572:	b8 17 00 00 00       	mov    $0x17,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <getuid>:
SYSCALL(getuid) 
 57a:	b8 18 00 00 00       	mov    $0x18,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <getgid>:
SYSCALL(getgid)
 582:	b8 19 00 00 00       	mov    $0x19,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <getppid>:
SYSCALL(getppid)
 58a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <setuid>:
SYSCALL(setuid)
 592:	b8 1b 00 00 00       	mov    $0x1b,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <setgid>:
SYSCALL(setgid)
 59a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <getprocs>:
SYSCALL(getprocs)
 5a2:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5aa:	55                   	push   %ebp
 5ab:	89 e5                	mov    %esp,%ebp
 5ad:	83 ec 18             	sub    $0x18,%esp
 5b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 5b3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5b6:	83 ec 04             	sub    $0x4,%esp
 5b9:	6a 01                	push   $0x1
 5bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5be:	50                   	push   %eax
 5bf:	ff 75 08             	pushl  0x8(%ebp)
 5c2:	e8 23 ff ff ff       	call   4ea <write>
 5c7:	83 c4 10             	add    $0x10,%esp
}
 5ca:	90                   	nop
 5cb:	c9                   	leave  
 5cc:	c3                   	ret    

000005cd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5cd:	55                   	push   %ebp
 5ce:	89 e5                	mov    %esp,%ebp
 5d0:	53                   	push   %ebx
 5d1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5db:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5df:	74 17                	je     5f8 <printint+0x2b>
 5e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5e5:	79 11                	jns    5f8 <printint+0x2b>
    neg = 1;
 5e7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 5ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f1:	f7 d8                	neg    %eax
 5f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5f6:	eb 06                	jmp    5fe <printint+0x31>
  } else {
    x = xx;
 5f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 5fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 605:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 608:	8d 41 01             	lea    0x1(%ecx),%eax
 60b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 60e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 611:	8b 45 ec             	mov    -0x14(%ebp),%eax
 614:	ba 00 00 00 00       	mov    $0x0,%edx
 619:	f7 f3                	div    %ebx
 61b:	89 d0                	mov    %edx,%eax
 61d:	0f b6 80 4c 0d 00 00 	movzbl 0xd4c(%eax),%eax
 624:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 628:	8b 5d 10             	mov    0x10(%ebp),%ebx
 62b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 62e:	ba 00 00 00 00       	mov    $0x0,%edx
 633:	f7 f3                	div    %ebx
 635:	89 45 ec             	mov    %eax,-0x14(%ebp)
 638:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 63c:	75 c7                	jne    605 <printint+0x38>
  if(neg)
 63e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 642:	74 2d                	je     671 <printint+0xa4>
    buf[i++] = '-';
 644:	8b 45 f4             	mov    -0xc(%ebp),%eax
 647:	8d 50 01             	lea    0x1(%eax),%edx
 64a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 64d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 652:	eb 1d                	jmp    671 <printint+0xa4>
    putc(fd, buf[i]);
 654:	8d 55 dc             	lea    -0x24(%ebp),%edx
 657:	8b 45 f4             	mov    -0xc(%ebp),%eax
 65a:	01 d0                	add    %edx,%eax
 65c:	0f b6 00             	movzbl (%eax),%eax
 65f:	0f be c0             	movsbl %al,%eax
 662:	83 ec 08             	sub    $0x8,%esp
 665:	50                   	push   %eax
 666:	ff 75 08             	pushl  0x8(%ebp)
 669:	e8 3c ff ff ff       	call   5aa <putc>
 66e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 671:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 675:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 679:	79 d9                	jns    654 <printint+0x87>
    putc(fd, buf[i]);
}
 67b:	90                   	nop
 67c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 67f:	c9                   	leave  
 680:	c3                   	ret    

00000681 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 681:	55                   	push   %ebp
 682:	89 e5                	mov    %esp,%ebp
 684:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 687:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 68e:	8d 45 0c             	lea    0xc(%ebp),%eax
 691:	83 c0 04             	add    $0x4,%eax
 694:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 697:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 69e:	e9 59 01 00 00       	jmp    7fc <printf+0x17b>
    c = fmt[i] & 0xff;
 6a3:	8b 55 0c             	mov    0xc(%ebp),%edx
 6a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6a9:	01 d0                	add    %edx,%eax
 6ab:	0f b6 00             	movzbl (%eax),%eax
 6ae:	0f be c0             	movsbl %al,%eax
 6b1:	25 ff 00 00 00       	and    $0xff,%eax
 6b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6bd:	75 2c                	jne    6eb <printf+0x6a>
      if(c == '%'){
 6bf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6c3:	75 0c                	jne    6d1 <printf+0x50>
        state = '%';
 6c5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6cc:	e9 27 01 00 00       	jmp    7f8 <printf+0x177>
      } else {
        putc(fd, c);
 6d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d4:	0f be c0             	movsbl %al,%eax
 6d7:	83 ec 08             	sub    $0x8,%esp
 6da:	50                   	push   %eax
 6db:	ff 75 08             	pushl  0x8(%ebp)
 6de:	e8 c7 fe ff ff       	call   5aa <putc>
 6e3:	83 c4 10             	add    $0x10,%esp
 6e6:	e9 0d 01 00 00       	jmp    7f8 <printf+0x177>
      }
    } else if(state == '%'){
 6eb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 6ef:	0f 85 03 01 00 00    	jne    7f8 <printf+0x177>
      if(c == 'd'){
 6f5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6f9:	75 1e                	jne    719 <printf+0x98>
        printint(fd, *ap, 10, 1);
 6fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6fe:	8b 00                	mov    (%eax),%eax
 700:	6a 01                	push   $0x1
 702:	6a 0a                	push   $0xa
 704:	50                   	push   %eax
 705:	ff 75 08             	pushl  0x8(%ebp)
 708:	e8 c0 fe ff ff       	call   5cd <printint>
 70d:	83 c4 10             	add    $0x10,%esp
        ap++;
 710:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 714:	e9 d8 00 00 00       	jmp    7f1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 719:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 71d:	74 06                	je     725 <printf+0xa4>
 71f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 723:	75 1e                	jne    743 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 725:	8b 45 e8             	mov    -0x18(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	6a 00                	push   $0x0
 72c:	6a 10                	push   $0x10
 72e:	50                   	push   %eax
 72f:	ff 75 08             	pushl  0x8(%ebp)
 732:	e8 96 fe ff ff       	call   5cd <printint>
 737:	83 c4 10             	add    $0x10,%esp
        ap++;
 73a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73e:	e9 ae 00 00 00       	jmp    7f1 <printf+0x170>
      } else if(c == 's'){
 743:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 747:	75 43                	jne    78c <printf+0x10b>
        s = (char*)*ap;
 749:	8b 45 e8             	mov    -0x18(%ebp),%eax
 74c:	8b 00                	mov    (%eax),%eax
 74e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 751:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 755:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 759:	75 25                	jne    780 <printf+0xff>
          s = "(null)";
 75b:	c7 45 f4 b9 0a 00 00 	movl   $0xab9,-0xc(%ebp)
        while(*s != 0){
 762:	eb 1c                	jmp    780 <printf+0xff>
          putc(fd, *s);
 764:	8b 45 f4             	mov    -0xc(%ebp),%eax
 767:	0f b6 00             	movzbl (%eax),%eax
 76a:	0f be c0             	movsbl %al,%eax
 76d:	83 ec 08             	sub    $0x8,%esp
 770:	50                   	push   %eax
 771:	ff 75 08             	pushl  0x8(%ebp)
 774:	e8 31 fe ff ff       	call   5aa <putc>
 779:	83 c4 10             	add    $0x10,%esp
          s++;
 77c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	0f b6 00             	movzbl (%eax),%eax
 786:	84 c0                	test   %al,%al
 788:	75 da                	jne    764 <printf+0xe3>
 78a:	eb 65                	jmp    7f1 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 78c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 790:	75 1d                	jne    7af <printf+0x12e>
        putc(fd, *ap);
 792:	8b 45 e8             	mov    -0x18(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	0f be c0             	movsbl %al,%eax
 79a:	83 ec 08             	sub    $0x8,%esp
 79d:	50                   	push   %eax
 79e:	ff 75 08             	pushl  0x8(%ebp)
 7a1:	e8 04 fe ff ff       	call   5aa <putc>
 7a6:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7ad:	eb 42                	jmp    7f1 <printf+0x170>
      } else if(c == '%'){
 7af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7b3:	75 17                	jne    7cc <printf+0x14b>
        putc(fd, c);
 7b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b8:	0f be c0             	movsbl %al,%eax
 7bb:	83 ec 08             	sub    $0x8,%esp
 7be:	50                   	push   %eax
 7bf:	ff 75 08             	pushl  0x8(%ebp)
 7c2:	e8 e3 fd ff ff       	call   5aa <putc>
 7c7:	83 c4 10             	add    $0x10,%esp
 7ca:	eb 25                	jmp    7f1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7cc:	83 ec 08             	sub    $0x8,%esp
 7cf:	6a 25                	push   $0x25
 7d1:	ff 75 08             	pushl  0x8(%ebp)
 7d4:	e8 d1 fd ff ff       	call   5aa <putc>
 7d9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7df:	0f be c0             	movsbl %al,%eax
 7e2:	83 ec 08             	sub    $0x8,%esp
 7e5:	50                   	push   %eax
 7e6:	ff 75 08             	pushl  0x8(%ebp)
 7e9:	e8 bc fd ff ff       	call   5aa <putc>
 7ee:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 7f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7fc:	8b 55 0c             	mov    0xc(%ebp),%edx
 7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 802:	01 d0                	add    %edx,%eax
 804:	0f b6 00             	movzbl (%eax),%eax
 807:	84 c0                	test   %al,%al
 809:	0f 85 94 fe ff ff    	jne    6a3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 80f:	90                   	nop
 810:	c9                   	leave  
 811:	c3                   	ret    

00000812 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 812:	55                   	push   %ebp
 813:	89 e5                	mov    %esp,%ebp
 815:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 818:	8b 45 08             	mov    0x8(%ebp),%eax
 81b:	83 e8 08             	sub    $0x8,%eax
 81e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 821:	a1 68 0d 00 00       	mov    0xd68,%eax
 826:	89 45 fc             	mov    %eax,-0x4(%ebp)
 829:	eb 24                	jmp    84f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82e:	8b 00                	mov    (%eax),%eax
 830:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 833:	77 12                	ja     847 <free+0x35>
 835:	8b 45 f8             	mov    -0x8(%ebp),%eax
 838:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 83b:	77 24                	ja     861 <free+0x4f>
 83d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 840:	8b 00                	mov    (%eax),%eax
 842:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 845:	77 1a                	ja     861 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 847:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84a:	8b 00                	mov    (%eax),%eax
 84c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 84f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 852:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 855:	76 d4                	jbe    82b <free+0x19>
 857:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85a:	8b 00                	mov    (%eax),%eax
 85c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 85f:	76 ca                	jbe    82b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 861:	8b 45 f8             	mov    -0x8(%ebp),%eax
 864:	8b 40 04             	mov    0x4(%eax),%eax
 867:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 86e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 871:	01 c2                	add    %eax,%edx
 873:	8b 45 fc             	mov    -0x4(%ebp),%eax
 876:	8b 00                	mov    (%eax),%eax
 878:	39 c2                	cmp    %eax,%edx
 87a:	75 24                	jne    8a0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 87c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87f:	8b 50 04             	mov    0x4(%eax),%edx
 882:	8b 45 fc             	mov    -0x4(%ebp),%eax
 885:	8b 00                	mov    (%eax),%eax
 887:	8b 40 04             	mov    0x4(%eax),%eax
 88a:	01 c2                	add    %eax,%edx
 88c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	8b 10                	mov    (%eax),%edx
 899:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89c:	89 10                	mov    %edx,(%eax)
 89e:	eb 0a                	jmp    8aa <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a3:	8b 10                	mov    (%eax),%edx
 8a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ad:	8b 40 04             	mov    0x4(%eax),%eax
 8b0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ba:	01 d0                	add    %edx,%eax
 8bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8bf:	75 20                	jne    8e1 <free+0xcf>
    p->s.size += bp->s.size;
 8c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c4:	8b 50 04             	mov    0x4(%eax),%edx
 8c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ca:	8b 40 04             	mov    0x4(%eax),%eax
 8cd:	01 c2                	add    %eax,%edx
 8cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d8:	8b 10                	mov    (%eax),%edx
 8da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8dd:	89 10                	mov    %edx,(%eax)
 8df:	eb 08                	jmp    8e9 <free+0xd7>
  } else
    p->s.ptr = bp;
 8e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8e7:	89 10                	mov    %edx,(%eax)
  freep = p;
 8e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ec:	a3 68 0d 00 00       	mov    %eax,0xd68
}
 8f1:	90                   	nop
 8f2:	c9                   	leave  
 8f3:	c3                   	ret    

000008f4 <morecore>:

static Header*
morecore(uint nu)
{
 8f4:	55                   	push   %ebp
 8f5:	89 e5                	mov    %esp,%ebp
 8f7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8fa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 901:	77 07                	ja     90a <morecore+0x16>
    nu = 4096;
 903:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 90a:	8b 45 08             	mov    0x8(%ebp),%eax
 90d:	c1 e0 03             	shl    $0x3,%eax
 910:	83 ec 0c             	sub    $0xc,%esp
 913:	50                   	push   %eax
 914:	e8 39 fc ff ff       	call   552 <sbrk>
 919:	83 c4 10             	add    $0x10,%esp
 91c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 91f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 923:	75 07                	jne    92c <morecore+0x38>
    return 0;
 925:	b8 00 00 00 00       	mov    $0x0,%eax
 92a:	eb 26                	jmp    952 <morecore+0x5e>
  hp = (Header*)p;
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 932:	8b 45 f0             	mov    -0x10(%ebp),%eax
 935:	8b 55 08             	mov    0x8(%ebp),%edx
 938:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 93b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93e:	83 c0 08             	add    $0x8,%eax
 941:	83 ec 0c             	sub    $0xc,%esp
 944:	50                   	push   %eax
 945:	e8 c8 fe ff ff       	call   812 <free>
 94a:	83 c4 10             	add    $0x10,%esp
  return freep;
 94d:	a1 68 0d 00 00       	mov    0xd68,%eax
}
 952:	c9                   	leave  
 953:	c3                   	ret    

00000954 <malloc>:

void*
malloc(uint nbytes)
{
 954:	55                   	push   %ebp
 955:	89 e5                	mov    %esp,%ebp
 957:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 95a:	8b 45 08             	mov    0x8(%ebp),%eax
 95d:	83 c0 07             	add    $0x7,%eax
 960:	c1 e8 03             	shr    $0x3,%eax
 963:	83 c0 01             	add    $0x1,%eax
 966:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 969:	a1 68 0d 00 00       	mov    0xd68,%eax
 96e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 971:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 975:	75 23                	jne    99a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 977:	c7 45 f0 60 0d 00 00 	movl   $0xd60,-0x10(%ebp)
 97e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 981:	a3 68 0d 00 00       	mov    %eax,0xd68
 986:	a1 68 0d 00 00       	mov    0xd68,%eax
 98b:	a3 60 0d 00 00       	mov    %eax,0xd60
    base.s.size = 0;
 990:	c7 05 64 0d 00 00 00 	movl   $0x0,0xd64
 997:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99d:	8b 00                	mov    (%eax),%eax
 99f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a5:	8b 40 04             	mov    0x4(%eax),%eax
 9a8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9ab:	72 4d                	jb     9fa <malloc+0xa6>
      if(p->s.size == nunits)
 9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b0:	8b 40 04             	mov    0x4(%eax),%eax
 9b3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9b6:	75 0c                	jne    9c4 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bb:	8b 10                	mov    (%eax),%edx
 9bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c0:	89 10                	mov    %edx,(%eax)
 9c2:	eb 26                	jmp    9ea <malloc+0x96>
      else {
        p->s.size -= nunits;
 9c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c7:	8b 40 04             	mov    0x4(%eax),%eax
 9ca:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9cd:	89 c2                	mov    %eax,%edx
 9cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d8:	8b 40 04             	mov    0x4(%eax),%eax
 9db:	c1 e0 03             	shl    $0x3,%eax
 9de:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9e7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ed:	a3 68 0d 00 00       	mov    %eax,0xd68
      return (void*)(p + 1);
 9f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f5:	83 c0 08             	add    $0x8,%eax
 9f8:	eb 3b                	jmp    a35 <malloc+0xe1>
    }
    if(p == freep)
 9fa:	a1 68 0d 00 00       	mov    0xd68,%eax
 9ff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a02:	75 1e                	jne    a22 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a04:	83 ec 0c             	sub    $0xc,%esp
 a07:	ff 75 ec             	pushl  -0x14(%ebp)
 a0a:	e8 e5 fe ff ff       	call   8f4 <morecore>
 a0f:	83 c4 10             	add    $0x10,%esp
 a12:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a19:	75 07                	jne    a22 <malloc+0xce>
        return 0;
 a1b:	b8 00 00 00 00       	mov    $0x0,%eax
 a20:	eb 13                	jmp    a35 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a25:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2b:	8b 00                	mov    (%eax),%eax
 a2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a30:	e9 6d ff ff ff       	jmp    9a2 <malloc+0x4e>
}
 a35:	c9                   	leave  
 a36:	c3                   	ret    
