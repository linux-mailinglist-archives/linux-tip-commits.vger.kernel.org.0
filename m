Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C681C35B511
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhDKNpH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8QtnLEvTr/q3WbBa+T26xL6cc4UM8kG1A8jZrijHH/s=;
        b=03+IVPQuGIU3I+IOKPCWM7vL0jV3irI/ahprI/FixwMillftEE0XjyvlS1dguiM0R0KGBn
        e+mG+hXSs+reKubQ+rY6FkzrvW6oZB4QPcdkKZ6Q6zTACerqp2TJ6DshY335is5uQGYzZY
        o31Wqn/F/vXdhxXH7yDgZOB9liyuB2HT4wBggcsxccajOILFRrcmzQySR3et8TFx39mdSM
        UBTDnmd/Px1JPVP0TLYXb8+Sk1UGhZF3/M77H/VrHFWD5Hr/ajOT5cbCqH4dqxWOLUtfXc
        RjWuIK8EDV4oaqD34zzChq8IqOoJhzj+87GlPncudftJllgGjA5I2NynrXf3Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8QtnLEvTr/q3WbBa+T26xL6cc4UM8kG1A8jZrijHH/s=;
        b=ZFsKldtqUrLVP52VXqOpJWfrHO7GQMskP+IEG01QATjzJREkHQUnXR3Y5/RE+IJAjJgaUP
        /p5hvyEdI+wVyNCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Make krc_this_cpu_unlock() use
 raw_spin_unlock_irqrestore()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862044.29796.9420473486156858728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7ffc9ec8eac196cbd85669a4d7920cd80f186a51
Gitweb:        https://git.kernel.org/tip/7ffc9ec8eac196cbd85669a4d7920cd80f186a51
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 20 Jan 2021 13:38:08 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

kvfree_rcu: Make krc_this_cpu_unlock() use raw_spin_unlock_irqrestore()

The krc_this_cpu_unlock() function does a raw_spin_unlock() immediately
followed by a local_irq_restore().  This commit saves a line of code by
merging them into a raw_spin_unlock_irqrestore().  This transformation
also reduces scheduling latency because raw_spin_unlock_irqrestore()
responds immediately to a reschedule request.  In contrast,
local_irq_restore() does a scheduling-oblivious enabling of interrupts.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08b5044..7ee83f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3229,8 +3229,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static inline struct kvfree_rcu_bulk_data *
