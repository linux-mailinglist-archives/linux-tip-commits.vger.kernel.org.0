Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064844D68D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhKKMZS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhKKMZR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:17 -0500
Date:   Thu, 11 Nov 2021 12:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYYIOtQDaPbGCb3v3IF3ppvv3NHDZmZ0fF0nIXal8tU=;
        b=ud/Zbi8oMwMVRso+9LyLMdxJgZYB8ThM1lXz2h6SiaE2RmlsoEzXQ1FvKjbI9VIiNRBZsK
        kL0gDycL/ZhnYo30ag26QOCpd9PcCdP00NA8aw5OKfxnhQnFig8xMpeTWwYwG61YzaHbDr
        6emd93Xb2hHdoa+QF2dIl8LiG+EiKviAWCsMDlUW28WyfnL1L+48TAQK1w75wmys+gdcgo
        SYFV4udz179O15q/AWY+tCLei1xVVtdxDvTyrpQHHfPPtwD1rcsqHY/kd1rGwxGctCKWpG
        nqaO9bXQdtGshppMP8mdRCMJw9EDq+7BUoiKxcQeK508YuowVT6SmnA9qfE56g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYYIOtQDaPbGCb3v3IF3ppvv3NHDZmZ0fF0nIXal8tU=;
        b=8aReROnJiP7XzQDzEcqFKGWo/C+T9O02nVV4LJbBBbecX9yaPzVaXxx3v3Mm2OMyDMK/kQ
        Zl8hkkjSDF6fQfAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] preempt: Restore preemption model selection configs
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110202448.4054153-2-valentin.schneider@arm.com>
References: <20211110202448.4054153-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163663334665.414.18302476342451146217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a8b76910e465d718effce0cad306a21fa4f3526b
Gitweb:        https://git.kernel.org/tip/a8b76910e465d718effce0cad306a21fa4f3526b
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 10 Nov 2021 20:24:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:33 +01:00

preempt: Restore preemption model selection configs

Commit c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic
preempt mode") changed the selectable config names for the preemption
model. This means a config file must now select

  CONFIG_PREEMPT_BEHAVIOUR=y

rather than

  CONFIG_PREEMPT=y

to get a preemptible kernel. This means all arch config files would need to
be updated - right now they'll all end up with the default
CONFIG_PREEMPT_NONE_BEHAVIOUR.

Rather than touch a good hundred of config files, restore usage of
CONFIG_PREEMPT{_NONE, _VOLUNTARY}. Make them configure:
o The build-time preemption model when !PREEMPT_DYNAMIC
o The default boot-time preemption model when PREEMPT_DYNAMIC

Add siblings of those configs with the _BUILD suffix to unconditionally
designate the build-time preemption model (PREEMPT_DYNAMIC is built with
the "highest" preemption model it supports, aka PREEMPT). Downstream
configs should by now all be depending / selected by CONFIG_PREEMPTION
rather than CONFIG_PREEMPT, so only a few sites need patching up.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20211110202448.4054153-2-valentin.schneider@arm.com
---
 include/linux/kernel.h   |  2 +-
 include/linux/vermagic.h |  2 +-
 init/Makefile            |  2 +-
 kernel/Kconfig.preempt   | 42 +++++++++++++++++++--------------------
 kernel/sched/core.c      |  6 +++---
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 968b4c4..77755ac 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -85,7 +85,7 @@
 struct completion;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY
+#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
 
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 1eaaa93..329d63b 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -15,7 +15,7 @@
 #else
 #define MODULE_VERMAGIC_SMP ""
 #endif
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_BUILD
 #define MODULE_VERMAGIC_PREEMPT "preempt "
 #elif defined(CONFIG_PREEMPT_RT)
 #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
diff --git a/init/Makefile b/init/Makefile
index 2846113..04eeee1 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -30,7 +30,7 @@ $(obj)/version.o: include/generated/compile.h
 quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
-	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
+	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
 	"$(CONFIG_PREEMPT_RT)" $(CONFIG_CC_VERSION_TEXT) "$(LD)"
 
 include/generated/compile.h: FORCE
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 60f1bfc..ce77f02 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,12 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config PREEMPT_NONE_BUILD
+	bool
+
+config PREEMPT_VOLUNTARY_BUILD
+	bool
+
+config PREEMPT_BUILD
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE_BEHAVIOUR
+	default PREEMPT_NONE
 
-config PREEMPT_NONE_BEHAVIOUR
+config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
+	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -18,10 +29,10 @@ config PREEMPT_NONE_BEHAVIOUR
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY_BEHAVIOUR
+config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
+	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -37,10 +48,10 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT_BEHAVIOUR
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPT_BUILD
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +69,7 @@ config PREEMPT_BEHAVIOUR
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
+	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,17 +86,6 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_NONE
-	bool
-
-config PREEMPT_VOLUNTARY
-	bool
-
-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-
 config PREEMPT_COUNT
        bool
 
@@ -95,8 +95,8 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	select PREEMPT_BUILD
 	default y
 	help
 	  This option allows to define the preemption model on the kernel
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 862af1d..3c9b0fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6628,13 +6628,13 @@ __setup("preempt=", setup_preempt_mode);
 static void __init preempt_dynamic_init(void)
 {
 	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
 			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
 		} else {
 			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
 			preempt_dynamic_mode = preempt_dynamic_full;
 			pr_info("Dynamic Preempt: full\n");
 		}
