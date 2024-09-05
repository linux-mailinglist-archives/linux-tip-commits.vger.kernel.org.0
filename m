Return-Path: <linux-tip-commits+bounces-2173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B196D593
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EB01F2A3FF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E4198A16;
	Thu,  5 Sep 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMOssNfQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+lXiNb0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A31957F8;
	Thu,  5 Sep 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531188; cv=none; b=S5VeNNwW/tHfxoxr5ohaND9/xbC6ThD/W0OdOcdW66ZEztuNhPGONYJUxCCChWTJr0bryrj2yyRVa2D1XQWvZY34p1qBlEvk9uytxS0/KqxA6cRsX415V8SWI2qtLwJ9SQ1NeVb3Q8Eim0ch3dAwdE0U61SpWR7MZ4VGWTOuEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531188; c=relaxed/simple;
	bh=o72Cx3zIzTyhHGksTEpd62D2fwJi9mkOBw/8e8a9ZQ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VnOikNpsmTl4cupUVp2iR7wszXzXeHF9MM1BMmwbhSpgHadTlrNXnmUqcPruycTURW2AVdPeOf8F4Z2kOMuEuLNr+ipMBokdRe3nRO4V3/JL+n0aix03fcej+wVSsigwKpILs6Gyr/MkShDSqQBLQ4ZOOO7IOeyVZX6O3Ho3Awk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMOssNfQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+lXiNb0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 10:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725531184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIgT6F8qJHIq/zJoM9j/iYzJUo7aMUDEVdH77Nbuxcw=;
	b=LMOssNfQ4RoM2OPD9R9e37Neyl0qC6eLgeheRogTar2E3Nh5StaYpNJsd0wOjjZIhfX9MV
	2lo7P/u7UDRPhn7egHWhKMOc9mfug0gDkCxu4AKtZoTr+FPMXcVas6UQ5nCWdq8D5i/Ucp
	1GRAr/Ptgg+CwXOKRDb1p/VygnEvc/jMcktXAu5O5UDuir4Cmanpqs1iXb2s7KdsGBcjI0
	sYV+hTIMNMkoNJT++WA+6aHOqFkQVjcv4ehJc6yw6/b21IkuEsz2+P1VsO+pjx/jH5Na+w
	SaTT3Kir3AabHQYcJclqLPwJ2/W8xkc0wxuZFZPq6Ueo3i4pA4cwcu0wb57bJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725531184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIgT6F8qJHIq/zJoM9j/iYzJUo7aMUDEVdH77Nbuxcw=;
	b=X+lXiNb0TrXvQrwqZBJq0N2SDKnt2Pn8IO5Hpi9OXkdUVWe0iiQ8jlbfqKmDLz82yAjrks
	bFvWbaO38zuHRMDw==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Ingo Molnar <mingo@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172553118415.2215.10312047395634942807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
Gitweb:        https://git.kernel.org/tip/8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Tue, 30 Jul 2024 04:49:18 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Sep 2024 12:02:14 +02:00

perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

After commit:

  63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")

... on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros no longer
return the package cpumask and package ID, instead they return the CCD
(Core Complex Die) mask and ID respectively.

This leads to the energy-pkg event scope to be modified to CCD instead of package.

So, change the PMU scope for AMD and Hygon back to package.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

  Before:

  $ cat /sys/devices/power/cpumask
  0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package
scope event, only one CPU will be collecting the event for all the CPUs in
the package.

  After:

  $ cat /sys/devices/power/cpumask
  0

[ mingo: Cleaned up the changelog ]

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240904100934.3260-1-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 47 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b985ca7..a481a93 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -103,6 +103,19 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms have a per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
+ *	2.2. Other Intel platforms are single die systems so the scope can be
+ *	     considered as either pkg-scope or die-scope, and we are considering
+ *	     them as die-scope.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -140,9 +153,25 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+/*
+ * Helper functions to get the correct topology macros according to the
+ * RAPL PMU scope.
+ */
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
+static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
+					 topology_die_cpumask(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -552,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -565,6 +594,11 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	if (rapl_pmu_idx < 0) {
+		pr_err("topology_logical_(package/die)_id() returned a negative value");
+		return -EINVAL;
+	}
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -579,14 +613,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -675,7 +709,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmus(void)
 {
-	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+	int nr_rapl_pmu = topology_max_packages();
+
+	if (!rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu *= topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)

