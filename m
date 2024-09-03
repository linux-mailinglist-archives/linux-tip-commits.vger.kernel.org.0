Return-Path: <linux-tip-commits+bounces-2157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41E969F35
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43111C23D88
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF33BBF0;
	Tue,  3 Sep 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PvrBzRU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJY6yb/z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363221373;
	Tue,  3 Sep 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370708; cv=none; b=sKtZpTU8YmSOaXfBpmy0u4XlvsHRB/ylOiA2rZm0nm0TXYQGeF9JDWA/OEmnvlqNq1ZbEh9OwfqekQu3vY1ReLoQbd68HwwaFesNU13IEATDDx7CWrqkPPHWr6k0HRTas3FbixNdUVUrmxj/PXz8CZ4q51en9a9kbnFSd8F2l2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370708; c=relaxed/simple;
	bh=bWN2jmRqlwrEqJB4pj9hIIuUuUbW9kZtPbQ7J9vv7Gw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I/5uirlgNcfpXhmpDDogRXSJHmLz4A4hzxxidSnirp8LTNZ9wYj1R/H0rDFKQokRZBgTARJf8eJjEhoguVpl39VY3uyQNAp/P3B9W28gJ7YCMUY4+86xbBhvhpKeFEiNynyyFh8OCvKjrPMFEi2Vx1+hwRWldEgPLWSCWOm7Bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PvrBzRU0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJY6yb/z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtLbi1xoam4qZUBDA2mfcB292sY0bc7JasomrMukwwk=;
	b=PvrBzRU0oStx1Fc/0SgENTW7rHI3m9F/hzJhCmshJfk0BL+WB1Dx96fPB+jHA71rN7jlxY
	xrpG54R9i4TtltdpySxSV1oLjocqUmdSsUwnTJmrzvxF4BUjXMO1sSj4sm/lY+kw77FKeZ
	ACwkOHNcPl3eHKm6mP7AgzRveZTOJxnckOHJiGkAhPLUbAgA6NQgrPbMVfpoS1pcy4AfAU
	EgbqocJSwH8D+3TQtmw9MHdKnTQcy0tgAkwIcQ+VOaE8zS/WNkXMtLUMjiOadNUeU+HEjv
	McyG6olu5/Qxcj92e/XCssHERmAn4VSBZokEZew/qrMfoT4eruVzeo2c+AwHUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtLbi1xoam4qZUBDA2mfcB292sY0bc7JasomrMukwwk=;
	b=MJY6yb/zQEGJe12RrKqeRHz1o2JiXH8PSIifYTBXluCzIiS6hTSkpDarqxG3jQuGN8J5Ym
	8iJW1yzCL85diAAw==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Properly deactivate sched_delayed task
 upon class change
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
 Valentin Schneider <vschneid@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240829135353.1524260-1-vschneid@redhat.com>
References: <20240829135353.1524260-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070257.2215.14068162505453895387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     75b6499024a6c1a4ef0288f280534a5c54269076
Gitweb:        https://git.kernel.org/tip/75b6499024a6c1a4ef0288f280534a5c54269076
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Thu, 29 Aug 2024 15:53:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:30 +02:00

sched/fair: Properly deactivate sched_delayed task upon class change

__sched_setscheduler() goes through an enqueue/dequeue cycle like so:

  flags := DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
  prev_class->dequeue_task(rq, p, flags);
  new_class->enqueue_task(rq, p, flags);

when prev_class := fair_sched_class, this is followed by:

  dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);

the idea being that since the task has switched classes, we need to drop
the sched_delayed logic and have that task be deactivated per its previous
dequeue_task(..., DEQUEUE_SLEEP).

Unfortunately, this leaves the task on_rq. This is missing the tail end of
dequeue_entities() that issues __block_task(), which __sched_setscheduler()
won't have done due to not using DEQUEUE_DELAYED - not that it should, as
it is pretty much a fair_sched_class specific thing.

Make switched_from_fair() properly deactivate sched_delayed tasks upon
class changes via __block_task(), as if a
  dequeue_task(..., DEQUEUE_DELAYED)
had been issued.

Fixes: 2e0199df252a ("sched/fair: Prepare exit/cleanup paths for delayed_dequeue")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240829135353.1524260-1-vschneid@redhat.com
---
 kernel/sched/fair.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fea057b..3a3286d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5456,6 +5456,13 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
+static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+{
+	se->sched_delayed = 0;
+	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+		se->vlag = 0;
+}
+
 static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -5531,11 +5538,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 
-	if (flags & DEQUEUE_DELAYED) {
-		se->sched_delayed = 0;
-		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
-			se->vlag = 0;
-	}
+	if (flags & DEQUEUE_DELAYED)
+		finish_delayed_dequeue_entity(se);
 
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
@@ -13107,11 +13111,16 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 	 * and we cannot use DEQUEUE_DELAYED.
 	 */
 	if (p->se.sched_delayed) {
+		/* First, dequeue it from its new class' structures */
 		dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);
-		p->se.sched_delayed = 0;
+		/*
+		 * Now, clean up the fair_sched_class side of things
+		 * related to sched_delayed being true and that wasn't done
+		 * due to the generic dequeue not using DEQUEUE_DELAYED.
+		 */
+		finish_delayed_dequeue_entity(&p->se);
 		p->se.rel_deadline = 0;
-		if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
-			p->se.vlag = 0;
+		__block_task(rq, p);
 	}
 }
 

