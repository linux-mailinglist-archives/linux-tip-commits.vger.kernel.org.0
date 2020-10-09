Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E472882A1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgJIGif (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJIGfZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:25 -0400
Date:   Fri, 09 Oct 2020 06:35:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PfJthSbSHcBdDlPEhaxMWlUozj4Cb6n2pffsJRkF+uQ=;
        b=hqeJf3/l4wAss8pIPwmr+6FZKsgeoGx5soNBx5yVR43K+AhupD2f/om4iAtczWCqyMiRdl
        cHO08ZS7AdbXzCOrYOmR5OxoOeda+X1Mj1OAnGPadp8y96mBw+haWHOboB86+PcYmRHd3q
        BWiZ/fFYkkLMSAnXvR1pjCfdF5N+o4rehc7KghsU3zyFzUpURfu7qXJOM0OWPfKeTy+bWW
        VlvUoe8o+EFTkV3kVSb4a7l6ryttQwjOKPmzYxB4mdRWt8wRCVJDu9+2mh7NNA6dmoHDWp
        5poW+tXLFlwQMW9xi4TUti2reVfwxan3a1m2ap1c+p7YwsqLxoeqSEC26S4FXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PfJthSbSHcBdDlPEhaxMWlUozj4Cb6n2pffsJRkF+uQ=;
        b=2sm1z6g87CL2qeXit3VtbCQ0j+KM3glvd+4NRcQAazWjTpaBMB6O4n9mMZICnX+j0JzLfK
        lNF3PiIkpS2xl+DA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Always set .need_qs from __rcu_read_lock() for
 strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532169.7002.7955225833209656470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f19920e412fdeed1e15691bcee5b40e18b8e96ff
Gitweb:        https://git.kernel.org/tip/f19920e412fdeed1e15691bcee5b40e18b8e96ff
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 09:40:18 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:25 -07:00

rcu: Always set .need_qs from __rcu_read_lock() for strict GPs

The ->rcu_read_unlock_special.b.need_qs field in the task_struct
structure indicates that the RCU core needs a quiscent state from the
corresponding task.  The __rcu_read_unlock() function checks this (via
an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
reports a quiscent state immediately upon exit from the outermost RCU
read-side critical section.

Currently, this flag is only set when the scheduling-clock interrupt
decides that the current RCU grace period is too old, as in about
one full second too old.  But if the kernel has been built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
long.  This commit therefore sets the .need_qs field immediately at the
start of the RCU read-side critical section from within __rcu_read_lock()
in order to unconditionally enlist help from __rcu_read_unlock().

But note the additional check for rcu_state.gp_kthread, which prevents
attempts to awaken RCU's grace-period kthread during early boot before
there is a scheduler.  Leaving off this check results in early boot hangs.
So early that there is no console output.  Thus, this additional check
fails until such time as RCU's grace-period kthread has been created,
avoiding these empty-console hangs.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 44cf77d..668bbd2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -376,6 +376,8 @@ void __rcu_read_lock(void)
 	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
+		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
