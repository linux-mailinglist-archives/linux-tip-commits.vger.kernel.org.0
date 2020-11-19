Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C62B910C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKSL3p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgKSL3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 06:29:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506AC0613D4;
        Thu, 19 Nov 2020 03:29:38 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:29:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605785375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7H4KhXi9D8ARQ/NdwFDW7kephBNEzEByPbRBogYamo=;
        b=mXCXC1OKgE6llcDNn4erUyWh/aW/gwPmUQR1pu3+fzCAGCtDO2W0bQsQbu5B6nivvlhxMS
        eRZpLX4OZ6TwQ7IT8Ay5gYS9zH4fcb8bnr9BoE2QR3PPcaBs/8EWyvxN/kUyO6VK3ftFne
        p7yelPmdR+YD/CsSxyTbtrV72bYECMEhv/RRxL7lABMfhx+c+QyZ33yJhVTpJ1YBiH6wvG
        wIdc1h7i9pRXwH34N97/JSEgPg4HfueioJK6evD96nh1LFLCKw2OQmYiBq0l1DdJkQbibP
        XrlC7saMPwkzRPO4jbCqjuq9w0diUWtY8B6c9k68dGwPeLn+XJzRLyafKd77VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605785375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7H4KhXi9D8ARQ/NdwFDW7kephBNEzEByPbRBogYamo=;
        b=8/V3A8Ddb8xM0y5vqmVfLw8Xyppvlti1qaJuXMdOXQrATTIQmY7mfaWsvBrsHAzSThxUne
        bN7rKJ2YXACRMXDw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Remove amd_get_nb_id()
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109210659.754018-3-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <160578537454.11244.362527036655813732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     db970bd231c2264a062e0de4dcf4ead5e6669e7a
Gitweb:        https://git.kernel.org/tip/db970bd231c2264a062e0de4dcf4ead5e6669e7a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 09 Nov 2020 21:06:57 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 11:43:17 +01:00

x86/CPU/AMD: Remove amd_get_nb_id()

The Last Level Cache ID is returned by amd_get_nb_id(). In practice,
this value is the same as the AMD NodeId for callers of this function.
The NodeId is saved in struct cpuinfo_x86.cpu_die_id.

Replace calls to amd_get_nb_id() with the logical CPU's cpu_die_id and
remove the function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201109210659.754018-3-Yazen.Ghannam@amd.com
---
 arch/x86/events/amd/core.c       | 2 +-
 arch/x86/include/asm/processor.h | 2 --
 arch/x86/kernel/amd_nb.c         | 4 ++--
 arch/x86/kernel/cpu/amd.c        | 6 ------
 arch/x86/kernel/cpu/cacheinfo.c  | 2 +-
 arch/x86/kernel/cpu/mce/amd.c    | 4 ++--
 arch/x86/kernel/cpu/mce/inject.c | 4 ++--
 drivers/edac/amd64_edac.c        | 4 ++--
 drivers/edac/mce_amd.c           | 2 +-
 9 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 39eb276..2c1791c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -538,7 +538,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = amd_get_nb_id(cpu);
+	nb_id = topology_die_id(cpu);
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 82a08b5..c20a52b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -813,10 +813,8 @@ extern int set_tsc_mode(unsigned int val);
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
 #else
-static inline u16 amd_get_nb_id(int cpu)		{ return 0; }
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 #endif
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 18f6b7c..b439695 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -384,7 +384,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link = node_to_amd_nb(amd_get_nb_id(cpu))->link;
+	struct pci_dev *link = node_to_amd_nb(topology_die_id(cpu))->link;
 	unsigned int mask;
 
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -398,7 +398,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb = node_to_amd_nb(amd_get_nb_id(cpu));
+	struct amd_northbridge *nb = node_to_amd_nb(topology_die_id(cpu));
 	unsigned int reg;
 	int cuid;
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2f1fbd8..1f71c76 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -424,12 +424,6 @@ clear_ppin:
 	clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
 }
 
-u16 amd_get_nb_id(int cpu)
-{
-	return per_cpu(cpu_llc_id, cpu);
-}
-EXPORT_SYMBOL_GPL(amd_get_nb_id);
-
 u32 amd_get_nodes_per_socket(void)
 {
 	return nodes_per_socket;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f9ac682..3ca9be4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -580,7 +580,7 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 	if (index < 3)
 		return;
 
-	node = amd_get_nb_id(smp_processor_id());
+	node = topology_die_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0c6b02d..e486f96 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1341,7 +1341,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(amd_get_nb_id(cpu));
+		nb = node_to_amd_nb(topology_die_id(cpu));
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1445,7 +1445,7 @@ static void threshold_remove_bank(struct threshold_bank *bank)
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
 		nb->bank4 = NULL;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3a44346..7b36073 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -522,8 +522,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(amd_get_nb_id(cpu));
-		cpu = get_nbc_for_node(amd_get_nb_id(cpu));
+		toggle_nb_mca_mst_cpu(topology_die_id(cpu));
+		cpu = get_nbc_for_node(topology_die_id(cpu));
 	}
 
 	get_online_cpus();
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1362274..39fb900 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1133,7 +1133,7 @@ static int k8_early_channel_count(struct amd64_pvt *pvt)
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = amd_get_nb_id(m->extcpu);
+	u16 mce_nid = topology_die_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3046,7 +3046,7 @@ static void get_cpus_on_this_dct_cpumask(struct cpumask *mask, u16 nid)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (amd_get_nb_id(cpu) == nid)
+		if (topology_die_id(cpu) == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7f28edb..85095e3 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -869,7 +869,7 @@ static void decode_mc3_mce(struct mce *m)
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = amd_get_nb_id(m->extcpu);
+	int node_id = topology_die_id(m->extcpu);
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
