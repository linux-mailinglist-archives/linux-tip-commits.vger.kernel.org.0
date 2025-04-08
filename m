Return-Path: <linux-tip-commits+bounces-4749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60109A81554
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5761BA1FBE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EC241696;
	Tue,  8 Apr 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIQIxQsc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1atPoj4g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05C1DA60F;
	Tue,  8 Apr 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139102; cv=none; b=IOrs49Uv+zc8QETYtMf8zlWiXLKNK7ZeRM83ItwzYG1VXQux50LNuRUre+jjm4xWJukNbM3vnftluLqjoXba+ND5IK/D9Q+QvJPRP2kQloLwJBn7zd3RkMWDhD2ZXNvMLkGIllhwLuP5XB5BhGJPt+htHzDdWmKNlPpIaVeqXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139102; c=relaxed/simple;
	bh=syivn7SkDyRiV+Zm+7m5v/C4BFVJtwtmsvjPcOk6BkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TY2GW/X5ZGX7Ipma5E3IvLzF/6h9B2Pe4ILoxCV6dbL74elRZBEfp2kiBDSDybqC9hB7VZINrMnOTeho9nQYerlxBvQYLH+51Bu7CE4v6EmAxV/Tpgcu3ctKi4i6DXpy1RZO+VXYucMFpI5btzRwX8X42o2uOms+TzKxqvcrwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIQIxQsc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1atPoj4g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gR2yVItBwK9xEqhqU0SgYJXt41i4/tYYAHvSy5neFHU=;
	b=sIQIxQscpay0rqLO3WJjd4/Q7zN5GQGO2mXf4fPm9zCBEDHK5v0w5Md1L92ObyYViu3sxW
	mrRDg6tyScPkT44RGfP7+xpD0whdt+O/lGjypoluv1Ve4sojNzHOUvGeLghh5I6k+nwAag
	ZMXdO3c6lAnLeHcqCvajkFVwS8Taw8bLeZwzgLBD3H2ZLhVmOf9jbNYc3DgNdUT60fPwVA
	z5tSZ6XdzkgmqziO07PJ1tZc8DEhlqQxZr18ek7+KdI/DfHDM+7S4llKb1VQDuaAD3Xjnt
	a1wvCUMnRiL9RqPM2LllQqJ6sQ5YoRW4n9mBQUjqqfn1j7adrbYWCoA61dnmCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gR2yVItBwK9xEqhqU0SgYJXt41i4/tYYAHvSy5neFHU=;
	b=1atPoj4g2GOm0iZe+lcNYxgYu1IxEWU57vRs6ceDlqxWsWv0MpP/U3C7f5ItILVGQoYMig
	aMXCjQpSy/BIrkDw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support auto counter reload
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327195217.2683619-6-kan.liang@linux.intel.com>
References: <20250327195217.2683619-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413909301.31282.3812745568767080683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ec980e4facef8110f6fce27e5b6344660117f01f
Gitweb:        https://git.kernel.org/tip/ec980e4facef8110f6fce27e5b634466011=
7f01f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 27 Mar 2025 12:52:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:49 +02:00

perf/x86/intel: Support auto counter reload

The relative rates among two or more events are useful for performance
analysis, e.g., a high branch miss rate may indicate a performance
issue. Usually, the samples with a relative rate that exceeds some
threshold are more useful. However, the traditional sampling takes
samples of events separately. To get the relative rates among two or
more events, a high sample rate is required, which can bring high
overhead. Many samples taken in the non-hotspot area are also dropped
(useless) in the post-process.

The auto counter reload (ACR) feature takes samples when the relative
rate of two or more events exceeds some threshold, which provides the
fine-grained information at a low cost.
To support the feature, two sets of MSRs are introduced. For a given
counter IA32_PMC_GPn_CTR/IA32_PMC_FXm_CTR, bit fields in the
IA32_PMC_GPn_CFG_B/IA32_PMC_FXm_CFG_B MSR indicate which counter(s)
can cause a reload of that counter. The reload value is stored in the
IA32_PMC_GPn_CFG_C/IA32_PMC_FXm_CFG_C.
The details can be found at Intel SDM (085), Volume 3, 21.9.11 Auto
Counter Reload.

