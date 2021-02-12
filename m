Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F74319EDA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBLMmj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhBLMkc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:32 -0500
Date:   Fri, 12 Feb 2021 12:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pzZ+BMb0j0h9bM1TQUGZ+WGMTVl+eUOV9P3uLOsTiVU=;
        b=ARCmFGPSwjJdwCVWJM81ABpPI+B4uzEOL11u74w5RqkvkDonvq/ae1S4O8FmzgO/jbBXBu
        ccpLsROjsrLson7ZUuQs0aqzzq+i64/eO715rGGbuZYo2MxcmyU6LjdGVPd/jPgaj1kOj1
        qJ22E4uY4EFChJxrgPUFReVPDog1cBJJ/a7uj5n1uQdFOnOmurxtUKWPjB5mm4QW3VQV/Z
        naHJg/H/AfR6UuxnmKKn/EfXk5vZFcO1MeqWBL2rPiK1oV4DIC/t6MG79VAvOtruBbuTq7
        6zQuV3Ws3Mk/K1uyj4q4WQTkCeb0I95S65+jR7t4V9Wv3Lfqj36OWtbkXzo0vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pzZ+BMb0j0h9bM1TQUGZ+WGMTVl+eUOV9P3uLOsTiVU=;
        b=JLVNs+NJ4ZuSb+QrRpIrRuOMepejRCYHgSLVZccdDo3XSGwlMIU8DnFZP2vrEc+6KmMaC+
        r7LfFHE+WFXi/yDA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: segcblist: Remove redundant smp_mb()s
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344161.23325.14274383018495244052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     68804cf1c905ce227e4e1d0bc252c216811c59fd
Gitweb:        https://git.kernel.org/tip/68804cf1c905ce227e4e1d0bc252c216811c59fd
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Wed, 14 Oct 2020 18:21:53 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/tree: segcblist: Remove redundant smp_mb()s

The full memory barriers in rcu_segcblist_enqueue() and in rcu_do_batch()
are not needed because rcu_segcblist_add_len(), and thus also
rcu_segcblist_inc_len(), already includes a memory barrier *before*
and *after* the length of the list is updated.

This commit therefore removes these redundant smp_mb() invocations.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 7777804..1e80a0a 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -327,7 +327,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc6f379..b0fb654 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2523,7 +2523,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
