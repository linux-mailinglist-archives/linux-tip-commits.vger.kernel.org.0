Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F059434C52
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJTNqo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJTNqo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:44 -0400
Date:   Wed, 20 Oct 2021 13:44:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6BL4jLMSjeza8+XphVvrKoFFmLMS6Sg55nfe7qgZDE=;
        b=E2w6bQgaFZovReIu0eq8ELtHeE6Jg6/keaSza11XVH7ZP/KRc1fpwaHKKUrtaG9PzqSJ0N
        u7+9lrCLGbIQNhIAGwvowUEzRpC0iOR5crvBN9HA5UMjmZCdMh4DyAdGKwARo+NjUEOR93
        QPqRJlD+QwlExVF9avXbeqnsHZFAGOfFrDn9/yev760hXh3I4eTpuITICgSU6gZ/VDbvkN
        nHWxsfVbkdUxfo/M2hQ1t34R6k+NKcwK1a7rxQR7Ov1Z2m3aBnMstMGIj9p01/7qEs3qy+
        4oWA4711PfVN4vyFAytTzeThF0d8jptYpKyiU6+RNZg5AAEU/u2yTlIasohv6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6BL4jLMSjeza8+XphVvrKoFFmLMS6Sg55nfe7qgZDE=;
        b=4jHdiICdDKobD+NeG/S1o75sdFe462NAURZTMzkt73Yso6IVlO2eEV72zeUkCtu418H6Rs
        MJREZEbnlvOApjDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Replace the includes of fpu/internal.h
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011540.001197214@linutronix.de>
References: <20211015011540.001197214@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473746799.25758.13222466731014550326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b56d2795b29792c465cc8ef036abad5127a003fb
Gitweb:        https://git.kernel.org/tip/b56d2795b29792c465cc8ef036abad5127a003fb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:29 +02:00

x86/fpu: Replace the includes of fpu/internal.h

Now that the file is empty, fixup all references with the proper includes
and delete the former kitchen sink.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011540.001197214@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 26 --------------------------
 arch/x86/kernel/cpu/bugs.c          |  2 +-
 arch/x86/kernel/cpu/common.c        |  2 +-
 arch/x86/kernel/fpu/bugs.c          |  2 +-
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/kernel/fpu/init.c          |  2 +-
 arch/x86/kernel/fpu/regset.c        |  2 +-
 arch/x86/kernel/fpu/xstate.c        |  1 -
 arch/x86/kernel/smpboot.c           |  2 +-
 arch/x86/kernel/traps.c             |  2 +-
 arch/x86/kvm/vmx/vmx.c              |  2 +-
 arch/x86/power/cpu.c                |  2 +-
 12 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 8df83e8..e69de29 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 1994 Linus Torvalds
- *
- * Pentium III FXSR, SSE support
- * General FPU state handling cleanups
- *	Gareth Hughes <gareth@valinux.com>, May 2000
- * x86-64 work by Andi Kleen 2002
- */
-
-#ifndef _ASM_X86_FPU_INTERNAL_H
-#define _ASM_X86_FPU_INTERNAL_H
-
-#include <linux/compat.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-
-#include <asm/user.h>
-#include <asm/fpu/api.h>
-#include <asm/fpu/xstate.h>
-#include <asm/fpu/xcr.h>
-#include <asm/cpufeature.h>
-#include <asm/trace/fpu.h>
-
-#endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ecfca3b..6c8a86b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -22,7 +22,7 @@
 #include <asm/bugs.h>
 #include <asm/processor.h>
 #include <asm/processor-flags.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b3410f1..486dc8c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -42,7 +42,7 @@
 #include <asm/setup.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/mtrr.h>
 #include <asm/hwcap2.h>
 #include <linux/numa.h>
diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index 2954fab..794e701 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -2,7 +2,7 @@
 /*
  * x86 FPU bug checks:
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 
 /*
  * Boot time CPU/FPU FDIV bug detection code:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7397288..9bb0c1c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -6,7 +6,7 @@
  *  General FPU state handling cleanups
  *	Gareth Hughes <gareth@valinux.com>, May 2000
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/sched.h>
 #include <asm/fpu/signal.h>
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index d420d29..2379135 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -2,7 +2,7 @@
 /*
  * x86 FPU boot time init code:
  */
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 3d8ed45..01a1d97 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -5,7 +5,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/vmalloc.h>
 
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f0305b2..b022df9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -13,7 +13,6 @@
 #include <linux/proc_fs.h>
 
 #include <asm/fpu/api.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e24..2577ed3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -70,7 +70,7 @@
 #include <asm/mwait.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/setup.h>
 #include <asm/uv/uv.h>
 #include <linux/mc146818rtc.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a588009..bae7582 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -48,7 +48,7 @@
 #include <asm/ftrace.h>
 #include <asm/traps.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/mce.h>
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 116b089..9a97927 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -35,7 +35,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/debugreg.h>
 #include <asm/desc.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 6665f88..9f2b251 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #include <asm/mce.h>
 #include <asm/suspend.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
