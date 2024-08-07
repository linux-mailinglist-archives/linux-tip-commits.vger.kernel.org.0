Return-Path: <linux-tip-commits+bounces-1965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7094A64B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E0D280ECD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443421E3CD3;
	Wed,  7 Aug 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3B5VV0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKraatce"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D41E288F;
	Wed,  7 Aug 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027907; cv=none; b=DN2+JTKx4juWa2JvD3Tl+yuCIhZXM5KGYA7Trw7bu1brnj7vDjnND/nuomuqAXNVqoIH6uxD4LiU7ESJacaBUooiZaZEZXUcZ1BQIr+0yCQtM7OUaagsnm7GIyqpxN572t+et4a3cxeUy6utGUEIcjD56x2H/fRPQ+SpVhVYk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027907; c=relaxed/simple;
	bh=NNtkoNNV8TeR4V11Xi07UIN9jLrW77pRIC77+bhVy98=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NkDnDD/NQAjFoj5vkSB+n/VNO4LjNkALx9kbVpzbjJvZJ4Fj8Mk/I2X9noZEHpWa9jkAXy21+G4mLJ5jlbViIawYgGh9Vk1wZLk4L6Qn00kKjQK8vudCZTqqTdosOHlM2fbP3SMPK1hxHaVx3p/YH1Is12zLc2oE3i5KgPk9VmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l3B5VV0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKraatce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5JynV4laSGM/tFLk75KAOXCEVbA4FSrLdWwJ6GbrQ=;
	b=l3B5VV0FHGf9bHA/O5/T0kBgZfMTBAVe8M6kxa85Wg2Fc/3OUdfBArAHVmiS7znU+3wn7I
	SoMS7NGnEqkqZozBSZ90knKYjNIUT+x+xT8GtCbx2wLMq0umRdD06/DSnKe+bWzodgvYzq
	QVHSHoJ1gE+kGzZt4g9su+kcKpJUN33EUYargXsSscKzKQUOUWbuV4W9sZEUeFUF7/oUpH
	uo/yd3/CPBdgG2yvKlrkWpTeWensU6+OYRqTNQp5ySaqgatJyFr8a7it3v1tO3sYvQ02zJ
	qwuZlA4yh3i1ZunOybqOB+mNCgLWXQu+Ca+vCamtkO3pDcEcoU/43iOaD+fpsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dU5JynV4laSGM/tFLk75KAOXCEVbA4FSrLdWwJ6GbrQ=;
	b=EKraatcez8w/d368qq0GJ3i542zIMeMCeaePMxOKfcZnHpGYg+e1QJCUjgxpqH9RKzl8NC
	+Fh7PXhsB8Lo8QBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Lunar Lake support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731141353.759643-3-kan.liang@linux.intel.com>
References: <20240731141353.759643-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302789796.2215.3244304551949163711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9bd7dfe3a5262d3b29debdc66e1410201a235019
Gitweb:        https://git.kernel.org/tip/9bd7dfe3a5262d3b29debdc66e1410201a235019
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 31 Jul 2024 07:13:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Aug 2024 16:54:46 +02:00

perf/x86/intel/uncore: Add Lunar Lake support

The uncore subsystem for Lunar Lake is similar to the previous
Meteor Lake. The uncore PerfMon registers are located at both
MSR and MMIO space.

The ARB and iMC are kept. There is no difference from the Meteor Lake.
Move the global control initialization to the first box of the CBOX.

The sNCU is moved to the MMIO space.

