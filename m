Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37D40D92B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhIPMAp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhIPMAo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0CC061574;
        Thu, 16 Sep 2021 04:59:22 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6bp+lonpeyGKegxiKCOqMeqZVfuUHCpWIOwqL5z7S8=;
        b=b9Ba8OqW8kigmY3uIIw53SgFByum+CB1p7qFwXdQA+Pytn8d/TwVNhviOQbnJ3dxULfAKN
        fob4ld21iDR7u39IWlUSXF87gm6Vc5r69cciAie21pegb8KWOcgL5E5qnlvQyHns4gyhUN
        reBzcrPeWeYvg4y+5GN9iSOm2o0VW59oajLXHylW9h8YRm2y51VcV5sXjB4zv+tDTOK7dn
        0GJCPWSlSzKPIa5Kk7sVy8p35jsw2LmwhDP9lk1tmDwj2TRiRugZWO8Xm1hPA1b1fXASZi
        4bp6fqHkZ4+86H0+tYXElcLhZIft4VWYXlJYPZ8MJDJSTxsIZatARjJY7ugWEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6bp+lonpeyGKegxiKCOqMeqZVfuUHCpWIOwqL5z7S8=;
        b=EWYFe3OulQoxDNvwuEH+sEbNx+0K/MVf+we7GiddcR6XuSpOHcJ83SamfmVjsL1ur41J5J
        N48d9IroB733T7AA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwbase: Take care of ordering guarantee
 for fastpath reader
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210909110203.953991276@infradead.org>
References: <20210909110203.953991276@infradead.org>
MIME-Version: 1.0
Message-ID: <163179355810.25758.5004723890561552060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     81121524f1c798c9481bd7900450b72ee7ac2eef
Gitweb:        https://git.kernel.org/tip/81121524f1c798c9481bd7900450b72ee7ac2eef
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 09 Sep 2021 12:59:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:16 +02:00

locking/rwbase: Take care of ordering guarantee for fastpath reader

Readers of rwbase can lock and unlock without taking any inner lock, if
that happens, we need the ordering provided by atomic operations to
satisfy the ordering semantics of lock/unlock. Without that, considering
the follow case:

	{ X = 0 initially }

	CPU 0			CPU 1
	=====			=====
				rt_write_lock();
				X = 1
				rt_write_unlock():
				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
				  // ->readers is READER_BIAS.
	rt_read_lock():
	  if ((r = atomic_read(->readers)) < 0) // True
	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
	  <acquire the read lock via fast path>

	r1 = X;	// r1 may be 0, because nothing prevent the reordering
	        // of "X=1" and atomic_add() on CPU 1.

Therefore audit every usage of atomic operations that may happen in a
fast path, and add necessary barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210909110203.953991276@infradead.org
---
 kernel/locking/rwbase_rt.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 48fbbcc..88191f6 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -41,6 +41,12 @@
  * The risk of writer starvation is there, but the pathological use cases
  * which trigger it are not necessarily the typical RT workloads.
  *
+ * Fast-path orderings:
+ * The lock/unlock of readers can run in fast paths: lock and unlock are only
+ * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
+ * semantics of rwbase_rt. Atomic ops should thus provide _acquire()
+ * and _release() (or stronger).
+ *
  * Common code shared between RT rw_semaphore and rwlock
  */
 
@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * dec_and_test() is fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * _release() is needed in case that reader is in fast path, pairing
+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 */
+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -201,7 +214,11 @@ static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
 	/* Can do without CAS because we're serialized by wait_lock. */
 	lockdep_assert_held(&rwb->rtmutex.wait_lock);
 
-	if (!atomic_read(&rwb->readers)) {
+	/*
+	 * _acquire is needed in case the reader is in the fast path, pairing
+	 * with rwbase_read_unlock(), provides ACQUIRE.
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
 		return 1;
 	}
