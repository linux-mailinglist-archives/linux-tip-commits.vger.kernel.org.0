Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5735B4F7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhDKNod (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhDKNoL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:11 -0400
Date:   Sun, 11 Apr 2021 13:43:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8aTorMDqiglN29/MFngvGibuuz4LmZegAVn/7Xw1FPQ=;
        b=QDCW4xn4cmtnkcHMFwJfx2BIF/yPSpkIe6Fq74GHhqUh+6F9iwO564b0vX6jHj1IVkkHaA
        Bqi0etEh8/iEmrqQZbwhWFO5DGFvkTlfLkyMUKsFZheog3jrO0+NLYWKB5y/TkFGY/il6J
        tFBzdmQG0EAenZ0Sgoo2xKri0PGu5klf3EaCb95cIEjBHZtw3m7gMBbz2c3RPYSYag5t55
        IfRhERjjDbD8tb0U6xIYNZtv12NNHrjxPVRByaJFSYAxhXf0c1NSvTJRu5FNY+z/1iNY4M
        3EPCpIkbi9YL6bXdPq0UQqWg/T4nuhh87FSX9Oo5nEPmwn9z6m3fNFcSP9Eafg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8aTorMDqiglN29/MFngvGibuuz4LmZegAVn/7Xw1FPQ=;
        b=yKzmS2GOuC4KE2eI3c9CkwEccvl7zX6vP5VAYaGNXuf6PeJcInytouQ6obeCburV6t8dCJ
        i+qy8QtHTgzzMLBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Rename nocb_gp_update_state to
 nocb_gp_update_state_deoffloading
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861629.29796.15645746426143286381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     55adc3e1c82a25e99e9efef4f2b14b8b4806918a
Gitweb:        https://git.kernel.org/tip/55adc3e1c82a25e99e9efef4f2b14b8b4806918a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 18:12:13 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:22 -08:00

rcu/nocb: Rename nocb_gp_update_state to nocb_gp_update_state_deoffloading

The name nocb_gp_update_state() is unenlightening, so this commit changes
it to nocb_gp_update_state_deoffloading().  This function now does what
its name says, updates state and returns true if the CPU corresponding to
the specified rcu_data structure is in the process of being de-offloaded.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6a7f77d..93d3938 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2016,7 +2016,8 @@ static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
 	return rcu_segcblist_test_flags(&rdp->cblist, flags);
 }
 
-static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+static inline bool nocb_gp_update_state_deoffloading(struct rcu_data *rdp,
+						     bool *needwake_state)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 
@@ -2026,7 +2027,7 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
 				*needwake_state = true;
 		}
-		return true;
+		return false;
 	}
 
 	/*
@@ -2037,7 +2038,7 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
 	if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
 		*needwake_state = true;
-	return false;
+	return true;
 }
 
 
@@ -2075,7 +2076,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
-		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+		if (nocb_gp_update_state_deoffloading(rdp, &needwake_state)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			if (needwake_state)
 				swake_up_one(&rdp->nocb_state_wq);
