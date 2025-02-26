Return-Path: <linux-tip-commits+bounces-3639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509BA45C3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336901892788
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBE26F455;
	Wed, 26 Feb 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKVsmcRU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+o94fbS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3A25D54B;
	Wed, 26 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567264; cv=none; b=WLBSIqnkmLCUwBZLRMis+IFAYv6HVNdmpALrmex74Hxhqq1X0aoOiF3cRleCHwt8v/Mpr2fkOjsCGGb3fVh+pIhM/bm9gxVXXAvFnfRuUYnVYNmi70eMkoMvDfqP9YbNDedYR4BG3g28Lm3TFqJ13PlRitAFczD9Lobde6HzNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567264; c=relaxed/simple;
	bh=20V8Q3JuX6bpuXf2tz62/tfkMSlYO8jnRQLWlTir0pc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KqhMlJgLUKWHTJvINa9tNFk36P3gIsi+CyumDLaKFfgH3lU+cb3jbdaVnyvwz4R17GizYxjc4gQMKBMIgLue6j+kP3busMBRbOYcaUTYkG4Mvj6ggIsSInKPGKuTW/7PZddf/gEaYn/qD3GFPOSCEZVuNbkpSahN8kdgQI5E/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKVsmcRU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+o94fbS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/tobHeXcHckb25LxxGvxve/tBmhEiz2BS4ahzRIXr4=;
	b=BKVsmcRUwcIxB8kwZOb/wMYhAJJXDaSPreaQzYNi395kXSmj7vOe75AJF6XKoKxZms3TMt
	agnrzeqDVJycIqzGp+pIkZYAJnsFzgdyHJ1aMxZxGnSvlFOZ6r0F9wP56Xm0g2ee15ZC5q
	1VS+xRR/dkCWbsbKX0SB7Xuif2fSq4TBs0M1dvmpdRs92u4MXrt16/LKq7nW4/qAhi0uQe
	pnxcRFNnELWHqGn7e5Zj/GFTUyMFQWR6C7QRbMAn2UecSIY4RO1nCmFjcprzv9MAL3sY3E
	8b0dDbJ7/OGCNlVBPjiuqre/Z1NelCyHHFhlE4dXdQZiRrX0o3KVx24FPTgUUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/tobHeXcHckb25LxxGvxve/tBmhEiz2BS4ahzRIXr4=;
	b=e+o94fbSTYXE7Z3PnZ6d5TY25hgRNnIUD+5nstfncaSN/4vHHP/p1m/oYLK0Y62+QvFcJZ
	ivVsWWsyp+Afx2Dg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add paranoid FineIBT mode
Cc: Jennifer Miller <jmill@asu.edu>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.598033084@infradead.org>
References: <20250224124200.598033084@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726026.10177.11440921323058191988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3b920ee30ac68e6b040d37b9205f0acc074a0d9b
Gitweb:        https://git.kernel.org/tip/3b920ee30ac68e6b040d37b9205f0acc074a0d9b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:55 +01:00

x86/ibt: Add paranoid FineIBT mode

Due to concerns about circumvention attacks against FineIBT on 'naked'
ENDBR, add an additional caller side hash check to FineIBT. This
should make it impossible to pivot over such a 'naked' ENDBR
instruction at the cost of an additional load.

The specific pivot reported was against the SYSCALL entry site and
FRED will have all those holes fixed up.

  https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/

This specific fineibt_paranoid_start[] sequence was concocted by
Scott.

Reported-by: Jennifer Miller <jmill@asu.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.598033084@infradead.org
---
 arch/x86/kernel/alternative.c | 144 +++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 599f218..2bb5ba5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -741,6 +741,11 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		op2 = insn.opcode.bytes[1];
 
 		switch (op1) {
+		case 0x70 ... 0x7f:	/* Jcc.d8 */
+			/* See cfi_paranoid. */
+			WARN_ON_ONCE(cfi_mode != CFI_FINEIBT);
+			continue;
+
 		case CALL_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 			break;
@@ -994,6 +999,8 @@ u32 cfi_get_func_hash(void *func)
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
+static bool cfi_paranoid __ro_after_init = false;
+
 /*
  * Re-hash the CFI hash with a boot-time seed while making sure the result is
  * not a valid ENDBR instruction.
@@ -1036,6 +1043,12 @@ static __init int cfi_parse_cmdline(char *str)
 		} else if (!strcmp(str, "warn")) {
 			pr_alert("CFI mismatch non-fatal!\n");
 			cfi_warn = true;
+		} else if (!strcmp(str, "paranoid")) {
+			if (cfi_mode == CFI_FINEIBT) {
+				cfi_paranoid = true;
+			} else {
+				pr_err("Ignoring paranoid; depends on fineibt.\n");
+			}
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -1124,6 +1137,52 @@ extern u8 fineibt_caller_end[];
 
 #define fineibt_caller_jmp (fineibt_caller_size - 2)
 
+/*
+ * Since FineIBT does hash validation on the callee side it is prone to
+ * circumvention attacks where a 'naked' ENDBR instruction exists that
+ * is not part of the fineibt_preamble sequence.
+ *
+ * Notably the x86 entry points must be ENDBR and equally cannot be
+ * fineibt_preamble.
+ *
+ * The fineibt_paranoid caller sequence adds additional caller side
+ * hash validation. This stops such circumvention attacks dead, but at the cost
+ * of adding a load.
+ *
+ * <fineibt_paranoid_start>:
+ *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
+ *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
+ *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
+ *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
+ * 10:   41 ff d3                call   *%r11
+ * 13:   90                      nop
+ *
+ * Notably LEA does not modify flags and can be reordered with the CMP,
+ * avoiding a dependency. Again, using a non-taken (backwards) branch
+ * for the failure case, abusing LEA's immediate 0xf0 as LOCK prefix for the
+ * Jcc.d8, causing #UD.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_paranoid_start:			\n"
+	"	movl	$0x12345678, %r10d		\n"
+	"	cmpl	-9(%r11), %r10d			\n"
+	"	lea	-0x10(%r11), %r11		\n"
+	"	jne	fineibt_paranoid_start+0xd	\n"
+	"fineibt_paranoid_ind:				\n"
+	"	call	*%r11				\n"
+	"	nop					\n"
+	"fineibt_paranoid_end:				\n"
+	".popsection					\n"
+);
+
+extern u8 fineibt_paranoid_start[];
+extern u8 fineibt_paranoid_ind[];
+extern u8 fineibt_paranoid_end[];
+
+#define fineibt_paranoid_size (fineibt_paranoid_end - fineibt_paranoid_start)
+#define fineibt_paranoid_ind  (fineibt_paranoid_ind - fineibt_paranoid_start)
+#define fineibt_paranoid_ud   0xd
+
 static u32 decode_preamble_hash(void *addr)
 {
 	u8 *p = addr;
@@ -1287,18 +1346,48 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
 
+	BUG_ON(fineibt_paranoid_size != 20);
+
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		struct insn insn;
+		u8 bytes[20];
 		u32 hash;
+		int ret;
+		u8 op;
 
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
-		if (hash) {
+		if (!hash)
+			continue;
+
+		if (!cfi_paranoid) {
 			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
 			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+			/* rely on apply_retpolines() */
+			continue;
+		}
+
+		/* cfi_paranoid */
+		ret = insn_decode_kernel(&insn, addr + fineibt_caller_size);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op = insn.opcode.bytes[0];
+		if (op != CALL_INSN_OPCODE && op != JMP32_INSN_OPCODE) {
+			WARN_ON_ONCE(1);
+			continue;
 		}
-		/* rely on apply_retpolines() */
+
+		memcpy(bytes, fineibt_paranoid_start, fineibt_paranoid_size);
+		memcpy(bytes + fineibt_caller_hash, &hash, 4);
+
+		ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind);
+		if (WARN_ON_ONCE(ret != 3))
+			continue;
+
+		text_poke_early(addr, bytes, fineibt_paranoid_size);
 	}
 
 	return 0;
@@ -1315,8 +1404,15 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
-		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT)) {
+			/*
+			 * FRED has much saner context on exception entry and
+			 * is less easy to take advantage of.
+			 */
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				cfi_paranoid = true;
 			cfi_mode = CFI_FINEIBT;
+		}
 	}
 
 	/*
@@ -1373,8 +1469,10 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		/* now that nobody targets func()+0, remove ENDBR there */
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
-		if (builtin)
-			pr_info("Using FineIBT CFI\n");
+		if (builtin) {
+			pr_info("Using %sFineIBT CFI\n",
+				cfi_paranoid ? "paranoid " : "");
+		}
 		return;
 
 	default:
@@ -1447,7 +1545,7 @@ static void poison_cfi(void *addr)
  * We check the preamble by checking for the ENDBR instruction relative to the
  * 0xEA instruction.
  */
-bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+static bool decode_fineibt_preamble(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
@@ -1472,6 +1570,40 @@ Efault:
 	return false;
 }
 
+/*
+ * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
+ * sequence.
+ */
+static bool decode_fineibt_paranoid(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_paranoid_ud;
+	u32 hash;
+
+	if (!cfi_paranoid || !is_cfi_trap(addr + fineibt_caller_size - LEN_UD2))
+		return false;
+
+	__get_kernel_nofault(&hash, addr + fineibt_caller_hash, u32, Efault);
+	*target = regs->r11 + fineibt_preamble_size;
+	*type = regs->r10;
+
+	/*
+	 * Since the trapping instruction is the exact, but LOCK prefixed,
+	 * Jcc.d8 that got us here, the normal fixup will work.
+	 */
+	return true;
+
+Efault:
+	return false;
+}
+
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	if (decode_fineibt_paranoid(regs, target, type))
+		return true;
+
+	return decode_fineibt_preamble(regs, target, type);
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,

