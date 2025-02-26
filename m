Return-Path: <linux-tip-commits+bounces-3663-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E4A45E4D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6698719C21D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D620222582;
	Wed, 26 Feb 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCSFAfUI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gW46MkPt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4542222C6;
	Wed, 26 Feb 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571490; cv=none; b=j7BtLyPepmBNAOSF19VFk4Hpad+TQk7HLkyB3REEuC5XICgmnQ52y2AM8qtvUEixpYsG56E88WUqR4VYWIzTnDlHsX7Q9qu4CHLE7i7a/Kwc0ggLoCI738uBM+Im1rdE4AvOQL1zt6etDufaC1BCv3cnbVIsVVHeHXJBLLRWzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571490; c=relaxed/simple;
	bh=/nQzd3IkT/HgHYsKBwy21xsFE8rdMrKXLIea2d38yEI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oMzqzDuT1B2VBLIx03ylw/mkObIHJmfZoxPr2IVrj5/zgQjRG70+gUsJFhsJKALkLDJ2AQjEKVMq88SMPWEW0o6N00Kz2UmczakK7+ErJHKoE6e5hFU+NQE7eH8fsWdkVOAYh7nh8g1SfgQyxiFvbe9f9coq6Xwz1RJQQskvD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCSFAfUI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gW46MkPt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIjvomu0tDm/cQbC3Hgnhznd6YnkcUPhHJ53JIy9S9s=;
	b=CCSFAfUIyTQWs9EYTysZGGgxfDjeR3j/HQiCeYaWtsedpyDxdqKwxgtGCTVTcw/vMykKFK
	BP57GxtkRd3eYg8KujLbjrEhmYncNxF1emH4UrtcDm/lJpyis3QMhYAceTvR4K3YodrW47
	4En1ul440KoM5sjIf+jrh0Ue6pLBu8fUGwjArZ+jn82MdkAgs4Klrp/thA6AfzFDO+bmot
	pDJJFZzFx0sneO/sd0fFaYTshFIQoITyl0VNF9toO6OPCPGJXN11uk1ghGCHXw7nJkzurG
	FVoUl6o1/q1nlpu2W39CTkIkDuYw3+1xFhefopv6hXlh1iSvhIxEmmtXioNLvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIjvomu0tDm/cQbC3Hgnhznd6YnkcUPhHJ53JIy9S9s=;
	b=gW46MkPtTXeRBiI2jrwGqm6d7H8WOuu28SMibSnhYJ82r3GbI19qu77U2Ucki5rzUQ1h+J
	paOgLpDrG4s34aDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add paranoid FineIBT mode
Cc: Scott Constable <scott.d.constable@intel.com>,
 Jennifer Miller <jmill@asu.edu>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.598033084@infradead.org>
References: <20250224124200.598033084@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148505.10177.6140715740099958120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     97e59672a9d2aec0c27f6cd6a6b0edfdd6e5a85c
Gitweb:        https://git.kernel.org/tip/97e59672a9d2aec0c27f6cd6a6b0edfdd6e5a85c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 26 Feb 2025 12:25:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:27:45 +01:00

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

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Reported-by: Jennifer Miller <jmill@asu.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.598033084@infradead.org
---
 arch/x86/kernel/alternative.c | 144 +++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a2e8ee8..c698c9e 100644
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
@@ -998,6 +1003,8 @@ u32 cfi_get_func_hash(void *func)
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
+static bool cfi_paranoid __ro_after_init = false;
+
 /*
  * Re-hash the CFI hash with a boot-time seed while making sure the result is
  * not a valid ENDBR instruction.
@@ -1040,6 +1047,12 @@ static __init int cfi_parse_cmdline(char *str)
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
@@ -1128,6 +1141,52 @@ extern u8 fineibt_caller_end[];
 
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
@@ -1291,18 +1350,48 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
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
@@ -1319,8 +1408,15 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
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
@@ -1377,8 +1473,10 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
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
@@ -1451,7 +1549,7 @@ static void poison_cfi(void *addr)
  * We check the preamble by checking for the ENDBR instruction relative to the
  * 0xEA instruction.
  */
-bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+static bool decode_fineibt_preamble(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
@@ -1476,6 +1574,40 @@ Efault:
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
 #else /* !CONFIG_FINEIBT: */
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,

