Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634A51908F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCXJRL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:17:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgCXJRL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgL-0008Ip-7g; Tue, 24 Mar 2020 10:17:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8E5F31C04CE;
        Tue, 24 Mar 2020 10:16:54 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:54 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_node ->gp_seq
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141425.28353.6329369829734173857.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0937d045732b5dd5e5df1fb6355d5f4e01f3c4d7
Gitweb:        https://git.kernel.org/tip/0937d045732b5dd5e5df1fb6355d5f4e01f3c4d7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 14:53:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add READ_ONCE() to rcu_node ->gp_seq

The rcu_node structure's ->gp_seq field is read locklessly, so this
commit adds the READ_ONCE() to several loads in order to avoid
destructive compiler optimizations.

This data race was reported by KCSAN.  Not appropriate for backporting
because this affects only tracing and warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bb57c24..236692d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1126,8 +1126,9 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long gp_seq_req, const char *s)
 {
-	trace_rcu_future_grace_period(rcu_state.name, rnp->gp_seq, gp_seq_req,
-				      rnp->level, rnp->grplo, rnp->grphi, s);
+	trace_rcu_future_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+				      gp_seq_req, rnp->level,
+				      rnp->grplo, rnp->grphi, s);
 }
 
 /*
@@ -1904,7 +1905,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 		rnp_c = rnp;
 		rnp = rnp->parent;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		oldmask = rnp_c->qsmask;
+		oldmask = READ_ONCE(rnp_c->qsmask);
 	}
 
 	/*
@@ -2052,7 +2053,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 		return 0;
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
+	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 	return 0;
 }
