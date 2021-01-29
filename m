Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADB308C44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Jan 2021 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhA2STY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Jan 2021 13:19:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhA2SSx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Jan 2021 13:18:53 -0500
Date:   Fri, 29 Jan 2021 18:18:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611944287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZW92EKf2ZXcCyegrrAnVwhijhem3D/uoJqJtEh//aiA=;
        b=hF/jrKWzTq88QBwr7ySbxjfdyVSLRUIvENCOuGEhWSLNweC7prC+L0BsZI3xj57yRpJQIW
        BSKF6jf72/banA1XoPm0d9pam+6980XdWanp4vijB4S87nqk0EsH+2LAqCHUMn6MbtQSJW
        VFDzA8FAG9hwyXTG3Ie+1ekmVcm6c81Va5x7osDNTIG5mxT29va5ELeaAPhB4VnH6Qpdqx
        e1/V02M2Yg0tn9ncIY3ctPW6/TiLdneq2H2Ihim/HEtkCSyTw0pUzajPezptN2OoE41BG1
        3MHiGWaUXhUQ/EtL7Mi0JapjbPzWIjfbcIEBMaPz53iMHWslrefYKZAuR7JBaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611944287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZW92EKf2ZXcCyegrrAnVwhijhem3D/uoJqJtEh//aiA=;
        b=47zLj2H0uS4A+DkPOEHe1pTT7CC+jH1766m6t4i4W83XAIu8UGpk2sp8qchHRgvXnsWbY0
        dFmrpcHiusE4tCAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] thermal: Move therm_throt there from x86/mce
Cc:     Borislav Petkov <bp@suse.de>, Zhang Rui <rui.zhang@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210125130533.19938-3-bp@alien8.de>
References: <20210125130533.19938-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161194428693.23325.9067590586256276460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1dba8a9538f5164eb8874eed4c7d6799a3c64963
Gitweb:        https://git.kernel.org/tip/1dba8a9538f5164eb8874eed4c7d6799a3c64963
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 07 Jan 2021 13:29:05 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 29 Jan 2021 17:47:26 +01:00

thermal: Move therm_throt there from x86/mce

This functionality has nothing to do with MCE, move it to the thermal
framework and untangle it from MCE.

Have thermal_set_handler() check the build-time assigned default handler
stub was the one used before therm_throt assigns a new one.

Requested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/20210125130533.19938-3-bp@alien8.de
---
 arch/x86/Kconfig                             |   4 +-
 arch/x86/include/asm/irq.h                   |   4 +-
 arch/x86/include/asm/mce.h                   |  16 +-
 arch/x86/include/asm/thermal.h               |  21 +-
 arch/x86/kernel/cpu/intel.c                  |   3 +-
 arch/x86/kernel/cpu/mce/Makefile             |   2 +-
 arch/x86/kernel/cpu/mce/intel.c              |   1 +-
 arch/x86/kernel/cpu/mce/therm_throt.c        | 731 +------------------
 arch/x86/kernel/irq.c                        |  29 +-
 drivers/thermal/intel/Kconfig                |   4 +-
 drivers/thermal/intel/Makefile               |   1 +-
 drivers/thermal/intel/therm_throt.c          | 712 ++++++++++++++++++-
 drivers/thermal/intel/x86_pkg_temp_thermal.c |   3 +-
 13 files changed, 776 insertions(+), 755 deletions(-)
 create mode 100644 arch/x86/include/asm/thermal.h
 delete mode 100644 arch/x86/kernel/cpu/mce/therm_throt.c
 create mode 100644 drivers/thermal/intel/therm_throt.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10..54df315 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1157,10 +1157,6 @@ config X86_MCE_INJECT
 	  If you don't know what a machine check is and you don't do kernel
 	  QA it is safe to say n.
 
-config X86_THERMAL_VECTOR
-	def_bool y
-	depends on X86_MCE_INTEL
-
 source "arch/x86/events/Kconfig"
 
 config X86_LEGACY_VM86
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 528c8a7..ad65fe7 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -53,4 +53,8 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
+#ifdef CONFIG_X86_THERMAL_VECTOR
+void thermal_set_handler(void (*handler)(void));
+#endif
+
 #endif /* _ASM_X86_IRQ_H */
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index def9aa5..ddfb3ca 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -289,22 +289,6 @@ extern void (*mce_threshold_vector)(void);
 extern void (*deferred_error_int_vector)(void);
 
 /*
- * Thermal handler
- */
-
-void intel_init_thermal(struct cpuinfo_x86 *c);
-
-/* Interrupt Handler for core thermal thresholds */
-extern int (*platform_thermal_notify)(__u64 msr_val);
-
-/* Interrupt Handler for package thermal thresholds */
-extern int (*platform_thermal_package_notify)(__u64 msr_val);
-
-/* Callback support of rate control, return true, if
- * callback has rate control */
-extern bool (*platform_thermal_package_rate_control)(void);
-
-/*
  * Used by APEI to report memory error via /dev/mcelog
  */
 
diff --git a/arch/x86/include/asm/thermal.h b/arch/x86/include/asm/thermal.h
new file mode 100644
index 0000000..58b0e0a
--- /dev/null
+++ b/arch/x86/include/asm/thermal.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_THERMAL_H
+#define _ASM_X86_THERMAL_H
+
+/* Interrupt Handler for package thermal thresholds */
+extern int (*platform_thermal_package_notify)(__u64 msr_val);
+
+/* Interrupt Handler for core thermal thresholds */
+extern int (*platform_thermal_notify)(__u64 msr_val);
+
+/* Callback support of rate control, return true, if
+ * callback has rate control */
+extern bool (*platform_thermal_package_rate_control)(void);
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+void intel_init_thermal(struct cpuinfo_x86 *c);
+#else
+static inline void intel_init_thermal(struct cpuinfo_x86 *c) { }
+#endif
+
+#endif /* _ASM_X86_THERMAL_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3c..71221af 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -24,6 +24,7 @@
 #include <asm/traps.h>
 #include <asm/resctrl.h>
 #include <asm/numa.h>
+#include <asm/thermal.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -719,6 +720,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_disable();
 
 	split_lock_init();
+
+	intel_init_thermal(c);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 9f020c9..015856a 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -9,8 +9,6 @@ obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
 mce-inject-y			:= inject.o
 obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
 
-obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
-
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 
 obj-$(CONFIG_X86_MCELOG_LEGACY)	+= dev-mcelog.o
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index c2476fe..e309476 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -531,7 +531,6 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
-	intel_init_thermal(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_ppin_init(c);
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
deleted file mode 100644
index 5b1aa0f..0000000
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ /dev/null
@@ -1,731 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Thermal throttle event support code (such as syslog messaging and rate
- * limiting) that was factored out from x86_64 (mce_intel.c) and i386 (p4.c).
- *
- * This allows consistent reporting of CPU thermal throttle events.
- *
- * Maintains a counter in /sys that keeps track of the number of thermal
- * events, such that the user knows how bad the thermal problem might be
- * (since the logging to syslog is rate limited).
- *
- * Author: Dmitriy Zavin (dmitriyz@google.com)
- *
- * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
- *          Inspired by Ross Biro's and Al Borchers' counter code.
- */
-#include <linux/interrupt.h>
-#include <linux/notifier.h>
-#include <linux/jiffies.h>
-#include <linux/kernel.h>
-#include <linux/percpu.h>
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-
-#include <asm/processor.h>
-#include <asm/traps.h>
-#include <asm/apic.h>
-#include <asm/mce.h>
-#include <asm/msr.h>
-#include <asm/trace/irq_vectors.h>
-
-#include "internal.h"
-
-/* How long to wait between reporting thermal events */
-#define CHECK_INTERVAL		(300 * HZ)
-
-#define THERMAL_THROTTLING_EVENT	0
-#define POWER_LIMIT_EVENT		1
-
-/**
- * struct _thermal_state - Represent the current thermal event state
- * @next_check:			Stores the next timestamp, when it is allowed
- *				to log the next warning message.
- * @last_interrupt_time:	Stores the timestamp for the last threshold
- *				high event.
- * @therm_work:			Delayed workqueue structure
- * @count:			Stores the current running count for thermal
- *				or power threshold interrupts.
- * @last_count:			Stores the previous running count for thermal
- *				or power threshold interrupts.
- * @max_time_ms:		This shows the maximum amount of time CPU was
- *				in throttled state for a single thermal
- *				threshold high to low state.
- * @total_time_ms:		This is a cumulative time during which CPU was
- *				in the throttled state.
- * @rate_control_active:	Set when a throttling message is logged.
- *				This is used for the purpose of rate-control.
- * @new_event:			Stores the last high/low status of the
- *				THERM_STATUS_PROCHOT or
- *				THERM_STATUS_POWER_LIMIT.
- * @level:			Stores whether this _thermal_state instance is
- *				for a CORE level or for PACKAGE level.
- * @sample_index:		Index for storing the next sample in the buffer
- *				temp_samples[].
- * @sample_count:		Total number of samples collected in the buffer
- *				temp_samples[].
- * @average:			The last moving average of temperature samples
- * @baseline_temp:		Temperature at which thermal threshold high
- *				interrupt was generated.
- * @temp_samples:		Storage for temperature samples to calculate
- *				moving average.
- *
- * This structure is used to represent data related to thermal state for a CPU.
- * There is a separate storage for core and package level for each CPU.
- */
-struct _thermal_state {
-	u64			next_check;
-	u64			last_interrupt_time;
-	struct delayed_work	therm_work;
-	unsigned long		count;
-	unsigned long		last_count;
-	unsigned long		max_time_ms;
-	unsigned long		total_time_ms;
-	bool			rate_control_active;
-	bool			new_event;
-	u8			level;
-	u8			sample_index;
-	u8			sample_count;
-	u8			average;
-	u8			baseline_temp;
-	u8			temp_samples[3];
-};
-
-struct thermal_state {
-	struct _thermal_state core_throttle;
-	struct _thermal_state core_power_limit;
-	struct _thermal_state package_throttle;
-	struct _thermal_state package_power_limit;
-	struct _thermal_state core_thresh0;
-	struct _thermal_state core_thresh1;
-	struct _thermal_state pkg_thresh0;
-	struct _thermal_state pkg_thresh1;
-};
-
-/* Callback to handle core threshold interrupts */
-int (*platform_thermal_notify)(__u64 msr_val);
-EXPORT_SYMBOL(platform_thermal_notify);
-
-/* Callback to handle core package threshold_interrupts */
-int (*platform_thermal_package_notify)(__u64 msr_val);
-EXPORT_SYMBOL_GPL(platform_thermal_package_notify);
-
-/* Callback support of rate control, return true, if
- * callback has rate control */
-bool (*platform_thermal_package_rate_control)(void);
-EXPORT_SYMBOL_GPL(platform_thermal_package_rate_control);
-
-
-static DEFINE_PER_CPU(struct thermal_state, thermal_state);
-
-static atomic_t therm_throt_en	= ATOMIC_INIT(0);
-
-static u32 lvtthmr_init __read_mostly;
-
-#ifdef CONFIG_SYSFS
-#define define_therm_throt_device_one_ro(_name)				\
-	static DEVICE_ATTR(_name, 0444,					\
-			   therm_throt_device_show_##_name,		\
-				   NULL)				\
-
-#define define_therm_throt_device_show_func(event, name)		\
-									\
-static ssize_t therm_throt_device_show_##event##_##name(		\
-			struct device *dev,				\
-			struct device_attribute *attr,			\
-			char *buf)					\
-{									\
-	unsigned int cpu = dev->id;					\
-	ssize_t ret;							\
-									\
-	preempt_disable();	/* CPU hotplug */			\
-	if (cpu_online(cpu)) {						\
-		ret = sprintf(buf, "%lu\n",				\
-			      per_cpu(thermal_state, cpu).event.name);	\
-	} else								\
-		ret = 0;						\
-	preempt_enable();						\
-									\
-	return ret;							\
-}
-
-define_therm_throt_device_show_func(core_throttle, count);
-define_therm_throt_device_one_ro(core_throttle_count);
-
-define_therm_throt_device_show_func(core_power_limit, count);
-define_therm_throt_device_one_ro(core_power_limit_count);
-
-define_therm_throt_device_show_func(package_throttle, count);
-define_therm_throt_device_one_ro(package_throttle_count);
-
-define_therm_throt_device_show_func(package_power_limit, count);
-define_therm_throt_device_one_ro(package_power_limit_count);
-
-define_therm_throt_device_show_func(core_throttle, max_time_ms);
-define_therm_throt_device_one_ro(core_throttle_max_time_ms);
-
-define_therm_throt_device_show_func(package_throttle, max_time_ms);
-define_therm_throt_device_one_ro(package_throttle_max_time_ms);
-
-define_therm_throt_device_show_func(core_throttle, total_time_ms);
-define_therm_throt_device_one_ro(core_throttle_total_time_ms);
-
-define_therm_throt_device_show_func(package_throttle, total_time_ms);
-define_therm_throt_device_one_ro(package_throttle_total_time_ms);
-
-static struct attribute *thermal_throttle_attrs[] = {
-	&dev_attr_core_throttle_count.attr,
-	&dev_attr_core_throttle_max_time_ms.attr,
-	&dev_attr_core_throttle_total_time_ms.attr,
-	NULL
-};
-
-static const struct attribute_group thermal_attr_group = {
-	.attrs	= thermal_throttle_attrs,
-	.name	= "thermal_throttle"
-};
-#endif /* CONFIG_SYSFS */
-
-#define CORE_LEVEL	0
-#define PACKAGE_LEVEL	1
-
-#define THERM_THROT_POLL_INTERVAL	HZ
-#define THERM_STATUS_PROCHOT_LOG	BIT(1)
-
-#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
-#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
-
-static void clear_therm_status_log(int level)
-{
-	int msr;
-	u64 mask, msr_val;
-
-	if (level == CORE_LEVEL) {
-		msr  = MSR_IA32_THERM_STATUS;
-		mask = THERM_STATUS_CLEAR_CORE_MASK;
-	} else {
-		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
-		mask = THERM_STATUS_CLEAR_PKG_MASK;
-	}
-
-	rdmsrl(msr, msr_val);
-	msr_val &= mask;
-	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
-}
-
-static void get_therm_status(int level, bool *proc_hot, u8 *temp)
-{
-	int msr;
-	u64 msr_val;
-
-	if (level == CORE_LEVEL)
-		msr = MSR_IA32_THERM_STATUS;
-	else
-		msr = MSR_IA32_PACKAGE_THERM_STATUS;
-
-	rdmsrl(msr, msr_val);
-	if (msr_val & THERM_STATUS_PROCHOT_LOG)
-		*proc_hot = true;
-	else
-		*proc_hot = false;
-
-	*temp = (msr_val >> 16) & 0x7F;
-}
-
-static void __maybe_unused throttle_active_work(struct work_struct *work)
-{
-	struct _thermal_state *state = container_of(to_delayed_work(work),
-						struct _thermal_state, therm_work);
-	unsigned int i, avg, this_cpu = smp_processor_id();
-	u64 now = get_jiffies_64();
-	bool hot;
-	u8 temp;
-
-	get_therm_status(state->level, &hot, &temp);
-	/* temperature value is offset from the max so lesser means hotter */
-	if (!hot && temp > state->baseline_temp) {
-		if (state->rate_control_active)
-			pr_info("CPU%d: %s temperature/speed normal (total events = %lu)\n",
-				this_cpu,
-				state->level == CORE_LEVEL ? "Core" : "Package",
-				state->count);
-
-		state->rate_control_active = false;
-		return;
-	}
-
-	if (time_before64(now, state->next_check) &&
-			  state->rate_control_active)
-		goto re_arm;
-
-	state->next_check = now + CHECK_INTERVAL;
-
-	if (state->count != state->last_count) {
-		/* There was one new thermal interrupt */
-		state->last_count = state->count;
-		state->average = 0;
-		state->sample_count = 0;
-		state->sample_index = 0;
-	}
-
-	state->temp_samples[state->sample_index] = temp;
-	state->sample_count++;
-	state->sample_index = (state->sample_index + 1) % ARRAY_SIZE(state->temp_samples);
-	if (state->sample_count < ARRAY_SIZE(state->temp_samples))
-		goto re_arm;
-
-	avg = 0;
-	for (i = 0; i < ARRAY_SIZE(state->temp_samples); ++i)
-		avg += state->temp_samples[i];
-
-	avg /= ARRAY_SIZE(state->temp_samples);
-
-	if (state->average > avg) {
-		pr_warn("CPU%d: %s temperature is above threshold, cpu clock is throttled (total events = %lu)\n",
-			this_cpu,
-			state->level == CORE_LEVEL ? "Core" : "Package",
-			state->count);
-		state->rate_control_active = true;
-	}
-
-	state->average = avg;
-
-re_arm:
-	clear_therm_status_log(state->level);
-	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
-}
-
-/***
- * therm_throt_process - Process thermal throttling event from interrupt
- * @curr: Whether the condition is current or not (boolean), since the
- *        thermal interrupt normally gets called both when the thermal
- *        event begins and once the event has ended.
- *
- * This function is called by the thermal interrupt after the
- * IRQ has been acknowledged.
- *
- * It will take care of rate limiting and printing messages to the syslog.
- */
-static void therm_throt_process(bool new_event, int event, int level)
-{
-	struct _thermal_state *state;
-	unsigned int this_cpu = smp_processor_id();
-	bool old_event;
-	u64 now;
-	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
-
-	now = get_jiffies_64();
-	if (level == CORE_LEVEL) {
-		if (event == THERMAL_THROTTLING_EVENT)
-			state = &pstate->core_throttle;
-		else if (event == POWER_LIMIT_EVENT)
-			state = &pstate->core_power_limit;
-		else
-			return;
-	} else if (level == PACKAGE_LEVEL) {
-		if (event == THERMAL_THROTTLING_EVENT)
-			state = &pstate->package_throttle;
-		else if (event == POWER_LIMIT_EVENT)
-			state = &pstate->package_power_limit;
-		else
-			return;
-	} else
-		return;
-
-	old_event = state->new_event;
-	state->new_event = new_event;
-
-	if (new_event)
-		state->count++;
-
-	if (event != THERMAL_THROTTLING_EVENT)
-		return;
-
-	if (new_event && !state->last_interrupt_time) {
-		bool hot;
-		u8 temp;
-
-		get_therm_status(state->level, &hot, &temp);
-		/*
-		 * Ignore short temperature spike as the system is not close
-		 * to PROCHOT. 10C offset is large enough to ignore. It is
-		 * already dropped from the high threshold temperature.
-		 */
-		if (temp > 10)
-			return;
-
-		state->baseline_temp = temp;
-		state->last_interrupt_time = now;
-		schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
-	} else if (old_event && state->last_interrupt_time) {
-		unsigned long throttle_time;
-
-		throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
-		if (throttle_time > state->max_time_ms)
-			state->max_time_ms = throttle_time;
-		state->total_time_ms += throttle_time;
-		state->last_interrupt_time = 0;
-	}
-}
-
-static int thresh_event_valid(int level, int event)
-{
-	struct _thermal_state *state;
-	unsigned int this_cpu = smp_processor_id();
-	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
-	u64 now = get_jiffies_64();
-
-	if (level == PACKAGE_LEVEL)
-		state = (event == 0) ? &pstate->pkg_thresh0 :
-						&pstate->pkg_thresh1;
-	else
-		state = (event == 0) ? &pstate->core_thresh0 :
-						&pstate->core_thresh1;
-
-	if (time_before64(now, state->next_check))
-		return 0;
-
-	state->next_check = now + CHECK_INTERVAL;
-
-	return 1;
-}
-
-static bool int_pln_enable;
-static int __init int_pln_enable_setup(char *s)
-{
-	int_pln_enable = true;
-
-	return 1;
-}
-__setup("int_pln_enable", int_pln_enable_setup);
-
-#ifdef CONFIG_SYSFS
-/* Add/Remove thermal_throttle interface for CPU device: */
-static int thermal_throttle_add_dev(struct device *dev, unsigned int cpu)
-{
-	int err;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-	err = sysfs_create_group(&dev->kobj, &thermal_attr_group);
-	if (err)
-		return err;
-
-	if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
-		err = sysfs_add_file_to_group(&dev->kobj,
-					      &dev_attr_core_power_limit_count.attr,
-					      thermal_attr_group.name);
-		if (err)
-			goto del_group;
-	}
-
-	if (cpu_has(c, X86_FEATURE_PTS)) {
-		err = sysfs_add_file_to_group(&dev->kobj,
-					      &dev_attr_package_throttle_count.attr,
-					      thermal_attr_group.name);
-		if (err)
-			goto del_group;
-
-		err = sysfs_add_file_to_group(&dev->kobj,
-					      &dev_attr_package_throttle_max_time_ms.attr,
-					      thermal_attr_group.name);
-		if (err)
-			goto del_group;
-
-		err = sysfs_add_file_to_group(&dev->kobj,
-					      &dev_attr_package_throttle_total_time_ms.attr,
-					      thermal_attr_group.name);
-		if (err)
-			goto del_group;
-
-		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
-			err = sysfs_add_file_to_group(&dev->kobj,
-					&dev_attr_package_power_limit_count.attr,
-					thermal_attr_group.name);
-			if (err)
-				goto del_group;
-		}
-	}
-
-	return 0;
-
-del_group:
-	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
-
-	return err;
-}
-
-static void thermal_throttle_remove_dev(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
-}
-
-/* Get notified when a cpu comes on/off. Be hotplug friendly. */
-static int thermal_throttle_online(unsigned int cpu)
-{
-	struct thermal_state *state = &per_cpu(thermal_state, cpu);
-	struct device *dev = get_cpu_device(cpu);
-	u32 l;
-
-	state->package_throttle.level = PACKAGE_LEVEL;
-	state->core_throttle.level = CORE_LEVEL;
-
-	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
-	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
-
-	/* Unmask the thermal vector after the above workqueues are initialized. */
-	l = apic_read(APIC_LVTTHMR);
-	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-
-	return thermal_throttle_add_dev(dev, cpu);
-}
-
-static int thermal_throttle_offline(unsigned int cpu)
-{
-	struct thermal_state *state = &per_cpu(thermal_state, cpu);
-	struct device *dev = get_cpu_device(cpu);
-	u32 l;
-
-	/* Mask the thermal vector before draining evtl. pending work */
-	l = apic_read(APIC_LVTTHMR);
-	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
-
-	cancel_delayed_work_sync(&state->package_throttle.therm_work);
-	cancel_delayed_work_sync(&state->core_throttle.therm_work);
-
-	state->package_throttle.rate_control_active = false;
-	state->core_throttle.rate_control_active = false;
-
-	thermal_throttle_remove_dev(dev);
-	return 0;
-}
-
-static __init int thermal_throttle_init_device(void)
-{
-	int ret;
-
-	if (!atomic_read(&therm_throt_en))
-		return 0;
-
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",
-				thermal_throttle_online,
-				thermal_throttle_offline);
-	return ret < 0 ? ret : 0;
-}
-device_initcall(thermal_throttle_init_device);
-
-#endif /* CONFIG_SYSFS */
-
-static void notify_package_thresholds(__u64 msr_val)
-{
-	bool notify_thres_0 = false;
-	bool notify_thres_1 = false;
-
-	if (!platform_thermal_package_notify)
-		return;
-
-	/* lower threshold check */
-	if (msr_val & THERM_LOG_THRESHOLD0)
-		notify_thres_0 = true;
-	/* higher threshold check */
-	if (msr_val & THERM_LOG_THRESHOLD1)
-		notify_thres_1 = true;
-
-	if (!notify_thres_0 && !notify_thres_1)
-		return;
-
-	if (platform_thermal_package_rate_control &&
-		platform_thermal_package_rate_control()) {
-		/* Rate control is implemented in callback */
-		platform_thermal_package_notify(msr_val);
-		return;
-	}
-
-	/* lower threshold reached */
-	if (notify_thres_0 && thresh_event_valid(PACKAGE_LEVEL, 0))
-		platform_thermal_package_notify(msr_val);
-	/* higher threshold reached */
-	if (notify_thres_1 && thresh_event_valid(PACKAGE_LEVEL, 1))
-		platform_thermal_package_notify(msr_val);
-}
-
-static void notify_thresholds(__u64 msr_val)
-{
-	/* check whether the interrupt handler is defined;
-	 * otherwise simply return
-	 */
-	if (!platform_thermal_notify)
-		return;
-
-	/* lower threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD0) &&
-			thresh_event_valid(CORE_LEVEL, 0))
-		platform_thermal_notify(msr_val);
-	/* higher threshold reached */
-	if ((msr_val & THERM_LOG_THRESHOLD1) &&
-			thresh_event_valid(CORE_LEVEL, 1))
-		platform_thermal_notify(msr_val);
-}
-
-/* Thermal transition interrupt handler */
-static void intel_thermal_interrupt(void)
-{
-	__u64 msr_val;
-
-	if (static_cpu_has(X86_FEATURE_HWP))
-		wrmsrl_safe(MSR_HWP_STATUS, 0);
-
-	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
-
-	/* Check for violation of core thermal thresholds*/
-	notify_thresholds(msr_val);
-
-	therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
-			    THERMAL_THROTTLING_EVENT,
-			    CORE_LEVEL);
-
-	if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
-		therm_throt_process(msr_val & THERM_STATUS_POWER_LIMIT,
-					POWER_LIMIT_EVENT,
-					CORE_LEVEL);
-
-	if (this_cpu_has(X86_FEATURE_PTS)) {
-		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
-		/* check violations of package thermal thresholds */
-		notify_package_thresholds(msr_val);
-		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
-					THERMAL_THROTTLING_EVENT,
-					PACKAGE_LEVEL);
-		if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
-			therm_throt_process(msr_val &
-					PACKAGE_THERM_STATUS_POWER_LIMIT,
-					POWER_LIMIT_EVENT,
-					PACKAGE_LEVEL);
-	}
-}
-
-static void unexpected_thermal_interrupt(void)
-{
-	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
-		smp_processor_id());
-}
-
-static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
-
-DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
-{
-	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
-	inc_irq_stat(irq_thermal_count);
-	smp_thermal_vector();
-	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
-	ack_APIC_irq();
-}
-
-/* Thermal monitoring depends on APIC, ACPI and clock modulation */
-static int intel_thermal_supported(struct cpuinfo_x86 *c)
-{
-	if (!boot_cpu_has(X86_FEATURE_APIC))
-		return 0;
-	if (!cpu_has(c, X86_FEATURE_ACPI) || !cpu_has(c, X86_FEATURE_ACC))
-		return 0;
-	return 1;
-}
-
-void intel_init_thermal(struct cpuinfo_x86 *c)
-{
-	unsigned int cpu = smp_processor_id();
-	int tm2 = 0;
-	u32 l, h;
-
-	if ((c == &boot_cpu_data) && intel_thermal_supported(c))
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
-
-	if (!intel_thermal_supported(c))
-		return;
-
-	/*
-	 * First check if its enabled already, in which case there might
-	 * be some SMM goo which handles it, so we can't even put a handler
-	 * since it might be delivered via SMI already:
-	 */
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-
-	h = lvtthmr_init;
-	/*
-	 * The initial value of thermal LVT entries on all APs always reads
-	 * 0x10000 because APs are woken up by BSP issuing INIT-SIPI-SIPI
-	 * sequence to them and LVT registers are reset to 0s except for
-	 * the mask bits which are set to 1s when APs receive INIT IPI.
-	 * If BIOS takes over the thermal interrupt and sets its interrupt
-	 * delivery mode to SMI (not fixed), it restores the value that the
-	 * BIOS has programmed on AP based on BSP's info we saved since BIOS
-	 * is always setting the same value for all threads/cores.
-	 */
-	if ((h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED)
-		apic_write(APIC_LVTTHMR, lvtthmr_init);
-
-
-	if ((l & MSR_IA32_MISC_ENABLE_TM1) && (h & APIC_DM_SMI)) {
-		if (system_state == SYSTEM_BOOTING)
-			pr_debug("CPU%d: Thermal monitoring handled by SMI\n", cpu);
-		return;
-	}
-
-	/* early Pentium M models use different method for enabling TM2 */
-	if (cpu_has(c, X86_FEATURE_TM2)) {
-		if (c->x86 == 6 && (c->x86_model == 9 || c->x86_model == 13)) {
-			rdmsr(MSR_THERM2_CTL, l, h);
-			if (l & MSR_THERM2_CTL_TM_SELECT)
-				tm2 = 1;
-		} else if (l & MSR_IA32_MISC_ENABLE_TM2)
-			tm2 = 1;
-	}
-
-	/* We'll mask the thermal vector in the lapic till we're ready: */
-	h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
-	apic_write(APIC_LVTTHMR, h);
-
-	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
-	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			(l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
-	else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), h);
-	else
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-		      l | (THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE), h);
-
-	if (cpu_has(c, X86_FEATURE_PTS)) {
-		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
-		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				(l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE))
-				& ~PACKAGE_THERM_INT_PLN_ENABLE, h);
-		else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE
-				| PACKAGE_THERM_INT_PLN_ENABLE), h);
-		else
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			      l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
-	}
-
-	smp_thermal_vector = intel_thermal_interrupt;
-
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
-
-	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
-		      tm2 ? "TM2" : "TM1");
-
-	/* enable thermal throttle processing */
-	atomic_set(&therm_throt_en, 1);
-}
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd503..523fa52 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -374,3 +374,32 @@ void fixup_irqs(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+static void unexpected_thermal_interrupt(void)
+{
+	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
+		smp_processor_id());
+}
+
+static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
+
+void thermal_set_handler(void (*handler)(void))
+{
+	if (handler) {
+		WARN_ON(smp_thermal_vector != unexpected_thermal_interrupt);
+		smp_thermal_vector = handler;
+	} else {
+		smp_thermal_vector = unexpected_thermal_interrupt;
+	}
+}
+
+DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
+{
+	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
+	inc_irq_stat(irq_thermal_count);
+	smp_thermal_vector();
+	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
+	ack_APIC_irq();
+}
+#endif
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 8025b21..ce4f592 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -8,6 +8,10 @@ config INTEL_POWERCLAMP
 	  enforce idle time which results in more package C-state residency. The
 	  user interface is exposed via generic thermal framework.
 
