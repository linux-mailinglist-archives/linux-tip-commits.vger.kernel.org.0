Return-Path: <linux-tip-commits+bounces-6048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FEAFE865
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A181617C016
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FB2D94AA;
	Wed,  9 Jul 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1S+O+R1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5o+I+4qq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F27277C9E;
	Wed,  9 Jul 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062098; cv=none; b=ZOTgZq7zKrQeIkK6KSMKbaJRaplZEyWFHpzBxWuncH5rGbG76BB5tIXyBCsQi8HLcCuApAOzk4gxORZRImdgtX9wKCEYPx7u8kH6XMNVnIRaT6hc0Mo87T5m6X0xl9qBqJ0V2VHw5T0uK3BySNpz9pX5vpaRvShSrTWppIZSvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062098; c=relaxed/simple;
	bh=mTNHG6d1VBpO436gqRUeUOCJXTNTTBe0GVOskMPDnFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BKAFR1JhYcXzRKcbj5LDYnSgpJyNT2Q0LokvCYjaYMbbvAaOLENx+Tw2mcR4kNw39KhF2kNpuGBO7WA/6HGLQXGsjjIXq0JeXTWNxSCKA7fpygqKHNSd79ElQg6skfEZ2R0bTArlPky7+9J+eduwK/YkVI23hipAbHjPc0o4cOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1S+O+R1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5o+I+4qq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 11:54:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752062095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ztyvuwppasfowTcLGfoPbjON/1uaFKdMIc3+S/+N+s=;
	b=M1S+O+R1IX9kZOmhX9kuogEf6GlXkaJPyfDd5t/IHP/jbXcQrIoIdZ/sh5vBSPCygqNfl5
	p4OQ4jMQkQBoXX2uYNQSQX7HdQXajLB4xZ/nsKxc9MOO0NKWQ8ZgqRjxGmyHNy1Z5GRNUJ
	JcvAdpcAPbZZ5PkPqvnmycxwWkqxv2el5yvL3MkJ43XtFNtPWhuq2aMUDbbifc0pDjHfBY
	/FVnLRnRYrbr4ut375Y9Pive5mguNYKV2ZtxOj8LqU4UfLoxSWlZtaNVWeSyy4alDNg2nZ
	9zp5zkIOwk9fYMGcwY4qrADAogKqJM5ixsLidwUVc+jTVwInRo/KPFdBsnri1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752062095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ztyvuwppasfowTcLGfoPbjON/1uaFKdMIc3+S/+N+s=;
	b=5o+I+4qqAgOkElQMhEBPc+TpoGbLNjvipjyZRiwVR+RvrWki1XM2G83/dYCjDXZGVeRRQR
	8nSW+8quSPS3tjAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Panther Lake support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707201750.616527-4-kan.liang@linux.intel.com>
References: <20250707201750.616527-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175206209416.406.2362229859706951950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     64ad6d6ede0cff2997e707dcb051bd4987508c27
Gitweb:        https://git.kernel.org/tip/64ad6d6ede0cff2997e707dcb051bd4987508c27
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 07 Jul 2025 13:17:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:19 +02:00

perf/x86/intel/uncore: Add Panther Lake support

The Panther Lake supports CBOX, MC, sNCU, and HBO uncore PMON.

The CBOX is similar to Lunar Lake. The only difference is the number of
CBOX.

The other three uncore PMON can be retrieved from the discovery table.
The global control register resides in the sNCU. The global freeze bit
is set by default. It must be cleared before monitoring any uncore
counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250707201750.616527-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |  7 ++-
 arch/x86/events/intel/uncore.h           |  2 +-
 arch/x86/events/intel/uncore_discovery.h |  4 +-
 arch/x86/events/intel/uncore_snb.c       | 71 +++++++++++++++++++++++-
 arch/x86/events/intel/uncore_snbep.c     |  2 +-
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e0815a1..a762f7f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1807,6 +1807,12 @@ static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
 	.mmio_init = lnl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
+	.cpu_init = ptl_uncore_cpu_init,
+	.mmio_init = ptl_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1888,6 +1894,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 3dcb88c..d8815ff 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -612,10 +612,12 @@ void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
 void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
+void ptl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
 void lnl_uncore_mmio_init(void);
+void ptl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 690f737..dff75c9 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -171,3 +171,7 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
 					  struct intel_uncore_box *box);
 void uncore_find_add_unit(struct intel_uncore_discovery_unit *node,
 			  struct rb_root *root, u16 *num_units);
+struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
+		   struct intel_uncore_type **extra, int max_num_types,
+		   struct intel_uncore_type **uncores);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index a1a9683..2afd4bb 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1855,3 +1855,74 @@ void lnl_uncore_mmio_init(void)
 }
 
 /* end of Lunar Lake MMIO uncore support */
+
+/* Panther Lake uncore support */
+
+#define UNCORE_PTL_MAX_NUM_UNCORE_TYPES		42
+#define UNCORE_PTL_TYPE_IMC			6
+#define UNCORE_PTL_TYPE_SNCU			34
+#define UNCORE_PTL_TYPE_HBO			41
+
+#define PTL_UNCORE_GLOBAL_CTL_OFFSET		0x380
+
+static struct intel_uncore_type ptl_uncore_imc = {
+	.name			= "imc",
+	.mmio_map_size		= 0xf00,
+};
+
+static void ptl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	intel_generic_uncore_mmio_init_box(box);
+
+	/* Clear the global freeze bit */
+	if (box->io_addr)
+		writel(0, box->io_addr + PTL_UNCORE_GLOBAL_CTL_OFFSET);
+}
+
+static struct intel_uncore_ops ptl_uncore_sncu_ops = {
+	.init_box		= ptl_uncore_sncu_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= intel_generic_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type ptl_uncore_sncu = {
+	.name			= "sncu",
+	.ops			= &ptl_uncore_sncu_ops,
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type ptl_uncore_hbo = {
+	.name			= "hbo",
+	.mmio_map_size		= 0xf00,
+};
+
+static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] = {
+	[UNCORE_PTL_TYPE_IMC] = &ptl_uncore_imc,
+	[UNCORE_PTL_TYPE_SNCU] = &ptl_uncore_sncu,
+	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
+};
+
+void ptl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
+						 ptl_uncores);
+}
+
+static struct intel_uncore_type *ptl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	NULL
+};
+
+void ptl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 6;
+	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
+	uncore_msr_uncores = ptl_msr_uncores;
+}
+
+/* end of Panther Lake uncore support */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a65431..e1f370b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6413,7 +6413,7 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
 		   struct intel_uncore_type **extra, int max_num_types,
 		   struct intel_uncore_type **uncores)

