Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B53B83C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhF3Nur (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbhF3NuQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D461C0613A2;
        Wed, 30 Jun 2021 06:47:38 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=87VNtRz0rk0PvL/shGTVb/ZG3ocf4HVDpP4pgIXoHfk=;
        b=GZWDDRkn1klghAAY+AZw1YmRfGRTfpFvRG6ZAdaobuOKQZzejANOYFxs3xkzG4TiMqpn7U
        UV28DdwdOeUp9KBwbqTaFJu6Mjn9RM6sby2nd7h0FgOarnKO16Oyw6UjZYbb3Rgdfrmcdm
        vYJ28usEz1fX6JgYYbRzGlMVeX47I3AlE4mPsJmKQDd91oiJnc4EUa2h5ZZyD4EGlUYISK
        7XQm87fyEGNaqA/HCojY0f713M6rd+wznMf5fRE0jjtr07L65bAtkWez+i6giwHJ9qK1+I
        sF2xItdBIVFJ7odFjP2Wjb43n+qJ7AHnnJvG4oibJH+weafpz0I2oe0ljTnEog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=87VNtRz0rk0PvL/shGTVb/ZG3ocf4HVDpP4pgIXoHfk=;
        b=1XMzqkY3+nxQKUf7lD+Cx3n13Cd6ukVuUBjWNlPTFsG+VCj4I2dZcOVSleIVA3/CMy/hns
        ruXiZoxY5VjqY2AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add ->rt_priority and ->gp_start to
 show_rcu_gp_kthreads() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085647.395.1864286528181295737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e44111ed20d8b2d7b05b20d694358ae77d4e93e2
Gitweb:        https://git.kernel.org/tip/e44111ed20d8b2d7b05b20d694358ae77d4e93e2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 21:51:50 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Add ->rt_priority and ->gp_start to show_rcu_gp_kthreads() output

This commit adds ->rt_priority and ->gp_start to show_rcu_gp_kthreads()
output in order to better diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc..fb47025 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -726,6 +726,7 @@ void show_rcu_gp_kthreads(void)
 	unsigned long j;
 	unsigned long ja;
 	unsigned long jr;
+	unsigned long js;
 	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -734,11 +735,12 @@ void show_rcu_gp_kthreads(void)
 	j = jiffies;
 	ja = j - data_race(rcu_state.gp_activity);
 	jr = j - data_race(rcu_state.gp_req_activity);
+	js = j - data_race(rcu_state.gp_start);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->state : 0x1ffffL,
-		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
+		rcu_state.gp_state, t ? t->state : 0x1ffffL, t ? t->rt_priority : 0xffU,
+		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
 		data_race(rcu_state.gp_flags));
