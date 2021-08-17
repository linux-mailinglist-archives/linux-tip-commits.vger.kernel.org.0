Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD403EF376
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhHQUPo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhHQUPN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:13 -0400
Date:   Tue, 17 Aug 2021 20:14:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyaC0ELzjDolOXin8HG96xJxwbMj/zJPehDTGDcCo/0=;
        b=SAxROBe6bVzVmaEuCqbSgt04f9BcvoVnQYbSHsOoKRyxOP/pyf1R2LfHelKy+eQNYjtX3i
        eI8Xi4CCDEoCuGYXkTt95KqHFazSJgbXiuqzduxe9VheZBFdDo6/b2R4JH0nU03DmQHkJ2
        TAeSPwI9u9pt+YBsbt0m8H5jtBH52Mx9x4++g3wPldvvxFIsd1NY9g4UWLqiii2jGDlxpi
        j+G1R2dThyH+f48lTv2piuxNiyAB5/H5A4TKl/qsYxxkzP7gY0/Q7YKsPbxXcrFkPUyk3J
        sD9jVTVre51tQwQ4hMzLQ8NZZ8Pptwn2yLRQ6D7a8QFpfBS6zkqzL9RzQh5udw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyaC0ELzjDolOXin8HG96xJxwbMj/zJPehDTGDcCo/0=;
        b=PQc75JiUrLh985FZPazFfXXW7ES6bnFmvUYamq9rOaJAI84pshUd+Ar1VHTby59nQy+4DX
        xhNsjSKMV9gNmYCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Add missing owner initialization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211301.969975279@linutronix.de>
References: <20210815211301.969975279@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127819.25758.13622427291765387358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d8bbd97ad0b99a9394f2cd8410b884c48e218cf0
Gitweb:        https://git.kernel.org/tip/d8bbd97ad0b99a9394f2cd8410b884c48e218cf0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:38:40 +02:00

locking/local_lock: Add missing owner initialization

If CONFIG_DEBUG_LOCK_ALLOC=y is enabled then local_lock_t has an 'owner'
member which is checked for consistency, but nothing initialized it to
zero explicitly.

The static initializer does so implicit, and the run time allocated per CPU
storage is usually zero initialized as well, but relying on that is not
really good practice.

Fixes: 91710728d172 ("locking: Introduce local_lock()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211301.969975279@linutronix.de
---
 include/linux/local_lock_internal.h | 42 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index ded90b0..3f02b81 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -14,29 +14,14 @@ typedef struct {
 } local_lock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LL_DEP_MAP_INIT(lockname)			\
+# define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
-		.lock_type = LD_LOCK_PERCPU,			\
-	}
-#else
-# define LL_DEP_MAP_INIT(lockname)
-#endif
-
-#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
-
-#define __local_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
-			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
-			      LD_LOCK_PERCPU);			\
-} while (0)
+		.lock_type = LD_LOCK_PERCPU,		\
+	},						\
+	.owner = NULL,
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -51,11 +36,30 @@ static inline void local_lock_release(local_lock_t *l)
 	lock_map_release(&l->dep_map);
 }
 
+static inline void local_lock_debug_init(local_lock_t *l)
+{
+	l->owner = NULL;
+}
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
+# define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
+#define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+
+#define __local_lock_init(lock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
