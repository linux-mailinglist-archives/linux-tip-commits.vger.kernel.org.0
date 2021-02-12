Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A9319ED4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhBLMmF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhBLMkW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:22 -0500
Date:   Fri, 12 Feb 2021 12:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jtPlI7mTmnuJg4uabjCGPIJebTqlrrACfi+GBLFFdZ0=;
        b=e3QL5hpPXv8xJrRMKAGJSuyQuh206vC+bkhhEaEyWSJfBH9xB3OMMp69zuH4PO+bxc6RLM
        YjanS6D+VHArqxm7JZc7iHR8Wzc5VQryXpn6YgWEBFMy8v47zyXY+b763JpBRuplU1CRgi
        lZg9dZ7lhOd5zs8SD+Y2D8LnnG8okFSu1AVBg9UqUyk2puSSii4FeUPh6SgdOjuNOlJd1U
        RjOeXN7lOMtVBkZfq8VQAqqv1dYz8P1cNHOxhCt0dznbE2z4yIfCOlKJQjAMZP65ha0d3b
        caFVr/vNTNVM5dCAVabJunLLvkacvItGBJtxfrUVovVfd8fe04HiFCi0dWcw4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jtPlI7mTmnuJg4uabjCGPIJebTqlrrACfi+GBLFFdZ0=;
        b=JDilnQ4roORI0Us09oRW1EBarDaWvmNWShlLwSCQGWR07Ox/IPjg3i9RU+K0hm630adNT0
        yOYJmTpaVvABCLCQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Always init segcblist on CPU up
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344028.23325.6022208183454811527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     126d9d49528dae792859e5f11f3b447ce8a9a9b4
Gitweb:        https://git.kernel.org/tip/126d9d49528dae792859e5f11f3b447ce8a9a9b4
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:18 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/nocb: Always init segcblist on CPU up

How the rdp->cblist enabled state is treated at CPU-hotplug time depends
on whether or not that ->cblist is offloaded.

1) Not offloaded: The ->cblist is disabled when the CPU goes down. All
   its callbacks are migrated and none can to enqueued until after some
   later CPU-hotplug operation brings the CPU back up.

2) Offloaded: The ->cblist is not disabled on CPU down because the CB/GP
   kthreads must finish invoking the remaining callbacks. There is thus
   no need to re-enable it on CPU up.

Since the ->cblist offloaded state is set in stone at boot, it cannot
change between CPU down and CPU up. So 1) and 2) are symmetrical.

However, given runtime toggling of the offloaded state, there are two
additional asymmetrical scenarios:

3) The ->cblist is not offloaded when the CPU goes down. The ->cblist
   is later toggled to offloaded and then the CPU comes back up.

4) The ->cblist is offloaded when the CPU goes down. The ->cblist is
   later toggled to no longer be offloaded and then the CPU comes back up.

Scenario 4) is currently handled correctly. The ->cblist remains enabled
on CPU down and gets re-initialized on CPU up. The toggling operation
will wait until ->cblist is empty, so ->cblist will remain empty until
CPU-up time.

The scenario 3) would run into trouble though, as the rdp is disabled
on CPU down and not re-initialized/re-enabled on CPU up.  Except that
in this case, ->cblist is guaranteed to be empty because all its
callbacks were migrated away at CPU-down time.  And the CPU-up code
already initializes and enables any empty ->cblist structures in order
to handle the possibility of early-boot invocations of call_rcu() in
the case where such invocations don't occur.  So all that need be done
is to adjust the locking.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7cfc2e8..83362f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4015,12 +4015,18 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
-	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
-	    !rcu_segcblist_is_offloaded(&rdp->cblist))
-		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
+	/*
+	 * Lock in case the CB/GP kthreads are still around handling
+	 * old callbacks (longer term we should flush all callbacks
+	 * before completing CPU offline)
+	 */
+	rcu_nocb_lock(rdp);
+	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
+		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
+	rcu_nocb_unlock(rdp);
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
