Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3368F34D4EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2QYg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhC2QYM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D2C061574;
        Mon, 29 Mar 2021 09:24:12 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91QGa9aA+t4A3Hmyt55maFDF0tm327iD3uehIVMC21g=;
        b=mJNtCCrX41E2Qkr8DFITHOgVrD+bOxSkRkxke0iLaRux0/hOD5sLAzSI1pB6bFmn5sn/Oj
        OIjcHvdk5+JeiETF8VXx4qS5LspvDcKLdpPjiY9yznY6muCUWzfNdltcIc+ZishOVHL6x6
        FihgaI6SmaI+f12y3v0LYATniZNpLWJCHvG5XAahtY5EFbS2P3w8l7taMVG8REQfTrsvg+
        TWLyyif/v4K5GqCHDhA1IwjxQZZnwEMynPPYCuj1eWOjL6TwaLbw7mTEBlN0G43j7Wl0CE
        wkqic6EI5IOXBlXZVT0+M/cs62iow1HvqhL5CDIG3zUEKPhM6VPKBwZ6rUAlkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91QGa9aA+t4A3Hmyt55maFDF0tm327iD3uehIVMC21g=;
        b=I6YwYmr+8rWCObHJ8qohQ9tPakA28sCPNcAY+5352AlqHSK+7woKaYpNXVyQVe68gOPUEB
        8RpU5DqBGHSyNlCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Decrapify __rt_mutex_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.955697588@linutronix.de>
References: <20210326153943.955697588@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703504964.29796.13026490866909569761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f5a98866e506a816f6a855df1e7ed41e1891ec66
Gitweb:        https://git.kernel.org/tip/f5a98866e506a816f6a855df1e7ed41e1891ec66
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:03 +02:00

locking/rtmutex: Decrapify __rt_mutex_init()

The conditional debug handling is just another layer of obfuscation. Split
the function so rt_mutex_init_proxy_locked() can invoke the inner init and
__rt_mutex_init() gets the full treatment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.955697588@linutronix.de
---
 kernel/locking/rtmutex.c        | 10 ++++------
 kernel/locking/rtmutex_common.h |  7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2c77e72..c9c2ab5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1586,12 +1586,10 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
 {
-	lock->owner = NULL;
-	raw_spin_lock_init(&lock->wait_lock);
-	lock->waiters = RB_ROOT_CACHED;
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 
-	if (name && key)
-		debug_rt_mutex_init(lock, name, key);
+	__rt_mutex_basic_init(lock);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -1612,7 +1610,7 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL, NULL);
+	__rt_mutex_basic_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 8596a71..41adf8b 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -100,6 +100,13 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
 
+static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+{
+	lock->owner = NULL;
+	raw_spin_lock_init(&lock->wait_lock);
+	lock->waiters = RB_ROOT_CACHED;
+}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
