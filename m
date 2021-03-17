Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DD33F466
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhCQPt0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhCQPs5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0697C061763;
        Wed, 17 Mar 2021 08:48:56 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:48:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vpt01t3oc+vTzeIdu/PctHew1yl2vjBmHmGlSEKzJlE=;
        b=OQ6F8cIGOJcEcoYALnorS1UeCspbv7VW/tw1NOfzpojBmoM9qNSzRJnx68J8lcmpa4jy/z
        htL7iitnueVlHsjCfTKUZcK3ghXfa7nNGf1IGcMJEJFSFg6y++MGBuUWn1+8+DUECkzVDO
        Lds/0L4s3HyVFpgciaBT/m5Pcbr5rOMc4tp5RS8U1Ci+iyjHSpJcicy6ipf/dNuZlwTazP
        D+hLXcZe6p1Gsv1HdgICNTowzBqTQMCRAUTIG8HvxXJDIotl9Cd/UXHZyQ+puR0BcHbyGv
        6wcyVMgR6MGRZ5SAWfGvz4dOqTuR07nCBSY2BJ8CmZRtpjlSDd6loIA0M6wYhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vpt01t3oc+vTzeIdu/PctHew1yl2vjBmHmGlSEKzJlE=;
        b=3qGafSLVSquE4mITVgrF7mewnznTIyLhI+B2KHY9PwaxJaPBTk80Iluamz/m7XdoppO8Ns
        mm4nA+VS9w6zS4Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Add RT specific softirq accounting
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085726.983627589@linutronix.de>
References: <20210309085726.983627589@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613469.398.10281190899958570583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     728b478d2d358480b333b42d0e10e0fecb20114c
Gitweb:        https://git.kernel.org/tip/728b478d2d358480b333b42d0e10e0fecb20114c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:08 +01:00

softirq: Add RT specific softirq accounting

RT requires the softirq processing and local bottomhalf disabled regions to
be preemptible. Using the normal preempt count based serialization is
therefore not possible because this implicitely disables preemption.

RT kernels use a per CPU local lock to serialize bottomhalfs. As
local_bh_disable() can nest the lock can only be acquired on the outermost
invocation of local_bh_disable() and released when the nest count becomes
zero. Tasks which hold the local lock can be preempted so its required to
keep track of the nest count per task.

Add a RT only counter to task struct and adjust the relevant macros in
preempt.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085726.983627589@linutronix.de

---
 include/linux/hardirq.h | 1 +
 include/linux/preempt.h | 6 +++++-
 include/linux/sched.h   | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 7c9d6a2..69bc86e 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
+#include <linux/sched.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 69cc8b6..9881eac 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -79,7 +79,11 @@
 
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#ifdef CONFIG_PREEMPT_RT
+# define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+#else
+# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#endif
 #define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb2..743a613 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1044,6 +1044,9 @@ struct task_struct {
 	int				softirq_context;
 	int				irq_config;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	int				softirq_disable_cnt;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL
