Return-Path: <linux-tip-commits+bounces-1578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27633924832
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CD31F21A8A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FB1D3648;
	Tue,  2 Jul 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIFARi99";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9pC6kUB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3E1CFD42;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948260; cv=none; b=ixM4zt9c9Zunm8xwFJFyPgrVCjnAgB46/SPMsnIE/HIKc6I18rs23ToVPaUPigdkHvO8+1HGZkmbl3OMOPby+QHus6H4HyAMx0DbdCWm2qpVERRzGR4R8VZVHJ9AhG10Pg3aP7EH6t3LFW+3zmNeah2uNdyFDf3jjvKpI2KxZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948260; c=relaxed/simple;
	bh=c98UIAp+lv0ZQoCqdvx39DtRdTP69vileisur3vy+ts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QGJ149HUcz9rOCBeyy5MNbNLgZ9EdBQ6vq2ikkVMlBpOCLljKELD/3L+/355R0e03i16B1IR62S8SafVJpFSmI980lrd3CDAjRCIMYVKQedtdIM0pja7rr/odM/FCjMqensnKabkSIq9c0LAWBjKnbTm1gRYeIOjcnRDe4b8Asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIFARi99; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9pC6kUB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWmFZSZNVogtzv/QNqHZxH3RhvI1sjc7ZFPkGlYJ72E=;
	b=JIFARi99rxCCVSw/O1agOFWvglbgp2JOXctMGlpDo5PZIlI7IAY+UGvHMJtoOdj9z3jiwe
	3RC5SXXcDdMSk5QABSPysT+op2IRQjBPOt2tIPRzkk66dhyXMbLpengEe9z2Nz8KeB+uOk
	uw37MTgYfc8XiO/7c9uFG/SGVzY4o+FiZTlXXsO0WzL/mSFD9rdTkuU91daQQotKs0f3BO
	XlvP6dUWKa5Q5dMz1svIyA8JT0USj1cfuqhzCPB3QUd+0WV9XGnUxgLiyiW81d2le5XZYx
	NPm+Ho1ULVon/yy6zW1ueNj9zMrApzTNljk0coRE83YKyjljLgPw25A+iI1C0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWmFZSZNVogtzv/QNqHZxH3RhvI1sjc7ZFPkGlYJ72E=;
	b=n9pC6kUBeeucq0GvE98l0lBQL6IBnY/Uo1r6AByv3dVmIXcK8gOjRFPXLOVB+72BdF1Pyc
	+7HmewV8Vy5iBeBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Introduce snc_nodes_per_l3_cache
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-7-tony.luck@intel.com>
References: <20240628215619.76401-7-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825555.2215.15888159409373742726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e13db55b5a0d447dea63cde772c1078405bbbf96
Gitweb:        https://git.kernel.org/tip/e13db55b5a0d447dea63cde772c1078405bbbf96
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:06 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Introduce snc_nodes_per_l3_cache

Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
and memory controllers on a socket into two or more groups. These are
presented to the operating system as NUMA nodes.

This may enable some workloads to have slightly lower latency to memory
as the memory controller(s) in an SNC node are electrically closer to the
CPU cores on that SNC node. This cost may be offset by lower bandwidth
since the memory accesses for each core can only be interleaved between
the memory controllers on the same SNC node.

Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
to track L3 cache occupancy and memory bandwidth. There is an MSR that
controls how the RMIDs are shared between SNC nodes.

The default mode divides them numerically. E.g. when there are two SNC
nodes on a socket the lower number half of the RMIDs are given to the
first node, the remainder to the second node. This would be difficult
to use with the Linux resctrl interface as specific RMID values assigned
to resctrl groups are not visible to users.

RMID sharing mode divides the physical RMIDs evenly between SNC nodes
but uses a logical RMID in the IA32_PQR_ASSOC MSR. For example a system
with 200 physical RMIDs (as enumerated by CPUID leaf 0xF) that has two
SNC nodes per L3 cache instance would have 100 logical RMIDs available
for Linux to use. A task running on SNC node 0 with RMID 5 would
accumulate LLC occupancy and MBM bandwidth data in physical RMID 5.
Another task using RMID 5, but running on SNC node 1 would accumulate
data in physical RMID 105.

Even with this renumbering SNC mode requires several changes in resctrl
behavior for correct operation.

Add a static global to arch/x86/kernel/cpu/resctrl/monitor.c to indicate
how many SNC domains share an L3 cache instance.  Initialize this to
"1". Runtime detection of SNC mode will adjust this value.

Update all places to take appropriate action when SNC mode is enabled:
1) The number of logical RMIDs per L3 cache available for use is the
   number of physical RMIDs divided by the number of SNC nodes.
2) Likewise the "mon_scale" value must be divided by the number of SNC
   nodes.
3) Add a function to convert from logical RMID values (assigned to
   tasks and loaded into the IA32_PQR_ASSOC MSR on context switch)
   to physical RMID values to load into IA32_QM_EVTSEL MSR when
   reading counters on each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-7-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 56 +++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 89d7e6f..ff4e745 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -97,6 +97,8 @@ unsigned int resctrl_rmid_realloc_limit;
 
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
+static int snc_nodes_per_l3_cache = 1;
+
 /*
  * The correction factor table is documented in Documentation/arch/x86/resctrl.rst.
  * If rmid > rmid threshold, MBM total and local values should be multiplied
@@ -185,7 +187,43 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
 	return entry;
 }
 
-static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+/*
+ * When Sub-NUMA Cluster (SNC) mode is not enabled (as indicated by
+ * "snc_nodes_per_l3_cache == 1") no translation of the RMID value is
+ * needed. The physical RMID is the same as the logical RMID.
+ *
+ * On a platform with SNC mode enabled, Linux enables RMID sharing mode
+ * via MSR 0xCA0 (see the "RMID Sharing Mode" section in the "Intel
+ * Resource Director Technology Architecture Specification" for a full
+ * description of RMID sharing mode).
+ *
+ * In RMID sharing mode there are fewer "logical RMID" values available
+ * to accumulate data ("physical RMIDs" are divided evenly between SNC
+ * nodes that share an L3 cache). Linux creates an rdt_mon_domain for
+ * each SNC node.
+ *
+ * The value loaded into IA32_PQR_ASSOC is the "logical RMID".
+ *
+ * Data is collected independently on each SNC node and can be retrieved
+ * using the "physical RMID" value computed by this function and loaded
+ * into IA32_QM_EVTSEL. @cpu can be any CPU in the SNC node.
+ *
+ * The scope of the IA32_QM_EVTSEL and IA32_QM_CTR MSRs is at the L3
+ * cache.  So a "physical RMID" may be read from any CPU that shares
+ * the L3 cache with the desired SNC node, not just from a CPU in
+ * the specific SNC node.
+ */
+static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (snc_nodes_per_l3_cache == 1)
+		return lrmid;
+
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+}
+
+static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
 {
 	u64 msr_val;
 
@@ -197,7 +235,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, prmid);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
@@ -233,14 +271,17 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     enum resctrl_event_id eventid)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
+	u32 prmid;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
 		memset(am, 0, sizeof(*am));
 
+		prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 		/* Record any initial, non-zero count value. */
-		__rmid_read(rmid, eventid, &am->prev_msr);
+		__rmid_read_phys(prmid, eventid, &am->prev_msr);
 	}
 }
 
@@ -275,8 +316,10 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
+	u32 prmid;
 	int ret;
 
 	resctrl_arch_rmid_read_context_check();
@@ -284,7 +327,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
 		return -EINVAL;
 
-	ret = __rmid_read(rmid, eventid, &msr_val);
+	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
+	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 	if (ret)
 		return ret;
 
@@ -1022,8 +1066,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)

