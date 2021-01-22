Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2BB3004E8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbhAVOH7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 09:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbhAVOGu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 09:06:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6BAC06174A;
        Fri, 22 Jan 2021 06:05:30 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7+/wVpsO2Jwrj3g1txkCA+TeCYCNYZEnZLa2VmkfAw=;
        b=xuAnF3D8K5lz0Jpr/KIBSSgNdOBcUeNpPRCKc1qw/CI3VQLPwU+9/4D3DucxCOR8W0PBfD
        DFLv8AJw+i7mtUgfa58V5dNLZl4yuGPk1SNjSkUuD5p5EmhK3fk2mC+VIa0HMBauejej8b
        fbYusBMeq78x+CMpRLVrHf4WTpatgXH/Zk8Bb95x0lVNkyDBPepOf4xg9cRB+QbEBfSVlG
        sZCEPPDTiA3VtH4DBSuPvzUaF51/YGA3WowpFLMvpNRq7rMDZHWfKOE2fi9WLKAZKH+hcv
        jxaar+9xNBdatttseQL8E2ToV6ss46DD5mFcmHcQ87sFAYYIEjahVOnEbbaasw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7+/wVpsO2Jwrj3g1txkCA+TeCYCNYZEnZLa2VmkfAw=;
        b=px23t6KmEs16a7FBgaMDFyPmiqEasD9HD93PMT/owPVqfmWzCrJwXjDvmdEfMPGTK40j+P
        wo2lVzDK/qJjFSAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: report broken irq restoration
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210111153707.10071-1-mark.rutland@arm.com>
References: <20210111153707.10071-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <161132432734.414.7901255699341809699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     997acaf6b4b59c6a9c259740312a69ea549cc684
Gitweb:        https://git.kernel.org/tip/997acaf6b4b59c6a9c259740312a69ea549cc684
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 11 Jan 2021 15:37:07 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 11:08:56 +01:00

lockdep: report broken irq restoration

We generally expect local_irq_save() and local_irq_restore() to be
paired and sanely nested, and so local_irq_restore() expects to be
called with irqs disabled. Thus, within local_irq_restore() we only
trace irq flag changes when unmasking irqs.

This means that a sequence such as:

| local_irq_disable();
| local_irq_save(flags);
| local_irq_enable();
| local_irq_restore(flags);

... is liable to break things, as the local_irq_restore() would mask
irqs without tracing this change. Similar problems may exist for
architectures whose arch_irq_restore() function depends on being called
with irqs disabled.

We don't consider such sequences to be a good idea, so let's define
those as forbidden, and add tooling to detect such broken cases.

This patch adds debug code to WARN() when raw_local_irq_restore() is
called with irqs enabled. As raw_local_irq_restore() is expected to pair
with raw_local_irq_save(), it should never be called with irqs enabled.

To avoid the possibility of circular header dependencies between
irqflags.h and bug.h, the warning is handled in a separate C file.

The new code is all conditional on a new CONFIG_DEBUG_IRQFLAGS symbol
which is independent of CONFIG_TRACE_IRQFLAGS. As noted above such cases
will confuse lockdep, so CONFIG_DEBUG_LOCKDEP now selects
CONFIG_DEBUG_IRQFLAGS.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210111153707.10071-1-mark.rutland@arm.com
---
 include/linux/irqflags.h       | 12 ++++++++++++
 kernel/locking/Makefile        |  1 +
 kernel/locking/irqflag-debug.c | 11 +++++++++++
 lib/Kconfig.debug              |  8 ++++++++
 4 files changed, 32 insertions(+)
 create mode 100644 kernel/locking/irqflag-debug.c

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 8de0e13..600c10d 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -149,6 +149,17 @@ do {						\
 # define start_critical_timings() do { } while (0)
 #endif
 
+#ifdef CONFIG_DEBUG_IRQFLAGS
+extern void warn_bogus_irq_restore(void);
+#define raw_check_bogus_irq_restore()			\
+	do {						\
+		if (unlikely(!arch_irqs_disabled()))	\
+			warn_bogus_irq_restore();	\
+	} while (0)
+#else
+#define raw_check_bogus_irq_restore() do { } while (0)
+#endif
+
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
@@ -162,6 +173,7 @@ do {						\
 #define raw_local_irq_restore(flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
+		raw_check_bogus_irq_restore();		\
 		arch_local_irq_restore(flags);		\
 	} while (0)
 #define raw_local_save_flags(flags)			\
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 6d11cfb..8838f1d 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -15,6 +15,7 @@ CFLAGS_REMOVE_mutex-debug.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_rtmutex-debug.o = $(CC_FLAGS_FTRACE)
 endif
 
+obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
 ifeq ($(CONFIG_PROC_FS),y)
diff --git a/kernel/locking/irqflag-debug.c b/kernel/locking/irqflag-debug.c
new file mode 100644
index 0000000..9603d20
--- /dev/null
+++ b/kernel/locking/irqflag-debug.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/irqflags.h>
+
+void warn_bogus_irq_restore(void)
+{
+	WARN_ONCE(1, "raw_local_irq_restore() called with IRQs enabled\n");
+}
+EXPORT_SYMBOL(warn_bogus_irq_restore);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e6e58b2..78eadf6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1343,6 +1343,7 @@ config LOCKDEP_SMALL
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
+	select DEBUG_IRQFLAGS
 	help
 	  If you say Y here, the lock dependency engine will do
 	  additional runtime checks to debug itself, at the price
@@ -1431,6 +1432,13 @@ config TRACE_IRQFLAGS_NMI
 	depends on TRACE_IRQFLAGS
 	depends on TRACE_IRQFLAGS_NMI_SUPPORT
 
+config DEBUG_IRQFLAGS
+	bool "Debug IRQ flag manipulation"
+	help
+	  Enables checks for potentially unsafe enabling or disabling of
+	  interrupts, such as calling raw_local_irq_restore() when interrupts
+	  are enabled.
+
 config STACKTRACE
 	bool "Stack backtrace support"
 	depends on STACKTRACE_SUPPORT
