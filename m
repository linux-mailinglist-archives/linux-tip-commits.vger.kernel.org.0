Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4999288266
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgJIGgv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732062AbgJIGfm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E1C0613D5;
        Thu,  8 Oct 2020 23:35:42 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bplmiakwEdLUH6qZAdfgxd9R9t/lVT1Fj72bM4MHKpw=;
        b=dSDKwHSMj9V0IaJo97cA02+FINoiLY7E4YVD1E0/ips6ylonbOdpmnHbUabV0OfEuflT55
        J+XvCqTld8UvGwUdZpAfkmGy5y6ZjADAZjeHjcCZOCk7AksQkqlBm4GgfV6T4Ku2rLINq1
        uylko0jsBL24qaH9CVNbPyYZD4rLTnfnA911NQRZZLjWPEUpGihb/OG1ZjRatxk3eeFj8s
        Y5KqOWyhNc8OChM9QG2Pjl746QkWu5zBUyrqpST7u0IUC6AkQVjb2wdA1iEmoboLAfotlG
        DlVASotO2RUuts0cDRZ6kg8PwpaYTZY+hVZgCFLFP6Mh8GCmYHtvA5Xiq9YmEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bplmiakwEdLUH6qZAdfgxd9R9t/lVT1Fj72bM4MHKpw=;
        b=rqd1xaLrflgPdjWKYYU7fiFZlkgS/KyOAWccbqN1iDy/SfqiioVhSCrYNG2cLAQ+IH2GyI
        FEmpTe735PuEmgBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] nocb: Remove show_rcu_nocb_state() false positive printout
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534024.7002.809799285141915376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2130c6b4f610ea65e9df71dfa79ee08f2fc17743
Gitweb:        https://git.kernel.org/tip/2130c6b4f610ea65e9df71dfa79ee08f2fc17743
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 22 Jun 2020 16:46:43 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:06 -07:00

nocb: Remove show_rcu_nocb_state() false positive printout

The rcu_data structure's ->nocb_timer field is used to defer wakeups of
the corresponding no-CBs CPU's grace-period kthread ("rcuog*"), and that
structure's ->nocb_defer_wakeup field is used to track such deferral.
This means that the show_rcu_nocb_state() printing an error when those
fields are set for a CPU not corresponding to a no-CBs grace-period
kthread is erroneous.

This commit therefore switches the check from ->nocb_timer to
->nocb_bypass_timer and removes the check of ->nocb_defer_wakeup.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bbc0c07..4d63ee3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2411,10 +2411,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		return;
 
 	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
-	wastimer = timer_pending(&rdp->nocb_timer);
+	wastimer = timer_pending(&rdp->nocb_bypass_timer);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
-	if (!rdp->nocb_defer_wakeup && !rdp->nocb_gp_sleep &&
-	    !waslocked && !wastimer && !wassleep)
+	if (!rdp->nocb_gp_sleep && !waslocked && !wastimer && !wassleep)
 		return;  /* Nothing untowards. */
 
 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
