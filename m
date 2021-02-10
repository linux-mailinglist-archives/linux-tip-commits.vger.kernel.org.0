Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2659F316890
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBJOAQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhBJOAI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72735C061786;
        Wed, 10 Feb 2021 05:59:27 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0cg01lr5Z/ry2eaEssMwlpyzdMtjO1YiiTnj0Gz8Gk=;
        b=V8QXEaCzIoEdRrFkwd5vPUIQky96KKDdwjbDqzl3hnFGy1cQZD8gbTuScOIDfhdEfpY983
        29yCH057g59FrzUmZKl+BMlxsz0rk/EA/R2M9uqeUi1gMMjHrI62CLnT7Z3JHATgRbgZuL
        f1NnDGbtubbdqM+DdlVvaO8ZlXIgzwOGV2GudN2T4I0py+id5ZMOGJe+WWZJS+Ej0r7P94
        1jpdTxCYLiCLARLdWE9/NFSVRhcm0Z612aUchPdtgDfvfApt+dyYLJExmgUU11aRSIqIDF
        3k42uu5Wp9r1bsKkcIAQjjaiH4iQBrji7rNOAEevXh8gm7RZars8Z+8qDtUd5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0cg01lr5Z/ry2eaEssMwlpyzdMtjO1YiiTnj0Gz8Gk=;
        b=fsWCsWVQNoOKrHE0FEFtP3ZshIi/CKgPfR0YrE8xoPs2c8s5SLykoS+RSQKVKyEq0+oCE3
        mz53rnxnFvaTbzBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Kill mutex_trylock_recursive()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210085248.219210-2-bigeasy@linutronix.de>
References: <20210210085248.219210-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <161296556531.23325.10473355259841906876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f319d49a4167e402b01b2b56639386f0b6846ba
Gitweb:        https://git.kernel.org/tip/0f319d49a4167e402b01b2b56639386f0b6846ba
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 09:52:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:40 +01:00

locking/mutex: Kill mutex_trylock_recursive()

There are not users of mutex_trylock_recursive() in tree as of
v5.11-rc7.

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210210085248.219210-2-bigeasy@linutronix.de
---
 include/linux/mutex.h  | 25 -------------------------
 kernel/locking/mutex.c | 10 ----------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd185c..0cd631a 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -199,29 +199,4 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-/*
- * These values are chosen such that FAIL and SUCCESS match the
- * values of the regular mutex_trylock().
- */
-enum mutex_trylock_recursive_enum {
-	MUTEX_TRYLOCK_FAILED    = 0,
-	MUTEX_TRYLOCK_SUCCESS   = 1,
-	MUTEX_TRYLOCK_RECURSIVE,
-};
-
-/**
- * mutex_trylock_recursive - trylock variant that allows recursive locking
- * @lock: mutex to be locked
- *
- * This function should not be used, _ever_. It is purely for hysterical GEM
- * raisins, and once those are gone this will be removed.
- *
- * Returns:
- *  - MUTEX_TRYLOCK_FAILED    - trylock failed,
- *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
- *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
- */
-extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock);
-
 #endif /* __LINUX_MUTEX_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce5..adb9350 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -86,16 +86,6 @@ bool mutex_is_locked(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_is_locked);
 
-__must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock)
-{
-	if (unlikely(__mutex_owner(lock) == current))
-		return MUTEX_TRYLOCK_RECURSIVE;
-
-	return mutex_trylock(lock);
-}
-EXPORT_SYMBOL(mutex_trylock_recursive);
-
 static inline unsigned long __owner_flags(unsigned long owner)
 {
 	return owner & MUTEX_FLAGS;
