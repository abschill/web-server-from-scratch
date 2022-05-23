	.text
	.file	"server.c"
	.globl	sigchld_handler                 # -- Begin function sigchld_handler
	.p2align	4, 0x90
	.type	sigchld_handler,@function
sigchld_handler:                        # @sigchld_handler
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	callq	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, -8(%rbp)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	$4294967295, %edi               # imm = 0xFFFFFFFF
	xorl	%eax, %eax
	movl	%eax, %esi
	movl	$1, %edx
	callq	waitpid@PLT
	cmpl	$0, %eax
	jle	.LBB0_3
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_1
.LBB0_3:
	movl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)                 # 4-byte Spill
	callq	__errno_location@PLT
	movl	-12(%rbp), %ecx                 # 4-byte Reload
	movl	%ecx, (%rax)
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	sigchld_handler, .Lfunc_end0-sigchld_handler
	.cfi_endproc
                                        # -- End function
	.globl	get_home_content                # -- Begin function get_home_content
	.p2align	4, 0x90
	.type	get_home_content,@function
get_home_content:                       # @get_home_content
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	.L.str(%rip), %rdi
	leaq	.L.str.1(%rip), %rsi
	callq	fopen@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB1_4
# %bb.1:
	movq	-24(%rbp), %rdi
	xorl	%eax, %eax
	movl	%eax, %esi
	movl	$2, %edx
	callq	fseek@PLT
	movq	-24(%rbp), %rdi
	callq	ftell@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, fsize(%rip)
	movq	-24(%rbp), %rdi
	xorl	%eax, %eax
	movl	%eax, %esi
	xorl	%edx, %edx
	callq	fseek@PLT
	movq	-16(%rbp), %rdi
	callq	malloc@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB1_3
# %bb.2:
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movl	$1, %esi
	callq	fread@PLT
.LBB1_3:
	movq	-24(%rbp), %rdi
	callq	fclose@PLT
.LBB1_4:
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	get_home_content, .Lfunc_end1-get_home_content
	.cfi_endproc
                                        # -- End function
	.globl	get_in_addr                     # -- Begin function get_in_addr
	.p2align	4, 0x90
	.type	get_in_addr,@function
get_in_addr:                            # @get_in_addr
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rax
	movzwl	(%rax), %eax
	cmpl	$2, %eax
	jne	.LBB2_2
