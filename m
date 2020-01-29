Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48614CD4C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jan 2020 16:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgA2PYw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jan 2020 10:24:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgA2PYw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jan 2020 10:24:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwpCq-0002Zu-Rz; Wed, 29 Jan 2020 16:24:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0ADE71C1C19;
        Wed, 29 Jan 2020 16:24:40 +0100 (CET)
Date:   Wed, 29 Jan 2020 15:24:39 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/split_lock: Enable split lock detection by kernel
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
References: <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <158031147976.396.8941798847364718785.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fdbfb51ae760d1bba3f89e4fa00da83016ec4dbe
Gitweb:        https://git.kernel.org/tip/fdbfb51ae760d1bba3f89e4fa00da83016ec4dbe
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Sun, 26 Jan 2020 12:05:35 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 29 Jan 2020 13:42:39 +01:00

x86/split_lock: Enable split lock detection by kernel

A split-lock occurs when an atomic instruction operates on data that spans
two cache lines. In order to maintain atomicity the core takes a global bus
lock.

This is typically >1000 cycles slower than an atomic operation within a
cache line. It also disrupts performance on other cores (which must wait
for the bus lock to be released before their memory operations can
complete). For real-time systems this may mean missing deadlines. For other
systems it may just be very annoying.

Some CPUs have the capability to raise an #AC trap when a split lock is
attempted.

Provide a command line option to give the user choices on how to handle
this:

split_lock_detect=
	off	- not enabled (no traps for split locks)
	warn	- warn once when an application does a
		  split lock, but allow it to continue
		  running.
	fatal	- Send SIGBUS to applications that cause split lock

On systems that support split lock detection the default is "warn". Note
that if the kernel hits a split lock in any mode other than "off" it will
OOPs.

One implementation wrinkle is that the MSR to control the split lock
detection is per-core, not per thread. This might result in some short
lived races on HT systems in "warn" mode if Linux tries to enable on one
thread while disabling on the other. Race analysis by Sean Christopherson:

  - Toggling of split-lock is only done in "warn" mode.  Worst case
    scenario of a race is that a misbehaving task will generate multiple
    #AC exceptions on the same instruction.  And this race will only occur
    if both siblings are running tasks that generate split-lock #ACs, e.g.
    a race where sibling threads are writing different values will only
    occur if CPUx is disabling split-lock after an #AC and CPUy is
    re-enabling split-lock after *its* previous task generated an #AC.
  - Transitioning between off/warn/fatal modes at runtime isn't supported
    and disabling is tracked per task, so hardware will always reach a steady
    state that matches the configured mode.  I.e. split-lock is guaranteed to
    be enabled in hardware once all _TIF_SLD threads have been scheduled out.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200126200535.GB30377@agluck-desk2.amr.corp.intel.com

---
 Documentation/admin-guide/kernel-parameters.txt |  22 ++-
 arch/x86/include/asm/cpu.h                      |  12 +-
 arch/x86/include/asm/cpufeatures.h              |   2 +-
 arch/x86/include/asm/msr-index.h                |   9 +-
 arch/x86/include/asm/thread_info.h              |   4 +-
 arch/x86/kernel/cpu/common.c                    |   2 +-
 arch/x86/kernel/cpu/intel.c                     | 175 +++++++++++++++-
 arch/x86/kernel/process.c                       |   3 +-
 arch/x86/kernel/traps.c                         |  24 +-
 9 files changed, 250 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ec92120..87176a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4637,6 +4637,28 @@
 	spia_pedr=
 	spia_peddr=
 
+	split_lock_detect=
+			[X86] Enable split lock detection
+
+			When enabled (and if hardware support is present), atomic
+			instructions that access data across cache line
+			boundaries will result in an alignment check exception.
+
+			off	- not enabled
+
+			warn	- the kernel will emit rate limited warnings
+				  about applications triggering the #AC
+				  exception. This mode is the default on CPUs
+				  that supports split lock detection.
+
+			fatal	- the kernel will send SIGBUS to applications
+				  that trigger the #AC exception.
+
+			If an #AC exception is hit in the kernel or in
+			firmware (i.e. not while executing in user mode)
+			the kernel will oops in either "warn" or "fatal"
+			mode.
+
 	srcutree.counter_wrap_check [KNL]
 			Specifies how frequently to check for
 			grace-period sequence counter wrap for the
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc8..ff6f3ca 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,16 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_CPU_SUP_INTEL
+extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void switch_to_sld(unsigned long tifn);
+extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+#else
+static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void switch_to_sld(unsigned long tifn) {}
+static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	return false;
+}
+#endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb..cd56ad5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -285,6 +285,7 @@
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
@@ -367,6 +368,7 @@
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ebe1685..8821697 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,11 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
+#define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf43279..f807930 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,6 +92,7 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
+#define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
+#define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -145,7 +147,7 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\
-	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE | _TIF_SLD)
 
 /*
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 86b8241..adb2f63 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1242,6 +1242,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
+	cpu_set_core_cap_bits(c);
+
 	fpu__init_system(c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 57473e2..5d92e38 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,8 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cmdline.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -31,6 +33,19 @@
 #include <asm/apic.h>
 #endif
 
+enum split_lock_detect_state {
+	sld_off = 0,
+	sld_warn,
+	sld_fatal,
+};
+
+/*
+ * Default to sld_off because most systems do not support split lock detection
+ * split_lock_setup() will switch this to sld_warn on systems that support
+ * split lock detect, unless there is a command line override.
+ */
+static enum split_lock_detect_state sld_state = sld_off;
+
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
  * allow a way to override the automatic disabling of MPX.
