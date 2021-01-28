Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BF3075DB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jan 2021 13:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhA1MWV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jan 2021 07:22:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhA1MWT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jan 2021 07:22:19 -0500
Date:   Thu, 28 Jan 2021 12:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trpTr5Kt6dyOcuEAnVdH0aFyDdUBi+2DCuy6JjrYcbI=;
        b=dAsjuBJO3JBaZxSNHCZBNQntmN1/5W2H7oEzyAMWOIs0NpRftMqPRuyNA3diT2ymJ6xGpU
        aoPTEpO1d7H7MeEd92hWeQi5gj2sPOZ64pe6BRT5JwnKdP+VgpvhuoF0N374NhWTZVxcTW
        HSZv38oIrmYRjKDmLG9wUNOuocZoErNqXs15deXWJ6dsu68/mL0G7qc0uvurYFsX51hwHe
        0ac4cxyzKHYwj799akte2cLYUMu0zum4wXBLj6x7XUwFtfEpuhErj8z20JMhiz49ip5FVa
        nldIu1yy+ADDl/Cu5TyZOOl3ZMiFHwezBNhz/d9oElUoforlVib28rDtLgjmfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trpTr5Kt6dyOcuEAnVdH0aFyDdUBi+2DCuy6JjrYcbI=;
        b=eOVuruo85Tf6Q46WXOGYDzuZJD2mqkrylbvsieO7XilfeKT2tkLY5wEONYZV+uhE9L8Wo4
        X5c8b78sAvDhJ2BQ==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add missing kernel-doc markup
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <161183649616.23325.8512729812885530815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bf594bf400016a1ac58c753bcc0393a39c36f669
Gitweb:        https://git.kernel.org/tip/bf594bf400016a1ac58c753bcc0393a39c36f669
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 16:58:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jan 2021 13:20:18 +01:00

locking/rtmutex: Add missing kernel-doc markup

To fix the following issues:
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'lock' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'wake_q' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'name' not described in '__rt_mutex_init'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'key' not described in '__rt_mutex_init'

[ tglx: Change rt lock to rt_mutex for consistency sake ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com


---
 kernel/locking/rtmutex.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cfdd5b9..a201e5e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1604,8 +1604,11 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /**
- * Futex variant, that since futex variants do not use the fast-path, can be
- * simple and will not need to retry.
+ * __rt_mutex_futex_unlock - Futex variant, that since futex variants
+ * do not use the fast-path, can be simple and will not need to retry.
+ *
+ * @lock:	The rt_mutex to be unlocked
+ * @wake_q:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 				    struct wake_q_head *wake_q)
@@ -1662,13 +1665,15 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
- * __rt_mutex_init - initialize the rt lock
+ * __rt_mutex_init - initialize the rt_mutex
  *
- * @lock: the rt lock to be initialized
+ * @lock:	The rt_mutex to be initialized
+ * @name:	The lock name used for debugging
+ * @key:	The lock class key used for debugging
  *
- * Initialize the rt lock to unlocked state.
+ * Initialize the rt_mutex to unlocked state.
  *
- * Initializing of a locked rt lock is not allowed
+ * Initializing of a locked rt_mutex is not allowed
  */
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
