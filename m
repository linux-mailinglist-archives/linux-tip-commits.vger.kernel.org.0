Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3945A3B839D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhF3NuR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhF3NuB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:01 -0400
Date:   Wed, 30 Jun 2021 13:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fEzR7VBaZbU9KAtf0OZ0/r0qcFg4pdX0SEKjyLSIU3Q=;
        b=rWjm6XExaTPhS3KYH1wMOH5L9D9jbBaoTYx2qv/htMNO+1skY4Gh/RA1qsaopjMAfBJyVW
        M4wH250u4XjzWMd/EfuoicYzhYf7a9vSSrHD5qF10DuxtM5jrpd+oo5BOAnU1IQ+JVsxDi
        fxVKa4w/L3FQcBZXT3GtnTxLpTZqxIdak9NiPgdtjr28G+tIFiEWlCrhig96f76GF2V4oJ
        o7SOPPbtz4+N7pzm21t4xav8zhQmvWdyQw9w/yuzorUrZOULd7QhimZCyeiTJE5PYDIYDF
        gBOBCazc81H5aUVzVTMaT7m6W7cu3iz5GnyIu6xev3CTNVupw8Laiy+ruKMfLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fEzR7VBaZbU9KAtf0OZ0/r0qcFg4pdX0SEKjyLSIU3Q=;
        b=3pkJt7keEe4PW5bQCiJ7bh1XbgeEjz8BPFBeEXMVVkPpNX8kaEc7m2VldkZIv9LOePHc51
        jt4+85fZLHB0FeBA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Directly call __wake_nocb_gp() from bypass timer
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085052.395.5718251285639705149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c7ef7500a891432a3bb2b036f535bfdf58aa3605
Gitweb:        https://git.kernel.org/tip/c7ef7500a891432a3bb2b036f535bfdf58aa3605
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:05 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:08 -07:00

rcu/nocb: Directly call __wake_nocb_gp() from bypass timer

The bypass timer calls __call_rcu_nocb_wake() instead of directly
calling __wake_nocb_gp().  The only difference here is that
rdp->qlen_last_fqs_check gets overridden.  But resetting the deferred
force quiescent state base shouldn't be relevant for that timer.  In fact
the bypass queue in question can be for any rdp from the group and not
necessarily the rdp leader on which the bypass timer is attached.

This commit therefore calls __wake_nocb_gp() directly.  This way we
don't even need to lock the ->nocb_lock.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5a2aa9c..82e9ffb 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2015,9 +2015,10 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
-	rcu_nocb_lock_irqsave(rdp, flags);
+
+	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
 	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
-	__call_rcu_nocb_wake(rdp, true, flags);
+	__wake_nocb_gp(rdp, rdp, false, flags);
 }
 
 /*
