Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959FC422A64
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhJEOOJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhJEON5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:57 -0400
Date:   Tue, 05 Oct 2021 14:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QgXlyK4yh0y1akJ+TiaB4oGx9UYMojXgse965nP9K8=;
        b=B6Hky9L96GnX8YiG8oS+MlLQyf1FbHKTZeEdO5maRlag6sdEJdXE3F/mGNi3/hF1tRUONQ
        /jwzr7q1fwAIjuMThmOaZjfEF+5Wk8GXbeTYdf19ANMO91ICb7b+sVOK6OGsFtF0h7hajd
        f69AICCwGSIDSqk5Y3ur9g8jQihEu3pUJnnOiCAXjWOlwOZvRKAoj/AYCIaHalBmYKER7S
        B9v6SWvZ0sl7+H8CA3KKnkjJjKcqdR0/DHzv8huS9BqUqr6kh3/NgUp6ixqZxp898rV7vJ
        oWERBQJ9Qsgcc1ZNkLV2pfGKu3CxPCqrRXocWwozXLuT3PPfxZife5hvTU3BlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QgXlyK4yh0y1akJ+TiaB4oGx9UYMojXgse965nP9K8=;
        b=BJUGwLe85L194pZ+xBheRkj9ZxymwzFtGDSR1VGQNI3sVhAhP9UpCbz8cVKQv82XN2/nyC
        c3fxa5MhOgAda2Bg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Provide Kconfig support for default dynamic
 preempt mode
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210914103134.11309-1-frederic@kernel.org>
References: <20210914103134.11309-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <163344312450.25758.17799728166210849123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c597bfddc9e9e8a63817252b67c3ca0e544ace26
Gitweb:        https://git.kernel.org/tip/c597bfddc9e9e8a63817252b67c3ca0e544ace26
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 14 Sep 2021 12:31:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:56 +02:00

sched: Provide Kconfig support for default dynamic preempt mode

Currently the boot defined preempt behaviour (aka dynamic preempt)
selects full preemption by default when the "preempt=" boot parameter
is omitted. However distros may rather want to default to either
no preemption or voluntary preemption.

To provide with this flexibility, make dynamic preemption a visible
Kconfig option and adapt the preemption behaviour selected by the user
to either static or dynamic preemption.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210914103134.11309-1-frederic@kernel.org
---
 kernel/Kconfig.preempt | 32 +++++++++++++++++++++++---------
 kernel/sched/core.c    | 29 ++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5876e30..60f1bfc 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,10 +2,11 @@
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_NONE_BEHAVIOUR
 
-config PREEMPT_NONE
+config PREEMPT_NONE_BEHAVIOUR
 	bool "No Forced Preemption (Server)"
+	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -17,9 +18,10 @@ config PREEMPT_NONE
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY
+config PREEMPT_VOLUNTARY_BEHAVIOUR
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,12 +37,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT
+config PREEMPT_BEHAVIOUR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +58,7 @@ config PREEMPT
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,6 +75,17 @@ config PREEMPT_RT
 
 endchoice
 
+config PREEMPT_NONE
+	bool
+
+config PREEMPT_VOLUNTARY
+	bool
+
+config PREEMPT
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 config PREEMPT_COUNT
        bool
 
@@ -83,7 +94,10 @@ config PREEMPTION
        select PREEMPT_COUNT
 
 config PREEMPT_DYNAMIC
-	bool
+	bool "Preemption behaviour defined on boot"
+	depends on HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
+	default y
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1741e0..95f4e16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6520,12 +6520,13 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
  */
 
 enum {
-	preempt_dynamic_none = 0,
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
 };
 
-int preempt_dynamic_mode = preempt_dynamic_full;
+int preempt_dynamic_mode = preempt_dynamic_undefined;
 
 int sched_dynamic_mode(const char *str)
 {
@@ -6598,7 +6599,27 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=", setup_preempt_mode);
 
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("Dynamic Preempt: full\n");
+		}
+	}
+}
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
 /*
  * This is the entry point to schedule() from kernel preemption
@@ -9398,6 +9419,8 @@ void __init sched_init(void)
 
 	init_uclamp();
 
+	preempt_dynamic_init();
+
 	scheduler_running = 1;
 }
 
