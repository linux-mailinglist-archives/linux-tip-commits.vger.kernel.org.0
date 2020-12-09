Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132B82D4948
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbgLISmN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgLISja (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE02C0613D6;
        Wed,  9 Dec 2020 10:38:50 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcV8BJ/omVvrB3Axifuak69PnU7W6cTm9AfQijivhLY=;
        b=zLIweO/9cHztXuWdnhznL7bnx1ezX4xf59K8KCbSsw/gO32P4tda4R9ZzdkgSLqoDWyQmU
        annw/2LGybNuFiwuZ1oWKvuWLiV47G/hnMjrWb0o029/fkIxQURy3H9Q/Et/ptH5+aLvoY
        mU4AAcguGQ5m1F8UBfk62GGH0Vg2e9e6lhMpb2+2J231pQrW+lny5KMNCuOaSTpwoOmvPq
        s3FmLVNMkPF9v3CZGFUTPHzeDm6LjBvDfezG5AuRunmn4WnLh/F5tZbL2Xe1qRuH9lyaE6
        QRm8P6zv0U0v7NUbRLDkTikO6ocRDc2ttMuUOf/QSozl2yxETeUoQoXS6BCQEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcV8BJ/omVvrB3Axifuak69PnU7W6cTm9AfQijivhLY=;
        b=l0ObtSSPJw8gpia911IDSerAr5mYQeoGEvyA1mer4WU9KgsSCDbCJF99wELrYLy3bgdO62
        dmzNXzMh9LrzSLBQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Prevent potential lock starvation
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201121041416.12285-3-longman@redhat.com>
References: <20201121041416.12285-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <160753912781.3364.7199376060300852014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2f06f702925b512a95b95dca3855549c047eef58
Gitweb:        https://git.kernel.org/tip/2f06f702925b512a95b95dca3855549c047eef58
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 20 Nov 2020 23:14:13 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:48 +01:00

locking/rwsem: Prevent potential lock starvation

The lock handoff bit is added in commit 4f23dbc1e657 ("locking/rwsem:
Implement lock handoff to prevent lock starvation") to avoid lock
starvation. However, allowing readers to do optimistic spinning does
introduce an unlikely scenario where lock starvation can happen.

The lock handoff bit may only be set when a waiter is being woken up.
In the case of reader unlock, wakeup happens only when the reader count
reaches 0. If there is a continuous stream of incoming readers acquiring
read lock via optimistic spinning, it is possible that the reader count
may never reach 0 and so the handoff bit will never be asserted.

One way to prevent this scenario from happening is to disallow optimistic
spinning if the rwsem is currently owned by readers. If the previous
or current owner is a writer, optimistic spinning will be allowed.

If the previous owner is a reader but the reader count has reached 0
before, a wakeup should have been issued. So the handoff mechanism
will be kicked in to prevent lock starvation. As a result, it should
be OK to do optimistic spinning in this case.

This patch may have some impact on reader performance as it reduces
reader optimistic spinning especially if the lock critical sections
are short the number of contending readers are small.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lkml.kernel.org/r/20201121041416.12285-3-longman@redhat.com
---
 kernel/locking/rwsem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 5768b90..c055f4b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1010,16 +1010,27 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 {
-	long adjustment = -RWSEM_READER_BIAS;
+	long owner, adjustment = -RWSEM_READER_BIAS;
+	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 	bool wake = false;
 
 	/*
+	 * To prevent a constant stream of readers from starving a sleeping
+	 * waiter, don't attempt optimistic spinning if the lock is currently
+	 * owned by readers.
+	 */
+	owner = atomic_long_read(&sem->owner);
+	if ((owner & RWSEM_READER_OWNED) && (rcnt > 1) &&
+	   !(count & RWSEM_WRITER_LOCKED))
+		goto queue;
+
+	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
 	 */
-	waiter.last_rowner = atomic_long_read(&sem->owner);
+	waiter.last_rowner = owner;
 	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
 		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
 