In the hw_config(), an ACR event is specially configured, because the
cause/reloadable counter mask has to be applied to the dyn_constraint.
Besides the HW limit, e.g., not support perf metrics, PDist and etc, a
SW limit is applied as well. ACR events in a group must be contiguous.
It facilitates the later conversion from the event idx to the counter
idx. Otherwise, the intel_pmu_acr_late_setup() has to traverse the whole
event list again to find the "cause" event.
Also, add a new flag PERF_X86_EVENT_ACR to indicate an ACR group, which
is set to the group leader.

The late setup() is also required for an ACR group. It's to convert the
event idx to the counter idx, and saved it in hw.config1.

The ACR configuration MSRs are only updated in the enable_event().
The disable_event() doesn't clear the ACR CFG register.
Add acr_cfg_b/acr_cfg_c in the struct cpu_hw_events to cache the MSR
values. It can avoid a MSR write if the value is not changed.

Expose an acr_mask to the sysfs. The perf tool can utilize the new
format to configure the relation of events in the group. The bit
sequence of the acr_mask follows the events enabled order of the group.

Example:

Here is the snippet of the mispredict.c. Since the array has a random
numbers, jumps are random and often mispredicted.
The mispredicted rate depends on the compared value.

For the Loop1, ~11% of all branches are mispredicted.
For the Loop2, ~21% of all branches are mispredicted.

main()
{
...
        for (i =3D 0; i < N; i++)
                data[i] =3D rand() % 256;
...
        /* Loop 1 */
        for (k =3D 0; k < 50; k++)
                for (i =3D 0; i < N; i++)
                        if (data[i] >=3D 64)
                                sum +=3D data[i];
...

...
        /* Loop 2 */
        for (k =3D 0; k < 50; k++)
                for (i =3D 0; i < N; i++)
                        if (data[i] >=3D 128)
                                sum +=3D data[i];
...
}

Usually, a code with a high branch miss rate means a bad performance.
To understand the branch miss rate of the codes, the traditional method
usually samples both branches and branch-misses events. E.g.,
perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions/u}"
               -c 1000000 -- ./mispredict

[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
The 5106 samples are from both events and spread in both Loops.
In the post-process stage, a user can know that the Loop 2 has a 21%
branch miss rate. Then they can focus on the samples of branch-misses
events for the Loop 2.

With this patch, the user can generate the samples only when the branch
miss rate > 20%. For example,
perf record -e "{cpu_atom/branch-misses,period=3D200000,acr_mask=3D0x2/ppu,
                 cpu_atom/branch-instructions,period=3D1000000,acr_mask=3D0x3=
/u}"
                -- ./mispredict

(Two different periods are applied to branch-misses and
branch-instructions. The ratio is set to 20%.
If the branch-instructions is overflowed first, the branch-miss
rate < 20%. No samples should be generated. All counters should be
automatically reloaded.
If the branch-misses is overflowed first, the branch-miss rate > 20%.
A sample triggered by the branch-misses event should be
generated. Just the counter of the branch-instructions should be
automatically reloaded.

The branch-misses event should only be automatically reloaded when
the branch-instructions is overflowed. So the "cause" event is the
branch-instructions event. The acr_mask is set to 0x2, since the
event index in the group of branch-instructions is 1.

The branch-instructions event is automatically reloaded no matter which
events are overflowed. So the "cause" events are the branch-misses
and the branch-instructions event. The acr_mask should be set to 0x3.)

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.098 MB perf.data (2498 samples) ]

 $perf report

Percent       =E2=94=82154:   movl    $0x0,-0x14(%rbp)
              =E2=94=82     =E2=86=93 jmp     1af
              =E2=94=82     for (i =3D j; i < N; i++)
              =E2=94=8215d:   mov     -0x10(%rbp),%eax
              =E2=94=82       mov     %eax,-0x18(%rbp)
              =E2=94=82     =E2=86=93 jmp     1a2
              =E2=94=82     if (data[i] >=3D 128)
              =E2=94=82165:   mov     -0x18(%rbp),%eax
              =E2=94=82       cltq
              =E2=94=82       lea     0x0(,%rax,4),%rdx
              =E2=94=82       mov     -0x8(%rbp),%rax
              =E2=94=82       add     %rdx,%rax
              =E2=94=82       mov     (%rax),%eax
              =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80cmp     $0x7f,%eax
100.00   0.00 =E2=94=82    =E2=94=9C=E2=94=80=E2=94=80jle     19e
              =E2=94=82    =E2=94=82sum +=3D data[i];

The 2498 samples are all from the branch-misses events for the Loop 2.

