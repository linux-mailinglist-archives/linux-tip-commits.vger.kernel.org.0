Return-Path: <linux-tip-commits+bounces-3976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F1A4ED7E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB50170021
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16427933A;
	Tue,  4 Mar 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Kvl4ZxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQ2a7mg6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95621278109;
	Tue,  4 Mar 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116847; cv=none; b=Jj0Ek7KdWTuAKxZb5QrjCq9OTxCas7J1M6iTTifBU1Zdq1jTz0dlEQJxJDKhl3gNFcXlypxLJJGXQw05axvYYYrnT65t25BAh1O6h4DLOei4n+R+8E6+necWkgiuPpzoTaL4SkLqqaD/6AaXWAlRp4Vhg9SsvwSYXy9mpxmWqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116847; c=relaxed/simple;
	bh=5QbghuNJdbeDoH4sV76FqJgu3HF9h6LS5HnIbaUnAmc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Eq2nF2YKypudqKAM+VPEIobz+EP46YXe3IlACxQYZlX1i0sAv8It0I4EBC8lG9ir7x5kel0FyVYesMIjAFYw1nxq3tqiYOjYgQGr8cfyUDgKwwo25nfR0LrYusT3IFkuxPu9QawOvWDp7tEVqQCKgvczZMKKvZR/RLDDhF2SY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Kvl4ZxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQ2a7mg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCYEiXGuVzEuTDViT1gCvMkyoj4iFfz2oaren0fgpQo=;
	b=3Kvl4ZxYD0LRSbnwvOUVyvtXlBXlsWhPXTkCD88XA5WsrHO/uZWeBtnh095VilxkTsxtyA
	zqdRDlPSymelT/U4e4rwcItuutildZA+xYLUPqqNLDbzuRf0zeJnbz5bQghVFai6+DWK5p
	TN8NcRLNkkiMNzaARdH95f5TUPRJ0NjBj1AhCxis7oIzlb6CBg+HoVw1yMhwuJjzrdYDyE
	6YKyn7Nj2DEtPShhELXMSM9IYhu/MFiwXuNc0Joh01KnHcDqH8M+xY7MhVXGEIA0l3O+I/
	GUrotsfRoUF828RYU0pkiVSSCc2ZoZ/+XxDvRyVEODVOKzjK6QSrjgpauJ+cFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCYEiXGuVzEuTDViT1gCvMkyoj4iFfz2oaren0fgpQo=;
	b=cQ2a7mg6dsMCvD6AKpUKy7iB+Ocw/EVjLayix1ojUyOdDwEqD/2qXEiiO4+TObtwOqKf1J
	gwNz2bLTOVEv2NCA==
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
Message-ID: <174111684366.14745.3819656149455202145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d6bb8b60e0c2be9fb311d6f6ce2530e3dd177450
Gitweb:        https://git.kernel.org/tip/d6bb8b60e0c2be9fb311d6f6ce2530e3dd177450
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:38 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

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

