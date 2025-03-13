Return-Path: <linux-tip-commits+bounces-4198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADFA5FD9C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0713A37BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E7136347;
	Thu, 13 Mar 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PAeFTM9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DW0uYVby"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BA1519AE;
	Thu, 13 Mar 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886496; cv=none; b=Ln4HpmpkL4ZOx8vNmK2A/EpyHvupJHUBdqW3qGOKYh/miUBWKwf1IqvQ1G/bQ5ucQZGmEolTvhdfFXSZ1txD4v3Oa0bsX6uwRKyWxJFEceIpdybimXU3AEt0oyQXyb4m5yFMkimTTrIOZmBtt9zOh9txQYtZEG17Jd/p/HB8o/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886496; c=relaxed/simple;
	bh=NVCGhAouJUasH/BREpDurMep9hgLHLS0AcQUME+59i8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cuVaoXoS1J5Kw9vH1Jb1qIpiKSmcH9kIbhfi7M3kQS/RFxljW2uLYpdvo1IvlV1RlcmWRk3OoyWK4imgpzjUT8j5RodZrJtTPmXXc3YMKXzi/Xo69+xt/U6cbXwKOzd08Iw9gu2S//k/DVvVM8ktOhcDJJq/GqjVg94+L1+W+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PAeFTM9Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DW0uYVby; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 17:21:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741886492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbaZBsyr9quWomJXj1kMU0PyDKTRBIzlMSWmZq0hROE=;
	b=PAeFTM9Y/tf846jbrRtNHXuwQHXkdNPKeUpdq9s+O0SBxeiydCxMnXY4H4k7aFx7qbLlDR
	43SLjgckuzQ79y0GBhQRoOhKUsyl81fNAquo8jMm0s9Z2UF06CjYvC3oErOiyyLrV+NeWw
	fvF5YowuR/sXhQ9vCHiIhgRyzguMZjFC0o6L6jz9xn+aQ0DQZo6duYdguyWBskQCdZkS58
	Oxz4hbeDl0VCe0pLibdH/P7+ZS9VmaTZcuxImbmzjPK3ciN12K0xY1amr/qPuxp7/RY9up
	CoVmtcA1axofFEY7WZYpo5sb0kD+ExWA9vuQpKemj2PywQdD4qbpQI4BMbkvqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741886492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbaZBsyr9quWomJXj1kMU0PyDKTRBIzlMSWmZq0hROE=;
	b=DW0uYVbyazJXR3vaFMNN5D7lFiaiywSxEcJk+r1mRNFWrVCChQ3ANfGG2KyGkWIZvsUyNn
	sXEbwOqubkRUsJBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move the LA57 trampoline to separate source file
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313120324.1095968-2-ardb+git@google.com>
References: <20250313120324.1095968-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174188649133.14745.9068040012782463635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     e27dffba1b1d6c047b48c325adcb1342d3e3fa69
Gitweb:        https://git.kernel.org/tip/e27dffba1b1d6c047b48c325adcb1342d3e3fa69
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 13 Mar 2025 13:03:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 18:12:38 +01:00

x86/boot: Move the LA57 trampoline to separate source file

To permit the EFI stub to call this code even when building the kernel
without the legacy decompressor, move the trampoline out of the latter's
startup code.

This is part of an ongoing WIP effort on my part to make the existing,
generic EFI zboot format work on x86 as well.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250313120324.1095968-2-ardb+git@google.com
---
 arch/x86/boot/compressed/Makefile     |   1 +-
 arch/x86/boot/compressed/head_64.S    | 103 +-----------------------
 arch/x86/boot/compressed/la57toggle.S | 112 +++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 103 deletions(-)
 create mode 100644 arch/x86/boot/compressed/la57toggle.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 606c74f..0e0b238 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,6 +98,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
