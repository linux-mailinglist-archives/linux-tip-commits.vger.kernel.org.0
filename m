Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13EA3B83BF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhF3Nuq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbhF3NuN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:13 -0400
Date:   Wed, 30 Jun 2021 13:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=P/DH0qDZ8xWa0anTT3mAfSR7//2XDt8S5wV4O4kgPOU=;
        b=G2gAr4CGcER94LxyUnNQ3kiGkbKx3Kocs+pfIaChWt0tG46/G7MWLEPm7Ob+flBCrGHBlO
        HhWn+tpb+KjNtp2L2sxtAi+R4wUjjt/XgYtuVEUJlvDp7tIsRYGjuJ6LpCdiz7r69HpmvL
        erCtsBkoWloVFIXX+S4zzqsWrsQSDduFOH4QcBsaFNUxBkASRygNc3YROEAaTozbpjHThf
        Aj45QZIRHGtkNrF7+37FaQgH3IbzlEI9bKGOI3nm+CzRK4zefvwi795+vCnLL46m0JXvT8
        cRAv4pcMc54R82c/q4sg0EC9OmnP8uaauJE1GfDrNVhuDJaiLOUW4SCQgfropA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=P/DH0qDZ8xWa0anTT3mAfSR7//2XDt8S5wV4O4kgPOU=;
        b=Ul22FD6042yf8nSzNRrqgjWttGJqkBoh2WYKgE2AE/4+IE4yzUnqFF09B8tI5ON7KyKNaX
        bSxrOKzUXf4Dj9CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Delay-based false positives for RCU
 priority boosting tests
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086251.395.13930142443024003209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7b9dad7abad70750c7fbacd5eb5e917f73b42759
Gitweb:        https://git.kernel.org/tip/7b9dad7abad70750c7fbacd5eb5e917f73b42759
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 07 Apr 2021 17:09:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

rcutorture: Delay-based false positives for RCU priority boosting tests

If an rcu_torture_boost() kthread determines that its grace period
has not yet ended, it invokes rcu_torture_boost_failed() which checks
whether enough time has elapsed for this to be considered a failure of
RCU priority boosting, and, if so, flags the error.

Unfortunately, that kthread might be preempted for some seconds between
the time that it checks the grace period and the time that it checks the
time.  This delay can result in a false positive, featuring a complaint
that a particular grace period has not ended, followed by a diagnostic
dump featuring a much later grace period.

This commit avoids these false positives by rechecking for the end of
the grace period after the time check.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 06d08f4..3defd0f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -921,6 +921,10 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 	static int dbg_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
+		// Recheck after checking time to avoid false positives.
+		smp_mb(); // Time check before grace-period check.
+		if (cur_ops->poll_gp_state(gp_state))
+			return false; // passed, though perhaps just barely
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
@@ -929,10 +933,10 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 			cur_ops->gp_kthread_dbg();
 		}
 
-		return true; /* failed */
+		return true; // failed
 	}
 
-	return false; /* passed */
+	return false; // passed
 }
 
 static int rcu_torture_boost(void *arg)
