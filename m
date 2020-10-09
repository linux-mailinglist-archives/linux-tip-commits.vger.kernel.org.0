Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D319A288268
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgJIGg4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgJIGfk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:40 -0400
Date:   Fri, 09 Oct 2020 06:35:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7GAtStCTGUefVjtPLoM9spLu4k5e3/GFYGMOYiaPfek=;
        b=ITWJMi+nq7XmSfllNv7TKyTn0jDalcn3IPn26JsMWpseW1cjqlCntBt+ORSVM9h4DhCYvJ
        yiYEVwymv/jaIw1TPdoijTzHyv7zvhh9nkcMisDWiOiRx8zwQ9iSJc5YISKN7HKRRyv7AI
        wj3kb7LwDom9QkC62piLRQTSSeYcjI1X0Mpw9FNdgcV4+pqg/dDROD+GzDNi1mBLZJNku1
        r+Wza7R8IAvVrXESGVAsIl9Pyku2fsE+m5+tgwx6MrFVSu8x9f9JFG/nPcQcYGoQE+y3Q+
        vWsGtjwjeuh6trYtEET3yMvvsYOLX8ZCGJ2ZguS4FHtQAkMvCI2XJ/xD69t8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7GAtStCTGUefVjtPLoM9spLu4k5e3/GFYGMOYiaPfek=;
        b=q4gzT//Prv8eid37XeeICZ+eP6D7aGMDxtM6WK1k4aTobv2DCADE20qV+dvYCuj1m0NgxO
        08cttsLwXjtvqwBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_do_batch() access to
 rcu_kick_kthreads
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533869.7002.1775214182693934335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fe63b723cc7ca3a91ea91274e0f2cba29452b3fa
Gitweb:        https://git.kernel.org/tip/fe63b723cc7ca3a91ea91274e0f2cba29452b3fa
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 18:04:45 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:07 -07:00

rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kthreads

Given that sysfs can change the value of rcu_kick_kthreads at any time,
this commit adds a READ_ONCE() to the sole access to that variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b5d3b47..a1780a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -158,7 +158,7 @@ static void rcu_stall_kick_kthreads(void)
 {
 	unsigned long j;
 
-	if (!rcu_kick_kthreads)
+	if (!READ_ONCE(rcu_kick_kthreads))
 		return;
 	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
 	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
@@ -580,7 +580,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
-	if ((rcu_stall_is_suppressed() && !rcu_kick_kthreads) ||
+	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
