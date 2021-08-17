Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429F3EF34E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhHQUOz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhHQUOs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4EC061292;
        Tue, 17 Aug 2021 13:14:13 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcW7j4+t/jeuFZItOQhm/zjv0AnencikBxTBbaAXZCM=;
        b=qnUzFFIm7wUmr8LtaGQmE3JoBjT7DXF6kavl77vl5kmUolSCX8ZnQC0lIrjP5Lwo3QwbBD
        6ThW/FVYzBtL580FccXo5BKcFslr1xlWGk8PLNLpfBHQEAG+Yodi+DUEsjZPfMJ5BL0qZA
        rZ0+JL3OIgD8CIt93asqP9yGfs4MarGyi4z/ApbYDNPnpuFUKcxrFdExXJSuz2FdoFayfj
        rF4zZCkVG5hZSmwBA+2A244K2KqIIfQPqzRYZST+FfBmz5vQNbGo4CLZTuL2ZwYPKU4hXV
        iAQwfsxIa+omqeIqCEgd0BPbBSew3Sv57NslIyLOUK+tzCFZ5PpWr1kOY3/z/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcW7j4+t/jeuFZItOQhm/zjv0AnencikBxTBbaAXZCM=;
        b=CxZ7+nIoYjhYKZJrUwWJkBK+cijmY42GjnWLuRnIrkqy2cVvc3ONl7pWYjG0PC4f8KJF3F
        F+UxhpBP6PVdaOAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Abstract out waiter enqueueing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.566318143@linutronix.de>
References: <20210815211304.566318143@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125167.25758.9665327938530667311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     843dac28f90ef80535b0aee0b78446f1770c8611
Gitweb:        https://git.kernel.org/tip/843dac28f90ef80535b0aee0b78446f1770c8611
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:54 +02:00

locking/ww_mutex: Abstract out waiter enqueueing

The upcoming rtmutex based ww_mutex needs a different handling for
enqueueing a waiter. Split it out into a helper function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.566318143@linutronix.de
---
 kernel/locking/ww_mutex.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 1cd178c..f5aaf2f 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -44,6 +44,15 @@ __ww_waiter_last(struct mutex *lock)
 	return w;
 }
 
+static inline void
+__ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mutex_waiter *pos)
+{
+	struct list_head *p = &lock->wait_list;
+	if (pos)
+		p = &pos->list;
+	__mutex_add_waiter(lock, waiter, p);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -337,12 +346,11 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		      struct mutex *lock,
 		      struct ww_acquire_ctx *ww_ctx)
 {
-	struct mutex_waiter *cur;
-	struct list_head *pos;
+	struct mutex_waiter *cur, *pos = NULL;
 	bool is_wait_die;
 
 	if (!ww_ctx) {
-		__mutex_add_waiter(lock, waiter, &lock->wait_list);
+		__ww_waiter_add(lock, waiter, NULL);
 		return 0;
 	}
 
@@ -355,7 +363,6 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 	 * never die here, but they are sorted in stamp order and
 	 * may wound the lock holder.
 	 */
-	pos = &lock->wait_list;
 	for (cur = __ww_waiter_last(lock); cur;
 	     cur = __ww_waiter_prev(lock, cur)) {
 
@@ -378,13 +385,13 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 			break;
 		}
 
-		pos = &cur->list;
+		pos = cur;
 
 		/* Wait-Die: ensure younger waiters die. */
 		__ww_mutex_die(lock, cur, ww_ctx);
 	}
 
-	__mutex_add_waiter(lock, waiter, pos);
+	__ww_waiter_add(lock, waiter, pos);
 
 	/*
 	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
