Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBA28824E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgJIGfk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732022AbgJIGfh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0449C0613D7;
        Thu,  8 Oct 2020 23:35:36 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Z8X+qKlyXcvxsTvM8HDzVgV4m/qxq55wvF+Cac/XeaQ=;
        b=XkQdU+kEanJOwEj6WXhUJM92Z/XoCvu0bo5T+ZHLakmqIoiMyhxeq3/g/jRNdzj4Z4GOqJ
        MRvwzXvTm9F0QSDdkF5K6Ag8WH9vTDssqD0Bv8sygINWyHcriHLwyOEI+jq22EKp2EiaJf
        4taWzVf2+p3Da5Wy3YfaPTCzgZK5GWXhSVCFq6M0lM05en4jiu3RHfNERa6vMpnHRv/hTq
        oFI9cVJNeUn6DPxhG1vqyvHBztiOqCppwGNeoHIJ02qQddXY2LnidJsgJWbOKDgSAmC9ql
        GgE5vKwJRhwsYdziWAC5hVWZGvEiQp3PRpjCgtZiGY47tpzgukCNXhWHM1ytWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Z8X+qKlyXcvxsTvM8HDzVgV4m/qxq55wvF+Cac/XeaQ=;
        b=LtqcOUf+ktYJWxNUJgCntKy4pt8mM9VIhXzdw225VFg6eWi8acfmhrzugw28eJyKQFLOzV
        LwHqzufPuTtvA/Bg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make FQS more aggressive in complaining about
 offline CPUs
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533463.7002.6461687369311038134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     666ca2907e6b75960ce2f0fe50afc5d8a46f296d
Gitweb:        https://git.kernel.org/tip/666ca2907e6b75960ce2f0fe50afc5d8a46f296d
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Fri, 07 Aug 2020 13:07:20 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:37:55 -07:00

rcu: Make FQS more aggressive in complaining about offline CPUs

The RCU grace-period kthread's force-quiescent state (FQS) loop should
never see an offline CPU that has not yet reported a quiescent state.
After all, the offline CPU should have reported a quiescent state
during the CPU-offline process, or, failing that, by rcu_gp_init()
if it ran concurrently with either the CPU going offline or the last
task on a leaf rcu_node structure exiting its RCU read-side critical
section while all CPUs corresponding to that structure are offline.
The FQS loop should therefore complain if it does see an offline CPU
that has not yet reported a quiescent state.

And it does, but only once the grace period has been in force for a
full second.  This commit therefore makes this warning more aggressive,
so that it will trigger as soon as the condition makes its appearance.

Light testing with TREE03 and hotplug shows no warnings.  This commit
also converts the warning to WARN_ON_ONCE() in order to stave off possible
log spam.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c7afe4..396abe0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1214,13 +1214,28 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if a CPU that is considered to be offline from RCU's
+	 * perspective has not yet reported a quiescent state.  After all,
+	 * the offline CPU should have reported a quiescent state during
+	 * the CPU-offline process, or, failing that, by rcu_gp_init()
+	 * if it ran concurrently with either the CPU going offline or the
+	 * last task on a leaf rcu_node structure exiting its RCU read-side
+	 * critical section while all CPUs corresponding to that structure
+	 * are offline.  This added warning detects bugs in any of these
+	 * code paths.
+	 *
+	 * The rcu_node structure's ->lock is held here, which excludes
+	 * the relevant portions the CPU-hotplug code, the grace-period
+	 * initialization code, and the rcu_read_unlock() code paths.
+	 *
+	 * For more detail, please refer to the "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
+	 */
+	if (WARN_ON_ONCE(!(rdp->grpmask & rcu_rnp_online_cpus(rnp)))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
