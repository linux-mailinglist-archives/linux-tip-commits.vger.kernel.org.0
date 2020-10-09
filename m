Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE742882A8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgJIGik (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgJIGfU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7AC0613D6;
        Thu,  8 Oct 2020 23:35:20 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rKBYFQ/So55Z2El1xidOkx62I/XbOa0MY/XuLE2a+i4=;
        b=Tcq8F5S/ywZ6xTVSGLoAstzMhboipyg0KpLbwXDxk+iHVEDNK00cJw7lN3i74lba3i3sjm
        Mg8IHddlOQ9rSSqHXpwmfndFAlqvIoQuk0R+Kc0C5mREbGduOD0bKDjvbmQi099PibTzcN
        J2pQUJLEQOmRlWHuNG3OeBuA9qdKc3Id7dOGF+XFNseifHcPtSvYuQhx0z4zNpkaW47baL
        x/2q+0Wy/MdXTvrd2TrMeEvzBMFGvQOY9eYW+2ELZxwfW3AP+mgq+5TMUEwO1eFgjuBF4l
        w6r2kaGwSpBnnpBT/54KoQ2+vCgGJVjEGERSayb3OEwQmJvQ3U+RZaN41b6hCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rKBYFQ/So55Z2El1xidOkx62I/XbOa0MY/XuLE2a+i4=;
        b=h5RfpLFAjNGYU9WUKSU10PnADNQYH1kN6E3VHvxxcCBm8DqcZOhS2KqBLfgpqEchijB0do
        so5a2doViMFqJtCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused "cpu" parameter from rcu_report_qs_rdp()
Cc:     Jann Horn <jannh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531738.7002.16707938900728884787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cfeac3977ab4b6222a01f79997739d2367a8cc94
Gitweb:        https://git.kernel.org/tip/cfeac3977ab4b6222a01f79997739d2367a8cc94
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 20 Aug 2020 11:26:14 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:28 -07:00

rcu: Remove unused "cpu" parameter from rcu_report_qs_rdp()

The "cpu" parameter to rcu_report_qs_rdp() is not used, with rdp->cpu
being used instead.  Furtheremore, every call to rcu_report_qs_rdp()
invokes it on rdp->cpu.  This commit therefore removes this unused "cpu"
parameter and converts a check of rdp->cpu against smp_processor_id()
to a WARN_ON_ONCE().

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 8 ++++----
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a295cad..c612765 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2240,7 +2240,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
  * structure.  This must be called from the specified CPU.
  */
 static void
-rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
+rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
@@ -2249,6 +2249,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
+	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
@@ -2265,8 +2266,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	if (rdp->cpu == smp_processor_id())
-		rdp->core_needs_qs = false;
+	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -2315,7 +2315,7 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	 * Tell RCU we are done (but rcu_report_qs_rdp() will be the
 	 * judge of that).
 	 */
-	rcu_report_qs_rdp(rdp->cpu, rdp);
+	rcu_report_qs_rdp(rdp);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 25a676d..ca31be0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -461,7 +461,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
 		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
-			rcu_report_qs_rdp(rdp->cpu, rdp);
+			rcu_report_qs_rdp(rdp);
 			udelay(rcu_unlock_delay);
 		} else {
 			rcu_qs();
@@ -791,7 +791,7 @@ void rcu_read_unlock_strict(void)
 	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
-	rcu_report_qs_rdp(rdp->cpu, rdp);
+	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_strict);
