Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1752D9030
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgLMT35 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:29:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLMTBm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:42 -0500
Date:   Sun, 13 Dec 2020 19:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+CbHgVki3q1baGdbDkEk/RUvyB4yTwMgFVyKhn5reU8=;
        b=SDuxwSrfqwSbrti8SXlLEN+pIKMVhFZjCnHK73c3Er8Q/PrejAWLyXfoH5yBwKNbx6C68y
        hDKysJR78sAsYKSnzF4KL02lFfQ1rpASurV306Jj6oKUBvXwKpwT2/bp/NH4jjV+NRx+sc
        +4AG7dw7t/wSJ5vUrfWOM4799Jkd2EljrBI3HLm7rOe/Zofhg6Q/DYg6rIUUNg7FPEj+ix
        ACW4SGe2N7DG7Gm2eT3BLhqb0h4zLzW8UGoFyna6HWJhJoC4QTPO8gEu5exVVKArlgPn5R
        fdmhJEBAfpZo4CWgkaJj5X1W7NDHAYv8di3bdDj+wqI3QNrweu00uDSRWqOfiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+CbHgVki3q1baGdbDkEk/RUvyB4yTwMgFVyKhn5reU8=;
        b=+mtGMkXlg4jmHlh9qOlCNhWWH3UaoHrRlOMktvlGqXgmom5lelX8nJxnAnGK+rhV3TZSoN
        yRwD7GfnxVU9KrAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Do not report strict GPs for outgoing CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788605941.3364.4968080291078714518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bfb3aa735f82c8d98b32a669934ee7d6b346264d
Gitweb:        https://git.kernel.org/tip/bfb3aa735f82c8d98b32a669934ee7d6b346264d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 30 Oct 2020 13:11:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu: Do not report strict GPs for outgoing CPUs

An outgoing CPU is marked offline in a stop-machine handler and most
of that CPU's services stop at that point, including IRQ work queues.
However, that CPU must take another pass through the scheduler and through
a number of CPU-hotplug notifiers, many of which contain RCU readers.
In the past, these readers were not a problem because the outgoing CPU
has interrupts disabled, so that rcu_read_unlock_special() would not
be invoked, and thus RCU would never attempt to queue IRQ work on the
outgoing CPU.

This changed with the advent of the CONFIG_RCU_STRICT_GRACE_PERIOD
Kconfig option, in which rcu_read_unlock_special() is invoked upon exit
from almost all RCU read-side critical sections.  Worse yet, because
interrupts are disabled, rcu_read_unlock_special() cannot immediately
report a quiescent state and will therefore attempt to defer this
reporting, for example, by queueing IRQ work.  Which fails with a splat
because the CPU is already marked as being offline.

But it turns out that there is no need to report this quiescent state
because rcu_report_dead() will do this job shortly after the outgoing
CPU makes its final dive into the idle loop.  This commit therefore
makes rcu_read_unlock_special() refrain from queuing IRQ work onto
outgoing CPUs.

Fixes: 44bad5b3cca2 ("rcu: Do full report for .need_qs for strict GPs")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jann Horn <jannh@google.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e..7e291ce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -628,7 +628,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp) {
+			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				init_irq_work(&rdp->defer_qs_iw,
