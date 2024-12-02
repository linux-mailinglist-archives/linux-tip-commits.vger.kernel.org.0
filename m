Return-Path: <linux-tip-commits+bounces-2941-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AD9E0036
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A10281FA9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1520B802;
	Mon,  2 Dec 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4I750X8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uI4G+7I1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD220B1F4;
	Mon,  2 Dec 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138128; cv=none; b=T1ZujS/8p0qJ/L9wdcFXUegrwDasphhNRAhTE6KyI8Qd81BN7WZ7Sq9ncALc3c96LAXHR1esrr2JUzzeV8bN3eECQKEIQeDfhYOc8iiBF9PTBXILuj0ZWDRl4tnfj/PZtNQvH1stkioXxrISjph9lh8K+5KOyELdwWvQGbmrBjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138128; c=relaxed/simple;
	bh=eMWOWZkTaFB6b0FN2dWf2RzsiZibvCZec5eNc7dO720=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b4mHcmvpr5270SEXU7qKRdbUTStOeUDYkSO+9h6JDLF8n63osydbz4B7noI72pYVn+Smm3AV29v30uKSlViBTT0EQawAHqIlxRFOjehc2V0h7LXziWoLUvRKMuitmpLReVleRR5kYnCk5zHH3row2c2U4ItFyBtJdvaszwp/QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4I750X8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uI4G+7I1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKSbqUAQFREAmFyCOZSzoSg4J0v08d4ypkBxHHLDSvI=;
	b=J4I750X8JpdGQhy/Fm8F4PQZdKsRaIAUIvDk0I9y9XVmnwrsIsJfzdjelMo01WIYmuNDA1
	G/RfwdT9FzomqjxFXqFGmoVgXcY4KGYgixGCjqXSlFBtQ09Au6oxym8IwTl1qDXUufRhEw
	mXOExUU19n2JQ7p3W9Sk/cx57xvLKKBcP/vrcn0ohqIL7jhFSSbdYvZStpOCHuZRO8om3R
	7VrFued0kYmtc+ZklH8S9vWlpB8DUW9wWztpNjZZaFcpyNgBp4qFxIwfFxwxETGE1Lw/2q
	X7QHB1MHk2pN9945+B22swl8EStAqBCKAl/qh36OmUWjwPvsQuuGDR/EQs+IGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKSbqUAQFREAmFyCOZSzoSg4J0v08d4ypkBxHHLDSvI=;
	b=uI4G+7I10Ew0MTsHQuuG22tJILnpiwpmp/+1PpzY370TEtuKn6uPwVL+k4f42oXln5UYSl
	DNkWueIkr8lmJkDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Collect more annotations in objtool.h
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.786598147@infradead.org>
References: <20241128094311.786598147@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812323.412.11711989942586825957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bb8170067470cc7af28e4386e600b1e0a6a8956a
Gitweb:        https://git.kernel.org/tip/bb8170067470cc7af28e4386e600b1e0a6a8956a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:43 +01:00

objtool: Collect more annotations in objtool.h

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.786598147@infradead.org
---
 arch/x86/include/asm/alternative.h   | 12 +----
 arch/x86/include/asm/nospec-branch.h |  9 +---
 include/linux/instrumentation.h      |  4 +-
 include/linux/objtool.h              | 80 +++++++++++++++++----------
 4 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 595695f..e3903b7 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -56,12 +56,6 @@
 #endif
 
 /*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
-
-/*
  * The patching flags are part of the upper bits of the @ft_flags parameter when
  * specifying them. The split is currently like this:
  *
@@ -308,12 +302,6 @@ void nop_func(void);
 #endif
 
 /*
- * objtool annotation to ignore the alternatives and only consider the original
- * instruction(s).
- */
-#define ANNOTATE_IGNORE_ALTERNATIVE ANNOTATE type=ANNOTYPE_IGNORE_ALTS
-
-/*
  * Issue one struct alt_instr descriptor entry (need to put it into
  * the section .altinstructions, see below). This entry contains
  * enough information for the alternatives patching code to patch an
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 50340a1..7e8bf78 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -180,13 +180,6 @@
 #ifdef __ASSEMBLY__
 
 /*
- * This should be used immediately before an indirect jump/call. It tells
- * objtool the subsequent indirect jump/call is vouched safe for retpoline
- * builds.
- */
-#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
-
-/*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
  * vs RETBleed validation.
  */
@@ -345,8 +338,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
-
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index c8f866c..bf675a8 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -10,7 +10,7 @@
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_BEGIN)\
+		     ANNOTATE_INSTR_BEGIN(__ASM_BREF(c))		\
 		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
@@ -48,7 +48,7 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_END)	\
+		     ANNOTATE_INSTR_END(__ASM_BREF(c))			\
 		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 42287c1..fd487d4 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -63,8 +63,6 @@
 	"911:\n\t"						\
 	__ASM_ANNOTATE(911b, type)
 
-#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
-
 #else /* __ASSEMBLY__ */
 
 /*
@@ -113,19 +111,6 @@
 #endif
 .endm
 
-/*
- * Use objtool to validate the entry requirement that all code paths do
- * VALIDATE_UNRET_END before RET.
- *
- * NOTE: The macro must be used at the beginning of a global symbol, otherwise
- * it will be ignored.
- */
-#if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
-#define VALIDATE_UNRET_BEGIN	ANNOTATE type=ANNOTYPE_UNRET_BEGIN
-#else
-#define VALIDATE_UNRET_BEGIN
-#endif
 
 .macro REACHABLE
 .Lhere_\@:
@@ -142,14 +127,6 @@
 	.popsection
 .endm
 
-#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
-
-/*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warning.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
-
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -161,16 +138,12 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
-#define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
-#define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro ANNOTATE_NOENDBR
-.endm
 .macro REACHABLE
 .endm
 .macro ANNOTATE type:req
@@ -179,4 +152,57 @@
 
 #endif /* CONFIG_OBJTOOL */
 
+#ifndef __ASSEMBLY__
+/*
+ * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
+ * these relocations will never be used for indirect calls.
+ */
+#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
+/*
+ * See linux/instrumentation.h
+ */
+#define ANNOTATE_INSTR_BEGIN(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_BEGIN)
+#define ANNOTATE_INSTR_END(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_END)
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL	ASM_ANNOTATE(ANNOTYPE_INTRA_FUNCTION_CALL)
+/*
+ * Use objtool to validate the entry requirement that all code paths do
+ * VALIDATE_UNRET_END before RET.
+ *
+ * NOTE: The macro must be used at the beginning of a global symbol, otherwise
+ * it will be ignored.
+ */
+#define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
+
+#else
+#define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
+#define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
+/*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=ANNOTYPE_INSTR_BEGIN */
+/*	ANNOTATE_INSTR_END		ANNOTATE type=ANNOTYPE_INSTR_END */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
+#define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
+#define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#endif
+
+#if defined(CONFIG_NOINSTR_VALIDATION) && \
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
+#define VALIDATE_UNRET_BEGIN	ANNOTATE_UNRET_BEGIN
+#else
+#define VALIDATE_UNRET_BEGIN
+#endif
+
 #endif /* _LINUX_OBJTOOL_H */

