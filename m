Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311AC288260
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgJIGgj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbgJIGfm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:42 -0400
Date:   Fri, 09 Oct 2020 06:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yJbGKcVNZiv3M4rGlbKiiuSECxyqIZLuUNaQ7knqa9w=;
        b=CvE3hKCAjrxn7fpljUABUF3/oof3NPMFekaouwAbkodU2IITuLF067CBE86XS5cMWup01Y
        64h2T56Kk7EmDZxA1bTEDW+souZPgw7JU4XHkojTH4fULJ0t2h5OYWGQTc12B/6y56q8M/
        4gDIIiz1DKd1OXDbF5NzdIk31vTnFD1n2YnJaXYn92uEaH398xLX08p30FK1uzhQWqC/8v
        tbJry3Hg0LKMkIj6EF4QPa3hmGizV1Azt/lWY328ZcLQnsnW4iFNNtCOynoVU8ojducfjV
        adNeO3TJoXptEnoatHNsj406ap6mSNmnhu1jDjkrBB23XAKwp+PTIuhojqFqxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yJbGKcVNZiv3M4rGlbKiiuSECxyqIZLuUNaQ7knqa9w=;
        b=F16svzurh14woVkENP37BfJt7dRRmlf2fcjQbxojR4m5IlRvPHAwp5yxU0tVkcjpbbqNaW
        n2LcNgQVjOBQ0gCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533973.7002.13740505646082417641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b5374b2df0ac1c78895b8eb8d9582a7bdc67257d
Gitweb:        https://git.kernel.org/tip/b5374b2df0ac1c78895b8eb8d9582a7bdc67257d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 17:09:27 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:06 -07:00

rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor

Given that sysfs can change the value of rcu_divisor at any time, this
commit adds a READ_ONCE to the sole access to that variable.  While in
the area, this commit also adds bounds checking, clamping the value to
a shift that makes sense for a signed long.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acc926f..1dca14c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2362,6 +2362,7 @@ int rcutree_dead_cpu(unsigned int cpu)
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
+	int div;
 	unsigned long flags;
 	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
@@ -2390,7 +2391,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
-	bl = max(rdp->blimit, pending >> rcu_divisor);
+	div = READ_ONCE(rcu_divisor);
+	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
+	bl = max(rdp->blimit, pending >> div);
 	if (unlikely(bl > 100))
 		tlimit = local_clock() + rcu_resched_ns;
 	trace_rcu_batch_start(rcu_state.name,
