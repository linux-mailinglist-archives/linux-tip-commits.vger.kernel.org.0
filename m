Return-Path: <linux-tip-commits+bounces-3371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04FA36D72
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1816D9C5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15DD1A9B39;
	Sat, 15 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D32e530V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKVWPCzq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB31A239E;
	Sat, 15 Feb 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617001; cv=none; b=HsT/F9MQ4/1CIaBfOqiMHrMZdOOFzmGXYmopa19rkX3ONz36NOLLYdlrl9GEHIpaIJYGZc++JaaF67r28dXRCF0VfHBxrg/JvFSjYlc6VJwagXUx79sg72QL2t0Kz30Z/FITWHkChfNYrD1FYx5DlekgAQUiNJs3p3QOm8/I7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617001; c=relaxed/simple;
	bh=lC55fyNHoyp4vsS4UMlBwwB5k4O4e7wE6Rjucc/ganA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f5CL7wQJe9wfOHLsszcDzevvL9h8FwSjCukP0gxBzUwlRGLUflkmJkLIp5yfwGaYayQwgIbC/OzAEXozYeFmTgxw387qRYcj1SYi2JGMc0u6+Yw+LBAXDSffsH0dA2bq6rfebh6fFIWfJ/exlmK6qm2E9GLCsbBO4kLRCyN2ikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D32e530V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKVWPCzq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZzIlYvmwxfnyejxp76CfJeOWAIpwTl7n+WiFqMLQh0=;
	b=D32e530VFoDGUoWed9UFG5W0RJBX1tSnP+dZul+J9zOZ+bYJjYylB5VKSHfqhXcS/icKWl
	MwLm3ms4pTOWkQHKmx3ZvbvbcD+jErrerOY2y6ITCCjtcLMKujRCOPjNwmd58GMX8/hptJ
	Hug8gRr8vx8xRkNfVKepZ0RjqRu8oz0ISbBpg2p8iEIJ/BTwNdOox3RfSIkJvEpsLWFZLb
	jqPFVSph/vp7OM6KWEqi+l2VxY8OwvpqcmjBauihRx6LZ7MKUhtNGDEVGhBo8nE4+goqrX
	DLcWKQxplDfb/u61NhA0oIT4K/2i42TMFn4g/qFKkreRQBU1RSKFbtW6wVOrAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZzIlYvmwxfnyejxp76CfJeOWAIpwTl7n+WiFqMLQh0=;
	b=bKVWPCzqS5nOd90B26EbV37QhvhVwfetQmHAMl8Bdi+gPITjVvgpogCee95sxKx+9LMetP
	jWMBVL/NdDUUxYBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Cleanup and robustify decode_bug()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.721120726@infradead.org>
References: <20250207122546.721120726@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699739.10177.117895311119370347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c20ad96c9a8f0aeaf4e4057730a22de2657ad0c2
Gitweb:        https://git.kernel.org/tip/c20ad96c9a8f0aeaf4e4057730a22de2657ad0c2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:06 +01:00

x86/traps: Cleanup and robustify decode_bug()

Notably, don't attempt to decode an immediate when MOD == 3.

Additionally have it return the instruction length, such that WARN
like bugs can more reliably skip to the correct instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.721120726@infradead.org
---
 arch/x86/include/asm/bug.h |  5 +-
 arch/x86/include/asm/ibt.h |  4 +-
 arch/x86/kernel/traps.c    | 82 +++++++++++++++++++++++++++----------
 3 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index e85ac0c..1a5e4b3 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,8 +22,9 @@
 #define SECOND_BYTE_OPCODE_UD2	0x0b
 
 #define BUG_NONE		0xffff
-#define BUG_UD1			0xfffe
-#define BUG_UD2			0xfffd
+#define BUG_UD2			0xfffe
+#define BUG_UD1			0xfffd
+#define BUG_UD1_UBSAN		0xfffc
 
 #ifdef CONFIG_GENERIC_BUG
 
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index d955e0d..f0ca5c0 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -41,7 +41,7 @@
 	_ASM_PTR fname "\n\t"				\
 	".popsection\n\t"
 
-static inline __attribute_const__ u32 gen_endbr(void)
+static __always_inline __attribute_const__ u32 gen_endbr(void)
 {
 	u32 endbr;
 
@@ -56,7 +56,7 @@ static inline __attribute_const__ u32 gen_endbr(void)
 	return endbr;
 }
 
-static inline __attribute_const__ u32 gen_endbr_poison(void)
+static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
 	/*
 	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2dbadf3..05b86c0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -94,10 +94,17 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 
 /*
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
- * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ * If it's a UD1, further decode to determine its use:
+ *
+ * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
+ * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
+ * static_call:  0f b9 cc                ud1    %esp,%ecx
+ *
+ * Notably UBSAN uses EAX, static_call uses ECX.
  */
-__always_inline int decode_bug(unsigned long addr, u32 *imm)
+__always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
+	unsigned long start = addr;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -110,24 +117,42 @@ __always_inline int decode_bug(unsigned long addr, u32 *imm)
 		return BUG_NONE;
 
 	v = *(u8 *)(addr++);
-	if (v == SECOND_BYTE_OPCODE_UD2)
+	if (v == SECOND_BYTE_OPCODE_UD2) {
+		*len = addr - start;
 		return BUG_UD2;
+	}
 
-	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+	if (v != SECOND_BYTE_OPCODE_UD1)
 		return BUG_NONE;
 
-	/* Retrieve the immediate (type value) for the UBSAN UD1 */
-	v = *(u8 *)(addr++);
-	if (X86_MODRM_RM(v) == 4)
-		addr++;
-
 	*imm = 0;
-	if (X86_MODRM_MOD(v) == 1)
-		*imm = *(u8 *)addr;
-	else if (X86_MODRM_MOD(v) == 2)
-		*imm = *(u32 *)addr;
-	else
-		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+	v = *(u8 *)(addr++);		/* ModRM */
+
+	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
+		addr++;			/* SIB */
+
+	/* Decode immediate, if present */
+	switch (X86_MODRM_MOD(v)) {
+	case 0: if (X86_MODRM_RM(v) == 5)
+			addr += 4; /* RIP + disp32 */
+		break;
+
+	case 1: *imm = *(s8 *)addr;
+		addr += 1;
+		break;
+
+	case 2: *imm = *(s32 *)addr;
+		addr += 4;
+		break;
+
+	case 3: break;
+	}
+
+	/* record instruction length */
+	*len = addr - start;
+
+	if (X86_MODRM_REG(v) == 0)	/* EAX */
+		return BUG_UD1_UBSAN;
 
 	return BUG_UD1;
 }
@@ -258,10 +283,10 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
-	int ud_type;
-	u32 imm;
+	int ud_type, ud_len;
+	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &imm);
+	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -281,15 +306,28 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (ud_type == BUG_UD2) {
+
+	switch (ud_type) {
+	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
 		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += LEN_UD2;
+			regs->ip += ud_len;
 			handled = true;
 		}
-	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
-		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
+		break;
+
+	case BUG_UD1_UBSAN:
+		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+			pr_crit("%s at %pS\n",
+				report_ubsan_failure(regs, ud_imm),
+				(void *)regs->ip);
+		}
+		break;
+
+	default:
+		break;
 	}
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();

