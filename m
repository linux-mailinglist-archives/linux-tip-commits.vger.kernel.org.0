Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024623EF3AC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhHQURQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhHQUPy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C8C0619FB;
        Tue, 17 Aug 2021 13:14:33 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH1w7MCaqdHRDQjNk/HWJzl4j10uz1ZWUSL4YTjMPKA=;
        b=VrdjTExRzL/IveYy9BAewXIPwD6B4hmaPcLF9+0NrYrjTdEYOCWSL90QRt5vFmqvVp/lXe
        NO/DlvJrS2ccmZviqylKiOyxKuZkgGsINPVdadOEDm15BY9P1dqmjMoAQIkxSlryeXuFZS
        zBwIuslZ8+hbgRSyYrDRWFdqLr3sui0oKo2RIGvGB/oj176hONuVtIMLDERWU8xG5FdTHR
        oIpUKkmgcMdGu2k2IrmSqPfFthl2bxrplQNev0tZeJKpCizP4bYvgGEAO3XAPUOkP1ShMJ
        I0yBGE1X8tKQGgwVo/OE8zkbwKlnHxJ8lmbaisD5IF05MAnNx5HxksG8FsOzJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH1w7MCaqdHRDQjNk/HWJzl4j10uz1ZWUSL4YTjMPKA=;
        b=/9E8ZZOaRRjD7REGr34T74TgvWa8wEJvIRaFyI9hpbWKR3fTwJ3bn2g//eWIm/m+05Tblb
        YTW42xOrAR6aKsCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Convert macros to inlines
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.610830960@linutronix.de>
References: <20210815211302.610830960@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127171.25758.16943783024246758710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     785159301bedea25fae9b20cae3d12377246e941
Gitweb:        https://git.kernel.org/tip/785159301bedea25fae9b20cae3d12377246e941
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:00:48 +02:00

locking/rtmutex: Convert macros to inlines

Inlines are type-safe...

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.610830960@linutronix.de
---
 kernel/locking/rtmutex.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1a7e3f8..5187add 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,8 +141,19 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_acquire(&lock->owner, old, new) == old;
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_release(&lock->owner, old, new) == old;
+}
 
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we force
@@ -201,8 +212,20 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-# define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
-# define rt_mutex_cmpxchg_release(l,c,n)	(0)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+}
 
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {
