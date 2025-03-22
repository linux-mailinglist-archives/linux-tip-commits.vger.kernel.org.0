Return-Path: <linux-tip-commits+bounces-4422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744CA6C871
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D613A3AED9D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3A194080;
	Sat, 22 Mar 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9Y+YTnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6zUwcb1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D21B6CE3;
	Sat, 22 Mar 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634008; cv=none; b=f6/QQvRDkXb8j/adyc+eMHb/z5zB0BE4A9T4EB1w+RgKw0MwYWjGCp6atcsD13qssUkOnusftjtXjXdEw6tbG+5l2QY7mv3dZRGWfKi7ZNnnWf7ed77WwV42lt9Jb3X/rPB0MXWSvBdq9pIzFmbY87zu87ga8AjQ6q+joJzUHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634008; c=relaxed/simple;
	bh=W59WgOSEvEDsobCjJu9DFVc7z97C93wLQ1xRZujVXSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LJ++xR6Bq1eybw47tRUBSKF824HWjbQNI1qgUP6VWMNvh4CLYexLOsCqyfIp7Up8WcEj130zU+lVYynVwViDEFWr2O0dtckl6EkSQxfjZyLuk8A73IipZYrjqa8ytF9m8+sHw9EkbGE5T7secEIdwhmeR6ZaRB5NegdK7by1RTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9Y+YTnv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6zUwcb1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Mar 2025 08:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742633998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pODKjKvgtEz0+QUaHKasO52nf7kB9KtWAAn6uBM7K2M=;
	b=V9Y+YTnvFNitL4tUn3OCgrhcBC+8bQaNk//3FMfqsR1s2ouX5+kotKU1f7rqYUErvMWdJa
	YqNQ50Ts23x+hMu84jFxujC4llYpfJvHaeyotj32kn/d80tZdJm6xaoERd6IaxAxXiwbXB
	W9y1Hq5lUh7mYkIEpq/G7S4SK/n0IPCOsdYq+6x2aPyOpCnh8QfiLx+9D7IDzLTwkxgcUo
	E2Gr3TP7vOpCNIX+QCJb3WehXPOscXcZxWTrKCIKUkk0NCwYjA6d5WOeWdPYxc6Rws6wW5
	W5EkF/+KOHOxn/vmP8xlnnSzKPg/JCpOMNOWjswRKlqSBCsTmImHlsLWbpIKtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742633998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pODKjKvgtEz0+QUaHKasO52nf7kB9KtWAAn6uBM7K2M=;
	b=F6zUwcb1auiFAGOFzaSPWwl+hG2lZf7Tw4wvA/PzyVKsDFhXMjPstPOmziv8rrLCaVv7JH
	jTa/TwLjGeUFVgBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tracing: Disable branch profiling in noinstr code
Cc: Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <fb94fc9303d48a5ed370498f54500cc4c338eb6d.1742586676.git.jpoimboe@kernel.org>
References:
 <fb94fc9303d48a5ed370498f54500cc4c338eb6d.1742586676.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174263399725.14745.478310656996497124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2cbb20b008dba39893f0e296dc8ca312f40a9a0e
Gitweb:        https://git.kernel.org/tip/2cbb20b008dba39893f0e296dc8ca312f40a9a0e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 21 Mar 2025 12:53:32 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 09:49:26 +01:00

tracing: Disable branch profiling in noinstr code

CONFIG_TRACE_BRANCH_PROFILING inserts a call to ftrace_likely_update()
for each use of likely() or unlikely().  That breaks noinstr rules if
the affected function is annotated as noinstr.

Disable branch profiling for files with noinstr functions.  In addition
to some individual files, this also includes the entire arch/x86
subtree, as well as the kernel/entry, drivers/cpuidle, and drivers/idle
directories, all of which are noinstr-heavy.

Due to the nature of how sched binaries are built by combining multiple
.c files into one, branch profiling is disabled more broadly across the
sched code than would otherwise be needed.

This fixes many warnings like the following:

  vmlinux.o: warning: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __rdgsbase_inactive+0x33: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: handle_bug.isra.0+0x198: call to ftrace_likely_update() leaves .noinstr.text section
  ...

Reported-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/fb94fc9303d48a5ed370498f54500cc4c338eb6d.1742586676.git.jpoimboe@kernel.org
---
 arch/x86/Kbuild                    | 4 ++++
 arch/x86/coco/sev/core.c           | 2 --
 arch/x86/kernel/head64.c           | 2 --
 arch/x86/mm/kasan_init_64.c        | 1 -
 arch/x86/mm/mem_encrypt_amd.c      | 2 --
 arch/x86/mm/mem_encrypt_identity.c | 2 --
 drivers/acpi/Makefile              | 4 ++++
 drivers/cpuidle/Makefile           | 3 +++
 drivers/idle/Makefile              | 5 ++++-
 kernel/Makefile                    | 5 +++++
 kernel/entry/Makefile              | 3 +++
 kernel/sched/Makefile              | 5 +++++
 kernel/time/Makefile               | 6 ++++++
 lib/Makefile                       | 5 +++++
 14 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index cf0ad89..f7fb3d8 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 96c7bc6..d14bce0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -9,8 +9,6 @@
 
 #define pr_fmt(fmt)	"SEV: " fmt
 
-#define DISABLE_BRANCH_PROFILING
-
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/cc_platform.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 22c9ba3..368157a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -5,8 +5,6 @@
  *  Copyright (C) 2000 Andrea Arcangeli <andrea@suse.de> SuSE
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 9dddf19..0539efd 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
 
 /* cpu_feature_enabled() cannot be used this early */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b56c5c0..7490ff6 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -7,8 +7,6 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index e6c7686..4e991de 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -7,8 +7,6 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 /*
  * Since we're dealing with identity mappings, physical and virtual
  * addresses are the same, so override these defines which are ultimately
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0..797070f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -5,6 +5,10 @@
 
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_processor_idle.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 #
 # ACPI Boot-Time Table Parsing
 #
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d103342..1de9e92 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -3,6 +3,9 @@
 # Makefile for cpuidle.
 #
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
diff --git a/drivers/idle/Makefile b/drivers/idle/Makefile
index 0a3c375..a34af1b 100644
--- a/drivers/idle/Makefile
+++ b/drivers/idle/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_INTEL_IDLE)			+= intel_idle.o
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
+obj-$(CONFIG_INTEL_IDLE)			+= intel_idle.o
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b0..434929d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -21,6 +21,11 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_irq_work.o = $(CC_FLAGS_FTRACE)
 endif
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_context_tracking.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 095c775..d4b8bd0 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -6,6 +6,9 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b..8ae8637 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -22,6 +22,11 @@ ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
+CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING
+endif
 #
 # Build efficiency:
 #
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index fe0ae82..e6e9b85 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_sched_clock.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-y += time.o timer.o hrtimer.o sleep_timeout.o
 obj-y += timekeeping.o ntp.o clocksource.o jiffies.o timer_list.o
 obj-y += timeconv.o timecounter.o alarmtimer.o
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7a..4f3d00a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,6 +5,11 @@
 
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_smp_processor_id.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 # These files are disabled because they produce lots of non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. For example,
 # rbtree can be global and individual rotations don't correlate with inputs.

