Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F751DA1D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgESUA2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgEST7H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:59:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC0C08C5C0;
        Tue, 19 May 2020 12:59:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OF-0000FW-1m; Tue, 19 May 2020 21:59:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CD5B1C04E3;
        Tue, 19 May 2020 21:58:48 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.270771162@linutronix.de>
References: <20200505134100.270771162@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832840.17951.9965229788112577467.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0995a5dfbe49badff78e78761fb66f46579f2f9a
Gitweb:        https://git.kernel.org/tip/0995a5dfbe49badff78e78761fb66f46579f2f9a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Mar 2020 13:09:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:21 +02:00

tracing: Provide lockdep less trace_hardirqs_on/off() variants

trace_hardirqs_on/off() is only partially safe vs. RCU idle. The tracer
core itself is safe, but the resulting tracepoints can be utilized by
e.g. BPF which is unsafe.

Provide variants which do not contain the lockdep invocation so the lockdep
and tracer invocations can be split at the call site and placed
properly. This is required because lockdep needs to be aware of the state
before switching away from RCU idle and after switching to RCU idle because
these transitions can take locks.

As these code pathes are going to be non-instrumentable the tracer can be
invoked after RCU is turned on and before the switch to RCU idle. So for
these new variants there is no need to invoke the rcuidle aware tracer
functions.

Name them so they match the lockdep counterparts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134100.270771162@linutronix.de


---
 include/linux/irqflags.h        |  4 +++-
 kernel/trace/trace_preemptirq.c | 37 ++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 61a9ced..f150e69 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -29,6 +29,8 @@
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+  extern void trace_hardirqs_on_prepare(void);
+  extern void trace_hardirqs_off_prepare(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context(p)	((p)->hardirq_context)
@@ -96,6 +98,8 @@ do {						\
 	  } while (0)
 
 #else
+# define trace_hardirqs_on_prepare()		do { } while (0)
+# define trace_hardirqs_off_prepare()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
 # define lockdep_hardirq_context(p)	0
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 4d8e99f..c008801 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,24 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+/*
+ * Like trace_hardirqs_on() but without the lockdep invocation. This is
+ * used in the low level entry code where the ordering vs. RCU is important
+ * and lockdep uses a staged approach which splits the lockdep hardirq
+ * tracking into a RCU on and a RCU off section.
+ */
+void trace_hardirqs_on_prepare(void)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+}
+EXPORT_SYMBOL(trace_hardirqs_on_prepare);
+NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
+
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
@@ -33,6 +51,25 @@ void trace_hardirqs_on(void)
 EXPORT_SYMBOL(trace_hardirqs_on);
 NOKPROBE_SYMBOL(trace_hardirqs_on);
 
+/*
+ * Like trace_hardirqs_off() but without the lockdep invocation. This is
+ * used in the low level entry code where the ordering vs. RCU is important
+ * and lockdep uses a staged approach which splits the lockdep hardirq
+ * tracking into a RCU on and a RCU off section.
+ */
+void trace_hardirqs_off_prepare(void)
+{
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+	}
+
+}
+EXPORT_SYMBOL(trace_hardirqs_off_prepare);
+NOKPROBE_SYMBOL(trace_hardirqs_off_prepare);
+
 void trace_hardirqs_off(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {
