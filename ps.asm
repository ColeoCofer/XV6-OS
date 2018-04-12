
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  //struct uproc ptable;
  //getprocs(&ptable);
  

  
  exit();
  11:	e8 2a 03 00 00       	call   340 <exit>

00000016 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  16:	55                   	push   %ebp
  17:	89 e5                	mov    %esp,%ebp
  19:	57                   	push   %edi
  1a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1e:	8b 55 10             	mov    0x10(%ebp),%edx
  21:	8b 45 0c             	mov    0xc(%ebp),%eax
  24:	89 cb                	mov    %ecx,%ebx
  26:	89 df                	mov    %ebx,%edi
  28:	89 d1                	mov    %edx,%ecx
  2a:	fc                   	cld    
  2b:	f3 aa                	rep stos %al,%es:(%edi)
  2d:	89 ca                	mov    %ecx,%edx
  2f:	89 fb                	mov    %edi,%ebx
  31:	89 5d 08             	mov    %ebx,0x8(%ebp)
  34:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  37:	90                   	nop
  38:	5b                   	pop    %ebx
  39:	5f                   	pop    %edi
  3a:	5d                   	pop    %ebp
  3b:	c3                   	ret    

0000003c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  3c:	55                   	push   %ebp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  42:	8b 45 08             	mov    0x8(%ebp),%eax
  45:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  48:	90                   	nop
  49:	8b 45 08             	mov    0x8(%ebp),%eax
  4c:	8d 50 01             	lea    0x1(%eax),%edx
  4f:	89 55 08             	mov    %edx,0x8(%ebp)
  52:	8b 55 0c             	mov    0xc(%ebp),%edx
  55:	8d 4a 01             	lea    0x1(%edx),%ecx
  58:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  5b:	0f b6 12             	movzbl (%edx),%edx
  5e:	88 10                	mov    %dl,(%eax)
  60:	0f b6 00             	movzbl (%eax),%eax
  63:	84 c0                	test   %al,%al
  65:	75 e2                	jne    49 <strcpy+0xd>
    ;
  return os;
  67:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  6a:	c9                   	leave  
  6b:	c3                   	ret    

0000006c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  6c:	55                   	push   %ebp
  6d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  6f:	eb 08                	jmp    79 <strcmp+0xd>
    p++, q++;
  71:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  75:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  79:	8b 45 08             	mov    0x8(%ebp),%eax
  7c:	0f b6 00             	movzbl (%eax),%eax
  7f:	84 c0                	test   %al,%al
  81:	74 10                	je     93 <strcmp+0x27>
  83:	8b 45 08             	mov    0x8(%ebp),%eax
  86:	0f b6 10             	movzbl (%eax),%edx
  89:	8b 45 0c             	mov    0xc(%ebp),%eax
  8c:	0f b6 00             	movzbl (%eax),%eax
  8f:	38 c2                	cmp    %al,%dl
  91:	74 de                	je     71 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	0f b6 00             	movzbl (%eax),%eax
  99:	0f b6 d0             	movzbl %al,%edx
  9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  9f:	0f b6 00             	movzbl (%eax),%eax
  a2:	0f b6 c0             	movzbl %al,%eax
  a5:	29 c2                	sub    %eax,%edx
  a7:	89 d0                	mov    %edx,%eax
}
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    

000000ab <strlen>:

