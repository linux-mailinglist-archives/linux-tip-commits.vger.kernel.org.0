Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E614C34D4F1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC2QYh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhC2QYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D890C061756;
        Mon, 29 Mar 2021 09:24:13 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLM/jbFIOweaTQ5Jh2NQYokPkwy0Vvwy27bPAMYAZAo=;
        b=SgDa7piHMrsM3KyX4Mfn7ptfRNfXVAnAMLJ96AGWmZD9/57ZKuc/cPglClHNQTkfApLq0y
        p6EoGIAxoaZuCKlyqtC2B9jD5te5xki/kOOeXhrJtd7gZuAp4+J95/FIJSz/FRvysv4sJE
        I+F0uLtDbePP2jQUmmQje4AYac7OcPpHI5mYG7KvyT4Uf6Ej8zg/hZmzt+mAW2bVHvQesE
        NlhCecbu/zkRuqrhzFXXtAnuyiD5QHyqux9TDSW9+0daYKdu4sccSlmNi01qpEiPS4UUda
        SB/SAKN8fjLCBDYsVhubn8EG0GeObfqc0jtciwfushXlna7PRWHi9dVqY+lvsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLM/jbFIOweaTQ5Jh2NQYokPkwy0Vvwy27bPAMYAZAo=;
        b=OgImZg1Prbby4TTE/bHfRI/OeYuQ4gOKoX4VFmFFW0Wy+WcEjBckJqIN+ZElGtQF0qsga9
        6UWcZCH4a/cRb0AA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Consolidate rt_mutex_init()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.437405350@linutronix.de>
References: <20210326153943.437405350@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505131.29796.6858791226110189392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     199cacd1a625cfc499d624b98b10dc763062f7dd
Gitweb:        https://git.kernel.org/tip/199cacd1a625cfc499d624b98b10dc763062f7dd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:02 +02:00

locking/rtmutex: Consolidate rt_mutex_init()

rt_mutex_init() only initializes lockdep if CONFIG_DEBUG_RT_MUTEXES is
enabled, which is fine because all lockdep variants select it, but there is
no reason to do so.

Move the function outside of the CONFIG_DEBUG_RT_MUTEXES block which
removes #ifdeffery.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.437405350@linutronix.de
---
 include/linux/rtmutex.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 0725c4b..243fabc 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -43,6 +43,7 @@ struct hrtimer_sleeper;
  extern int rt_mutex_debug_check_no_locks_freed(const void *from,
 						unsigned long len);
  extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
+ extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
  static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
 						       unsigned long len)
@@ -50,22 +51,15 @@ struct hrtimer_sleeper;
 	return 0;
  }
 # define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
+# define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-
-# define rt_mutex_init(mutex) \
+#define rt_mutex_init(mutex) \
 do { \
 	static struct lock_class_key __key; \
 	__rt_mutex_init(mutex, __func__, &__key); \
 } while (0)
 
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
-#else
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
-#endif
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
 	, .dep_map = { .name = #mutexname }
