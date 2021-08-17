Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD013EF32A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHQUOd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhHQUOd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1712C061764;
        Tue, 17 Aug 2021 13:13:59 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:13:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCiN/8ES4XK5dFfq5NTjwHSufKLI1m8EYMQjqUavrKQ=;
        b=IEIHu5DUq6EwoUzvfa5/Uz79U8//R+TfiIRoRBqKQDwNksfSetdUW5S5vblHfFcjWHz4Io
        uoPEX/aXCxVqg54DPfU6IgS0aoH243jsYz+28N5hHxt6HMLN+C2ALqhRgtqQnPgg9CXEDD
        flmct6qjjc9Otk6fo5+kd+LUMIadCJyJJ6A46NKuCKhnWK4jloxgUCNqCSyEx6YAycbdpa
        gqRu12W9+W3AP3HFp9tOMv4g42av6XrdQ7MWyfH5fuZWuSuKvJOLYWHyaU75GZ2Wr8qJks
        2eT3LPx1+Fa9t2Uyz8VYWK8zmQbDiMe6aEMknblOYp3EMkc4ucnkFbSVD1VSdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCiN/8ES4XK5dFfq5NTjwHSufKLI1m8EYMQjqUavrKQ=;
        b=tB3G1jfreH1y/K2deWLPuioS5MylTeJ27Oogmx+GMrpi+uThCG8C10yNk4bWZc0CeU73kY
        aTsTK0blseraRMCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Add PREEMPT_RT support
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211306.023630962@linutronix.de>
References: <20210815211306.023630962@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123648.25758.6097638559084736237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     026659b9774e4c586baeb457557fcfc4e0ad144b
Gitweb:        https://git.kernel.org/tip/026659b9774e4c586baeb457557fcfc4e0ad144b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:08:49 +02:00

locking/local_lock: Add PREEMPT_RT support

On PREEMPT_RT enabled kernels local_lock maps to a per CPU 'sleeping'
spinlock which protects the critical section while staying preemptible. CPU
locality is established by disabling migration.

Provide the necessary types and macros to substitute the non-RT variant.

Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211306.023630962@linutronix.de
---
 include/linux/local_lock_internal.h | 44 ++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 3f02b81..975e33b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -6,6 +6,8 @@
 #include <linux/percpu-defs.h>
 #include <linux/lockdep.h>
 
+#ifndef CONFIG_PREEMPT_RT
+
 typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -95,3 +97,45 @@ do {								\
 		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
+
+#else /* !CONFIG_PREEMPT_RT */
+
+/*
+ * On PREEMPT_RT local_lock maps to a per CPU spinlock, which protects the
+ * critical section while staying preemptible.
+ */
+typedef spinlock_t local_lock_t;
+
+#define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+
+#define __local_lock_init(l)					\
+	do {							\
+		local_spin_lock_init((l));			\
+	} while (0)
+
+#define __local_lock(__lock)					\
+	do {							\
+		migrate_disable();				\
+		spin_lock(this_cpu_ptr((__lock)));		\
+	} while (0)
+
+#define __local_lock_irq(lock)			__local_lock(lock)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__local_lock(lock);				\
+	} while (0)
+
+#define __local_unlock(__lock)					\
+	do {							\
+		spin_unlock(this_cpu_ptr((__lock)));		\
+		migrate_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)		__local_unlock(lock)
+
+#define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
+
+#endif /* CONFIG_PREEMPT_RT */
