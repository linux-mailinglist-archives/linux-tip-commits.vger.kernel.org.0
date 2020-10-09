Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816A92882A7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgJIGij (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbgJIGfX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:23 -0400
Date:   Fri, 09 Oct 2020 06:35:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2BjU6Dd0+8smCa8D15pN297fRlUtzvf1hCoADrfqjBk=;
        b=VXxz2Glo5IPPBzgk0wgh/rOwYlDlNKwdVKtsrbr5nQS0eydM/OrKPxSPIuDGju8rdWzax/
        orUQm1jcOeloJhiD48jIpc5WSCC+DiVQVSSH/5YMR3VxHtH5R2SKeDEny2oKW63UqOPt2r
        aLRR/h2EqFqJDO+z3LeSyC5yTz+zLTJxc6/znfyVGObfveCv069Ld0gRoFPovIYQCN2hxO
        S9fnINDnPFnktlPqKDSEt+Kd19qgmussjck9HexsMFsloje6Qt/sj5ZrzmpsXRUt2uA5CH
        htg6vWM+avrepDNXvbJARLhEdx2YitMtzAVnPjgWA+SE1172KzJSy7s0VVtmQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2BjU6Dd0+8smCa8D15pN297fRlUtzvf1hCoADrfqjBk=;
        b=y7Ijr1LhZn/BbhFmFNqEaTMiM3pDAtr6O7QOkpVhuBXliXPkkKD6NwxpbkTRlcQJQEqz7r
        4AxSB5i2BpoeiiCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Do full report for .need_qs for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532115.7002.4715240799588139724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     44bad5b3cca2d452d17ef82841b20b42a2cf11a0
Gitweb:        https://git.kernel.org/tip/44bad5b3cca2d452d17ef82841b20b42a2cf11a0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 15:12:50 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:25 -07:00

rcu: Do full report for .need_qs for strict GPs

The rcu_preempt_deferred_qs_irqrestore() function is invoked at
the end of an RCU read-side critical section (for example, directly
from rcu_read_unlock()) and, if .need_qs is set, invokes rcu_qs() to
report the new quiescent state.  This works, except that rcu_qs() only
updates per-CPU state, leaving reporting of the actual quiescent state
to a later call to rcu_report_qs_rdp(), for example from within a later
RCU_SOFTIRQ instance.  Although this approach is exactly what you want if
you are more concerned about efficiency than about short grace periods,
in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, short grace periods are
the name of the game.

This commit therefore makes rcu_preempt_deferred_qs_irqrestore() directly
invoke rcu_report_qs_rdp() in CONFIG_RCU_STRICT_GRACE_PERIOD=y, thus
shortening grace periods.

Historical note:  To the best of my knowledge, causing rcu_read_unlock()
to directly report a quiescent state first appeared in Jim Houston's
and Joe Korty's JRCU.  This is the second instance of a Linux-kernel RCU
feature being inspired by JRCU, the first being RCU callback offloading
(as in the RCU_NOCB_CPU Kconfig option).

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 668bbd2..dfdb902 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -459,8 +459,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		return;
 	}
 	t->rcu_read_unlock_special.s = 0;
-	if (special.b.need_qs)
-		rcu_qs();
+	if (special.b.need_qs) {
+		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+			rcu_report_qs_rdp(rdp->cpu, rdp);
+		else
+			rcu_qs();
+	}
 
 	/*
 	 * Respond to a request by an expedited grace period for a
