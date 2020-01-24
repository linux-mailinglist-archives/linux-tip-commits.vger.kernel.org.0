Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59105148E71
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jan 2020 20:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbgAXTLS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jan 2020 14:11:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391882AbgAXTLR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MI-0007bk-Dt; Fri, 24 Jan 2020 20:11:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 43D001C1A5F;
        Fri, 24 Jan 2020 20:11:09 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:09 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224111055.11836-6-maz@kernel.org>
References: <20191224111055.11836-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157989306908.396.16938186680182683031.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5e5168461c22c8738d31d4ee12a5cbc2ab0aa440
Gitweb:        https://git.kernel.org/tip/5e5168461c22c8738d31d4ee12a5cbc2ab0aa440
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 24 Dec 2019 11:10:28 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Jan 2020 14:22:19 

irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation

GICv4.1 defines a new VPE table that is potentially shared between
both the ITSs and the redistributors, following complicated affinity
rules.

To make things more confusing, the programming of this table at
the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
for something completely different.

The code flow is somewhat complexified by the need to respect the
affinities required by the HW, meaning that tables can either be
inherited from a previously discovered ITS or redistributor.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191224111055.11836-6-maz@kernel.org
---
 arch/arm/include/asm/arch_gicv3.h   |   2 +-
 arch/arm64/include/asm/arch_gicv3.h |   1 +-
 drivers/irqchip/irq-gic-v3-its.c    | 310 ++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h  |  33 ++-
 4 files changed, 339 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index fa50bb0..b5752f0 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -327,6 +328,7 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
 /*
  * GITS_VPROPBASER - hi and lo bits may be accessed independently.
  */
+#define gits_read_vpropbaser(c)		__gic_readq_nonatomic(c)
 #define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 89e4c8b..4750fc8 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -141,6 +141,7 @@ static inline u32 gic_read_rpr(void)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+#define gits_read_vpropbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6b0a8d6..9124f7f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -106,6 +106,7 @@ struct its_node {
 	u64			typer;
 	u64			cbaser_save;
 	u32			ctlr_save;
+	u32			mpidr;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -116,6 +117,7 @@ struct its_node {
 };
 
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
+#define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -2100,6 +2102,65 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	return indirect;
 }
 
+static u32 compute_common_aff(u64 val)
+{
+	u32 aff, clpiaff;
+
+	aff = FIELD_GET(GICR_TYPER_AFFINITY, val);
+	clpiaff = FIELD_GET(GICR_TYPER_COMMON_LPI_AFF, val);
+
+	return aff & ~(GENMASK(31, 0) >> (clpiaff * 8));
+}
+
+static u32 compute_its_aff(struct its_node *its)
+{
+	u64 val;
+	u32 svpet;
+
+	/*
+	 * Reencode the ITS SVPET and MPIDR as a GICR_TYPER, and compute
+	 * the resulting affinity. We then use that to see if this match
+	 * our own affinity.
+	 */
+	svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
+	val  = FIELD_PREP(GICR_TYPER_COMMON_LPI_AFF, svpet);
+	val |= FIELD_PREP(GICR_TYPER_AFFINITY, its->mpidr);
+	return compute_common_aff(val);
+}
+
+static struct its_node *find_sibling_its(struct its_node *cur_its)
+{
+	struct its_node *its;
+	u32 aff;
+
+	if (!FIELD_GET(GITS_TYPER_SVPET, cur_its->typer))
+		return NULL;
+
+	aff = compute_its_aff(cur_its);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser;
+
+		if (!is_v4_1(its) || its == cur_its)
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		return its;
+	}
+
+	return NULL;
+}
+
 static void its_free_tables(struct its_node *its)
 {
 	int i;
@@ -2142,6 +2203,17 @@ static int its_alloc_tables(struct its_node *its)
 			break;
 
 		case GITS_BASER_TYPE_VCPU:
+			if (is_v4_1(its)) {
+				struct its_node *sibling;
+
+				WARN_ON(i != 2);
+				if ((sibling = find_sibling_its(its))) {
+					*baser = sibling->tables[2];
+					its_write_baser(its, baser, baser->val);
+					continue;
+				}
+			}
+
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    ITS_MAX_VPEID_BITS);
@@ -2163,6 +2235,220 @@ static int its_alloc_tables(struct its_node *its)
 	return 0;
 }
 
