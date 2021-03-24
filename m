Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A9034725D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhCXHWs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhCXHWb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:31 -0400
Date:   Wed, 24 Mar 2021 07:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Owq1Am7meL9Q/jGOIThiw2Zi5NmBTbkpD0U3mACxbE=;
        b=B4f8miXvxdhKeYcQaexvaGQ+gXqM8HI2l91e8hWU8vb2NRTExdKBbq0HPwc3agXjgU74HY
        G1DCGsDUFUxmJB+38GQ5ldLOLGSXAbP3l1LlpY/4M1joJeKKvAMNjC5kMR6AHJGpZCluPR
        BI2iACSR3/wn5tSATDJwdE1iYhSz4ksc0cb7j98sLusQ3kVoUbJPJSG6WKxA5M8mRt+1Ee
        zwdxltqxHvsi7q+IJMe3Mp4oeONw4jT7s2CCjvQMfG5zMpCPh7nuxA/suljBihxEST3vJj
        /TWqwiSwIAzSJ3/7GjD45XkerQPf7lJP9I2zSDbO4x3prK0RCYJUsW5SuRSKBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Owq1Am7meL9Q/jGOIThiw2Zi5NmBTbkpD0U3mACxbE=;
        b=UZ/GzE8aYPEWeSDFHiWA5yG4THa+dGaqQFznpHgKnb+8HqlL6L/IeYIDzu6IIny0P0Tmeg
        Bb9IdW6XpzkxAUCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Consolidate rt_mutex_init()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213707.896403641@linutronix.de>
References: <20210323213707.896403641@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657055019.398.7246933621468834394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1ba7cf8e3a9316daa84ee774346028f84bca2957
Gitweb:        https://git.kernel.org/tip/1ba7cf8e3a9316daa84ee774346028f84bca2957
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:07 +01:00

locking/rtmutex: Consolidate rt_mutex_init()

rt_mutex_init() only initializes lockdep if CONFIG_DEBUG_RT_MUTEXES=y,
which is fine because all lockdep variants select it, but there is
no reason to do so.

Move the function outside of the CONFIG_DEBUG_RT_MUTEXES block which
removes #ifdeffery.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213707.896403641@linutronix.de
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
