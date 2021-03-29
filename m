Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258D934D4EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhC2QYg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhC2QYM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:12 -0400
Date:   Mon, 29 Mar 2021 16:24:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wtdky9YWT00d1UJqcfKQNVSkSmxUBpG7ily5elNxug4=;
        b=baBuMMIW0aYMw56IfLarMfEKfJF759iF034/VvAGZflYRc9hK1D8NOFnadpnN/UwzCSyhb
        s4YlTl0G6/j4x+7EtuGE1T8yQZ93jzdztCazqsbvbVczsSmN6EW5H+JhLIUyx2Aj+4r42K
        jnlfjNPxCrt73AGOozXA2vwbSRudP/HIK1JRZOzm/3qIROpHfVCzCzsqAGsbPXYZIgVqms
        2JKcxUwT1GSwy7k/dRvKutZElyjW3AwybV7Nktm/lGk752U6XTkVL0q8ZBsQNXDZ/JCgG8
        I6oyuqRIGiXEQblO0M1rK41z7s54kDZOCBhjSGDxQTME+PNlWGyGwS4hwxtnsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wtdky9YWT00d1UJqcfKQNVSkSmxUBpG7ily5elNxug4=;
        b=wGjYrsAfob1Jv7doxW4bqwYQGQJ+r8qVk43XUN8R90NxRNXZN/EhtXY0x2ShZ+dv4rK2W+
        1AL66d8vVTTiBpCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Move rt_mutex_debug_task_free()
 to rtmutex.c
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.646359691@linutronix.de>
References: <20210326153943.646359691@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505060.29796.3186035994822030508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fae37feee096bd3c85f6453713131a471404c6f5
Gitweb:        https://git.kernel.org/tip/fae37feee096bd3c85f6453713131a471404c6f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:03 +02:00

locking/rtmutex: Move rt_mutex_debug_task_free() to rtmutex.c

Prepare for removing the header maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.646359691@linutronix.de
---
 kernel/locking/rtmutex-debug.c | 6 ------
 kernel/locking/rtmutex.c       | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index df584c9..f1a83ec 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,12 +32,6 @@
 
 #include "rtmutex_common.h"
 
-void rt_mutex_debug_task_free(struct task_struct *task)
-{
-	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
-	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 96c7c53..8a934db 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1813,3 +1813,11 @@ bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 
 	return cleanup;
 }
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+void rt_mutex_debug_task_free(struct task_struct *task)
+{
+	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
+	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
+}
+#endif
