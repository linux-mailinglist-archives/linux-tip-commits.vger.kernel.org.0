Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE93407FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCROe5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhCROey (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 10:34:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F2C06174A;
        Thu, 18 Mar 2021 07:34:54 -0700 (PDT)
Date:   Thu, 18 Mar 2021 14:34:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616078092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/ewoGk78/Eg/0j610ADfWpRrOgxCFvE+Di683U6sJK8=;
        b=g68zD4rTihOh/5mzZvGDI7mZGshPYW3PWN0Eg+WlyBe9rYOFotZuTSULlJKuuu6hfiLpdQ
        UazNumcCXMOHncpgcuXD6Nh++Bq7jlblAq71h7ALdKlnyFsX0Zkoz9NKpeJJ/r8MolhKOY
        Hcj8VNEq0er5eOTOOPCQ1ux5sgu2z8JsdZLxniE6J9LskbsWL7p7FNNAENeqAXP6ond8fU
        bQeA5SnBz072BIEglIXt71bmeSXtodNg9GwD+fSFIrjT3szT+dC91/1h/khjborxEGKQsG
        o6O+k4b1vPIAP4AubiZ0WslmajoLlqfkTsMsucXjrYmbcaX3OZer2tMLLWaJ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616078092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/ewoGk78/Eg/0j610ADfWpRrOgxCFvE+Di683U6sJK8=;
        b=eEGR3/PMRUhd5Dsjz38R3YqP3VRRqN1funsX82lgScHjECghTghRAm82f/oZJTj4Jlv3T8
        60lU+mpcbqYd+FDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix various typos in comments
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161607809057.398.13905578871049588815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33
Gitweb:        https://git.kernel.org/tip/d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 18 Mar 2021 15:28:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 18 Mar 2021 15:31:53 +01:00

x86: Fix various typos in comments

Fix ~144 single-word typos in arch/x86/ code comments.

Doing this in a single commit should reduce the churn.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/crypto/curve25519-x86_64.c       |  6 +++---
 arch/x86/crypto/twofish_glue_3way.c       |  2 +-
 arch/x86/events/amd/core.c                |  2 +-
 arch/x86/events/amd/iommu.h               |  2 +-
 arch/x86/events/core.c                    |  2 +-
 arch/x86/events/intel/core.c              | 12 ++++++------
 arch/x86/events/intel/ds.c                |  2 +-
 arch/x86/events/intel/lbr.c               |  2 +-
 arch/x86/events/intel/p4.c                |  4 ++--
 arch/x86/events/intel/pt.c                |  2 +-
 arch/x86/events/zhaoxin/core.c            |  2 +-
 arch/x86/hyperv/hv_init.c                 |  4 ++--
 arch/x86/include/asm/cmpxchg.h            |  2 +-
 arch/x86/include/asm/idtentry.h           |  2 +-
 arch/x86/include/asm/intel_pconfig.h      |  2 +-
 arch/x86/include/asm/io.h                 |  2 +-
 arch/x86/include/asm/irq_stack.h          |  2 +-
 arch/x86/include/asm/kvm_host.h           |  4 ++--
 arch/x86/include/asm/paravirt_types.h     |  2 +-
 arch/x86/include/asm/pgtable.h            |  2 +-
 arch/x86/include/asm/processor.h          |  2 +-
 arch/x86/include/asm/set_memory.h         |  2 +-
 arch/x86/include/asm/uv/uv_geo.h          |  2 +-
 arch/x86/include/asm/uv/uv_hub.h          |  2 +-
 arch/x86/include/uapi/asm/bootparam.h     |  4 ++--
 arch/x86/include/uapi/asm/msgbuf.h        |  2 +-
 arch/x86/include/uapi/asm/sgx.h           |  2 +-
 arch/x86/include/uapi/asm/shmbuf.h        |  2 +-
 arch/x86/include/uapi/asm/sigcontext.h    |  2 +-
 arch/x86/kernel/acpi/boot.c               |  4 ++--
 arch/x86/kernel/acpi/sleep.c              |  2 +-
 arch/x86/kernel/apic/apic.c               | 10 +++++-----
 arch/x86/kernel/apic/io_apic.c            |  8 ++++----
 arch/x86/kernel/apic/vector.c             |  4 ++--
 arch/x86/kernel/apm_32.c                  |  6 +++---
 arch/x86/kernel/cpu/common.c              |  4 ++--
 arch/x86/kernel/cpu/cyrix.c               |  2 +-
 arch/x86/kernel/cpu/mce/core.c            |  2 +-
 arch/x86/kernel/cpu/mshyperv.c            |  4 ++--
 arch/x86/kernel/cpu/mtrr/cleanup.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  4 ++--
 arch/x86/kernel/cpu/sgx/arch.h            |  2 +-
 arch/x86/kernel/cpu/sgx/main.c            |  4 ++--
 arch/x86/kernel/cpu/topology.c            |  4 ++--
 arch/x86/kernel/e820.c                    |  2 +-
 arch/x86/kernel/fpu/xstate.c              |  2 +-
 arch/x86/kernel/head64.c                  |  2 +-
 arch/x86/kernel/idt.c                     |  2 +-
 arch/x86/kernel/irq.c                     |  2 +-
 arch/x86/kernel/kgdb.c                    |  4 ++--
 arch/x86/kernel/kprobes/ftrace.c          |  2 +-
 arch/x86/kernel/machine_kexec_64.c        |  2 +-
 arch/x86/kernel/process.c                 |  2 +-
 arch/x86/kernel/pvclock.c                 |  2 +-
 arch/x86/kernel/signal.c                  |  2 +-
 arch/x86/kernel/smp.c                     |  2 +-
 arch/x86/kernel/smpboot.c                 |  2 +-
 arch/x86/kernel/sysfb_efi.c               |  2 +-
 arch/x86/kernel/topology.c                |  2 +-
 arch/x86/kernel/traps.c                   |  2 +-
 arch/x86/kernel/tsc.c                     |  6 +++---
 arch/x86/kvm/cpuid.c                      |  2 +-
 arch/x86/kvm/emulate.c                    |  2 +-
 arch/x86/kvm/irq_comm.c                   |  2 +-
 arch/x86/kvm/mmu/mmu.c                    |  2 +-
 arch/x86/kvm/mmu/mmu_internal.h           |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                |  6 +++---
 arch/x86/kvm/pmu.h                        |  2 +-
 arch/x86/kvm/svm/avic.c                   |  2 +-
 arch/x86/kvm/svm/sev.c                    |  2 +-
 arch/x86/kvm/svm/svm.c                    |  2 +-
 arch/x86/kvm/vmx/posted_intr.c            |  2 +-
 arch/x86/kvm/vmx/vmx.c                    |  6 +++---
 arch/x86/kvm/x86.c                        |  6 +++---
 arch/x86/lib/insn-eval.c                  |  6 +++---
 arch/x86/lib/mmx_32.c                     |  2 +-
 arch/x86/mm/fault.c                       |  2 +-
 arch/x86/mm/init.c                        |  4 ++--
 arch/x86/mm/init_64.c                     |  6 +++---
 arch/x86/mm/kaslr.c                       |  2 +-
 arch/x86/mm/kmmio.c                       |  2 +-
 arch/x86/mm/mem_encrypt_boot.S            |  2 +-
 arch/x86/mm/pat/memtype.c                 |  2 +-
 arch/x86/mm/pat/set_memory.c              |  2 +-
 arch/x86/mm/pti.c                         |  4 ++--
 arch/x86/mm/tlb.c                         |  6 +++---
 arch/x86/net/bpf_jit_comp.c               |  4 ++--
 arch/x86/pci/fixup.c                      |  2 +-
 arch/x86/platform/efi/efi_64.c            |  4 ++--
 arch/x86/platform/efi/quirks.c            |  2 +-
 arch/x86/platform/intel-quark/imr.c       |  2 +-
 arch/x86/platform/intel/iosf_mbi.c        |  4 ++--
 arch/x86/platform/uv/uv_nmi.c             |  2 +-
 96 files changed, 144 insertions(+), 144 deletions(-)

diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 5af8021..6706b6c 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -114,11 +114,11 @@ static inline void fadd(u64 *out, const u64 *f1, const u64 *f2)
 	);
 }
 
