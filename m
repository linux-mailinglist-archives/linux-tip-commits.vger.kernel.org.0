Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECB231BB7F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBOO4Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBOO4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:24 -0500
Date:   Mon, 15 Feb 2021 14:55:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8UOcHYAGdmo18At0PS2BdGGAPqRNIrhWrDP7d+Ui0/c=;
        b=mgjUD0lVncXsHrygxyFjIQ8OytOLB1DVv5HOj6r2FcWe2HsVxCaLV7Mkcx7SQo8WgdmR7X
        FXWX07yU0wUgyT+FNSk1peZq0AsS8ecrvMf00umE0Z0xjN86tPNnpymePahdbyzdC1b3x2
        QphUM9gh08my8tiq8bGYVqU/+o5xpnxtgbaZzpjy8em/uwwtZmqonZEMVJkt4UeafIoAS5
        rQuxEEKTcNZE8vmj9dw7SnR4eGnfNCHzYKjlnNZ+0pwSXmZ6/E6RYe9qxDfAKT2u+gHLeW
        iADBEVfZjgAFo7IR3n3UEDT86dXILuMHC7GTy51ns+0j4yC1sgJ/8UMG8ryOqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8UOcHYAGdmo18At0PS2BdGGAPqRNIrhWrDP7d+Ui0/c=;
        b=S6C7KfommUMiqNAnyTG/HPaPstvsCKRWMl5OmxtxU7ruOvlgXf9JJ54rwqUfnna+WhEY9X
        Uimfjc3U0QloVtCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Do not NMI offline CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094179.20312.6185773368566071142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     725969ac11d7fa50aa701321daa600ce421fc21b
Gitweb:        https://git.kernel.org/tip/725969ac11d7fa50aa701321daa600ce421fc21b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Nov 2020 12:19:47 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:59:47 -08:00

rcu: Do not NMI offline CPUs

Currently, RCU CPU stall warning messages will NMI whatever CPU looks
like it is blocking either the current grace period or the grace-period
kthread.  This can produce confusing output if the target CPU is offline.
This commit therefore checks for offline CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 35c1355..29cf096 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -333,9 +333,12 @@ static void rcu_dump_cpu_stacks(void)
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
-			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
-				if (!trigger_single_cpu_backtrace(cpu))
+			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
+				if (cpu_is_offline(cpu))
+					pr_err("Offline CPU %d blocking current GP.\n", cpu);
+				else if (!trigger_single_cpu_backtrace(cpu))
 					dump_cpu_task(cpu);
+			}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
@@ -466,9 +469,13 @@ static void rcu_check_gp_kthread_starvation(void)
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			if (cpu >= 0) {
-				pr_err("Stack dump where RCU grace-period kthread last ran:\n");
-				if (!trigger_single_cpu_backtrace(cpu))
-					dump_cpu_task(cpu);
+				if (cpu_is_offline(cpu)) {
+					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
+				} else  {
+					pr_err("Stack dump where RCU GP kthread last ran:\n");
+					if (!trigger_single_cpu_backtrace(cpu))
+						dump_cpu_task(cpu);
+				}
 			}
 			wake_up_process(gpk);
 		}
