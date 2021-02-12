Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA7319EC3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBLMkr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhBLMjU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:20 -0500
Date:   Fri, 12 Feb 2021 12:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3YrjrQekvkKj8iZKNWq7t1M8zunZQiOFqyLXSm2SEgU=;
        b=OZf2Zp1lQxSHSzUR8J6FTzQzbV9/wUp7qlgLkfytpzHanrUrZ69MhlD2QzWaaQzTNDc7Hm
        O/KjWIi6KRnXwh08HkGIlkBEpp5dBFaeJcpwZ+RXGn7eXW527FSBsAWJ21pQIFarN5RYyF
        P8CvLtM5k9E5YwfBa0GvphbNYDTKlUB5yXYDKTrSBBMba8KeJlwXhj+SmvDIgfkmMZ2Mx2
        brDPrNtImvDcgPl7T0vs0EQtK5wErd+ZcjK7gYoOVFX+mP41km22MYUPWQrIye/i9UFwdh
        6PjLrPaMZNHsjrEldt5djwTyR8LSfEXrYy6jlAL3rPY3ElwRG78Of+X12g760A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3YrjrQekvkKj8iZKNWq7t1M8zunZQiOFqyLXSm2SEgU=;
        b=/K5Xe1g+fm3YzabLtam2RVwBl+zCk4rPJsmnk9Ctpz4AmkMY7rMrjgAxrle0aWiZIG0re6
        PEjAhY7U2cfNANAQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last
 stage of de-offloading
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
Message-ID: <161313343854.23325.17698030659823462530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b9ced9e1ab51ed6057ac8198fd1eeb404a32a867
Gitweb:        https://git.kernel.org/tip/b9ced9e1ab51ed6057ac8198fd1eeb404a32a867
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:25 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading

This commit sets SEGCBLIST_SOFTIRQ_ONLY once toggling is otherwise fully
complete, allowing further RCU callback manipulation to be carried out
locklessly and locally.

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
 kernel/rcu/tree_plugin.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 35dc9b3..8641b72 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2352,7 +2352,14 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
+	/*
+	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
+	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
+	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
+	 * disabled now, but let's be paranoid.
+	 */
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
 	return ret;
 }
