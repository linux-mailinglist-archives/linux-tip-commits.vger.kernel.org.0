Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C675FD96B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKOJhm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:37:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOJhl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:37:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY2n-0004I1-17; Fri, 15 Nov 2019 10:37:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9FACC1C08AC;
        Fri, 15 Nov 2019 10:37:32 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:37:32 -0000
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/hyperv] x86/hyperv: Initialize clockevents earlier in CPU onlining
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dexuan Cui <decui@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
References: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <157381065212.29467.1687740076150356688.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/hyperv branch of tip:

Commit-ID:     4df4cb9e99f83b70d54bc0e25081ac23cceafcbc
Gitweb:        https://git.kernel.org/tip/4df4cb9e99f83b70d54bc0e25081ac23cceafcbc
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Wed, 13 Nov 2019 01:11:49 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 10:33:49 +01:00

x86/hyperv: Initialize clockevents earlier in CPU onlining

Hyper-V has historically initialized stimer-based clockevents late in the
process of onlining a CPU because clockevents depend on stimer
interrupts. In the original Hyper-V design, stimer interrupts generate a
VMbus message, so the VMbus machinery must be running first, and VMbus
can't be initialized until relatively late. On x86/64, LAPIC timer based
clockevents are used during early initialization before VMbus and
stimer-based clockevents are ready, and again during CPU offlining after
the stimer clockevents have been shut down.

Unfortunately, this design creates problems when offlining CPUs for
hibernation or other purposes. stimer-based clockevents are shut down
relatively early in the offlining process, so clockevents_unbind_device()
must be used to fallback to the LAPIC-based clockevents for the remainder
of the offlining process.  Furthermore, the late initialization and early
shutdown of stimer-based clockevents doesn't work well on ARM64 since there
is no other timer like the LAPIC to fallback to. So CPU onlining and
offlining doesn't work properly.

Fix this by recognizing that stimer Direct Mode is the normal path for
newer versions of Hyper-V on x86/64, and the only path on other
architectures. With stimer Direct Mode, stimer interrupts don't require any
VMbus machinery. stimer clockevents can be initialized and shut down
consistent with how it is done for other clockevent devices. While the old
VMbus-based stimer interrupts must still be supported for backward
compatibility on x86, that mode of operation can be treated as legacy.

So add a new Hyper-V stimer entry in the CPU hotplug state list, and use
that new state when in Direct Mode. Update the Hyper-V clocksource driver
to allocate and initialize stimer clockevents earlier during boot. Update
Hyper-V initialization and the VMbus driver to use this new design. As a
result, the LAPIC timer is no longer used during boot or CPU
onlining/offlining and clockevents_unbind_device() is not called.  But
retain the old design as a legacy implementation for older versions of
Hyper-V that don't support Direct Mode.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Link: https://lkml.kernel.org/r/1573607467-9456-1-git-send-email-mikelley@microsoft.com
---
 arch/x86/hyperv/hv_init.c          |   6 +-
 drivers/clocksource/hyperv_timer.c | 154 ++++++++++++++++++++++------
 drivers/hv/hv.c                    |   4 +-
 drivers/hv/vmbus_drv.c             |  30 ++---
 include/clocksource/hyperv_timer.h |   7 +-
 include/linux/cpuhotplug.h         |   1 +-
 6 files changed, 151 insertions(+), 51 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2db3972..50ff030 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -311,6 +311,12 @@ void __init hyperv_init(void)
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
+	/*
+	 * Ignore any errors in setting up stimer clockevents
+	 * as we can run with the LAPIC timer as a fallback.
+	 */
+	(void)hv_stimer_alloc();
+
 	hv_apic_init();
 
 	x86_init.pci.arch_init = hv_pci_init;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 2317d4e..287d8d5 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 #include <linux/mm.h>
+#include <linux/cpuhotplug.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -30,6 +31,15 @@ static u64 hv_sched_clock_offset __ro_after_init;
  * mechanism is used when running on older versions of Hyper-V
  * that don't support Direct Mode. While Hyper-V provides
  * four stimer's per CPU, Linux uses only stimer0.
+ *
+ * Because Direct Mode does not require processing a VMbus
+ * message, stimer interrupts can be enabled earlier in the
+ * process of booting a CPU, and consistent with when timer
+ * interrupts are enabled for other clocksource drivers.
+ * However, for legacy versions of Hyper-V when Direct Mode
+ * is not enabled, setting up stimer interrupts must be
+ * delayed until VMbus is initialized and can process the
+ * interrupt message.
  */
 static bool direct_mode_enabled;
 
@@ -102,17 +112,12 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 /*
  * hv_stimer_init - Per-cpu initialization of the clockevent
  */
