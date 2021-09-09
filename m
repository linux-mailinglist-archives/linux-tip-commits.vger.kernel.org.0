Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0183840491F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhIILTy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhIILTm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:42 -0400
Date:   Thu, 09 Sep 2021 11:18:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FY+adX14T3Qzw5BM8IDLNE+krjE9qm+SxMeWgeSnOKg=;
        b=YEHI1mR3+8Lpbsp6GKz0s7HU7p8JmTn4quzGTTAk48PlG+KRJ1qdQOJTcg22tV6LXqhKgC
        XTMA7j55qbrqXLxoEBFXCroIGqROAt0tfuatScK+AfVBhS3/SJjUgl2aK4rmF3vbw/5sj2
        FGR9ocikKjvE5M72xosEGGDK8hom9YySypNFcvdEE/N3tRlPAbE7uauGERL6OKeilt/OAQ
        2MixGXtDjcdeudiPM2uJ+0Vp2t0q8i5P79B5Al1i1PNgg3Vw2edwChwzuuaCUsSgsGhCTB
        GUWem02Y8RrRE7ni6fZi2fNaCsrR+H2Y4XhnRornu8fjldhuGcL6ByEGjqvE0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FY+adX14T3Qzw5BM8IDLNE+krjE9qm+SxMeWgeSnOKg=;
        b=v/jo2D2X1sRHIM+K5lb7zfRavxHHYOEEnVakk9mJBUXB4V0Aqi7QUyP53KnvYb7J9WMmVf
        JMitbwK+fOsmeXCQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Trigger nohz.next_balance updates when
 a CPU goes NOHZ-idle
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210823111700.2842997-3-valentin.schneider@arm.com>
References: <20210823111700.2842997-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163118631134.25758.13371242955265585577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     df100a6682d3d9d4b7cbb531a3f783035732ba92
Gitweb:        https://git.kernel.org/tip/df100a6682d3d9d4b7cbb531a3f783035732ba92
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 23 Aug 2021 12:17:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:30 +02:00

sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle

Consider a system with some NOHZ-idle CPUs, such that

  nohz.idle_cpus_mask = S
  nohz.next_balance = T

When a new CPU k goes NOHZ idle (nohz_balance_enter_idle()), we end up
with:

  nohz.idle_cpus_mask = S \U {k}
  nohz.next_balance = T

Note that the nohz.next_balance hasn't changed - it won't be updated until
a NOHZ balance is triggered. This is problematic if the newly NOHZ idle CPU
has an earlier rq.next_balance than the other NOHZ idle CPUs, IOW if:

  cpu_rq(k).next_balance < nohz.next_balance

In such scenarios, the existing nohz.next_balance will prevent any NOHZ
balance from happening, which itself will prevent nohz.next_balance from
being updated to this new cpu_rq(k).next_balance. Unnecessary load balance
delays of over 12ms caused by this were observed on an arm64 RB5 board.

Use the new nohz.needs_update flag to mark the presence of newly-idle CPUs
that need their rq->next_balance to be collated into
nohz.next_balance. Trigger a NOHZ_NEXT_KICK when the flag is set.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210823111700.2842997-3-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48ce754..2a5efde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5754,6 +5754,7 @@ static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
+	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -10417,6 +10418,9 @@ static void nohz_balancer_kick(struct rq *rq)
 unlock:
 	rcu_read_unlock();
 out:
+	if (READ_ONCE(nohz.needs_update))
+		flags |= NOHZ_NEXT_KICK;
+
 	if (flags)
 		kick_ilb(flags);
 }
@@ -10513,12 +10517,13 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
-	 * store.
+	 * and @needs_update stores.
 	 */
 	smp_mb__after_atomic();
 
 	set_cpu_sd_state_idle(cpu);
 
+	WRITE_ONCE(nohz.needs_update, 1);
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
@@ -10567,13 +10572,17 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	/*
 	 * We assume there will be no idle load after this update and clear
 	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
-	 * set the has_blocked flag and trig another update of idle load.
+	 * set the has_blocked flag and trigger another update of idle load.
 	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
+	 *
+	 * Same applies to idle_cpus_mask vs needs_update.
 	 */
 	if (flags & NOHZ_STATS_KICK)
 		WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_NEXT_KICK)
+		WRITE_ONCE(nohz.needs_update, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10597,6 +10606,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		if (need_resched()) {
 			if (flags & NOHZ_STATS_KICK)
 				has_blocked_load = true;
+			if (flags & NOHZ_NEXT_KICK)
+				WRITE_ONCE(nohz.needs_update, 1);
 			goto abort;
 		}
 
