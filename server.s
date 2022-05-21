	.file	"server.c"
	.text
	.globl	sigchld_handler
	.type	sigchld_handler, @function
sigchld_handler:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	nop
.L2:
	movl	$1, %edx
	movl	$0, %esi
	movl	$-1, %edi
	call	waitpid@PLT
	testl	%eax, %eax
	jg	.L2
	call	__errno_location@PLT
	movl	-4(%rbp), %edx
	movl	%edx, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sigchld_handler, .-sigchld_handler
	.section	.rodata
.LC0:
	.string	"rb"
.LC1:
	.string	"index.html"
	.text
	.globl	get_home_content
	.type	get_home_content, @function
get_home_content:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	$0, -24(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L4
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	ftell@PLT
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L5
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread@PLT
.L5:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
.L4:
	cmpq	$0, -24(%rbp)
	je	.L7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L7:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	get_home_content, .-get_home_content
	.globl	get_in_addr
	.type	get_in_addr, @function
get_in_addr:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movzwl	(%rax), %eax
	cmpw	$2, %ax
	jne	.L9
	movq	-8(%rbp), %rax
	addq	$4, %rax
	jmp	.L10
.L9:
	movq	-8(%rbp), %rax
	addq	$8, %rax
.L10:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	get_in_addr, .-get_in_addr
	.section	.rodata
.LC2:
	.string	"3000"
.LC3:
	.string	"getaddrinfo: %s\n"
.LC4:
	.string	"server: socket"
.LC5:
	.string	"setsockopt"
.LC6:
	.string	"server: bind"
.LC7:
	.string	"server: failed to bind\n"
.LC8:
	.string	"listen"
.LC9:
	.string	"sigaction"
	.align 8
.LC10:
	.string	"server: waiting for connections..."
.LC11:
	.string	"accept"
	.align 8
.LC12:
	.string	"server: got connection from %s\n"
.LC13:
	.string	"HTTP/1.1 200 OK\r\n"
.LC14:
	.string	"send"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$448, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1, -432(%rbp)
	leaq	-400(%rbp), %rax
	movl	$48, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movl	$0, -396(%rbp)
	movl	$1, -392(%rbp)
	movl	$1, -400(%rbp)
	movl	$0, %eax
	call	get_home_content
	leaq	-416(%rbp), %rdx
	leaq	-400(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	getaddrinfo@PLT
	movl	%eax, -424(%rbp)
	cmpl	$0, -424(%rbp)
	je	.L12
	movl	-424(%rbp), %eax
	movl	%eax, %edi
	call	gai_strerror@PLT
	movq	%rax, %rdx
	movq	stderr(%rip), %rax
	leaq	.LC3(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L29
	jmp	.L30
.L12:
	movq	-416(%rbp), %rax
	movq	%rax, -408(%rbp)
	jmp	.L14
.L20:
	movq	-408(%rbp), %rax
	movl	12(%rax), %edx
	movq	-408(%rbp), %rax
	movl	8(%rax), %ecx
	movq	-408(%rbp), %rax
	movl	4(%rax), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	socket@PLT
	movl	%eax, -428(%rbp)
	cmpl	$-1, -428(%rbp)
	jne	.L15
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L16
.L15:
	leaq	-432(%rbp), %rdx
	movl	-428(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt@PLT
	cmpl	$-1, %eax
	jne	.L17
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L17:
	movq	-408(%rbp), %rax
	movl	16(%rax), %edx
	movq	-408(%rbp), %rax
	movq	24(%rax), %rcx
	movl	-428(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	cmpl	$-1, %eax
	jne	.L31
	movl	-428(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	nop
.L16:
	movq	-408(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, -408(%rbp)
.L14:
	cmpq	$0, -408(%rbp)
	jne	.L20
	jmp	.L19
.L31:
	nop
.L19:
	movq	-416(%rbp), %rax
	movq	%rax, %rdi
	call	freeaddrinfo@PLT
	cmpq	$0, -408(%rbp)
	jne	.L21
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$23, %edx
	movl	$1, %esi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L21:
	movl	-428(%rbp), %eax
	movl	$10, %esi
	movl	%eax, %edi
	call	listen@PLT
	cmpl	$-1, %eax
	jne	.L22
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L22:
	leaq	sigchld_handler(%rip), %rax
	movq	%rax, -224(%rbp)
	leaq	-224(%rbp), %rax
	addq	$8, %rax
	movq	%rax, %rdi
	call	sigemptyset@PLT
	movl	$268435456, -88(%rbp)
	leaq	-224(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rsi
	movl	$17, %edi
	call	sigaction@PLT
	cmpl	$-1, %eax
	jne	.L23
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L23:
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L28:
	movl	$128, -436(%rbp)
	leaq	-436(%rbp), %rdx
	leaq	-352(%rbp), %rcx
	movl	-428(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -420(%rbp)
	cmpl	$-1, -420(%rbp)
	jne	.L24
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	jmp	.L25
.L24:
	leaq	-352(%rbp), %rax
	movq	%rax, %rdi
	call	get_in_addr
	movq	%rax, %rsi
	movzwl	-352(%rbp), %eax
	movzwl	%ax, %eax
	leaq	-64(%rbp), %rdx
	movl	$46, %ecx
	movl	%eax, %edi
	call	inet_ntop@PLT
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	call	fork@PLT
	testl	%eax, %eax
	jne	.L26
	movl	-428(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	-420(%rbp), %eax
	movl	$0, %ecx
	movl	$15, %edx
	leaq	.LC13(%rip), %rsi
	movl	%eax, %edi
	call	send@PLT
	cmpq	$-1, %rax
	jne	.L27
	leaq	.LC14(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L27:
	movl	-420(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$0, %edi
	call	exit@PLT
.L26:
	movl	-420(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
.L25:
	jmp	.L28
.L30:
	call	__stack_chk_fail@PLT
.L29:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4: