Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4F3BB84B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhGEH4S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhGEH4R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2BC061574;
        Mon,  5 Jul 2021 00:53:40 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1OiQqZLfLG6vfeKrVNh3xSOU4rm1HnS0eXHWE9NjIA=;
        b=wMjiLhtn0Cbt6AQDJmguu801surjD4XvKti0nBrLxYkxg2GhALz9IECQXRhDQ0hDGbaTmp
        tHyXgJ2B7kiIRYWSo3WEnQ/gHNDyJZZM8308hIurfk8vCP7oYCeHkf758WjIhUvO/vNCya
        kRyzLx3x8i2ETiHk5ias/cW2Y0HOMbiqqp95BMtMXKrl3yTU6czYMgPMq9OePqc6Okseg+
        dwb0esN4whbUHo6l97i44sw6RV0j/o4RDr1MpZO4wF1mWhwBVh//ClI6TdqDBCNlVXXmzM
        Pihm10pZPtFmFxKVZBOoGFkHSvDlWAbV/cKJJfjT8GhNAyBTfRecSiHmT3txTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1OiQqZLfLG6vfeKrVNh3xSOU4rm1HnS0eXHWE9NjIA=;
        b=Xd2V/bfaNEJJdENNsHAhfih6KeiNeEhCcrmbsbIpFGCfyOsXUPzhAvSFJYyP1+6Y7St+1I
        pkW3q2/lfEqhEcDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support IMC free-running
 counters on Sapphire Rapids server
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-16-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-16-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547161799.395.2063699936448060602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c76826a65f50038f050424365dbf3f97203f8710
Gitweb:        https://git.kernel.org/tip/c76826a65f50038f050424365dbf3f97203f8710
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:42 +02:00

perf/x86/intel/uncore: Support IMC free-running counters on Sapphire Rapids server

Several free-running counters for IMC uncore blocks are supported on
Sapphire Rapids server.

They are not enumerated in the discovery tables. The number of the
free-running counter boxes is calculated from the number of
corresponding standard boxes.

The snbep_pci2phy_map_init() is invoked to setup the mapping from a PCI
BUS to a Die ID, which is used to locate the corresponding MC device of
a IMC uncore unit in the spr_uncore_imc_freerunning_init_box().

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-16-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 66 ++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9882549..2558e26 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5753,6 +5753,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 #define UNCORE_SPR_IIO				1
+#define UNCORE_SPR_IMC				6
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
@@ -5849,12 +5850,65 @@ static struct intel_uncore_type spr_uncore_iio_free_running = {
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 
+enum perf_uncore_spr_imc_freerunning_type_id {
+	SPR_IMC_DCLK,
+	SPR_IMC_PQ_CYCLES,
+
+	SPR_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters spr_imc_freerunning[] = {
+	[SPR_IMC_DCLK]		= { 0x22b0, 0x0, 0, 1, 48 },
+	[SPR_IMC_PQ_CYCLES]	= { 0x2318, 0x8, 0, 2, 48 },
+};
+
+static struct uncore_event_desc spr_uncore_imc_freerunning_events[] = {
+	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
+
+	INTEL_UNCORE_EVENT_DESC(rpq_cycles,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(wpq_cycles,		"event=0xff,umask=0x21"),
+	{ /* end: all zeroes */ },
+};
+
+#define SPR_MC_DEVICE_ID	0x3251
+
+static void spr_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
+{
+	int mem_offset = box->pmu->pmu_idx * ICX_IMC_MEM_STRIDE + SNR_IMC_MMIO_MEM0_OFFSET;
+
+	snr_uncore_mmio_map(box, uncore_mmio_box_ctl(box),
+			    mem_offset, SPR_MC_DEVICE_ID);
+}
+
+static struct intel_uncore_ops spr_uncore_imc_freerunning_ops = {
+	.init_box	= spr_uncore_imc_freerunning_init_box,
+	.exit_box	= uncore_mmio_exit_box,
+	.read_counter	= uncore_mmio_read_counter,
+	.hw_config	= uncore_freerunning_hw_config,
+};
+
+static struct intel_uncore_type spr_uncore_imc_free_running = {
+	.name			= "imc_free_running",
+	.num_counters		= 3,
+	.mmio_map_size		= SNR_IMC_MMIO_SIZE,
+	.num_freerunning_types	= SPR_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning		= spr_imc_freerunning,
+	.ops			= &spr_uncore_imc_freerunning_ops,
+	.event_descs		= spr_uncore_imc_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
 #define UNCORE_SPR_MSR_EXTRA_UNCORES		1
+#define UNCORE_SPR_MMIO_EXTRA_UNCORES		1
 
 static struct intel_uncore_type *spr_msr_uncores[UNCORE_SPR_MSR_EXTRA_UNCORES] = {
 	&spr_uncore_iio_free_running,
 };
 
+static struct intel_uncore_type *spr_mmio_uncores[UNCORE_SPR_MMIO_EXTRA_UNCORES] = {
+	&spr_uncore_imc_free_running,
+};
+
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 					struct intel_uncore_type *from_type)
 {
@@ -5957,7 +6011,17 @@ int spr_uncore_pci_init(void)
 
 void spr_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
+	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
+
+	if (ret)
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
+	else {
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
+							 spr_mmio_uncores);
+
+		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
+	}
 }
 
 /* end of SPR uncore support */
