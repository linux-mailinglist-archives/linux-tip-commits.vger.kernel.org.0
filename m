Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F6C3BB857
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGEH40 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGEH4W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854AC0613DF;
        Mon,  5 Jul 2021 00:53:44 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFZunGTFnhJ2ZOLEFSK93AJXcyv451dgQ3Sb6Z33+1I=;
        b=pwYIsFsjoLGUdcjFYERJN+c/vOZ9xJgCwsj6grL9lwYzh/NgbDH1P6qGwF88mLDgi/+s2J
        5VGsxSO692PvRcLuOtpYb6t36C0p9ij9eXyXxESVQmt2ltHSJLPfjBuyHTcuSrT8Hl2J9J
        cvn0HID9K+4tzstlgK4Bt0dBzYlek38smZVJXbbQEvvtVLz6eZkUZpg7sG0aeloeMlCbML
        Qb8N+NDVundLHVBHGs0Re/Yj9AS/2w4JHtL/E0O+2CYygDK62bc9ieX/Cv7p/zKIkcesqM
        FuOtiL2zPO7OW3FyUV1E2IxW/xOb5FVfA5O0nMzZqA28Uxi/3nFWK8pkogKB0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFZunGTFnhJ2ZOLEFSK93AJXcyv451dgQ3Sb6Z33+1I=;
        b=FwnPFeavGHpc66Q/eo9s4xFlVQLWMIPU7gS2hzj6wwMFc7gFMlk8PHlpHAPAtLMBl3nLXE
        fhX9nu07rp5sbIBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 M2M support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-9-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162273.395.16534832346812561443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f57191edaaeb01279a88ace1be5b7230bdd8c0ab
Gitweb:        https://git.kernel.org/tip/f57191edaaeb01279a88ace1be5b7230bdd8c0ab
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:39 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server M2M support

The M2M blocks manage the interface between the mesh (operating on both
the mesh and the SMI3 protocol) and the memory controllers.

The layout of the control registers for a M2M uncore unit is a little
 bit different from the generic one. So a specific format and ops are
required. Expose the common PCI ops which can be reused.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-9-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 14 +++++------
 arch/x86/events/intel/uncore_discovery.h |  8 ++++++-
 arch/x86/events/intel/uncore_snbep.c     | 30 ++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index cc44311..6322df1 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -377,7 +377,7 @@ static struct intel_uncore_ops generic_uncore_msr_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
-static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -386,7 +386,7 @@ static void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
 }
 
-static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -394,7 +394,7 @@ static void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
 	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
 }
 
-static void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	int box_ctl = uncore_pci_box_ctl(box);
@@ -411,8 +411,8 @@ static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, hwc->config);
 }
 
-static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
-					     struct perf_event *event)
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
@@ -420,8 +420,8 @@ static void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
 	pci_write_config_dword(pdev, hwc->config_base, 0);
 }
 
-static u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
-					   struct perf_event *event)
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event)
 {
 	struct pci_dev *pdev = box->pci_dev;
 	struct hw_perf_event *hwc = &event->hw;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 9723243..b85655b 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -140,5 +140,13 @@ void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
 					     struct perf_event *event);
 
+void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_pci_disable_event(struct intel_uncore_box *box,
+					    struct perf_event *event);
+u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
+					  struct perf_event *event);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3c9d459..72ba8d4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5670,6 +5670,34 @@ static struct intel_uncore_type spr_uncore_imc = {
 	.ops			= &spr_uncore_mmio_ops,
 };
 
+static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
+					struct perf_event *event)
+{
+	struct pci_dev *pdev = box->pci_dev;
+	struct hw_perf_event *hwc = &event->hw;
+
+	pci_write_config_dword(pdev, hwc->config_base + 4, (u32)(hwc->config >> 32));
+	pci_write_config_dword(pdev, hwc->config_base, (u32)hwc->config);
+}
+
+static struct intel_uncore_ops spr_uncore_pci_ops = {
+	.init_box		= intel_generic_uncore_pci_init_box,
+	.disable_box		= intel_generic_uncore_pci_disable_box,
+	.enable_box		= intel_generic_uncore_pci_enable_box,
+	.disable_event		= intel_generic_uncore_pci_disable_event,
+	.enable_event		= spr_uncore_pci_enable_event,
+	.read_counter		= intel_generic_uncore_pci_read_counter,
+};
+
+#define SPR_UNCORE_PCI_COMMON_FORMAT()			\
+	SPR_UNCORE_COMMON_FORMAT(),			\
+	.ops			= &spr_uncore_pci_ops
+
+static struct intel_uncore_type spr_uncore_m2m = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m2m",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5680,7 +5708,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_pcu,
 	NULL,
 	&spr_uncore_imc,
-	NULL,
+	&spr_uncore_m2m,
 	NULL,
 	NULL,
 	NULL,
