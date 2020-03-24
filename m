Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB119092C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgCXJSm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:18:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44028 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgCXJQ7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg9-0008AE-AB; Tue, 24 Mar 2020 10:16:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2418E1C04D7;
        Tue, 24 Mar 2020 10:16:47 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Optimize and protect atomic_cmpxchg() loop
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140668.28353.2014121522030682311.tip-bot2@tip-bot2>
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

Commit-ID:     faa059c397dec8a452c79e9dba64419113ea64e2
Gitweb:        https://git.kernel.org/tip/faa059c397dec8a452c79e9dba64419113ea64e2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 03 Feb 2020 14:20:00 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Optimize and protect atomic_cmpxchg() loop

This commit reworks the atomic_cmpxchg() loop in rcu_eqs_special_set()
to do only the initial read from the current CPU's rcu_data structure's
->dynticks field explicitly.  On subsequent passes, this value is instead
retained from the failing atomic_cmpxchg() operation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4a4a975..6c62481 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -342,14 +342,17 @@ bool rcu_eqs_special_set(int cpu)
 {
 	int old;
 	int new;
+	int new_old;
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 
+	new_old = atomic_read(&rdp->dynticks);
 	do {
-		old = atomic_read(&rdp->dynticks);
+		old = new_old;
 		if (old & RCU_DYNTICK_CTRL_CTR)
 			return false;
 		new = old | RCU_DYNTICK_CTRL_MASK;
-	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
+		new_old = atomic_cmpxchg(&rdp->dynticks, old, new);
+	} while (new_old != old);
 	return true;
 }
 
