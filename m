Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DF319E97
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhBLMit (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhBLMhy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:54 -0500
Date:   Fri, 12 Feb 2021 12:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RtgiXd2rWxBwn+xg1HBGqwYlVH7+RLO0hjcNNIGp4iY=;
        b=GvA4e1ntY6+YKmDIXGhntaPO2gZsOTeeUk5X9RFQmqswkb0za3/kTueKDaxhJlREejXDYa
        yPIvyZFL7FvZk3f1Kl+gEpMqdIW/A0e3g/VWPA/fDlzyxR1YZQBsAcZQFIFqq9dPrMqNVP
        Y/lj5KAC6xVWXmqesis/MZA0dUvXS4gYPrybiGVIAoB9XDGQ4S+MgiR58QysY6aSrVl7O9
        nnP/jP0GJBuvW+ZWBDXZ7BGw6HFouvMBUJS4O/FRqxwISW9LSIjHbl+7gphNTfB+0hjsp1
        /ZQquW+i6YhcekJY4ZVKmZ6f2o3BjUtentyIRiDITaJFbjDwqPGQq0TUW6EBqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RtgiXd2rWxBwn+xg1HBGqwYlVH7+RLO0hjcNNIGp4iY=;
        b=/rgh9G3AZeigS/NtHWCCYHWZttlyadRHyscniDXZrohKU6VwzMZDR2KJp7pRXtICp33W1E
        uMeexV6Kz/qjwrDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make synctype[] and nsynctype be static global
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343029.23325.7275057339166845502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     18fbf307b7319af3725c36e16af6ae9f35a8699c
Gitweb:        https://git.kernel.org/tip/18fbf307b7319af3725c36e16af6ae9f35a8699c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 16:46:06 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:10 -08:00

rcutorture: Make synctype[] and nsynctype be static global

Full testing of the new SRCU polling API requires that the fake writers
also use it in order to test concurrent calls to all of the API members,
especially start_poll_synchronize_srcu().  This commit prepares the ground
for this by making the synctype[] and nsynctype variables be static
globals so that the rcu_torture_fakewriter() function can access them.
Initialization of these variables is moved from rcu_torture_writer()
to a new rcu_torture_write_types() function that is invoked from
rcu_torture_init() just before the first writer kthread is spawned.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 62 +++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1930d92..0d257e2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1062,37 +1062,18 @@ rcu_torture_fqs(void *arg)
 	return 0;
 }
 
+// Used by writers to randomly choose from the available grace-period
+// primitives.  The only purpose of the initialization is to size the array.
+static int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC, RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
+static int nsynctypes;
+
 /*
- * RCU torture writer kthread.  Repeatedly substitutes a new structure
- * for that pointed to by rcu_torture_current, freeing the old structure
- * after a series of grace periods (the "pipeline").
+ * Determine which grace-period primitives are available.
  */
-static int
-rcu_torture_writer(void *arg)
+static void rcu_torture_write_types(void)
 {
-	bool boot_ended;
-	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
-	unsigned long cookie;
-	int expediting = 0;
-	unsigned long gp_snap;
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
 	bool gp_poll1 = gp_poll, gp_sync1 = gp_sync;
-	int i;
-	int idx;
-	int oldnice = task_nice(current);
-	struct rcu_torture *rp;
-	struct rcu_torture *old_rp;
-	static DEFINE_TORTURE_RANDOM(rand);
-	bool stutter_waited;
-	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
-			   RTWS_COND_GET, RTWS_POLL_GET, RTWS_SYNC };
-	int nsynctypes = 0;
-
-	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
-	if (!can_expedite)
-		pr_alert("%s" TORTURE_FLAG
-			 " GP expediting controlled from boot/sysfs for %s.\n",
-			 torture_type, cur_ops->name);
 
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_poll1 && !gp_sync1)
@@ -1127,6 +1108,34 @@ rcu_torture_writer(void *arg)
 	} else if (gp_sync && !cur_ops->sync) {
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	}
+}
+
+/*
+ * RCU torture writer kthread.  Repeatedly substitutes a new structure
+ * for that pointed to by rcu_torture_current, freeing the old structure
+ * after a series of grace periods (the "pipeline").
+ */
+static int
+rcu_torture_writer(void *arg)
+{
+	bool boot_ended;
+	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
+	unsigned long cookie;
+	int expediting = 0;
+	unsigned long gp_snap;
+	int i;
+	int idx;
+	int oldnice = task_nice(current);
+	struct rcu_torture *rp;
+	struct rcu_torture *old_rp;
+	static DEFINE_TORTURE_RANDOM(rand);
+	bool stutter_waited;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
+	if (!can_expedite)
+		pr_alert("%s" TORTURE_FLAG
+			 " GP expediting controlled from boot/sysfs for %s.\n",
+			 torture_type, cur_ops->name);
 	if (WARN_ONCE(nsynctypes == 0,
 		      "rcu_torture_writer: No update-side primitives.\n")) {
 		/*
@@ -2889,6 +2898,7 @@ rcu_torture_init(void)
 
 	/* Start up the kthreads. */
 
+	rcu_torture_write_types();
 	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
 					  writer_task);
 	if (firsterr)
