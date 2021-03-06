Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2587632FA4F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCFLzS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhCFLyg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6046C06174A;
        Sat,  6 Mar 2021 03:54:36 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OuJZwGDwlaW0Wa3IXh411I2JynFFpaznnIhQ2J/Z4Ug=;
        b=SdH/JnQFOkMf4AeP9Zo0Z0S63ErVHjrGueNTk23tRb8jmqrYRSV1e5GzifvYc63FnHqqal
        UmtQEocpDm6chi2bqfvhOh4czX44FQqp2TTDUfVoKmtQ9somMYc0SuGs/Og21AmuKZBTsx
        oct53LKx/QmfiE0CpWWDtbrXVc1tVWFjghDshMHJqETkWAWZO1BL6Ap6tLBJwi4KHAg63C
        5RWw2XdOinOqsz7sTMvxPOGVeHlDj1YUYQVfslwKHFwuIzNUWCRUSU5424sPbyRd1816IO
        iwc9w0TM3X1HkekdjX9dOVN/iKXr+ccXo2EDQ8tbRigfDNqMWcnEh5DaAoyyoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OuJZwGDwlaW0Wa3IXh411I2JynFFpaznnIhQ2J/Z4Ug=;
        b=NiO3BoZCTPzIunYYpGxAxTVDsVaw7AoI1QWpCv/TnB6TcqTfZk2/XfTovd/FfBZ/MDWkzG
        Dh+viO5QUxnODdCg==
From:   "tip-bot2 for Shuah Khan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add lockdep lock state defines
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161503167445.398.647250483272295461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f8cfa46608f8aa5ca5421ce281ab314129c15411
Gitweb:        https://git.kernel.org/tip/f8cfa46608f8aa5ca5421ce281ab314129c15411
Author:        Shuah Khan <skhan@linuxfoundation.org>
AuthorDate:    Fri, 26 Feb 2021 17:06:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:51:10 +01:00

lockdep: Add lockdep lock state defines

Adds defines for lock state returns from lock_is_held_type() based on
Johannes Berg's suggestions as it make it easier to read and maintain
the lock states. These are defines and a enum to avoid changes to
lock_is_held_type() and lockdep_is_held() return types.

Updates to lock_is_held_type() and  __lock_is_held() to use the new
defines.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
---
 include/linux/lockdep.h  | 11 +++++++++--
 kernel/locking/lockdep.c | 11 ++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index dbd9ea8..17805aa 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -268,6 +268,11 @@ extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 extern void lock_release(struct lockdep_map *lock, unsigned long ip);
 
+/* lock_is_held_type() returns */
+#define LOCK_STATE_UNKNOWN	-1
+#define LOCK_STATE_NOT_HELD	0
+#define LOCK_STATE_HELD		1
+
 /*
  * Same "read" as for lock_acquire(), except -1 means any.
  */
@@ -302,11 +307,13 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
 
 #define lockdep_assert_held(l)	do {					\
-		WARN_ON(debug_locks && lockdep_is_held(l) == 0);	\
+		WARN_ON(debug_locks &&					\
+			lockdep_is_held(l) == LOCK_STATE_NOT_HELD);	\
 	} while (0)
 
 #define lockdep_assert_not_held(l)	do {				\
-		WARN_ON(debug_locks && lockdep_is_held(l) == 1);	\
+		WARN_ON(debug_locks &&					\
+			lockdep_is_held(l) == LOCK_STATE_HELD);		\
 	} while (0)
 
 #define lockdep_assert_held_write(l)	do {			\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 969736b..c0b8926 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -54,6 +54,7 @@
 #include <linux/nmi.h>
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
+#include <linux/lockdep.h>
 
 #include <asm/sections.h>
 
@@ -5252,13 +5253,13 @@ int __lock_is_held(const struct lockdep_map *lock, int read)
 
 		if (match_held_lock(hlock, lock)) {
 			if (read == -1 || hlock->read == read)
-				return 1;
+				return LOCK_STATE_HELD;
 
-			return 0;
+			return LOCK_STATE_NOT_HELD;
 		}
 	}
 
-	return 0;
+	return LOCK_STATE_NOT_HELD;
 }
 
 static struct pin_cookie __lock_pin_lock(struct lockdep_map *lock)
@@ -5537,14 +5538,14 @@ EXPORT_SYMBOL_GPL(lock_release);
 noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 {
 	unsigned long flags;
-	int ret = 0;
+	int ret = LOCK_STATE_NOT_HELD;
 
 	/*
 	 * Avoid false negative lockdep_assert_held() and
 	 * lockdep_assert_not_held().
 	 */
 	if (unlikely(!lockdep_enabled()))
-		return -1;
+		return LOCK_STATE_UNKNOWN;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
