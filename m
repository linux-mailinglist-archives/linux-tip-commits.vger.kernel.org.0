Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8363BB85A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhGEH41 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhGEH4W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46BC0613E0;
        Mon,  5 Jul 2021 00:53:45 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5qbjVS3usu5X8Jt1k2xVXiOBbGTJB0FJc7fd4HJCtk=;
        b=D0IHIqxyIMYwFghndvzQs+dGR1NkcMWgpOBprGuhUThZeftYF0Ozoczp4FVG8tLNtV/YMT
        Bqg9EEoTqy+uMRl2ty6juSqj/aPqCp1O4+a6Z/IQEtXEZSV4NVFyWJ6/iKIzsNqBTepmTX
        tKgwEPZNOQT93/lcpnhqlo9RB4PAF/zHCxNfUL/DyuEjT4VZ/YNtnuH8bYU7x2sbJvwrdk
        ivW1kjgtaLARmWOqCQvYUVBnc4LoSKC9GgeWz/dHUvs//xXHwvszK2SVzmgmz/WE3clweD
        BQuKoVTJDfLKWmQPQO9u1lYQ605nToUCvO+lpGuAqeJk71mmFqxc3H7oapRZlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5qbjVS3usu5X8Jt1k2xVXiOBbGTJB0FJc7fd4HJCtk=;
        b=MQOZDz+OI9O7vT+UtwZzzF0Y9blqkSg31MlVbiyWJkGK+bt0nDHpkQdHzlSp11xx+oPa1S
        xRrzAoR2wfy0v+Aw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 IMC support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-8-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-8-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162337.395.18008351855361370266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     85f2e30f987ecc73fbb5e24eda0f36ba7f337c5c
Gitweb:        https://git.kernel.org/tip/85f2e30f987ecc73fbb5e24eda0f36ba7f337c5c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:39 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server IMC support

The Sapphire Rapids IMC provides the interface to the DRAM and
communicates to the rest of the uncore through the M2M block.

The layout of the control registers for a IMC uncore unit is a little
bit different from the generic one. There is a fixed counter for IMC.
So a specific format and ops are required. Expose the common MMIO ops
which can be reused.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-8-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 10 +++----
 arch/x86/events/intel/uncore_discovery.h |  6 ++++-
 arch/x86/events/intel/uncore_snbep.c     | 35 ++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 25f1c01..cc44311 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -454,7 +454,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
 	return type->box_ctls[box->dieid] + type->mmio_offsets[box->pmu->pmu_idx];
 }
 
-static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 {
 	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
 	struct intel_uncore_type *type = box->pmu->type;
@@ -478,7 +478,7 @@ static void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_INT, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -486,7 +486,7 @@ static void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box)
 	writel(GENERIC_PMON_BOX_CTL_FRZ, box->io_addr);
 }
 
-static void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box)
 {
 	if (!box->io_addr)
 		return;
@@ -505,8 +505,8 @@ static void intel_generic_uncore_mmio_enable_event(struct intel_uncore_box *box,
 	writel(hwc->config, box->io_addr + hwc->config_base);
 }
 
-static void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
-					      struct perf_event *event)
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index e836a68..9723243 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -134,5 +134,11 @@ void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
 
+void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_enable_box(struct intel_uncore_box *box);
+void intel_generic_uncore_mmio_disable_event(struct intel_uncore_box *box,
+					     struct perf_event *event);
+
 struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 913cd7a..3c9d459 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5637,6 +5637,39 @@ static struct intel_uncore_type spr_uncore_pcu = {
 	.name			= "pcu",
 };
 
+static void spr_uncore_mmio_enable_event(struct intel_uncore_box *box,
+					 struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!box->io_addr)
+		return;
+
+	if (uncore_pmc_fixed(hwc->idx))
+		writel(SNBEP_PMON_CTL_EN, box->io_addr + hwc->config_base);
+	else
+		writel(hwc->config, box->io_addr + hwc->config_base);
+}
+
+static struct intel_uncore_ops spr_uncore_mmio_ops = {
+	.init_box		= intel_generic_uncore_mmio_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= spr_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+static struct intel_uncore_type spr_uncore_imc = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "imc",
+	.fixed_ctr_bits		= 48,
+	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
+	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
+	.ops			= &spr_uncore_mmio_ops,
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5646,7 +5679,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_m2pcie,
 	&spr_uncore_pcu,
 	NULL,
-	NULL,
+	&spr_uncore_imc,
 	NULL,
 	NULL,
 	NULL,
