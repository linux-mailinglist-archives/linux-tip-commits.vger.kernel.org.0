Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46CD3D8B37
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhG1J6L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhG1J6K (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:10 -0400
Date:   Wed, 28 Jul 2021 09:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnihibDtoB6ak6U3BUGP8VotKBDVfd7qcx1ub838zOY=;
        b=3DRiuk9Z0mjWcLP/3gUqVuIWq0lyt1C5c0Ewj+CvIXxGMTdxn5/gzsniPHpOlVQcE25Enj
        CgUtas90iz0BnvfIRsJN4ZL021IHgiyCewyFm+vqwMdQtWxfOgxvVcrFesJn1OM30IEWPS
        T31Gh5O40UmmHmqO8RtFLSTHPrHlq8yEjhuiB67+d9k2T3ABhoEWhDOYY+vbS09uo46xxW
        7v1kxFhdo11QyqsTbg8i8RBSPphoypBZRjeCJ1ZXww1MkxxRNuPIWkZn7BONVBSmtWIFru
        x86ETqhB4yMJ5dQ2tJx5kIJnZY95+OrZJgqs7crpBiyX5SljqzPgOrKSzm/ysw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnihibDtoB6ak6U3BUGP8VotKBDVfd7qcx1ub838zOY=;
        b=6ctR7F7uAPmRCrufa0xJgi8uDP86i6EP2PRvq1TTIsKyXMCzKA8wx4U2wTua0udPYvHrLF
        E1/AsD8eLnbbL/AQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Prepare for opt-in based L1D flush in switch_mm()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628748.395.9010965350802211795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b5f06f64e269f9820cd5ad9e9a98afa6c8914b7a
Gitweb:        https://git.kernel.org/tip/b5f06f64e269f9820cd5ad9e9a98afa6c8914b7a
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Mon, 26 Apr 2021 21:42:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:24 +02:00

x86/mm: Prepare for opt-in based L1D flush in switch_mm()

The goal of this is to allow tasks that want to protect sensitive
information, against e.g. the recently found snoop assisted data sampling
vulnerabilites, to flush their L1D on being switched out.  This protects
their data from being snooped or leaked via side channels after the task
has context switched out.

This could also be used to wipe L1D when an untrusted task is switched in,
but that's not a really well defined scenario while the opt-in variant is
clearly defined.

The mechanism is default disabled and can be enabled on the kernel command
line.

Prepare for the actual prctl based opt-in:

  1) Provide the necessary setup functionality similar to the other
     mitigations and enable the static branch when the command line option
     is set and the CPU provides support for hardware assisted L1D
     flushing. Software based L1D flush is not supported because it's CPU
     model specific and not really well defined.

     This does not come with a sysfs file like the other mitigations
     because it is not bound to any specific vulnerability.

     Support has to be queried via the prctl(2) interface.

  2) Add TIF_SPEC_L1D_FLUSH next to L1D_SPEC_IB so the two bits can be
     mangled into the mm pointer in one go which allows to reuse the
     existing mechanism in switch_mm() for the conditional IBPB speculation
     barrier efficiently.

  3) Add the L1D flush specific functionality which flushes L1D when the
     outgoing task opted in.

     Also check whether the incoming task has requested L1D flush and if so
     validate that it is not accidentaly running on an SMT sibling as this
     makes the whole excercise moot because SMT siblings share L1D which
     opens tons of other attack vectors. If that happens schedule task work
     which signals the incoming task on return to user/guest with SIGBUS as
     this is part of the paranoid L1D flush contract.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-1-sblbir@amazon.com
