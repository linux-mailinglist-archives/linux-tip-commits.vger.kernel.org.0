Return-Path: <linux-tip-commits+bounces-4226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E961A62A46
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Mar 2025 10:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E90D189D240
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Mar 2025 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E018DB34;
	Sat, 15 Mar 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bavpjWqK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWxYacxE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A015098F;
	Sat, 15 Mar 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031432; cv=none; b=fUQxOAvOial08twDQF322uQpRmlHJ4YqZYqPdGmmEAXaW3sI624gxogp+ckKuBZZ3HHP2iIwm2goo7c6Ud71ibzGKtmYiE/RLqDeLyRt0GrnP9D4HTvQw6AeKdm6Cdt44uFIPwwwluInxjotZQWGCTtb9iMPiYraDSupn0EvBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031432; c=relaxed/simple;
	bh=Podxq94qhfjiTzkhH2OKB2YqQG0X3XIQSOA0CTo8gtU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jq0H/cf5zWqC5WYbsCMdke24KNUxeQQSIH7VLQexBEkHTEurQrzp7jkLweLjNQx+FPrtlpNIQfgpzMTRLZPrwGed2B6irf41aCPoQhByOZZclGdqkeUYTz7i6XKcMBRk4YJvIjRXbQej33M+ss50RVHBhxsiEqUDn3gHGp76tFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bavpjWqK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWxYacxE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Mar 2025 09:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742031428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G18gL6KLRhYrk77mhZUdT315zzdpIUOlEhlJ+r6Td4M=;
	b=bavpjWqKeOnESF3XouLWN0ECizGI+cbPjcRLDsAMadiPV6Ve7JVoDgvZi4QZ07FuFrXgNd
	Uwnmrn5lkUJsTWgcTUVEoPehPukgNcKSzd1fx1II8uvGPHY/dw8rrI5rS6f0OIss8o8DjA
	xZMwpFIOIok9Fp22sS67hmI8Jhc/X2T7ItjHkmxUg5G0pauemVKRJxMkD6iput4jRFxYIV
	bQdnTdxuK7Y9ge9AtS6T8IiscbHtJccdgIIp5/tCxg9bmHyNGnudHaM/9C7n3HsHnQJ0j6
	28rcqWAXJVvb4LugxRjhL4SVHkHpvLpg7AsUInOmnCC+Gjn1N8NC2q3CY6BWug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742031428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G18gL6KLRhYrk77mhZUdT315zzdpIUOlEhlJ+r6Td4M=;
	b=hWxYacxE8iavNoAg0KKH1XXwYx+vPdYC2LVIx2bEGRaOiaOg7g4evIlTkAf+qffZixiJ9z
	OHq043PmIuBHYFBQ==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Use the uclamp_is_used() helper
 instead of open-coding it
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Hongyan Xia <hongyan.xia2@arm.com>,
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
Message-ID: <174203142782.14745.3072195890652957741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5fca5a4cf97313dd2f5eae29624ceb1dc48f258a
Gitweb:        https://git.kernel.org/tip/5fca5a4cf97313dd2f5eae29624ceb1dc48f258a
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 19 Feb 2025 17:37:46 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Mar 2025 10:26:37 +01:00

sched/uclamp: Use the uclamp_is_used() helper instead of open-coding it

Don't open-code static_branch_unlikely(&sched_uclamp_used), we have
the uclamp_is_used() wrapper around it.

[ mingo: Clean up the changelog ]

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 

