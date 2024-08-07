Return-Path: <linux-tip-commits+bounces-1966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B494A652
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3084FB2DE3D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F81E4EE6;
	Wed,  7 Aug 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmPHh76n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAsEhBeY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB91E289F;
	Wed,  7 Aug 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027908; cv=none; b=nRTw+NAI3Lspia1sjU8b6kGo3A1qSCZBq0kL+dGgk2pWtKW5caxEA3NP5BEbiOpm21p99ADxJlhFW/whF8O1rEfIWNp9YsLJ8bzy2GrwZ609yG5nmMdBw/ximKfziKlVE+Nw9ULDfEU0egv11GofZ8wJ4DEsZPddRgvt9aB3svM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027908; c=relaxed/simple;
	bh=yhmqZIen4Wo7sowLFXv6x280t/84kqH/IySLeZ5Ht7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cblG9z3a/njfUg9vl2zfXl1I2m5H1XoyQlYOyXSPCXe+uBBXgMZMIINdliCJQUQ9ZzKa28lPBMqxBjwP4mOqM80G+0zzULMPGh/oqqjhZaJWmc7os9kg0g54sAvZf/pQ/KWiNU1qmaXOt1fK0RKSULzSvKG/ZXNpKhdF0KfZrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmPHh76n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAsEhBeY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVMqYciCsTuU550u0MH95dPneDLUq1N/CwCTxxFXB4Y=;
	b=AmPHh76nLagJ6IO3/g6VoYG9WyWFW29sZyN+dNqO5dMbsnkRAjU5Mw5Iia/H7KmcmDLNhw
	DOtcQVuM4/R1UpS7vGwiMYVsd+3pC7oa2jINPfmfypH/nd/6kt/YJ+cEHLUFYHccKonu/3
	2tzKFj55ZZPYvTrkLvaturb1AZil9WMKrhzIAvuB0ezE/aPKp/3kHnYKCs9s0B8QXt5G0P
	2pux4VB9W2kpoa0YsyJ7jw5Sfc6BKA5W2wMzvA/KXvNO6ia83tvPUeli+f2YGvtVSiCug7
	qTAwd6DHkXx6y4Ti8RvDoO8h7XEU18A6XNBbZ/RZIywCQvZJ/+fgd2Nbm4qyMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVMqYciCsTuU550u0MH95dPneDLUq1N/CwCTxxFXB4Y=;
	b=cAsEhBeYv+GaFisZXGzBeV9lmehrndtdaw+jyH4XcC54JNZ/nDYehlt/OA7PxxZ3E2PSpY
	wdRoqY7Ed6wuS+Bw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out common MMIO init
 and ops functions
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731141353.759643-2-kan.liang@linux.intel.com>
References: <20240731141353.759643-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789843.2215.6926174409123387665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     efb0c9c0b9f78d964fb23ec6fdebe5a493f477f3
Gitweb:        https://git.kernel.org/tip/efb0c9c0b9f78d964fb23ec6fdebe5a493f477f3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 31 Jul 2024 07:13:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:46 +02:00

perf/x86/intel/uncore: Factor out common MMIO init and ops functions

Some uncore PMON registers are located in the MMIO space. For the client
machine, the MMIO space is usually located at D0:F0 but in a different
BAR. For example, some uncore PMON registers are located in the SAF BAR,
not the MCHBAR in the Lunar Lake.

The current __uncore_imc_init_box() hard code the BAR information.
Factor out the uncore_get_box_mmio_addr() which uses the BAR information
as a parameter.
The only change is the error output message. The hardcode name 'MCHBAR'
is replaced by the offset of a BAR.

Add a new macro, MMIO_UNCORE_COMMON_OPS(), since the MMIO ops functions
are usually the same among different generations.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240731141353.759643-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 47 ++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 9462fd9..05fe6e9 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1481,33 +1481,35 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
 #define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
-static void __uncore_imc_init_box(struct intel_uncore_box *box,
-				  unsigned int base_offset)
+static void
+uncore_get_box_mmio_addr(struct intel_uncore_box *box,
+			 unsigned int base_offset,
+			 int bar_offset, int step)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
 	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
-	u32 mch_bar;
+	u32 bar;
 
 	if (!pdev) {
 		pr_warn("perf uncore: Cannot find matched IMC device.\n");
 		return;
 	}
 
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
-	/* MCHBAR is disabled */
-	if (!(mch_bar & BIT(0))) {
-		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+	pci_read_config_dword(pdev, bar_offset, &bar);
+	if (!(bar & BIT(0))) {
+		pr_warn("perf uncore: BAR 0x%x is disabled. Failed to map %s counters.\n",
+			bar_offset, type->name);
 		pci_dev_put(pdev);
 		return;
 	}
-	mch_bar &= ~BIT(0);
-	addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
+	bar &= ~BIT(0);
+	addr = (resource_size_t)(bar + step * pmu->pmu_idx);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
-	addr |= ((resource_size_t)mch_bar << 32);
+	pci_read_config_dword(pdev, bar_offset + 4, &bar);
+	addr |= ((resource_size_t)bar << 32);
 #endif
 
 	addr += base_offset;
@@ -1518,6 +1520,14 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
 	pci_dev_put(pdev);
 }
 
+static void __uncore_imc_init_box(struct intel_uncore_box *box,
+				  unsigned int base_offset)
+{
+	uncore_get_box_mmio_addr(box, base_offset,
+				 SNB_UNCORE_PCI_IMC_BAR_OFFSET,
+				 TGL_UNCORE_MMIO_IMC_MEM_OFFSET);
+}
+
 static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	__uncore_imc_init_box(box, 0);
@@ -1612,14 +1622,17 @@ static void adl_uncore_mmio_enable_box(struct intel_uncore_box *box)
 	writel(0, box->io_addr + uncore_mmio_box_ctl(box));
 }
 
+#define MMIO_UNCORE_COMMON_OPS()				\
+	.exit_box	= uncore_mmio_exit_box,		\
+	.disable_box	= adl_uncore_mmio_disable_box,	\
+	.enable_box	= adl_uncore_mmio_enable_box,	\
+	.disable_event	= intel_generic_uncore_mmio_disable_event,	\
+	.enable_event	= intel_generic_uncore_mmio_enable_event,	\
+	.read_counter	= uncore_mmio_read_counter,
+
 static struct intel_uncore_ops adl_uncore_mmio_ops = {
 	.init_box	= adl_uncore_imc_init_box,
-	.exit_box	= uncore_mmio_exit_box,
-	.disable_box	= adl_uncore_mmio_disable_box,
-	.enable_box	= adl_uncore_mmio_enable_box,
-	.disable_event	= intel_generic_uncore_mmio_disable_event,
-	.enable_event	= intel_generic_uncore_mmio_enable_event,
-	.read_counter	= uncore_mmio_read_counter,
+	MMIO_UNCORE_COMMON_OPS()
 };
 
 #define ADL_UNC_CTL_CHMASK_MASK			0x00000f00

