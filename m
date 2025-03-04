Return-Path: <linux-tip-commits+bounces-3988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B133A4EDB7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210841894674
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0A27815A;
	Tue,  4 Mar 2025 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIGMHuXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0bI7fqV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9184277800;
	Tue,  4 Mar 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117440; cv=none; b=JxVyuyIbxVJ4hvz/Sq7yEts226rH48Zu7402o1RseghsfiJgdq4oiVZ18PRFq2zMDr8U65irjdsk5UntlIs1VL7sgzllAZ6MmN+EnaACm9svl1Mjt/dvJVv1jALpC049/Oqe9lDrhZ1ASDuqgEH6Y7xSJwiM7iW6GEUjokLoMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117440; c=relaxed/simple;
	bh=lwPjjI75HktXq760krvh+GdV/LQ8t/ZdiS+CCwGSUXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GFwV027jqZ0DEYRk3lsiR4jqcHusAhnIJJNIyHxu9rFa/NVifRzce2zTylEx0C02ejI9IVYFIkVUcvBqx6FWf04RLaQF0gp4qW+ClBm6KzU/yKMAMOzYPwV603ZncUtVqykfq53dI+qSmGXO+ClEanw2bPFp7zqLbqE+N1Al6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIGMHuXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0bI7fqV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741117437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA+g1R5s4WbyzsasPjj7nJfYM5UBKRe634U7IO9ZBK4=;
	b=cIGMHuXwX/cTEM29RY+WDqj5QkXd0NsQWJoTolmoM8RXlSCJ4/DLDKHzlGp9JTd3rIAH/a
	crJMjJluOxzEnihCn0m0hz27f1RNC7HwuZ3hTsta+lsUG+FOYBcib8UeqzOfrfGVSAvyNb
	51ibxM0HO2gPVWRiYCL/80zFukgv5/SnmYIXZ7BWED4yU+KrHuZ4v5K0jek2oYg1Q3c3et
	7W0/QMlNOvsgMZYOVzj+KqVsb6inxrY3gGagG4PmZFWlhoKgCl8tgPnoCm6xDtAVurAi0i
	bE7kdTWghVoZ7uPKsFqL9QZ3JQ9pezKgcqjM8DAPOlcU4Re1iFKjMvqXsJ0XYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741117437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA+g1R5s4WbyzsasPjj7nJfYM5UBKRe634U7IO9ZBK4=;
	b=Q0bI7fqVFG/SDLSFTeXmZ5NMUzKx0PReM6wqpb9FRx0SIegkVmbkZrpiXxRRtQ3tnPgyPB
	gXpnBquFwyUAC7BQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/preempt: Move preempt count to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-4-brgerst@gmail.com>
References: <20250303165246.2175811-4-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111743683.14745.5998784827619682097.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     46e8fff6d45fe44cb0939c9339b6d5936551b1e4
Gitweb:        https://git.kernel.org/tip/46e8fff6d45fe44cb0939c9339b6d5936551b1e4
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:38 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:30:33 +01:00

x86/preempt: Move preempt count to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-4-brgerst@gmail.com
---
 arch/x86/include/asm/current.h |  1 -
 arch/x86/include/asm/preempt.h | 25 +++++++++++++------------
 arch/x86/kernel/cpu/common.c   |  4 +++-
 include/linux/preempt.h        |  1 +
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 60bc66e..46a736d 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	int			preempt_count;
 	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	u64			call_depth;
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 919909d..578441d 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -4,10 +4,11 @@
 
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
-#include <asm/current.h>
 
 #include <linux/static_call_types.h>
 
+DECLARE_PER_CPU_CACHE_HOT(int, __preempt_count);
+
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
 
@@ -23,18 +24,18 @@
  */
 static __always_inline int preempt_count(void)
 {
-	return raw_cpu_read_4(pcpu_hot.preempt_count) & ~PREEMPT_NEED_RESCHED;
+	return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
 
 static __always_inline void preempt_count_set(int pc)
 {
 	int old, new;
 
-	old = raw_cpu_read_4(pcpu_hot.preempt_count);
+	old = raw_cpu_read_4(__preempt_count);
 	do {
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
+	} while (!raw_cpu_try_cmpxchg_4(__preempt_count, &old, new));
 }
 
 /*
@@ -43,7 +44,7 @@ static __always_inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(pcpu_hot.preempt_count, (cpu)) = PREEMPT_DISABLED; \
+	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
@@ -57,17 +58,17 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	raw_cpu_and_4(pcpu_hot.preempt_count, ~PREEMPT_NEED_RESCHED);
+	raw_cpu_and_4(__preempt_count, ~PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	raw_cpu_or_4(pcpu_hot.preempt_count, PREEMPT_NEED_RESCHED);
+	raw_cpu_or_4(__preempt_count, PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
 {
-	return !(raw_cpu_read_4(pcpu_hot.preempt_count) & PREEMPT_NEED_RESCHED);
+	return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
 /*
@@ -76,12 +77,12 @@ static __always_inline bool test_preempt_need_resched(void)
 
 static __always_inline void __preempt_count_add(int val)
 {
-	raw_cpu_add_4(pcpu_hot.preempt_count, val);
+	raw_cpu_add_4(__preempt_count, val);
 }
 
 static __always_inline void __preempt_count_sub(int val)
 {
-	raw_cpu_add_4(pcpu_hot.preempt_count, -val);
+	raw_cpu_add_4(__preempt_count, -val);
 }
 
 /*
@@ -91,7 +92,7 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.preempt_count), e,
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
 			       __percpu_arg([var]));
 }
 
@@ -100,7 +101,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-	return unlikely(raw_cpu_read_4(pcpu_hot.preempt_count) == preempt_offset);
+	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f00870b..a9d6153 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2066,12 +2066,14 @@ __setup("setcpuid=", setup_setcpuid);
 
 DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
+DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
+EXPORT_PER_CPU_SYMBOL(__preempt_count);
+
 #ifdef CONFIG_X86_64
 static void wrmsrl_cstar(unsigned long val)
 {
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235..4c1af9b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -319,6 +319,7 @@ do { \
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
+struct task_struct;
 
 /**
  * preempt_ops - notifiers called when a task is preempted and rescheduled

