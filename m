Return-Path: <linux-tip-commits+bounces-2919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA289E000A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE1281B05
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18481FDE3E;
	Mon,  2 Dec 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zc/VPS7q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txF+sRBp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D51FA167;
	Mon,  2 Dec 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138085; cv=none; b=ueq5ba2TW/mWD5p9WQcSOhzKqbO9noDzssBFXuv9B3Ia5q8OXBHmAdm6ivhx3j9gxJTuHA7OEUCGtSUKtts7c3YQ3zpg6xUWH+m26c7q03A34dYajJp0RXfaPcXM9TZViQfA4Fu79F8njjiEmikzNtGwaIKMgUlSLvfxh6ohZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138085; c=relaxed/simple;
	bh=ZMi1c7ThN0G83/xaaTt2VYyBOdETvQmIdvzSlcG+tiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W442epWrReszGnBRXBBLXPLhYhwtnwZJLk7furPDKCV6gFW3f+G6uI2mn1X8yFPAiEfHrXniqiUfMvTaXY/WLbEZAiWFe9GKcav1sXeKrABNrClGYBjNNcXZX9NQ3PeNOgDJFbx1ptNy9S50HL6iBxf8VKQITYcWLEXNki7kCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zc/VPS7q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txF+sRBp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cenA/UTw4tRdp9nL3KQrUkdXLtm2ApY+26ZlBPHNFT0=;
	b=Zc/VPS7qaKPaIP/4YtsuLTFv7cOtM7qSulTjaVFreHNWtYQyJmVPQ/JehgWfnLnEWdXHZ6
	cE97sKI8G+aw5pjEwZ0jcpsRZfjY+mbCzCqcms2oy1EFWnuJs9oLmH0wTbi6ZSceWB1Uu0
	gzgK5uR68NyDJahUp1/UybkWhVOdxventM85v0eGIwJrJN94uzHHa/WOgiMMh4lviQqq5R
	mHPYIgRgygQs8lXJlNfteA33FxpszA6QQyqrFycc8JBIP7BPCFm8BBOzVD0AHuL1pvxJ1u
	TlXCI3aTM7NFG6f8Ca1aboAgNp9RfxnF7Lkxno9kJrE0x9skvqWvbhClwCyvHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cenA/UTw4tRdp9nL3KQrUkdXLtm2ApY+26ZlBPHNFT0=;
	b=txF+sRBpVyvtJtBPbuTtXH5Y0uGICCylHEL6nO2OLdzVjz/CLGaLp/zCtxxNmICOJNFJXB
	w7P3gYko1/jlJUAQ==
From: "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Consolidate Timer Cancellation
Cc: Wander Lairson Costa <wander@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240724142253.27145-3-wander@redhat.com>
References: <20240724142253.27145-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808183.412.15845553244301795873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a181f20fb4e9ad3c93ea6c71520c23826042629
Gitweb:        https://git.kernel.org/tip/3a181f20fb4e9ad3c93ea6c71520c23826042629
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Wed, 24 Jul 2024 11:22:48 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:31 +01:00

sched/deadline: Consolidate Timer Cancellation

After commit b58652db66c9 ("sched/deadline: Fix task_struct reference
leak"), I identified additional calls to hrtimer_try_to_cancel that
might also require a dl_server check. It remains unclear whether this
omission was intentional or accidental in those contexts.

This patch consolidates the timer cancellation logic into dedicated
functions, ensuring consistent behavior across all calls.
Additionally, it reduces code duplication and improves overall code
cleanliness.

Note the use of the __always_inline keyword. In some instances, we
have a task_struct pointer, dereference the dl member, and then use
the container_of macro to retrieve the task_struct pointer again. By
inlining the code, the compiler can potentially optimize out this
redundant round trip.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240724142253.27145-3-wander@redhat.com
---
 kernel/sched/deadline.c | 41 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1c8b838..33b4646 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -342,6 +342,29 @@ static void dl_rq_change_utilization(struct rq *rq, struct sched_dl_entity *dl_s
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static __always_inline
+void cancel_dl_timer(struct sched_dl_entity *dl_se, struct hrtimer *timer)
+{
+	/*
+	 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+	 * it will eventually call put_task_struct().
+	 */
+	if (hrtimer_try_to_cancel(timer) == 1 && !dl_server(dl_se))
+		put_task_struct(dl_task_of(dl_se));
+}
+
+static __always_inline
+void cancel_replenish_timer(struct sched_dl_entity *dl_se)
+{
+	cancel_dl_timer(dl_se, &dl_se->dl_timer);
+}
+
+static __always_inline
+void cancel_inactive_timer(struct sched_dl_entity *dl_se)
+{
+	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
+}
+
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
@@ -495,10 +518,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
-			if (!dl_server(dl_se))
-				put_task_struct(dl_task_of(dl_se));
-		}
+		cancel_inactive_timer(dl_se);
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -2113,13 +2133,8 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
-			 *
-			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
-			 * it will eventually call put_task_struct().
 			 */
-			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
-			    !dl_server(&p->dl))
-				put_task_struct(p);
+			cancel_replenish_timer(&p->dl);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {
@@ -2287,8 +2302,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		cancel_inactive_timer(&p->dl);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
 	rq_unlock(rq, &rf);
@@ -3036,8 +3050,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
  */
 static void switched_to_dl(struct rq *rq, struct task_struct *p)
 {
-	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-		put_task_struct(p);
+	cancel_inactive_timer(&p->dl);
 
 	/*
 	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep

