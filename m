Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8811908E6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCXJQw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:16:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCXJQv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg1-00081o-8a; Tue, 24 Mar 2020 10:16:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AE64D1C0481;
        Tue, 24 Mar 2020 10:16:38 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:38 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Fix process_srcu()/srcu_batches_completed() datarace
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139839.28353.5827172655436222384.tip-bot2@tip-bot2>
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

Commit-ID:     39f91504a03a7a2abdb52205106942fa4a548d0d
Gitweb:        https://git.kernel.org/tip/39f91504a03a7a2abdb52205106942fa4a548d0d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Dec 2019 19:39:35 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:01:11 -08:00

srcu: Fix process_srcu()/srcu_batches_completed() datarace

The srcu_struct structure's ->srcu_idx field is accessed locklessly,
so reads must use READ_ONCE().  This commit therefore adds the needed
READ_ONCE() invocation where it was missed.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 79848f7..119a373 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1079,7 +1079,7 @@ EXPORT_SYMBOL_GPL(srcu_barrier);
  */
 unsigned long srcu_batches_completed(struct srcu_struct *ssp)
 {
-	return ssp->srcu_idx;
+	return READ_ONCE(ssp->srcu_idx);
 }
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 
