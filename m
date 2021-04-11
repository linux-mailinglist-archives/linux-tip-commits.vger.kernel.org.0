Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2414835B4DA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhDKNoK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhDKNoD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:03 -0400
Date:   Sun, 11 Apr 2021 13:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pNF8W+yPOOVb/lHFn5Anm6APkvTDKgfXttPuSe41zoU=;
        b=a0CUeLHRpIUyh6E4ZFxg5sPTRPi7kuFadqySkM7OHUOIP7i7ypNS4NW0l9UPOZU/7Q2l/Q
        oI1PU2FZpHfHJOM2IHLHoMCEomqYEEKRhfsA1/tJ+/1NLyKvdZA2Ov6dkfdDh5Iltk/LBT
        FqPaVhnFaY5HpGYwJZDBMO15O0Kc55tA4m9TlWy8WF9uieW7w9flFUAXOUmo68I37JKFJH
        mVv5ZRDkjysaUk8MGo3iFTm4MWYggjNm1a+gB4rI9tG/5B2WMZOSCIV0VxQ+Ib+gDYaFQq
        IH8ZfjBN2NLRCttzh4EWpAH2QyT/6X7KKoXLM52JClKZiEiuUqQC13xf1GLflg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pNF8W+yPOOVb/lHFn5Anm6APkvTDKgfXttPuSe41zoU=;
        b=JjLPzAtJeczg7giqDV+YGqq40hWFtmeCkgE9yqfs6H9Hdl6LobDf2tKyOaNWKpRRwvk39+
        Rz0PwsXNgvtHtwCg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Move trace_rcu_nocb_wake() calls outside
 nocb_lock when possible
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860543.29796.3405977038161658800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e02691b7ef51c5fac0eee5a6ebde45ce92958fae
Gitweb:        https://git.kernel.org/tip/e02691b7ef51c5fac0eee5a6ebde45ce92958fae
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:02 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:54:55 -07:00

rcu/nocb: Move trace_rcu_nocb_wake() calls outside nocb_lock when possible

Those tracing calls don't need to be under ->nocb_lock.  This commit
therefore moves them outside of that lock.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b08564b..9846c8a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1703,9 +1703,9 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force,
 
 	lockdep_assert_held(&rdp->nocb_lock);
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("AlreadyAwake"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return false;
 	}
 
@@ -1955,9 +1955,9 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
 	if (rcu_nocb_poll || !t) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
 	// Need to actually to a wakeup.
@@ -1992,8 +1992,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeOvfIsDeferred"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	} else {
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 	return;
 }
