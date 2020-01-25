Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5911494E1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAYKqP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:46:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAYKmz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIts-0008MB-Ad; Sat, 25 Jan 2020 11:42:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 001001C1A75;
        Sat, 25 Jan 2020 11:42:43 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:42 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use READ_ONCE() for ->expmask in
 rcu_read_unlock_special()
Cc:     syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896281.396.13421941439896300344.tip-bot2@tip-bot2>
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

Commit-ID:     c51f83c315c392d9776c33eb16a2fe1349d65c7f
Gitweb:        https://git.kernel.org/tip/c51f83c315c392d9776c33eb16a2fe1349d65c7f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 Nov 2019 08:22:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:27:33 -08:00

rcu: Use READ_ONCE() for ->expmask in rcu_read_unlock_special()

The rcu_node structure's ->expmask field is updated only when holding the
->lock, but is also accessed locklessly.  This means that all ->expmask
updates must use WRITE_ONCE() and all reads carried out without holding
->lock must use READ_ONCE().  This commit therefore changes the lockless
->expmask read in rcu_read_unlock_special() to use READ_ONCE().

Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3a3271..698a7f1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -599,7 +599,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_node *rnp = rdp->mynode;
 
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & rnp->expmask) ||
+		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
 		if (irqs_were_disabled && use_softirq &&
