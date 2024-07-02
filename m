Return-Path: <linux-tip-commits+bounces-1565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3292481D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC691C256E3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EC1CE099;
	Tue,  2 Jul 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtUFmxpu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgcmDcba"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5F1CD5DB;
	Tue,  2 Jul 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948255; cv=none; b=UUQ1UifXjyURY40yJ583MBUgV/uSMq8cPuLRd+IYx0GIjMHFGO9oK4RTC95F9gYgWzRksZPNdPtwZXulxvFKy3YvJ5iQD7IYFQxwmmD6+O5bIfOBdSqlZ3YXoNaqj29XKz9NND7KkIKQ7TIYPPmY6DHA6UkruBnKhTm15HlXYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948255; c=relaxed/simple;
	bh=6cMAqHs39Em8ywR/d2JeKa7T6qianxO6osWQtxsGEJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FpxvPwKfnX8aJVVp6gMwEa/NEL8IuaDi3+MbMsCJ1svgMVzMAWAFZYSqq7v+GcEUUKutE8wG05sJD0bOmZqbMMs6ciqfWPPd0UCgUi+VeJDMwNCnJHig9nEH73yxLNLtx764vBx8GEPWjJqWsFrC/BX5ujjjH0a9MZWk4T8Nsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xtUFmxpu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgcmDcba; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtprK++LALtm7pPnwdesQgj0C/V1mdg1Do5gahf3GTE=;
	b=xtUFmxpuWlQ5tX9ZjieeEGZlzOGT8UPBQ97oanMcjrElX3SouV/+juCuts3pUgZhEBrsGs
	MrN3yyAga0zcwlc3HLSkWxHwRiUOfPzO4Ye7NGAzBtwfBOTWYnGGx+OzgbafTLdsfAnuPk
	jY51oYGI4TOmTDDRH0RT3jNdiTe2QfsdpczDS0wWvpm9UevQE9HXDgBbSh6ZEIdkVqS56j
	ZGn822vGE+g/36/7WW+94UEoCt+POcIysUb20B/Ug5O2/mixlGNa0vV1daMfk1CllDto10
	snKf0nUCfKBj41SksSfB10gILOCz2GcjAH+i/1DdsXoqKU2Qp/ax/s3bVnK2mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtprK++LALtm7pPnwdesQgj0C/V1mdg1Do5gahf3GTE=;
	b=hgcmDcbag9aWUr3HT+12XXAoPZ0goRgrN49w/bePL7/7RFkz7rgZIDlxkuvBWrBqGiM66W
	1e4D2QD9ywME5fBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Detect Sub-NUMA Cluster (SNC) mode
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-19-tony.luck@intel.com>
References: <20240628215619.76401-19-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825137.2215.3592224005117605146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     13488150f5e2a9b84a335ae18bee33a918ead85d
Gitweb:        https://git.kernel.org/tip/13488150f5e2a9b84a335ae18bee33a918ead85d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:18 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 20:02:11 +02:00

x86/resctrl: Detect Sub-NUMA Cluster (SNC) mode

There isn't a simple hardware bit that indicates whether a CPU is running in
Sub-NUMA Cluster (SNC) mode. Infer the state by comparing the number of CPUs
sharing the L3 cache with CPU0 to the number of CPUs in the same NUMA node as
CPU0.

Add the missing definition of pr_fmt() to monitor.c. This wasn't noticed
before as there are only "can't happen" console messages from this file.

  [ bp: Massage commit message. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-19-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 66 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 16b7bf5..9f53b12 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -15,6 +15,8 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
+#define pr_fmt(fmt)	"resctrl: " fmt
+
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
@@ -1110,6 +1112,68 @@ void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d)
 		msr_clear_bit(MSR_RMID_SNC_CONFIG, 0);
 }
 
+/* CPU models that support MSR_RMID_SNC_CONFIG */
+static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
+	X86_MATCH_VFM(INTEL_ICELAKE_X, 0),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, 0),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, 0),
+	{}
+};
+
+/*
+ * There isn't a simple hardware bit that indicates whether a CPU is running
+ * in Sub-NUMA Cluster (SNC) mode. Infer the state by comparing the
+ * number of CPUs sharing the L3 cache with CPU0 to the number of CPUs in
+ * the same NUMA node as CPU0.
+ * It is not possible to accurately determine SNC state if the system is
+ * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes
+ * to L3 caches. It will be OK if system is booted with hyperthreading
+ * disabled (since this doesn't affect the ratio).
+ */
+static __init int snc_get_config(void)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(0, RESCTRL_L3_CACHE);
+	const cpumask_t *node0_cpumask;
+	int cpus_per_node, cpus_per_l3;
+	int ret;
+
+	if (!x86_match_cpu(snc_cpu_ids) || !ci)
+		return 1;
+
+	cpus_read_lock();
+	if (num_online_cpus() != num_present_cpus())
+		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
+	cpus_read_unlock();
+
+	node0_cpumask = cpumask_of_node(cpu_to_node(0));
+
+	cpus_per_node = cpumask_weight(node0_cpumask);
+	cpus_per_l3 = cpumask_weight(&ci->shared_cpu_map);
+
+	if (!cpus_per_node || !cpus_per_l3)
+		return 1;
+
+	ret = cpus_per_l3 / cpus_per_node;
+
+	/* sanity check: Only valid results are 1, 2, 3, 4 */
+	switch (ret) {
+	case 1:
+		break;
+	case 2 ... 4:
+		pr_info("Sub-NUMA Cluster mode detected with %d nodes per L3 cache\n", ret);
+		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_L3_NODE;
+		break;
+	default:
+		pr_warn("Ignore improbable SNC node count %d\n", ret);
+		ret = 1;
+		break;
+	}
+
+	return ret;
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
@@ -1117,6 +1181,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int threshold;
 	int ret;
 
+	snc_nodes_per_l3_cache = snc_get_config();
+
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
 	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;