The number of samples and overhead is significantly reduced without
losing any information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lkml.kernel.org/r/20250327195217.2683619-6-kan.liang@linux.inte=
l.com
---
 arch/x86/events/core.c           |   2 +-
 arch/x86/events/intel/core.c     | 226 +++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     |  10 +-
 arch/x86/include/asm/msr-index.h |   4 +-
 include/linux/perf_event.h       |   1 +-
 5 files changed, 240 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a0fe51e..f53ae1f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -755,7 +755,7 @@ void x86_pmu_enable_all(int added)
 	}
 }
=20
-static inline int is_x86_event(struct perf_event *event)
+int is_x86_event(struct perf_event *event)
 {
 	int i;
=20
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 876678a..3152a01 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2603,7 +2603,8 @@ static void intel_pmu_del_event(struct perf_event *even=
t)
 		intel_pmu_lbr_del(event);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
-	if (is_pebs_counter_event_group(event))
+	if (is_pebs_counter_event_group(event) ||
+	    is_acr_event_group(event))
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
=20
@@ -2882,6 +2883,52 @@ static void intel_pmu_enable_fixed(struct perf_event *=
event)
 	cpuc->fixed_ctrl_val |=3D bits;
 }
=20
+static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	int msr_b, msr_c;
+
+	if (!mask && !cpuc->acr_cfg_b[idx])
+		return;
+
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		msr_b =3D MSR_IA32_PMC_V6_GP0_CFG_B;
+		msr_c =3D MSR_IA32_PMC_V6_GP0_CFG_C;
+	} else {
+		msr_b =3D MSR_IA32_PMC_V6_FX0_CFG_B;
+		msr_c =3D MSR_IA32_PMC_V6_FX0_CFG_C;
+		idx -=3D INTEL_PMC_IDX_FIXED;
+	}
+
+	if (cpuc->acr_cfg_b[idx] !=3D mask) {
+		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
+		cpuc->acr_cfg_b[idx] =3D mask;
+	}
+	/* Only need to update the reload value when there is a valid config value.=
 */
+	if (mask && cpuc->acr_cfg_c[idx] !=3D reload) {
+		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
+		cpuc->acr_cfg_c[idx] =3D reload;
+	}
+}
+
+static void intel_pmu_enable_acr(struct perf_event *event)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	if (!is_acr_event_group(event) || !event->attr.config2) {
+		/*
+		 * The disable doesn't clear the ACR CFG register.
+		 * Check and clear the ACR CFG register.
+		 */
+		intel_pmu_config_acr(hwc->idx, 0, 0);
+		return;
+	}
+
+	intel_pmu_config_acr(hwc->idx, hwc->config1, -hwc->sample_period);
+}
+
+DEFINE_STATIC_CALL_NULL(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
+
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	u64 enable_mask =3D ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -2896,9 +2943,12 @@ static void intel_pmu_enable_event(struct perf_event *=
event)
 		if (branch_sample_counters(event))
 			enable_mask |=3D ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
+		static_call_cond(intel_pmu_enable_acr_event)(event);
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
+		static_call_cond(intel_pmu_enable_acr_event)(event);
+		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
 		break;
@@ -2916,6 +2966,31 @@ static void intel_pmu_enable_event(struct perf_event *=
event)
 	}
 }
=20
+static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
+{
+	struct perf_event *event, *leader;
+	int i, j, idx;
+
+	for (i =3D 0; i < cpuc->n_events; i++) {
+		leader =3D cpuc->event_list[i];
+		if (!is_acr_event_group(leader))
+			continue;
+
+		/* The ACR events must be contiguous. */
+		for (j =3D i; j < cpuc->n_events; j++) {
+			event =3D cpuc->event_list[j];
+			if (event->group_leader !=3D leader->group_leader)
+				break;
+			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_=
MAX) {
+				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
+					return;
+				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
+			}
+		}
+		i =3D j - 1;
+	}
+}
+
 void intel_pmu_late_setup(void)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
@@ -2924,6 +2999,7 @@ void intel_pmu_late_setup(void)
 		return;
=20
 	intel_pmu_pebs_late_setup(cpuc);
+	intel_pmu_acr_late_setup(cpuc);
 }
=20
 static void intel_pmu_add_event(struct perf_event *event)
@@ -2932,7 +3008,8 @@ static void intel_pmu_add_event(struct perf_event *even=
t)
 		intel_pmu_pebs_add(event);
 	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
-	if (is_pebs_counter_event_group(event))
+	if (is_pebs_counter_event_group(event) ||
+	    is_acr_event_group(event))
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup++;
 }
