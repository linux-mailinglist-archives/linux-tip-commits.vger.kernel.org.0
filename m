Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C02190923
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCXJSa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:18:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44053 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgCXJRC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgB-0008BC-5g; Tue, 24 Mar 2020 10:16:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD56B1C04DD;
        Tue, 24 Mar 2020 10:16:47 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:47 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add missing annotation for rcu_nocb_bypass_lock()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140759.28353.5316247654362289852.tip-bot2@tip-bot2>
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

Commit-ID:     9ced454807191e44ef093aeeee68194be9ce3a1a
Gitweb:        https://git.kernel.org/tip/9ced454807191e44ef093aeeee68194be9ce3a1a
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 22:42:15 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Add missing annotation for rcu_nocb_bypass_lock()

Sparse reports warning at rcu_nocb_bypass_lock()

|warning: context imbalance in rcu_nocb_bypass_lock() - wrong count at exit

To fix this, this commit adds an __acquires(&rdp->nocb_bypass_lock).
Given that rcu_nocb_bypass_lock() does actually call raw_spin_lock()
when raw_spin_trylock() fails, this not only fixes the warning but also
improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0f8b714..6db2cad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1486,6 +1486,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
  * flag the contention.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
+	__acquires(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
