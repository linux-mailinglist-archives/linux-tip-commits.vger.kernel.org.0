Return-Path: <linux-tip-commits+bounces-2156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51646969F34
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C731C23C85
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E23A267;
	Tue,  3 Sep 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwr6pl33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7hbMpxF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6E1E4AD;
	Tue,  3 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370708; cv=none; b=q7c/KDANbWW/jj/rdEUGlQlKq6n36MsAtdOKPVYAr529N5p2v76lAkTDFGJlR5s6RV/qt17rro6FOV/VOftaK21VjwdEeOk/S5w8kk0YDl3usu++sbwUyFVHVNiZI+1w+f/NOx2DgCIBCG28kMABNKdGsj1Wu4kbOzlnZ0blORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370708; c=relaxed/simple;
	bh=i9B8WKlUvkkKErLDXvmZWsiNaCIFL18hziVaL6MpOQ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WV5bVl52+afdJg9dqlYzjYwQDz3wQCzu419MvqWItzcr/67v+6JBpC6UhbMzsoxmjyenSYmQzrC4/WwP1Ir7kgf24D2sFakJ2JjKSE9TOkVFQun5eLlB+xtWaH2u1hKcsANqVzKGfLmg+xbf5SdQhG4Lb1/oh+UAHCnDDNBGaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwr6pl33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7hbMpxF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+ZuHw6riyfhEA/Rp+oBw3hEz0I4hrrsBv7r/rSbU3w=;
	b=dwr6pl33QE0VZGiMYp14MZB+DCFI6bY4wDMkBdem6ygnjho1cD5AFcufUUmA1Lu3VELZg7
	CO8e/zcE4MXcgi9tTEtMcToOroOEsyo0Dwp+q4E7YDfUOBd/TmNFX00wCMxd19oMzmzS+G
	xgot7rPyEtykVr4nrNZi90zwGf+sSIpkSLTYQd+WhJaoOzUlIAD8yxMSrKIR2+qeWU4tYC
	QY9vueAJBi9OTJQGT0E/74VMJnfbC5yzJqJ3mzCgNID0lDtwR5AhXOfVgWK+tVKVATIopr
	0J7Yz0DCYzBOk7+F0j0CEmpA2B9vE4TQgHg9cXcTwURuVYup1xoSxnkXK6/V8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+ZuHw6riyfhEA/Rp+oBw3hEz0I4hrrsBv7r/rSbU3w=;
	b=z7hbMpxFRIQ/1dwJllXWiB+6Yo0nTmCx6c8YlkcMAGAFXo6p9J1wLXAFRqsyJ5ctIMQyi2
	2UuYoYUE4ZGLUMCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fixup set_next_task() implementations
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224015.724111109@infradead.org>
References: <20240813224015.724111109@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070185.2215.14750958986616718887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dae4320b29f0bbdae93f7c1f6f80b19f109ca0bc
Gitweb:        https://git.kernel.org/tip/dae4320b29f0bbdae93f7c1f6f80b19f109ca0bc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:30 +02:00

sched: Fixup set_next_task() implementations

The rule is that:

  pick_next_task() := pick_task() + set_next_task(.first = true)

Turns out, there's still a few things in pick_next_task() that are
missing from that combination.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224015.724111109@infradead.org
---
 kernel/sched/deadline.c |  6 ++--
 kernel/sched/fair.c     | 62 ++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2e84037..f7ac7cf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2386,6 +2386,9 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
+
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
@@ -2452,9 +2455,6 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	if (!p->dl_server)
 		set_next_task_dl(rq, p, true);
 
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, &p->dl);
-
 	return p;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a3286d..eaeb8b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8760,6 +8760,9 @@ again:
 	return task_of(se);
 }
 
+static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -8808,33 +8811,17 @@ again:
 
 		put_prev_entity(cfs_rq, pse);
 		set_next_entity(cfs_rq, se);
+
+		__set_next_task_fair(rq, p, true);
 	}
 
-	goto done;
+	return p;
+
 simple:
 #endif
 	if (prev)
 		put_prev_task(rq, prev);
-
-	for_each_sched_entity(se)
-		set_next_entity(cfs_rq_of(se), se);
-
-done: __maybe_unused;
-#ifdef CONFIG_SMP
-	/*
-	 * Move the next running task to the front of
-	 * the list, so our cfs_tasks list becomes MRU
-	 * one.
-	 */
-	list_move(&p->se.group_node, &rq->cfs_tasks);
-#endif
-
-	if (hrtick_enabled_fair(rq))
-		hrtick_start_fair(rq, p);
-
-	update_misfit_status(p, rq);
-	sched_fair_update_stop_tick(rq, p);
-
+	set_next_task_fair(rq, p, true);
 	return p;
 
 idle:
@@ -13145,12 +13132,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 	}
 }
 
-/* Account for a task changing its policy or group.
- *
- * This routine is mostly called to set cfs_rq->curr field when a task
- * migrates between groups/classes.
- */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 
@@ -13163,6 +13145,27 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		list_move(&se->group_node, &rq->cfs_tasks);
 	}
 #endif
+	if (!first)
+		return;
+
+	SCHED_WARN_ON(se->sched_delayed);
+
+	if (hrtick_enabled_fair(rq))
+		hrtick_start_fair(rq, p);
+
+	update_misfit_status(p, rq);
+	sched_fair_update_stop_tick(rq, p);
+}
+
+/*
+ * Account for a task changing its policy or group.
+ *
+ * This routine is mostly called to set cfs_rq->curr field when a task
+ * migrates between groups/classes.
+ */
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+{
+	struct sched_entity *se = &p->se;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -13172,10 +13175,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
 
-	if (!first)
-		return;
-
-	SCHED_WARN_ON(se->sched_delayed);
+	__set_next_task_fair(rq, p, first);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)

