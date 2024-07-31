Return-Path: <linux-tip-commits+bounces-1894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7405942CE3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CF81C21D6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92F1AD415;
	Wed, 31 Jul 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VI9Q6pu3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aA9acHTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF311AD3FD;
	Wed, 31 Jul 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424039; cv=none; b=ZlqdThW7aumtemwUlVeJI8bpTKYT1pWQl7W2HpH0PaylMtQ96JuvgBFYSyQIZGUlMmX4N2ND0OVRqoUY7CDH6dy3EUr81pf3mSLZqmFpQ/pdzb3/3y3gOzaGqBbVjcS057CsZeP1BRJmAcCMI7vFZlNi8xZR0WKcWYC8F08ZhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424039; c=relaxed/simple;
	bh=I/lOvaZd+0IQn64S8K2YnhgKTVjxXwN9f8g0beT9BOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T6qgqhw/4HscSm9Q39m+V75WExHOAA5ehS+RFpTJptD8yqMo3GrIq0jOCy2brxzazQCVFqATL9Pg+TjGTfmrKRxj1ZoPjIEhh4r+XLifTffvRnJfjmcQYUfWs9PvM7xXgLyy6vZkEEYEGL/aI0xyL5WkRw52g/8Vzs3tf2Hkcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VI9Q6pu3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aA9acHTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 11:07:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722424035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdYHp8GrPpJ2QKMRZe0RU42PKIoOx5HwzcrPOeEnWms=;
	b=VI9Q6pu37bclpm/VE7M9v6jeJnpvM87m172+szB9sTou7stkaGi+KWvuSqGqcgGhAUYVI5
	z3Jf3AneQTKIsiDL0TVb7GZsoh1G8LCsYeQCSx/rJ1oJX8f5FMjxep94589Ook9tTjusGG
	WPFc/ZE7oIW4Dt0ClmiOOe6VwHK+iionrpHjAjklBM+Q60+8FwQ+BoYayjYk7T0e0gSA0M
	6/Mj1ztzE/7o+FGrfAj/t0IpNZtTcgYLLQF1T6kVnuL0YE+THgH3dvORfRxVHZl+T+k0B6
	0QwhG0DGHuJD8vji88DIbmG6OjbzfVnAfZ2mDk1qP2bpUTz9wRc9jLUOcE0J3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722424035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdYHp8GrPpJ2QKMRZe0RU42PKIoOx5HwzcrPOeEnWms=;
	b=aA9acHTKeovx10kbd8kdgLI368iGLgbNODo1xTHNuK8M2QOpGEeIZDvG/KACkHBuT5LsD2
	UwD4GXeJs/Yre0Cg==
From: "tip-bot2 for Li Huafei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86: Fix smp_processor_id()-in-preemptible warnings
Cc: Li Huafei <lihuafei1@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729220928.325449-1-lihuafei1@huawei.com>
References: <20240729220928.325449-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172242403555.2215.14795716569884927147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f73cefa3b72eaa90abfc43bf6d68137ba059d4b1
Gitweb:        https://git.kernel.org/tip/f73cefa3b72eaa90abfc43bf6d68137ba059d4b1
Author:        Li Huafei <lihuafei1@huawei.com>
AuthorDate:    Tue, 30 Jul 2024 06:09:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 31 Jul 2024 12:57:39 +02:00

perf/x86: Fix smp_processor_id()-in-preemptible warnings

The following bug was triggered on a system built with
CONFIG_DEBUG_PREEMPT=y:

 # echo p > /proc/sysrq-trigger

 BUG: using smp_processor_id() in preemptible [00000000] code: sh/117
 caller is perf_event_print_debug+0x1a/0x4c0
 CPU: 3 UID: 0 PID: 117 Comm: sh Not tainted 6.11.0-rc1 #109
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4f/0x60
  check_preemption_disabled+0xc8/0xd0
  perf_event_print_debug+0x1a/0x4c0
  __handle_sysrq+0x140/0x180
  write_sysrq_trigger+0x61/0x70
  proc_reg_write+0x4e/0x70
  vfs_write+0xd0/0x430
  ? handle_mm_fault+0xc8/0x240
  ksys_write+0x9c/0xd0
  do_syscall_64+0x96/0x190
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

This is because the commit d4b294bf84db ("perf/x86: Hybrid PMU support
for counters") took smp_processor_id() outside the irq critical section.
If a preemption occurs in perf_event_print_debug() and the task is
migrated to another cpu, we may get incorrect pmu debug information.
Move smp_processor_id() back inside the irq critical section to fix this
issue.

Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240729220928.325449-1-lihuafei1@huawei.com
---
 arch/x86/events/core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 12f2a0c..be01823 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1520,20 +1520,23 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 void perf_event_print_debug(void)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
+	unsigned long *cntr_mask, *fixed_cntr_mask;
+	struct event_constraint *pebs_constraints;
+	struct cpu_hw_events *cpuc;
 	u64 pebs, debugctl;
-	int cpu = smp_processor_id();
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
-	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
-	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
-	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
-	unsigned long flags;
-	int idx;
+	int cpu, idx;
+
+	guard(irqsave)();
+
+	cpu = smp_processor_id();
+	cpuc = &per_cpu(cpu_hw_events, cpu);
+	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
+	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
+	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 
 	if (!*(u64 *)cntr_mask)
 		return;
 
-	local_irq_save(flags);
-
 	if (x86_pmu.version >= 2) {
 		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1577,7 +1580,6 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
 	}
-	local_irq_restore(flags);
 }
 
 void x86_pmu_stop(struct perf_event *event, int flags)

