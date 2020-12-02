Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1364E2CC68D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgLBTYC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 14:24:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgLBTXy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 14:23:54 -0500
Date:   Wed, 02 Dec 2020 19:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8XJ9h1TijQvfijyamQEM7Xp5vz0MghIfETP+SgoG5s=;
        b=vs9NXd2H21lrSNQ/24f0AFnGfzpcbsjpHQZfJq/CZtOombuYCeYX9tg+TcDqkHlTlR9qwC
        xBFN1w3To+hlFlIq6abqyrxbVHb0bgF2nb0lERfSgRLpu8tXZFpbwwczX3JOw6xkgKT1dh
        DIVx+cn6KcZn3xpZmNd0WTRoGNp+nGJr7cws0avbFC7ZT5FycgAJ6my52LZPg11cIwYrYb
        02HCJUbUT0cArg+zw8Pp3/fR9xtkZ7O42sxvwAX03IstZCIWYC9PaTSO3cVmGibANeBp6g
        qKma1vGp1PMzi+WuE/NiOoBDoWFCtdWRBLdxCXjfbAkSYVW5870TqjvJLICTIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8XJ9h1TijQvfijyamQEM7Xp5vz0MghIfETP+SgoG5s=;
        b=Gy3ieVL4oelNUa6ChjvJ8ZVnchPhuzHoqIxhBWoqRI+oxLCZBf79IG8xrRwsM2utWhlJCL
        wk+eCw2yXn1npWBg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] s390/vtime: Use the generic IRQ entry accounting
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201202115732.27827-3-frederic@kernel.org>
References: <20201202115732.27827-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160693699179.3364.7706377815520047436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2b91ec9f551b56751cde48792f1c0a1130358844
Gitweb:        https://git.kernel.org/tip/2b91ec9f551b56751cde48792f1c0a1130358844
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 12:57:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 20:20:04 +01:00

s390/vtime: Use the generic IRQ entry accounting

s390 has its own version of IRQ entry accounting because it doesn't
account the idle time the same way the other architectures do. Only
the actual idle sleep time is accounted as idle time, the rest of the
idle task execution is accounted as system time.

Make the generic IRQ entry accounting aware of architectures that have
their own way of accounting idle time and convert s390 to use it.

This prepares s390 to get involved in further consolidations of IRQ
time accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201202115732.27827-3-frederic@kernel.org

---
 arch/Kconfig                  |  7 ++++++-
 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      |  4 ----
 kernel/sched/cputime.c        | 13 ++-----------
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc..0f151b4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -627,6 +627,12 @@ config HAVE_TIF_NOHZ
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
 
+config HAVE_VIRT_CPU_ACCOUNTING_IDLE
+	bool
+	help
+	  Architecture has its own way to account idle CPU time and therefore
+	  doesn't implement vtime_account_idle().
+
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
@@ -641,7 +647,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_GEN
 	  some 32-bit arches may require multiple accesses, so proper
 	  locking is needed to protect against concurrent accesses.
 
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4a2a12b..6f1fdcd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -181,6 +181,7 @@ config S390
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
 	select MODULES_USE_ELF_RELA
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index 3622d4e..fac6a67 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,7 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_ACCOUNT
 #define __ARCH_HAS_VTIME_TASK_SWITCH
 
 #endif /* _S390_VTIME_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index f9f2a11..ebd8e56 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -247,10 +247,6 @@ void vtime_account_kernel(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
-void vtime_account_irq_enter(struct task_struct *tsk)
-__attribute__((alias("vtime_account_kernel")));
-
-
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 61ce9f9..2783162 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -417,23 +417,14 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-/*
- * Archs that account the whole time spent in the idle task
- * (outside irq) as idle time can rely on this and just implement
- * vtime_account_kernel() and vtime_account_idle(). Archs that
- * have other meaning of the idle time (s390 only includes the
- * time spent by the CPU when it's in low power mode) must override
- * vtime_account().
- */
-#ifndef __ARCH_HAS_VTIME_ACCOUNT
 void vtime_account_irq_enter(struct task_struct *tsk)
 {
-	if (!in_interrupt() && is_idle_task(tsk))
+	if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+	    !in_interrupt() && is_idle_task(tsk))
 		vtime_account_idle(tsk);
 	else
 		vtime_account_kernel(tsk);
 }
-#endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
