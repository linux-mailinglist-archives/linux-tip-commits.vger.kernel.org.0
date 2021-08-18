Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427373EFE67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhHRH7W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbhHRH7T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1668C0613CF;
        Wed, 18 Aug 2021 00:58:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8FrK0OgPXogtI25SEE8/xjcIXnLsYOoRGxOfDRFp2us=;
        b=G+l/W07oNeSes/W1QgbO6/9re+fgyPQWGudhh/BIHhn8dvxEj6SfwT0FLsrOUSILfTrbCC
        rmUx5PYpsemMKCYWM/4Zs8NVetH0pQq/KKi2Zr9gAwg7v4nYPa7CfYsfdGfX9vIrF4+lkS
        TqgNYPtOHW3ZDdOuXzIohk7+pz6202oWp4HYJzr3FTeN/kyEj2Q+vuv9oC4tFYNn4EYZah
        TFQwtcPXHWfg/12dfNtFhr7TlfswmhvNestZSdLkPPdKFZG3dKNgWYpRAI7SP3zCxLSrgd
        SXy6/VhujSx3rgka+zQefrjGynllG0WaIJYsg8KQ4wW14k+Bf55sEpV2nIMh1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8FrK0OgPXogtI25SEE8/xjcIXnLsYOoRGxOfDRFp2us=;
        b=/Ddv25IN75BludfvnBFrry9K2A60zf1acstMOItMmhpCR+4qiEbwo0uQypWzmZ2dGTnKDE
        dhhRfOFfhQVYaWDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] tools/memory-model: Add example for heuristic
 lockless reads
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352108.25758.14477266680514227448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     436eef23c41fe10dc34ed19a00caf9f1290a8689
Gitweb:        https://git.kernel.org/tip/436eef23c41fe10dc34ed19a00caf9f1290a8689
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 13 May 2021 14:54:58 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 27 Jul 2021 11:47:34 -07:00

tools/memory-model: Add example for heuristic lockless reads

This commit adds example code for heuristic lockless reads, based loosely
on the sem_lock() and sem_unlock() functions.

[ paulmck: Apply Alan Stern and Manfred Spraul feedback. ]

Reported-by: Manfred Spraul <manfred@colorfullife.com>
[ paulmck: Update per Manfred Spraul and Hillf Danton feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 93 ++++++++++++-
 1 file changed, 93 insertions(+)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 58bff26..d96fe20 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -319,6 +319,99 @@ of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
 concurrent lockless write.
 
 
+Lock-Protected Writes With Heuristic Lockless Reads
+---------------------------------------------------
+
+For another example, suppose that the code can normally make use of
+a per-data-structure lock, but there are times when a global lock
+is required.  These times are indicated via a global flag.  The code
+might look as follows, and is based loosely on nf_conntrack_lock(),
+nf_conntrack_all_lock(), and nf_conntrack_all_unlock():
+
+	bool global_flag;
+	DEFINE_SPINLOCK(global_lock);
+	struct foo {
+		spinlock_t f_lock;
+		int f_data;
+	};
+
+	/* All foo structures are in the following array. */
+	int nfoo;
+	struct foo *foo_array;
+
+	void do_something_locked(struct foo *fp)
+	{
+		/* This works even if data_race() returns nonsense. */
+		if (!data_race(global_flag)) {
+			spin_lock(&fp->f_lock);
+			if (!smp_load_acquire(&global_flag)) {
+				do_something(fp);
+				spin_unlock(&fp->f_lock);
+				return;
+			}
+			spin_unlock(&fp->f_lock);
+		}
+		spin_lock(&global_lock);
+		/* global_lock held, thus global flag cannot be set. */
+		spin_lock(&fp->f_lock);
+		spin_unlock(&global_lock);
+		/*
+		 * global_flag might be set here, but begin_global()
+		 * will wait for ->f_lock to be released.
+		 */
+		do_something(fp);
+		spin_unlock(&fp->f_lock);
+	}
+
+	void begin_global(void)
+	{
+		int i;
+
+		spin_lock(&global_lock);
+		WRITE_ONCE(global_flag, true);
+		for (i = 0; i < nfoo; i++) {
+			/*
+			 * Wait for pre-existing local locks.  One at
+			 * a time to avoid lockdep limitations.
+			 */
+			spin_lock(&fp->f_lock);
+			spin_unlock(&fp->f_lock);
+		}
+	}
+
+	void end_global(void)
+	{
+		smp_store_release(&global_flag, false);
+		spin_unlock(&global_lock);
+	}
+
+All code paths leading from the do_something_locked() function's first
+read from global_flag acquire a lock, so endless load fusing cannot
+happen.
+
+If the value read from global_flag is true, then global_flag is
+rechecked while holding ->f_lock, which, if global_flag is now false,
+prevents begin_global() from completing.  It is therefore safe to invoke
+do_something().
+
+Otherwise, if either value read from global_flag is true, then after
+global_lock is acquired global_flag must be false.  The acquisition of
+->f_lock will prevent any call to begin_global() from returning, which
+means that it is safe to release global_lock and invoke do_something().
+
+For this to work, only those foo structures in foo_array[] may be passed
+to do_something_locked().  The reason for this is that the synchronization
+with begin_global() relies on momentarily holding the lock of each and
+every foo structure.
+
+The smp_load_acquire() and smp_store_release() are required because
+changes to a foo structure between calls to begin_global() and
+end_global() are carried out without holding that structure's ->f_lock.
+The smp_load_acquire() and smp_store_release() ensure that the next
+invocation of do_something() from do_something_locked() will see those
+changes.
+
+
 Lockless Reads and Writes
 -------------------------
 
