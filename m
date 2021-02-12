Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37A9319EC1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhBLMkp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhBLMjN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:13 -0500
Date:   Fri, 12 Feb 2021 12:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AsI37Vs2BES46kgqEv95fXrf2NwHUTkrbYQF+q5zz2s=;
        b=MDUi9ZYeFpgDxKzVXHUixJo0E8ySj4X0+0/OZh4gOUKbGp8ZGKPXCI5jE81y7VTrJMqdXd
        YkX7v5xNrdo3OOJKESk4DG6VooxjtiW5A49gRtRbNI3/gjHUNtPegFXvOOd4xWgkOFkU+G
        /+MfpECGiiNfqNuKnyOLStRixiyN1cswTy+4JUjC4af1euJbmJnZvPa353ffqDH4CMk5Sl
        bwNU7I0HQGZGbYTKQrsWIOhwOQHw1B9TLcalSxsCqg0UIZHOXFoBHgWeu/qeMQ/YMeQ4m8
        hTi/qWE+74UTUJjJKdEVv6JZ/PeJryUTC85cIPy1V0QkOgjHIsHSkd9auBJS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AsI37Vs2BES46kgqEv95fXrf2NwHUTkrbYQF+q5zz2s=;
        b=UCaic7q3HeaWi0FAq06XTQAaEHNsY/W+doC7cu54OZQ+gNmUS/VKxf805cMNss9MMJ5Unf
        ubO+8wOUI+T3C9CQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Process batch locally as long as offloading
 isn't complete
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
Message-ID: <161313343812.23325.2633708901299893170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     32aa2f4170d22f0b9fcb75ab05679ab122fae373
Gitweb:        https://git.kernel.org/tip/32aa2f4170d22f0b9fcb75ab05679ab122fae373
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:27 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcu/nocb: Process batch locally as long as offloading isn't complete

This commit makes sure to process the callbacks locally (via either
RCU_SOFTIRQ or the rcuc kthread) whenever the segcblist isn't entirely
offloaded.  This ensures that callbacks are invoked one way or another
while a CPU is in the middle of a toggle operation.

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
 kernel/rcu/rcu_segcblist.h | 12 ++++++++++++
 kernel/rcu/tree.c          |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 28c9a52..afad6fc 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -95,6 +95,18 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 	return false;
 }
 
+static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
+{
+	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
+
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		if ((rsclp->flags & flags) == flags)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4ef59a5..ec14c01 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2700,6 +2700,7 @@ static __latent_entropy void rcu_core(void)
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2729,7 +2730,7 @@ static __latent_entropy void rcu_core(void)
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active)))
 		rcu_do_batch(rdp);
 
