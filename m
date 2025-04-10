Return-Path: <linux-tip-commits+bounces-4829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C948A84186
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9827B21A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3DC2836A5;
	Thu, 10 Apr 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uXqvps3d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4P33fXC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AC281528;
	Thu, 10 Apr 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283587; cv=none; b=MP7fzYpGYVqvgke2IrgBl7HL2JKHeV5c5aTTxH8wOA4hJ873wSrg2EhwhA5bLh/VTIkdPh6Nn1+SFlFDFv4bw7gQ4LxEn2QsZdx23FDnBztDf4rgu2ByrPMKC9dSarc64ndwwk04uiFv5Z8ny7J4TL0k+50xXIHRyW6oZrev4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283587; c=relaxed/simple;
	bh=tRfxp2I7QVqo0nD0k7rTi8wfS/VvhtXZk7ZPPq6aYZc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OcpIP/2Xuaefuye/Bl2PIBQgrCi2K33+id/rucG34L9TlZC9hMZV0QCP9XJ6QaA9uQklcxDAAlmJMMOFbPkgT6a3qpnXNDY9HUqyiTE9NWdYm3S+ss86OXIhmCj0vP41d9LLhZeJApMjV1z5CA2WlsmDgQiVfz5wTH1qMg4mTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uXqvps3d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4P33fXC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 11:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744283584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NW5HXnJPw7aNgGXidvvqedqSb9GBeyIfhvTbxPouz8=;
	b=uXqvps3dwWuBdjDJGVUNSTBxLndZlEAIiVAgyauG1byn13y45aTeYD9EPwBfEqfHPhDJqw
	7CS7NpprOc7HyYYsPkMJuz9dolesk/8KeMANQUtO5HHEsPrsvSUCMWbdAvSWbJKP+T2HyH
	YblkGYVaP2/CcDa6AGmmIbHrqEWsK6FVi5Z/Koa/4EpM2wfSq+4GXBJ72IKKDcMCxIoa8J
	iRm5pLI/VsQbunFPczx0S3IyLDBAPNQQ7D+cw9ez4q9a5Ugq/REc8f0PLOBoDg6spdj8Jo
	W1rVjIaxp3VWIdSogHbv5NaqkNIhuZKn1ALx984s5xZz6xWKnLKoRlHS13FdXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744283584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NW5HXnJPw7aNgGXidvvqedqSb9GBeyIfhvTbxPouz8=;
	b=S4P33fXCUEPRSwoSJITg6L5h5w/FhYM3oXeiFJyy7JPsiasizpI572lNnzyNFfujFyNWWT
	iUeeF1wsEioM4uAQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/kexec: Add 8250 serial port output
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326142404.256980-2-dwmw2@infradead.org>
References: <20250326142404.256980-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174428358301.31282.8006471785913803552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d358b45120cc8da9f10d8c1e8ec3559f72525147
Gitweb:        https://git.kernel.org/tip/d358b45120cc8da9f10d8c1e8ec3559f72525147
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 26 Mar 2025 14:16:01 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 12:17:13 +02:00

x86/kexec: Add 8250 serial port output

If a serial port was configured for early_printk, use it for debug output
from the relocate_kernel exception handler too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250326142404.256980-2-dwmw2@infradead.org
---
 arch/x86/include/asm/kexec.h         |  1 +-
 arch/x86/kernel/early_printk.c       |  6 ++++-
 arch/x86/kernel/relocate_kernel_64.S | 39 ++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index fb4537c..9601094 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -64,6 +64,7 @@ extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
+extern uint16_t kexec_debug_8250_port;
 #endif
 
 /*
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 611f27e..acb7d05 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/screen_info.h>
@@ -144,6 +145,11 @@ static __init void early_serial_hw_init(unsigned divisor)
 	static_call(serial_out)(early_serial_base, DLL, divisor & 0xff);
 	static_call(serial_out)(early_serial_base, DLH, (divisor >> 8) & 0xff);
 	static_call(serial_out)(early_serial_base, LCR, c & ~DLAB);
+
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_X86_64)
+	if (static_call_query(serial_in) == io_serial_in)
+		kexec_debug_8250_port = early_serial_base;
+#endif
 }
 
 #define DEFAULT_BAUD 9600
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 29cb399..21011cd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@ SYM_DATA(kexec_va_control_page, .quad 0)
 SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+SYM_DATA(kexec_debug_8250_port, .word 0)
 
 	.balign 16
 SYM_DATA_START_LOCAL(kexec_debug_gdt)
@@ -380,24 +381,50 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 /*
- * Generic 'print character' routine (as yet unimplemented)
+ * Generic 'print character' routine
  *  - %al: Character to be printed (may clobber %rax)
  *  - %rdx: MMIO address or port.
  */
-SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+#define XMTRDY          0x20
+
+#define TXR             0       /*  Transmit register (WRITE) */
+#define LSR             5       /*  Line Status               */
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
+	addw	$LSR, %dx
+	xchg	%al, %ah
+.Lxmtrdy_loop:
+	inb	%dx, %al
+	testb	$XMTRDY, %al
+	jnz	.Lready
+	rep nop
+	jmp .Lxmtrdy_loop
+
+.Lready:
+	subw	$LSR, %dx
+	xchg	%al, %ah
+	outb	%al, %dx
+pr_char_null:
+	ANNOTATE_NOENDBR
+
 	ANNOTATE_UNRET_SAFE
 	ret
-SYM_CODE_END(pr_char)
+SYM_CODE_END(pr_char_8250)
 
 /*
  * Load pr_char function pointer into %rsi and load %rdx with whatever
  * that function wants to see there (typically port/MMIO address).
  */
-.macro	pr_setup
-	/* No output; pr_char just returns */
-	leaq	pr_char(%rip), %rsi
+.macro pr_setup
+	leaq	pr_char_8250(%rip), %rsi
+	movw	kexec_debug_8250_port(%rip), %dx
+	testw	%dx, %dx
+	jnz	1f
+
+	leaq	pr_char_null(%rip), %rsi
+1:
 .endm
 
 /* Print the nybble in %bl, clobber %rax */

