Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16D33B83B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhF3Nup (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhF3NuM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:12 -0400
Date:   Wed, 30 Jun 2021 13:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nbcao/sAgC7+OZzVtRmVwB8KkhTCO9u7zLbgS53tzkM=;
        b=zRCCiTq/nh7JvEqy5MfpCLnmH3biKJMDAoQm8qMzZf9L70toRBExrk7jwKmv953EZvmPh3
        pcDe1NRNAgTlmpQh9ugfrwpUPyWAidohKL9UBxWJvDxYKH371wvNiclaIQxOisI32dSU+c
        wd76CRfSt7cXYIv+NKW31tr9o83cggQngXtB3Hzqb0vcNb8CC0mS93IyfppY7ppB3X8TVG
        AfJlwilBPmuVATN72j8wBjahavTUnrVShfcxLzrO4zIyqrd70sQCwS5LPHmx0rs1A3ygFP
        PW93hSktRXSUGMXFGVgNQEJNieBGbprFo61zhsbtu3n+pVqOI/0YyJwfK00rbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nbcao/sAgC7+OZzVtRmVwB8KkhTCO9u7zLbgS53tzkM=;
        b=5m2lKwwEDRGiwdclt3eFPcMwsmFKbJgrovooY9LvJfqgKw/IITpdSZ0iGjSLNkJwKolGex
        0DOji9Oqx3hEBDCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make rcu_torture_boost_failed() check for GP end
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086148.395.6253862224399468749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bcd4af44e2f173074328980b60178fdbb1853e4f
Gitweb:        https://git.kernel.org/tip/bcd4af44e2f173074328980b60178fdbb1853e4f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 08 Apr 2021 10:46:55 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

rcutorture: Make rcu_torture_boost_failed() check for GP end

It is possible that a delayed grace period that rcu_torture_boost()
was polling for ended while rcu_torture_boost_failed() was printing the
failure splat.  It would be good to know when this happens.  This commit
therefore has rcu_torture_boost_failed() recheck the grace period after
printing the splat, and printing a message indicating whether or not
the grace period has ended.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 31338b2..02a14df 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -919,6 +919,7 @@ static void rcu_torture_enable_rt_throttle(void)
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
 	static int dbg_done;
+	bool gp_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		// Recheck after checking time to avoid false positives.
@@ -931,6 +932,11 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
 				current->rt_priority, gp_state, end - start);
 			cur_ops->gp_kthread_dbg();
+			// Recheck after print to flag grace period ending during splat.
+			gp_done = cur_ops->poll_gp_state(gp_state);
+			pr_info("Boost inversion: GP %lu %s.\n", gp_state,
+				gp_done ? "ended already" : "still pending");
+
 		}
 
 		return true; // failed
