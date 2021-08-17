Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396653EF348
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhHQUOv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhHQUOr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:47 -0400
Date:   Tue, 17 Aug 2021 20:14:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlbyU7oabq6QJaRyxWtsQ1W+xWAp4FZ/8F43UowZAdI=;
        b=gUKcWKsDuXm9JKUxGWo6QBmGGLKgTweOAoE9NKy+PPfUviDlamRqW+hgN2TcrzREKsdXrf
        C9JYSvBx/2cjUt54R6julJ+navMmnRqQaM+MN06A/ujjH+OKgR5vx/CchNPFn4uiVFXuVM
        WoDs7E3HX54tCreNX760RYHfCvMBIRZSGyvZjLP6JSk1Y7/YhkYsf4mgry6Cz/t6aFQl9P
        2p5An/pS1rfIw2cEhcxSaLbO3K4t6rY5rT0QUzRV7o1SV5NOINM9mth/xpw7rhNYBUDz83
        Ryb9hUG8zHgme5ddeA/SWzp6T3MDeE8F8nhEmJUQ5Hh9vamTAJPMUkINdmVYSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlbyU7oabq6QJaRyxWtsQ1W+xWAp4FZ/8F43UowZAdI=;
        b=X0PUlP+SAdcrFVWQTtaeA5nUlk9ScSXU3P/3nVIpw0h8gEYLkrukmdXs8ibUSxTJg3W4Yy
        WzCDb+G1/9LxtyDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Abstract out the waiter iteration
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.509186185@linutronix.de>
References: <20210815211304.509186185@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125223.25758.10344291090591811028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     23d599eb2377404100d0d1508e12b0a2c40b49b1
Gitweb:        https://git.kernel.org/tip/23d599eb2377404100d0d1508e12b0a2c40b49b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:52 +02:00

locking/ww_mutex: Abstract out the waiter iteration

Split out the waiter iteration functions so they can be substituted for a
rtmutex based ww_mutex later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.509186185@linutronix.de
---
 kernel/locking/ww_mutex.h | 57 +++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 6a98f3b..1cd178c 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -1,5 +1,49 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+static inline struct mutex_waiter *
+__ww_waiter_first(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w = list_first_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
+{
+	w = list_next_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
+{
+	w = list_prev_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_last(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w = list_last_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -161,7 +205,9 @@ __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 	lockdep_assert_held(&lock->wait_lock);
 
-	list_for_each_entry(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_first(lock); cur;
+	     cur = __ww_waiter_next(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 
@@ -263,8 +309,9 @@ __ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
 	 * If there is a waiter in front of us that has a context, then its
 	 * stamp is earlier than ours and we must kill ourself.
 	 */
-	cur = waiter;
-	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_prev(lock, waiter); cur;
+	     cur = __ww_waiter_prev(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 
@@ -309,7 +356,9 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 	 * may wound the lock holder.
 	 */
 	pos = &lock->wait_list;
-	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
+	for (cur = __ww_waiter_last(lock); cur;
+	     cur = __ww_waiter_prev(lock, cur)) {
+
 		if (!cur->ww_ctx)
 			continue;
 