+static u64 inherit_vpe_l1_table_from_its(void)
+{
+	struct its_node *its;
+	u64 val;
+	u32 aff;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser, addr;
+
+		if (!is_v4_1(its))
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		/* We have a winner! */
+		val  = GICR_VPROPBASER_4_1_VALID;
+		if (baser & GITS_BASER_INDIRECT)
+			val |= GICR_VPROPBASER_4_1_INDIRECT;
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
+				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
+		switch (FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser)) {
+		case GIC_PAGE_SIZE_64K:
+			addr = GITS_BASER_ADDR_48_to_52(baser);
+			break;
+		default:
+			addr = baser & GENMASK_ULL(47, 12);
+			break;
+		}
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
+		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
+				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
+				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
+
+		return val;
+	}
+
+	return 0;
+}
+
+static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
+{
+	u32 aff;
+	u64 val;
+	int cpu;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	for_each_possible_cpu(cpu) {
+		void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
+		u32 tmp;
+
+		if (!base || cpu == smp_processor_id())
+			continue;
+
+		val = gic_read_typer(base + GICR_TYPER);
+		tmp = compute_common_aff(val);
+		if (tmp != aff)
+			continue;
+
+		/*
+		 * At this point, we have a victim. This particular CPU
+		 * has already booted, and has an affinity that matches
+		 * ours wrt CommonLPIAff. Let's use its own VPROPBASER.
+		 * Make sure we don't write the Z bit in that case.
+		 */
+		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+		val &= ~GICR_VPROPBASER_4_1_Z;
+
+		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
+
+		return val;
+	}
+
+	return 0;
+}
+
+static int allocate_vpe_l1_table(void)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val, gpsz, npg, pa;
+	unsigned int psz = SZ_64K;
+	unsigned int np, epp, esz;
+	struct page *page;
+
+	if (!gic_rdists->has_rvpeid)
+		return 0;
+
+	/*
+	 * if VPENDBASER.Valid is set, disable any previously programmed
+	 * VPE by setting PendingLast while clearing Valid. This has the
+	 * effect of making sure no doorbell will be generated and we can
+	 * then safely clear VPROPBASER.Valid.
+	 */
+	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
+		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+				      vlpi_base + GICR_VPENDBASER);
+
+	/*
+	 * If we can inherit the configuration from another RD, let's do
+	 * so. Otherwise, we have to go through the allocation process. We
+	 * assume that all RDs have the exact same requirements, as
+	 * nothing will work otherwise.
+	 */
+	val = inherit_vpe_l1_table_from_rd(&gic_data_rdist()->vpe_table_mask);
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
+	if (!gic_data_rdist()->vpe_table_mask)
+		return -ENOMEM;
+
+	val = inherit_vpe_l1_table_from_its();
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	/* First probe the page size */
+	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
+	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
+	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
+
+	switch (gpsz) {
+	default:
+		gpsz = GIC_PAGE_SIZE_4K;
+		/* fall through */
+	case GIC_PAGE_SIZE_4K:
+		psz = SZ_4K;
+		break;
+	case GIC_PAGE_SIZE_16K:
+		psz = SZ_16K;
+		break;
+	case GIC_PAGE_SIZE_64K:
+		psz = SZ_64K;
+		break;
+	}
+
+	/*
+	 * Start populating the register from scratch, including RO fields
+	 * (which we want to print in debug cases...)
+	 */
+	val = 0;
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, gpsz);
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ENTRY_SIZE, esz);
+
+	/* How many entries per GIC page? */
+	esz++;
+	epp = psz / (esz * SZ_8);
+
+	/*
+	 * If we need more than just a single L1 page, flag the table
+	 * as indirect and compute the number of required L1 pages.
+	 */
+	if (epp < ITS_MAX_VPEID) {
+		int nl2;
+
+		val |= GICR_VPROPBASER_4_1_INDIRECT;
+
+		/* Number of L2 pages required to cover the VPEID space */
+		nl2 = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
+
+		/* Number of L1 pages to point to the L2 pages */
+		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
+	} else {
+		npg = 1;
+	}
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
+
+	/* Right, that's the number of CPU pages we need for L1 */
+	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);
+
+	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %d\n",
+		 np, npg, psz, epp, esz);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	if (!page)
+		return -ENOMEM;
+
+	gic_data_rdist()->vpe_l1_page = page;
+	pa = virt_to_phys(page_address(page));
+	WARN_ON(!IS_ALIGNED(pa, psz));
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
+	val |= GICR_VPROPBASER_RaWb;
+	val |= GICR_VPROPBASER_InnerShareable;
+	val |= GICR_VPROPBASER_4_1_Z;
+	val |= GICR_VPROPBASER_4_1_VALID;
+
+out:
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
+
+	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
+		 smp_processor_id(), val,
+		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
+
+	return 0;
+}
+
 static int its_alloc_collections(struct its_node *its)
 {
 	int i;
@@ -2362,7 +2648,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
-	if (gic_rdists->has_vlpis) {
+	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
 		/*
@@ -2386,6 +2672,16 @@ static void its_cpu_init_lpis(void)
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
+	if (allocate_vpe_l1_table()) {
+		/*
+		 * If the allocation has failed, we're in massive trouble.
+		 * Disable direct injection, and pray that no VM was
+		 * already running...
+		 */
+		gic_rdists->has_rvpeid = false;
+		gic_rdists->has_vlpis = false;
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -3788,6 +4084,14 @@ static int __init its_probe_one(struct resource *res,
 		} else {
 			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
 		}
+
+		if (is_v4_1(its)) {
+			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
+
+			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
+				&res->start, its->mpidr, svpet);
+		}
 	}
 
 	its->numa_node = numa_node;
