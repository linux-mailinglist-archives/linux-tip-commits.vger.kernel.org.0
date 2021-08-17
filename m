Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A753EF3B2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhHQUR3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbhHQUQT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F848C06114A;
        Tue, 17 Aug 2021 13:14:40 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TZukvdfUKJdIJWfAb0k38O7O5rKWLBgrZRWrtQiJQ0=;
        b=mM/hAI3J7CDKdPmu93pLoj0T9pw5m2YH3ra9XuxD9ST35oRvZGeoqcsv97NIlKAPpp8BrP
        AFSdIunbYEZ6AfWCDXVhYNKvMXldYCgNXK2MvGvnrEFLZ36+CMgU6gIdgqkH1mx3jCbobs
        MYN22fNKE28qj6/WxcLHkMau8Rz4qXv68MrvGb0D6u0rwldJKCjydmRH40sXCqOjFl/Q6Y
        wTi/Krhw15Sy7hsEFsVkKkAe+9bQbpint+i10u0nxQrW3PcaTaId8MFCtMceBAXfkdcSvc
        OijDb6JHxCmDPqJdim5/9VXrNZrUCuBECFnlbDudHmxkVUShit9lkZXmJ8+/fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TZukvdfUKJdIJWfAb0k38O7O5rKWLBgrZRWrtQiJQ0=;
        b=OdA9wYocOPxf+oSY34xe8oBYL1OoQXeaWdgyhyFO25QcBXmhwiCqv1kXOg28bPB5M7svRd
        HgYUGx13DNZemxBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Set proper wait context for lockdep
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.031014562@linutronix.de>
References: <20210815211302.031014562@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127764.25758.12948277329755565854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b41cda03765580caf7723b8c1b672d191c71013f
Gitweb:        https://git.kernel.org/tip/b41cda03765580caf7723b8c1b672d191c71013f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:38:50 +02:00

locking/rtmutex: Set proper wait context for lockdep

RT mutexes belong to the LD_WAIT_SLEEP class. Make them so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.031014562@linutronix.de
---
 include/linux/rtmutex.h  | 19 ++++++++++++-------
 kernel/locking/rtmutex.c |  2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index d1672de..87b325a 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -52,17 +52,22 @@ do { \
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
-	, .dep_map = { .name = #mutexname }
+#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
+	.dep_map = {					\
+		.name = #mutexname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
 
-#define __RT_MUTEX_INITIALIZER(mutexname) \
-	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
-	, .waiters = RB_ROOT_CACHED \
-	, .owner = NULL \
-	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
+#define __RT_MUTEX_INITIALIZER(mutexname)				\
+{									\
+	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock),	\
+	.waiters = RB_ROOT_CACHED,					\
+	.owner = NULL,							\
+	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
+}
 
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ad0db32..1a7e3f8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1556,7 +1556,7 @@ void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
 
 	__rt_mutex_basic_init(lock);
 }
