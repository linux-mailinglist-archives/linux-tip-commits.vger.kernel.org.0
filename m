Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D286819094C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgCXJSz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:18:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCXJQy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg3-00083S-AK; Tue, 24 Mar 2020 10:16:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AA5A1C04D3;
        Tue, 24 Mar 2020 10:16:40 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:40 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add missing annotation for exit_tasks_rcu_start()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140001.28353.5179493215017548997.tip-bot2@tip-bot2>
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

Commit-ID:     e1e9bdc00ade6651c11bf5628ee9d313ee6089ac
Gitweb:        https://git.kernel.org/tip/e1e9bdc00ade6651c11bf5628ee9d313ee6089ac
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 22:41:26 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:45 -08:00

rcu: Add missing annotation for exit_tasks_rcu_start()

Sparse reports a warning at exit_tasks_rcu_start(void)

|warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit

To fix this, this commit adds an __acquires(&tasks_rcu_exit_srcu).
Given that exit_tasks_rcu_start() does actually call __srcu_read_lock(),
this not only fixes the warning but also improves on the readability of
the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a27df76..a04fe54 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
 core_initcall(rcu_spawn_tasks_kthread);
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void)
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