@@ -4148,6 +4452,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	bool has_v4 = false;
 	int err;
 
+	gic_rdists = rdists;
+
 	its_parent = parent_domain;
 	of_node = to_of_node(handle);
 	if (of_node)
@@ -4160,8 +4466,6 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return -ENXIO;
 	}
 
-	gic_rdists = rdists;
-
 	err = allocate_lpi_tables();
 	if (err)
 		return err;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9dfe641..db0a111 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -102,6 +102,11 @@
 
 #define GIC_V3_DIST_SIZE		0x10000
 
+#define GIC_PAGE_SIZE_4K		0ULL
+#define GIC_PAGE_SIZE_16K		1ULL
+#define GIC_PAGE_SIZE_64K		2ULL
+#define GIC_PAGE_SIZE_MASK		3ULL
+
 /*
  * Re-Distributor registers, offsets from RD_base
  */
@@ -239,6 +244,8 @@
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
 #define GICR_TYPER_RVPEID		(1U << 7)
+#define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
+#define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
 #define GIC_V3_REDIST_SIZE		0x20000
 
@@ -277,6 +284,18 @@
 #define GICR_VPROPBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWt)
 #define GICR_VPROPBASER_RaWaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWb)
 
+/*
+ * GICv4.1 VPROPBASER reinvention. A subtle mix between the old
+ * VPROPBASER and ITS_BASER. Just not quite any of the two.
+ */
+#define GICR_VPROPBASER_4_1_VALID	(1ULL << 63)
+#define GICR_VPROPBASER_4_1_ENTRY_SIZE	GENMASK_ULL(61, 59)
+#define GICR_VPROPBASER_4_1_INDIRECT	(1ULL << 55)
+#define GICR_VPROPBASER_4_1_PAGE_SIZE	GENMASK_ULL(54, 53)
+#define GICR_VPROPBASER_4_1_Z		(1ULL << 52)
+#define GICR_VPROPBASER_4_1_ADDR	GENMASK_ULL(51, 12)
+#define GICR_VPROPBASER_4_1_SIZE	GENMASK_ULL(6, 0)
+
 #define GICR_VPENDBASER			0x0078
 
 #define GICR_VPENDBASER_SHAREABILITY_SHIFT		(10)
@@ -314,6 +333,7 @@
 #define GITS_CTLR			0x0000
 #define GITS_IIDR			0x0004
 #define GITS_TYPER			0x0008
+#define GITS_MPIDR			0x0018
 #define GITS_CBASER			0x0080
 #define GITS_CWRITER			0x0088
 #define GITS_CREADR			0x0090
@@ -347,6 +367,8 @@
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
+#define GITS_TYPER_VMAPP		(1ULL << 40)
+#define GITS_TYPER_SVPET		GENMASK_ULL(42, 41)
 
 #define GITS_IIDR_REV_SHIFT		12
 #define GITS_IIDR_REV_MASK		(0xf << GITS_IIDR_REV_SHIFT)
@@ -417,10 +439,11 @@
 #define GITS_BASER_InnerShareable					\
 	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
 #define GITS_BASER_PAGE_SIZE_SHIFT	(8)
-#define GITS_BASER_PAGE_SIZE_4K		(0ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_16K	(1ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_64K	(2ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_MASK	(3ULL << GITS_BASER_PAGE_SIZE_SHIFT)
+#define __GITS_BASER_PSZ(sz)		(GIC_PAGE_SIZE_ ## sz << GITS_BASER_PAGE_SIZE_SHIFT)
+#define GITS_BASER_PAGE_SIZE_4K		__GITS_BASER_PSZ(4K)
+#define GITS_BASER_PAGE_SIZE_16K	__GITS_BASER_PSZ(16K)
+#define GITS_BASER_PAGE_SIZE_64K	__GITS_BASER_PSZ(64K)
+#define GITS_BASER_PAGE_SIZE_MASK	__GITS_BASER_PSZ(MASK)
 #define GITS_BASER_PAGES_MAX		256
 #define GITS_BASER_PAGES_SHIFT		(0)
 #define GITS_BASER_NR_PAGES(r)		(((r) & 0xff) + 1)
@@ -612,8 +635,10 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
+		struct page	*vpe_l1_page;
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
+		cpumask_t	*vpe_table_mask;
 	} __percpu		*rdist;
 	phys_addr_t		prop_table_pa;
 	void			*prop_table_va;
