Return-Path: <linux-tip-commits+bounces-3665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBAA45E5D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30423A7597
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5F23315E;
	Wed, 26 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elo/pAs/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CNNQsidk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B82222DB;
	Wed, 26 Feb 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571491; cv=none; b=EompbCx+K0Uxi9nTpNSWhohZFg25bt/+ynWF2c9G6Pea1RFNVS5ANOKIpwW8rEPZEbu8/cW6S4aWfIWJxEAz56CRUcEpmUD0+45aR00vPgHCi4FtI6KK9HgcJogVkzPSP4obYU4aEG43RhBSN1WaOkX3mowUyHrbSueaXtb4LM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571491; c=relaxed/simple;
	bh=xEp7vwTVS7ccylkpfA2TiK6BOoiGlHS59q4fPq6UiZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GAiL8bdtwDXqq29KrFO7LS+Nh7RPRPng8MuLz3NHC2PW58L/sQftZhhMLPYVnzuKZcJOqG3jZK6RhXLU3XO+pn24qEiTwXMYB675qqmUjWVL3/w6MBqXOCTCfKEWlVfUUcROm9990rISzVaWzdSh4MWz1M9wJmfx9N3HgKO9tgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elo/pAs/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CNNQsidk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyPFXpUqlbfS/1Y5aIPCc5/lmvk3zKCxEsN0aTmqK40=;
	b=elo/pAs/zfxK9JG38DwPmuVWcjgppTj3IpA+taOTetKJXPNAtZ7EWu6UrRg3uvcoztDrR+
	sCilQQ9x9p8sUwrDCIvfwG4UZgz/ZjAk+1tD3jMemScvN18MEfR9582RUEVgNP2MP1YZfI
	/nvZjC8z69e3MuyRl90Xs/jqT2fszKh/rfL0LV/7q/zkoM7v+XK4AuABhdNgTAGGElzw5T
	bo4YvXzYEiYK9Tbebq7T3VxjSZp9LfDFICW+KPUGv1LsbN1d1s5rNeoHA2HKTdERx27o8M
	uPhITcHrOylXFCpS3G1K3VNEdGnwSbRLalyQK8+VVjmm+ubED1ToXT3yrib0Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyPFXpUqlbfS/1Y5aIPCc5/lmvk3zKCxEsN0aTmqK40=;
	b=CNNQsidkrq9DZJ58VqchLN+uvbiVHjpcTWrg3yJyLbrqZuzacyfP2c/Bxm1VoiyxeMJmqp
	2z+7f95OXTUv/HBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Optimize the FineIBT instruction sequence
Cc: Scott Constable <scott.d.constable@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.371942555@infradead.org>
References: <20250224124200.371942555@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148641.10177.8516809208628420142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     06926c6cdb955bf24521d4e13af95b4d062d02d0
Gitweb:        https://git.kernel.org/tip/06926c6cdb955bf24521d4e13af95b4d062d02d0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:24:09 +01:00

x86/ibt: Optimize the FineIBT instruction sequence

Scott notes that non-taken branches are faster. Abuse overlapping code
that traps instead of explicit UD2 instructions.

And LEA does not modify flags and will have less dependencies.

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.371942555@infradead.org
---
 arch/x86/kernel/alternative.c | 61 ++++++++++++++++++++++------------
 arch/x86/net/bpf_jit_comp.c   |  5 +--
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea68f0e..a2e8ee8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1057,9 +1057,9 @@ early_param("cfi", cfi_parse_cmdline);
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
  *	nop					     subl   $0x12345678,%r10d   // 7
- *	nop					     jz     1f			// 2
- *	nop					     ud2			// 2
- *	nop					1:   nop			// 1
+ *	nop					     jne    __cfi_\func+6	// 2
+ *	nop					     nop3			// 3
+ *	nop
  *	nop
  *	nop
  *	nop
@@ -1071,37 +1071,50 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * caller:					caller:
  *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
- *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
+ *	addl	$-15(%r11),%r10d	 // 4	     lea    -0x10(%r11),%r11	// 4
  *	je	1f			 // 2	     nop4			// 4
  *	ud2				 // 2
- * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
+ * 1:	cs call	__x86_indirect_thunk_r11 // 6	     call   *%r11; nop3;	// 6
  *
  */
 
-asm(	".pushsection .rodata			\n"
-	"fineibt_preamble_start:		\n"
-	"	endbr64				\n"
-	"	subl	$0x12345678, %r10d	\n"
-	"	je	fineibt_preamble_end	\n"
-	"fineibt_preamble_ud2:			\n"
-	"	ud2				\n"
-	"	nop				\n"
-	"fineibt_preamble_end:			\n"
+/*
+ * <fineibt_preamble_start>:
+ *  0:   f3 0f 1e fa             endbr64
+ *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
+ *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
+ *  d:   0f 1f 00                nopl   (%rax)
+ *
+ * Note that the JNE target is the 0xEA byte inside the SUB, this decodes as
+ * (bad) on x86_64 and raises #UD.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_preamble_start:			\n"
+	"	endbr64					\n"
+	"	subl	$0x12345678, %r10d		\n"
+	"	jne	fineibt_preamble_start+6	\n"
+	ASM_NOP3
+	"fineibt_preamble_end:				\n"
 	".popsection\n"
 );
 
 extern u8 fineibt_preamble_start[];
-extern u8 fineibt_preamble_ud2[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
-#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
+#define fineibt_preamble_ud   6
 #define fineibt_preamble_hash 7
 
+/*
+ * <fineibt_caller_start>:
+ *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
+ *  6:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+ *  a:   0f 1f 40 00             nopl   0x0(%rax)
+ */
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
 	"	movl	$0x12345678, %r10d	\n"
-	"	sub	$16, %r11		\n"
+	"	lea	-0x10(%r11), %r11	\n"
 	ASM_NOP4
 	"fineibt_caller_end:			\n"
 	".popsection				\n"
@@ -1432,15 +1445,15 @@ static void poison_cfi(void *addr)
 }
 
 /*
- * regs->ip points to a UD2 instruction, return true and fill out target and
- * type when this UD2 is from a FineIBT preamble.
+ * When regs->ip points to a 0xEA byte in the FineIBT preamble,
+ * return true and fill out target and type.
  *
  * We check the preamble by checking for the ENDBR instruction relative to the
- * UD2 instruction.
+ * 0xEA instruction.
  */
 bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
-	unsigned long addr = regs->ip - fineibt_preamble_ud2;
+	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
 
 	if (!exact_endbr((void *)addr))
@@ -1451,6 +1464,12 @@ bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
 	*type = (u32)regs->r10 + hash;
 
+	/*
+	 * Since regs->ip points to the middle of an instruction; it cannot
+	 * continue with the normal fixup.
+	 */
+	regs->ip = *target;
+
 	return true;
 
 Efault:
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f36508b..ce033e6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -417,9 +417,8 @@ static void emit_fineibt(u8 **pprog, u32 hash)
 
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
-	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
-	EMIT2(0x0f, 0x0b);				/* ud2			*/
-	EMIT1(0x90);					/* nop			*/
+	EMIT2(0x75, 0xf9);				/* jne.d8 .-7		*/
+	EMIT3(0x0f, 0x1f, 0x00);			/* nop3			*/
 	EMIT_ENDBR_POISON();
 
 	*pprog = prog;

