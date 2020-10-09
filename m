Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7528829A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgJIGiN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55506 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbgJIGf1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:27 -0400
Date:   Fri, 09 Oct 2020 06:35:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TRMoSCA3zMyRWQN+TnmkbTko4LXIZW/GMyWgT07m2N4=;
        b=mDB7QIMwOOrZ7a+F63UE74wrrF8JLj024IcTlrOga6ioTT6uiP2KnZpwdE2ZGAnX2zirR6
        bc6CWzGidg8YmymsZorcvDThm5v5aOIVAQNqFTqxnm0AhWpOAnL/bAu2s3aMgxJDATeTE1
        3a5fy9QZjaKmg7z3KlIr5zumDqXgiEGkpGGpg+xU7Cym7h8ZWHlgl6Wd/Yvu3188RuzggA
        oY3nulIA5Ja0s1+e840p/45c8af1yS2UrDSrUCoNKp+/ZnNdw1G9UhslG0osuqMH5x9Jlu
        LdFuEAo7v8dKWGUscV+te024SNNgWO82NCr7zaCiC8eUmEaRv5uf7M5Mkgi9Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TRMoSCA3zMyRWQN+TnmkbTko4LXIZW/GMyWgT07m2N4=;
        b=QMQBajYS+B4qB/E9fWeTY5uYq6vcREhJ2gogsW5kc3iiZ1x2Y9AfSKnxkClUsIbd0c5nAN
        1ppNFM7w/lwCAjCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add Kconfig option for strict RCU grace periods
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532383.7002.16410894923218174403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8cbd0e38a9f2de38e8991c5c1c6f9024b2731d17
Gitweb:        https://git.kernel.org/tip/8cbd0e38a9f2de38e8991c5c1c6f9024b2731d17
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 05 Aug 2020 15:51:20 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:23 -07:00

rcu: Add Kconfig option for strict RCU grace periods

People running automated tests have asked for a way to make RCU minimize
grace-period duration in order to increase the probability of KASAN
detecting a pointer being improperly leaked from an RCU read-side critical
section, for example, like this:

	rcu_read_lock();
	p = rcu_dereference(gp);
	do_something_with(p); // OK
	rcu_read_unlock();
	do_something_else_with(p); // BUG!!!

The rcupdate.rcu_expedited boot parameter is a start in this direction,
given that it makes calls to synchronize_rcu() instead invoke the faster
(and more wasteful) synchronize_rcu_expedited().  However, this does
nothing to shorten RCU grace periods that are instead initiated by
call_rcu(), and RCU pointer-leak bugs can involve call_rcu() just as
surely as they can synchronize_rcu().

This commit therefore adds a RCU_STRICT_GRACE_PERIOD Kconfig option
that will be used to shorten normal (non-expedited) RCU grace periods.
This commit also dumps out a message when this option is in effect.
Later commits will actually shorten grace periods.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 15 +++++++++++++++
 kernel/rcu/tree_plugin.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3cf6132..cab5a4b 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -114,4 +114,19 @@ config RCU_EQS_DEBUG
 	  Say N here if you need ultimate kernel/user switch latencies
 	  Say Y if you are unsure
 
+config RCU_STRICT_GRACE_PERIOD
+	bool "Provide debug RCU implementation with short grace periods"
+	depends on DEBUG_KERNEL && RCU_EXPERT
+	default n
+	select PREEMPT_COUNT if PREEMPT=n
+	help
+	  Select this option to build an RCU variant that is strict about
+	  grace periods, making them as short as it can.  This limits
+	  scalability, destroys real-time response, degrades battery
+	  lifetime and kills performance.  Don't try this on large
+	  machines, as in systems with more than about 10 or 20 CPUs.
+	  But in conjunction with tools like KASAN, it can be helpful
+	  when looking for certain types of RCU usage bugs, for example,
+	  too-short RCU read-side critical sections.
+
 endmenu # "RCU Debugging"
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5b..44cf77d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -36,6 +36,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU dyntick-idle grace-period acceleration is enabled.\n");
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
 		pr_info("\tRCU lockdep checking is enabled.\n");
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		pr_info("\tRCU strict (and thus non-scalable) grace periods enabled.\n");
 	if (RCU_NUM_LVLS >= 4)
 		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
 	if (RCU_FANOUT_LEAF != 16)
