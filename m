Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D973EF328
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHQUOc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhHQUOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:32 -0400
Date:   Tue, 17 Aug 2021 20:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhI5hzUYYWilCb9SZRu0oFevXaNxr+x9CY/UOW0MxyY=;
        b=xL5XFcFyQq0ITjfiIPK9J5cIy93c1vk6BNG82pCzdXO0lJvyBODw60w3JYnG1Vm5V291UA
        XesbSmAcL5u9jF5qmUQtJhsX355+mtI43Gs47mWakJN4bU64QP7BmRGVLpFRAmw8LVea1d
        hwB2tdyq/N+YzR6PcUDxbNfLANH9us8JKMWCRsyalex+URCdTEWRv69c3Tp5yNEfqbAGFx
        6T/0NLf6lY1fy5TRLVbFER1XOdtasm3ON1iCTKVq3k1bWItJ1SoSo9T7dcaNmj3QLv450J
        i8P1+FAevL60hEZ6OBp0lPLgRfJoEZwHkPJpA61MIc+HXAXxeIizq5bTLdkIZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhI5hzUYYWilCb9SZRu0oFevXaNxr+x9CY/UOW0MxyY=;
        b=91CJm+2+QYOt6cxXmcrqkuD9Q5pm5hr24VXaEbR9tf8M88NBG/1nP3OIOboku2o0j9qWMY
        nlvmVeaHAcJBXoCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock/rt: Prepare for RT local_lock
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.967526724@linutronix.de>
References: <20210815211305.967526724@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123702.25758.3164311298979686916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     31552385f8e9d0869117014bf8e55ba0497e3ec8
Gitweb:        https://git.kernel.org/tip/31552385f8e9d0869117014bf8e55ba0497e3ec8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:06:13 +02:00

locking/spinlock/rt: Prepare for RT local_lock

Add the static and runtime initializer mechanics to support the RT variant
of local_lock, which requires the lock type in the lockdep map to be set
to LD_LOCK_PERCPU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.967526724@linutronix.de
---
 include/linux/spinlock_rt.h        | 24 ++++++++++++++++--------
 include/linux/spinlock_types.h     |  6 ++++++
 include/linux/spinlock_types_raw.h |  8 ++++++++
 kernel/locking/spinlock_rt.c       |  7 +++++--
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 4fc7219..835aeda 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -8,20 +8,28 @@
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				struct lock_class_key *key);
+				struct lock_class_key *key, bool percpu);
 #else
 static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-				       struct lock_class_key *key)
+				struct lock_class_key *key, bool percpu)
 {
 }
 #endif
 
-#define spin_lock_init(slock)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_base_init(&(slock)->lock);		\
-	__rt_spin_lock_init(slock, #slock, &__key);	\
+#define spin_lock_init(slock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+} while (0)
+
+#define local_spin_lock_init(slock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
 
 extern void rt_spin_lock(spinlock_t *lock);
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 8a9aadb..2dfa35f 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -60,6 +60,12 @@ typedef struct spinlock {
 		SPIN_DEP_MAP_INIT(name)				\
 	}
 
+#define __LOCAL_SPIN_LOCK_UNLOCKED(name)			\
+	{							\
+		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		LOCAL_SPIN_DEP_MAP_INIT(name)			\
+	}
+
 #define DEFINE_SPINLOCK(name)					\
 	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
 
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index a8a4330..91cb36b 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -37,9 +37,17 @@ typedef struct raw_spinlock {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 	}
+
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.lock_type = LD_LOCK_PERCPU,		\
+	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
 # define SPIN_DEP_MAP_INIT(lockname)
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index c36648b..d2912e4 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -120,10 +120,13 @@ EXPORT_SYMBOL(rt_spin_trylock_bh);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __rt_spin_lock_init(spinlock_t *lock, const char *name,
-			 struct lock_class_key *key)
+			 struct lock_class_key *key, bool percpu)
 {
+	u8 type = percpu ? LD_LOCK_PERCPU : LD_LOCK_NORMAL;
+
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+	lockdep_init_map_type(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG,
+			      LD_WAIT_INV, type);
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 #endif
