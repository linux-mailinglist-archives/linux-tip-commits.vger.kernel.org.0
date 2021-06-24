Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB03B2862
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhFXHMO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:12:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42634 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhFXHMI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:12:08 -0400
Date:   Thu, 24 Jun 2021 07:09:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624518588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3GW+ce0WZL2Ug0EXQaPWCaN191B8B6D6fsuCSOotN0=;
        b=SRKP0van25QxIvCzl+Pe5W0wYInvhHzjq3/lDVfswwJ4tKMXAQnSR8hiSx+CLHK7QC3GlN
        COxa+lgNS4Du39sav5WQFyeAggBbBF3jZl6D0Y+FbKvKsEBTYj1UqN526hMnki0DQMoQab
        gqiUAKs4KmeslCIDgQz4wiTy85vWxluF2UV2mJBtUGxaCc6vmqXMWgT6+fu2u1Yq4b1Ehk
        AswO6YJiyddbX4jyJ/d6NwkmVZy7m/ShzoOQ12jg7uDoCBLjaJA0LTpuJHxz/xiQn0WkHg
        mB4Oi5x0gJJ1G6drl/QVuPE79evMlvkyxYbGyaucw2vWXwtfXEok7bBgrJQEXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624518588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3GW+ce0WZL2Ug0EXQaPWCaN191B8B6D6fsuCSOotN0=;
        b=UtS3yx/iM8sV/ndyKJlZsOFBVf1lzhZh1yhCn6L+L1/YfBWv+P6y9lAvEOiHYSjOWbxhDy
        CYoaCcSx+dWPzxDA==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix PEBS-via-PT reload base value
 for Extended PEBS
Cc:     Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621034710.31107-1-likexu@tencent.com>
References: <20210621034710.31107-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <162451858770.395.4853641374330968205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4c58d922c0877e23cc7d3d7c6bff49b85faaca89
Gitweb:        https://git.kernel.org/tip/4c58d922c0877e23cc7d3d7c6bff49b85faaca89
Author:        Like Xu <like.xu.linux@gmail.com>
AuthorDate:    Mon, 21 Jun 2021 11:47:10 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Jun 2021 18:30:52 +02:00

perf/x86/intel: Fix PEBS-via-PT reload base value for Extended PEBS

If we use the "PEBS-via-PT" feature on a platform that supports
extended PBES, like this:

    perf record -c 10000 \
    -e '{intel_pt/branch=0/,branch-instructions/aux-output/p}' uname

we will encounter the following call trace:

[  250.906542] unchecked MSR access error: WRMSR to 0x14e1 (tried to write
0x0000000000000000) at rIP: 0xffffffff88073624 (native_write_msr+0x4/0x20)
[  250.920779] Call Trace:
[  250.923508]  intel_pmu_pebs_enable+0x12c/0x190
[  250.928359]  intel_pmu_enable_event+0x346/0x390
[  250.933300]  x86_pmu_start+0x64/0x80
[  250.937231]  x86_pmu_enable+0x16a/0x2f0
[  250.941434]  perf_event_exec+0x144/0x4c0
[  250.945731]  begin_new_exec+0x650/0xbf0
[  250.949933]  load_elf_binary+0x13e/0x1700
[  250.954321]  ? lock_acquire+0xc2/0x390
[  250.958430]  ? bprm_execve+0x34f/0x8a0
[  250.962544]  ? lock_is_held_type+0xa7/0x120
[  250.967118]  ? find_held_lock+0x32/0x90
[  250.971321]  ? sched_clock_cpu+0xc/0xb0
[  250.975527]  bprm_execve+0x33d/0x8a0
[  250.979452]  do_execveat_common.isra.0+0x161/0x1d0
[  250.984673]  __x64_sys_execve+0x33/0x40
[  250.988877]  do_syscall_64+0x3d/0x80
[  250.992806]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  250.998302] RIP: 0033:0x7fbc971d82fb
[  251.002235] Code: Unable to access opcode bytes at RIP 0x7fbc971d82d1.
[  251.009303] RSP: 002b:00007fffb8aed808 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[  251.017478] RAX: ffffffffffffffda RBX: 00007fffb8af2f00 RCX: 00007fbc971d82fb
[  251.025187] RDX: 00005574792aac50 RSI: 00007fffb8af2f00 RDI: 00007fffb8aed810
[  251.032901] RBP: 00007fffb8aed970 R08: 0000000000000020 R09: 00007fbc9725c8b0
[  251.040613] R10: 6d6c61632f6d6f63 R11: 0000000000000202 R12: 00005574792aac50
[  251.048327] R13: 00007fffb8af35f0 R14: 00005574792aafdf R15: 00005574792aafe7

This is because the target reload msr address is calculated
based on the wrong base msr and the target reload msr value
is accessed from ds->pebs_event_reset[] with the wrong offset.

According to Intel SDM Table 2-14, for extended PBES feature,
the reload msr for MSR_IA32_FIXED_CTRx should be based on
MSR_RELOAD_FIXED_CTRx.

For fixed counters, let's fix it by overriding the reload msr
address and its value, thus avoiding out-of-bounds access.

Fixes: 42880f726c66("perf/x86/intel: Support PEBS output to PT")
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210621034710.31107-1-likexu@tencent.com
---
 arch/x86/events/intel/ds.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1ec8fd3..8647713 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1187,6 +1187,9 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	u64 value = ds->pebs_event_reset[hwc->idx];
+	u32 base = MSR_RELOAD_PMC0;
+	unsigned int idx = hwc->idx;
 
 	if (!is_pebs_pt(event))
 		return;
@@ -1196,7 +1199,12 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 
 	cpuc->pebs_enabled |= PEBS_OUTPUT_PT;
 
-	wrmsrl(MSR_RELOAD_PMC0 + hwc->idx, ds->pebs_event_reset[hwc->idx]);
+	if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+		base = MSR_RELOAD_FIXED_CTR0;
+		idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+		value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
+	}
+	wrmsrl(base + idx, value);
 }
 
 void intel_pmu_pebs_enable(struct perf_event *event)
@@ -1204,6 +1212,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	unsigned int idx = hwc->idx;
 
 	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
 
@@ -1222,19 +1231,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 		}
 	}
 
+	if (idx >= INTEL_PMC_IDX_FIXED)
+		idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
 	 */
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		unsigned int idx = hwc->idx;
-
-		if (idx >= INTEL_PMC_IDX_FIXED)
-			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
 		ds->pebs_event_reset[idx] =
 			(u64)(-hwc->sample_period) & x86_pmu.cntval_mask;
 	} else {
-		ds->pebs_event_reset[hwc->idx] = 0;
+		ds->pebs_event_reset[idx] = 0;
 	}
 
 	intel_pmu_pebs_via_pt_enable(event);