uint
strlen(char *s)
{
  ab:	55                   	push   %ebp
  ac:	89 e5                	mov    %esp,%ebp
  ae:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  b8:	eb 04                	jmp    be <strlen+0x13>
  ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	01 d0                	add    %edx,%eax
  c6:	0f b6 00             	movzbl (%eax),%eax
  c9:	84 c0                	test   %al,%al
  cb:	75 ed                	jne    ba <strlen+0xf>
    ;
  return n;
  cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d0:	c9                   	leave  
  d1:	c3                   	ret    

000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	55                   	push   %ebp
  d3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  d5:	8b 45 10             	mov    0x10(%ebp),%eax
  d8:	50                   	push   %eax
  d9:	ff 75 0c             	pushl  0xc(%ebp)
  dc:	ff 75 08             	pushl  0x8(%ebp)
  df:	e8 32 ff ff ff       	call   16 <stosb>
  e4:	83 c4 0c             	add    $0xc,%esp
  return dst;
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  ea:	c9                   	leave  
  eb:	c3                   	ret    

000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	83 ec 04             	sub    $0x4,%esp
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
  f8:	eb 14                	jmp    10e <strchr+0x22>
    if(*s == c)
  fa:	8b 45 08             	mov    0x8(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	3a 45 fc             	cmp    -0x4(%ebp),%al
 103:	75 05                	jne    10a <strchr+0x1e>
      return (char*)s;
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	eb 13                	jmp    11d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 10a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	0f b6 00             	movzbl (%eax),%eax
 114:	84 c0                	test   %al,%al
 116:	75 e2                	jne    fa <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 118:	b8 00 00 00 00       	mov    $0x0,%eax
}
 11d:	c9                   	leave  
 11e:	c3                   	ret    

0000011f <gets>:

char*
gets(char *buf, int max)
{
 11f:	55                   	push   %ebp
 120:	89 e5                	mov    %esp,%ebp
 122:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 12c:	eb 42                	jmp    170 <gets+0x51>
    cc = read(0, &c, 1);
 12e:	83 ec 04             	sub    $0x4,%esp
 131:	6a 01                	push   $0x1
 133:	8d 45 ef             	lea    -0x11(%ebp),%eax
 136:	50                   	push   %eax
 137:	6a 00                	push   $0x0
 139:	e8 1a 02 00 00       	call   358 <read>
 13e:	83 c4 10             	add    $0x10,%esp
 141:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 144:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 148:	7e 33                	jle    17d <gets+0x5e>
      break;
    buf[i++] = c;
 14a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 14d:	8d 50 01             	lea    0x1(%eax),%edx
 150:	89 55 f4             	mov    %edx,-0xc(%ebp)
 153:	89 c2                	mov    %eax,%edx
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	01 c2                	add    %eax,%edx
 15a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 15e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 160:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 164:	3c 0a                	cmp    $0xa,%al
 166:	74 16                	je     17e <gets+0x5f>
 168:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 16c:	3c 0d                	cmp    $0xd,%al
 16e:	74 0e                	je     17e <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 170:	8b 45 f4             	mov    -0xc(%ebp),%eax
 173:	83 c0 01             	add    $0x1,%eax
 176:	3b 45 0c             	cmp    0xc(%ebp),%eax
 179:	7c b3                	jl     12e <gets+0xf>
 17b:	eb 01                	jmp    17e <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 17d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 17e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	01 d0                	add    %edx,%eax
 186:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 189:	8b 45 08             	mov    0x8(%ebp),%eax
}
 18c:	c9                   	leave  
 18d:	c3                   	ret    

0000018e <stat>:

int
stat(char *n, struct stat *st)
{
 18e:	55                   	push   %ebp
 18f:	89 e5                	mov    %esp,%ebp
 191:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	83 ec 08             	sub    $0x8,%esp
 197:	6a 00                	push   $0x0
 199:	ff 75 08             	pushl  0x8(%ebp)
 19c:	e8 df 01 00 00       	call   380 <open>
 1a1:	83 c4 10             	add    $0x10,%esp
 1a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ab:	79 07                	jns    1b4 <stat+0x26>
    return -1;
 1ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b2:	eb 25                	jmp    1d9 <stat+0x4b>
  r = fstat(fd, st);
 1b4:	83 ec 08             	sub    $0x8,%esp
 1b7:	ff 75 0c             	pushl  0xc(%ebp)
 1ba:	ff 75 f4             	pushl  -0xc(%ebp)
 1bd:	e8 d6 01 00 00       	call   398 <fstat>
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1c8:	83 ec 0c             	sub    $0xc,%esp
 1cb:	ff 75 f4             	pushl  -0xc(%ebp)
 1ce:	e8 95 01 00 00       	call   368 <close>
 1d3:	83 c4 10             	add    $0x10,%esp
  return r;
 1d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <atoi>:

int
atoi(const char *s)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
 1de:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 1e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 1e8:	eb 04                	jmp    1ee <atoi+0x13>
 1ea:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	0f b6 00             	movzbl (%eax),%eax
 1f4:	3c 20                	cmp    $0x20,%al
 1f6:	74 f2                	je     1ea <atoi+0xf>
  sign = (*s == '-') ? -1 : 1;
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	0f b6 00             	movzbl (%eax),%eax
 1fe:	3c 2d                	cmp    $0x2d,%al
 200:	75 07                	jne    209 <atoi+0x2e>
 202:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 207:	eb 05                	jmp    20e <atoi+0x33>
 209:	b8 01 00 00 00       	mov    $0x1,%eax
 20e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	0f b6 00             	movzbl (%eax),%eax
 217:	3c 2b                	cmp    $0x2b,%al
 219:	74 0a                	je     225 <atoi+0x4a>
 21b:	8b 45 08             	mov    0x8(%ebp),%eax
 21e:	0f b6 00             	movzbl (%eax),%eax
 221:	3c 2d                	cmp    $0x2d,%al
 223:	75 2b                	jne    250 <atoi+0x75>
    s++;
 225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 229:	eb 25                	jmp    250 <atoi+0x75>
    n = n*10 + *s++ - '0';
 22b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 22e:	89 d0                	mov    %edx,%eax
 230:	c1 e0 02             	shl    $0x2,%eax
 233:	01 d0                	add    %edx,%eax
 235:	01 c0                	add    %eax,%eax
 237:	89 c1                	mov    %eax,%ecx
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	8d 50 01             	lea    0x1(%eax),%edx
 23f:	89 55 08             	mov    %edx,0x8(%ebp)
 242:	0f b6 00             	movzbl (%eax),%eax
 245:	0f be c0             	movsbl %al,%eax
 248:	01 c8                	add    %ecx,%eax
 24a:	83 e8 30             	sub    $0x30,%eax
 24d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '9')
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	0f b6 00             	movzbl (%eax),%eax
 256:	3c 2f                	cmp    $0x2f,%al
 258:	7e 0a                	jle    264 <atoi+0x89>
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	3c 39                	cmp    $0x39,%al
 262:	7e c7                	jle    22b <atoi+0x50>
    n = n*10 + *s++ - '0';
  return sign*n;
 264:	8b 45 f8             	mov    -0x8(%ebp),%eax
 267:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    

0000026d <atoo>:

int
atoo(const char *s)
{
 26d:	55                   	push   %ebp
 26e:	89 e5                	mov    %esp,%ebp
 270:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 273:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 27a:	eb 04                	jmp    280 <atoo+0x13>
 27c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	0f b6 00             	movzbl (%eax),%eax
 286:	3c 20                	cmp    $0x20,%al
 288:	74 f2                	je     27c <atoo+0xf>
  sign = (*s == '-') ? -1 : 1;
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	0f b6 00             	movzbl (%eax),%eax
 290:	3c 2d                	cmp    $0x2d,%al
 292:	75 07                	jne    29b <atoo+0x2e>
 294:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 299:	eb 05                	jmp    2a0 <atoo+0x33>
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 00             	movzbl (%eax),%eax
 2a9:	3c 2b                	cmp    $0x2b,%al
 2ab:	74 0a                	je     2b7 <atoo+0x4a>
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	0f b6 00             	movzbl (%eax),%eax
 2b3:	3c 2d                	cmp    $0x2d,%al
 2b5:	75 27                	jne    2de <atoo+0x71>
    s++;
 2b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 2bb:	eb 21                	jmp    2de <atoo+0x71>
    n = n*8 + *s++ - '0';
 2bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c0:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	8d 50 01             	lea    0x1(%eax),%edx
 2cd:	89 55 08             	mov    %edx,0x8(%ebp)
 2d0:	0f b6 00             	movzbl (%eax),%eax
 2d3:	0f be c0             	movsbl %al,%eax
 2d6:	01 c8                	add    %ecx,%eax
 2d8:	83 e8 30             	sub    $0x30,%eax
 2db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  n = 0;
  while (*s == ' ') s++;
  sign = (*s == '-') ? -1 : 1;
  if (*s == '+'  || *s == '-')
    s++;
  while('0' <= *s && *s <= '7')
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
 2e1:	0f b6 00             	movzbl (%eax),%eax
 2e4:	3c 2f                	cmp    $0x2f,%al
 2e6:	7e 0a                	jle    2f2 <atoo+0x85>
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	0f b6 00             	movzbl (%eax),%eax
 2ee:	3c 37                	cmp    $0x37,%al
 2f0:	7e cb                	jle    2bd <atoo+0x50>
    n = n*8 + *s++ - '0';
  return sign*n;
 2f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2f5:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 2f9:	c9                   	leave  
 2fa:	c3                   	ret    

000002fb <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 2fb:	55                   	push   %ebp
 2fc:	89 e5                	mov    %esp,%ebp
 2fe:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 307:	8b 45 0c             	mov    0xc(%ebp),%eax
 30a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30d:	eb 17                	jmp    326 <memmove+0x2b>
    *dst++ = *src++;
 30f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 312:	8d 50 01             	lea    0x1(%eax),%edx
 315:	89 55 fc             	mov    %edx,-0x4(%ebp)
 318:	8b 55 f8             	mov    -0x8(%ebp),%edx
 31b:	8d 4a 01             	lea    0x1(%edx),%ecx
 31e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 321:	0f b6 12             	movzbl (%edx),%edx
 324:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 326:	8b 45 10             	mov    0x10(%ebp),%eax
 329:	8d 50 ff             	lea    -0x1(%eax),%edx
 32c:	89 55 10             	mov    %edx,0x10(%ebp)
 32f:	85 c0                	test   %eax,%eax
 331:	7f dc                	jg     30f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 333:	8b 45 08             	mov    0x8(%ebp),%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 338:	b8 01 00 00 00       	mov    $0x1,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <exit>:
SYSCALL(exit)
 340:	b8 02 00 00 00       	mov    $0x2,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <wait>:
SYSCALL(wait)
 348:	b8 03 00 00 00       	mov    $0x3,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <pipe>:
SYSCALL(pipe)
 350:	b8 04 00 00 00       	mov    $0x4,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <read>:
SYSCALL(read)
 358:	b8 05 00 00 00       	mov    $0x5,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <write>:
SYSCALL(write)
 360:	b8 10 00 00 00       	mov    $0x10,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <close>:
SYSCALL(close)
 368:	b8 15 00 00 00       	mov    $0x15,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <kill>:
SYSCALL(kill)
 370:	b8 06 00 00 00       	mov    $0x6,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exec>:
SYSCALL(exec)
 378:	b8 07 00 00 00       	mov    $0x7,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <open>:
SYSCALL(open)
 380:	b8 0f 00 00 00       	mov    $0xf,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <mknod>:
SYSCALL(mknod)
 388:	b8 11 00 00 00       	mov    $0x11,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <unlink>:
SYSCALL(unlink)
 390:	b8 12 00 00 00       	mov    $0x12,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <fstat>:
SYSCALL(fstat)
 398:	b8 08 00 00 00       	mov    $0x8,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <link>:
SYSCALL(link)
 3a0:	b8 13 00 00 00       	mov    $0x13,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <mkdir>:
SYSCALL(mkdir)
 3a8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <chdir>:
SYSCALL(chdir)
 3b0:	b8 09 00 00 00       	mov    $0x9,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <dup>:
SYSCALL(dup)
 3b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <getpid>:
SYSCALL(getpid)
 3c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sbrk>:
SYSCALL(sbrk)
 3c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <sleep>:
SYSCALL(sleep)
 3d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <uptime>:
SYSCALL(uptime)
 3d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <halt>:
SYSCALL(halt)
 3e0:	b8 16 00 00 00       	mov    $0x16,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <date>:
SYSCALL(date)
 3e8:	b8 17 00 00 00       	mov    $0x17,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <getuid>:
SYSCALL(getuid) 
 3f0:	b8 18 00 00 00       	mov    $0x18,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getgid>:
SYSCALL(getgid)
 3f8:	b8 19 00 00 00       	mov    $0x19,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <getppid>:
SYSCALL(getppid)
 400:	b8 1a 00 00 00       	mov    $0x1a,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <setuid>:
SYSCALL(setuid)
 408:	b8 1b 00 00 00       	mov    $0x1b,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <setgid>:
SYSCALL(setgid)
 410:	b8 1c 00 00 00       	mov    $0x1c,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <getprocs>:
SYSCALL(getprocs)
 418:	b8 1d 00 00 00       	mov    $0x1d,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 18             	sub    $0x18,%esp
 426:	8b 45 0c             	mov    0xc(%ebp),%eax
 429:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 42c:	83 ec 04             	sub    $0x4,%esp
 42f:	6a 01                	push   $0x1
 431:	8d 45 f4             	lea    -0xc(%ebp),%eax
 434:	50                   	push   %eax
 435:	ff 75 08             	pushl  0x8(%ebp)
 438:	e8 23 ff ff ff       	call   360 <write>
 43d:	83 c4 10             	add    $0x10,%esp
}
 440:	90                   	nop
 441:	c9                   	leave  
 442:	c3                   	ret    

00000443 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 443:	55                   	push   %ebp
 444:	89 e5                	mov    %esp,%ebp
 446:	53                   	push   %ebx
 447:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 44a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 451:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 455:	74 17                	je     46e <printint+0x2b>
 457:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 45b:	79 11                	jns    46e <printint+0x2b>
    neg = 1;
 45d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 464:	8b 45 0c             	mov    0xc(%ebp),%eax
 467:	f7 d8                	neg    %eax
 469:	89 45 ec             	mov    %eax,-0x14(%ebp)
 46c:	eb 06                	jmp    474 <printint+0x31>
  } else {
    x = xx;
 46e:	8b 45 0c             	mov    0xc(%ebp),%eax
 471:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 474:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 47b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 47e:	8d 41 01             	lea    0x1(%ecx),%eax
 481:	89 45 f4             	mov    %eax,-0xc(%ebp)
 484:	8b 5d 10             	mov    0x10(%ebp),%ebx
 487:	8b 45 ec             	mov    -0x14(%ebp),%eax
 48a:	ba 00 00 00 00       	mov    $0x0,%edx
 48f:	f7 f3                	div    %ebx
 491:	89 d0                	mov    %edx,%eax
 493:	0f b6 80 1c 0b 00 00 	movzbl 0xb1c(%eax),%eax
 49a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 49e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a4:	ba 00 00 00 00       	mov    $0x0,%edx
 4a9:	f7 f3                	div    %ebx
 4ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b2:	75 c7                	jne    47b <printint+0x38>
  if(neg)
 4b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b8:	74 2d                	je     4e7 <printint+0xa4>
    buf[i++] = '-';
 4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bd:	8d 50 01             	lea    0x1(%eax),%edx
 4c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c8:	eb 1d                	jmp    4e7 <printint+0xa4>
    putc(fd, buf[i]);
 4ca:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d0:	01 d0                	add    %edx,%eax
 4d2:	0f b6 00             	movzbl (%eax),%eax
 4d5:	0f be c0             	movsbl %al,%eax
 4d8:	83 ec 08             	sub    $0x8,%esp
 4db:	50                   	push   %eax
 4dc:	ff 75 08             	pushl  0x8(%ebp)
 4df:	e8 3c ff ff ff       	call   420 <putc>
 4e4:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ef:	79 d9                	jns    4ca <printint+0x87>
    putc(fd, buf[i]);
}
 4f1:	90                   	nop
 4f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f5:	c9                   	leave  
 4f6:	c3                   	ret    

