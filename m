Return-Path: <linux-tip-commits+bounces-4709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1CA7CF9E
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B841656EA
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1C1A08BC;
	Sun,  6 Apr 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4rczCELy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rafsjn5M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776851C5A;
	Sun,  6 Apr 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964386; cv=none; b=V0FzEQSlGE5f3v+94pugEX0uLuKWhceb6vmkO2nXgOocbS71pGPiU9AjsiKmdLwrvewJHEmGAnGFPYD52vzrkx7md1b42/VDLBWcT02ixwoB/WHuiWfEXGcKBXulGgKXfw1NVEaYxuctfSXsEQ75CvcjGnYLoNHEIyw5jivzGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964386; c=relaxed/simple;
	bh=LoukVe85IChN1j67HpCL5pFFjUj+SXLNYllT3iwkSrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I2ws44I4mzk+81dLCaOrGPQxF+9wfesz82HiAIYPY8OFI73mEowb+9u8RY/pDhV5+ZzkBFlR7Ssb66o+3SItehWrJ8zlWuSBV1GhluQHyTJceEveqLHsaykpf9Ur2pTWPy6nlKmlx1NIHGkySDBqCMRkNRuZkQyM9zVSAYGpjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4rczCELy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rafsjn5M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:33:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743964381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCPTo2nXJmAC2PS9ibj0u2zrR/Pqlc5a3/+W5x6xhJw=;
	b=4rczCELywP0xX89JezwC2mk6T9VEDgKeiuwFBPfVm2eFjefWEnf2lf+ImndE9CkCTeKBAM
	2crsfAYSpXvC2UDantXrwxTK77o63MPhZERaPkmltC/iqdwwOBlUsdxEvrdnLJZTV+sNl/
	Eynk51VcwZwUQkc2W7PZlG+XpEHGCeV1XsfOOO6zDC543Ata0XAteLpFpQBCT2iS9a8D/D
	4yjvOJMl7YtjqLzJXFJMpMGBgodpU7SuLj37WG8d+tGvx0HCccI3c+wNsRkhenBsrC5d39
	tyIWTfHGZcPBzqwSA5genvNyoi4pqm5/UzrvgdL9T1yGA7+9XErDtEg/7pqRSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743964381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCPTo2nXJmAC2PS9ibj0u2zrR/Pqlc5a3/+W5x6xhJw=;
	b=Rafsjn5M5dCn5wEmhOJjO2bHQpqu6eb0SoNWuPhGJHcnc0fuJKc9Y4NFVaw4c/l2OuKFA+
	mOCqnUZxS5nN9KDw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Move the EFI mixed mode startup code back
 under arch/x86, into startup/
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401133416.1436741-11-ardb+git@google.com>
References: <20250401133416.1436741-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396438105.31282.2243827952440371468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e
Gitweb:        https://git.kernel.org/tip/4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 01 Apr 2025 15:34:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:15:14 +02:00

x86/boot: Move the EFI mixed mode startup code back under arch/x86, into startup/

Linus expressed a strong preference for arch-specific asm code (i.e.,
virtually all of it) to reside under arch/ rather than anywhere else.

So move the EFI mixed mode startup code back, and put it under
arch/x86/boot/startup/ where all shared x86 startup code is going to
live.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20250401133416.1436741-11-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile           |   3 +-
 arch/x86/boot/startup/efi-mixed.S        | 253 ++++++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile    |   1 +-
 drivers/firmware/efi/libstub/x86-mixed.S | 253 +----------------------
 4 files changed, 256 insertions(+), 254 deletions(-)
 create mode 100644 arch/x86/boot/startup/efi-mixed.S
 delete mode 100644 drivers/firmware/efi/libstub/x86-mixed.S

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 03519ef..73946a3 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
+
 lib-$(CONFIG_X86_64)		+= la57toggle.o
+lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/boot/startup/efi-mixed.S b/arch/x86/boot/startup/efi-mixed.S
new file mode 100644
index 0000000..e04ed99
--- /dev/null
+++ b/arch/x86/boot/startup/efi-mixed.S
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
+ *
+ * Early support for invoking 32-bit EFI services from a 64-bit kernel.
+ *
+ * Because this thunking occurs before ExitBootServices() we have to
+ * restore the firmware's 32-bit GDT and IDT before we make EFI service
+ * calls.
+ *
+ * On the plus side, we don't have to worry about mangling 64-bit
+ * addresses into 32-bits because we're executing with an identity
+ * mapped pagetable and haven't transitioned to 64-bit virtual addresses
+ * yet.
+ */
+
+#include <linux/linkage.h>
+#include <asm/desc_defs.h>
+#include <asm/msr.h>
+#include <asm/page_types.h>
+#include <asm/pgtable_types.h>
+#include <asm/processor-flags.h>
+#include <asm/segment.h>
+
+	.text
+	.code32
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+SYM_FUNC_START(efi32_stub_entry)
+	call	1f
+1:	popl	%ecx
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	(_bss - 1b)(%ecx), %edi
+	leal	(_ebss - 1b)(%ecx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
+	add	$0x4, %esp		/* Discard return address */
+	movl	8(%esp), %ebx		/* struct boot_params pointer */
+	jmp	efi32_startup
+SYM_FUNC_END(efi32_stub_entry)
+#endif
+
+/*
+ * Called using a far call from __efi64_thunk() below, using the x86_64 SysV
+ * ABI (except for R8/R9 which are inaccessible to 32-bit code - EAX/EBX are
+ * used instead).  EBP+16 points to the arguments passed via the stack.
+ *
+ * The first argument (EDI) is a pointer to the boot service or protocol, to
+ * which the remaining arguments are passed, each truncated to 32 bits.
+ */
+SYM_FUNC_START_LOCAL(efi_enter32)
+	/*
+	 * Convert x86-64 SysV ABI params to i386 ABI
+	 */
+	pushl	32(%ebp)	/* Up to 3 args passed via the stack */
+	pushl	24(%ebp)
+	pushl	16(%ebp)
+	pushl	%ebx		/* R9 */
+	pushl	%eax		/* R8 */
+	pushl	%ecx
+	pushl	%edx
+	pushl	%esi
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Disable long mode via EFER */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btrl	$_EFER_LME, %eax
+	wrmsr
+
+	call	*%edi
+
+	/* We must preserve return value */
+	movl	%eax, %edi
+
+	call	efi32_enable_long_mode
+
+	addl	$32, %esp
+	movl	%edi, %eax
+	lret
+SYM_FUNC_END(efi_enter32)
+
+	.code64
+SYM_FUNC_START(__efi64_thunk)
+	push	%rbp
+	movl	%esp, %ebp
+	push	%rbx
+
+	/* Move args #5 and #6 into 32-bit accessible registers */
+	movl	%r8d, %eax
+	movl	%r9d, %ebx
+
+	lcalll	*efi32_call(%rip)
+
+	pop	%rbx
+	pop	%rbp
+	RET
+SYM_FUNC_END(__efi64_thunk)
+
+	.code32
+SYM_FUNC_START_LOCAL(efi32_enable_long_mode)
+	movl	%cr4, %eax
+	btsl	$(X86_CR4_PAE_BIT), %eax
+	movl	%eax, %cr4
+
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	/* Disable interrupts - the firmware's IDT does not work in long mode */
+	cli
+
+	/* Enable paging */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+	ret
+SYM_FUNC_END(efi32_enable_long_mode)
+
+/*
+ * This is the common EFI stub entry point for mixed mode. It sets up the GDT
+ * and page tables needed for 64-bit execution, after which it calls the
+ * common 64-bit EFI entrypoint efi_stub_entry().
+ *
+ * Arguments:	0(%esp)	image handle
+ * 		4(%esp)	EFI system table pointer
+ *		%ebx	struct boot_params pointer (or NULL)
+ *
+ * Since this is the point of no return for ordinary execution, no registers
+ * are considered live except for the function parameters. [Note that the EFI
+ * stub may still exit and return to the firmware using the Exit() EFI boot
+ * service.]
+ */
+SYM_FUNC_START_LOCAL(efi32_startup)
+	movl	%esp, %ebp
+
+	subl	$8, %esp
+	sgdtl	(%esp)			/* Save GDT descriptor to the stack */
+	movl	2(%esp), %esi		/* Existing GDT pointer */
+	movzwl	(%esp), %ecx		/* Existing GDT limit */
+	inc	%ecx			/* Existing GDT size */
+	andl	$~7, %ecx		/* Ensure size is multiple of 8 */
+
+	subl	%ecx, %esp		/* Allocate new GDT */
+	andl	$~15, %esp		/* Realign the stack */
+	movl	%esp, %edi		/* New GDT address */
+	leal	7(%ecx), %eax		/* New GDT limit */
+	pushw	%cx			/* Push 64-bit CS (for LJMP below) */
+	pushl	%edi			/* Push new GDT address */
+	pushw	%ax			/* Push new GDT limit */
+
+	/* Copy GDT to the stack and add a 64-bit code segment at the end */
+	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) & 0xffffffff, (%edi,%ecx)
+	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) >> 32, 4(%edi,%ecx)
+	shrl	$2, %ecx
+	cld
+	rep	movsl			/* Copy the firmware GDT */
+	lgdtl	(%esp)			/* Switch to the new GDT */
+
+	call	1f
+1:	pop	%edi
+
+	/* Record mixed mode entry */
+	movb	$0x0, (efi_is64 - 1b)(%edi)
+
+	/* Set up indirect far call to re-enter 32-bit mode */
+	leal	(efi32_call - 1b)(%edi), %eax
+	addl	%eax, (%eax)
+	movw	%cs, 4(%eax)
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Set up 1:1 mapping */
+	leal	(pte - 1b)(%edi), %eax
+	movl	$_PAGE_PRESENT | _PAGE_RW | _PAGE_PSE, %ecx
+	leal	(_PAGE_PRESENT | _PAGE_RW)(%eax), %edx
+2:	movl	%ecx, (%eax)
+	addl	$8, %eax
+	addl	$PMD_SIZE, %ecx
+	jnc	2b
+
+	movl	$PAGE_SIZE, %ecx
+	.irpc	l, 0123
+	movl	%edx, \l * 8(%eax)
+	addl	%ecx, %edx
+	.endr
+	addl	%ecx, %eax
+	movl	%edx, (%eax)
+	movl	%eax, %cr3
+
+	call	efi32_enable_long_mode
+
+	/* Set up far jump to 64-bit mode (CS is already on the stack) */
+	leal	(efi_stub_entry - 1b)(%edi), %eax
+	movl	%eax, 2(%esp)
+
+	movl	0(%ebp), %edi
+	movl	4(%ebp), %esi
+	movl	%ebx, %edx
+	ljmpl	*2(%esp)
+SYM_FUNC_END(efi32_startup)
+
+/*
+ * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
+ *			       efi_system_table_32_t *sys_table)
+ */
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebx				// save callee-save registers
+
+	/* Check whether the CPU supports long mode */
+	movl	$0x80000001, %eax		// assume extended info support
+	cpuid
+	btl	$29, %edx			// check long mode bit
+	jnc	1f
+	leal	8(%esp), %esp			// preserve stack alignment
+	xor	%ebx, %ebx			// no struct boot_params pointer
+	jmp	efi32_startup			// only ESP and EBX remain live
+1:	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
+	popl	%ebx
+	RET
+SYM_FUNC_END(efi32_pe_entry)
+
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+	.org	efi32_stub_entry + 0x200
+	.code64
+SYM_FUNC_START_NOALIGN(efi64_stub_entry)
+	jmp	efi_handover_entry
+SYM_FUNC_END(efi64_stub_entry)
+#endif
+
+	.data
+	.balign	8
+SYM_DATA_START_LOCAL(efi32_call)
+	.long	efi_enter32 - .
+	.word	0x0
+SYM_DATA_END(efi32_call)
+SYM_DATA(efi_is64, .byte 1)
+
+	.bss
+	.balign PAGE_SIZE
+SYM_DATA_LOCAL(pte, .fill 6 * PAGE_SIZE, 1, 0)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9..2f17339 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -85,7 +85,6 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
-lib-$(CONFIG_EFI_MIXED)		+= x86-mixed.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
diff --git a/drivers/firmware/efi/libstub/x86-mixed.S b/drivers/firmware/efi/libstub/x86-mixed.S
deleted file mode 100644
index e04ed99..0000000
--- a/drivers/firmware/efi/libstub/x86-mixed.S
+++ /dev/null
@@ -1,253 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
- *
- * Early support for invoking 32-bit EFI services from a 64-bit kernel.
- *
- * Because this thunking occurs before ExitBootServices() we have to
- * restore the firmware's 32-bit GDT and IDT before we make EFI service
- * calls.
- *
- * On the plus side, we don't have to worry about mangling 64-bit
- * addresses into 32-bits because we're executing with an identity
- * mapped pagetable and haven't transitioned to 64-bit virtual addresses
- * yet.
- */
-
-#include <linux/linkage.h>
-#include <asm/desc_defs.h>
-#include <asm/msr.h>
-#include <asm/page_types.h>
-#include <asm/pgtable_types.h>
-#include <asm/processor-flags.h>
-#include <asm/segment.h>
-
-	.text
-	.code32
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-SYM_FUNC_START(efi32_stub_entry)
-	call	1f
-1:	popl	%ecx
-
-	/* Clear BSS */
-	xorl	%eax, %eax
-	leal	(_bss - 1b)(%ecx), %edi
-	leal	(_ebss - 1b)(%ecx), %ecx
-	subl	%edi, %ecx
-	shrl	$2, %ecx
-	cld
-	rep	stosl
-
-	add	$0x4, %esp		/* Discard return address */
-	movl	8(%esp), %ebx		/* struct boot_params pointer */
-	jmp	efi32_startup
-SYM_FUNC_END(efi32_stub_entry)
-#endif
-
-/*
- * Called using a far call from __efi64_thunk() below, using the x86_64 SysV
- * ABI (except for R8/R9 which are inaccessible to 32-bit code - EAX/EBX are
- * used instead).  EBP+16 points to the arguments passed via the stack.
- *
- * The first argument (EDI) is a pointer to the boot service or protocol, to
- * which the remaining arguments are passed, each truncated to 32 bits.
- */
-SYM_FUNC_START_LOCAL(efi_enter32)
-	/*
-	 * Convert x86-64 SysV ABI params to i386 ABI
-	 */
-	pushl	32(%ebp)	/* Up to 3 args passed via the stack */
-	pushl	24(%ebp)
-	pushl	16(%ebp)
-	pushl	%ebx		/* R9 */
-	pushl	%eax		/* R8 */
-	pushl	%ecx
-	pushl	%edx
-	pushl	%esi
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Disable long mode via EFER */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btrl	$_EFER_LME, %eax
-	wrmsr
-
-	call	*%edi
-
-	/* We must preserve return value */
-	movl	%eax, %edi
-
-	call	efi32_enable_long_mode
-
-	addl	$32, %esp
-	movl	%edi, %eax
-	lret
-SYM_FUNC_END(efi_enter32)
-
-	.code64
-SYM_FUNC_START(__efi64_thunk)
-	push	%rbp
-	movl	%esp, %ebp
-	push	%rbx
-
-	/* Move args #5 and #6 into 32-bit accessible registers */
-	movl	%r8d, %eax
-	movl	%r9d, %ebx
-
-	lcalll	*efi32_call(%rip)
-
-	pop	%rbx
-	pop	%rbp
-	RET
-SYM_FUNC_END(__efi64_thunk)
-
-	.code32
-SYM_FUNC_START_LOCAL(efi32_enable_long_mode)
-	movl	%cr4, %eax
-	btsl	$(X86_CR4_PAE_BIT), %eax
-	movl	%eax, %cr4
-
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btsl	$_EFER_LME, %eax
-	wrmsr
-
-	/* Disable interrupts - the firmware's IDT does not work in long mode */
-	cli
-
-	/* Enable paging */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-	ret
-SYM_FUNC_END(efi32_enable_long_mode)
-
-/*
- * This is the common EFI stub entry point for mixed mode. It sets up the GDT
- * and page tables needed for 64-bit execution, after which it calls the
- * common 64-bit EFI entrypoint efi_stub_entry().
- *
- * Arguments:	0(%esp)	image handle
- * 		4(%esp)	EFI system table pointer
- *		%ebx	struct boot_params pointer (or NULL)
- *
- * Since this is the point of no return for ordinary execution, no registers
- * are considered live except for the function parameters. [Note that the EFI
- * stub may still exit and return to the firmware using the Exit() EFI boot
- * service.]
- */
-SYM_FUNC_START_LOCAL(efi32_startup)
-	movl	%esp, %ebp
-
-	subl	$8, %esp
-	sgdtl	(%esp)			/* Save GDT descriptor to the stack */
-	movl	2(%esp), %esi		/* Existing GDT pointer */
-	movzwl	(%esp), %ecx		/* Existing GDT limit */
-	inc	%ecx			/* Existing GDT size */
-	andl	$~7, %ecx		/* Ensure size is multiple of 8 */
-
-	subl	%ecx, %esp		/* Allocate new GDT */
-	andl	$~15, %esp		/* Realign the stack */
-	movl	%esp, %edi		/* New GDT address */
-	leal	7(%ecx), %eax		/* New GDT limit */
-	pushw	%cx			/* Push 64-bit CS (for LJMP below) */
-	pushl	%edi			/* Push new GDT address */
-	pushw	%ax			/* Push new GDT limit */
-
-	/* Copy GDT to the stack and add a 64-bit code segment at the end */
-	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) & 0xffffffff, (%edi,%ecx)
-	movl	$GDT_ENTRY(DESC_CODE64, 0, 0xfffff) >> 32, 4(%edi,%ecx)
-	shrl	$2, %ecx
-	cld
-	rep	movsl			/* Copy the firmware GDT */
-	lgdtl	(%esp)			/* Switch to the new GDT */
-
-	call	1f
-1:	pop	%edi
-
-	/* Record mixed mode entry */
-	movb	$0x0, (efi_is64 - 1b)(%edi)
-
-	/* Set up indirect far call to re-enter 32-bit mode */
-	leal	(efi32_call - 1b)(%edi), %eax
-	addl	%eax, (%eax)
-	movw	%cs, 4(%eax)
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Set up 1:1 mapping */
-	leal	(pte - 1b)(%edi), %eax
-	movl	$_PAGE_PRESENT | _PAGE_RW | _PAGE_PSE, %ecx
-	leal	(_PAGE_PRESENT | _PAGE_RW)(%eax), %edx
-2:	movl	%ecx, (%eax)
-	addl	$8, %eax
-	addl	$PMD_SIZE, %ecx
-	jnc	2b
-
-	movl	$PAGE_SIZE, %ecx
-	.irpc	l, 0123
-	movl	%edx, \l * 8(%eax)
-	addl	%ecx, %edx
-	.endr
-	addl	%ecx, %eax
-	movl	%edx, (%eax)
-	movl	%eax, %cr3
-
-	call	efi32_enable_long_mode
-
-	/* Set up far jump to 64-bit mode (CS is already on the stack) */
-	leal	(efi_stub_entry - 1b)(%edi), %eax
-	movl	%eax, 2(%esp)
-
-	movl	0(%ebp), %edi
-	movl	4(%ebp), %esi
-	movl	%ebx, %edx
-	ljmpl	*2(%esp)
-SYM_FUNC_END(efi32_startup)
-
-/*
- * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
- *			       efi_system_table_32_t *sys_table)
- */
-SYM_FUNC_START(efi32_pe_entry)
-	pushl	%ebx				// save callee-save registers
-
-	/* Check whether the CPU supports long mode */
-	movl	$0x80000001, %eax		// assume extended info support
-	cpuid
-	btl	$29, %edx			// check long mode bit
-	jnc	1f
-	leal	8(%esp), %esp			// preserve stack alignment
-	xor	%ebx, %ebx			// no struct boot_params pointer
-	jmp	efi32_startup			// only ESP and EBX remain live
-1:	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	popl	%ebx
-	RET
-SYM_FUNC_END(efi32_pe_entry)
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-	.org	efi32_stub_entry + 0x200
-	.code64
-SYM_FUNC_START_NOALIGN(efi64_stub_entry)
-	jmp	efi_handover_entry
-SYM_FUNC_END(efi64_stub_entry)
-#endif
-
-	.data
-	.balign	8
-SYM_DATA_START_LOCAL(efi32_call)
-	.long	efi_enter32 - .
-	.word	0x0
-SYM_DATA_END(efi32_call)
-SYM_DATA(efi_is64, .byte 1)
-
-	.bss
-	.balign PAGE_SIZE
-SYM_DATA_LOCAL(pte, .fill 6 * PAGE_SIZE, 1, 0)

