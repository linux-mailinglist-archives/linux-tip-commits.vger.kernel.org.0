Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF3319EB6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhBLMkV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBLMiy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:54 -0500
Date:   Fri, 12 Feb 2021 12:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XvcbagKxbcq3pwrIc01OurBOtVW6URwUVaygGRp/Ol4=;
        b=a3FyrHz48nkeomsN8OxrFrXalDgoLcPpbn2hLJ4qFPHXq1jyGnrOxlTrJ8fEXPd2NbInBc
        SZ2r//jQDjNoB4Q/Jx3S86ACtO0dO1eGtCbMiydosA0qZ4mjQXvmtA6pTm1zi+1MfM9XgX
        4rBvPsvrvhBTGijul1t4fkg3acgqNoO/7zNSjEUt8Lq7+yAJPijygUsma81/hViOobV+9c
        1ieErndMPnA4LoBrJEKKGwpdPrFmFtdi9iAKRsSn2+2MSGz0ePRNZoaFNQ5cU06CxHhjnC
        FaExe3o1lkjkCB+M5/n1sJTv8z4mF82Kj3I6/Xjp8Xq97m9oUsjeVuY4YJZfrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XvcbagKxbcq3pwrIc01OurBOtVW6URwUVaygGRp/Ol4=;
        b=PBajEKdR1+pwwHYO8gR9MHD6h91q6setRQlGQOhhsEQU3yyGMGbPyLmc/FerB2YSZNDMgh
        msgi7tpw+TlmwODw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Do any deferred nocb wakeups at CPU offline time
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343559.23325.6203027900932629036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     147c6852d34563b87ff0e67383c2bf675e8248f6
Gitweb:        https://git.kernel.org/tip/147c6852d34563b87ff0e67383c2bf675e8248f6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 22 Dec 2020 16:49:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:50:24 -08:00

rcu: Do any deferred nocb wakeups at CPU offline time

Because the need to wake a nocb GP kthread ("rcuog") is sometimes
detected when wakeups cannot be done, these wakeups can be deferred.
The wakeups are then carried out by calls to do_nocb_deferred_wakeup()
at various safe points in the code, including RCU's idle hooks.  However,
when a CPU goes offline, it invokes arch_cpu_idle_dead() without invoking
any of RCU's idle hooks.

This commit therefore adds a call to do_nocb_deferred_wakeup() in
rcu_report_dead() in order to handle any deferred wakeups that have been
requested by the outgoing CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03810a5..e6dee71 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4178,6 +4178,9 @@ void rcu_report_dead(unsigned int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	// Do any dangling deferred wakeups.
+	do_nocb_deferred_wakeup(rdp);
+
 	/* QS for any half-done expedited grace period. */
 	preempt_disable();
 	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
