Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06863EF361
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhHQUPY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhHQUO4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:56 -0400
Date:   Tue, 17 Aug 2021 20:14:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLq0bvjwM+wTWWqILoFgjQIBzSqefgFUJOCkcW3oHQY=;
        b=ZklXYufJ2xh/615ks+X20ExHj/PO7YMyZM39aaNJ0AgatfPEJObZ7SVwSJzK4UGjgBdO/o
        jY5uqIB4PRjO57Z6t/njppQ+mTO+Xm703zvspa2hBRyTSSgRoXAMvEZNHfArNHqrNh1m3W
        Gd4jBg20cQDcjhz+WF7G6bQ2RFOej1kbZup43q4yWJ1YohaRU5d3Mod0bV8VHJX5Q3L3r+
        Qe5xhl5PdRA+YTbC/mFacFktjp8W65WSAbyXEJ5gtiOivZWhR08Yl586KxVRWOF3IdDm2+
        6ry4bPOUSd/sLt16ocrVzHtmg43MgbiCEBC6ruqiXIZPIvwTMuzDR5XL9EQSjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLq0bvjwM+wTWWqILoFgjQIBzSqefgFUJOCkcW3oHQY=;
        b=s5hvuMpEBQi2zYttyw4ctRuKYmobLrqVoRv2P1EC7L+55Z/+w3aWyVSGh8qOy37ng8pFwL
        19VrPDqGyNzbjCDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlock: Provide RT specific spinlock_t
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.654230709@linutronix.de>
References: <20210815211303.654230709@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126136.25758.10202046136238053065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     051790eecc03aff6978763791d38c1daea94c2f8
Gitweb:        https://git.kernel.org/tip/051790eecc03aff6978763791d38c1daea94c2f8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:41:24 +02:00

locking/spinlock: Provide RT specific spinlock_t

RT replaces spinlocks with a simple wrapper around an rtmutex, which turns
spinlocks on RT into 'sleeping' spinlocks. The actual implementation of the
spinlock API differs from a regular rtmutex, as it does neither handle
timeouts nor signals and it is state preserving across the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.654230709@linutronix.de
---
 include/linux/spinlock_types.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 42be111..8a9aadb 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -11,6 +11,9 @@
 
 #include <linux/spinlock_types_raw.h>
 
+#ifndef CONFIG_PREEMPT_RT
+
+/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
 typedef struct spinlock {
 	union {
 		struct raw_spinlock rlock;
@@ -39,6 +42,29 @@ typedef struct spinlock {
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
+#else /* !CONFIG_PREEMPT_RT */
+
+/* PREEMPT_RT kernels map spinlock to rt_mutex */
+#include <linux/rtmutex.h>
+
+typedef struct spinlock {
+	struct rt_mutex_base	lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} spinlock_t;
+
+#define __SPIN_LOCK_UNLOCKED(name)				\
+	{							\
+		.lock = __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		SPIN_DEP_MAP_INIT(name)				\
+	}
+
+#define DEFINE_SPINLOCK(name)					\
+	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #include <linux/rwlock_types.h>
 
 #endif /* __LINUX_SPINLOCK_TYPES_H */