+	vmlinux-objs-y += $(obj)/la57toggle.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1dcb794..3dc8635 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -483,110 +483,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-/*
- * This is the 32-bit trampoline that will be copied over to low memory. It
- * will be called using the ordinary 64-bit calling convention from code
- * running in 64-bit mode.
- *
- * Return address is at the top of the stack (might be above 4G).
- * The first argument (EDI) contains the address of the temporary PGD level
- * page table in 32-bit addressable memory which will be programmed into
- * register CR3.
- */
-	.section ".rodata", "a", @progbits
-SYM_CODE_START(trampoline_32bit_src)
-	/*
-	 * Preserve callee save 64-bit registers on the stack: this is
-	 * necessary because the architecture does not guarantee that GPRs will
-	 * retain their full 64-bit values across a 32-bit mode switch.
-	 */
-	pushq	%r15
-	pushq	%r14
-	pushq	%r13
-	pushq	%r12
-	pushq	%rbp
-	pushq	%rbx
-
-	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
-	movq	%rsp, %rbx
-	shrq	$32, %rbx
-
-	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
-	pushq	$__KERNEL32_CS
-	leaq	0f(%rip), %rax
-	pushq	%rax
-	lretq
-
-	/*
-	 * The 32-bit code below will do a far jump back to long mode and end
-	 * up here after reconfiguring the number of paging levels. First, the
-	 * stack pointer needs to be restored to its full 64-bit value before
-	 * the callee save register contents can be popped from the stack.
-	 */
-.Lret:
-	shlq	$32, %rbx
-	orq	%rbx, %rsp
-
-	/* Restore the preserved 64-bit registers */
-	popq	%rbx
-	popq	%rbp
-	popq	%r12
-	popq	%r13
-	popq	%r14
-	popq	%r15
-	retq
-
 	.code32
-0:
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Point CR3 to the trampoline's new top level page table */
-	movl	%edi, %cr3
-
-	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btsl	$_EFER_LME, %eax
-	/* Avoid writing EFER if no change was made (for TDX guest) */
-	jc	1f
-	wrmsr
-1:
-	/* Toggle CR4.LA57 */
-	movl	%cr4, %eax
-	btcl	$X86_CR4_LA57_BIT, %eax
-	movl	%eax, %cr4
-
-	/* Enable paging again. */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/*
-	 * Return to the 64-bit calling code using LJMP rather than LRET, to
-	 * avoid the need for a 32-bit addressable stack. The destination
-	 * address will be adjusted after the template code is copied into a
-	 * 32-bit addressable buffer.
-	 */
-.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
-SYM_CODE_END(trampoline_32bit_src)
-
-/*
- * This symbol is placed right after trampoline_32bit_src() so its address can
- * be used to infer the size of the trampoline code.
- */
-SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
-
-	/*
-         * The trampoline code has a size limit.
-         * Make sure we fail to compile if the trampoline code grows
-         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
-	 */
-	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
-
-	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/compressed/la57toggle.S
new file mode 100644
index 0000000..9ee0023
--- /dev/null
+++ b/arch/x86/boot/compressed/la57toggle.S
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
+#include "pgtable.h"
+
+/*
+ * This is the 32-bit trampoline that will be copied over to low memory. It
+ * will be called using the ordinary 64-bit calling convention from code
+ * running in 64-bit mode.
+ *
+ * Return address is at the top of the stack (might be above 4G).
+ * The first argument (EDI) contains the address of the temporary PGD level
+ * page table in 32-bit addressable memory which will be programmed into
+ * register CR3.
+ */
+
+	.section ".rodata", "a", @progbits
+SYM_CODE_START(trampoline_32bit_src)
+	/*
+	 * Preserve callee save 64-bit registers on the stack: this is
+	 * necessary because the architecture does not guarantee that GPRs will
+	 * retain their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%r15
+	pushq	%r14
+	pushq	%r13
+	pushq	%r12
+	pushq	%rbp
+	pushq	%rbx
+
+	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
+	movq	%rsp, %rbx
+	shrq	$32, %rbx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels. First, the
+	 * stack pointer needs to be restored to its full 64-bit value before
+	 * the callee save register contents can be popped from the stack.
+	 */
+.Lret:
+	shlq	$32, %rbx
+	orq	%rbx, %rsp
+
+	/* Restore the preserved 64-bit registers */
+	popq	%rbx
+	popq	%rbp
+	popq	%r12
+	popq	%r13
+	popq	%r14
+	popq	%r15
+	retq
+
+	.code32
+0:
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Point CR3 to the trampoline's new top level page table */
+	movl	%edi, %cr3
+
+	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+	jc	1f
+	wrmsr
+1:
+	/* Toggle CR4.LA57 */
+	movl	%cr4, %eax
+	btcl	$X86_CR4_LA57_BIT, %eax
+	movl	%eax, %cr4
+
+	/* Enable paging again. */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/*
+	 * Return to the 64-bit calling code using LJMP rather than LRET, to
+	 * avoid the need for a 32-bit addressable stack. The destination
+	 * address will be adjusted after the template code is copied into a
+	 * 32-bit addressable buffer.
+	 */
+.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
+SYM_CODE_END(trampoline_32bit_src)
+
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
+
+	/*
+         * The trampoline code has a size limit.
+         * Make sure we fail to compile if the trampoline code grows
+         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
+	 */
+	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE

