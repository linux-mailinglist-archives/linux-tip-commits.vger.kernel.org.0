Return-Path: <linux-tip-commits+bounces-2024-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3C94C24A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700AF1C21F1D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A84190041;
	Thu,  8 Aug 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j911YKRI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwdzkZkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950981723;
	Thu,  8 Aug 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133245; cv=none; b=SbdkL2syT8ftcVBJnEN0zi/b8Or83rJnjNgV2/8vbxgjHp6DSAUeCq7wXVsduvhxUhWudUq92SRx46DNqpvaQRDZ3sZHYskWUpMB6/2rx2AbDwL8RZv83013xMeUcuYcF4W3U6XBXKTUDR9y/EBREtz4p96fNg1Y85Ndn2LVDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133245; c=relaxed/simple;
	bh=4UE8GNUFQN+6eAKcsgV/aCcOmyjTYgoG5maoYXODNVA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DRQxjAqHX+Pe573hvMcD6dBD/rtMATJ+FFLxlzwOvoQgzj4jN6/PkX8o5NdAAuQngZUrp/CeCoWYZwwUfbJ0Cf3ZYNWwZwo5WY9DcmQjLlBFQnXUmeUdXxb+9BPfrrozjPQ5P62wJrSpEv7ZRUNn3gA7NKNnMNP7kOHdHBdDBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j911YKRI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwdzkZkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 16:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723133241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSNa4FgSSkham/sjLvHvKjr0055tnZan/aUD91lpTvU=;
	b=j911YKRITCQS0KFxepC1CiK9BrzmsnMaiCvzlU9i3s8jhBsMKnHRGdMgJ13o3KDU//ltd8
	NeY05nt5EKeeQzqppIgxX7reB6EKWFXz+GkwjxAIjcFZ3O+IPz/SQI/z03U8zjpCd7Vzhk
	G93ULOZZvfbhJTcGTdgeMrEV4D4xaFkYvbDx6DWQmWlbvq2NEAgYeADAzmHw2BvgGRuIRy
	erMPqmqVhWHrT8ng3HOSELdQIjg45lzep/9pYNbFR24s+suMTDlvxLvA7v/mcbv6K64CQT
	LHIeUISbbzSIuFjG2G0LwqX2QSNQQz1nrAGUNxoGOeER5dI3i0hQdrkVWKBZ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723133241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSNa4FgSSkham/sjLvHvKjr0055tnZan/aUD91lpTvU=;
	b=lwdzkZkKFaNb3LIz0rXMvdLnWXaHTgx3ZPvkyoZFi3lcNi9bxcapzloz47dsQ0BZbpcgMq
	Kuytm5Gs+RoLOdAw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/split_lock: Move Split and Bus lock code to
 a dedicated file
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240808062937.1149-2-ravi.bangoria@amd.com>
References: <20240808062937.1149-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313324133.2215.16928323785605442856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     350afa8a1101f62ce31bc4ed6f69cf4b90ec4fa2
Gitweb:        https://git.kernel.org/tip/350afa8a1101f62ce31bc4ed6f69cf4b90ec4fa2
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Thu, 08 Aug 2024 06:29:34 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 18:02:15 +02:00

x86/split_lock: Move Split and Bus lock code to a dedicated file

Bus Lock Detect functionality on AMD platforms works identical to Intel.

Move split_lock and bus_lock specific code from intel.c to a dedicated
file so that it can be compiled and supported on non-Intel platforms.

Also, introduce CONFIG_X86_BUS_LOCK_DETECT, make it dependent on
CONFIG_CPU_SUP_INTEL and add compilation dependency of the new bus_lock.c
file on CONFIG_X86_BUS_LOCK_DETECT.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/all/20240808062937.1149-2-ravi.bangoria@amd.com

