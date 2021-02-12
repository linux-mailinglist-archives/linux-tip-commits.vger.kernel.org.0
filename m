Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814B8319EE1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhBLMnI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhBLMkf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:35 -0500
Date:   Fri, 12 Feb 2021 12:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O6GxGBS3nEhZsc2UaSGbSx6LNp+AoYK3iSZ9h3sxALE=;
        b=xek3hKZRA/D3ffDXgxwgRvoJuGxk4VmJwViw1aDf6x+h5AkBk5f6FH4KeTwolLHEy/0TuL
        teKK/KhRVDi84fpE+CKvisz8tfunTmUxMQfex24oYq1Wmbs+PyijqyYRZ1h3Gz8uLR6qr9
        0q7mRie5h73G20RCZpUFL6ZbloIcIzApotE+EP4Kt+crUSbQBygEKE30E5oNINrOSmjkbf
        yoJvMRUHOvok1hsD9TLrvHnHle94W2hM7+OEDy4cAtXfY6kytGPo+0Oiu7KLUTx20P6Sxa
        BS4QJqG2oAI3ktHFZ9FwboUgYd7DMzmIn/VO0e/c/tDLgqELwy5fl+pbh2sa7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O6GxGBS3nEhZsc2UaSGbSx6LNp+AoYK3iSZ9h3sxALE=;
        b=8gLROf1dT9Dy8zHV9RBU7UKGY7jWFBI3np9XYUFaj8X+6wC8U2e/Hi9p2iWIVfLhvQqmpH
        ZsPieykG8sjw5cBg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/segcblist: Add additional comments to explain smp_mb()
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344223.23325.13792940906941856081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c2e13112e830c06825339cbadf0b3bc2bdb9a716
Gitweb:        https://git.kernel.org/tip/c2e13112e830c06825339cbadf0b3bc2bdb9a716
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Tue, 03 Nov 2020 09:26:03 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:23:23 -08:00

rcu/segcblist: Add additional comments to explain smp_mb()

One counter-intuitive property of RCU is the fact that full memory
barriers are needed both before and after updates to the full
(non-segmented) length.  This patch therefore helps to assist the
reader's intuition by adding appropriate comments.

[ paulmck:  Wordsmithing. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 68 ++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index bb246d8..3cff800 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,17 +94,77 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * field to disagree with the actual number of callbacks on the structure.
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
+ *
+ * So why on earth is a memory barrier required both before and after
+ * the update to the ->len field???
+ *
+ * The reason is that rcu_barrier() locklessly samples each CPU's ->len
+ * field, and if a given CPU's field is zero, avoids IPIing that CPU.
+ * This can of course race with both queuing and invoking of callbacks.
+ * Failing to correctly handle either of these races could result in
+ * rcu_barrier() failing to IPI a CPU that actually had callbacks queued
+ * which rcu_barrier() was obligated to wait on.  And if rcu_barrier()
+ * failed to wait on such a callback, unloading certain kernel modules
+ * would result in calls to functions whose code was no longer present in
+ * the kernel, for but one example.
+ *
+ * Therefore, ->len transitions from 1->0 and 0->1 have to be carefully
+ * ordered with respect with both list modifications and the rcu_barrier().
+ *
+ * The queuing case is CASE 1 and the invoking case is CASE 2.
+ *
+ * CASE 1: Suppose that CPU 0 has no callbacks queued, but invokes
+ * call_rcu() just as CPU 1 invokes rcu_barrier().  CPU 0's ->len field
+ * will transition from 0->1, which is one of the transitions that must
+ * be handled carefully.  Without the full memory barriers after the ->len
+ * update and at the beginning of rcu_barrier(), the following could happen:
+ *
+ * CPU 0				CPU 1
+ *
+ * call_rcu().
+ *					rcu_barrier() sees ->len as 0.
+ * set ->len = 1.
+ *					rcu_barrier() does nothing.
+ *					module is unloaded.
+ * callback invokes unloaded function!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0 will
+ * have unambiguously preceded the return from the racing call_rcu(), which
+ * means that this call_rcu() invocation is OK to not wait on.  After all,
+ * you are supposed to make sure that any problematic call_rcu() invocations
+ * happen before the rcu_barrier().
+ *
+ *
+ * CASE 2: Suppose that CPU 0 is invoking its last callback just as
+ * CPU 1 invokes rcu_barrier().  CPU 0's ->len field will transition from
+ * 1->0, which is one of the transitions that must be handled carefully.
+ * Without the full memory barriers before the ->len update and at the
+ * end of rcu_barrier(), the following could happen:
+ *
+ * CPU 0				CPU 1
+ *
+ * start invoking last callback
+ * set ->len = 0 (reordered)
+ *					rcu_barrier() sees ->len as 0
+ *					rcu_barrier() does nothing.
+ *					module is unloaded
+ * callback executing after unloaded!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0
+ * will be fully ordered after the completion of the callback function,
+ * so that the module unloading operation is completely safe.
+ *
  */
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
-	smp_mb__before_atomic(); /* Up to the caller! */
+	smp_mb__before_atomic(); // Read header comment above.
 	atomic_long_add(v, &rsclp->len);
-	smp_mb__after_atomic(); /* Up to the caller! */
+	smp_mb__after_atomic();  // Read header comment above.
 #else
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 	WRITE_ONCE(rsclp->len, rsclp->len + v);
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 #endif
 }
 
