Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7F3B83FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhF3Nvv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhF3Nuo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:44 -0400
Date:   Wed, 30 Jun 2021 13:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FONzyO1Zm9hJRyZZCFyBJHv/2i0s4Yooe40atB0O01M=;
        b=JFZP4fvIC/FMX06808Hqw+6OSRGfdWr3txs26wE76CkOOQh6i/TD22ePlT5qdjZkNnBNKW
        W8S4ywsSF2md6oz7yPkPpDL679zAtnzWPcP8xY0ssAMLoPfgkiJJYE3nnZqUrEX7na7oK9
        IaPwhHz4veRsu1LRilrbwnvmINDJ7g8UvLVYXeoouy9ooeqPwT6rTM521byso+Bb50rLmc
        qaaoKNOgzuKorWfT5+8bugP4qzAGN7jiH0UwKyR6/7KUpWxTcrGBw16HaJS2MD2vXMSMW9
        Q9dE9FKvEF6ZrAW2ZXOrD+a3pbxZc20QvGY+aH1LntJ025ikMgN+LHlEqQ9+Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FONzyO1Zm9hJRyZZCFyBJHv/2i0s4Yooe40atB0O01M=;
        b=rjSVD1GrU0t7DwNXW+XOznzKgtAJsETJ94EYdfz0HegTDkRFF2ENgIrVceoVBpbhg4Y+M4
        TmqsaBISE6dA4YCQ==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Fix comments according to current code
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087745.395.10446409807969301478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d8628f35bae0d0b1f06ca32fa57de76a7055e731
Gitweb:        https://git.kernel.org/tip/d8628f35bae0d0b1f06ca32fa57de76a7055e731
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Wed, 28 Apr 2021 15:44:22 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Fix comments according to current code

The kvfree_rcu() function now defers allocations in the common
case due to the fact that there is no lockless access to the
memory-allocator caches/pools.  In addition, in CONFIG_PREEMPT_NONE=y
and in CONFIG_PREEMPT_VOLUNTARY=y kernels, there is no reliable way to
determine if spinlocks are held.  As a result, allocation is deferred in
the common case, and the two-argument form of kvfree_rcu() thus uses the
"channel 3" queue through all the rcu_head structures.  This channel
is called referred to as the emergency case in comments, and these
comments are now obsolete.

This commit therefore updates these comments to reflect the new
common-case nature of such emergencies.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d643fd8..b043af7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3355,9 +3355,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * Emergency case only. It can happen under low memory
-	 * condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporary maintained.
+	 * This is used when the "bulk" path can not be used for the
+	 * double-argument of kvfree_rcu().  This happens when the
+	 * page-cache is empty, which means that objects are instead
+	 * queued on a linked list through their rcu_head structures.
+	 * This list is named "Channel 3".
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -3403,8 +3405,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			// Channel 1 corresponds to SLAB ptrs.
-			// Channel 2 corresponds to vmalloc ptrs.
+			// Channel 1 corresponds to the SLAB-pointer bulk path.
+			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (!krwp->bkvhead_free[j]) {
 					krwp->bkvhead_free[j] = krcp->bkvhead[j];
@@ -3412,7 +3414,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				}
 			}
 
-			// Channel 3 corresponds to emergency path.
+			// Channel 3 corresponds to both SLAB and vmalloc
+			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
