Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0734BF5B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC1VdE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 17:33:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39706 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhC1Vch (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 17:32:37 -0400
Date:   Sun, 28 Mar 2021 21:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EttrXKKJIIV8WwATeqXRdCyBwwtwEt9twIMqjtWZEVo=;
        b=Bk5sPgAJbeSh8kujzzYNc0EnSB4sX5Y8+E+7u0verdxK5bH0NFVAYf+72qn36zWgw/xPML
        X4Xzw/oJFyEX1su5cACNlyiRiuVrnNwPWWrDVo5Qn9d09Nh9v/0P0MPSVuGfJGUSLeBNnH
        V7oxdh/rPQDJ3CnMbQ4tx1u+2q9U8CGtmR4ENV7QLBA7Hyax3UlMb6y/hAXBIW/YMzSyav
        Nurmbs7z1PD5qYNwk/4coNYVxu3AsOUo957tvcmL4q6LAGFAYCOkxtZEHjU2XRPVDkuIkg
        XavG3ojAiA7R6sG1ViGTGt6MQzLwvDm7po/Lq2Do0FLbqA26v2ehtmqCrSEoYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EttrXKKJIIV8WwATeqXRdCyBwwtwEt9twIMqjtWZEVo=;
        b=myLlg9WOnSCbUOFAaef5v7KMBTxQzrCSbKyvxHA2jyOYY67VDe2SC7CjtXfX0K2PNa+UGO
        kBwt+b3nnp7cBqBA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/traps: Handle #DB for bus lock
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322135325.682257-3-fenghua.yu@intel.com>
References: <20210322135325.682257-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <161696715606.398.8416000398049877626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     ebb1064e7c2e90b56e4d40ab154ef9796060a1c3
Gitweb:        https://git.kernel.org/tip/ebb1064e7c2e90b56e4d40ab154ef9796060a1c3
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 22 Mar 2021 13:53:24 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 22:52:15 +02:00

x86/traps: Handle #DB for bus lock

Bus locks degrade performance for the whole system, not just for the CPU
that requested the bus lock. Two CPU features "#AC for split lock" and
"#DB for bus lock" provide hooks so that the operating system may choose
one of several mitigation strategies.

#AC for split lock is already implemented. Add code to use the #DB for
bus lock feature to cover additional situations with new options to
mitigate.

split_lock_detect=
		#AC for split lock		#DB for bus lock

off		Do nothing			Do nothing

warn		Kernel OOPs			Warn once per task and
		Warn once per task and		and continues to run.
		disable future checking
	 	When both features are
		supported, warn in #AC

fatal		Kernel OOPs			Send SIGBUS to user.
		Send SIGBUS to user
		When both features are
		supported, fatal in #AC

ratelimit:N	Do nothing			Limit bus lock rate to
						N per second in the
						current non-root user.

Default option is "warn".

Hardware only generates #DB for bus lock detect when CPL>0 to avoid
nested #DB from multiple bus locks while the first #DB is being handled.
So no need to handle #DB for bus lock detected in the kernel.

#DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL MSR
while #AC for split lock is enabled by split lock detection bit 29 in
TEST_CTRL MSR.

Both breakpoint and bus lock in the same instruction can trigger one #DB.
The bus lock is handled before the breakpoint in the #DB handler.

Delivery of #DB for bus lock in userspace clears DR6[11], which is set by
the #DB handler right after reading DR6.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210322135325.682257-3-fenghua.yu@intel.com

---
 arch/x86/include/asm/cpu.h           |   7 +-
 arch/x86/include/asm/msr-index.h     |   1 +-
 arch/x86/include/uapi/asm/debugreg.h |   1 +-
 arch/x86/kernel/cpu/common.c         |   2 +-
 arch/x86/kernel/cpu/intel.c          | 111 +++++++++++++++++++++-----
 arch/x86/kernel/traps.c              |   4 +-
 6 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccb..0d7fc0e 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -41,12 +41,13 @@ unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_CPU_SUP_INTEL
-extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+extern void handle_bus_lock(struct pt_regs *regs);
 #else
-static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
@@ -57,6 +58,8 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline void handle_bus_lock(struct pt_regs *regs) {}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ec..32c496f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -265,6 +265,7 @@
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index d95d080..0007ba0 100644
--- a/arch/x86/include/uapi/asm/debugreg.h
+++ b/arch/x86/include/uapi/asm/debugreg.h
@@ -24,6 +24,7 @@
 #define DR_TRAP3	(0x8)		/* db3 */
 #define DR_TRAP_BITS	(DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)
 
+#define DR_BUS_LOCK	(0x800)		/* bus_lock */
 #define DR_STEP		(0x4000)	/* single-step */
 #define DR_SWITCH	(0x8000)	/* task switch */
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640ab..1a4e260 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1330,7 +1330,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
-	cpu_set_core_cap_bits(c);
+	sld_setup(c);
 
 	fpu__init_system(c);
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a5..e25e52b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -44,9 +44,9 @@ enum split_lock_detect_state {
 };
 
 /*
- * Default to sld_off because most systems do not support split lock detection
- * split_lock_setup() will switch this to sld_warn on systems that support
- * split lock detect, unless there is a command line override.
+ * Default to sld_off because most systems do not support split lock detection.
+ * sld_state_setup() will switch this to sld_warn on systems that support
+ * split lock/bus lock detect, unless there is a command line override.
  */
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
 static u64 msr_test_ctrl_cache __ro_after_init;
@@ -603,6 +603,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 }
 
 static void split_lock_init(void);