-/* Computes the field substraction of two field elements */
+/* Computes the field subtraction of two field elements */
 static inline void fsub(u64 *out, const u64 *f1, const u64 *f2)
 {
 	asm volatile(
-		/* Compute the raw substraction of f1-f2 */
+		/* Compute the raw subtraction of f1-f2 */
 		"  movq 0(%1), %%r8;"
 		"  subq 0(%2), %%r8;"
 		"  movq 8(%1), %%r9;"
@@ -135,7 +135,7 @@ static inline void fsub(u64 *out, const u64 *f1, const u64 *f2)
 		"  mov $38, %%rcx;"
 		"  cmovc %%rcx, %%rax;"
 
-		/* Step 2: Substract carry*38 from the original difference */
+		/* Step 2: Subtract carry*38 from the original difference */
 		"  sub %%rax, %%r8;"
 		"  sbb $0, %%r9;"
 		"  sbb $0, %%r10;"
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 0372569..3507cf2 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -117,7 +117,7 @@ static bool is_blacklisted_cpu(void)
 		 * storing blocks in 64bit registers to allow three blocks to
 		 * be processed parallel. Parallel operation then allows gaining
 		 * more performance than was trade off, on out-of-order CPUs.
-		 * However Atom does not benefit from this parallellism and
+		 * However Atom does not benefit from this parallelism and
 		 * should be blacklisted.
 		 */
 		return true;
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 2c1791c..9687a8a 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -623,7 +623,7 @@ static void amd_pmu_disable_all(void)
 	/*
 	 * Check each counter for overflow and wait for it to be reset by the
 	 * NMI if it has overflowed. This relies on the fact that all active
-	 * counters are always enabled when this function is caled and
+	 * counters are always enabled when this function is called and
 	 * ARCH_PERFMON_EVENTSEL_INT is always set.
 	 */
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 0e5c036..e6493a6 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -17,7 +17,7 @@
 #define IOMMU_PC_DEVID_MATCH_REG		0x20
 #define IOMMU_PC_COUNTER_REPORT_REG		0x28
 
-/* maximun specified bank/counters */
+/* maximum specified bank/counters */
 #define PC_MAX_SPEC_BNKS			64
 #define PC_MAX_SPEC_CNTRS			16
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 18df171..4c31cae 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -765,7 +765,7 @@ struct perf_sched {
 };
 
 /*
- * Initialize interator that runs through all events and counters.
+ * Initialize iterator that runs through all events and counters.
  */
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
 			    int num, int wmin, int wmax, int gpmax)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7bbb5bb..5934d7c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -137,7 +137,7 @@ static struct event_constraint intel_ivb_event_constraints[] __read_mostly =
 	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* CPU_CLK_UNHALTED.REF */
 	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4), /* L1D_PEND_MISS.PENDING */
-	INTEL_UEVENT_CONSTRAINT(0x0279, 0xf), /* IDQ.EMTPY */
+	INTEL_UEVENT_CONSTRAINT(0x0279, 0xf), /* IDQ.EMPTY */
 	INTEL_UEVENT_CONSTRAINT(0x019c, 0xf), /* IDQ_UOPS_NOT_DELIVERED.CORE */
 	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf), /* CYCLE_ACTIVITY.CYCLES_LDM_PENDING */
 	INTEL_UEVENT_CONSTRAINT(0x04a3, 0xf), /* CYCLE_ACTIVITY.CYCLES_NO_EXECUTE */
@@ -2186,7 +2186,7 @@ static void intel_pmu_enable_all(int added)
  *   magic three (non-counting) events 0x4300B5, 0x4300D2, and 0x4300B1 either
  *   in sequence on the same PMC or on different PMCs.
  *
- * In practise it appears some of these events do in fact count, and
+ * In practice it appears some of these events do in fact count, and
  * we need to program all 4 events.
  */
 static void intel_pmu_nhm_workaround(void)
@@ -2435,7 +2435,7 @@ static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 
 	/*
 	 * The metric is reported as an 8bit integer fraction
-	 * suming up to 0xff.
+	 * summing up to 0xff.
 	 * slots-in-metric = (Metric / 0xff) * slots
 	 */
 	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
@@ -2824,7 +2824,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	}
 
 	/*
-	 * Intel Perf mertrics
+	 * Intel Perf metrics
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
@@ -4591,7 +4591,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 
 	/*
 	 * Disable the check for real HW, so we don't
-	 * mess with potentionaly enabled registers:
+	 * mess with potentially enabled registers:
 	 */
 	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return true;
