Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A430A2882C6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgJIGfN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbgJIGfM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F0C0613D2;
        Thu,  8 Oct 2020 23:35:12 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1itabSknk0NK4f5lwHsd7w6B4PLNNvmzniHAitwaUII=;
        b=mFUgFfmfSmpN/uQ7+Mqs2dFGl9b6CgfFxkaf+E8VE27m10iAp91E8hp2smx07UFAeZmH3m
        KLc/Eb6Sx6zO04QUyoJS5mI1v+ZT2iuOaD58MExfO5xtYtnWTVClRq9drdcoZA0H77sQ+M
        TG+fxZM0HYibhAJpABWaXcELTFh9+hQz65WZUk4fR2KuHYitz+UftclVFXYqpBS+/SUrzW
        UWZPEQRe9dG68ZHkE0LEfpAsq98Pkjg5HklS9Ut+BzOYWGB/FK2b7VWdxCVk6JMDLdcgfG
        ZT6FJHhfkyHhJIppqUiO+qrJFPvhI86JX3JK3ZvWQpyKLMZ7+dZINIZzMTJ4ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1itabSknk0NK4f5lwHsd7w6B4PLNNvmzniHAitwaUII=;
        b=PoQHLjPWt3sj2JyyeZluWMqasb9EZELQFnRKTLpgzVjW5wq0XWtXMc3DRmcP8GAEqCPMW8
        ggaRMgK3NN+888Bw==
From:   "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Shrink each possible cpu krcp
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Zqiang <qiang.zhang@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222530932.7002.13613783348783018135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     70060b8770d34f83e9fa4c3526db013dd2773611
Gitweb:        https://git.kernel.org/tip/70060b8770d34f83e9fa4c3526db013dd2773611
Author:        Zqiang <qiang.zhang@windriver.com>
AuthorDate:    Fri, 14 Aug 2020 14:45:57 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 03 Sep 2020 09:40:13 -07:00

rcu: Shrink each possible cpu krcp

CPUs can go offline shortly after kfree_call_rcu() has been invoked,
which can leave memory stranded until those CPUs come back online.
This commit therefore drains the kcrp of each CPU, not just the
ones that happen to be online.

Acked-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2323622..9245064 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3450,7 +3450,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
@@ -3465,7 +3465,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu, freed = 0;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -3498,7 +3498,7 @@ void __init kfree_rcu_scheduler_running(void)
 	int cpu;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
