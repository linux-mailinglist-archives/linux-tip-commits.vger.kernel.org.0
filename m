Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AF1ED558
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jun 2020 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgFCRvB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Jun 2020 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgFCRug (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008DC08C5C1;
        Wed,  3 Jun 2020 10:50:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX6-0005zF-TF; Wed, 03 Jun 2020 19:50:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 855D21C0081;
        Wed,  3 Jun 2020 19:50:32 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use __irq_exit_rcu() in irq_exit()
Cc:     Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
References: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159120663239.17951.483143219705198013.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     10396895ab36357e676b894d89f64667ce226150
Gitweb:        https://git.kernel.org/tip/10396895ab36357e676b894d89f64667ce226150
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:36 +02:00

x86/entry: Use __irq_exit_rcu() in irq_exit()

Because if you rename a function, you should also rename the users.

Fixes: b614345f52bc ("x86/entry: Clarify irq_{enter,exit}_rcu()")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lkml.kernel.org/r/20200602150511.GH706478@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r/20200603114051.838509047@infradead.org

---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index a3eb6eb..c4201b7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -438,7 +438,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	irq_exit_rcu();
+	__irq_exit_rcu();
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();