---
 arch/x86/Kconfig               |   8 +-
 arch/x86/include/asm/cpu.h     |  11 +-
 arch/x86/kernel/cpu/Makefile   |   2 +-
 arch/x86/kernel/cpu/bus_lock.c | 406 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/intel.c    | 406 +--------------------------------
 include/linux/sched.h          |   2 +-
 kernel/fork.c                  |   2 +-
 7 files changed, 427 insertions(+), 410 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/bus_lock.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9..9c4e69a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2426,6 +2426,14 @@ config CFI_AUTO_DEFAULT
 
 source "kernel/livepatch/Kconfig"
 
+config X86_BUS_LOCK_DETECT
+	bool "Split Lock Detect and Bus Lock Detect support"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable Split Lock Detect and Bus Lock Detect functionalities.
+	  See <file:Documentation/arch/x86/buslock.rst> for more information.
+
 endmenu
 
 config CC_HAS_NAMED_AS
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8..86cf795 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -26,12 +26,13 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
-#ifdef CONFIG_CPU_SUP_INTEL
+#ifdef CONFIG_X86_BUS_LOCK_DETECT
 extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
-u8 get_this_hybrid_cpu_type(void);
+void split_lock_init(void);
+void bus_lock_init(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -45,7 +46,13 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 }
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
+static inline void split_lock_init(void) {}
+static inline void bus_lock_init(void) {}
+#endif
 
+#ifdef CONFIG_CPU_SUP_INTEL
+u8 get_this_hybrid_cpu_type(void);
+#else
 static inline u8 get_this_hybrid_cpu_type(void)
 {
 	return 0;
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5857a0f..4efdf5c 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -59,6 +59,8 @@ obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 obj-$(CONFIG_DEBUG_FS)			+= debugfs.o
 
+obj-$(CONFIG_X86_BUS_LOCK_DETECT)	+= bus_lock.o
+
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(src)/mkcapflags.sh $@ $^
 
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
new file mode 100644
index 0000000..704e924
--- /dev/null
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
+#include <linux/semaphore.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/cpuhotplug.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cmdline.h>
+#include <asm/traps.h>
+#include <asm/cpu.h>
+
+enum split_lock_detect_state {
+	sld_off = 0,
+	sld_warn,
+	sld_fatal,
+	sld_ratelimit,
+};
+
+/*
+ * Default to sld_off because most systems do not support split lock detection.
+ * sld_state_setup() will switch this to sld_warn on systems that support
+ * split lock/bus lock detect, unless there is a command line override.
+ */
+static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
+static u64 msr_test_ctrl_cache __ro_after_init;
+
+/*
+ * With a name like MSR_TEST_CTL it should go without saying, but don't touch
+ * MSR_TEST_CTL unless the CPU is one of the whitelisted models.  Writing it
+ * on CPUs that do not support SLD can cause fireworks, even when writing '0'.
+ */
+static bool cpu_model_supports_sld __ro_after_init;
+
+static const struct {
+	const char			*option;
+	enum split_lock_detect_state	state;
+} sld_options[] __initconst = {
+	{ "off",	sld_off   },
+	{ "warn",	sld_warn  },
+	{ "fatal",	sld_fatal },
+	{ "ratelimit:", sld_ratelimit },
+};
+
+static struct ratelimit_state bld_ratelimit;
+
+static unsigned int sysctl_sld_mitigate = 1;
+static DEFINE_SEMAPHORE(buslock_sem, 1);
+
+#ifdef CONFIG_PROC_SYSCTL
+static struct ctl_table sld_sysctls[] = {
+	{
+		.procname       = "split_lock_mitigate",
+		.data           = &sysctl_sld_mitigate,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+};
+
+static int __init sld_mitigate_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sld_sysctls);
+	return 0;
+}
+
+late_initcall(sld_mitigate_sysctl_init);
+#endif
+
+static inline bool match_option(const char *arg, int arglen, const char *opt)
+{
+	int len = strlen(opt), ratelimit;
+
+	if (strncmp(arg, opt, len))
+		return false;
+
+	/*
+	 * Min ratelimit is 1 bus lock/sec.
+	 * Max ratelimit is 1000 bus locks/sec.
+	 */
+	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 &&
+	    ratelimit > 0 && ratelimit <= 1000) {
+		ratelimit_state_init(&bld_ratelimit, HZ, ratelimit);
+		ratelimit_set_flags(&bld_ratelimit, RATELIMIT_MSG_ON_RELEASE);
+		return true;
+	}
+
+	return len == arglen;
+}
+
+static bool split_lock_verify_msr(bool on)
+{
+	u64 ctrl, tmp;
+
+	if (rdmsrl_safe(MSR_TEST_CTRL, &ctrl))
+		return false;
+	if (on)
+		ctrl |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+	else
+		ctrl &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+	if (wrmsrl_safe(MSR_TEST_CTRL, ctrl))
+		return false;
+	rdmsrl(MSR_TEST_CTRL, tmp);
+	return ctrl == tmp;
+}
+
+static void __init sld_state_setup(void)
+{
+	enum split_lock_detect_state state = sld_warn;
+	char arg[20];
+	int i, ret;
+
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		return;
+
+	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
+				  arg, sizeof(arg));
+	if (ret >= 0) {
+		for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
+			if (match_option(arg, ret, sld_options[i].option)) {
+				state = sld_options[i].state;
+				break;
+			}
+		}
+	}
+	sld_state = state;
+}
+
+static void __init __split_lock_setup(void)
+{
+	if (!split_lock_verify_msr(false)) {
+		pr_info("MSR access failed: Disabled\n");
+		return;
+	}
+
+	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
+	if (!split_lock_verify_msr(true)) {
+		pr_info("MSR access failed: Disabled\n");
+		return;
+	}
+
+	/* Restore the MSR to its cached value. */
+	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+}
+
+/*
+ * MSR_TEST_CTRL is per core, but we treat it like a per CPU MSR. Locking
+ * is not implemented as one thread could undo the setting of the other
+ * thread immediately after dropping the lock anyway.
+ */
+static void sld_update_msr(bool on)
+{
+	u64 test_ctrl_val = msr_test_ctrl_cache;
+
+	if (on)
+		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+
+	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
+}
+
+void split_lock_init(void)
+{
+	/*
+	 * #DB for bus lock handles ratelimit and #AC for split lock is
+	 * disabled.
+	 */
+	if (sld_state == sld_ratelimit) {
+		split_lock_verify_msr(false);
+		return;
+	}
+
+	if (cpu_model_supports_sld)
+		split_lock_verify_msr(sld_state != sld_off);
+}
+
+static void __split_lock_reenable_unlock(struct work_struct *work)
+{
+	sld_update_msr(true);
+	up(&buslock_sem);
+}
+
+static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock);
+
+static void __split_lock_reenable(struct work_struct *work)
+{
+	sld_update_msr(true);
+}
+static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+
+/*
+ * If a CPU goes offline with pending delayed work to re-enable split lock
+ * detection then the delayed work will be executed on some other CPU. That
+ * handles releasing the buslock_sem, but because it executes on a
+ * different CPU probably won't re-enable split lock detection. This is a
+ * problem on HT systems since the sibling CPU on the same core may then be
+ * left running with split lock detection disabled.
+ *
+ * Unconditionally re-enable detection here.
+ */
+static int splitlock_cpu_offline(unsigned int cpu)
+{
+	sld_update_msr(true);
+
+	return 0;
+}
+
+static void split_lock_warn(unsigned long ip)
+{
+	struct delayed_work *work;
+	int cpu;
+
+	if (!current->reported_split_lock)
+		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid, ip);
+	current->reported_split_lock = 1;
+
+	if (sysctl_sld_mitigate) {
+		/*
+		 * misery factor #1:
+		 * sleep 10ms before trying to execute split lock.
+		 */
+		if (msleep_interruptible(10) > 0)
+			return;
+		/*
+		 * Misery factor #2:
+		 * only allow one buslocked disabled core at a time.
+		 */
+		if (down_interruptible(&buslock_sem) == -EINTR)
+			return;
+		work = &sl_reenable_unlock;
+	} else {
+		work = &sl_reenable;
+	}
+
+	cpu = get_cpu();
+	schedule_delayed_work_on(cpu, work, 2);
+
+	/* Disable split lock detection on this CPU to make progress */
+	sld_update_msr(false);
+	put_cpu();
+}
+
+bool handle_guest_split_lock(unsigned long ip)
+{
+	if (sld_state == sld_warn) {
+		split_lock_warn(ip);
+		return true;
+	}
+
+	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
+		     current->comm, current->pid,
+		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
+
+	current->thread.error_code = 0;
+	current->thread.trap_nr = X86_TRAP_AC;
+	force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
+	return false;
+}
+EXPORT_SYMBOL_GPL(handle_guest_split_lock);
+
+void bus_lock_init(void)
+{
+	u64 val;
+
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		return;
+
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+
+	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off) {
+		/*
+		 * Warn and fatal are handled by #AC for split lock if #AC for
+		 * split lock is supported.
+		 */
+		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	} else {
+		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	}
+
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+}
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+	split_lock_warn(regs->ip);
+	return true;
+}
+
+void handle_bus_lock(struct pt_regs *regs)
+{
+	switch (sld_state) {
+	case sld_off:
+		break;
+	case sld_ratelimit:
+		/* Enforce no more than bld_ratelimit bus locks/sec. */
+		while (!__ratelimit(&bld_ratelimit))
+			msleep(20);
+		/* Warn on the bus lock. */
+		fallthrough;
+	case sld_warn:
+		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid, regs->ip);
+		break;
+	case sld_fatal:
+		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
+		break;
+	}
+}
+
+/*
+ * CPU models that are known to have the per-core split-lock detection
+ * feature even though they do not enumerate IA32_CORE_CAPABILITIES.
+ */
+static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
+	X86_MATCH_VFM(INTEL_ICELAKE_X,	0),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,	0),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,	0),
+	{}
+};
+
+static void __init split_lock_setup(struct cpuinfo_x86 *c)
+{
+	const struct x86_cpu_id *m;
+	u64 ia32_core_caps;
+
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
+	/* Check for CPUs that have support but do not enumerate it: */
+	m = x86_match_cpu(split_lock_cpu_ids);
+	if (m)
+		goto supported;
+
+	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
+		return;
+
+	/*
+	 * Not all bits in MSR_IA32_CORE_CAPS are architectural, but
+	 * MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT is.  All CPUs that set
+	 * it have split lock detection.
+	 */
+	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
+		goto supported;
+
+	/* CPU is not in the model list and does not have the MSR bit: */
+	return;
+
+supported:
+	cpu_model_supports_sld = true;
+	__split_lock_setup();
+}
+
+static void sld_state_show(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return;
+
+	switch (sld_state) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+	case sld_warn:
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
+			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
+			if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					      "x86/splitlock", NULL, splitlock_cpu_offline) < 0)
+				pr_warn("No splitlock CPU offline handler\n");
+		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
+			pr_info("#DB: warning on user-space bus_locks\n");
+		}
+		break;
+	case sld_fatal:
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
+			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
+		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
+			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n",
+				boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ?
+				" from non-WB" : "");
+		}
+		break;
+	case sld_ratelimit:
+		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: setting system wide bus lock rate limit to %u/sec\n", bld_ratelimit.burst);
+		break;
+	}
+}
+
+void __init sld_setup(struct cpuinfo_x86 *c)
+{
+	split_lock_setup(c);
+	sld_state_setup();
+	sld_state_show();
+}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 08b95a3..8a483f4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -7,13 +7,9 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/semaphore.h>
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
-#include <linux/workqueue.h>
-#include <linux/delay.h>
-#include <linux/cpuhotplug.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -24,8 +20,6 @@
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
-#include <asm/cmdline.h>
-#include <asm/traps.h>
 #include <asm/resctrl.h>
 #include <asm/numa.h>
 #include <asm/thermal.h>
