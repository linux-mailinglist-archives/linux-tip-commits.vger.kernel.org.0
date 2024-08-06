Return-Path: <linux-tip-commits+bounces-1952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF87948E2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F7D1F25DFB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF741BDA83;
	Tue,  6 Aug 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJGGOeIa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGTmzTZA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4F2A1CF;
	Tue,  6 Aug 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945190; cv=none; b=hE9phrdSh5PZtcyaPru577lSckDPYqpkKdLNJpb1Cg7TDwnVOwj8Pzawp4qS1KSkBzfgqa23Mq70C3ad7OK7xSEXA3rVUaz0/A6e+ZwAfcvMeaMaIL2hhuzZWjtGeka81dGNVHGolY7tjO9e+Xx9eZZLQ+AU/hM4z4lDScMyIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945190; c=relaxed/simple;
	bh=CNZJ3Lq8F35sFAbgx540GIpCpVJdLnk0G17IgsWZIHA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B7wldI11UbrlPl+0goGUwoSQeHM7KdZlYO9W7ahf2PSrhkfxxaVErq3IQRqPQ+okaz+yXBPuFxr+3j7icvgfk8O/m9thM5n9obrNOQiQTavTTX+GXkAJyd4FpDdMPPDLU06Bh7uPmpp3BMODaseB7RBI/+eh0lfRTeEBTbZCaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJGGOeIa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGTmzTZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Aug 2024 11:53:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722945186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Bpor1yaqG3+b2msk49kLf36xT6CBn/y8kwyy9CUNk=;
	b=xJGGOeIayBZUrbAEJqpXeucj9onVahWRbpbPKEy/2v3PWRiRez+ZAkOrs45g9/Z1XIRCUB
	5eDIZe+KrVFf1gCjOJcU7YUI2uKb118JCvXGe5y3UeLnvP3gVJwdLInX4RKZvqDQ4n0QUu
	u0Cd2a9zqKDsT2DASYRrahUPrettWV1JhYTIJ83oLDvpsum6iIYDOqiud/xoNBUlApnMBy
	4CXlScAPiDDg6MdcXGAFJav96x94tEANBy04ZkIa60H1qY/RYKUd6DRHcCOTRaBi4r9ive
	qnRibZqQIoc+Ze1OoQTvAKlgPBlt0jvyeotLGZVo2A1nftB3/YJBcVfOutN0zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722945186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Bpor1yaqG3+b2msk49kLf36xT6CBn/y8kwyy9CUNk=;
	b=QGTmzTZA03CHDcdg8XUozdvnPf1/1N3VbWq9vy9/+xmt2RlD3JBZ9kqTCVMf+kgWPJyY0E
	xU1FLyQg1AJN6bBw==
From: "tip-bot2 for Gatlin Newhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Enable UBSAN traps on x86
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240724000206.451425-1-gatlin.newhouse@gmail.com>
References: <20240724000206.451425-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172294518606.2215.14664483852771489627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7424fc6b86c8980a87169e005f5cd4438d18efe6
Gitweb:        https://git.kernel.org/tip/7424fc6b86c8980a87169e005f5cd4438d18efe6
Author:        Gatlin Newhouse <gatlin.newhouse@gmail.com>
AuthorDate:    Wed, 24 Jul 2024 00:01:55 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Aug 2024 13:42:40 +02:00

x86/traps: Enable UBSAN traps on x86

Currently ARM64 extracts which specific sanitizer has caused a trap via
encoded data in the trap instruction. Clang on x86 currently encodes the
same data in the UD1 instruction but x86 handle_bug() and
is_valid_bugaddr() currently only look at UD2.

Bring x86 to parity with ARM64, similar to commit 25b84002afb9 ("arm64:
Support Clang UBSAN trap codes for better reporting"). See the llvm
links for information about the code generation.

Enable the reporting of UBSAN sanitizer details on x86 compiled with clang
when CONFIG_UBSAN_TRAP=y by analysing UD1 and retrieving the type immediate
which is encoded by the compiler after the UD1.

[ tglx: Simplified it by moving the printk() into handle_bug() ]

Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20240724000206.451425-1-gatlin.newhouse@gmail.com
Link: https://github.com/llvm/llvm-project/commit/c5978f42ec8e9#diff-bb68d7cd885f41cfc35843998b0f9f534adb60b415f647109e597ce448e92d9f
Link: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86InstrSystem.td#L27
---
 arch/x86/include/asm/bug.h | 12 ++++++++-
 arch/x86/kernel/traps.c    | 59 +++++++++++++++++++++++++++++++++----
 include/linux/ubsan.h      |  5 +++-
 lib/Kconfig.ubsan          |  4 +--
 4 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d..806649c 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,18 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_ASOP		0x67
+#define OPCODE_ESCAPE		0x0f
+#define SECOND_BYTE_OPCODE_UD1	0xb9
+#define SECOND_BYTE_OPCODE_UD2	0x0b
+
+#define BUG_NONE		0xffff
+#define BUG_UD1			0xfffe
+#define BUG_UD2			0xfffd
+
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17..4158816 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/iommu.h>
+#include <linux/ubsan.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -91,6 +92,47 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr == INSN_UD2;
 }
 
+/*
+ * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
+ * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ */
+__always_inline int decode_bug(unsigned long addr, u32 *imm)
+{
+	u8 v;
+
+	if (addr < TASK_SIZE_MAX)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == INSN_ASOP)
+		v = *(u8 *)(addr++);
+	if (v != OPCODE_ESCAPE)
+		return BUG_NONE;
+
+	v = *(u8 *)(addr++);
+	if (v == SECOND_BYTE_OPCODE_UD2)
+		return BUG_UD2;
+
+	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+		return BUG_NONE;
+
+	/* Retrieve the immediate (type value) for the UBSAN UD1 */
+	v = *(u8 *)(addr++);
+	if (X86_MODRM_RM(v) == 4)
+		addr++;
+
+	*imm = 0;
+	if (X86_MODRM_MOD(v) == 1)
+		*imm = *(u8 *)addr;
+	else if (X86_MODRM_MOD(v) == 2)
+		*imm = *(u32 *)addr;
+	else
+		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+
+	return BUG_UD1;
+}
+
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -216,6 +258,8 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
+	int ud_type;
+	u32 imm;
 
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -223,7 +267,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	ud_type = decode_bug(regs->ip, &imm);
+	if (ud_type == BUG_NONE)
 		return handled;
 
 	/*
@@ -236,10 +281,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-		regs->ip += LEN_UD2;
-		handled = true;
+	if (ud_type == BUG_UD2) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
+		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += LEN_UD2;
+			handled = true;
+		}
+	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index bff7445..d8219cb 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -4,6 +4,11 @@
 
 #ifdef CONFIG_UBSAN_TRAP
 const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+#else
+static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index bdda600..1d4aa7a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -29,8 +29,8 @@ config UBSAN_TRAP
 
 	  Also note that selecting Y will cause your kernel to Oops
 	  with an "illegal instruction" error with no further details
-	  when a UBSAN violation occurs. (Except on arm64, which will
-	  report which Sanitizer failed.) This may make it hard to
+	  when a UBSAN violation occurs. (Except on arm64 and x86, which
+	  will report which Sanitizer failed.) This may make it hard to
 	  determine whether an Oops was caused by UBSAN or to figure
 	  out the details of a UBSAN violation. It makes the kernel log
 	  output less useful for bug reports.

