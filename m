Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C13B83BB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhF3Nup (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhF3NuM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:12 -0400
Date:   Wed, 30 Jun 2021 13:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YLTeLrGXcrRR8NMRvf2HpCr944I7u62/+PnMzMSpKmQ=;
        b=rL4Gi0wBM5XPTy1gIyyL5xRDKbwoMPOGyJ1ESW2iw7jPfKVF3NlR/q404pHwgWHrbb5Q1y
        YwsOpZlZ4ECax8uiozmPSfrNxBqmGvsP0ocxHUD+e6LPkLIO8zRLkVvIiP5kZWokGb9gB+
        pxlPngOpiqn8mls5Jeml/RurNjKd59HBoeCBK7vBUn7kF2ncxxhEUQx+zdR8cHoW0X913o
        Y5tyyEFiCW2a2b1uEK6cMy/NMO0lfXbQAG9kYKbrNazGlqFcqhSR1Ctk6tYiy/DJoa5Pxx
        0yewkEAwB9p6ZOCyfosiA8YuW8Csvok/84arDP4IT0+ySuawPwbaEXi2mCV9Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YLTeLrGXcrRR8NMRvf2HpCr944I7u62/+PnMzMSpKmQ=;
        b=rqYLj2+fwR6kfq3FV6FxSmOzQT/ZBcMFg7xL8mNZ4NpKcaSJSvL4CtixorB+jr+ukAO01e
        vbXWhM9L7+2Xt/Dg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Consolidate rcu_torture_boost() timing
 and statistics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086199.395.9495219438891545774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8c7ec02e2a69807db8024635b48829dca5701c42
Gitweb:        https://git.kernel.org/tip/8c7ec02e2a69807db8024635b48829dca5701c42
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 07 Apr 2021 20:00:00 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

rcutorture: Consolidate rcu_torture_boost() timing and statistics

This commit consolidates two loops in rcu_torture_boost(), one of which
counts the number of boost-test episodes and the other of which computes
the start time of the next episode, into one loop that does both with but
a single acquisition of boost_mutex.  This means that the count of the
number of boost-test episodes is incremented after an episode completes
rather than before it starts, but it also avoids the over-counting that
was possible previously.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3defd0f..31338b2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -956,15 +956,6 @@ static int rcu_torture_boost(void *arg)
 		bool failed = false; // Test failed already in this test interval
 		bool gp_initiated = false;
 
-		/* Increment n_rcu_torture_boosts once per boost-test */
-		while (!kthread_should_stop()) {
-			if (mutex_trylock(&boost_mutex)) {
-				n_rcu_torture_boosts++;
-				mutex_unlock(&boost_mutex);
-				break;
-			}
-			schedule_timeout_uninterruptible(1);
-		}
 		if (kthread_should_stop())
 			goto checkwait;
 
@@ -1015,7 +1006,10 @@ static int rcu_torture_boost(void *arg)
 		 */
 		while (oldstarttime == boost_starttime && !kthread_should_stop()) {
 			if (mutex_trylock(&boost_mutex)) {
-				boost_starttime = jiffies + test_boost_interval * HZ;
+				if (oldstarttime == boost_starttime) {
+					boost_starttime = jiffies + test_boost_interval * HZ;
+					n_rcu_torture_boosts++;
+				}
 				mutex_unlock(&boost_mutex);
 				break;
 			}
