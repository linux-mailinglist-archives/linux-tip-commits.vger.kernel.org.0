Return-Path: <linux-tip-commits+bounces-6060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2792B00251
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA25F5641AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F845273818;
	Thu, 10 Jul 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Crpn/aXW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3XWBXhM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44725F986;
	Thu, 10 Jul 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151599; cv=none; b=uKhtaEhb9hDVZSbcwtFxinp8FHTibTaAAAYTBICd82PUnk8NRGUBQRKWHyqaoCmEqySWA4fq4xgrpMPN25LNXMYzqaLxlAkP/jONLd8yFbYo01IiAXdoMeUdry4s5bkrA2tVXsHuMZKrEjgEKPDzVe697Ya1648GY3nYrCIga1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151599; c=relaxed/simple;
	bh=a0tVkI3BUkdEZFtkB7aIOPZq0eCdwV7KzbnLMAGCMs0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dmk1dSN2/GXpCSm2Xldhm/IThY+bq4leThlI4Edabj3ZDOFpR6yOAKl/NoD4xTkOmwZ3TxNFfpamP0+y8JL8zlpTwKT0Wk5nQmo3ym1pjAOGyYnwXwZNm5LD8FtSqsiv9Ij4dEI2Je9k2TZlKZtMkH2rjcqDQcGYZ1nBEiPmPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Crpn/aXW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y3XWBXhM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiMpFINyJfC6fh4irfgewySWr/wpaxAQUq0mTu9kJ/w=;
	b=Crpn/aXWX+jkfHzQ1K/Q4mgjJRSS8eIOVa4WzTyyYzDHca7634MTvk22Ut1eFaiJt1un8v
	wH7v6mRqYwReHGLe7B78/pvRJOf12TD5wWjeZ59KjIFA0TxUEZC66IUt7XlfXDbEtjOkCf
	hkHZJlihVYGBqqgse+x7hGbhCjquAg0SLJGLSrwZp3UyNA4/6DGFXQJribRRydyuA25igd
	UllFHiKYcRW8URT2SDPXHlA0wAndl+dJlDJcp1gGd9b9+aWtYTtQGaiyAzaVJagZfnJ0Mw
	1PMqmAbccQ5UVbOnh8VNGSFKwgwv01HqwwgrIJhsn3J0jHuDzVxaMQtH/uWpbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiMpFINyJfC6fh4irfgewySWr/wpaxAQUq0mTu9kJ/w=;
	b=Y3XWBXhMpq2uL/JLD8qaEDPLmImZSNW9SyJ56/lshcntEm4cU5FYFnxr6TNab24PkmAaV3
	noNpDdgVkGQ1TYAw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix NO_RUN_TO_PARITY case
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-3-vincent.guittot@linaro.org>
References: <20250708165630.1948751-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159451.406.1574940645817260327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     74eec63661d46a7153d04c2e0249eeb76cc76d44
Gitweb:        https://git.kernel.org/tip/74eec63661d46a7153d04c2e0249eeb76cc76d44
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:22 +02:00

sched/fair: Fix NO_RUN_TO_PARITY case

EEVDF expects the scheduler to allocate a time quantum to the selected
entity and then pick a new entity for next quantum.
Although this notion of time quantum is not strictly doable in our case,
we can ensure a minimum runtime for each task most of the time and pick a
new entity after a minimum time has elapsed.
Reuse the slice protection of run to parity to ensure such runtime
quantum.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250708165630.1948751-3-vincent.guittot@linaro.org
---
 include/linux/sched.h | 10 +++++++++-
 kernel/sched/fair.c   | 31 ++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4802fcf..5592138 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -583,7 +583,15 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
-	s64				vlag;
+	union {
+		/*
+		 * When !@on_rq this field is vlag.
+		 * When cfs_rq->curr == se (which implies @on_rq)
+		 * this field is vprot. See protect_slice().
+		 */
+		s64                     vlag;
+		u64                     vprot;
+	};
 	u64				slice;
 
 	u64				nr_migrations;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43fe5c8..8d288df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -882,23 +882,35 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 }
 
 /*
- * HACK, stash a copy of deadline at the point of pick in vlag,
- * which isn't used until dequeue.
+ * Set the vruntime up to which an entity can run before looking
+ * for another entity to pick.
+ * In case of run to parity, we protect the entity up to its deadline.
+ * When run to parity is disabled, we give a minimum quantum to the running
+ * entity to ensure progress.
  */
 static inline void set_protect_slice(struct sched_entity *se)
 {
-	se->vlag = se->deadline;
+	u64 slice = se->slice;
+	u64 vprot = se->deadline;
+
+	if (!sched_feat(RUN_TO_PARITY))
+		slice = min(slice, normalized_sysctl_sched_base_slice);
+
+	if (slice != se->slice)
+		vprot = min_vruntime(vprot, se->vruntime + calc_delta_fair(slice, se));
+
+	se->vprot = vprot;
 }
 
 static inline bool protect_slice(struct sched_entity *se)
 {
-	return se->vlag == se->deadline;
+	return ((s64)(se->vprot - se->vruntime) > 0);
 }
 
 static inline void cancel_protect_slice(struct sched_entity *se)
 {
 	if (protect_slice(se))
-		se->vlag = se->deadline + 1;
+		se->vprot = se->vruntime;
 }
 
 /*
@@ -937,7 +949,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	if (sched_feat(RUN_TO_PARITY) && curr && protect_slice(curr))
+	if (curr && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -1156,11 +1168,8 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	cgroup_account_cputime(p, delta_exec);
 }
 
-static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+static inline bool resched_next_slice(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	if (!sched_feat(PREEMPT_SHORT))
-		return false;
-
 	if (protect_slice(curr))
 		return false;
 
@@ -1248,7 +1257,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_queued == 1)
 		return;
 
-	if (resched || did_preempt_short(cfs_rq, curr)) {
+	if (resched || resched_next_slice(cfs_rq, curr)) {
 		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}

