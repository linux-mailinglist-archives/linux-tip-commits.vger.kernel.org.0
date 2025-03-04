Return-Path: <linux-tip-commits+bounces-3986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3688A4EDB3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D73D17349D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64D2780FB;
	Tue,  4 Mar 2025 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4wyTa9e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIjfeGk6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF73276048;
	Tue,  4 Mar 2025 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117439; cv=none; b=Xdofc5qym+N3gvRDjZ0JiPF/yrdPTbsWl1rf4Bl6YG9tyTTdRqL23hVtFGRvnYn+JNWhkq8ImutEtcQP/mDZt+ix15NtOyt7YmzhKT7L0x4thUMQgBWNTjAr2Ip2eXDZ1YuoXghI2CiCVKNR6p0u4ubC7or8hm2Pzs0kr8EGtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117439; c=relaxed/simple;
	bh=rFOfVKWVLD63/nkEuEj00tWXHwizBIe1GrnCJNXMbkc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WFq1Y7wOmSyoWLuBKkPgFhXsAG69AO06DMwd6eyXqtplYoAcqA8Uj+fveIqzbkjYLV0KtgN/aYdxbo+kKq1pDZ/p3Y1PxE3R9ZeolT4trGmH2dyGS8N5i2/BmuP9q4YIDqR6Jk6qWbkU3WmDdEsuJ7L/v39/mClPycq8D0uEAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4wyTa9e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIjfeGk6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741117436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckNB3owsb35ilje+r+MXAFnrlcL67o+6SkmJnBJcTmg=;
	b=q4wyTa9exa7Ci7zbXIgqnZNw42V2c7VhkatXH+4yv/HtFK1MPoX8D6zXwvbobw3sj9K1IL
	Ltx5U1/5QMAjDF8PAi66HgGAiAYvXemq5rAFu/8VJdvsJVlly3UAfQEZ61T2dKugF2rnzx
	EXbsL6dZxw5BJAEg7oGfN62+z+oUS1oK7l55mDRQTOll8XM1MdsaVzhtr09gkSyH8znUjd
	wW13IzZKmf8zO0ssYSDJHOgiHKr4+NlX5X4nT93Pz3bMqv2eryBiq9ArdTq8fzKr7IqhK6
	ydsIXDMWGSsXRxfjhgxwJe73iAQ2D1VNH7gnPAqFVq1KUKF/xAVTkkwCaSmH4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741117436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckNB3owsb35ilje+r+MXAFnrlcL67o+6SkmJnBJcTmg=;
	b=hIjfeGk6JJL2Mx8F0kqEYEYK7dajyfD3Kh0MgZ6q8uYOtk6Z3VOgrI3lnbTh3cr0MZms2u
	F0+Gt1KTBNXEpBDg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retbleed: Move call depth to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-6-brgerst@gmail.com>
References: <20250303165246.2175811-6-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111743546.14745.2858969252097377729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     839be1619fb897364b782997bc2c5d072d7a79f2
Gitweb:        https://git.kernel.org/tip/839be1619fb897364b782997bc2c5d072d7a79f2
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:40 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:30:33 +01:00

x86/retbleed: Move call depth to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-6-brgerst@gmail.com
---
 arch/x86/include/asm/current.h       |  3 ---
 arch/x86/include/asm/nospec-branch.h | 11 ++++++-----
 arch/x86/kernel/asm-offsets.c        |  3 ---
 arch/x86/kernel/cpu/common.c         |  8 ++++++++
 arch/x86/lib/retpoline.S             |  2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index f988462..8ba2c0f 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,9 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-	u64			call_depth;
-#endif
 	unsigned long		top_of_stack;
 	void			*hardirq_stack_ptr;
 	u16			softirq_pending;
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index aee26bb..44c6076 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -12,7 +12,6 @@
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
-#include <asm/current.h>
 
 /*
  * Call depth tracking for Intel SKL CPUs to address the RSB underflow
@@ -78,21 +77,21 @@
 #include <asm/asm-offsets.h>
 
 #define CREDIT_CALL_DEPTH					\
-	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	movq	$-1, PER_CPU_VAR(__x86_call_depth);
 
 #define RESET_CALL_DEPTH					\
 	xor	%eax, %eax;					\
 	bts	$63, %rax;					\
-	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);
 
 #define RESET_CALL_DEPTH_FROM_CALL				\
 	movb	$0xfc, %al;					\
 	shl	$56, %rax;					\
-	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);		\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	sarq	$5, PER_CPU_VAR(__x86_call_depth);		\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #else
@@ -387,6 +386,8 @@ extern void call_depth_return_thunk(void);
 		    __stringify(INCREMENT_CALL_DEPTH),		\
 		    X86_FEATURE_CALL_DEPTH)
 
+DECLARE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
+
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DECLARE_PER_CPU(u64, __x86_call_count);
 DECLARE_PER_CPU(u64, __x86_ret_count);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index a98020b..6fae88f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -109,9 +109,6 @@ static void __used common(void)
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
 	OFFSET(X86_current_task, pcpu_hot, current_task);
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-	OFFSET(X86_call_depth, pcpu_hot, call_depth);
-#endif
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
 	BLANK();
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a9d6153..fd224ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2075,6 +2075,14 @@ DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 #ifdef CONFIG_X86_64
+/*
+ * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
+ * so that this space is reserved in the hot cache section even when the
+ * mitigation is disabled.
+ */
+DEFINE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
+EXPORT_PER_CPU_SYMBOL(__x86_call_depth);
+
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 038f49a..a26c43a 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -343,7 +343,7 @@ SYM_FUNC_START(call_depth_return_thunk)
 	 * case.
 	 */
 	CALL_THUNKS_DEBUG_INC_RETS
-	shlq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth)
+	shlq	$5, PER_CPU_VAR(__x86_call_depth)
 	jz	1f
 	ANNOTATE_UNRET_SAFE
 	ret