# %bb.1:
	movq	-16(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB2_3
.LBB2_2:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -8(%rbp)
.LBB2_3:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	get_in_addr, .Lfunc_end2-get_in_addr
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$448, %rsp                      # imm = 0x1C0
	movl	$0, -4(%rbp)
	movl	$1, -420(%rbp)
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	movl	$48, %edx
	callq	memset@PLT
	movl	$0, -60(%rbp)
	movl	$1, -56(%rbp)
	movl	$1, -64(%rbp)
	xorl	%eax, %eax
	movl	%eax, %edi
	leaq	.L.str.2(%rip), %rsi
	leaq	-64(%rbp), %rdx
	leaq	-72(%rbp), %rcx
	callq	getaddrinfo@PLT
	movl	%eax, -424(%rbp)
	cmpl	$0, %eax
	je	.LBB3_2
# %bb.1:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -440(%rbp)                # 8-byte Spill
	movl	-424(%rbp), %edi
	callq	gai_strerror@PLT
	movq	-440(%rbp), %rdi                # 8-byte Reload
	movq	%rax, %rdx
	leaq	.L.str.3(%rip), %rsi
	movb	$0, %al
	callq	fprintf@PLT
	movl	$1, %eax
	addq	$448, %rsp                      # imm = 0x1C0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB3_2:
	.cfi_def_cfa %rbp, 16
	movq	-72(%rbp), %rax
	movq	%rax, -80(%rbp)
.LBB3_3:                                # =>This Inner Loop Header: Depth=1
	cmpq	$0, -80(%rbp)
	je	.LBB3_12
# %bb.4:                                #   in Loop: Header=BB3_3 Depth=1
	movq	-80(%rbp), %rax
	movl	4(%rax), %edi
	movq	-80(%rbp), %rax
	movl	8(%rax), %esi
	movq	-80(%rbp), %rax
	movl	12(%rax), %edx
	callq	socket@PLT
	movl	%eax, -8(%rbp)
	cmpl	$-1, %eax
	jne	.LBB3_6
# %bb.5:                                #   in Loop: Header=BB3_3 Depth=1
	leaq	.L.str.4(%rip), %rdi
	callq	perror@PLT
	jmp	.LBB3_11
.LBB3_6:                                #   in Loop: Header=BB3_3 Depth=1
	movl	-8(%rbp), %edi
	leaq	-420(%rbp), %rcx
	movl	$1, %esi
	movl	$2, %edx
	movl	$4, %r8d
	callq	setsockopt@PLT
	cmpl	$-1, %eax
	jne	.LBB3_8
# %bb.7:
	leaq	.L.str.5(%rip), %rdi
	callq	perror@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB3_8:                                #   in Loop: Header=BB3_3 Depth=1
	movl	-8(%rbp), %edi
	movq	-80(%rbp), %rax
	movq	24(%rax), %rsi
	movq	-80(%rbp), %rax
	movl	16(%rax), %edx
	callq	bind@PLT
	cmpl	$-1, %eax
	jne	.LBB3_10
# %bb.9:                                #   in Loop: Header=BB3_3 Depth=1
	movl	-8(%rbp), %edi
	callq	close@PLT
	leaq	.L.str.6(%rip), %rdi
	callq	perror@PLT
	jmp	.LBB3_11
.LBB3_10:
	jmp	.LBB3_12
.LBB3_11:                               #   in Loop: Header=BB3_3 Depth=1
	movq	-80(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, -80(%rbp)
	jmp	.LBB3_3
.LBB3_12:
	movq	-72(%rbp), %rdi
	callq	freeaddrinfo@PLT
	cmpq	$0, -80(%rbp)
	jne	.LBB3_14
# %bb.13:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	.L.str.7(%rip), %rsi
	movb	$0, %al
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB3_14:
	movl	-8(%rbp), %edi
	movl	$10, %esi
	callq	listen@PLT
	cmpl	$-1, %eax
	jne	.LBB3_16
# %bb.15:
	leaq	.L.str.8(%rip), %rdi
	callq	perror@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB3_16:
	leaq	sigchld_handler(%rip), %rax
	movq	%rax, -368(%rbp)
	leaq	-368(%rbp), %rdi
	addq	$8, %rdi
	callq	sigemptyset@PLT
	movl	$268435456, -232(%rbp)          # imm = 0x10000000
	movl	$17, %edi
	leaq	-368(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	sigaction@PLT
	cmpl	$-1, %eax
	jne	.LBB3_18
# %bb.17:
	leaq	.L.str.9(%rip), %rdi
	callq	perror@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB3_18:
	leaq	.L.str.10(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
.LBB3_19:                               # =>This Inner Loop Header: Depth=1
	movl	$128, -212(%rbp)
	movl	-8(%rbp), %edi
	leaq	-208(%rbp), %rsi
	leaq	-212(%rbp), %rdx
	callq	accept@PLT
	movl	%eax, -12(%rbp)
	cmpl	$-1, -12(%rbp)
	jne	.LBB3_21
# %bb.20:                               #   in Loop: Header=BB3_19 Depth=1
	leaq	.L.str.11(%rip), %rdi
	callq	perror@PLT
	jmp	.LBB3_19
.LBB3_21:                               #   in Loop: Header=BB3_19 Depth=1
	movzwl	-208(%rbp), %eax
	movl	%eax, -444(%rbp)                # 4-byte Spill
	leaq	-208(%rbp), %rdi
	callq	get_in_addr
	movl	-444(%rbp), %edi                # 4-byte Reload
	movq	%rax, %rsi
	leaq	-416(%rbp), %rdx
	movl	$46, %ecx
	callq	inet_ntop@PLT
	leaq	-416(%rbp), %rsi
	leaq	.L.str.12(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	callq	get_home_content
	movq	%rax, -432(%rbp)
	callq	fork@PLT
	cmpl	$0, %eax
	jne	.LBB3_25
# %bb.22:
	movl	-8(%rbp), %edi
	callq	close@PLT
	movl	-12(%rbp), %edi
	movq	-432(%rbp), %rsi
	movq	fsize(%rip), %rdx
	movl	$2048, %ecx                     # imm = 0x800
	callq	send@PLT
	cmpq	$-1, %rax
	jne	.LBB3_24
# %bb.23:
	leaq	.L.str.13(%rip), %rdi
	callq	perror@PLT
.LBB3_24:
	movl	-12(%rbp), %edi
	callq	close@PLT
	xorl	%edi, %edi
	callq	exit@PLT
.LBB3_25:                               #   in Loop: Header=BB3_19 Depth=1
	movq	-432(%rbp), %rdi
	callq	free@PLT
	movl	-12(%rbp), %edi
	callq	close@PLT
	jmp	.LBB3_19
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function
	.type	fsize,@object                   # @fsize
	.data
	.globl	fsize
	.p2align	3
fsize:
	.quad	580                             # 0x244
	.size	fsize, 8

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"index.html"
	.size	.L.str, 11

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"r"
	.size	.L.str.1, 2

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"3000"
	.size	.L.str.2, 5

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"getaddrinfo: %s\n"
	.size	.L.str.3, 17

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"server: socket"
	.size	.L.str.4, 15

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"setsockopt"
	.size	.L.str.5, 11

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"server: bind"
	.size	.L.str.6, 13

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"server: failed to bind\n"
	.size	.L.str.7, 24

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"listen"
	.size	.L.str.8, 7

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"sigaction"
	.size	.L.str.9, 10

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"http server: waiting for connections on 3000...\n"
	.size	.L.str.10, 49

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"accept"
	.size	.L.str.11, 7

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"server: got connection from %s\n"
	.size	.L.str.12, 32

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"error sending tcp socket msg"
	.size	.L.str.13, 29

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym sigchld_handler
	.addrsig_sym __errno_location
	.addrsig_sym waitpid
	.addrsig_sym get_home_content
	.addrsig_sym fopen
	.addrsig_sym fseek
	.addrsig_sym ftell
	.addrsig_sym malloc
	.addrsig_sym fread
	.addrsig_sym fclose
	.addrsig_sym get_in_addr
	.addrsig_sym getaddrinfo
	.addrsig_sym fprintf
	.addrsig_sym gai_strerror
	.addrsig_sym socket
	.addrsig_sym perror
	.addrsig_sym setsockopt
	.addrsig_sym exit
	.addrsig_sym bind
	.addrsig_sym close
	.addrsig_sym freeaddrinfo
	.addrsig_sym listen
	.addrsig_sym sigemptyset
	.addrsig_sym sigaction
	.addrsig_sym printf
	.addrsig_sym accept
	.addrsig_sym inet_ntop
	.addrsig_sym fork
	.addrsig_sym send
	.addrsig_sym free
	.addrsig_sym fsize
	.addrsig_sym stderr