@@ -606,6 +621,8 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
+static void split_lock_init(void);
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	early_init_intel(c);
@@ -720,6 +737,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_enable();
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+
+	split_lock_init();
 }
 
 #ifdef CONFIG_X86_32
@@ -981,3 +1000,159 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
+
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
+static const struct {
+	const char			*option;
+	enum split_lock_detect_state	state;
+} sld_options[] __initconst = {
+	{ "off",	sld_off   },
+	{ "warn",	sld_warn  },
+	{ "fatal",	sld_fatal },
+};
+
+static inline bool match_option(const char *arg, int arglen, const char *opt)
+{
+	int len = strlen(opt);
+
+	return len == arglen && !strncmp(arg, opt, len);
+}
+
+static void __init split_lock_setup(void)
+{
+	char arg[20];
+	int i, ret;
+
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+	sld_state = sld_warn;
+
+	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
+				  arg, sizeof(arg));
+	if (ret >= 0) {
+		for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
+			if (match_option(arg, ret, sld_options[i].option)) {
+				sld_state = sld_options[i].state;
+				break;
+			}
+		}
+	}
+
+	switch (sld_state) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+
+	case sld_warn:
+		pr_info("warning about user-space split_locks\n");
+		break;
+
+	case sld_fatal:
+		pr_info("sending SIGBUS on user-space split_locks\n");
+		break;
+	}
+}
+
+/*
+ * Locking is not required at the moment because only bit 29 of this
+ * MSR is implemented and locking would not prevent that the operation
+ * of one thread is immediately undone by the sibling thread.
+ * Use the "safe" versions of rdmsr/wrmsr here because although code
+ * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
+ * exist, there may be glitches in virtualization that leave a guest
+ * with an incorrect view of real h/w capabilities.
+ */
+static bool __sld_msr_set(bool on)
+{
+	u64 test_ctrl_val;
+
+	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
+		return false;
+
+	if (on)
+		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+	else
+		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+
+	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
+}
+
+static void split_lock_init(void)
+{
+	if (sld_state == sld_off)
+		return;
+
+	if (__sld_msr_set(true))
+		return;
+
+	/*
+	 * If this is anything other than the boot-cpu, you've done
+	 * funny things and you get to keep whatever pieces.
+	 */
+	pr_warn("MSR fail -- disabled\n");
+	sld_state = sld_off;
+}
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+
+	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+			    current->comm, current->pid, regs->ip);
+
+	/*
+	 * Disable the split lock detection for this task so it can make
+	 * progress and set TIF_SLD so the detection is re-enabled via
+	 * switch_to_sld() when the task is scheduled out.
+	 */
+	__sld_msr_set(false);
+	set_tsk_thread_flag(current, TIF_SLD);
+	return true;
+}
+
+/*
+ * This function is called only when switching between tasks with
+ * different split-lock detection modes. It sets the MSR for the
+ * mode of the new task. This is right most of the time, but since
+ * the MSR is shared by hyperthreads on a physical core there can
+ * be glitches when the two threads need different modes.
+ */
+void switch_to_sld(unsigned long tifn)
+{
+	__sld_msr_set(!(tifn & _TIF_SLD));
+}
+
+#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
+
+/*
+ * The following processors have the split lock detection feature. But
+ * since they don't have the IA32_CORE_CAPABILITIES MSR, the feature cannot
+ * be enumerated. Enable it by family and model matching on these
+ * processors.
+ */
+static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	{}
+};
+
+void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+{
+	u64 ia32_core_caps = 0;
+
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return;
+	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
+		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		/* Enumerate split lock detection by family and model. */
+		if (x86_match_cpu(split_lock_cpu_ids))
+			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
+	}
+
+	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
+		split_lock_setup();
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 839b524..a43c328 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -650,6 +650,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		/* Enforce MSR update to ensure consistent state */
 		__speculation_ctrl_update(~tifn, tifn);
 	}
+
+	if ((tifp ^ tifn) & _TIF_SLD)
+		switch_to_sld(tifn);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9e6f822..9f42f0a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -46,6 +46,7 @@
 #include <asm/traps.h>
 #include <asm/desc.h>
 #include <asm/fpu/internal.h>
+#include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/mce.h>
 #include <asm/fixmap.h>
@@ -244,7 +245,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 {
 	struct task_struct *tsk = current;
 
-
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
 
@@ -290,9 +290,29 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	char *str = "alignment check";
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
+		return;
+
+	if (!user_mode(regs))
+		die("Split lock detected\n", regs, error_code);
+
+	local_irq_enable();
+
+	if (handle_user_split_lock(regs, error_code))
+		return;
+
+	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
+		error_code, BUS_ADRALN, NULL);
+}
+
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