000004f7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f7:	55                   	push   %ebp
 4f8:	89 e5                	mov    %esp,%ebp
 4fa:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 504:	8d 45 0c             	lea    0xc(%ebp),%eax
 507:	83 c0 04             	add    $0x4,%eax
 50a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 50d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 514:	e9 59 01 00 00       	jmp    672 <printf+0x17b>
    c = fmt[i] & 0xff;
 519:	8b 55 0c             	mov    0xc(%ebp),%edx
 51c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51f:	01 d0                	add    %edx,%eax
 521:	0f b6 00             	movzbl (%eax),%eax
 524:	0f be c0             	movsbl %al,%eax
 527:	25 ff 00 00 00       	and    $0xff,%eax
 52c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 52f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 533:	75 2c                	jne    561 <printf+0x6a>
      if(c == '%'){
 535:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 539:	75 0c                	jne    547 <printf+0x50>
        state = '%';
 53b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 542:	e9 27 01 00 00       	jmp    66e <printf+0x177>
      } else {
        putc(fd, c);
 547:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	83 ec 08             	sub    $0x8,%esp
 550:	50                   	push   %eax
 551:	ff 75 08             	pushl  0x8(%ebp)
 554:	e8 c7 fe ff ff       	call   420 <putc>
 559:	83 c4 10             	add    $0x10,%esp
 55c:	e9 0d 01 00 00       	jmp    66e <printf+0x177>
      }
    } else if(state == '%'){
 561:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 565:	0f 85 03 01 00 00    	jne    66e <printf+0x177>
      if(c == 'd'){
 56b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 56f:	75 1e                	jne    58f <printf+0x98>
        printint(fd, *ap, 10, 1);
 571:	8b 45 e8             	mov    -0x18(%ebp),%eax
 574:	8b 00                	mov    (%eax),%eax
 576:	6a 01                	push   $0x1
 578:	6a 0a                	push   $0xa
 57a:	50                   	push   %eax
 57b:	ff 75 08             	pushl  0x8(%ebp)
 57e:	e8 c0 fe ff ff       	call   443 <printint>
 583:	83 c4 10             	add    $0x10,%esp
        ap++;
 586:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58a:	e9 d8 00 00 00       	jmp    667 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 58f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 593:	74 06                	je     59b <printf+0xa4>
 595:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 599:	75 1e                	jne    5b9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 59b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59e:	8b 00                	mov    (%eax),%eax
 5a0:	6a 00                	push   $0x0
 5a2:	6a 10                	push   $0x10
 5a4:	50                   	push   %eax
 5a5:	ff 75 08             	pushl  0x8(%ebp)
 5a8:	e8 96 fe ff ff       	call   443 <printint>
 5ad:	83 c4 10             	add    $0x10,%esp
        ap++;
 5b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b4:	e9 ae 00 00 00       	jmp    667 <printf+0x170>
      } else if(c == 's'){
 5b9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5bd:	75 43                	jne    602 <printf+0x10b>
        s = (char*)*ap;
 5bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c2:	8b 00                	mov    (%eax),%eax
 5c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cf:	75 25                	jne    5f6 <printf+0xff>
          s = "(null)";
 5d1:	c7 45 f4 ad 08 00 00 	movl   $0x8ad,-0xc(%ebp)
        while(*s != 0){
 5d8:	eb 1c                	jmp    5f6 <printf+0xff>
          putc(fd, *s);
 5da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5dd:	0f b6 00             	movzbl (%eax),%eax
 5e0:	0f be c0             	movsbl %al,%eax
 5e3:	83 ec 08             	sub    $0x8,%esp
 5e6:	50                   	push   %eax
 5e7:	ff 75 08             	pushl  0x8(%ebp)
 5ea:	e8 31 fe ff ff       	call   420 <putc>
 5ef:	83 c4 10             	add    $0x10,%esp
          s++;
 5f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f9:	0f b6 00             	movzbl (%eax),%eax
 5fc:	84 c0                	test   %al,%al
 5fe:	75 da                	jne    5da <printf+0xe3>
 600:	eb 65                	jmp    667 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 602:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 606:	75 1d                	jne    625 <printf+0x12e>
        putc(fd, *ap);
 608:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60b:	8b 00                	mov    (%eax),%eax
 60d:	0f be c0             	movsbl %al,%eax
 610:	83 ec 08             	sub    $0x8,%esp
 613:	50                   	push   %eax
 614:	ff 75 08             	pushl  0x8(%ebp)
 617:	e8 04 fe ff ff       	call   420 <putc>
 61c:	83 c4 10             	add    $0x10,%esp
        ap++;
 61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 623:	eb 42                	jmp    667 <printf+0x170>
      } else if(c == '%'){
 625:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 629:	75 17                	jne    642 <printf+0x14b>
        putc(fd, c);
 62b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62e:	0f be c0             	movsbl %al,%eax
 631:	83 ec 08             	sub    $0x8,%esp
 634:	50                   	push   %eax
 635:	ff 75 08             	pushl  0x8(%ebp)
 638:	e8 e3 fd ff ff       	call   420 <putc>
 63d:	83 c4 10             	add    $0x10,%esp
 640:	eb 25                	jmp    667 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 642:	83 ec 08             	sub    $0x8,%esp
 645:	6a 25                	push   $0x25
 647:	ff 75 08             	pushl  0x8(%ebp)
 64a:	e8 d1 fd ff ff       	call   420 <putc>
 64f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 652:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 655:	0f be c0             	movsbl %al,%eax
 658:	83 ec 08             	sub    $0x8,%esp
 65b:	50                   	push   %eax
 65c:	ff 75 08             	pushl  0x8(%ebp)
 65f:	e8 bc fd ff ff       	call   420 <putc>
 664:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 667:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 672:	8b 55 0c             	mov    0xc(%ebp),%edx
 675:	8b 45 f0             	mov    -0x10(%ebp),%eax
 678:	01 d0                	add    %edx,%eax
 67a:	0f b6 00             	movzbl (%eax),%eax
 67d:	84 c0                	test   %al,%al
 67f:	0f 85 94 fe ff ff    	jne    519 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 685:	90                   	nop
 686:	c9                   	leave  
 687:	c3                   	ret    

00000688 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 688:	55                   	push   %ebp
 689:	89 e5                	mov    %esp,%ebp
 68b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	83 e8 08             	sub    $0x8,%eax
 694:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 697:	a1 38 0b 00 00       	mov    0xb38,%eax
 69c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69f:	eb 24                	jmp    6c5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a9:	77 12                	ja     6bd <free+0x35>
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b1:	77 24                	ja     6d7 <free+0x4f>
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	8b 00                	mov    (%eax),%eax
 6b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6bb:	77 1a                	ja     6d7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6cb:	76 d4                	jbe    6a1 <free+0x19>
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 00                	mov    (%eax),%eax
 6d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d5:	76 ca                	jbe    6a1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	8b 40 04             	mov    0x4(%eax),%eax
 6dd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e7:	01 c2                	add    %eax,%edx
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 00                	mov    (%eax),%eax
 6ee:	39 c2                	cmp    %eax,%edx
 6f0:	75 24                	jne    716 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f5:	8b 50 04             	mov    0x4(%eax),%edx
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 00                	mov    (%eax),%eax
 6fd:	8b 40 04             	mov    0x4(%eax),%eax
 700:	01 c2                	add    %eax,%edx
 702:	8b 45 f8             	mov    -0x8(%ebp),%eax
 705:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	8b 00                	mov    (%eax),%eax
 70d:	8b 10                	mov    (%eax),%edx
 70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 712:	89 10                	mov    %edx,(%eax)
 714:	eb 0a                	jmp    720 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 10                	mov    (%eax),%edx
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	8b 40 04             	mov    0x4(%eax),%eax
 726:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	01 d0                	add    %edx,%eax
 732:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 735:	75 20                	jne    757 <free+0xcf>
    p->s.size += bp->s.size;
 737:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73a:	8b 50 04             	mov    0x4(%eax),%edx
 73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 740:	8b 40 04             	mov    0x4(%eax),%eax
 743:	01 c2                	add    %eax,%edx
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	8b 10                	mov    (%eax),%edx
 750:	8b 45 fc             	mov    -0x4(%ebp),%eax
 753:	89 10                	mov    %edx,(%eax)
 755:	eb 08                	jmp    75f <free+0xd7>
  } else
    p->s.ptr = bp;
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 75d:	89 10                	mov    %edx,(%eax)
  freep = p;
 75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 762:	a3 38 0b 00 00       	mov    %eax,0xb38
}
 767:	90                   	nop
 768:	c9                   	leave  
 769:	c3                   	ret    

0000076a <morecore>:

static Header*
morecore(uint nu)
{
 76a:	55                   	push   %ebp
 76b:	89 e5                	mov    %esp,%ebp
 76d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 770:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 777:	77 07                	ja     780 <morecore+0x16>
    nu = 4096;
 779:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 780:	8b 45 08             	mov    0x8(%ebp),%eax
 783:	c1 e0 03             	shl    $0x3,%eax
 786:	83 ec 0c             	sub    $0xc,%esp
 789:	50                   	push   %eax
 78a:	e8 39 fc ff ff       	call   3c8 <sbrk>
 78f:	83 c4 10             	add    $0x10,%esp
 792:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 795:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 799:	75 07                	jne    7a2 <morecore+0x38>
    return 0;
 79b:	b8 00 00 00 00       	mov    $0x0,%eax
 7a0:	eb 26                	jmp    7c8 <morecore+0x5e>
  hp = (Header*)p;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	8b 55 08             	mov    0x8(%ebp),%edx
 7ae:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	83 c0 08             	add    $0x8,%eax
 7b7:	83 ec 0c             	sub    $0xc,%esp
 7ba:	50                   	push   %eax
 7bb:	e8 c8 fe ff ff       	call   688 <free>
 7c0:	83 c4 10             	add    $0x10,%esp
  return freep;
 7c3:	a1 38 0b 00 00       	mov    0xb38,%eax
}
 7c8:	c9                   	leave  
 7c9:	c3                   	ret    

000007ca <malloc>:

void*
malloc(uint nbytes)
{
 7ca:	55                   	push   %ebp
 7cb:	89 e5                	mov    %esp,%ebp
 7cd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d0:	8b 45 08             	mov    0x8(%ebp),%eax
 7d3:	83 c0 07             	add    $0x7,%eax
 7d6:	c1 e8 03             	shr    $0x3,%eax
 7d9:	83 c0 01             	add    $0x1,%eax
 7dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7df:	a1 38 0b 00 00       	mov    0xb38,%eax
 7e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7eb:	75 23                	jne    810 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7ed:	c7 45 f0 30 0b 00 00 	movl   $0xb30,-0x10(%ebp)
 7f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f7:	a3 38 0b 00 00       	mov    %eax,0xb38
 7fc:	a1 38 0b 00 00       	mov    0xb38,%eax
 801:	a3 30 0b 00 00       	mov    %eax,0xb30
    base.s.size = 0;
 806:	c7 05 34 0b 00 00 00 	movl   $0x0,0xb34
 80d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 45 f0             	mov    -0x10(%ebp),%eax
 813:	8b 00                	mov    (%eax),%eax
 815:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 818:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81b:	8b 40 04             	mov    0x4(%eax),%eax
 81e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 821:	72 4d                	jb     870 <malloc+0xa6>
      if(p->s.size == nunits)
 823:	8b 45 f4             	mov    -0xc(%ebp),%eax
 826:	8b 40 04             	mov    0x4(%eax),%eax
 829:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 82c:	75 0c                	jne    83a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 831:	8b 10                	mov    (%eax),%edx
 833:	8b 45 f0             	mov    -0x10(%ebp),%eax
 836:	89 10                	mov    %edx,(%eax)
 838:	eb 26                	jmp    860 <malloc+0x96>
      else {
        p->s.size -= nunits;
 83a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83d:	8b 40 04             	mov    0x4(%eax),%eax
 840:	2b 45 ec             	sub    -0x14(%ebp),%eax
 843:	89 c2                	mov    %eax,%edx
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84e:	8b 40 04             	mov    0x4(%eax),%eax
 851:	c1 e0 03             	shl    $0x3,%eax
 854:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 857:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 85d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 860:	8b 45 f0             	mov    -0x10(%ebp),%eax
 863:	a3 38 0b 00 00       	mov    %eax,0xb38
      return (void*)(p + 1);
 868:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86b:	83 c0 08             	add    $0x8,%eax
 86e:	eb 3b                	jmp    8ab <malloc+0xe1>
    }
    if(p == freep)
 870:	a1 38 0b 00 00       	mov    0xb38,%eax
 875:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 878:	75 1e                	jne    898 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 87a:	83 ec 0c             	sub    $0xc,%esp
 87d:	ff 75 ec             	pushl  -0x14(%ebp)
 880:	e8 e5 fe ff ff       	call   76a <morecore>
 885:	83 c4 10             	add    $0x10,%esp
 888:	89 45 f4             	mov    %eax,-0xc(%ebp)
 88b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88f:	75 07                	jne    898 <malloc+0xce>
        return 0;
 891:	b8 00 00 00 00       	mov    $0x0,%eax
 896:	eb 13                	jmp    8ab <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a1:	8b 00                	mov    (%eax),%eax
 8a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a6:	e9 6d ff ff ff       	jmp    818 <malloc+0x4e>
}
 8ab:	c9                   	leave  
 8ac:	c3                   	ret    