+config X86_THERMAL_VECTOR
+	def_bool y
+	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
+
 config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
index 0d9736c..ff2ad30 100644
--- a/drivers/thermal/intel/Makefile
+++ b/drivers/thermal/intel/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
 obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
+obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
new file mode 100644
index 0000000..4f12fcd
--- /dev/null
+++ b/drivers/thermal/intel/therm_throt.c
@@ -0,0 +1,712 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Thermal throttle event support code (such as syslog messaging and rate
+ * limiting) that was factored out from x86_64 (mce_intel.c) and i386 (p4.c).
+ *
+ * This allows consistent reporting of CPU thermal throttle events.
+ *
+ * Maintains a counter in /sys that keeps track of the number of thermal
+ * events, such that the user knows how bad the thermal problem might be
+ * (since the logging to syslog is rate limited).
+ *
+ * Author: Dmitriy Zavin (dmitriyz@google.com)
+ *
+ * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
+ *          Inspired by Ross Biro's and Al Borchers' counter code.
+ */
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+
+#include <asm/processor.h>
+#include <asm/thermal.h>
+#include <asm/traps.h>
+#include <asm/apic.h>
+#include <asm/irq.h>
+#include <asm/msr.h>
+
+/* How long to wait between reporting thermal events */
+#define CHECK_INTERVAL		(300 * HZ)
+
+#define THERMAL_THROTTLING_EVENT	0
+#define POWER_LIMIT_EVENT		1
+
+/**
+ * struct _thermal_state - Represent the current thermal event state
+ * @next_check:			Stores the next timestamp, when it is allowed
+ *				to log the next warning message.
+ * @last_interrupt_time:	Stores the timestamp for the last threshold
+ *				high event.
+ * @therm_work:			Delayed workqueue structure
+ * @count:			Stores the current running count for thermal
+ *				or power threshold interrupts.
+ * @last_count:			Stores the previous running count for thermal
+ *				or power threshold interrupts.
+ * @max_time_ms:		This shows the maximum amount of time CPU was
+ *				in throttled state for a single thermal
+ *				threshold high to low state.
+ * @total_time_ms:		This is a cumulative time during which CPU was
+ *				in the throttled state.
+ * @rate_control_active:	Set when a throttling message is logged.
+ *				This is used for the purpose of rate-control.
+ * @new_event:			Stores the last high/low status of the
+ *				THERM_STATUS_PROCHOT or
+ *				THERM_STATUS_POWER_LIMIT.
+ * @level:			Stores whether this _thermal_state instance is
+ *				for a CORE level or for PACKAGE level.
+ * @sample_index:		Index for storing the next sample in the buffer
+ *				temp_samples[].
+ * @sample_count:		Total number of samples collected in the buffer
+ *				temp_samples[].
+ * @average:			The last moving average of temperature samples
+ * @baseline_temp:		Temperature at which thermal threshold high
+ *				interrupt was generated.
+ * @temp_samples:		Storage for temperature samples to calculate
+ *				moving average.
+ *
+ * This structure is used to represent data related to thermal state for a CPU.
+ * There is a separate storage for core and package level for each CPU.
+ */
+struct _thermal_state {
+	u64			next_check;
+	u64			last_interrupt_time;
+	struct delayed_work	therm_work;
+	unsigned long		count;
+	unsigned long		last_count;
+	unsigned long		max_time_ms;
+	unsigned long		total_time_ms;
+	bool			rate_control_active;
+	bool			new_event;
+	u8			level;
+	u8			sample_index;
+	u8			sample_count;
+	u8			average;
+	u8			baseline_temp;
+	u8			temp_samples[3];
+};
+
+struct thermal_state {
+	struct _thermal_state core_throttle;
+	struct _thermal_state core_power_limit;
+	struct _thermal_state package_throttle;
+	struct _thermal_state package_power_limit;
+	struct _thermal_state core_thresh0;
+	struct _thermal_state core_thresh1;
+	struct _thermal_state pkg_thresh0;
+	struct _thermal_state pkg_thresh1;
+};
+
+/* Callback to handle core threshold interrupts */
+int (*platform_thermal_notify)(__u64 msr_val);
+EXPORT_SYMBOL(platform_thermal_notify);
+
+/* Callback to handle core package threshold_interrupts */
+int (*platform_thermal_package_notify)(__u64 msr_val);
+EXPORT_SYMBOL_GPL(platform_thermal_package_notify);
+
+/* Callback support of rate control, return true, if
+ * callback has rate control */
+bool (*platform_thermal_package_rate_control)(void);
+EXPORT_SYMBOL_GPL(platform_thermal_package_rate_control);
+
+
+static DEFINE_PER_CPU(struct thermal_state, thermal_state);
+
+static atomic_t therm_throt_en	= ATOMIC_INIT(0);
+
+static u32 lvtthmr_init __read_mostly;
+
+#ifdef CONFIG_SYSFS
+#define define_therm_throt_device_one_ro(_name)				\
+	static DEVICE_ATTR(_name, 0444,					\
+			   therm_throt_device_show_##_name,		\
+				   NULL)				\
+
+#define define_therm_throt_device_show_func(event, name)		\
+									\
+static ssize_t therm_throt_device_show_##event##_##name(		\
+			struct device *dev,				\
+			struct device_attribute *attr,			\
+			char *buf)					\
+{									\
+	unsigned int cpu = dev->id;					\
+	ssize_t ret;							\
+									\
+	preempt_disable();	/* CPU hotplug */			\
+	if (cpu_online(cpu)) {						\
+		ret = sprintf(buf, "%lu\n",				\
+			      per_cpu(thermal_state, cpu).event.name);	\
+	} else								\
+		ret = 0;						\
+	preempt_enable();						\
+									\
+	return ret;							\
+}
+
+define_therm_throt_device_show_func(core_throttle, count);
+define_therm_throt_device_one_ro(core_throttle_count);
+
+define_therm_throt_device_show_func(core_power_limit, count);
+define_therm_throt_device_one_ro(core_power_limit_count);
+
+define_therm_throt_device_show_func(package_throttle, count);
+define_therm_throt_device_one_ro(package_throttle_count);
+
+define_therm_throt_device_show_func(package_power_limit, count);
+define_therm_throt_device_one_ro(package_power_limit_count);
+
+define_therm_throt_device_show_func(core_throttle, max_time_ms);
+define_therm_throt_device_one_ro(core_throttle_max_time_ms);
+
+define_therm_throt_device_show_func(package_throttle, max_time_ms);
+define_therm_throt_device_one_ro(package_throttle_max_time_ms);
+
+define_therm_throt_device_show_func(core_throttle, total_time_ms);
+define_therm_throt_device_one_ro(core_throttle_total_time_ms);
+
+define_therm_throt_device_show_func(package_throttle, total_time_ms);
+define_therm_throt_device_one_ro(package_throttle_total_time_ms);
+
+static struct attribute *thermal_throttle_attrs[] = {
+	&dev_attr_core_throttle_count.attr,
+	&dev_attr_core_throttle_max_time_ms.attr,
+	&dev_attr_core_throttle_total_time_ms.attr,
+	NULL
+};
+
+static const struct attribute_group thermal_attr_group = {
+	.attrs	= thermal_throttle_attrs,
+	.name	= "thermal_throttle"
+};
+#endif /* CONFIG_SYSFS */
+
+#define CORE_LEVEL	0
+#define PACKAGE_LEVEL	1
+
+#define THERM_THROT_POLL_INTERVAL	HZ
+#define THERM_STATUS_PROCHOT_LOG	BIT(1)
+
+#define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+
+static void clear_therm_status_log(int level)
+{
+	int msr;
+	u64 mask, msr_val;
+
+	if (level == CORE_LEVEL) {
+		msr  = MSR_IA32_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_CORE_MASK;
+	} else {
+		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
+		mask = THERM_STATUS_CLEAR_PKG_MASK;
+	}
+
+	rdmsrl(msr, msr_val);
+	msr_val &= mask;
+	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
+}
+
+static void get_therm_status(int level, bool *proc_hot, u8 *temp)
+{
+	int msr;
+	u64 msr_val;
+
+	if (level == CORE_LEVEL)
+		msr = MSR_IA32_THERM_STATUS;
+	else
+		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+
+	rdmsrl(msr, msr_val);
+	if (msr_val & THERM_STATUS_PROCHOT_LOG)
+		*proc_hot = true;
+	else
+		*proc_hot = false;
+
+	*temp = (msr_val >> 16) & 0x7F;
+}
+
+static void __maybe_unused throttle_active_work(struct work_struct *work)
+{
+	struct _thermal_state *state = container_of(to_delayed_work(work),
+						struct _thermal_state, therm_work);
+	unsigned int i, avg, this_cpu = smp_processor_id();
+	u64 now = get_jiffies_64();
+	bool hot;
+	u8 temp;
+
+	get_therm_status(state->level, &hot, &temp);
+	/* temperature value is offset from the max so lesser means hotter */
+	if (!hot && temp > state->baseline_temp) {
+		if (state->rate_control_active)
+			pr_info("CPU%d: %s temperature/speed normal (total events = %lu)\n",
+				this_cpu,
+				state->level == CORE_LEVEL ? "Core" : "Package",
+				state->count);
+
+		state->rate_control_active = false;
+		return;
+	}
+
+	if (time_before64(now, state->next_check) &&
+			  state->rate_control_active)
+		goto re_arm;
+
+	state->next_check = now + CHECK_INTERVAL;
+
+	if (state->count != state->last_count) {
+		/* There was one new thermal interrupt */
+		state->last_count = state->count;
+		state->average = 0;
+		state->sample_count = 0;
+		state->sample_index = 0;
+	}
+
+	state->temp_samples[state->sample_index] = temp;
+	state->sample_count++;
+	state->sample_index = (state->sample_index + 1) % ARRAY_SIZE(state->temp_samples);
+	if (state->sample_count < ARRAY_SIZE(state->temp_samples))
+		goto re_arm;
+
+	avg = 0;
+	for (i = 0; i < ARRAY_SIZE(state->temp_samples); ++i)
+		avg += state->temp_samples[i];
+
+	avg /= ARRAY_SIZE(state->temp_samples);
+
+	if (state->average > avg) {
+		pr_warn("CPU%d: %s temperature is above threshold, cpu clock is throttled (total events = %lu)\n",
+			this_cpu,
+			state->level == CORE_LEVEL ? "Core" : "Package",
+			state->count);
+		state->rate_control_active = true;
+	}
+
+	state->average = avg;
+
+re_arm:
+	clear_therm_status_log(state->level);
+	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+}
+
+/***
+ * therm_throt_process - Process thermal throttling event from interrupt
+ * @curr: Whether the condition is current or not (boolean), since the
+ *        thermal interrupt normally gets called both when the thermal
+ *        event begins and once the event has ended.
+ *
+ * This function is called by the thermal interrupt after the
+ * IRQ has been acknowledged.
+ *
+ * It will take care of rate limiting and printing messages to the syslog.
+ */
+static void therm_throt_process(bool new_event, int event, int level)
+{
+	struct _thermal_state *state;
+	unsigned int this_cpu = smp_processor_id();
+	bool old_event;
+	u64 now;
+	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
+
+	now = get_jiffies_64();
+	if (level == CORE_LEVEL) {
+		if (event == THERMAL_THROTTLING_EVENT)
+			state = &pstate->core_throttle;
+		else if (event == POWER_LIMIT_EVENT)
+			state = &pstate->core_power_limit;
+		else
+			return;
+	} else if (level == PACKAGE_LEVEL) {
+		if (event == THERMAL_THROTTLING_EVENT)
+			state = &pstate->package_throttle;
+		else if (event == POWER_LIMIT_EVENT)
+			state = &pstate->package_power_limit;
+		else
+			return;
+	} else
+		return;
+
+	old_event = state->new_event;
+	state->new_event = new_event;
+
+	if (new_event)
+		state->count++;
+
+	if (event != THERMAL_THROTTLING_EVENT)
+		return;
+
+	if (new_event && !state->last_interrupt_time) {
+		bool hot;
+		u8 temp;
+
+		get_therm_status(state->level, &hot, &temp);
+		/*
+		 * Ignore short temperature spike as the system is not close
+		 * to PROCHOT. 10C offset is large enough to ignore. It is
+		 * already dropped from the high threshold temperature.
+		 */
+		if (temp > 10)
+			return;
+
+		state->baseline_temp = temp;
+		state->last_interrupt_time = now;
+		schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+	} else if (old_event && state->last_interrupt_time) {
+		unsigned long throttle_time;
+
+		throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
+		if (throttle_time > state->max_time_ms)
+			state->max_time_ms = throttle_time;
+		state->total_time_ms += throttle_time;
+		state->last_interrupt_time = 0;
+	}
+}
+
+static int thresh_event_valid(int level, int event)
+{
+	struct _thermal_state *state;
+	unsigned int this_cpu = smp_processor_id();
+	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
+	u64 now = get_jiffies_64();
+
+	if (level == PACKAGE_LEVEL)
+		state = (event == 0) ? &pstate->pkg_thresh0 :
+						&pstate->pkg_thresh1;
+	else
+		state = (event == 0) ? &pstate->core_thresh0 :
+						&pstate->core_thresh1;
+
+	if (time_before64(now, state->next_check))
+		return 0;
+
+	state->next_check = now + CHECK_INTERVAL;
+
+	return 1;
+}
+
+static bool int_pln_enable;
+static int __init int_pln_enable_setup(char *s)
+{
+	int_pln_enable = true;
+
+	return 1;
+}
+__setup("int_pln_enable", int_pln_enable_setup);
+
+#ifdef CONFIG_SYSFS
+/* Add/Remove thermal_throttle interface for CPU device: */
+static int thermal_throttle_add_dev(struct device *dev, unsigned int cpu)
+{
+	int err;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	err = sysfs_create_group(&dev->kobj, &thermal_attr_group);
+	if (err)
+		return err;
+
+	if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_core_power_limit_count.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+	}
+
+	if (cpu_has(c, X86_FEATURE_PTS)) {
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_count.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_max_time_ms.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_total_time_ms.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+
+		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
+			err = sysfs_add_file_to_group(&dev->kobj,
+					&dev_attr_package_power_limit_count.attr,
+					thermal_attr_group.name);
+			if (err)
+				goto del_group;
+		}
+	}
+
+	return 0;
+
+del_group:
+	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
+
+	return err;
+}
+
+static void thermal_throttle_remove_dev(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
+}
+
+/* Get notified when a cpu comes on/off. Be hotplug friendly. */
+static int thermal_throttle_online(unsigned int cpu)
+{
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
+	struct device *dev = get_cpu_device(cpu);
+	u32 l;
+
+	state->package_throttle.level = PACKAGE_LEVEL;
+	state->core_throttle.level = CORE_LEVEL;
+
+	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
+	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
+
+	/* Unmask the thermal vector after the above workqueues are initialized. */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
+
+	return thermal_throttle_add_dev(dev, cpu);
+}
+
+static int thermal_throttle_offline(unsigned int cpu)
+{
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
+	struct device *dev = get_cpu_device(cpu);
+	u32 l;
+
+	/* Mask the thermal vector before draining evtl. pending work */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+
+	cancel_delayed_work_sync(&state->package_throttle.therm_work);
+	cancel_delayed_work_sync(&state->core_throttle.therm_work);
+
+	state->package_throttle.rate_control_active = false;
+	state->core_throttle.rate_control_active = false;
+
+	thermal_throttle_remove_dev(dev);
+	return 0;
+}
+
+static __init int thermal_throttle_init_device(void)
+{
+	int ret;
+
+	if (!atomic_read(&therm_throt_en))
+		return 0;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",
+				thermal_throttle_online,
+				thermal_throttle_offline);
+	return ret < 0 ? ret : 0;
+}
+device_initcall(thermal_throttle_init_device);
+
+#endif /* CONFIG_SYSFS */
+
+static void notify_package_thresholds(__u64 msr_val)
+{
+	bool notify_thres_0 = false;
+	bool notify_thres_1 = false;
+
+	if (!platform_thermal_package_notify)
+		return;
+
+	/* lower threshold check */
+	if (msr_val & THERM_LOG_THRESHOLD0)
+		notify_thres_0 = true;
+	/* higher threshold check */
+	if (msr_val & THERM_LOG_THRESHOLD1)
+		notify_thres_1 = true;
+
+	if (!notify_thres_0 && !notify_thres_1)
+		return;
+
+	if (platform_thermal_package_rate_control &&
+		platform_thermal_package_rate_control()) {
+		/* Rate control is implemented in callback */
+		platform_thermal_package_notify(msr_val);
+		return;
+	}
+
+	/* lower threshold reached */
+	if (notify_thres_0 && thresh_event_valid(PACKAGE_LEVEL, 0))
+		platform_thermal_package_notify(msr_val);
+	/* higher threshold reached */
+	if (notify_thres_1 && thresh_event_valid(PACKAGE_LEVEL, 1))
+		platform_thermal_package_notify(msr_val);
+}
+
+static void notify_thresholds(__u64 msr_val)
+{
+	/* check whether the interrupt handler is defined;
+	 * otherwise simply return
+	 */
+	if (!platform_thermal_notify)
+		return;
+
+	/* lower threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD0) &&
+			thresh_event_valid(CORE_LEVEL, 0))
+		platform_thermal_notify(msr_val);
+	/* higher threshold reached */
+	if ((msr_val & THERM_LOG_THRESHOLD1) &&
+			thresh_event_valid(CORE_LEVEL, 1))
+		platform_thermal_notify(msr_val);
+}
+
+/* Thermal transition interrupt handler */
+static void intel_thermal_interrupt(void)
+{
+	__u64 msr_val;
+
+	if (static_cpu_has(X86_FEATURE_HWP))
+		wrmsrl_safe(MSR_HWP_STATUS, 0);
+
+	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
+
+	/* Check for violation of core thermal thresholds*/
+	notify_thresholds(msr_val);
+
+	therm_throt_process(msr_val & THERM_STATUS_PROCHOT,
+			    THERMAL_THROTTLING_EVENT,
+			    CORE_LEVEL);
+
+	if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
+		therm_throt_process(msr_val & THERM_STATUS_POWER_LIMIT,
+					POWER_LIMIT_EVENT,
+					CORE_LEVEL);
+
+	if (this_cpu_has(X86_FEATURE_PTS)) {
+		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		/* check violations of package thermal thresholds */
+		notify_package_thresholds(msr_val);
+		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
+					THERMAL_THROTTLING_EVENT,
+					PACKAGE_LEVEL);
+		if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
+			therm_throt_process(msr_val &
+					PACKAGE_THERM_STATUS_POWER_LIMIT,
+					POWER_LIMIT_EVENT,
+					PACKAGE_LEVEL);
+	}
+}
+
+/* Thermal monitoring depends on APIC, ACPI and clock modulation */
+static int intel_thermal_supported(struct cpuinfo_x86 *c)
+{
+	if (!boot_cpu_has(X86_FEATURE_APIC))
+		return 0;
+	if (!cpu_has(c, X86_FEATURE_ACPI) || !cpu_has(c, X86_FEATURE_ACC))
+		return 0;
+	return 1;
+}
+
+void intel_init_thermal(struct cpuinfo_x86 *c)
+{
+	unsigned int cpu = smp_processor_id();
+	int tm2 = 0;
+	u32 l, h;
+
+	if ((c == &boot_cpu_data) && intel_thermal_supported(c))
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+
+	if (!intel_thermal_supported(c))
+		return;
+
+	/*
+	 * First check if its enabled already, in which case there might
+	 * be some SMM goo which handles it, so we can't even put a handler
+	 * since it might be delivered via SMI already:
+	 */
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+
+	h = lvtthmr_init;
+	/*
+	 * The initial value of thermal LVT entries on all APs always reads
+	 * 0x10000 because APs are woken up by BSP issuing INIT-SIPI-SIPI
+	 * sequence to them and LVT registers are reset to 0s except for
+	 * the mask bits which are set to 1s when APs receive INIT IPI.
+	 * If BIOS takes over the thermal interrupt and sets its interrupt
+	 * delivery mode to SMI (not fixed), it restores the value that the
+	 * BIOS has programmed on AP based on BSP's info we saved since BIOS
+	 * is always setting the same value for all threads/cores.
+	 */
+	if ((h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED)
+		apic_write(APIC_LVTTHMR, lvtthmr_init);
+
+
+	if ((l & MSR_IA32_MISC_ENABLE_TM1) && (h & APIC_DM_SMI)) {
+		if (system_state == SYSTEM_BOOTING)
+			pr_debug("CPU%d: Thermal monitoring handled by SMI\n", cpu);
+		return;
+	}
+
+	/* early Pentium M models use different method for enabling TM2 */
+	if (cpu_has(c, X86_FEATURE_TM2)) {
+		if (c->x86 == 6 && (c->x86_model == 9 || c->x86_model == 13)) {
+			rdmsr(MSR_THERM2_CTL, l, h);
+			if (l & MSR_THERM2_CTL_TM_SELECT)
+				tm2 = 1;
+		} else if (l & MSR_IA32_MISC_ENABLE_TM2)
+			tm2 = 1;
+	}
+
+	/* We'll mask the thermal vector in the lapic till we're ready: */
+	h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
+	apic_write(APIC_LVTTHMR, h);
+
+	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
+	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
+		wrmsr(MSR_IA32_THERM_INTERRUPT,
+			(l | (THERM_INT_LOW_ENABLE
+			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
+	else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+		wrmsr(MSR_IA32_THERM_INTERRUPT,
+			l | (THERM_INT_LOW_ENABLE
+			| THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), h);
+	else
+		wrmsr(MSR_IA32_THERM_INTERRUPT,
+		      l | (THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE), h);
+
+	if (cpu_has(c, X86_FEATURE_PTS)) {
+		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				(l | (PACKAGE_THERM_INT_LOW_ENABLE
+				| PACKAGE_THERM_INT_HIGH_ENABLE))
+				& ~PACKAGE_THERM_INT_PLN_ENABLE, h);
+		else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				l | (PACKAGE_THERM_INT_LOW_ENABLE
+				| PACKAGE_THERM_INT_HIGH_ENABLE
+				| PACKAGE_THERM_INT_PLN_ENABLE), h);
+		else
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			      l | (PACKAGE_THERM_INT_LOW_ENABLE
+				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
+	}
+
+	thermal_set_handler(intel_thermal_interrupt);
+
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
+
+	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
+		      tm2 ? "TM2" : "TM1");
+
+	/* enable thermal throttle processing */
+	atomic_set(&therm_throt_en, 1);
+}
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index b81c332..090f917 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -17,8 +17,9 @@
 #include <linux/pm.h>
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
+
 #include <asm/cpu_device_id.h>
-#include <asm/mce.h>
+#include <asm/thermal.h>
 
 /*
 * Rate control delay: Idea is to introduce denounce effect