=20
@@ -4087,6 +4164,39 @@ end:
 	return start;
 }
=20
+static inline bool intel_pmu_has_acr(struct pmu *pmu)
+{
+	return !!hybrid(pmu, acr_cause_mask64);
+}
+
+static bool intel_pmu_is_acr_group(struct perf_event *event)
+{
+	/* The group leader has the ACR flag set */
+	if (is_acr_event_group(event))
+		return true;
+
+	/* The acr_mask is set */
+	if (event->attr.config2)
+		return true;
+
+	return false;
+}
+
+static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *event,
+						 u64 *cause_mask, int *num)
+{
+	event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_cntr_mask64);
+	*cause_mask |=3D event->attr.config2;
+	*num +=3D 1;
+}
+
+static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
+						   int idx, u64 cause_mask)
+{
+	if (test_bit(idx, (unsigned long *)&cause_mask))
+		event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_cause_mask64);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret =3D x86_pmu_hw_config(event);
@@ -4215,6 +4325,94 @@ static int intel_pmu_hw_config(struct perf_event *even=
t)
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |=3D PERF_X86_EVENT_PEBS_CNTR;
=20
+	if (intel_pmu_has_acr(event->pmu) && intel_pmu_is_acr_group(event)) {
+		struct perf_event *sibling, *leader =3D event->group_leader;
+		struct pmu *pmu =3D event->pmu;
+		bool has_sw_event =3D false;
+		int num =3D 0, idx =3D 0;
+		u64 cause_mask =3D 0;
+
+		/* Not support perf metrics */
+		if (is_metric_event(event))
+			return -EINVAL;
+
+		/* Not support freq mode */
+		if (event->attr.freq)
+			return -EINVAL;
+
+		/* PDist is not supported */
+		if (event->attr.config2 && event->attr.precise_ip > 2)
+			return -EINVAL;
+
+		/* The reload value cannot exceeds the max period */
+		if (event->attr.sample_period > x86_pmu.max_period)
+			return -EINVAL;
+		/*
+		 * The counter-constraints of each event cannot be finalized
+		 * unless the whole group is scanned. However, it's hard
+		 * to know whether the event is the last one of the group.
+		 * Recalculate the counter-constraints for each event when
+		 * adding a new event.
+		 *
+		 * The group is traversed twice, which may be optimized later.
+		 * In the first round,
+		 * - Find all events which do reload when other events
+		 *   overflow and set the corresponding counter-constraints
+		 * - Add all events, which can cause other events reload,
+		 *   in the cause_mask
+		 * - Error out if the number of events exceeds the HW limit
+		 * - The ACR events must be contiguous.
+		 *   Error out if there are non-X86 events between ACR events.
+		 *   This is not a HW limit, but a SW limit.
+		 *   With the assumption, the intel_pmu_acr_late_setup() can
+		 *   easily convert the event idx to counter idx without
+		 *   traversing the whole event list.
+		 */
+		if (!is_x86_event(leader))
+			return -EINVAL;
+
+		if (leader->attr.config2)
+			intel_pmu_set_acr_cntr_constr(leader, &cause_mask, &num);
+
+		if (leader->nr_siblings) {
+			for_each_sibling_event(sibling, leader) {
+				if (!is_x86_event(sibling)) {
+					has_sw_event =3D true;
+					continue;
+				}
+				if (!sibling->attr.config2)
+					continue;
+				if (has_sw_event)
+					return -EINVAL;
+				intel_pmu_set_acr_cntr_constr(sibling, &cause_mask, &num);
+			}
+		}
+		if (leader !=3D event && event->attr.config2) {
+			if (has_sw_event)
+				return -EINVAL;
+			intel_pmu_set_acr_cntr_constr(event, &cause_mask, &num);
+		}
+
+		if (hweight64(cause_mask) > hweight64(hybrid(pmu, acr_cause_mask64)) ||
+		    num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
+			return -EINVAL;
+		/*
+		 * In the second round, apply the counter-constraints for
+		 * the events which can cause other events reload.
+		 */
+		intel_pmu_set_acr_caused_constr(leader, idx++, cause_mask);
+
+		if (leader->nr_siblings) {
+			for_each_sibling_event(sibling, leader)
+				intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask);
+		}
+
+		if (leader !=3D event)
+			intel_pmu_set_acr_caused_constr(event, idx, cause_mask);
+
+		leader->hw.flags |=3D PERF_X86_EVENT_ACR;
+	}
+
 	if ((event->attr.type =3D=3D PERF_TYPE_HARDWARE) ||
 	    (event->attr.type =3D=3D PERF_TYPE_HW_CACHE))
 		return 0;
