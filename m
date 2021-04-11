Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AC35B4FA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhDKNof (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhDKNoL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:11 -0400
Date:   Sun, 11 Apr 2021 13:43:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sF9bSsSKfqNk0mVJNho5vUi9/re5mckqnpxWuqqr4kk=;
        b=YSsPyuyGZC1K0bYwS4hoaetiB4M6BdL+xYBe2gFT81HLzB6LKnUPK5EpBRsijPG2FFI0LR
        ddt2Fv30Std7/3GAoMZV1TYYYWJwiK1lE1MQ9J1yKThcNi8Xra9RycOF07s+kv+VF7mCzx
        S+EyqTN0UbQCK8ju/fblZ26cRSDycY66RPGMMHpPlrhJyLak3U8IZ9vM17BhdAXn6BvNgS
        ii2GcHDcAOy5xgavy41y7dHfZfVAj98D69RmaOweuJlqV7K+gFVoFiQ9A/a6qSiPBDHQxM
        Jg1RCitdPR9e2zNKXCwOfYrSVXMSXUbkUGdZk4UeNK6jdkik/QoDTiSQRWzHBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sF9bSsSKfqNk0mVJNho5vUi9/re5mckqnpxWuqqr4kk=;
        b=29i/5P3PZATw+dvqlPjv6IfWIEceZxEL9uls6j/O9dS3LrKkULkrMGoRZl/v3MMOAsylWd
        RMMkJ6zmKJWay9AA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Avoid confusing double write of rdp->nocb_cb_sleep
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861699.29796.13292539988612818468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8a682b3974c36853b52fc8ede14dee966e96e19f
Gitweb:        https://git.kernel.org/tip/8a682b3974c36853b52fc8ede14dee966e96e19f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 18:12:12 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:21 -08:00

rcu/nocb: Avoid confusing double write of rdp->nocb_cb_sleep

The nocb_cb_wait() function first sets the rdp->nocb_cb_sleep flag to
true by after invoking the callbacks, and then sets it back to false if
it finds more callbacks that are ready to invoke.

This is confusing and will become unsafe if this flag is ever read
locklessly.  This commit therefore writes it only once, based on the
state after both callback invocation and checking.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9fd8588..6a7f77d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2230,6 +2230,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	unsigned long flags;
 	bool needwake_state = false;
 	bool needwake_gp = false;
+	bool can_sleep = true;
 	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
@@ -2253,8 +2254,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
 
-	WRITE_ONCE(rdp->nocb_cb_sleep, true);
-
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
 		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)) {
 			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_CB);
@@ -2262,7 +2261,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 				needwake_state = true;
 		}
 		if (rcu_segcblist_ready_cbs(cblist))
-			WRITE_ONCE(rdp->nocb_cb_sleep, false);
+			can_sleep = false;
 	} else {
 		/*
 		 * De-offloading. Clear our flag and notify the de-offload worker.
@@ -2275,6 +2274,8 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 			needwake_state = true;
 	}
 
+	WRITE_ONCE(rdp->nocb_cb_sleep, can_sleep);
+
 	if (rdp->nocb_cb_sleep)
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 
