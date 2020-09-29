Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8027BE8D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgI2H5I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgI2H4z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:55 -0400
Date:   Tue, 29 Sep 2020 07:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSr+Me/c5x9os+xUvFwv4kI6DU7PHuIuud7+xmT9O00=;
        b=YturEfF/wOTfOtT3Bdl3RPgEnOXw0AzDZN6Hi329H6RI2p5frR2Z4nDo/PJsRvgeWQfFKr
        y6dHyhXYFlQd3Wc0rzhhR9CI6Po3x/MrmOoy6t1ZZh+qC+UagYqMk+l2QqOV+EzFdgRuQj
        8oXH8bp6nNypHHFOzZJUnHtsB493If7wwLn+Evds6Xbl15O4DLI9AZqLDMdIlQGijzod9z
        YPw5VMbK4YxbUQxiH47VEvrhZ8LuZ0bw9w9mtvzwHDBPl+ILd3nVOVx+PbeFMP66t+xdfP
        ErTvYOM1nGVzujxMFmfVshvwdxdTwgvFEOk9wup7Re3grdGAJNE5a2U8/kcTJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSr+Me/c5x9os+xUvFwv4kI6DU7PHuIuud7+xmT9O00=;
        b=ucpLxgAQYdgKLGX2aTh3pFbbinJ08CRYEaUX03bH+8e5d7rjr3ggqJ5mJbq+btvpLTPUrY
        XIeap8lv0B//LVDg==
From:   "tip-bot2 for Lucas Stach" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix stale throttling on de-/boosted tasks
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200831110719.2126930-1-l.stach@pengutronix.de>
References: <20200831110719.2126930-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Message-ID: <160136621248.7002.15248843800877733816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46fcc4b00c3cca8adb9b7c9afdd499f64e427135
Gitweb:        https://git.kernel.org/tip/46fcc4b00c3cca8adb9b7c9afdd499f64e427135
Author:        Lucas Stach <l.stach@pengutronix.de>
AuthorDate:    Mon, 31 Aug 2020 13:07:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:24 +02:00

sched/deadline: Fix stale throttling on de-/boosted tasks

When a boosted task gets throttled, what normally happens is that it's
immediately enqueued again with ENQUEUE_REPLENISH, which replenishes the
runtime and clears the dl_throttled flag. There is a special case however:
if the throttling happened on sched-out and the task has been deboosted in
the meantime, the replenish is skipped as the task will return to its
normal scheduling class. This leaves the task with the dl_throttled flag
set.

Now if the task gets boosted up to the deadline scheduling class again
while it is sleeping, it's still in the throttled state. The normal wakeup
however will enqueue the task with ENQUEUE_REPLENISH not set, so we don't
actually place it on the rq. Thus we end up with a task that is runnable,
but not actually on the rq and neither a immediate replenishment happens,
nor is the replenishment timer set up, so the task is stuck in
forever-throttled limbo.

Clear the dl_throttled flag before dropping back to the normal scheduling
class to fix this issue.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200831110719.2126930-1-l.stach@pengutronix.de
---
 kernel/sched/deadline.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28..c19c188 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1527,12 +1527,15 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		pi_se = &pi_task->dl;
 	} else if (!dl_prio(p->normal_prio)) {
 		/*
-		 * Special case in which we have a !SCHED_DEADLINE task
-		 * that is going to be deboosted, but exceeds its
-		 * runtime while doing so. No point in replenishing
-		 * it, as it's going to return back to its original
-		 * scheduling class after this.
+		 * Special case in which we have a !SCHED_DEADLINE task that is going
+		 * to be deboosted, but exceeds its runtime while doing so. No point in
+		 * replenishing it, as it's going to return back to its original
+		 * scheduling class after this. If it has been throttled, we need to
+		 * clear the flag, otherwise the task may wake up as throttled after
+		 * being boosted again with no means to replenish the runtime and clear
+		 * the throttle.
 		 */
+		p->dl.dl_throttled = 0;
 		BUG_ON(!p->dl.dl_boosted || flags != ENQUEUE_REPLENISH);
 		return;
 	}