@@ -4656,7 +4656,7 @@ static __init void intel_arch_events_quirk(void)
 {
 	int bit;
 
-	/* disable event that reported as not presend by cpuid */
+	/* disable event that reported as not present by cpuid */
 	for_each_set_bit(bit, x86_pmu.events_mask, ARRAY_SIZE(intel_arch_events_map)) {
 		intel_perfmon_event_map[intel_arch_events_map[bit].id] = 0;
 		pr_warn("CPUID marked event: \'%s\' unavailable\n",
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae18..198211c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1805,7 +1805,7 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	 *
 	 *   [-period, 0]
 	 *
-	 * the difference between two consequtive reads is:
+	 * the difference between two consecutive reads is:
 	 *
 	 *   A) value2 - value1;
 	 *      when no overflows have happened in between,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890da..acb04ef 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1198,7 +1198,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		/*
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
-		 * Ensure we don't blindy read any address by validating it is
+		 * Ensure we don't blindly read any address by validating it is
 		 * a known text address.
 		 */
 		if (kernel_text_address(from)) {
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index a4cc660..2aef604 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -24,7 +24,7 @@ struct p4_event_bind {
 	unsigned int escr_msr[2];		/* ESCR MSR for this event */
 	unsigned int escr_emask;		/* valid ESCR EventMask bits */
 	unsigned int shared;			/* event is shared across threads */
-	char cntr[2][P4_CNTR_LIMIT];		/* counter index (offset), -1 on abscence */
+	char cntr[2][P4_CNTR_LIMIT];		/* counter index (offset), -1 on absence */
 };
 
 struct p4_pebs_bind {
@@ -45,7 +45,7 @@ struct p4_pebs_bind {
  * it's needed for mapping P4_PEBS_CONFIG_METRIC_MASK bits of
  * event configuration to find out which values are to be
  * written into MSR_IA32_PEBS_ENABLE and MSR_P4_PEBS_MATRIX_VERT
- * resgisters
+ * registers
  */
 static struct p4_pebs_bind p4_pebs_bind_map[] = {
 	P4_GEN_PEBS_BIND(1stl_cache_load_miss_retired,	0x0000001, 0x0000001),
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e94af4a..9158476 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -362,7 +362,7 @@ static bool pt_event_valid(struct perf_event *event)
 
 	/*
 	 * Setting bit 0 (TraceEn in RTIT_CTL MSR) in the attr.config
-	 * clears the assomption that BranchEn must always be enabled,
+	 * clears the assumption that BranchEn must always be enabled,
 	 * as was the case with the first implementation of PT.
 	 * If this bit is not set, the legacy behavior is preserved
 	 * for compatibility with the older userspace.
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index e68827e..949d845 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -494,7 +494,7 @@ static __init void zhaoxin_arch_events_quirk(void)
 {
 	int bit;
 
-	/* disable event that reported as not presend by cpuid */
+	/* disable event that reported as not present by cpuid */
 	for_each_set_bit(bit, x86_pmu.events_mask, ARRAY_SIZE(zx_arch_events_map)) {
 		zx_pmon_event_map[zx_arch_events_map[bit].id] = 0;
 		pr_warn("CPUID marked event: \'%s\' unavailable\n",
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b81047d..e7b94f6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(hyperv_stop_tsc_emulation);
 static inline bool hv_reenlightenment_available(void)
 {
 	/*
-	 * Check for required features and priviliges to make TSC frequency
+	 * Check for required features and privileges to make TSC frequency
 	 * change notifications work.
 	 */
 	return ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
@@ -292,7 +292,7 @@ static int hv_suspend(void)
 
 	/*
 	 * Reset the hypercall page as it is going to be invalidated
-	 * accross hibernation. Setting hv_hypercall_pg to NULL ensures
+	 * across hibernation. Setting hv_hypercall_pg to NULL ensures
 	 * that any subsequent hypercall operation fails safely instead of
 	 * crashing due to an access of an invalid page. The hypercall page
 	 * pointer is restored on resume.
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 4d4ec5c..94fbe6a 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -22,7 +22,7 @@ extern void __add_wrong_size(void)
 /*
  * Constants for operation sizes. On 32-bit, the 64-bit size it set to
  * -1 because sizeof will never return -1, thereby making those switch
- * case statements guaranteeed dead code which the compiler will
+ * case statements guaranteed dead code which the compiler will
  * eliminate, and allowing the "missing symbol in the default case" to
  * indicate a usage error.
  */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 5eb3bdf..e35e342 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -547,7 +547,7 @@ SYM_CODE_END(spurious_entries_start)
 /*
  * Dummy trap number so the low level ASM macro vector number checks do not
  * match which results in emitting plain IDTENTRY stubs without bells and
- * whistels.
+ * whistles.
  */
 #define X86_TRAP_OTHER		0xFFFF
 
diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
index 3cb002b..994638e 100644
--- a/arch/x86/include/asm/intel_pconfig.h
+++ b/arch/x86/include/asm/intel_pconfig.h
@@ -38,7 +38,7 @@ enum pconfig_leaf {
 #define MKTME_INVALID_ENC_ALG	4
 #define MKTME_DEVICE_BUSY	5
 
-/* Hardware requires the structure to be 256 byte alinged. Otherwise #GP(0). */
+/* Hardware requires the structure to be 256 byte aligned. Otherwise #GP(0). */
 struct mktme_key_program {
 	u16 keyid;
 	u32 keyid_ctrl;
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index d726459..841a5d1 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -159,7 +159,7 @@ static inline void *phys_to_virt(phys_addr_t address)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  * However, we truncate the address to unsigned int to avoid undesirable
- * promitions in legacy drivers.
+ * promotions in legacy drivers.
  */
 static inline unsigned int isa_virt_to_bus(volatile void *address)
 {
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 9b2a0ff..562854c 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -190,7 +190,7 @@
 
 /*
  * Macro to invoke __do_softirq on the irq stack. This is only called from
- * task context when bottom halfs are about to be reenabled and soft
+ * task context when bottom halves are about to be reenabled and soft
  * interrupts are pending to be processed. The interrupt stack cannot be in
  * use here.
  */
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9bc091e..eda93e5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1470,7 +1470,7 @@ extern u64 kvm_mce_cap_supported;
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
- *			should be resued as is, i.e. skip initialization of
+ *			should be reused as is, i.e. skip initialization of
  *			emulation context, instruction fetch and decode.
  *
  * EMULTYPE_TRAP_UD - Set when emulating an intercepted #UD from hardware.
@@ -1495,7 +1495,7 @@ extern u64 kvm_mce_cap_supported;
  *
  * EMULTYPE_VMWARE_GP - Set when emulating an intercepted #GP for VMware
  *			backdoor emulation, which is opt in via module param.
- *			VMware backoor emulation handles select instructions
+ *			VMware backdoor emulation handles select instructions
  *			and reinjects the #GP for all other cases.
  *
  * EMULTYPE_PF - Set when emulating MMIO by way of an intercepted #PF, in which
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de87087..c490308 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -371,7 +371,7 @@ int paravirt_disable_iospace(void);
  * on the stack.  All caller-save registers (eax,edx,ecx) are expected
  * to be modified (either clobbered or used for return values).
  * X86_64, on the other hand, already specifies a register-based calling
- * conventions, returning at %rax, with parameteres going on %rdi, %rsi,
+ * conventions, returning at %rax, with parameters going on %rdi, %rsi,
  * %rdx, and %rcx. Note that for this reason, x86_64 does not need any
  * special handling for dealing with 4 arguments, unlike i386.
  * However, x86_64 also have to clobber all caller saved registers, which
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c672..b1099f2 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1244,7 +1244,7 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
- *  dst - pointer to pgd range anwhere on a pgd page
+ *  dst - pointer to pgd range anywhere on a pgd page
  *  src - ""
  *  count - the number of pgds to copy.
  *
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149..0074e90 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -527,7 +527,7 @@ struct thread_struct {
 	struct io_bitmap	*io_bitmap;
 
 	/*
-	 * IOPL. Priviledge level dependent I/O permission which is
+	 * IOPL. Privilege level dependent I/O permission which is
 	 * emulated via the I/O bitmap to prevent user space from disabling
 	 * interrupts.
 	 */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4352f08..675d84d 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -9,7 +9,7 @@
  * The set_memory_* API can be used to change various attributes of a virtual
  * address range. The attributes include:
  * Cachability   : UnCached, WriteCombining, WriteThrough, WriteBack
- * Executability : eXeutable, NoteXecutable
+ * Executability : eXecutable, NoteXecutable
  * Read/Write    : ReadOnly, ReadWrite
  * Presence      : NotPresent
  * Encryption    : Encrypted, Decrypted
diff --git a/arch/x86/include/asm/uv/uv_geo.h b/arch/x86/include/asm/uv/uv_geo.h
index f241451..027a925 100644
--- a/arch/x86/include/asm/uv/uv_geo.h
+++ b/arch/x86/include/asm/uv/uv_geo.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_UV_GEO_H
 #define _ASM_UV_GEO_H
 
-/* Type declaractions */
+/* Type declarations */
 
 /* Size of a geoid_s structure (must be before decl. of geoid_u) */
 #define GEOID_SIZE	8
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 5002f52..d3e3197 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -353,7 +353,7 @@ union uvh_apicid {
  *
  * Note there are NO leds on a UV system.  This register is only
  * used by the system controller to monitor system-wide operation.
- * There are 64 regs per node.  With Nahelem cpus (2 cores per node,
+ * There are 64 regs per node.  With Nehalem cpus (2 cores per node,
  * 8 cpus per core, 2 threads per cpu) there are 32 cpu threads on
  * a node.
  *
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 600a141..b25d3f8 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -234,7 +234,7 @@ struct boot_params {
  * handling of page tables.
  *
  * These enums should only ever be used by x86 code, and the code that uses
- * it should be well contained and compartamentalized.
+ * it should be well contained and compartmentalized.
  *
  * KVM and Xen HVM do not have a subarch as these are expected to follow
  * standard x86 boot entries. If there is a genuine need for "hypervisor" type
@@ -252,7 +252,7 @@ struct boot_params {
  * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
  * 	which start at asm startup_xen() entry point and later jump to the C
  * 	xen_start_kernel() entry point. Both domU and dom0 type of guests are
- * 	currently supportd through this PV boot path.
+ * 	currently supported through this PV boot path.
  * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
  *	systems which do not have the PCI legacy interfaces.
  * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index b3d0664..ac83e25 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -12,7 +12,7 @@
  * The msqid64_ds structure for x86 architecture with x32 ABI.
  *
  * On x86-32 and x86-64 we can just use the generic definition, but
- * x32 uses the same binary layout as x86_64, which is differnet
+ * x32 uses the same binary layout as x86_64, which is different
  * from other 32-bit architectures.
  */
 
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 9034f30..9690d68 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -152,7 +152,7 @@ struct sgx_enclave_run {
  * Most exceptions reported on ENCLU, including those that occur within the
  * enclave, are fixed up and reported synchronously instead of being delivered
  * via a standard signal. Debug Exceptions (#DB) and Breakpoints (#BP) are
- * never fixed up and are always delivered via standard signals. On synchrously
+ * never fixed up and are always delivered via standard signals. On synchronously
  * reported exceptions, -EFAULT is returned and details about the exception are
  * recorded in @run.exception, the optional sgx_enclave_exception struct.
  *
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index f0305dc..fce18ea 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -9,7 +9,7 @@
  * The shmid64_ds structure for x86 architecture with x32 ABI.
  *
  * On x86-32 and x86-64 we can just use the generic definition, but
- * x32 uses the same binary layout as x86_64, which is differnet
+ * x32 uses the same binary layout as x86_64, which is different
  * from other 32-bit architectures.
  */
 
diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
index 844d60e..d0d9b33 100644
--- a/arch/x86/include/uapi/asm/sigcontext.h
+++ b/arch/x86/include/uapi/asm/sigcontext.h
@@ -139,7 +139,7 @@ struct _fpstate_32 {
  * The 64-bit FPU frame. (FXSAVE format and later)
  *
  * Note1: If sw_reserved.magic1 == FP_XSTATE_MAGIC1 then the structure is
- *        larger: 'struct _xstate'. Note that 'struct _xstate' embedds
+ *        larger: 'struct _xstate'. Note that 'struct _xstate' embeds
  *        'struct _fpstate' so that you can always assume the _fpstate portion
  *        exists so that you can check the magic value.
  *
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7bdc023..c2eee6e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -830,7 +830,7 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
 EXPORT_SYMBOL(acpi_unregister_ioapic);
 
 /**
- * acpi_ioapic_registered - Check whether IOAPIC assoicatied with @gsi_base
+ * acpi_ioapic_registered - Check whether IOAPIC associated with @gsi_base
  *			    has been registered
  * @handle:	ACPI handle of the IOAPIC device
  * @gsi_base:	GSI base associated with the IOAPIC
@@ -1657,7 +1657,7 @@ static int __init parse_acpi(char *arg)
 	else if (strcmp(arg, "noirq") == 0) {
 		acpi_noirq_set();
 	}
-	/* "acpi=copy_dsdt" copys DSDT */
+	/* "acpi=copy_dsdt" copies DSDT */
 	else if (strcmp(arg, "copy_dsdt") == 0) {
 		acpi_gbl_copy_dsdt_locally = 1;
 	}
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index cc1fea7..3f85fca 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -41,7 +41,7 @@ unsigned long acpi_get_wakeup_address(void)
  * x86_acpi_enter_sleep_state - enter sleep state
  * @state: Sleep state to enter.
  *
- * Wrapper around acpi_enter_sleep_state() to be called by assmebly.
+ * Wrapper around acpi_enter_sleep_state() to be called by assembly.
  */
 asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
 {
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index bda4f2a..0a56bc7 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -619,7 +619,7 @@ static void setup_APIC_timer(void)
 
 	if (this_cpu_has(X86_FEATURE_ARAT)) {
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_C3STOP;
-		/* Make LAPIC timer preferrable over percpu HPET */
+		/* Make LAPIC timer preferable over percpu HPET */
 		lapic_clockevent.rating = 150;
 	}
 
@@ -666,7 +666,7 @@ void lapic_update_tsc_freq(void)
  * In this functions we calibrate APIC bus clocks to the external timer.
  *
  * We want to do the calibration only once since we want to have local timer
- * irqs syncron. CPUs connected by the same APIC bus have the very same bus
+ * irqs synchronous. CPUs connected by the same APIC bus have the very same bus
  * frequency.
  *
  * This was previously done by reading the PIT/HPET and waiting for a wrap
@@ -1532,7 +1532,7 @@ static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
  * Most probably by now the CPU has serviced that pending interrupt and it
  * might not have done the ack_APIC_irq() because it thought, interrupt
  * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
- * the ISR bit and cpu thinks it has already serivced the interrupt. Hence
+ * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
  * a vector might get locked. It was noticed for timer irq (vector
  * 0x31). Issue an extra EOI to clear ISR.
  *
@@ -1657,7 +1657,7 @@ static void setup_local_APIC(void)
 	 */
 	/*
 	 * Actually disabling the focus CPU check just makes the hang less
-	 * frequent as it makes the interrupt distributon model be more
+	 * frequent as it makes the interrupt distribution model be more
 	 * like LRU than MRU (the short-term load is more even across CPUs).
 	 */
 
@@ -1875,7 +1875,7 @@ static __init void try_to_enable_x2apic(int remap_mode)
 
 		/*
 		 * Without IR, all CPUs can be addressed by IOAPIC/MSI only
-		 * in physical mode, and CPUs with an APIC ID that cannnot
+		 * in physical mode, and CPUs with an APIC ID that cannot
 		 * be addressed must not be brought online.
 		 */
 		x2apic_set_max_apicid(apic_limit);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c3b60c3..e90cbd6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -928,7 +928,7 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 
 	/*
 	 * setup_IO_APIC_irqs() programs all legacy IRQs with default trigger
-	 * and polarity attirbutes. So allow the first user to reprogram the
+	 * and polarity attributes. So allow the first user to reprogram the
 	 * pin with real trigger and polarity attributes.
 	 */
 	if (irq < nr_legacy_irqs() && data->count == 1) {
@@ -994,7 +994,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 
 	/*
 	 * Legacy ISA IRQ has already been allocated, just add pin to
-	 * the pin list assoicated with this IRQ and program the IOAPIC
+	 * the pin list associated with this IRQ and program the IOAPIC
 	 * entry. The IOAPIC entry
 	 */
 	if (irq_data && irq_data->parent_data) {
@@ -1742,7 +1742,7 @@ static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 		 * with masking the ioapic entry and then polling until
 		 * Remote IRR was clear before reprogramming the
 		 * ioapic I don't trust the Remote IRR bit to be
-		 * completey accurate.
+		 * completely accurate.
 		 *
 		 * However there appears to be no other way to plug
 		 * this race, so if the Remote IRR bit is not
@@ -1820,7 +1820,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 	/*
 	 * Tail end of clearing remote IRR bit (either by delivering the EOI
 	 * message via io-apic EOI register write or simulating it using
-	 * mask+edge followed by unnask+level logic) manually when the
+	 * mask+edge followed by unmask+level logic) manually when the
 	 * level triggered interrupt is seen as the edge triggered interrupt
 	 * at the cpu.
 	 */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c749..6aa27e0 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1045,7 +1045,7 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 *
 		 * But in case of cpu hotplug this should be a non issue
 		 * because if the affinity update happens right before all
-		 * cpus rendevouz in stop machine, there is no way that the
+		 * cpus rendezvous in stop machine, there is no way that the
 		 * interrupt can be blocked on the target cpu because all cpus
 		 * loops first with interrupts enabled in stop machine, so the
 		 * old vector is not yet cleaned up when the interrupt fires.
@@ -1054,7 +1054,7 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 * of the interrupt on the apic/system bus would be delayed
 		 * beyond the point where the target cpu disables interrupts
 		 * in stop machine. I doubt that it can happen, but at least
-		 * there is a theroretical chance. Virtualization might be
+		 * there is a theoretical chance. Virtualization might be
 		 * able to expose this, but AFAICT the IOAPIC emulation is not
 		 * as stupid as the real hardware.
 		 *
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 6602703..abb8dea 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -94,7 +94,7 @@
  *         Remove APM dependencies in arch/i386/kernel/process.c
  *         Remove APM dependencies in drivers/char/sysrq.c
  *         Reset time across standby.
- *         Allow more inititialisation on SMP.
+ *         Allow more initialisation on SMP.
  *         Remove CONFIG_APM_POWER_OFF and make it boot time
  *         configurable (default on).
  *         Make debug only a boot time parameter (remove APM_DEBUG).
@@ -766,7 +766,7 @@ static int apm_driver_version(u_short *val)
  *	not cleared until it is acknowledged.
  *
  *	Additional information is returned in the info pointer, providing
- *	that APM 1.2 is in use. If no messges are pending the value 0x80
+ *	that APM 1.2 is in use. If no messages are pending the value 0x80
  *	is returned (No power management events pending).
  */
 static int apm_get_event(apm_event_t *event, apm_eventinfo_t *info)
@@ -1025,7 +1025,7 @@ static int apm_enable_power_management(int enable)
  *	status which gives the rough battery status, and current power
  *	source. The bat value returned give an estimate as a percentage
  *	of life and a status value for the battery. The estimated life
- *	if reported is a lifetime in secodnds/minutes at current powwer
+ *	if reported is a lifetime in secodnds/minutes at current power
  *	consumption.
  */
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640ab..1aa5f0a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -482,7 +482,7 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	if (pk)
 		pk->pkru = init_pkru_value;
 	/*
-	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
+	 * Setting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
 	 * update that bit in this CPU's "cpu_info".
 	 */
@@ -1404,7 +1404,7 @@ static void detect_null_seg_behavior(struct cpuinfo_x86 *c)
 	 * where GS is unused by the prev and next threads.
 	 *
 	 * Since neither vendor documents this anywhere that I can see,
-	 * detect it directly instead of hardcoding the choice by
+	 * detect it directly instead of hard-coding the choice by
 	 * vendor.
 	 *
 	 * I've designated AMD's behavior as the "bug" because it's
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 1d9b8aa..7227c15 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -291,7 +291,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 			mark_tsc_unstable("cyrix 5510/5520 detected");
 	}
 #endif
-		c->x86_cache_size = 16;	/* Yep 16K integrated cache thats it */
+		c->x86_cache_size = 16;	/* Yep 16K integrated cache that's it */
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7962355..bf7fe87 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -529,7 +529,7 @@ static void mce_irq_work_cb(struct irq_work *entry)
  * Check if the address reported by the CPU is in a format we can parse.
  * It would be possible to add code for most other cases, but all would
  * be somewhat complicated (e.g. segment offset would require an instruction
- * parser). So only support physical addresses up to page granuality for now.
+ * parser). So only support physical addresses up to page granularity for now.
  */
 int mce_usable_address(struct mce *m)
 {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e88bc29..415bc05 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -197,7 +197,7 @@ static unsigned char hv_get_nmi_reason(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 /*
  * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
- * it dificult to process CHANNELMSG_UNLOAD in case of crash. Handle
+ * it difficult to process CHANNELMSG_UNLOAD in case of crash. Handle
  * unknown NMI on the first CPU which gets it.
  */
 static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)
@@ -428,7 +428,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/*
 	 * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
-	 * set x2apic destination mode to physcial mode when x2apic is available
+	 * set x2apic destination mode to physical mode when x2apic is available
 	 * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
 	 * have 8-bit APIC id.
 	 */
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 9231640..0c3b372 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -434,7 +434,7 @@ set_var_mtrr_range(struct var_mtrr_state *state, unsigned long base_pfn,
 	state->range_sizek  = sizek - second_sizek;
 }
 
-/* Mininum size of mtrr block that can take hole: */
+/* Minimum size of mtrr block that can take hole: */
 static u64 mtrr_chunk_size __initdata = (256ULL<<20);
 
 static int __init parse_mtrr_chunk_size_opt(char *p)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 698bb26..23001ae 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -192,7 +192,7 @@ static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
  *	Intel(R) Xeon(R)  CPU E5-2608L v3  @  2.00GHz
  *	Intel(R) Xeon(R)  CPU E5-2658A v3  @  2.20GHz
  *
- * Probe by trying to write the first of the L3 cach mask registers
+ * Probe by trying to write the first of the L3 cache mask registers
  * and checking that the bits stick. Max CLOSids is always 4 and max cbm length
  * is always 20 on hsw server parts. The minimum cache bitmask length
  * allowed for HSW server is always 2 bits. Hardcode all of them.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7ac3121..98c0e21 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -387,7 +387,7 @@ void mon_event_count(void *info)
  * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
  * that:
  *
- *   current bandwdith(cur_bw) < user specified bandwidth(user_bw)
+ *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
  *
  * This uses the MBM counters to measure the bandwidth and MBA throttle
  * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index e916646..935af2a 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		 * If the thread does not get on the CPU for whatever
 		 * reason and the process which sets up the region is
 		 * interrupted then this will leave the thread in runnable
-		 * state and once it gets on the CPU it will derefence
+		 * state and once it gets on the CPU it will dereference
 		 * the cleared, but not freed, plr struct resulting in an
 		 * empty pseudo-locking loop.
 		 */
@@ -1391,7 +1391,7 @@ out:
  * group is removed from user space via a "rmdir" from userspace or the
  * unmount of the resctrl filesystem. On removal the resource group does
  * not go back to pseudo-locksetup mode before it is removed, instead it is
- * removed directly. There is thus assymmetry with the creation where the
+ * removed directly. There is thus asymmetry with the creation where the
  * &struct pseudo_lock_region is removed here while it was not created in
  * rdtgroup_pseudo_lock_create().
  *
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f9190ad..2392f9f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * User interface for Resource Alloction in Resource Director Technology(RDT)
+ * User interface for Resource Allocation in Resource Director Technology(RDT)
  *
  * Copyright (C) 2016 Intel Corporation
  *
@@ -294,7 +294,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 /*
  * This is safe against resctrl_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
- * from update_closid_rmid() is proteced against __switch_to() because
+ * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
  */
 static void update_cpu_closid_rmid(void *info)
diff --git a/arch/x86/kernel/cpu/sgx/arch.h b/arch/x86/kernel/cpu/sgx/arch.h
index dd7602c..26315be 100644
--- a/arch/x86/kernel/cpu/sgx/arch.h
+++ b/arch/x86/kernel/cpu/sgx/arch.h
@@ -271,7 +271,7 @@ struct sgx_pcmd {
  * @header1:		constant byte string
  * @vendor:		must be either 0x0000 or 0x8086
  * @date:		YYYYMMDD in BCD
- * @header2:		costant byte string
+ * @header2:		constant byte string
  * @swdefined:		software defined value
  */
 struct sgx_sigstruct_header {
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8df81a3..9ea55fd 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -195,10 +195,10 @@ static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
 
 /*
  * Swap page to the regular memory transformed to the blocked state by using
- * EBLOCK, which means that it can no loger be referenced (no new TLB entries).
+ * EBLOCK, which means that it can no longer be referenced (no new TLB entries).
  *
  * The first trial just tries to write the page assuming that some other thread
- * has reset the count for threads inside the enlave by using ETRACK, and
+ * has reset the count for threads inside the enclave by using ETRACK, and
  * previous thread count has been zeroed out. The second trial calls ETRACK
  * before EWB. If that fails we kick all the HW threads out, and then do EWB,
  * which should be guaranteed the succeed.
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 8678864..132a2de 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -30,7 +30,7 @@ EXPORT_SYMBOL(__max_die_per_package);
 
 #ifdef CONFIG_SMP
 /*
- * Check if given CPUID extended toplogy "leaf" is implemented
+ * Check if given CPUID extended topology "leaf" is implemented
  */
 static int check_extended_topology_leaf(int leaf)
 {
@@ -44,7 +44,7 @@ static int check_extended_topology_leaf(int leaf)
 	return 0;
 }
 /*
- * Return best CPUID Extended Toplogy Leaf supported
+ * Return best CPUID Extended Topology Leaf supported
  */
 static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
 {
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 22aad41..f74cb7d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -793,7 +793,7 @@ core_initcall(e820__register_nvs_regions);
 #endif
 
 /*
- * Allocate the requested number of bytes with the requsted alignment
+ * Allocate the requested number of bytes with the requested alignment
  * and return (the physical address) to the caller. Also register this
  * range in the 'kexec' E820 table as a reserved range.
  *
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 683749b..a85c640 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -253,7 +253,7 @@ static bool xfeature_enabled(enum xfeature xfeature)
 static void __init setup_xstate_features(void)
 {
 	u32 eax, ebx, ecx, edx, i;
-	/* start at the beginnning of the "extended state" */
+	/* start at the beginning of the "extended state" */
 	unsigned int last_good_offset = offsetof(struct xregs_state,
 						 extended_state_area);
 	/*
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5e9beb7..18be441 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -104,7 +104,7 @@ static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 static bool __head check_la57_support(unsigned long physaddr)
 {
 	/*
-	 * 5-level paging is detected and enabled at kernel decomression
+	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
 	 */
 	if (!(native_read_cr4() & X86_CR4_LA57))
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index ee1a283..d552f17 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -245,7 +245,7 @@ static const __initconst struct idt_data ist_idts[] = {
  * after that.
  *
  * Note, that X86_64 cannot install the real #PF handler in
- * idt_setup_early_traps() because the memory intialization needs the #PF
+ * idt_setup_early_traps() because the memory initialization needs the #PF
  * handler from the early_idt_handler_array to initialize the early page
  * tables.
  */
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 58aa712..e28f6a5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -338,7 +338,7 @@ void fixup_irqs(void)
 	irq_migrate_all_off_this_cpu();
 
 	/*
-	 * We can remove mdelay() and then send spuriuous interrupts to
+	 * We can remove mdelay() and then send spurious interrupts to
 	 * new cpu targets for all the irqs that were handled previously by
 	 * this cpu. While it works, I have seen spurious interrupt messages
 	 * (nothing wrong but still...).
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index ff7878d..3a43a2d 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -17,7 +17,7 @@
  *  Updated by:	     Tom Rini <trini@kernel.crashing.org>
  *  Updated by:	     Jason Wessel <jason.wessel@windriver.com>
  *  Modified for 386 by Jim Kingdon, Cygnus Support.
- *  Origianl kgdb, compatibility with 2.1.xx kernel by
+ *  Original kgdb, compatibility with 2.1.xx kernel by
  *  David Grothe <dave@gcom.com>
  *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
  *  X86_64 changes from Andi Kleen's patch merged by Jim Houston
@@ -642,7 +642,7 @@ void kgdb_arch_late(void)
 	struct perf_event **pevent;
 
 	/*
-	 * Pre-allocate the hw breakpoint structions in the non-atomic
+	 * Pre-allocate the hw breakpoint instructions in the non-atomic
 	 * portion of kgdb because this operation requires mutexs to
 	 * complete.
 	 */
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 373e5fa..596de2f 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+/* Ftrace callback handler for kprobes -- called under preempt disabled */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a..f01cd9a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -260,7 +260,7 @@ static void set_idt(void *newidt, u16 limit)
 {
 	struct desc_ptr curidt;
 
-	/* x86-64 supports unaliged loads & stores */
+	/* x86-64 supports unaligned loads & stores */
 	curidt.size    = limit;
 	curidt.address = (unsigned long)newidt;
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9c214d7..cdfe5b4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -451,7 +451,7 @@ void speculative_store_bypass_ht_init(void)
 	 * First HT sibling to come up on the core.  Link shared state of
 	 * the first HT sibling to itself. The siblings on the same core
 	 * which come up later will see the shared state pointer and link
-	 * themself to the state of this CPU.
+	 * themselves to the state of this CPU.
 	 */
 	st->shared_state = st;
 }
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 11065dc..eda37df 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -89,7 +89,7 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	/*
 	 * Assumption here is that last_value, a global accumulator, always goes
 	 * forward. If we are less than that, we should not be much smaller.
-	 * We assume there is an error marging we're inside, and then the correction
+	 * We assume there is an error margin we're inside, and then the correction
 	 * does not sacrifice accuracy.
 	 *
 	 * For reads: global may have changed between test and return,
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ea794a0..4de9b1d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -492,7 +492,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 * SS descriptor, but we do need SS to be valid.  It's possible
 	 * that the old SS is entirely bogus -- this can happen if the
 	 * signal we're trying to deliver is #GP or #SS caused by a bad
-	 * SS value.  We also have a compatbility issue here: DOSEMU
+	 * SS value.  We also have a compatibility issue here: DOSEMU
 	 * relies on the contents of the SS register indicating the
 	 * SS value at the time of the signal, even though that code in
 	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index eff4ce3..dbd68f3 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -67,7 +67,7 @@
  *	5AP.	symmetric IO mode (normal Linux operation) not affected.
  *		'noapic' mode has vector 0xf filled out properly.
  *	6AP.	'noapic' mode might be affected - fixed in later steppings
- *	7AP.	We do not assume writes to the LVT deassering IRQs
+ *	7AP.	We do not assume writes to the LVT deasserting IRQs
  *	8AP.	We do not enable low power mode (deep sleep) during MP bootup
  *	9AP.	We do not use mixed mode
  *
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7..2406c7f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1407,7 +1407,7 @@ void __init calculate_max_logical_packages(void)
 	int ncpus;
 
 	/*
-	 * Today neither Intel nor AMD support heterogenous systems so
+	 * Today neither Intel nor AMD support heterogeneous systems so
 	 * extrapolate the boot cpu's data to all packages.
 	 */
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
diff --git a/arch/x86/kernel/sysfb_efi.c b/arch/x86/kernel/sysfb_efi.c
index 653b7f6..8a56a6d 100644
--- a/arch/x86/kernel/sysfb_efi.c
+++ b/arch/x86/kernel/sysfb_efi.c
@@ -10,7 +10,7 @@
  * EFI Quirks
  * Several EFI systems do not correctly advertise their boot framebuffers.
  * Hence, we use this static table of known broken machines and fix up the
- * information so framebuffer drivers can load corectly.
+ * information so framebuffer drivers can load correctly.
  */
 
 #include <linux/dmi.h>
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index f5477ea..bd83748 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -113,7 +113,7 @@ int arch_register_cpu(int num)
 	 * Two known BSP/CPU0 dependencies: Resume from suspend/hibernate
 	 * depends on BSP. PIC interrupts depend on BSP.
 	 *
-	 * If the BSP depencies are under control, one can tell kernel to
+	 * If the BSP dependencies are under control, one can tell kernel to
 	 * enable BSP hotplug. This basically adds a control file and
 	 * one can attempt to offline BSP.
 	 */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a..9a1b23c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -395,7 +395,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		/*
 		 * Adjust our frame so that we return straight to the #GP
 		 * vector with the expected RSP value.  This is safe because
-		 * we won't enable interupts or schedule before we invoke
+		 * we won't enable interrupts or schedule before we invoke
 		 * general_protection, so nothing will clobber the stack
 		 * frame we just set up.
 		 *
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc..5d042b3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -739,7 +739,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 	 * 2) Reference counter. If available we use the HPET or the
 	 * PMTIMER as a reference to check the sanity of that value.
 	 * We use separate TSC readouts and check inside of the
-	 * reference read for any possible disturbance. We dicard
+	 * reference read for any possible disturbance. We discard
 	 * disturbed values here as well. We do that around the PIT
 	 * calibration delay loop as we have to wait for a certain
 	 * amount of time anyway.
@@ -1079,7 +1079,7 @@ static void tsc_resume(struct clocksource *cs)
  * very small window right after one CPU updated cycle_last under
  * xtime/vsyscall_gtod lock and the other CPU reads a TSC value which
  * is smaller than the cycle_last reference value due to a TSC which
- * is slighty behind. This delta is nowhere else observable, but in
+ * is slightly behind. This delta is nowhere else observable, but in
  * that case it results in a forward time jump in the range of hours
  * due to the unsigned delta calculation of the time keeping core
  * code, which is necessary to support wrapping clocksources like pm
@@ -1264,7 +1264,7 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  *	corresponding clocksource
  *	@cycles:	System counter value
  *	@cs:		Clocksource corresponding to system counter value. Used
- *			by timekeeping code to verify comparibility of two cycle
+ *			by timekeeping code to verify comparability of two cycle
  *			values.
  */
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6bd2f8b..c02466a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1033,7 +1033,7 @@ EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
  *  - Centaur:    0xc0000000 - 0xcfffffff
  *
  * The Hypervisor class is further subdivided into sub-classes that each act as
- * their own indepdent class associated with a 0x100 byte range.  E.g. if Qemu
+ * their own independent class associated with a 0x100 byte range.  E.g. if Qemu
  * is advertising support for both HyperV and KVM, the resulting Hypervisor
  * CPUID sub-classes are:
  *
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index f7970ba..cdd2a2b 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3222,7 +3222,7 @@ static int load_state_from_tss32(struct x86_emulate_ctxt *ctxt,
 	}
 
 	/*
-	 * Now load segment descriptors. If fault happenes at this stage
+	 * Now load segment descriptors. If fault happens at this stage
 	 * it is handled in a context of new task
 	 */
 	ret = __load_segment_descriptor(ctxt, tss->ldt_selector, VCPU_SREG_LDTR,
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 8a4de3f..d5b72a0 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -269,7 +269,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 			  const struct kvm_irq_routing_entry *ue)
 {
 	/* We can't check irqchip_in_kernel() here as some callers are
-	 * currently inititalizing the irqchip. Other callers should therefore
+	 * currently initializing the irqchip. Other callers should therefore
 	 * check kvm_arch_can_set_irq_routing() before calling this function.
 	 */
 	switch (ue->type) {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d75524b..b6f9a81 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4961,7 +4961,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 
 	/*
 	 * No need to care whether allocation memory is successful
-	 * or not since pte prefetch is skiped if it does not have
+	 * or not since pte prefetch is skipped if it does not have
 	 * enough objects in the cache.
 	 */
 	mmu_topup_memory_caches(vcpu, true);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ec4fc28..d708f47 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -59,7 +59,7 @@ struct kvm_mmu_page {
 #ifdef CONFIG_X86_64
 	bool tdp_mmu_page;
 
-	/* Used for freeing the page asyncronously if it is a TDP MMU page. */
+	/* Used for freeing the page asynchronously if it is a TDP MMU page. */
 	struct rcu_head rcu_head;
 #endif
 };
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d789150..f56ddc2 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -404,7 +404,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	 * If this warning were to trigger it would indicate that there was a
 	 * missing MMU notifier or a race with some notifier handler.
 	 * A present, leaf SPTE should never be directly replaced with another
-	 * present leaf SPTE pointing to a differnt PFN. A notifier handler
+	 * present leaf SPTE pointing to a different PFN. A notifier handler
 	 * should be zapping the SPTE before the main MM's page table is
 	 * changed, or the SPTE should be zeroed, and the TLBs flushed by the
 	 * thread before replacement.
@@ -418,7 +418,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 		/*
 		 * Crash the host to prevent error propagation and guest data
-		 * courruption.
+		 * corruption.
 		 */
 		BUG();
 	}
@@ -533,7 +533,7 @@ static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	/*
 	 * No other thread can overwrite the removed SPTE as they
 	 * must either wait on the MMU lock or use
-	 * tdp_mmu_set_spte_atomic which will not overrite the
+	 * tdp_mmu_set_spte_atomic which will not overwrite the
 	 * special removed SPTE value. No bookkeeping is needed
 	 * here since the SPTE is going from non-present
 	 * to non-present.
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 7b30bc9..67e753e 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -103,7 +103,7 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
 
 /* returns general purpose PMC with the specified MSR. Note that it can be
  * used for both PERFCTRn and EVNTSELn; that is why it accepts base as a
- * paramenter to tell them apart.
+ * parameter to tell them apart.
  */
 static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
 					 u32 base)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 78bdcfa..80010f9 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -838,7 +838,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
 		 * 2. Unsetting posted interrupt.
-		 * 3. APIC virtialization is disabled for the vcpu.
+		 * 3. APIC virtualization is disabled for the vcpu.
 		 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
 		 */
 		if (!get_pi_vcpu_info(kvm, e, &vcpu_info, &svm) && set &&
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 874ea30..2b27a94 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2082,7 +2082,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
 	hostsa = (struct vmcb_save_area *)(page_address(sd->save_area) + 0x400);
 	hostsa->xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 
-	/* PKRU is restored on VMEXIT, save the curent host value */
+	/* PKRU is restored on VMEXIT, save the current host value */
 	hostsa->pkru = read_pkru();
 
 	/* MSR_IA32_XSS is restored on VMEXIT, save the currnet host value */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58a45bb..6dad892 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4400,7 +4400,7 @@ static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, void *insn, int i
 	 *
 	 * This happens because CPU microcode reading instruction bytes
 	 * uses a special opcode which attempts to read data using CPL=0
-	 * priviledges. The microcode reads CS:RIP and if it hits a SMAP
+	 * privileges. The microcode reads CS:RIP and if it hits a SMAP
 	 * fault, it gives up and returns no instruction bytes.
 	 *
 	 * Detection:
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4831bc4..4597486 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -10,7 +10,7 @@
 #include "vmx.h"
 
 /*
- * We maintian a per-CPU linked-list of vCPU, so in wakeup_handler() we
+ * We maintain a per-CPU linked-list of vCPU, so in wakeup_handler() we
  * can find which vCPU should be waken up.
  */
 static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 32cf828..bdd94bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1529,7 +1529,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 
 	/*
 	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
-	 * utilize encodings marked reserved will casue a #GP fault.
+	 * utilize encodings marked reserved will cause a #GP fault.
 	 */
 	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_periods);
 	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
@@ -2761,7 +2761,7 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	/*
-	 * Update real mode segment cache. It may be not up-to-date if sement
+	 * Update real mode segment cache. It may be not up-to-date if segment
 	 * register was written while vcpu was in a guest mode.
 	 */
 	vmx_get_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_ES], VCPU_SREG_ES);
@@ -7252,7 +7252,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
 		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
 
-	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
+	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabricEn can be set */
 	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys))
 		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index edf96b3..f046b08 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -156,9 +156,9 @@ module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
 
 /*
  * lapic timer advance (tscdeadline mode only) in nanoseconds.  '-1' enables
- * adaptive tuning starting from default advancment of 1000ns.  '0' disables
+ * adaptive tuning starting from default advancement of 1000ns.  '0' disables
  * advancement entirely.  Any other value is used as-is and disables adaptive
- * tuning, i.e. allows priveleged userspace to set an exact advancement time.
+ * tuning, i.e. allows privileged userspace to set an exact advancement time.
  */
 static int __read_mostly lapic_timer_advance_ns = -1;
 module_param(lapic_timer_advance_ns, int, S_IRUGO | S_IWUSR);
@@ -1373,7 +1373,7 @@ static u64 kvm_get_arch_capabilities(void)
 	/*
 	 * If nx_huge_pages is enabled, KVM's shadow paging will ensure that
 	 * the nested hypervisor runs with NX huge pages.  If it is not,
-	 * L1 is anyway vulnerable to ITLB_MULTIHIT explots from other
+	 * L1 is anyway vulnerable to ITLB_MULTIHIT exploits from other
 	 * L1 guests, so it need not worry about its own (L2) guests.
 	 */
 	data |= ARCH_CAP_PSCHANGE_MC_NO;
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index bb0b3fe..2bf07e1 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -232,7 +232,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  * resolve_seg_reg() - obtain segment register index
  * @insn:	Instruction with operands
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to deterimine segment register
+ * @regoff:	Operand offset, in pt_regs, used to determine segment register
  *
  * Determine the segment register associated with the operands and, if
  * applicable, prefixes and the instruction pointed by @insn.
@@ -517,7 +517,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
  * @insn:	Instruction containing ModRM byte
  * @regs:	Register values as seen when entering kernel mode
  * @offs1:	Offset of the first operand register
- * @offs2:	Offset of the second opeand register, if applicable
+ * @offs2:	Offset of the second operand register, if applicable
  *
  * Obtain the offset, in pt_regs, of the registers indicated by the ModRM byte
  * in @insn. This function is to be used with 16-bit address encodings. The
@@ -576,7 +576,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
 	 * If ModRM.mod is 0 and ModRM.rm is 110b, then we use displacement-
 	 * only addressing. This means that no registers are involved in
 	 * computing the effective address. Thus, ensure that the first
-	 * register offset is invalild. The second register offset is already
+	 * register offset is invalid. The second register offset is already
 	 * invalid under the aforementioned conditions.
 	 */
 	if ((X86_MODRM_MOD(insn->modrm.value) == 0) &&
diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
index 419365c..cc5f4ea 100644
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -14,7 +14,7 @@
  *	tested so far for any MMX solution figured.
  *
  *	22/09/2000 - Arjan van de Ven
- *		Improved for non-egineering-sample Athlons
+ *		Improved for non-engineering-sample Athlons
  *
  */
 #include <linux/hardirq.h>
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e..ea70b82 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1523,7 +1523,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 *
 	 * In case the fault hit a RCU idle region the conditional entry
 	 * code reenabled RCU to avoid subsequent wreckage which helps
-	 * debugability.
+	 * debuggability.
 	 */
 	state = irqentry_enter(regs);
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd694fb..742fbdf 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -29,7 +29,7 @@
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
- * is only compied when SMP=y.
+ * is only compiled when SMP=y.
  */
 #define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
@@ -939,7 +939,7 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	/*
 	 * end could be not aligned, and We can not align that,
-	 * decompresser could be confused by aligned initrd_end
+	 * decompressor could be confused by aligned initrd_end
 	 * We already reserve the end partial page before in
 	 *   - i386_start_kernel()
 	 *   - x86_64_start_kernel()
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4..5524745 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -172,7 +172,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 
 		/*
 		 * With folded p4d, pgd_none() is always false, we need to
-		 * handle synchonization on p4d level.
+		 * handle synchronization on p4d level.
 		 */
 		MAYBE_BUILD_BUG_ON(pgd_none(*pgd_ref));
 		p4d_ref = p4d_offset(pgd_ref, addr);
@@ -986,7 +986,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
 			/*
 			 * Do not free direct mapping pages since they were
-			 * freed when offlining, or simplely not in use.
+			 * freed when offlining, or simply not in use.
 			 */
 			if (!direct)
 				free_pagetable(pte_page(*pte), 0);
@@ -1004,7 +1004,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 			 *
 			 * If we are not removing the whole page, it means
 			 * other page structs in this page are being used and
-			 * we canot remove them. So fill the unused page_structs
+			 * we cannot remove them. So fill the unused page_structs
 			 * with 0xFD, and remove the page when it is wholly
 			 * filled with 0xFD.
 			 */
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 6e6b397..557f0fe 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -96,7 +96,7 @@ void __init kernel_randomize_memory(void)
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
 		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
-	/* Adapt phyiscal memory region size based on available memory */
+	/* Adapt physical memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
 		kaslr_regions[0].size_tb = memory_tb;
 
diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index be020a7..d3efbc5 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Support for MMIO probes.
- * Benfit many code from kprobes
+ * Benefit many code from kprobes
  * (C) 2002 Louis Zhuang <louis.zhuang@intel.com>.
  *     2007 Alexander Eichner
  *     2008 Pekka Paalanen <pq@iki.fi>
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 7a84fc8..17d292b 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -27,7 +27,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 	 *     - stack page (PAGE_SIZE)
 	 *     - encryption routine page (PAGE_SIZE)
 	 *     - intermediate copy buffer (PMD_PAGE_SIZE)
-	 *    R8 - physcial address of the pagetables to use for encryption
+	 *    R8 - physical address of the pagetables to use for encryption
 	 */
 
 	push	%rbp
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index ca311aa..6084d14 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -695,7 +695,7 @@ int memtype_free(u64 start, u64 end)
 
 
 /**
- * lookup_memtype - Looksup the memory type for a physical address
+ * lookup_memtype - Looks up the memory type for a physical address
  * @paddr: physical address of which memory type needs to be looked up
  *
  * Only to be called when PAT is enabled
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c..4279806 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -680,7 +680,7 @@ pmd_t *lookup_pmd_address(unsigned long address)
  * end up in this kind of memory, for instance.
  *
  * This could be optimized, but it is only intended to be
- * used at inititalization time, and keeping it
+ * used at initialization time, and keeping it
  * unoptimized should increase the testing coverage for
  * the more obscure platforms.
  */
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab929..b377604 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -361,7 +361,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 * global, so set it as global in both copies.  Note:
 			 * the X86_FEATURE_PGE check is not _required_ because
 			 * the CPU ignores _PAGE_GLOBAL when PGE is not
-			 * supported.  The check keeps consistentency with
+			 * supported.  The check keeps consistency with
 			 * code that only set this bit when supported.
 			 */
 			if (boot_cpu_has(X86_FEATURE_PGE))
@@ -512,7 +512,7 @@ static void pti_clone_entry_text(void)
 static inline bool pti_kernel_image_global_ok(void)
 {
 	/*
-	 * Systems with PCIDs get litlle benefit from global
+	 * Systems with PCIDs get little benefit from global
 	 * kernel text and are not worth the downsides.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_PCID))
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 569ac1d..98f2695 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -106,7 +106,7 @@ static inline u16 kern_pcid(u16 asid)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/*
-	 * Make sure that the dynamic ASID space does not confict with the
+	 * Make sure that the dynamic ASID space does not conflict with the
 	 * bit we are using to switch between user and kernel ASIDs.
 	 */
 	BUILD_BUG_ON(TLB_NR_DYN_ASIDS >= (1 << X86_CR3_PTI_PCID_USER_BIT));
@@ -736,7 +736,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 *    3, we'd be break the invariant: we'd update local_tlb_gen above
 	 *    1 without the full flush that's needed for tlb_gen 2.
 	 *
-	 * 2. f->new_tlb_gen == mm_tlb_gen.  This is purely an optimiation.
+	 * 2. f->new_tlb_gen == mm_tlb_gen.  This is purely an optimization.
 	 *    Partial TLB flushes are not all that much cheaper than full TLB
 	 *    flushes, so it seems unlikely that it would be a performance win
 	 *    to do a partial flush if that won't bring our TLB fully up to
@@ -876,7 +876,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 static inline void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
-	/* Complete reentrency prevention checks */
+	/* Complete reentrancy prevention checks */
 	barrier();
 	this_cpu_dec(flush_tlb_info_idx);
 #endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6926d0c..3a310da 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1556,7 +1556,7 @@ emit_cond_jmp:		/* Convert BPF opcode to x86 */
 			if (is_imm8(jmp_offset)) {
 				if (jmp_padding) {
 					/* To keep the jmp_offset valid, the extra bytes are
-					 * padded before the jump insn, so we substract the
+					 * padded before the jump insn, so we subtract the
 					 * 2 bytes of jmp_cond insn from INSN_SZ_DIFF.
 					 *
 					 * If the previous pass already emits an imm8
@@ -1631,7 +1631,7 @@ emit_jmp:
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
 					 * are padded before the actual jmp insn, so
-					 * 2 bytes is substracted from INSN_SZ_DIFF.
+					 * 2 bytes is subtracted from INSN_SZ_DIFF.
 					 *
 					 * If the previous pass already emits an imm8
 					 * jmp, there is nothing to pad (0 byte).
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0a0e168..02dc646 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -375,7 +375,7 @@ static const struct dmi_system_id msi_k8t_dmi_table[] = {
  * The BIOS only gives options "DISABLED" and "AUTO". This code sets
  * the corresponding register-value to enable the soundcard.
  *
- * The soundcard is only enabled, if the mainborad is identified
+ * The soundcard is only enabled, if the mainboard is identified
  * via DMI-tables and the soundcard is detected to be off.
  */
 static void pci_fixup_msi_k8t_onboard_sound(struct pci_dev *dev)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 1b82d77..df7b547 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -195,7 +195,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	}
 
 	/*
-	 * Certain firmware versions are way too sentimential and still believe
+	 * Certain firmware versions are way too sentimental and still believe
 	 * they are exclusive and unquestionable owners of the first physical page,
 	 * even though they explicitly mark it as EFI_CONVENTIONAL_MEMORY
 	 * (but then write-access it later during SetVirtualAddressMap()).
@@ -457,7 +457,7 @@ void __init efi_dump_pagetable(void)
  * in a kernel thread and user context. Preemption needs to remain disabled
  * while the EFI-mm is borrowed. mmgrab()/mmdrop() is not used because the mm
  * can not change under us.
- * It should be ensured that there are no concurent calls to this function.
+ * It should be ensured that there are no concurrent calls to this function.
  */
 void efi_enter_mm(void)
 {
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 67d93a2..fda4216 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -726,7 +726,7 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 	 * Buggy efi_reset_system() is handled differently from other EFI
 	 * Runtime Services as it doesn't use efi_rts_wq. Although,
 	 * native_machine_emergency_restart() says that machine_real_restart()
-	 * could fail, it's better not to compilcate this fault handler
+	 * could fail, it's better not to complicate this fault handler
 	 * because this case occurs *very* rarely and hence could be improved
 	 * on a need by basis.
 	 */
diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 0286fe1..122e0f3 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -551,7 +551,7 @@ static void __init imr_fixup_memmap(struct imr_device *idev)
 
 	/*
 	 * Setup an unlocked IMR around the physical extent of the kernel
-	 * from the beginning of the .text secton to the end of the
+	 * from the beginning of the .text section to the end of the
 	 * .rodata section as one physically contiguous block.
 	 *
 	 * We don't round up @size since it is already PAGE_SIZE aligned.
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 526f70f..fdd49d7 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -187,7 +187,7 @@ bool iosf_mbi_available(void)
 EXPORT_SYMBOL(iosf_mbi_available);
 
 /*
- **************** P-Unit/kernel shared I2C bus arbritration ****************
+ **************** P-Unit/kernel shared I2C bus arbitration ****************
  *
  * Some Bay Trail and Cherry Trail devices have the P-Unit and us (the kernel)
  * share a single I2C bus to the PMIC. Below are helpers to arbitrate the
@@ -493,7 +493,7 @@ static void iosf_sideband_debug_init(void)
 	/* mcrx */
 	debugfs_create_x32("mcrx", 0660, iosf_dbg, &dbg_mcrx);
 
-	/* mcr - initiates mailbox tranaction */
+	/* mcr - initiates mailbox transaction */
 	debugfs_create_file("mcr", 0660, iosf_dbg, &dbg_mcr, &iosf_mcr_fops);
 }
 
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530..35d1a6e 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -889,7 +889,7 @@ static inline int uv_nmi_kdb_reason(void)
  * Call KGDB/KDB from NMI handler
  *
  * Note that if both KGDB and KDB are configured, then the action of 'kgdb' or
- * 'kdb' has no affect on which is used.  See the KGDB documention for further
+ * 'kdb' has no affect on which is used.  See the KGDB documentation for further
  * information.
  */
 static void uv_call_kgdb_kdb(int cpu, struct pt_regs *regs, int master)