---
 arch/x86/Kconfig                     |  1 +-
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/include/asm/thread_info.h   |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 37 +++++++++++++++++-
 arch/x86/mm/tlb.c                    | 58 ++++++++++++++++++++++++++-
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4927065..d8a2c3f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 3ad8c6d..ec2d5c8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -252,6 +252,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
+DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
+
 #include <asm/segment.h>
 
 /**
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d9afd35..cf13266 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,6 +81,7 @@ struct thread_info {
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -104,6 +105,7 @@ struct thread_info {
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70f..1a5a1b0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -43,6 +43,7 @@ static void __init mds_select_mitigation(void);
 static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init l1d_flush_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
 u64 x86_spec_ctrl_base;
@@ -76,6 +77,13 @@ EXPORT_SYMBOL_GPL(mds_user_clear);
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
 
+/*
+ * Controls whether l1d flush based mitigations are enabled,
+ * based on hw features and admin setting via boot parameter
+ * defaults to false
+ */
+DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -111,6 +119,7 @@ void __init check_bugs(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	srbds_select_mitigation();
+	l1d_flush_select_mitigation();
 
 	/*
 	 * As MDS and TAA mitigations are inter-related, print MDS
@@ -492,6 +501,34 @@ static int __init srbds_parse_cmdline(char *str)
 early_param("srbds", srbds_parse_cmdline);
 
 #undef pr_fmt
+#define pr_fmt(fmt)     "L1D Flush : " fmt
+
+enum l1d_flush_mitigations {
+	L1D_FLUSH_OFF = 0,
+	L1D_FLUSH_ON,
+};
+
+static enum l1d_flush_mitigations l1d_flush_mitigation __initdata = L1D_FLUSH_OFF;
+
+static void __init l1d_flush_select_mitigation(void)
+{
+	if (!l1d_flush_mitigation || !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return;
+
+	static_branch_enable(&switch_mm_cond_l1d_flush);
+	pr_info("Conditional flush on switch_mm() enabled\n");
+}
+
+static int __init l1d_flush_parse_cmdline(char *str)
+{
+	if (!strcmp(str, "on"))
+		l1d_flush_mitigation = L1D_FLUSH_ON;
+
+	return 0;
+}
+early_param("l1d_flush", l1d_flush_parse_cmdline);
+
+#undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V1 : " fmt
 
 enum spectre_v1_mitigation {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c98bc84..59ba296 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,11 +8,13 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/smt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
 
@@ -43,11 +45,12 @@
  */
 
 /*
- * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
  * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
-#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+#define LAST_USER_MM_L1D_FLUSH	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
 /* Bits to set when tlbstate and flush is (re)initialized */
 #define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
@@ -321,11 +324,52 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
+/*
+ * Invoked from return to user/guest by a task that opted-in to L1D
+ * flushing but ended up running on an SMT enabled core due to wrong
+ * affinity settings or CPU hotplug. This is part of the paranoid L1D flush
+ * contract which this task requested.
+ */
+static void l1d_flush_force_sigbus(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
+				struct task_struct *next)
+{
+	/* Flush L1D if the outgoing task requests it */
+	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+
+	/* Check whether the incoming task opted in for L1D flush */
+	if (likely(!(next_mm & LAST_USER_MM_L1D_FLUSH)))
+		return;
+
+	/*
+	 * Validate that it is not running on an SMT sibling as this would
+	 * make the excercise pointless because the siblings share L1D. If
+	 * it runs on a SMT sibling, notify it with SIGBUS on return to
+	 * user/guest
+	 */
+	if (this_cpu_read(cpu_info.smt_active)) {
+		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
+		next->l1d_flush_kill.func = l1d_flush_force_sigbus;
+		task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
+	}
+}
+
 static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	/*
+	 * Ensure that the bit shift above works as expected and the two flags
+	 * end up in bit 0 and 1.
+	 */
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
+
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -403,6 +447,16 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	if (static_branch_unlikely(&switch_mm_cond_l1d_flush)) {
+		/*
+		 * Flush L1D when the outgoing task requested it and/or
+		 * check whether the incoming task requested L1D flushing
+		 * and ended up on an SMT sibling.
+		 */
+		if (unlikely((prev_mm | next_mm) & LAST_USER_MM_L1D_FLUSH))
+			l1d_flush_evaluate(prev_mm, next_mm, next);
+	}
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
