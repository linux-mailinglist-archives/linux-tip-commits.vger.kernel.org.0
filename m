Return-Path: <linux-tip-commits+bounces-3370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DAA36D70
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3683218956F8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060891A7262;
	Sat, 15 Feb 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYb+VnMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXvgKj6x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09C19D8AC;
	Sat, 15 Feb 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617000; cv=none; b=YVVAwvvKUZq0MkPPpe5XqCdCBJeuglOxEtQAFCLqkDUYKovbkC2YzUhpKttt4m44LL3hybJbfQZB7wpnMYxpar6p2jMShI5H3JblCBLmGBvpA59oEn5nJLf93BD9ZGTNmKHrRfjpd9+i+57206YuktEstng7c3Pi23Cjeoso4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617000; c=relaxed/simple;
	bh=0EpzDWIm9cl5Xkdwk4yaB2P2H7gqvQ37qGAoy1nCqjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F0J82sxOj8jlMTlqp9lcI5uw2jZXzEtXqyk0JLvvdCTTXB59HCRT+N4Q5I//jxuZCVCFj24IL3n+mbYrcVd2DArazL0ZGBw+/tEqlFNuLcIdmkAgP3FEKdrR21bmrVS3no6pblXyTcKhMnduxQeIADI7vXF8TxNzfjZ/bU8DIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VYb+VnMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXvgKj6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6lrzJXG3xIpQht/p5fdCLRFyJxX6w2b/fGiLMIuzCI=;
	b=VYb+VnMZ70j4W9GD+tZwB/y9ncfjbmRnW2p2kZKScpW4MFuSox3kl/LwTRevV8xmF9v42M
	SeSCDdw2HO4BTLGBEpmz7Sqk8q/AQCkcoYIpWHQg+Vyc61tNHEzsfRzfbR69iDViJCF4OE
	xmoZxFv/suHVXzBZKkzQ/ClZnrGxcCWCHQqikUTv7gZHNqEMJaj2DQEbUGWpR2j/2jka15
	KTX2aH475qnikup8c9WGnM3Rlz8eJZZbZGjsRnIPgwx9zaAlISuEYFCRaYSl4pQbTFI0ZQ
	gYSIYr/Jcs+yK5hIn/2RmyoHlxSXe+tTxaqEu55zq47+IMFByFFFBWhkpT8XiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6lrzJXG3xIpQht/p5fdCLRFyJxX6w2b/fGiLMIuzCI=;
	b=XXvgKj6x++v8zf+3j1xK+3LB//4OG3CyUkpE3f/z7mzY87+HJvoUpfPvpTJmRJv2rZ5F7b
	48l2WFe/J+3Sv0DA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Handle FineIBT in handle_cfi_failure()
Cc: Sami Tolvanen <samitolvanen@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214092619.GB21726@noisy.programming.kicks-ass.net>
References: <20250214092619.GB21726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699585.10177.15712455227180390795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     882b86fd4e0d49bf91148dbadcdbece19ded40e6
Gitweb:        https://git.kernel.org/tip/882b86fd4e0d49bf91148dbadcdbece19ded40e6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 Feb 2025 12:45:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:07 +01:00

x86/ibt: Handle FineIBT in handle_cfi_failure()

Sami reminded me that FineIBT failure does not hook into the regular
CFI failure case, and as such CFI_PERMISSIVE does not work.

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20250214092619.GB21726@noisy.programming.kicks-ass.net
---
 arch/x86/include/asm/cfi.h    | 11 +++++++++++
 arch/x86/kernel/alternative.c | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cfi.c         | 22 ++++++++++++++++++----
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c8..7dd5ab2 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -126,6 +126,17 @@ static inline int cfi_get_offset(void)
 
 extern u32 cfi_get_func_hash(void *func);
 
+#ifdef CONFIG_FINEIBT
+extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+#else
+static inline bool
+decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	return false;
+}
+
+#endif
+
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e285933..247ee5f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1065,6 +1065,7 @@ asm(	".pushsection .rodata			\n"
 	"	endbr64				\n"
 	"	subl	$0x12345678, %r10d	\n"
 	"	je	fineibt_preamble_end	\n"
+	"fineibt_preamble_ud2:			\n"
 	"	ud2				\n"
 	"	nop				\n"
 	"fineibt_preamble_end:			\n"
@@ -1072,9 +1073,11 @@ asm(	".pushsection .rodata			\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_ud2[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
 #define fineibt_preamble_hash 7
 
 asm(	".pushsection .rodata			\n"
@@ -1410,6 +1413,33 @@ static void poison_cfi(void *addr)
 	}
 }
 
+/*
+ * regs->ip points to a UD2 instruction, return true and fill out target and
+ * type when this UD2 is from a FineIBT preamble.
+ *
+ * We check the preamble by checking for the ENDBR instruction relative to the
+ * UD2 instruction.
+ */
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_preamble_ud2;
+	u32 endbr, hash;
+
+	__get_kernel_nofault(&endbr, addr, u32, Efault);
+	if (endbr != gen_endbr())
+		return false;
+
+	*target = addr + fineibt_preamble_size;
+
+	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
+	*type = (u32)regs->r10 + hash;
+
+	return true;
+
+Efault:
+	return false;
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index e6bf78f..f6905be 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -70,11 +70,25 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 	unsigned long target;
 	u32 type;
 
-	if (!is_cfi_trap(regs->ip))
-		return BUG_TRAP_TYPE_NONE;
+	switch (cfi_mode) {
+	case CFI_KCFI:
+		if (!is_cfi_trap(regs->ip))
+			return BUG_TRAP_TYPE_NONE;
+
+		if (!decode_cfi_insn(regs, &target, &type))
+			return report_cfi_failure_noaddr(regs, regs->ip);
+
+		break;
 
-	if (!decode_cfi_insn(regs, &target, &type))
-		return report_cfi_failure_noaddr(regs, regs->ip);
+	case CFI_FINEIBT:
+		if (!decode_fineibt_insn(regs, &target, &type))
+			return BUG_TRAP_TYPE_NONE;
+
+		break;
+
+	default:
+		return BUG_TRAP_TYPE_NONE;
+	}
 
 	return report_cfi_failure(regs, regs->ip, &target, type);
 }