@@ -6061,6 +6259,21 @@ td_is_visible(struct kobject *kobj, struct attribute *=
attr, int i)
 	return attr->mode;
 }
=20
+PMU_FORMAT_ATTR(acr_mask,	"config2:0-63");
+
+static struct attribute *format_acr_attrs[] =3D {
+	&format_attr_acr_mask.attr,
+	NULL
+};
+
+static umode_t
+acr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	struct device *dev =3D kobj_to_dev(kobj);
+
+	return intel_pmu_has_acr(dev_get_drvdata(dev)) ? attr->mode : 0;
+}
+
 static struct attribute_group group_events_td  =3D {
 	.name =3D "events",
 	.is_visible =3D td_is_visible,
@@ -6103,6 +6316,12 @@ static struct attribute_group group_format_evtsel_ext =
=3D {
 	.is_visible =3D evtsel_ext_is_visible,
 };
=20
+static struct attribute_group group_format_acr =3D {
+	.name       =3D "format",
+	.attrs      =3D format_acr_attrs,
+	.is_visible =3D acr_is_visible,
+};
+
 static struct attribute_group group_default =3D {
 	.attrs      =3D intel_pmu_attrs,
 	.is_visible =3D default_is_visible,
@@ -6117,6 +6336,7 @@ static const struct attribute_group *attr_update[] =3D {
 	&group_format_extra,
 	&group_format_extra_skl,
 	&group_format_evtsel_ext,
+	&group_format_acr,
 	&group_default,
 	NULL,
 };
@@ -6401,6 +6621,7 @@ static const struct attribute_group *hybrid_attr_update=
[] =3D {
 	&group_caps_lbr,
 	&hybrid_group_format_extra,
 	&group_format_evtsel_ext,
+	&group_format_acr,
 	&group_default,
 	&hybrid_group_cpus,
 	NULL,
@@ -6593,6 +6814,7 @@ static __always_inline void intel_pmu_init_skt(struct p=
mu *pmu)
 	intel_pmu_init_grt(pmu);
 	hybrid(pmu, event_constraints) =3D intel_skt_event_constraints;
 	hybrid(pmu, extra_regs) =3D intel_cmt_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
=20
 __init int intel_pmu_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ab9af2e..46bbb50 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -120,6 +120,11 @@ static inline bool is_pebs_counter_event_group(struct pe=
rf_event *event)
 	return event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
 }
=20
+static inline bool is_acr_event_group(struct perf_event *event)
+{
+	return event->group_leader->hw.flags & PERF_X86_EVENT_ACR;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -287,6 +292,10 @@ struct cpu_hw_events {
 	u64			fixed_ctrl_val;
 	u64			active_fixed_ctrl_val;
=20
+	/* Intel ACR configuration */
+	u64			acr_cfg_b[X86_PMC_IDX_MAX];
+	u64			acr_cfg_c[X86_PMC_IDX_MAX];
+
 	/*
 	 * Intel LBR bits
 	 */
@@ -1103,6 +1112,7 @@ static struct perf_pmu_format_hybrid_attr format_attr_h=
ybrid_##_name =3D {\
 	.pmu_type	=3D _pmu,						\
 }
=20
+int is_x86_event(struct perf_event *event);
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
=20
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index e6134ef..53da787 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -594,7 +594,11 @@
 /* V6 PMON MSR range */
 #define MSR_IA32_PMC_V6_GP0_CTR		0x1900
 #define MSR_IA32_PMC_V6_GP0_CFG_A	0x1901
+#define MSR_IA32_PMC_V6_GP0_CFG_B	0x1902
+#define MSR_IA32_PMC_V6_GP0_CFG_C	0x1903
 #define MSR_IA32_PMC_V6_FX0_CTR		0x1980
+#define MSR_IA32_PMC_V6_FX0_CFG_B	0x1982
+#define MSR_IA32_PMC_V6_FX0_CFG_C	0x1983
 #define MSR_IA32_PMC_V6_STEP		4
=20
 /* KeyID partitioning between MKTME and TDX */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5c54732..947ad12 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -157,6 +157,7 @@ struct hw_perf_event {
 	union {
 		struct { /* hardware */
 			u64		config;
+			u64		config1;
 			u64		last_tag;
 			u64		dyn_constraint;
 			unsigned long	config_base;

