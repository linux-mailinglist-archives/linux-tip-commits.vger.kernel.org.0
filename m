Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C43EF358
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhHQUPR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhHQUOw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:52 -0400
Date:   Tue, 17 Aug 2021 20:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98NzfdBEFkMYL6vJXSqNA5Ma/WhM3yeGmyBdrpXIAU=;
        b=K40hlnBAjPcAyT8qz8CdqEYjP3Ug/AsXzlZB9elwo/laowt6WxGo1RjunPAgmU1bIum/kJ
        yHsHkJ+emlsy1YK95RwTT+5hgeeEeWnj+fajqYCYQclmEQ8db6lJrVKSjwIxK5OO+JbkTY
        0a/hAT016Z5CUVnqf/U9561qQnBDqPrqRfovCieGYeqaP7ULTJHStub6aODCEZrSuv1iy3
        Ye1YH9qeq9WsYt4ncBfIreOVdXkHhltA7blK1ON5py+LaoX3Vyy9ktIphT/2Mm+XgufacJ
        rJi+8mDM/Shnt0eAUce52Tzz277f7ovimTbWgJcYPNiERMwfIngddZzLBYjPhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98NzfdBEFkMYL6vJXSqNA5Ma/WhM3yeGmyBdrpXIAU=;
        b=j+ePZ5zw5GSB9kA5kVOhHncsgN5xwuk+g7JdBreYDg7QlnWvQrEfIGiFgHe3CTjzH5UmQN
        pIdFM5xlV1Cwj3CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Move the 'struct mutex_waiter'
 definition from <linux/mutex.h> to the internal header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.054325923@linutronix.de>
References: <20210815211304.054325923@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125721.25758.6834000266165256181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     43d2d52d704e025518d35c3079fcbff744623166
Gitweb:        https://git.kernel.org/tip/43d2d52d704e025518d35c3079fcbff744623166
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 18:24:31 +02:00

locking/mutex: Move the 'struct mutex_waiter' definition from <linux/mutex.h> to the internal header

Move the mutex waiter declaration from the public <linux/mutex.h> header
to the internal kernel/locking/mutex.h header.

There is no reason to expose it outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.054325923@linutronix.de
---
 include/linux/mutex.h  | 13 -------------
 kernel/locking/mutex.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index e193235..62bafee 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -74,19 +74,6 @@ struct ww_mutex {
 #endif
 };
 
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 586e4f1..0b2a79c 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -7,6 +7,19 @@
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
 
+/*
+ * This is the control structure for tasks blocked on mutex, which resides
+ * on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);
