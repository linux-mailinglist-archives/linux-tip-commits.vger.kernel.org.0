Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD23EF34D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHQUOy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhHQUOs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ABFC0613CF;
        Tue, 17 Aug 2021 13:14:14 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE4W23T6mWscYRtU3/FmEp7SMp9/IFzh8pjxHPo8rRE=;
        b=TYpH3kyLVmIV4gGBc7Y8OYlSwZxQNUgrLKlhrxII7IJ9EUH5uoF6Yvp+gSQnWOmzik3Gd9
        MSY0vlCAD9bBP1jTK5Sx9jEl8cpUEIwMjXYTks1owEpaXVxcrqzORNQk8uOJ9ZuHPPbmke
        7gBkAX31KYBXC41ubFZjGfvsDgR0VjC5pfBcAxon5EJmB5OzS5HP6rtMJjOCLOXuiDpq8C
        xxisqyUTBO1svFvO3mG/pbYvU7uaSM0x3pohdkSeWLnUxDdVHjfR4e/Zqk86xJ3ljYxZwk
        oN/K7lR9he/Hq4kFlRNJTea+d4txUODgI8kBDr+kkgvcM7a77KD9hBVD5Wv8Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE4W23T6mWscYRtU3/FmEp7SMp9/IFzh8pjxHPo8rRE=;
        b=+VRr25RMsyG0yl4DefCJz7Sb9O70lr1P6ijX3fXDE8vGagBLGBtUs0mWjneqmxPIMOmZ1G
        qqGxOCXUUKLLFDBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Remove the __sched annotation
 from ww_mutex APIs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.453235952@linutronix.de>
References: <20210815211304.453235952@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125280.25758.9542137274889127981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5297ccb2c50916c59294a63fae79fe01a7fbb79a
Gitweb:        https://git.kernel.org/tip/5297ccb2c50916c59294a63fae79fe01a7fbb79a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:49 +02:00

locking/ww_mutex: Remove the __sched annotation from ww_mutex APIs

None of these functions will be on the stack when blocking in
schedule(), hence __sched is not needed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.453235952@linutronix.de
---
 kernel/locking/ww_mutex.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index dadc798..6a98f3b 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -62,7 +62,7 @@ ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
  * transaction than @b and depending on algorithm either needs to wait for
  * @b or die.
  */
-static inline bool __sched
+static inline bool
 __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 {
 
@@ -77,7 +77,7 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
  * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
  * __ww_mutex_check_kill() wake any but the earliest context.
  */
-static bool __sched
+static bool
 __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
@@ -154,7 +154,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
  *
  * The current task must not be on the wait list.
  */
-static void __sched
+static void
 __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
@@ -210,7 +210,7 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	raw_spin_unlock(&lock->base.wait_lock);
 }
 
-static __always_inline int __sched
+static __always_inline int
 __ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
@@ -238,7 +238,7 @@ __ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
  * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
  * look at waiters before us in the wait-list.
  */
-static inline int __sched
+static inline int
 __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
 		      struct ww_acquire_ctx *ctx)
 {
@@ -285,7 +285,7 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
  * older contexts already waiting) to avoid unnecessary waiting and for
  * Wound-Wait ensure we wound the owning context when it is younger.
  */
-static inline int __sched
+static inline int
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		      struct mutex *lock,
 		      struct ww_acquire_ctx *ww_ctx)