-void hv_stimer_init(unsigned int cpu)
+static int hv_stimer_init(unsigned int cpu)
 {
 	struct clock_event_device *ce;
 
-	/*
-	 * Synthetic timers are always available except on old versions of
-	 * Hyper-V on x86.  In that case, just return as Linux will use a
-	 * clocksource based on emulated PIT or LAPIC timer hardware.
-	 */
-	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
-		return;
+	if (!hv_clock_event)
+		return 0;
 
 	ce = per_cpu_ptr(hv_clock_event, cpu);
 	ce->name = "Hyper-V clockevent";
@@ -127,28 +132,55 @@ void hv_stimer_init(unsigned int cpu)
 					HV_CLOCK_HZ,
 					HV_MIN_DELTA_TICKS,
 					HV_MAX_MAX_DELTA_TICKS);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(hv_stimer_init);
 
 /*
  * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
  */
-void hv_stimer_cleanup(unsigned int cpu)
+int hv_stimer_cleanup(unsigned int cpu)
 {
 	struct clock_event_device *ce;
 
-	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		ce = per_cpu_ptr(hv_clock_event, cpu);
+	if (!hv_clock_event)
+		return 0;
+
+	/*
+	 * In the legacy case where Direct Mode is not enabled
+	 * (which can only be on x86/64), stimer cleanup happens
+	 * relatively early in the CPU offlining process. We
+	 * must unbind the stimer-based clockevent device so
+	 * that the LAPIC timer can take over until clockevents
+	 * are no longer needed in the offlining process. Note
+	 * that clockevents_unbind_device() eventually calls
+	 * hv_ce_shutdown().
+	 *
+	 * The unbind should not be done when Direct Mode is
+	 * enabled because we may be on an architecture where
+	 * there are no other clockevent devices to fallback to.
+	 */
+	ce = per_cpu_ptr(hv_clock_event, cpu);
+	if (direct_mode_enabled)
 		hv_ce_shutdown(ce);
-	}
+	else
+		clockevents_unbind_device(ce, cpu);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
 
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
-int hv_stimer_alloc(int sint)
+int hv_stimer_alloc(void)
 {
-	int ret;
+	int ret = 0;
+
+	/*
+	 * Synthetic timers are always available except on old versions of
+	 * Hyper-V on x86.  In that case, return as error as Linux will use a
+	 * clockevent based on emulated LAPIC timer hardware.
+	 */
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
+		return -EINVAL;
 
 	hv_clock_event = alloc_percpu(struct clock_event_device);
 	if (!hv_clock_event)
@@ -159,22 +191,78 @@ int hv_stimer_alloc(int sint)
 	if (direct_mode_enabled) {
 		ret = hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
 				hv_stimer0_isr);
-		if (ret) {
-			free_percpu(hv_clock_event);
-			hv_clock_event = NULL;
-			return ret;
-		}
+		if (ret)
+			goto free_percpu;
+
+		/*
+		 * Since we are in Direct Mode, stimer initialization
+		 * can be done now with a CPUHP value in the same range
+		 * as other clockevent devices.
+		 */
+		ret = cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
+				"clockevents/hyperv/stimer:starting",
+				hv_stimer_init, hv_stimer_cleanup);
+		if (ret < 0)
+			goto free_stimer0_irq;
 	}
+	return ret;
 
-	stimer0_message_sint = sint;
-	return 0;
+free_stimer0_irq:
+	hv_remove_stimer0_irq(stimer0_irq);
+	stimer0_irq = 0;
+free_percpu:
+	free_percpu(hv_clock_event);
+	hv_clock_event = NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hv_stimer_alloc);
 
+/*
+ * hv_stimer_legacy_init -- Called from the VMbus driver to handle
+ * the case when Direct Mode is not enabled, and the stimer
+ * must be initialized late in the CPU onlining process.
+ *
+ */
+void hv_stimer_legacy_init(unsigned int cpu, int sint)
+{
+	if (direct_mode_enabled)
+		return;
+
+	/*
+	 * This function gets called by each vCPU, so setting the
+	 * global stimer_message_sint value each time is conceptually
+	 * not ideal, but the value passed in is always the same and
+	 * it avoids introducing yet another interface into this
+	 * clocksource driver just to set the sint in the legacy case.
+	 */
+	stimer0_message_sint = sint;
+	(void)hv_stimer_init(cpu);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_legacy_init);
+
+/*
+ * hv_stimer_legacy_cleanup -- Called from the VMbus driver to
+ * handle the case when Direct Mode is not enabled, and the
+ * stimer must be cleaned up early in the CPU offlining
+ * process.
+ */
+void hv_stimer_legacy_cleanup(unsigned int cpu)
+{
+	if (direct_mode_enabled)
+		return;
+	(void)hv_stimer_cleanup(cpu);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_legacy_cleanup);
+
+
 /* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
 void hv_stimer_free(void)
 {
-	if (direct_mode_enabled && (stimer0_irq != 0)) {
+	if (!hv_clock_event)
+		return;
+
+	if (direct_mode_enabled) {
+		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
 		hv_remove_stimer0_irq(stimer0_irq);
 		stimer0_irq = 0;
 	}
@@ -190,14 +278,20 @@ EXPORT_SYMBOL_GPL(hv_stimer_free);
 void hv_stimer_global_cleanup(void)
 {
 	int	cpu;
-	struct clock_event_device *ce;
 
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		for_each_present_cpu(cpu) {
-			ce = per_cpu_ptr(hv_clock_event, cpu);
-			clockevents_unbind_device(ce, cpu);
-		}
+	/*
+	 * hv_stime_legacy_cleanup() will stop the stimer if Direct
+	 * Mode is not enabled, and fallback to the LAPIC timer.
+	 */
+	for_each_present_cpu(cpu) {
+		hv_stimer_legacy_cleanup(cpu);
 	}
