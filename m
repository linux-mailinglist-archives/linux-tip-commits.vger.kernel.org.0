Return-Path: <linux-tip-commits+bounces-6058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CFB0024E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98591BC5AE3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6B25DB0B;
	Thu, 10 Jul 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6EjZOP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gf4YDwe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE0944F;
	Thu, 10 Jul 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151597; cv=none; b=Zxj+ZkF5Ck4KE+t2VcHjvysWLqFK2LFdeS5jyvXEJKTfVdtJ89Sa8lrHdxNv90SpZY7Q2ZFcqSWgF8jmohWnL5m7TsQOVTHtDrVnuvBim4Jh1CN+XbXpVAx72bt9Eas7kDbqL0FcxFESY5uUpQT7aycJYkK/BD9Ig15x9ozjjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151597; c=relaxed/simple;
	bh=EUy1RWhGkA/UUQuao5MxvwNfL0GVIosP4gkBlPpvJGw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cQYnd1RdW0wPomjxuRcJNI+uUvpKImrEWaUboRMSmdzTC8xs5724ECUWFS1OR24HACkOdyGdgGph+fdaXOKGMqADZjafvjzgvN7jbPOpujBb8cy7O0zAQVpDNY2KO3Knz5U1yxXfycsYFM5usxdiMDGq7AZDSxkxq0x9jJyJzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6EjZOP2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gf4YDwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMDiDo+QTpoPmb+iSoSELZIP2GTaaJBwlzi9+fw2LdY=;
	b=a6EjZOP2Jf5YkEkdexLTqyb4jwsJylwp12e3aLxtUiH9UstK7ULNVbKuj6uDeftxG7zLmb
	uGo4NpwZpxloVC41AoZe0weVi/Zo/oWJBKnFrOz9ZVqhqA8wZyV7Eh+VZw3rr0fx3uk+Ov
	AUAoPBZi5Wu5l30zMG1U8j9y/4uC28viqqOW4HBqwK3GvY1W2qCDTYu+dWikj/MEWAQBB4
	eM4T0Fx6X/NT69KYajvEM53WLZlzU2POyqZpEYpbuo+ZP6cKVWbPpfv0DPfA/BzsX+pSUS
	MPycnN3WHN0m01z2YsiMJZelD+aC/OlIZrqMwyCe5lpGvdWoTDfJ+gjtXSWhiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMDiDo+QTpoPmb+iSoSELZIP2GTaaJBwlzi9+fw2LdY=;
	b=2gf4YDweJdvmrRwSDKDvN0gD9VqJeaEjxjB45ZBeEhi6LtgPRfpO294NwkY0/LuLBBmIWc
	1gFaaKHwRE0ohVDw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix entity's lag with run to parity
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-6-vincent.guittot@linaro.org>
References: <20250708165630.1948751-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159169.406.15823025358050819239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a0baa8e6c570c252999cb651398a88f8f990b4a
Gitweb:        https://git.kernel.org/tip/3a0baa8e6c570c252999cb651398a88f8f990b4a
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:23 +02:00

sched/fair: Fix entity's lag with run to parity

When an entity is enqueued without preempting current, we must ensure
that the slice protection is updated to take into account the slice
duration of the newly enqueued task so that its lag will not exceed
its slice (+ tick).

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250708165630.1948751-6-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45e057f..1660960 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -889,13 +889,13 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  * When run to parity is disabled, we give a minimum quantum to the running
  * entity to ensure progress.
  */
-static inline void set_protect_slice(struct sched_entity *se)
+static inline void set_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 slice = normalized_sysctl_sched_base_slice;
 	u64 vprot = se->deadline;
 
 	if (sched_feat(RUN_TO_PARITY))
-		slice = cfs_rq_min_slice(cfs_rq_of(se));
+		slice = cfs_rq_min_slice(cfs_rq);
 
 	slice = min(slice, se->slice);
 	if (slice != se->slice)
@@ -904,6 +904,13 @@ static inline void set_protect_slice(struct sched_entity *se)
 	se->vprot = vprot;
 }
 
+static inline void update_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	u64 slice = cfs_rq_min_slice(cfs_rq);
+
+	se->vprot = min_vruntime(se->vprot, se->vruntime + calc_delta_fair(slice, se));
+}
+
 static inline bool protect_slice(struct sched_entity *se)
 {
 	return ((s64)(se->vprot - se->vruntime) > 0);
@@ -5467,7 +5474,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		set_protect_slice(se);
+		set_protect_slice(cfs_rq, se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -8720,6 +8727,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
 		goto preempt;
 
+	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
+		update_protect_slice(cfs_rq, se);
+
 	return;
 
 preempt:

