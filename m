Return-Path: <linux-tip-commits+bounces-3848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BFA4D64E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971C33AAD89
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B81FC7EC;
	Tue,  4 Mar 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAxJskcN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDznIPeJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BC1FBEB9;
	Tue,  4 Mar 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076872; cv=none; b=j5ag9FA5JT+NU+pTbQIyeapNYqxWaMUSLGhfTmBoQAXBL+qXfu8vrSzpub4e0F935+PbSDz+J/Uom1UYl328/Bkzlt+vIFhQAIDeuqPueuDo2Z2xR8a+I7k+MdgbSjf54QJJuBp8NxwB2m/nlMWrY9W9UL8zC+yn9z0QcCkH/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076872; c=relaxed/simple;
	bh=EH4Ns7RGVUwvPNPq415WG7MXhhwqqmCfRwGWkfGL4bQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h5uB7oEapJF0aLdD2O72waLVL0aCMDxv6c/oPosViyvU3nsk5AOpPDXWl6jKdWmOiv6+ASn7NgRCPDl2Y1yv231+iEuBlKWqmYCcCT5qY5+8tOhv1tPMjcRp/PP67AUQuP2zdLZw7fAtOVrOGDGEcwz6CTUpGafepOIe/Zxtfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAxJskcN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDznIPeJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp6bCnZBpNShy0/dkxT8SVr+AanNcMDDnJUzsy0bQ5o=;
	b=pAxJskcNxP5jWru9C9NlnbdD2pgfCkvwUYw0KPE5Rn5CHsNy3ljph14l7dHoV+1okXJ+bD
	nGcxibyJId+ACnBabLD9bTRek7h2dFt3Ju9c5ZlEZzVMy5KFn9zwa423ekhF51rl2A0NFR
	+6k4n+afvqbirjoktg0mlRpu8CD61qw18ZSBODa21EMgBVcFOEHkFR1Vd5WsSHiyuGTAZK
	BgUzQ2AUAQYruekkrg9voZrkzZp3tgvVqRh52+BvAH9RFSh+Q3wGpQpNuQ90b/LiaodKYa
	H2NMARqyv0y1dFyXdARTTu1t3vNa1zZ/pZ/9cut/ugz+pu8F7E9YmIF4RWrtQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp6bCnZBpNShy0/dkxT8SVr+AanNcMDDnJUzsy0bQ5o=;
	b=WDznIPeJppJdshZgKkvqT7o2vxXNvA+UmuhtrTRhZIIssQmnOkZjzmGpaRAJdl/yBgjao1
	0uwwUxm5wGvq+YAA==
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
Message-ID: <174107686802.14745.1591483482446970377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e836c9cd89d097603e80a1a0d1c90d887f573129
Gitweb:        https://git.kernel.org/tip/e836c9cd89d097603e80a1a0d1c90d887f573129
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:40 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:41 +01:00

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
index 7e8bf78..a560205 100644
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
@@ -388,6 +387,8 @@ extern void call_depth_return_thunk(void);
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
index c479d3c..ffa291c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2058,6 +2058,14 @@ DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
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

