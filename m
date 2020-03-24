Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5858A1908E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCXJQs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:16:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43969 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbgCXJQr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffw-00081X-12; Tue, 24 Mar 2020 10:16:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E94C1C04CD;
        Tue, 24 Mar 2020 10:16:38 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:37 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139794.28353.15121164288284124653.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     710426068dc60f2d2e139478d6185710802cdc0a
Gitweb:        https://git.kernel.org/tip/710426068dc60f2d2e139478d6185710802cdc0a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 11:42:05 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:01:11 -08:00

srcu: Hold srcu_struct ->lock when updating ->srcu_gp_seq

A read of the srcu_struct structure's ->srcu_gp_seq field should not
need READ_ONCE() when that structure's ->lock is held.  Except that this
lock is not always held when updating this field.  This commit therefore
acquires the lock around updates and removes a now-unneeded READ_ONCE().

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Switch from READ_ONCE() to lock per Peter Zilstra question. ]
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/srcutree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 119a373..c19c1df 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -450,7 +450,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&ssp->srcu_gp_seq);
-	state = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
+	state = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
 }
 
@@ -1130,7 +1130,9 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
+		spin_lock_irq_rcu_node(ssp);
 		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
+		spin_unlock_irq_rcu_node(ssp);
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
