Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAB1494B4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgAYKnX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:43:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgAYKnX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuN-0000Cn-4b; Sat, 25 Jan 2020 11:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC5371C1A8E;
        Sat, 25 Jan 2020 11:42:55 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:55 -0000
From:   "tip-bot2 for Stefan Reiter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Fix dump_tree hierarchy print always active
Cc:     Stefan Reiter <stefan@pimaker.at>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897557.396.7518376565482337804.tip-bot2@tip-bot2>
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

Commit-ID:     610dea36d3083a977e4f156206cbe1eaa2a532f0
Gitweb:        https://git.kernel.org/tip/610dea36d3083a977e4f156206cbe1eaa2a532f0
Author:        Stefan Reiter <stefan@pimaker.at>
AuthorDate:    Fri, 04 Oct 2019 19:49:10 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:37:50 -08:00

rcu/nocb: Fix dump_tree hierarchy print always active

Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
dump_tree") added print statements to rcu_organize_nocb_kthreads for
debugging, but incorrectly guarded them, causing the function to always
spew out its message.

This patch fixes it by guarding both pr_alert statements with dump_tree,
while also changing the second pr_alert to a pr_cont, to print the
hierarchy in a single line (assuming that's how it was supposed to
work).

Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree")
Signed-off-by: Stefan Reiter <stefan@pimaker.at>
[ paulmck: Make single-nocbs-CPU GP kthreads look less erroneous. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55..758bfe1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2321,6 +2321,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;
+	bool gotnocbs = false;
+	bool gotnocbscbs = true;
 	int ls = rcu_nocb_gp_stride;
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
@@ -2343,21 +2345,31 @@ static void __init rcu_organize_nocb_kthreads(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
+			gotnocbs = true;
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
 			rdp->nocb_gp_rdp = rdp;
 			rdp_gp = rdp;
-			if (!firsttime && dump_tree)
-				pr_cont("\n");
-			firsttime = false;
-			pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
+			if (dump_tree) {
+				if (!firsttime)
+					pr_cont("%s\n", gotnocbscbs
+							? "" : " (self only)");
+				gotnocbscbs = false;
+				firsttime = false;
+				pr_alert("%s: No-CB GP kthread CPU %d:",
+					 __func__, cpu);
+			}
 		} else {
 			/* Another CB kthread, link to previous GP kthread. */
+			gotnocbscbs = true;
 			rdp->nocb_gp_rdp = rdp_gp;
 			rdp_prev->nocb_next_cb_rdp = rdp;
-			pr_alert(" %d", cpu);
+			if (dump_tree)
+				pr_cont(" %d", cpu);
 		}
 		rdp_prev = rdp;
 	}
+	if (gotnocbs && dump_tree)
+		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
 }
 
 /*