The HBO is newly added and only be accessed from the MMIO space.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240731141353.759643-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |   6 +-
 arch/x86/events/intel/uncore.h     |   2 +-
 arch/x86/events/intel/uncore_snb.c | 133 ++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 42968ad..d98fac5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1816,6 +1816,11 @@ static const struct intel_uncore_init_fun mtl_uncore_init __initconst = {
 	.mmio_init = adl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
+	.cpu_init = lnl_uncore_cpu_init,
+	.mmio_init = lnl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1896,6 +1901,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 027ef29..79ff32e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -611,10 +611,12 @@ void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
+void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
+void lnl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 05fe6e9..983beed 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -252,6 +252,7 @@ DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
 DEFINE_UNCORE_FORMAT_ATTR(cmask8, cmask, "config:24-31");
 DEFINE_UNCORE_FORMAT_ATTR(threshold, threshold, "config:24-29");
+DEFINE_UNCORE_FORMAT_ATTR(threshold2, threshold, "config:24-31");
 
 /* Sandy Bridge uncore support */
 static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -746,6 +747,34 @@ void mtl_uncore_cpu_init(void)
 	uncore_msr_uncores = mtl_msr_uncores;
 }
 
+static struct intel_uncore_type *lnl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	&mtl_uncore_arb,
+	NULL
+};
+
+#define LNL_UNC_MSR_GLOBAL_CTL			0x240e
+
+static void lnl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	if (box->pmu->pmu_idx == 0)
+		wrmsrl(LNL_UNC_MSR_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static struct intel_uncore_ops lnl_uncore_msr_ops = {
+	.init_box	= lnl_uncore_msr_init_box,
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
+void lnl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 4;
+	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+	uncore_msr_uncores = lnl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1716,3 +1745,107 @@ void adl_uncore_mmio_init(void)
 }
 
 /* end of Alder Lake MMIO uncore support */
+
+/* Lunar Lake MMIO uncore support */
+#define LNL_UNCORE_PCI_SAFBAR_OFFSET		0x68
+#define LNL_UNCORE_MAP_SIZE			0x1000
+#define LNL_UNCORE_SNCU_BASE			0xE4B000
+#define LNL_UNCORE_SNCU_CTR			0x390
+#define LNL_UNCORE_SNCU_CTRL			0x398
+#define LNL_UNCORE_SNCU_BOX_CTL			0x380
+#define LNL_UNCORE_GLOBAL_CTL			0x700
+#define LNL_UNCORE_HBO_BASE			0xE54000
+#define LNL_UNCORE_HBO_OFFSET			-4096
+#define LNL_UNCORE_HBO_CTR			0x570
+#define LNL_UNCORE_HBO_CTRL			0x550
+#define LNL_UNCORE_HBO_BOX_CTL			0x548
+
+#define LNL_UNC_CTL_THRESHOLD			0xff000000
+#define LNL_UNC_RAW_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 SNB_UNC_CTL_UMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET | \
+						 SNB_UNC_CTL_INVERT | \
+						 LNL_UNC_CTL_THRESHOLD)
+
+static struct attribute *lnl_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_threshold2.attr,
+	NULL
+};
+
+static const struct attribute_group lnl_uncore_format_group = {
+	.name		= "format",
+	.attrs		= lnl_uncore_formats_attr,
+};
+
+static void lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 LNL_UNCORE_HBO_OFFSET);
+}
+
+static struct intel_uncore_ops lnl_uncore_hbo_ops = {
+	.init_box	= lnl_uncore_hbo_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_hbo = {
+	.name		= "hbo",
+	.num_counters   = 4,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_HBO_CTR,
+	.event_ctl	= LNL_UNCORE_HBO_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_HBO_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_hbo_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static void lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 0);
+
+	if (box->io_addr)
+		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + LNL_UNCORE_GLOBAL_CTL);
+}
+
+static struct intel_uncore_ops lnl_uncore_sncu_ops = {
+	.init_box	= lnl_uncore_sncu_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_sncu = {
+	.name		= "sncu",
+	.num_counters   = 2,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_SNCU_CTR,
+	.event_ctl	= LNL_UNCORE_SNCU_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_SNCU_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_sncu_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static struct intel_uncore_type *lnl_mmio_uncores[] = {
+	&adl_uncore_imc,
+	&lnl_uncore_hbo,
+	&lnl_uncore_sncu,
+	NULL
+};
+
+void lnl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = lnl_mmio_uncores;
+}
+
+/* end of Lunar Lake MMIO uncore support */

