Return-Path: <linux-tip-commits+bounces-4225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD3A61C9E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64D1460502
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76402063D6;
	Fri, 14 Mar 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xp1nQ/vq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zd0bt+Om"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CB2054EE;
	Fri, 14 Mar 2025 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983898; cv=none; b=P3yoOfshdk+qEJNlS27VKmABZ2JsIhJLRNFMa+/cfHLOel3XueWsKJhQP44TPnSGRIPvBCQAg+E+hzJsa62h4GtYlIPfGGsit1aL12q7hC23jwkNyBTM6m370LXUcSEj3z4KWHZZES2q+47lBnV6hdxpdQmtCH0wj1xNi19ez40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983898; c=relaxed/simple;
	bh=b26uyQ+aofqffXRLNtnu1tzRD6zwtdebtw5/vfRuDLA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dw3GtyCZHlKKhyDH3gmQAOFwhiUYoKVb5JkSXssHrPKpEUxdPmgsocrelXq0hHmBbCna11M+Y7KfOmRm19C/cg6rw0Jj5VJR69d1p4ra90EOwWlg1jznHkRF4v/FH2FBOJKMNkNYdMoouf6hUts1nBuofB/KlXjl1U5pCraaTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xp1nQ/vq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zd0bt+Om; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741983895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3aswdCdHTABWoDbNKTpfKSvKyBgCYxJGUS0FVhMtgw=;
	b=xp1nQ/vqaY5iJFAWf3g/D5msD1MTf+YKlNNsj7etsMMu6hmUUxA5m5ZNo8j21D14glzBAr
	5GnmJw7mTI0fBWi0Ibz/Nsg4wMvGKaZ4xtFn8YhYuJ1noEremznaU/c0pysuMLZrDBOZFf
	+NODL0kZCJlL5RZ57fNVgfZ7ZVzoVSPJYiuN++M/dwdQ82qMlTTNrV9ZxvjxywaD2kj+V2
	4thJifIBirp55CcNa7dTBTIPZjkrqReeQRHv0bi2LL12gAaAR17PPqOxaxTz8Pe7S4fvjH
	Lpg8VPwXrRIzsyCS6zxEVq/S4VoxQimT2rx/J14aQ6xXmA924yOUg8cwKVJxnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741983895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3aswdCdHTABWoDbNKTpfKSvKyBgCYxJGUS0FVhMtgw=;
	b=zd0bt+OmHC5oA5WLR5p8mt+kwtNlKA4FfGlap34UemXPFrDNLC1wFlbI/D4+4JzfpQ85Z5
	n7pi/bd5CYqyMjDQ==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Always using uclamp_is_used()
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Hongyan Xia <hongyan.xia2@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219093747.2612-1-xuewen.yan@unisoc.com>
References: <20250219093747.2612-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198389421.14745.12951843087386226788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     12fc0fdcbd1cc2f906596b77c03d7e5ed58947d1
Gitweb:        https://git.kernel.org/tip/12fc0fdcbd1cc2f906596b77c03d7e5ed58947d1
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 19 Feb 2025 17:37:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Mar 2025 21:13:18 +01:00

sched/uclamp: Always using uclamp_is_used()

Now, we have the uclamp_is_used() func to judge the uclamp enabled,
so replace the static_branch_unlikely(&sched_uclamp_used) with it.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250219093747.2612-1-xuewen.yan@unisoc.com
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/sched.h | 28 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 621cfc7..45daa41 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1756,7 +1756,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
@@ -1783,7 +1783,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 023b844..8d42d3c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3394,6 +3394,19 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
+/*
+ * When uclamp is compiled in, the aggregation at rq level is 'turned off'
+ * by default in the fast path and only gets turned on once userspace performs
+ * an operation that requires it.
+ *
+ * Returns true if userspace opted-in to use uclamp and aggregation at rq level
+ * hence is active.
+ */
+static inline bool uclamp_is_used(void)
+{
+	return static_branch_likely(&sched_uclamp_used);
+}
+
 static inline unsigned long uclamp_rq_get(struct rq *rq,
 					  enum uclamp_id clamp_id)
 {
@@ -3417,7 +3430,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
 	unsigned long rq_util;
 	unsigned long max_util;
 
-	if (!static_branch_likely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return false;
 
 	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
@@ -3426,19 +3439,6 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
 	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
 }
 
-/*
- * When uclamp is compiled in, the aggregation at rq level is 'turned off'
- * by default in the fast path and only gets turned on once userspace performs
- * an operation that requires it.
- *
- * Returns true if userspace opted-in to use uclamp and aggregation at rq level
- * hence is active.
- */
-static inline bool uclamp_is_used(void)
-{
-	return static_branch_likely(&sched_uclamp_used);
-}
-
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
 

