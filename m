Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4983B8394
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhF3NuJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhF3Nt6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:58 -0400
Date:   Wed, 30 Jun 2021 13:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n4rtqfI0gXR2arwqpZ7PrNhwGmqdqGjBPpZmUTSUEzo=;
        b=z9InDKCMx2ZndDIH0pv+rKug2kZmdOOkyTB9lSuEdR/xxQJ5v9TecFqdjpXlQPHNDjzPrh
        ZOvuV2Tq+biAUXSiL70m3Axbvs0jjl+2hk9zYj+P2IgfE8/kLBUDQfDaahNnc4FPm4ZptV
        HwSUsvGF376aLV/s8vlqzE1wzzKnbnzWR/hEl+eRp3uIDuPbySyRVn9u10cqWRlU27aFJW
        NCp22hX/BUuzHz4i3AtkuwHAPs2VvAlAmKnKyxmJQr4UJrUcruDKp/wHlhpeHlHyWiacNJ
        oNxj/sFx9hwT+J/Vkvv3AArI69zxp3VFXzg2M4fVPZSVZa3LeVMDgjgir4s/LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n4rtqfI0gXR2arwqpZ7PrNhwGmqdqGjBPpZmUTSUEzo=;
        b=yGvF4F9UMYdPP40qCYqrwdgWVzlAlI21EtcH4oVgu7yMJBVJYYEASEUQEZ/Q0iqJg4v1rV
        IftDlUaIG1iX3gDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Only cancel nocb timer if not polling
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084839.395.10133057189448756080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f9fc166b790bd214083035d865653133b8a963d1
Gitweb:        https://git.kernel.org/tip/f9fc166b790bd214083035d865653133b8a963d1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:09 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Only cancel nocb timer if not polling

This commit refrains deleting the ->nocb_timer if rcu_nocb is polling
because it should not ever have been queued in the polling case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4253a0e..db28e31 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2176,18 +2176,18 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 	if (bypass) {
-		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
-		// Avoid race with first bypass CB.
-		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-			del_timer(&my_rdp->nocb_timer);
-		}
 		if (!rcu_nocb_poll) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			// Avoid race with first bypass CB.
+			if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+				WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+				del_timer(&my_rdp->nocb_timer);
+			}
 			// At least one child with non-empty ->nocb_bypass, so set
 			// timer in order to avoid stranding its callbacks.
 			mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 		}
-		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
