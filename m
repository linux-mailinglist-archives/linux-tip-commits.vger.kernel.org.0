Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A993182B6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBKAvH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBKAvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55283C061756;
        Wed, 10 Feb 2021 16:50:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbR9B1Tsx9Pq3c7cpxmiv8ErRo0EaDvnFA4353iNUtg=;
        b=ANZEfkyL2uMLjEhdrJ37acYBrD1fCH9V/YwP2As7QnJLRFCZGF5ZQk2RSKTKlm2IJ4DoUc
        T9CmQkP7DmrN8Sz4O7nyhCBli2T6P4rpxyLrnm1uaq5EMCBFb6JGxEScQ5brjaGuny5R3M
        WwCyYLRBZP5D5IEAdZnJSLS0TI4tfbtWdMX+4pRC8VRcQ7PJx6yBhan0HB0ET7Su2CG/qt
        zEpnRcWG1P5GLxGs0ewJTiVoXBg2cdvMPAFh7nV/6IOtzpu5feCNQGLtJgiaWTMTVxA8b3
        pG6NYbDOflKbrhxqQxgRe5zvdiuk1Zb5bRk0xWAnGfljtKQu4hIPO4gYcUmrsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbR9B1Tsx9Pq3c7cpxmiv8ErRo0EaDvnFA4353iNUtg=;
        b=1rxZzSFxilCRbNAIzr3n1WX+BY2/KmSM8FXHjLU3H0xzh+8pUWGENezHNpbqrhEJHuL5jy
        jeQhqkWVIky+4+AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] softirq: Move do_softirq_own_stack() to generic asm header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002513.289960691@linutronix.de>
References: <20210210002513.289960691@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462406.23325.11301767256395948426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     db1cc7aede37eb9235759131ddfefd9c0ea5136f
Gitweb:        https://git.kernel.org/tip/db1cc7aede37eb9235759131ddfefd9c0ea5136f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:16 +01:00

softirq: Move do_softirq_own_stack() to generic asm header

To avoid include recursion hell move the do_softirq_own_stack() related
content into a generic asm header and include it from all places in arch/
which need the prototype.

This allows architectures to provide an inline implementation of
do_softirq_own_stack() without introducing a lot of #ifdeffery all over the
place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002513.289960691@linutronix.de

---
 arch/parisc/kernel/irq.c            |  1 +
 arch/powerpc/kernel/irq.c           |  1 +
 arch/s390/kernel/irq.c              |  1 +
 arch/sh/kernel/irq.c                |  1 +
 arch/sparc/kernel/irq_64.c          |  1 +
 arch/x86/kernel/irq_32.c            |  1 +
 arch/x86/kernel/irq_64.c            |  1 +
 include/asm-generic/Kbuild          |  1 +
 include/asm-generic/softirq_stack.h | 14 ++++++++++++++
 include/linux/interrupt.h           |  9 ---------
 kernel/softirq.c                    |  2 ++
 11 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 include/asm-generic/softirq_stack.h

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 49cd6d2..1632d52 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
+#include <asm/softirq_stack.h>
 #include <asm/smp.h>
 #include <asm/ldcw.h>
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6b1eca5..96296d3 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
 #include <asm/hw_irq.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index f8a8b94..a1a2f75 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/stacktrace.h>
+#include <asm/softirq_stack.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index ab5f790..ef0f082 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <asm/thread_info.h>
 #include <cpu/mmu_context.h>
+#include <asm/softirq_stack.h>
 
 atomic_t irq_err_count;
 
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3ec9f14..c8848bb 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -42,6 +42,7 @@
 #include <asm/head.h>
 #include <asm/hypervisor.h>
 #include <asm/cacheflush.h>
+#include <asm/softirq_stack.h>
 
 #include "entry.h"
 #include "cpumap.h"
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 0b79efc..044902d 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -22,6 +22,7 @@
 
 #include <asm/apic.h>
 #include <asm/nospec-branch.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index b88fdb9..f335c39 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/softirq_stack.h>
 #include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 267f6df..bd68418 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -51,6 +51,7 @@ mandatory-y += sections.h
 mandatory-y += serial.h
 mandatory-y += shmparam.h
 mandatory-y += simd.h
+mandatory-y += softirq_stack.h
 mandatory-y += switch_to.h
 mandatory-y += timex.h
 mandatory-y += tlbflush.h
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/softirq_stack.h
new file mode 100644
index 0000000..eceeecf
--- /dev/null
+++ b/include/asm-generic/softirq_stack.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
+#define __ASM_GENERIC_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+void do_softirq_own_stack(void);
+#else
+static inline void do_softirq_own_stack(void)
+{
+	__do_softirq();
+}
+#endif
+
+#endif
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f0b918f..967e257 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,15 +569,6 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
-void do_softirq_own_stack(void);
-#else
-static inline void do_softirq_own_stack(void)
-{
-	__do_softirq();
-}
-#endif
-
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046..9908ec4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -26,6 +26,8 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 
+#include <asm/softirq_stack.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
 
