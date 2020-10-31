Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73C2A157A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Oct 2020 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgJaLaf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 31 Oct 2020 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgJaLaf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 31 Oct 2020 07:30:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E78C0613D5;
        Sat, 31 Oct 2020 04:30:34 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:30:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604143832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsB98iqrU+rxw9xA0DzPumvB4zFOqFjdq5X8x1qmzcI=;
        b=kYs4tsOfxqOJAKQBL4SWSanhu1q11ig47I9zQdYLNK9gSad19mOTd6sQEnr2Wjd73NPK59
        A/j1ZgTolXTFXOemS75AUzktF+NzDJc+CfrI/vk4IHO3pgsmGyWnP705tDpbdxAonNNKu7
        JvwKZE+l7GMUU7QGvbusm4kiYT7oNkLsWNnURlTbzBkjaWl/I0vuYCOWyo69NiTkXWWO10
        hdrncZJvIjWYKmBBwCj3/SZY/9L1N/6vwJUumKC6GhcvWL9nEbRo+5gDRz4ZUoZFiIrj1R
        cPEyV46+b0mbksL/xxnquMlVou1bMGi+BvIP1EgQpa0f2U8GgofdIz0OclNTTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604143832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsB98iqrU+rxw9xA0DzPumvB4zFOqFjdq5X8x1qmzcI=;
        b=dpm4Z9jYFbpZXg7WTVtqCVQX72tcyLU8w71q8KSuP9rvLoArcyPyjAsST9Rd7UX6PqLOfh
        F5QS5KO24fV2ExBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Fix nr_unused_locks accounting
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201027124834.GL2628@hirez.programming.kicks-ass.net>
References: <20201027124834.GL2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160414383158.397.3025016969633820018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1a39340865ce505a029b37aeb47a3e4c8db5f6c6
Gitweb:        https://git.kernel.org/tip/1a39340865ce505a029b37aeb47a3e4c8db5f6c6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Oct 2020 13:48:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Oct 2020 17:07:18 +01:00

lockdep: Fix nr_unused_locks accounting

Chris reported that commit 24d5a3bffef1 ("lockdep: Fix
usage_traceoverflow") breaks the nr_unused_locks validation code
triggered by /proc/lockdep_stats.

By fully splitting LOCK_USED and LOCK_USED_READ it becomes a bad
indicator for accounting nr_unused_locks; simplyfy by using any first
bit.

Fixes: 24d5a3bffef1 ("lockdep: Fix usage_traceoverflow")
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://lkml.kernel.org/r/20201027124834.GL2628@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1102849..b71ad8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4396,6 +4396,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	if (unlikely(hlock_class(this)->usage_mask & new_mask))
 		goto unlock;
 
+	if (!hlock_class(this)->usage_mask)
+		debug_atomic_dec(nr_unused_locks);
+
 	hlock_class(this)->usage_mask |= new_mask;
 
 	if (new_bit < LOCK_TRACE_STATES) {
@@ -4403,19 +4406,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			return 0;
 	}
 
-	switch (new_bit) {
-	case 0 ... LOCK_USED-1:
+	if (new_bit < LOCK_USED) {
 		ret = mark_lock_irq(curr, this, new_bit);
 		if (!ret)
 			return 0;
-		break;
-
-	case LOCK_USED:
-		debug_atomic_dec(nr_unused_locks);
-		break;
-
-	default:
-		break;
 	}
 
 unlock:
