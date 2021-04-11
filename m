Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82EC35B4F8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDKNod (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbhDKNoL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:11 -0400
Date:   Sun, 11 Apr 2021 13:43:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VdjbInYUm/+XYAwaoDDVs3tRWaPO+9nKVh6a4gWnTuM=;
        b=PrXK5x7FlC7TD3PLV3yFFuBx3+yIlA17n9VXh7zoDRZdl02P7NIkBg8dbgCUTG83gjHab0
        4FYpwAmeUlMzkB3ycfs9eG27B1Ttvn1S7VIBa+w0+Uq0B7kgx7liZ0B0XCnR09vKPbOabk
        q44EkWD9GNyAFEkSUxr6leX3kmsWg7XITYUkvr07XIDO3zYn50t7/OsrE+/XTt/Xt/zSe5
        eUcXoZAcynYPU1U6Tj56yPAkewWzgEBpLSHUTwi6NLilq9cIKcagNtpZJqAZMQCxkLVqd0
        7RedtIJW2avDBUY3THB1slPmSOGaqUvD9OyGBbtQHBAU8reNxF74e/XTb0pZGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148617;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VdjbInYUm/+XYAwaoDDVs3tRWaPO+9nKVh6a4gWnTuM=;
        b=FRYnrpYq9xoYaF4nEtMSaw+evwOw8dkPl6uwK9b0MEehodkd6pOzqV/di8IYAXSagj4DOn
        s/PXri/hahusgqDQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Only (re-)initialize segcblist when needed
 on CPU up
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861661.29796.13634261035877506522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ec711bc12c777b1165585f59f7a6c35a89e04cc3
Gitweb:        https://git.kernel.org/tip/ec711bc12c777b1165585f59f7a6c35a89e04cc3
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 18:12:10 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:22 -08:00

rcu/nocb: Only (re-)initialize segcblist when needed on CPU up

At the start of a CPU-hotplug operation, the incoming CPU's callback
list can be in a number of states:

1.	Disabled and empty.  This is the case when the boot CPU has
	not invoked call_rcu(), when a non-boot CPU first comes online,
	and when a non-offloaded CPU comes back online.  In this case,
	it is both necessary and permissible to initialize ->cblist.
	Because either the CPU is currently running with interrupts
	disabled (boot CPU) or is not yet running at all (other CPUs),
	it is not necessary to acquire ->nocb_lock.

	In this case, initialization is required.

2.	Disabled and non-empty.  This cannot occur, because early boot
	call_rcu() invocations enable the callback list before enqueuing
	their callback.

3.	Enabled, whether empty or not.	In this case, the callback
	list has already been initialized.  This case occurs when the
	boot CPU has executed an early boot call_rcu() and also when
	an offloaded CPU comes back online.  In both cases, there is
	no need to initialize the callback list: In the boot-CPU case,
	the CPU has not (yet) gone offline, and in the offloaded case,
	the rcuo kthreads are taking care of business.

	Because it is not necessary to initialize the callback list,
	it is also not necessary to acquire ->nocb_lock.

Therefore, checking if the segcblist is enabled suffices.  This commit
therefore initializes the callback list at rcutree_prepare_cpu() time
only if that list is disabled.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee77858..402ea36 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4084,14 +4084,13 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
+
 	/*
-	 * Lock in case the CB/GP kthreads are still around handling
-	 * old callbacks.
+	 * Only non-NOCB CPUs that didn't have early-boot callbacks need to be
+	 * (re-)initialized.
 	 */
-	rcu_nocb_lock(rdp);
-	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
+	if (!rcu_segcblist_is_enabled(&rdp->cblist))
 		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
-	rcu_nocb_unlock(rdp);
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
