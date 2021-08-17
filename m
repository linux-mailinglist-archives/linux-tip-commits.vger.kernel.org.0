Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993D83EF352
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhHQUO5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhHQUOt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:49 -0400
Date:   Tue, 17 Aug 2021 20:14:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFS5xKuy5v83mccvh1sMhscAwSor0LI7FNNEJeOmWAk=;
        b=rMDRnOi7Bpalt2uDH8lDPPr8RV5M89w2HzM3gecv6q+n/aC0m8WX/23fz8stHXFwS8E074
        5pGWKADiftoSC9gtae0v2laoJOS1yM2GfghzJXHCo2wYC7QGNzSTAYNYfyMlUVX9BMpyqY
        /+WZVkstep78OWMX1lfuHsxTXGjjmOGVfdunWDtkDbLqFea0Lipt6HDBttu7Gw+jb7mFAP
        PGjk4feNoOAhCzzoOSC8tlWRAutZy7ASWEQbi0HSVOhWnrpWp+C1zT+K3HBI2BkqQK/36d
        8wwI66cTMgw73AjnhnMKLBujnXG+TaLJuah2uLJoR6aQy46yCQueJPlC9Zd2Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFS5xKuy5v83mccvh1sMhscAwSor0LI7FNNEJeOmWAk=;
        b=tEvuqy4y26BuXtyx1sWi8qZrZBuggUJSyf5qQBT4rZXksdaY85x2XzwCObMAsozydT/B2j
        JiuJxs44JLuKCLDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Gather mutex_waiter initialization
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.281927514@linutronix.de>
References: <20210815211304.281927514@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125462.25758.4913735794085506953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c0afb0ffc06e6b4e492a3b711f1fb32074f9949c
Gitweb:        https://git.kernel.org/tip/c0afb0ffc06e6b4e492a3b711f1fb32074f9949c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:04:41 +02:00

locking/ww_mutex: Gather mutex_waiter initialization

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.281927514@linutronix.de
---
 kernel/locking/mutex-debug.c |  1 +
 kernel/locking/mutex.c       | 12 +++---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 7ef5a36..bc8abb8 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -30,6 +30,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
+	waiter->ww_ctx = MUTEX_POISON_WW_CTX;
 }
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 73ad862..6cb27c5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -982,17 +982,15 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	debug_mutex_lock_common(lock, &waiter);
+	waiter.task = current;
+	if (ww_ctx)
+		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
 
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
-
-
-#ifdef CONFIG_DEBUG_MUTEXES
-		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
-#endif
 	} else {
 		/*
 		 * Add in stamp order, waking up waiters that must kill
@@ -1001,12 +999,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
-
-		waiter.ww_ctx = ww_ctx;
 	}
 
-	waiter.task = current;
-
 	set_current_state(state);
 	for (;;) {
 		bool first;
