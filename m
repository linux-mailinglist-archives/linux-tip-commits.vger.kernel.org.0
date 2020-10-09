Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A526288270
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgJIGhK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbgJIGfi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111BC0613D2;
        Thu,  8 Oct 2020 23:35:38 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fUa5GngnLEPx+P4V7jZ6q8T03DJCBqqv2sNq7Folu20=;
        b=FMAjY5tPzzUZs3b8qwPj6n5+1QUfnm0V55i1egXL34zd75gs4V08xx9oWQeZtC1zO9Lurm
        CWJmpCMnJneYA6hm0E7oJbBlsJfFMJwGflKMi8+pLAo4smbgyPmVATnQEDw6egzxMCfIDm
        2g5tu5Z3EdyeGsm4j4014gHj1xXHdaOdkz5fzdFVQNy+qZosUqyV9k3x6rnfmQPq2dbLbT
        Q5t54TCCLZxPDFen186wY0jwGaSbvsn9tjcFAGTsB9vC8Kh08fLxAso1x9aMaATGhQwRZf
        l8jYboKzR5rlspPG0peSR1Xjhczxqs1LwdhCwwARC1BWkA+irs7ghsaKE8eVdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fUa5GngnLEPx+P4V7jZ6q8T03DJCBqqv2sNq7Folu20=;
        b=dsCIB0kveo8aiFG2cgT9dpAP27q4RFwxmM6VDA9CqieDUBzBI3GPM9l04OTEZgNwGgZIxm
        HxJTCiAanNr8PRAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Move rcu_cpu_started per-CPU variable to rcu_data
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533625.7002.6016249586861310634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c0f97f20e5d97a1358ade650fcf6a322c0c9bc72
Gitweb:        https://git.kernel.org/tip/c0f97f20e5d97a1358ade650fcf6a322c0c9bc72
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 24 Jul 2020 20:22:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:37:54 -07:00

rcu: Move rcu_cpu_started per-CPU variable to rcu_data

When the rcu_cpu_started per-CPU variable was added by commit
f64c6013a202 ("rcu/x86: Provide early rcu_cpu_starting() callback"),
there were multiple sets of per-CPU rcu_data structures.  Therefore, the
rcu_cpu_started flag was added as a separate per-CPU variable.  But now
there is only one set of per-CPU rcu_data structures, so this commit
moves rcu_cpu_started to a new ->cpu_started field in that structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 ++++-------
 kernel/rcu/tree.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da05afc..52108dd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3967,8 +3967,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static DEFINE_PER_CPU(int, rcu_cpu_started);
-
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -3988,12 +3986,11 @@ void rcu_cpu_starting(unsigned int cpu)
 	struct rcu_node *rnp;
 	bool newcpu;
 
-	if (per_cpu(rcu_cpu_started, cpu))
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	if (rdp->cpu_started)
 		return;
+	rdp->cpu_started = true;
 
-	per_cpu(rcu_cpu_started, cpu) = 1;
-
-	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -4053,7 +4050,7 @@ void rcu_report_dead(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	raw_spin_unlock(&rcu_state.ofl_lock);
 
-	per_cpu(rcu_cpu_started, cpu) = 0;
+	rdp->cpu_started = false;
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c96ae35..309bc7f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -156,6 +156,7 @@ struct rcu_data {
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
+	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
 	unsigned long	ticks_this_gp;	/* The number of scheduling-clock */
