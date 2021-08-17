Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0984F3EF37E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhHQUPz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhHQUPW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AAC06122E;
        Tue, 17 Aug 2021 13:14:26 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gANacfchpJpfkqIg5PyeiZEsrTUzpFN6VZQphJv1350=;
        b=J8Hf5PMGu1FXlsEkqQHuyMxjoqaYmj4/7LBJxKO9OTfM8AvS/F6wv/Yk9gg4dUTk19eSXV
        3gU0dUDZQ5j1DKFxc4ZrZnF+8PKmynzez1Jl1AumzYkmfu2Wi2JzFAw5gg7pZNR0Yz/GPX
        zyAG4/zi6bd7jUW704BFg8SHUz3JmnLAToMh87yiduR9ycnFer+nyc+nA8qm2L6ZfhsijS
        eHoMFYGPXnK6j7tNEGIsRJwywzPgNQG/Fa/RFxiz2qG90zsDeTYrDaAo2ivkakPT+2H7We
        oCiOHDauNJwGkWWNQJtbb/YGx1GTDYD36i0LEAdloWEC3uwawh2CUgWuh7QcJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gANacfchpJpfkqIg5PyeiZEsrTUzpFN6VZQphJv1350=;
        b=covK2vUfaFvOe34Esgy+s+OFXq4pej2yVFiOOYnjcl3zoilFFse3fwYO++eHuAuhK7XOL/
        lYfiPtKHYz/ceTDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock: Split the lock types header,
 and move the raw types into <linux/spinlock_types_raw.h>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.371269088@linutronix.de>
References: <20210815211303.371269088@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126413.25758.447251507070242546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4f084ca74c3f0eb321ab50e69afd27c8fcb96a99
Gitweb:        https://git.kernel.org/tip/4f084ca74c3f0eb321ab50e69afd27c8fcb96a99
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:26:27 +02:00

locking/spinlock: Split the lock types header, and move the raw types into <linux/spinlock_types_raw.h>

Move raw_spinlock into its own file. Prepare for RT 'sleeping spinlocks', to
avoid header recursion, as RT locks require rtmutex.h, which in turn requires
the raw spinlock types.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.371269088@linutronix.de
---
 include/linux/rwlock_types.h       |  4 ++-
 include/linux/spinlock.h           |  4 ++-
 include/linux/spinlock_types.h     | 59 +--------------------------
 include/linux/spinlock_types_raw.h | 65 +++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/spinlock_types_raw.h

diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3bd03e1..0ad226b 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -1,6 +1,10 @@
 #ifndef __LINUX_RWLOCK_TYPES_H
 #define __LINUX_RWLOCK_TYPES_H
 
+#if !defined(__LINUX_SPINLOCK_TYPES_H)
+# error "Do not include directly, include spinlock_types.h"
+#endif
+
 /*
  * include/linux/rwlock_types.h - generic rwlock type definitions
  *				  and initializers
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 7989784..5803b56 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -12,6 +12,8 @@
  *  asm/spinlock_types.h: contains the arch_spinlock_t/arch_rwlock_t and the
  *                        initializers
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
@@ -31,6 +33,8 @@
  *                        contains the generic, simplified UP spinlock type.
  *                        (which is an empty structure on non-debug builds)
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw RT types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index b981caa..42be111 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -9,64 +9,7 @@
  * Released under the General Public License (GPL).
  */
 
-#if defined(CONFIG_SMP)
-# include <asm/spinlock_types.h>
-#else
-# include <linux/spinlock_types_up.h>
-#endif
-
-#include <linux/lockdep_types.h>
-
-typedef struct raw_spinlock {
-	arch_spinlock_t raw_lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_cpu;
-	void *owner;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} raw_spinlock_t;
-
-#define SPINLOCK_MAGIC		0xdead4ead
-
-#define SPINLOCK_OWNER_INIT	((void *)-1L)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SPIN,	\
-	}
-# define SPIN_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_CONFIG,	\
-	}
-#else
-# define RAW_SPIN_DEP_MAP_INIT(lockname)
-# define SPIN_DEP_MAP_INIT(lockname)
-#endif
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-# define SPIN_DEBUG_INIT(lockname)		\
-	.magic = SPINLOCK_MAGIC,		\
-	.owner_cpu = -1,			\
-	.owner = SPINLOCK_OWNER_INIT,
-#else
-# define SPIN_DEBUG_INIT(lockname)
-#endif
-
-#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
-	{					\
-	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
-	SPIN_DEBUG_INIT(lockname)		\
-	RAW_SPIN_DEP_MAP_INIT(lockname) }
-
-#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
-
-#define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
+#include <linux/spinlock_types_raw.h>
 
 typedef struct spinlock {
 	union {
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
new file mode 100644
index 0000000..a8a4330
--- /dev/null
+++ b/include/linux/spinlock_types_raw.h
@@ -0,0 +1,65 @@
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
+#define __LINUX_SPINLOCK_TYPES_RAW_H
+
+#include <linux/types.h>
+
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
+#else
+# include <linux/spinlock_types_up.h>
+#endif
+
+#include <linux/lockdep_types.h>
+
+typedef struct raw_spinlock {
+	arch_spinlock_t raw_lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} raw_spinlock_t;
+
+#define SPINLOCK_MAGIC		0xdead4ead
+
+#define SPINLOCK_OWNER_INIT	((void *)-1L)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SPIN,	\
+	}
+# define SPIN_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+	}
+#else
+# define RAW_SPIN_DEP_MAP_INIT(lockname)
+# define SPIN_DEP_MAP_INIT(lockname)
+#endif
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define SPIN_DEBUG_INIT(lockname)		\
+	.magic = SPINLOCK_MAGIC,		\
+	.owner_cpu = -1,			\
+	.owner = SPINLOCK_OWNER_INIT,
+#else
+# define SPIN_DEBUG_INIT(lockname)
+#endif
+
+#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
+{						\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	RAW_SPIN_DEP_MAP_INIT(lockname) }
+
+#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
+
+#define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
+
+#endif /* __LINUX_SPINLOCK_TYPES_RAW_H */