+
+	/*
+	 * If Direct Mode is enabled, the cpuhp teardown callback
+	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
+	 * stimers.
+	 */
 	hv_stimer_free();
 }
 EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fcc5279..6098e0c 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -202,7 +202,7 @@ int hv_synic_init(unsigned int cpu)
 {
 	hv_synic_enable_regs(cpu);
 
-	hv_stimer_init(cpu);
+	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
 
 	return 0;
 }
@@ -277,7 +277,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
-	hv_stimer_cleanup(cpu);
+	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 53a60c8..8c06b33 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1340,10 +1340,6 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_alloc;
 
-	ret = hv_stimer_alloc(VMBUS_MESSAGE_SINT);
-	if (ret < 0)
-		goto err_alloc;
-
 	/*
 	 * Initialize the per-cpu interrupt state and stimer state.
 	 * Then connect to the host.
@@ -1400,9 +1396,8 @@ static int vmbus_bus_init(void)
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
 err_cpuhp:
-	hv_stimer_free();
-err_alloc:
 	hv_synic_free();
+err_alloc:
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
@@ -2315,20 +2310,23 @@ static void hv_crash_handler(struct pt_regs *regs)
 static int hv_synic_suspend(void)
 {
 	/*
-	 * When we reach here, all the non-boot CPUs have been offlined, and
-	 * the stimers on them have been unbound in hv_synic_cleanup() ->
+	 * When we reach here, all the non-boot CPUs have been offlined.
+	 * If we're in a legacy configuration where stimer Direct Mode is
+	 * not enabled, the stimers on the non-boot CPUs have been unbound
+	 * in hv_synic_cleanup() -> hv_stimer_legacy_cleanup() ->
 	 * hv_stimer_cleanup() -> clockevents_unbind_device().
 	 *
-	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled. Here
-	 * we do not unbind the stimer on CPU0 because: 1) it's unnecessary
-	 * because the interrupts remain disabled between syscore_suspend()
-	 * and syscore_resume(): see create_image() and resume_target_kernel();
+	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled.
+	 * Here we do not call hv_stimer_legacy_cleanup() on CPU0 because:
+	 * 1) it's unnecessary as interrupts remain disabled between
+	 * syscore_suspend() and syscore_resume(): see create_image() and
+	 * resume_target_kernel()
 	 * 2) the stimer on CPU0 is automatically disabled later by
 	 * syscore_suspend() -> timekeeping_suspend() -> tick_suspend() -> ...
-	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown(); 3) a warning
-	 * would be triggered if we call clockevents_unbind_device(), which
-	 * may sleep, in an interrupts-disabled context. So, we intentionally
-	 * don't call hv_stimer_cleanup(0) here.
+	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown()
+	 * 3) a warning would be triggered if we call
+	 * clockevents_unbind_device(), which may sleep, in an
+	 * interrupts-disabled context.
 	 */
 
 	hv_synic_disable_regs(0);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 422f5e5..553e539 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -21,10 +21,11 @@
 #define HV_MIN_DELTA_TICKS 1
 
 /* Routines called by the VMbus driver */
-extern int hv_stimer_alloc(int sint);
+extern int hv_stimer_alloc(void);
 extern void hv_stimer_free(void);
-extern void hv_stimer_init(unsigned int cpu);
-extern void hv_stimer_cleanup(unsigned int cpu);
+extern int hv_stimer_cleanup(unsigned int cpu);
+extern void hv_stimer_legacy_init(unsigned int cpu, int sint);
+extern void hv_stimer_legacy_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 068793a..4dcaea1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -129,6 +129,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
+	CPUHP_AP_HYPERV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
