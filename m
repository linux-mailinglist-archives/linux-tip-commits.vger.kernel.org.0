Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E263EF34C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhHQUOx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhHQUOr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B9C0612E7;
        Tue, 17 Aug 2021 13:14:13 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfgG4+VmBJ1N3HLhAgV8Av1Xp3A2WuRjii+BxlxflMg=;
        b=2+il9VTXPw6GZrCyIoabM++018VGsvDbprwKi5Pfk/Z1tB/p9o4P2CnI+lezwyk8Os9m3I
        Rvt+ePW3UB98j+I+W/SzT1NdHwUgaJqyXqZbjGyOmjij3zk7P1mkPUBmv9ZLoqGUSdH3Wl
        XB5WC3YNP6yZiv71ZLVnc3YXa4IduK5e2YeO8W3R0hzdEmxSmVzjSzhsqeGjb4SU49EzV6
        TstfV/GchHD/UIwgzLyIOF2BdosiQu3IH70XGf7fbgHyk5OKHPtexdzZEBaDNfPM01Idhu
        JyYjavMN1nO0TUcBJwiUz1MVCJ7gdDraKUSgWP3vj75plpWILwxKo8EBqFmybw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfgG4+VmBJ1N3HLhAgV8Av1Xp3A2WuRjii+BxlxflMg=;
        b=2a70Fd16oSsLUUOzDNjsEHeQ7p5GUCiiWw0a9fFvfGIHZWkeg0r+oWaBX/iu60St0npdic
        dIKqJ14a8nooS9Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Abstract out mutex accessors
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.622477030@linutronix.de>
References: <20210815211304.622477030@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125110.25758.3399929616125299500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9934ccc75cec2bafac552c2130835630530c4f7e
Gitweb:        https://git.kernel.org/tip/9934ccc75cec2bafac552c2130835630530c4f7e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:57 +02:00

locking/ww_mutex: Abstract out mutex accessors

Move the mutex related access from various ww_mutex functions into helper
functions so they can be substituted for rtmutex based ww_mutex later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.622477030@linutronix.de
---
 kernel/locking/ww_mutex.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index f5aaf2f..842dbed 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -53,6 +53,18 @@ __ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mutex_wa
 	__mutex_add_waiter(lock, waiter, p);
 }
 
+static inline struct task_struct *
+__ww_mutex_owner(struct mutex *lock)
+{
+	return __mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct mutex *lock)
+{
+	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -157,7 +169,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
-	struct task_struct *owner = __mutex_owner(lock);
+	struct task_struct *owner = __ww_mutex_owner(lock);
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -253,7 +265,7 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
 	 * and/or !empty list.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(!__ww_mutex_has_waiters(&lock->base)))
 		return;
 
 	/*
