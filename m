Return-Path: <linux-tip-commits+bounces-2885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B89D9DE6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EDCB22B63
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339F1DE2AA;
	Tue, 26 Nov 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ewa1sxW2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYzRJqZw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0069D31;
	Tue, 26 Nov 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648239; cv=none; b=iDiA3YTeo2kBPQt6XTuk6XEF1A417MaLpSOuBpoRj1dpO8/L9IRPzfTEhQshC5jGl3OXTV6tgEQ/KalQVF+NloRyXHCAQ7F5/2SntzmxQxKRou8dZRvLptPsKZu/Ja9DnhnQ5K2fbSUM35z4cT88Eq0bMTsvdMu2PtXS1Nnfq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648239; c=relaxed/simple;
	bh=bW+RePTpBYAc14xwlwGbndtb7RAmp9WgBOiayb8C1kM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PjQ60i4qTjHgaDTlPhL/genYz7IouBlEx2CMQkdrKoooALJzirt/ZRdT2KtQ6DrB0KEpMH9/4Bga9IpEmk4+by7uViA8bE+sPnhCBZiZZhmBgFE27lyKvSe30KjVKqiJBw2q9wH9x2IeYOWM5apVIUtMWdIyM4xb0gfD/U9CZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ewa1sxW2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYzRJqZw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 19:10:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732648235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9j90idOre3ZuAnf6kwFV3UdptClNKbtMH5d4CknwTJk=;
	b=Ewa1sxW2Fm2C4MC3J75w1OgNxGPO08F8wG6eMbB32lhfdh8paEj1u1UPg++DT57q12GCXw
	cjjodbhxhK2v9vBjjjs+XjFE2Iw1XdzeWcMTL51snqMKscTMYUaytRc3L1232v9vJ2Bg+o
	3QDR30zr4eoUFSONph4o8c2iixuXIpffr8bOVow03sA/lf30/98z2JW9nJr5h8NbwbxmsR
	R0QhJ5m4SeYZPKI9zRkttY8zHgYZf5PBWoIdw3LHQVaUACImc5zoBtYNAdEZ6L7hW5yVHb
	JqVNwj0P8z94xHL+AhQiAbodFs9AQdGRcEG9MkP33YV7xAVAF7i71oc0wRfcxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732648235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9j90idOre3ZuAnf6kwFV3UdptClNKbtMH5d4CknwTJk=;
	b=fYzRJqZwIehhH1qf2QDmarcENXToRC/hKDYaehl83w/et2FWsFIQsUuzMUKwF79WAiZ0w7
	pVYVaBzNViOFzFAg==
From: "tip-bot2 for Zhou Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gicv3-its: Add workaround for hip09 ITS
 erratum 162100801
Cc: Marc Zyngier <maz@kernel.org>, Nianyao Tang <tangnianyao@huawei.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173264823263.412.279402930930170658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f82e62d470cc990ebd9d691f931dd418e4e9cea9
Gitweb:        https://git.kernel.org/tip/f82e62d470cc990ebd9d691f931dd418e4e9cea9
Author:        Zhou Wang <wangzhou1@hisilicon.com>
AuthorDate:    Sat, 16 Nov 2024 16:01:26 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 26 Nov 2024 20:06:05 +01:00

irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801

When enabling GICv4.1 in hip09, VMAPP fails to clear some caches during
the unmap operation, which can causes vSGIs to be lost.

To fix the issue, invalidate the related vPE cache through GICR_INVALLR
after VMOVP.

Suggested-by: Marc Zyngier <maz@kernel.org>
Co-developed-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>

---
 Documentation/arch/arm64/silicon-errata.rst |  2 +-
 arch/arm64/Kconfig                          | 11 ++++-
 drivers/irqchip/irq-gic-v3-its.c            | 50 +++++++++++++++-----
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 65bfab1..77db10e 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -258,6 +258,8 @@ stable kernels.
 | Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
 |                | ,11} SMMU PMCG  |                 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip09           | #162100801      | HISILICON_ERRATUM_162100801 |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d743737..ea39e3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1236,6 +1236,17 @@ config HISILICON_ERRATUM_161600802
 
 	  If unsure, say Y.
 
+config HISILICON_ERRATUM_162100801
+	bool "Hip09 162100801 erratum support"
+	default y
+	help
+	  When enabling GICv4.1 in hip09, VMAPP will fail to clear some caches
+	  during unmapping operation, which will cause some vSGIs lost.
+	  To fix the issue, invalidate related vPE cache through GICR_INVALLR
+	  after VMOVP.
+
+	  If unsure, say Y.
+
 config QCOM_FALKOR_ERRATUM_1003
 	bool "Falkor E1003: Incorrect translation due to ASID change"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 16acce0..92244cf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -47,6 +47,7 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
+#define ITS_FLAGS_WORKAROUND_HISILICON_162100801	(1ULL << 4)
 
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
@@ -64,6 +65,7 @@ static u32 lpi_id_bits;
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
 static u8 __ro_after_init lpi_prop_prio;
+static struct its_node *find_4_1_its(void);
 
 /*
  * Collection structure - just an ID, and a redistributor address to
@@ -3883,6 +3885,20 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	raw_spin_unlock_irqrestore(&vpe_proxy.lock, flags);
 }
 
+static void its_vpe_4_1_invall_locked(int cpu, struct its_vpe *vpe)
+{
+	void __iomem *rdbase;
+	u64 val;
+
+	val  = GICR_INVALLR_V;
+	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
+
+	guard(raw_spinlock)(&gic_data_rdist_cpu(cpu)->rd_lock);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVALLR);
+	wait_for_syncr(rdbase);
+}
+
 static int its_vpe_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3890,6 +3906,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	unsigned int from, cpu = nr_cpu_ids;
 	struct cpumask *table_mask;
+	struct its_node *its;
 	unsigned long flags;
 
 	/*
@@ -3952,6 +3969,11 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	vpe->col_idx = cpu;
 
 	its_send_vmovp(vpe);
+
+	its = find_4_1_its();
+	if (its && its->flags & ITS_FLAGS_WORKAROUND_HISILICON_162100801)
+		its_vpe_4_1_invall_locked(cpu, vpe);
+
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
 out:
@@ -4259,22 +4281,12 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 
 static void its_vpe_4_1_invall(struct its_vpe *vpe)
 {
-	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
-	val  = GICR_INVALLR_V;
-	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
-
 	/* Target the redistributor this vPE is currently known on */
 	cpu = vpe_to_cpuid_lock(vpe, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVALLR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	its_vpe_4_1_invall_locked(cpu, vpe);
 	vpe_to_cpuid_unlock(vpe, flags);
 }
 
@@ -4867,6 +4879,14 @@ static bool its_set_non_coherent(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_HISILICON_162100801;
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4913,6 +4933,14 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_hip07_161600802,
 	},
 #endif
+#ifdef CONFIG_HISILICON_ERRATUM_162100801
+	{
+		.desc	= "ITS: Hip09 erratum 162100801",
+		.iidr	= 0x00051736,
+		.mask	= 0xffffffff,
+		.init	= its_enable_quirk_hip09_162100801,
+	},
+#endif
 #ifdef CONFIG_ROCKCHIP_ERRATUM_3588001
 	{
 		.desc   = "ITS: Rockchip erratum RK3588001",

