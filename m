Return-Path: <linux-tip-commits+bounces-4710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD246A7CFA1
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604C97A2597
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920311AAE13;
	Sun,  6 Apr 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcjUPJKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtde9TO0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654511A76BC;
	Sun,  6 Apr 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964390; cv=none; b=LhdC8hFad0jUtflUqDVcSmu5zVCgL4/cQH5O2/wm+MzIF9FPz2l3+NCq3PfSFddv0SdlVJVnUJd7E+lahKWwgf/cWQ3iWEQ7OoRNg5acj949cnoNDDvIFEEqweITyZOo8AWlFHCtHz/O8gaQsfvjn67mxgBT6VElstv9PHutQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964390; c=relaxed/simple;
	bh=FnsfxoLa78+M3GnU20TojujWbdQulFapllAgtfjoMWg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UHfmLVUKifuFOo5JU31g3VePMxqwv5xWwuy+qqW7ELaKsRpx/Nf6L7DIf4haDr4yV4PiiAQPr9hm1i+KuLDwAGoy37lzBo3pW5C4x/kWEWIZwy7UL8G+awJi5QOrVIL1rbKbTQA3X6kXOQekw/p3rBSiVd320c0hPiJlv2jv5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcjUPJKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtde9TO0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:33:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743964387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT+QH7FsgbM8XOAXWBi+vLdglNo3DS031IqwIGb9R7c=;
	b=dcjUPJKDMV7Y/5vPV7aPb+ei3RurKKKbZJhr3u1s85CdRWH/oG9RekT5ds+sjfHSlg9FY3
	0aj/u8s8sC2e70QMhrB8Ae/53VeyBk5Rkjim/NOkLx3xO0mleQHAULoJX7KOxiArMLBiya
	8QfSIueirBl/U28d09O1jCOzPLKqEMp8NJ0MPcNsR1bpHhUJjRLUF3v95u2/1zoxKM3cd8
	H8nsN81Hx7A0pSaNgiZv7DzOTngALSjNhNDhWrPlYkSCrdZSx7KhLKZgnnkafuTBagq1f1
	tAeFvBI9U1e869/YirPidPx8qsdzHBs8EB6JQsnQZiF/uEOCsZOLyE+oMhfvpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743964387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT+QH7FsgbM8XOAXWBi+vLdglNo3DS031IqwIGb9R7c=;
	b=vtde9TO01Y9hr9SlDLepM3/7XhfxNvfOmEU0Ab39m/FhrTXpdKG4jmQKxTc+UKhLaTK338
	DkniYjUe/kko0YBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move the 5-level paging trampoline into /startup
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401133416.1436741-10-ardb+git@google.com>
References: <20250401133416.1436741-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396438193.31282.11756630790316418499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5a67da1f49cf4f16ec9966446885131dad0eb245
Gitweb:        https://git.kernel.org/tip/5a67da1f49cf4f16ec9966446885131dad0eb245
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 01 Apr 2025 15:34:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:15:14 +02:00

x86/boot: Move the 5-level paging trampoline into /startup

The 5-level paging trampoline is used by both the EFI stub and the
traditional decompressor. Move it out of the decompressor sources into
the newly minted arch/x86/boot/startup/ sub-directory which will hold
startup code that may be shared between the decompressor, the EFI stub
and the kernel proper, and needs to tolerate being called during early
boot, before the kernel virtual mapping has been created.

This will allow the 5-level paging trampoline to be used by EFI boot
images such as zboot that omit the traditional decompressor entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401133416.1436741-10-ardb+git@google.com
---
 arch/x86/Makefile                     |   1 +-
 arch/x86/boot/compressed/Makefile     |   2 +-
 arch/x86/boot/compressed/la57toggle.S | 111 +-------------------------
 arch/x86/boot/startup/Makefile        |   3 +-
 arch/x86/boot/startup/la57toggle.S    | 111 +++++++++++++++++++++++++-
 5 files changed, 116 insertions(+), 112 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/la57toggle.S
 create mode 100644 arch/x86/boot/startup/Makefile
 create mode 100644 arch/x86/boot/startup/la57toggle.S

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5947230..53daf46 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -281,6 +281,7 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
+core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fdbce02..37b85ce 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -97,7 +97,6 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
-	vmlinux-objs-y += $(obj)/la57toggle.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
@@ -106,6 +105,7 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
 
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/la57toggle.S b/arch/x86/boot/compressed/la57toggle.S
deleted file mode 100644
index 370075b..0000000
--- a/arch/x86/boot/compressed/la57toggle.S
+++ /dev/null
@@ -1,111 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#include <linux/linkage.h>
-#include <asm/segment.h>
-#include <asm/boot.h>
-#include <asm/msr.h>
-#include <asm/processor-flags.h>
-
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
-
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
-	.code32
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
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
new file mode 100644
index 0000000..03519ef
--- /dev/null
+++ b/arch/x86/boot/startup/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/startup/la57toggle.S b/arch/x86/boot/startup/la57toggle.S
new file mode 100644
index 0000000..370075b
--- /dev/null
+++ b/arch/x86/boot/startup/la57toggle.S
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
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