+static void bus_lock_init(void);
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
@@ -720,6 +721,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_disable();
 
 	split_lock_init();
+	bus_lock_init();
 
 	intel_init_thermal(c);
 }
@@ -1020,16 +1022,15 @@ static bool split_lock_verify_msr(bool on)
 	return ctrl == tmp;
 }
 
-static void __init split_lock_setup(void)
+static void __init sld_state_setup(void)
 {
 	enum split_lock_detect_state state = sld_warn;
 	char arg[20];
 	int i, ret;
 
-	if (!split_lock_verify_msr(false)) {
-		pr_info("MSR access failed: Disabled\n");
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
-	}
 
 	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
 				  arg, sizeof(arg));
@@ -1041,17 +1042,14 @@ static void __init split_lock_setup(void)
 			}
 		}
 	}
+	sld_state = state;
+}
 
-	switch (state) {
-	case sld_off:
-		pr_info("disabled\n");
+static void __init __split_lock_setup(void)
+{
+	if (!split_lock_verify_msr(false)) {
+		pr_info("MSR access failed: Disabled\n");
 		return;
-	case sld_warn:
-		pr_info("warning about user-space split_locks\n");
-		break;
-	case sld_fatal:
-		pr_info("sending SIGBUS on user-space split_locks\n");
-		break;
 	}
 
 	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
@@ -1061,7 +1059,9 @@ static void __init split_lock_setup(void)
 		return;
 	}
 
-	sld_state = state;
+	/* Restore the MSR to its cached value. */
+	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
 	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
 }
 
@@ -1118,6 +1118,29 @@ bool handle_guest_split_lock(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(handle_guest_split_lock);
 
+static void bus_lock_init(void)
+{
+	u64 val;
+
+	/*
+	 * Warn and fatal are handled by #AC for split lock if #AC for
+	 * split lock is supported.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
+	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off)
+		return;
+
+	/*
+	 * Enable #DB for bus lock. All bus locks are handled in #DB except
+	 * split locks are handled in #AC in the fatal case.
+	 */
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
+	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
+}
+
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
@@ -1126,6 +1149,21 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	return true;
 }
 
+void handle_bus_lock(struct pt_regs *regs)
+{
+	switch (sld_state) {
+	case sld_off:
+		break;
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
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
@@ -1166,7 +1204,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	{}
 };
 
-void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+static void __init split_lock_setup(struct cpuinfo_x86 *c)
 {
 	const struct x86_cpu_id *m;
 	u64 ia32_core_caps;
@@ -1193,5 +1231,40 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	}
 
 	cpu_model_supports_sld = true;
-	split_lock_setup();
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
+		if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+			pr_info("#AC: crashing the kernel on kernel split_locks and warning on user-space split_locks\n");
+		else if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: warning on user-space bus_locks\n");
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
+	}
+}
+
+void __init sld_setup(struct cpuinfo_x86 *c)
+{
+	split_lock_setup(c);
+	sld_state_setup();
+	sld_state_show();
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a..7bb94a6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -978,6 +978,10 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 		goto out_irq;
 	}
 
+	/* #DB for bus lock can only be triggered from userspace. */
+	if (dr6 & DR_BUS_LOCK)
+		handle_bus_lock(regs);
+
 	/* Add the virtual_dr6 bits for signals. */
 	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
