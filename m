Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09A431DA1B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhBQNSZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhBQNSQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:16 -0500
Date:   Wed, 17 Feb 2021 13:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtN12CzgwYFqIF/QDBcNDpBXo5Kjz1t00AFsHjtn/Kk=;
        b=tRX34mJ5FdQGwS9nhC6VT607B5jqGPM/kR5UJ96TpL592W+BiiTp4Rx/ydQLW5dGcq2UBj
        BeaMPjVLQ00XA5+Cs+Ij5PsE5YvWdrmh4Ofrpk6T1O/igE8FpGvv65/P21Y5J1NUIxk/6M
        6lmYiT+npfff6EQNQ0105hNxirEvoIRZ3HYgOveJscFnbm0n6suJV/jcjcrjmk+zZtbH59
        Vq98RNFYYi2dtuDwWe6p/PNh9PUmJZiV5WYtvhfH67uEV65vlqylHPBJbYPwqWIKXeqKBR
        PAoCD7GGcM2P/r+1RTaZEHk2RIRbR/JVghCZ+9rsxCLprhcQYo2aUVihu2IlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtN12CzgwYFqIF/QDBcNDpBXo5Kjz1t00AFsHjtn/Kk=;
        b=ctiV8rBm4yX0z6wJUIp3agwNEzhio01mq2hi8gqE+8o+9kCIKviNxTayFKwZZnDBvHtcPK
        dtiOg0gxt1xyB0Dg==
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/features: Fix hrtick reprogramming
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210208073554.14629-2-juri.lelli@redhat.com>
References: <20210208073554.14629-2-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <161356785232.20312.17400375620954205583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     156ec6f42b8d300dbbf382738ff35c8bad8f4c3a
Gitweb:        https://git.kernel.org/tip/156ec6f42b8d300dbbf382738ff35c8bad8f4c3a
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 08 Feb 2021 08:35:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

sched/features: Fix hrtick reprogramming

Hung tasks and RCU stall cases were reported on systems which were not
100% busy. Investigation of such unexpected cases (no sign of potential
starvation caused by tasks hogging the system) pointed out that the
periodic sched tick timer wasn't serviced anymore after a certain point
and that caused all machinery that depends on it (timers, RCU, etc.) to
stop working as well. This issues was however only reproducible if
HRTICK was enabled.

Looking at core dumps it was found that the rbtree of the hrtimer base
used also for the hrtick was corrupted (i.e. next as seen from the base
root and actual leftmost obtained by traversing the tree are different).
Same base is also used for periodic tick hrtimer, which might get "lost"
if the rbtree gets corrupted.

Much alike what described in commit 1f71addd34f4c ("tick/sched: Do not
mess with an enqueued hrtimer") there is a race window between
hrtimer_set_expires() in hrtick_start and hrtimer_start_expires() in
__hrtick_restart() in which the former might be operating on an already
queued hrtick hrtimer, which might lead to corruption of the base.

Use hrtick_start() (which removes the timer before enqueuing it back) to
ensure hrtick hrtimer reprogramming is entirely guarded by the base
lock, so that no race conditions can occur.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210208073554.14629-2-juri.lelli@redhat.com
---
 kernel/sched/core.c  | 8 +++-----
 kernel/sched/sched.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cec507b..18d51ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -355,8 +355,9 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
+	ktime_t time = rq->hrtick_time;
 
-	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	hrtimer_start(timer, time, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 /*
@@ -380,7 +381,6 @@ static void __hrtick_start(void *arg)
 void hrtick_start(struct rq *rq, u64 delay)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
-	ktime_t time;
 	s64 delta;
 
 	/*
@@ -388,9 +388,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta = max_t(s64, delay, 10000LL);
-	time = ktime_add_ns(timer->base->get_time(), delta);
-
-	hrtimer_set_expires(timer, time);
+	rq->hrtick_time = ktime_add_ns(timer->base->get_time(), delta);
 
 	if (rq == this_rq())
 		__hrtick_restart(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2185b3b..0dfdd52 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1031,6 +1031,7 @@ struct rq {
 	call_single_data_t	hrtick_csd;
 #endif
 	struct hrtimer		hrtick_timer;
+	ktime_t 		hrtick_time;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