@@ -41,28 +35,6 @@
 #include <asm/apic.h>
 #endif
 
-enum split_lock_detect_state {
-	sld_off = 0,
-	sld_warn,
-	sld_fatal,
-	sld_ratelimit,
-};
-
-/*
- * Default to sld_off because most systems do not support split lock detection.
- * sld_state_setup() will switch this to sld_warn on systems that support
- * split lock/bus lock detect, unless there is a command line override.
- */
-static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
-static u64 msr_test_ctrl_cache __ro_after_init;
-
-/*
- * With a name like MSR_TEST_CTL it should go without saying, but don't touch
- * MSR_TEST_CTL unless the CPU is one of the whitelisted models.  Writing it
- * on CPUs that do not support SLD can cause fireworks, even when writing '0'.
- */
-static bool cpu_model_supports_sld __ro_after_init;
-
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
@@ -547,9 +519,6 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
-static void split_lock_init(void);
-static void bus_lock_init(void);
-
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	early_init_intel(c);
@@ -907,381 +876,6 @@ static const struct cpu_dev intel_cpu_dev = {
 
 cpu_dev_register(intel_cpu_dev);
 
-#undef pr_fmt
-#define pr_fmt(fmt) "x86/split lock detection: " fmt
-
-static const struct {
-	const char			*option;
-	enum split_lock_detect_state	state;
-} sld_options[] __initconst = {
-	{ "off",	sld_off   },
-	{ "warn",	sld_warn  },
-	{ "fatal",	sld_fatal },
-	{ "ratelimit:", sld_ratelimit },
-};
-
-static struct ratelimit_state bld_ratelimit;
-
-static unsigned int sysctl_sld_mitigate = 1;
-static DEFINE_SEMAPHORE(buslock_sem, 1);
-
-#ifdef CONFIG_PROC_SYSCTL
-static struct ctl_table sld_sysctls[] = {
-	{
-		.procname       = "split_lock_mitigate",
-		.data           = &sysctl_sld_mitigate,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
-	},
-};
-
-static int __init sld_mitigate_sysctl_init(void)
-{
-	register_sysctl_init("kernel", sld_sysctls);
-	return 0;
-}
-
-late_initcall(sld_mitigate_sysctl_init);
-#endif
-
-static inline bool match_option(const char *arg, int arglen, const char *opt)
-{
-	int len = strlen(opt), ratelimit;
-
-	if (strncmp(arg, opt, len))
-		return false;
-
-	/*
-	 * Min ratelimit is 1 bus lock/sec.
-	 * Max ratelimit is 1000 bus locks/sec.
-	 */
-	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 &&
-	    ratelimit > 0 && ratelimit <= 1000) {
-		ratelimit_state_init(&bld_ratelimit, HZ, ratelimit);
-		ratelimit_set_flags(&bld_ratelimit, RATELIMIT_MSG_ON_RELEASE);
-		return true;
-	}
-
-	return len == arglen;
-}
-
-static bool split_lock_verify_msr(bool on)
-{
-	u64 ctrl, tmp;
-
-	if (rdmsrl_safe(MSR_TEST_CTRL, &ctrl))
-		return false;
-	if (on)
-		ctrl |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
-	else
-		ctrl &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
-	if (wrmsrl_safe(MSR_TEST_CTRL, ctrl))
-		return false;
-	rdmsrl(MSR_TEST_CTRL, tmp);
-	return ctrl == tmp;
-}
-
-static void __init sld_state_setup(void)
-{
-	enum split_lock_detect_state state = sld_warn;
-	char arg[20];
-	int i, ret;
-
-	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
-	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-		return;
-
-	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
-				  arg, sizeof(arg));
-	if (ret >= 0) {
-		for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
-			if (match_option(arg, ret, sld_options[i].option)) {
-				state = sld_options[i].state;
-				break;
-			}
-		}
-	}
-	sld_state = state;
-}
-
-static void __init __split_lock_setup(void)
-{
-	if (!split_lock_verify_msr(false)) {
-		pr_info("MSR access failed: Disabled\n");
-		return;
-	}
-
-	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
-
-	if (!split_lock_verify_msr(true)) {
-		pr_info("MSR access failed: Disabled\n");
-		return;
-	}
-
-	/* Restore the MSR to its cached value. */
-	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
-
-	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
-}
-
-/*
- * MSR_TEST_CTRL is per core, but we treat it like a per CPU MSR. Locking
- * is not implemented as one thread could undo the setting of the other
- * thread immediately after dropping the lock anyway.
- */
-static void sld_update_msr(bool on)
-{
-	u64 test_ctrl_val = msr_test_ctrl_cache;
-
-	if (on)
-		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
-
-	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
-}
-
-static void split_lock_init(void)
-{
-	/*
-	 * #DB for bus lock handles ratelimit and #AC for split lock is
-	 * disabled.
-	 */
-	if (sld_state == sld_ratelimit) {
-		split_lock_verify_msr(false);
-		return;
-	}
-
-	if (cpu_model_supports_sld)
-		split_lock_verify_msr(sld_state != sld_off);
-}
-
-static void __split_lock_reenable_unlock(struct work_struct *work)
-{
-	sld_update_msr(true);
-	up(&buslock_sem);
-}
-
-static DECLARE_DELAYED_WORK(sl_reenable_unlock, __split_lock_reenable_unlock);
-
-static void __split_lock_reenable(struct work_struct *work)
-{
-	sld_update_msr(true);
-}
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
-
-/*
- * If a CPU goes offline with pending delayed work to re-enable split lock
- * detection then the delayed work will be executed on some other CPU. That
- * handles releasing the buslock_sem, but because it executes on a
- * different CPU probably won't re-enable split lock detection. This is a
- * problem on HT systems since the sibling CPU on the same core may then be
- * left running with split lock detection disabled.
- *
- * Unconditionally re-enable detection here.
- */
-static int splitlock_cpu_offline(unsigned int cpu)
-{
-	sld_update_msr(true);
-
-	return 0;
-}
-
-static void split_lock_warn(unsigned long ip)
-{
-	struct delayed_work *work;
-	int cpu;
-
-	if (!current->reported_split_lock)
-		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-				    current->comm, current->pid, ip);
-	current->reported_split_lock = 1;
-
-	if (sysctl_sld_mitigate) {
-		/*
-		 * misery factor #1:
-		 * sleep 10ms before trying to execute split lock.
-		 */
-		if (msleep_interruptible(10) > 0)
-			return;
-		/*
-		 * Misery factor #2:
-		 * only allow one buslocked disabled core at a time.
-		 */
-		if (down_interruptible(&buslock_sem) == -EINTR)
-			return;
-		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
-	}
-
-	cpu = get_cpu();
-	schedule_delayed_work_on(cpu, work, 2);
-
-	/* Disable split lock detection on this CPU to make progress */
-	sld_update_msr(false);
-	put_cpu();
-}
-
-bool handle_guest_split_lock(unsigned long ip)
-{
-	if (sld_state == sld_warn) {
-		split_lock_warn(ip);
-		return true;
-	}
-
-	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
-		     current->comm, current->pid,
-		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
-
-	current->thread.error_code = 0;
-	current->thread.trap_nr = X86_TRAP_AC;
-	force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
-	return false;
-}
-EXPORT_SYMBOL_GPL(handle_guest_split_lock);
-
-static void bus_lock_init(void)
-{
-	u64 val;
-
-	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-		return;
-
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
-
-	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
-	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
-	    sld_state == sld_off) {
-		/*
-		 * Warn and fatal are handled by #AC for split lock if #AC for
-		 * split lock is supported.
-		 */
-		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
-	} else {
-		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
-	}
-
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
-}
-
-bool handle_user_split_lock(struct pt_regs *regs, long error_code)
-{
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
-		return false;
-	split_lock_warn(regs->ip);
-	return true;
-}
-
-void handle_bus_lock(struct pt_regs *regs)
-{
-	switch (sld_state) {
-	case sld_off:
-		break;
-	case sld_ratelimit:
-		/* Enforce no more than bld_ratelimit bus locks/sec. */
-		while (!__ratelimit(&bld_ratelimit))
-			msleep(20);
-		/* Warn on the bus lock. */
-		fallthrough;
-	case sld_warn:
-		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
-				    current->comm, current->pid, regs->ip);
-		break;
-	case sld_fatal:
-		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
-		break;
-	}
-}
-
-/*
- * CPU models that are known to have the per-core split-lock detection
- * feature even though they do not enumerate IA32_CORE_CAPABILITIES.
- */
-static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	X86_MATCH_VFM(INTEL_ICELAKE_X,	0),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,	0),
-	X86_MATCH_VFM(INTEL_ICELAKE_D,	0),
-	{}
-};
-
-static void __init split_lock_setup(struct cpuinfo_x86 *c)
-{
-	const struct x86_cpu_id *m;
-	u64 ia32_core_caps;
-
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return;
-
-	/* Check for CPUs that have support but do not enumerate it: */
-	m = x86_match_cpu(split_lock_cpu_ids);
-	if (m)
-		goto supported;
-
-	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
-		return;
-
-	/*
-	 * Not all bits in MSR_IA32_CORE_CAPS are architectural, but
-	 * MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT is.  All CPUs that set
-	 * it have split lock detection.
-	 */
-	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
-		goto supported;
-
-	/* CPU is not in the model list and does not have the MSR bit: */
-	return;
-
-supported:
-	cpu_model_supports_sld = true;
-	__split_lock_setup();
-}
-
-static void sld_state_show(void)
-{
-	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
-	    !boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
-		return;
-
-	switch (sld_state) {
-	case sld_off:
-		pr_info("disabled\n");
-		break;
-	case sld_warn:
-		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
-			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
-			if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
-					      "x86/splitlock", NULL, splitlock_cpu_offline) < 0)
-				pr_warn("No splitlock CPU offline handler\n");
-		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
-			pr_info("#DB: warning on user-space bus_locks\n");
-		}
-		break;
-	case sld_fatal:
-		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
-			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
-		} else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT)) {
-			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n",
-				boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ?
-				" from non-WB" : "");
-		}
-		break;
-	case sld_ratelimit:
-		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-			pr_info("#DB: setting system wide bus lock rate limit to %u/sec\n", bld_ratelimit.burst);
-		break;
-	}
-}
-
-void __init sld_setup(struct cpuinfo_x86 *c)
-{
-	split_lock_setup(c);
-	sld_state_setup();
-	sld_state_show();
-}
-
 #define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
 
 /**
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d1503..d606b2a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -976,7 +976,7 @@ struct task_struct {
 #ifdef CONFIG_ARCH_HAS_CPU_PASID
 	unsigned			pasid_activated:1;
 #endif
-#ifdef	CONFIG_CPU_SUP_INTEL
+#ifdef CONFIG_X86_BUS_LOCK_DETECT
 	unsigned			reported_split_lock:1;
 #endif
 #ifdef CONFIG_TASK_DELAY_ACCT
diff --git a/kernel/fork.c b/kernel/fork.c
index cc76049..7f1f3dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1182,7 +1182,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->active_memcg = NULL;
 #endif
 
-#ifdef CONFIG_CPU_SUP_INTEL
+#ifdef CONFIG_X86_BUS_LOCK_DETECT
 	tsk->reported_split_lock = 0;
 #endif
 

