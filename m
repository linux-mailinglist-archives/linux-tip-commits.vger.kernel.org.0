Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F733EF331
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhHQUOh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhHQUOf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB04C061764;
        Tue, 17 Aug 2021 13:14:01 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:13:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AURNQ+yiagu9X2hXcAFpZEaShxSNZxa0lW5mHAwBfMA=;
        b=ZlkMLRahd5IYEncIMcmuQLpDgcnJYxkQtXjRAF2/se2lTM59NTvxY869cVIl6v6LgSXu7D
        eSheQlUtGxSgyv/Yo9B56t6+5Xg+b9keQlMmhW3IM2Oq7n8Q4r0/d49U6Vhfb/FvOLrOoN
        t1KoV/288H4TRtUIiScDXmRKSJbluy77fdEYEqONGy/zE9pqzaMZyH+QdYdGw19hzle5d9
        Ho9Qz6wTN5qGPCAgWjCYodddQuFm6kJ8PJJTXQUhaQu2DSrLiizdNI7UT7x72xRfWLncdW
        LxZVqxyGiL5Zk9MolI9sldvVWdIgRdYdj+965g8Zu2ModC01tExox5Fko4aiXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AURNQ+yiagu9X2hXcAFpZEaShxSNZxa0lW5mHAwBfMA=;
        b=dq85VKXHgUSv46E9aI5FMgnp8h/hNyzjF10fGEny6313uy+GFJQpDBBosWLvv7WvdV/IgJ
        ZO+B3LsLq2kawIBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Prevent lockdep false positive
 with PI futexes
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.750701219@linutronix.de>
References: <20210815211305.750701219@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123934.25758.12789675236369119207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     51711e825a6d1b2fe7ca46bb06d08c25d97656ee
Gitweb:        https://git.kernel.org/tip/51711e825a6d1b2fe7ca46bb06d08c25d97656ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:06:02 +02:00

locking/rtmutex: Prevent lockdep false positive with PI futexes

On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping' and rtmutex
based. That causes a lockdep false positive because some of the futex
functions invoke spin_unlock(&hb->lock) with the wait_lock of the rtmutex
associated to the pi_futex held.  spin_unlock() in turn takes wait_lock of
the rtmutex on which the spinlock is based which makes lockdep notice a
lock recursion.

Give the futex/rtmutex wait_lock a separate key.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.750701219@linutronix.de
---
 kernel/locking/rtmutex_api.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 92b7d28..5c9299a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -214,7 +214,19 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 					struct task_struct *proxy_owner)
 {
+	static struct lock_class_key pi_futex_key;
+
 	__rt_mutex_base_init(lock);
+	/*
+	 * On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping'
+	 * and rtmutex based. That causes a lockdep false positive, because
+	 * some of the futex functions invoke spin_unlock(&hb->lock) with
+	 * the wait_lock of the rtmutex associated to the pi_futex held.
+	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
+	 * the spinlock is based, which makes lockdep notice a lock
+	 * recursion. Give the futex/rtmutex wait_lock a separate key.
+	 */
+	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
