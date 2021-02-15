Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E131731BB9C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBOO5R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71574C0617A9;
        Mon, 15 Feb 2021 06:55:48 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K6I48ns3Jo4oBtb260eUlccEUt3YUP8NbXmKEFx6Ntg=;
        b=JFuC8D+7XSBLedRVyP8wKZ87by7zXoErPqTlZLZH0HV9yeiG/o1eH0isJzKKEOLTt5521u
        +rpnchS8/TH52x7DE9Wu3S/C3+qvuSEKhIg3FLHdTMzWBT189rtuSZtStAaq/CNlTHmXp3
        4avIzil2lPMbfVeMBSizlcFK22Ol1+UDdgf/AImTNIdcwh4LbkzHZNKhCIkEGd9nGNgUhO
        NV6GLeBmiX/YM++QW65zW0pLP7YTmKscmmd93g6T9/iuqfEmX473gu237COCZBZhv87Tyo
        vXWka+qRyCFvO6rld9DV8OfjNrg/COKVU3kzE8IERGOrrGGC3K9EOzgxcBowog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K6I48ns3Jo4oBtb260eUlccEUt3YUP8NbXmKEFx6Ntg=;
        b=ZFbF0LE4B6Vh2pfsJuPQTKlQI6ogN48keuwbbnrn1B/rJohcRN6MQNObUKO++3nmwDbXGC
        hJ9zj8HXn14PHbDA==
From:   "tip-bot2 for Julia Cartwright" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Enable rcu_normal_after_boot unconditionally for RT
Cc:     Luiz Capitulino <lcapitulino@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094568.20312.13010770270932827765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     36221e109eb20ac111bc3bf3e8d5639aa457c7e0
Gitweb:        https://git.kernel.org/tip/36221e109eb20ac111bc3bf3e8d5639aa457c7e0
Author:        Julia Cartwright <julia@ni.com>
AuthorDate:    Tue, 15 Dec 2020 15:16:47 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:43:51 -08:00

rcu: Enable rcu_normal_after_boot unconditionally for RT

Expedited RCU grace periods send IPIs to all non-idle CPUs, and thus can
disrupt time-critical code in real-time applications.  However, there
is a portion of boot-time processing (presumably before any real-time
applications have started) where expedited RCU grace periods are the only
option.  And so it is that experience with the -rt patchset indicates that
PREEMPT_RT systems should always set the rcupdate.rcu_normal_after_boot
kernel boot parameter.

This commit therefore makes the post-boot application environment safe
for real-time applications by making PREEMPT_RT systems disable the
rcupdate.rcu_normal_after_boot kernel boot parameter and acting as
if this parameter had been set.  This means that post-boot calls to
synchronize_rcu_expedited() will be treated as if they were instead
calls to synchronize_rcu(), thus preventing the IPIs, and thus avoiding
disrupting real-time applications.

Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Update kernel-parameters.txt accordingly. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/rcu/update.c                             | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 521255f..e0008d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4474,6 +4474,13 @@
 			only normal grace-period primitives.  No effect
 			on CONFIG_TINY_RCU kernels.
 
+			But note that CONFIG_PREEMPT_RT=y kernels enables
+			this kernel boot parameter, forcibly setting
+			it to the value one, that is, converting any
+			post-boot attempt at an expedited RCU grace
+			period to instead use normal non-expedited
+			grace-period processing.
+
 	rcupdate.rcu_task_ipi_delay= [KNL]
 			Set time in jiffies during which RCU tasks will
 			avoid sending IPIs, starting with the beginning
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39334d2..b95ae86 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -56,8 +56,10 @@
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
-static int rcu_normal_after_boot;
+static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
