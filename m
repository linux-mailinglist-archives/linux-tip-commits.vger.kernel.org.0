Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D4319EC7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhBLMk4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhBLMju (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:50 -0500
Date:   Fri, 12 Feb 2021 12:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wYwql6tJOqJUPIe4BK59ur8kJLCOQne0MbFrCaGo69E=;
        b=iBhlwK7sbR+heT+DsSguCXLrerg6Ha6CNPtF5CgWTkI3sEKmvbbatdUb4J7XS4FU03iNij
        7Z+SWUGrNZglXzHjWjptQJ2d6Jwiy1ESpGymwZUfnbyp3UFJ70hRNPI5Jxz5qyFhagfj7V
        sgRyTHbgbmfvziwlPFXVNkMMH0/awuP/EBO5/huTFf8d1GAqSV2EyI0xX7FszKYnQ1MVzO
        KDsdFXHxxGKV/ftbfAUv6j+QeLp4aDlMDyhKBDPzR3k83Tj21D5yiWQ089GZD3JuDFC4jd
        5M63FyoXf/UTi4YNHaIo4hzobFnExlWJWejOjAmjDoP8K7z0eAdZT6ysZyoAww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wYwql6tJOqJUPIe4BK59ur8kJLCOQne0MbFrCaGo69E=;
        b=aICML/5s1iOfYPwzAKoWuEwW4yNR4oZvpZJTXThi9KB1oSQqqHa22xuZHe334n/E7ZTU19
        v94xNETLYpbUB1BA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343880.23325.18244968176863208111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     314202f84ddd61e4d7576ef62570ad2e2d9db06b
Gitweb:        https://git.kernel.org/tip/314202f84ddd61e4d7576ef62570ad2e2d9db06b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:24 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcu/nocb: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY

This commit flushes the bypass queue and sets state to avoid its being
refilled before switching to the final de-offloaded state.  To avoid
refilling, this commit sets SEGCBLIST_SOFTIRQ_ONLY before re-enabling
IRQs.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c88ad62..35dc9b3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2339,12 +2339,21 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	/* Make sure nocb timer won't stay around */
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/* Make sure nocb timer won't stay around */
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	del_timer_sync(&rdp->nocb_timer);
 
+	/*
+	 * Flush bypass. While IRQs are disabled and once we set
+	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
+	 * enqueued on bypass.
+	 */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
 	return ret;
 }
 
