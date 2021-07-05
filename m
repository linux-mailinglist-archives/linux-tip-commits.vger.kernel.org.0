Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822823BB84A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGEH4R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhGEH4Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:16 -0400
Date:   Mon, 05 Jul 2021 07:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwMeEEnzXsEqs0rAkyY0mbn04roTsGGHQ2Vu84oLsSQ=;
        b=xHBnP22Du1EQ32NYxNAMyvx2VmrdO528XnSMuaiDt9VJasACh6VbyoxW7Y2FVFBAy+PYY/
        pp6mh7xqTPbx9XDAmD1Q8eTg4CqXrU64gEpubv1bzPTwh1v/7tj2MyC35mRjhmKNUN2H0e
        D2uIOb9ugr+Ur2ITuIOQxEqbKX8KIIyeTQwrecw/pwspszyjXRKntAPNqu2y6xXjRUyabT
        qszgGvk8uCMw2hj6B9b6kDDLAExyAabMVtaC6Vq6XThr/ylRtv11NPTo7PUHwFWLJUkyjP
        fQU5mgZZ7n683rZWYIJGARH2ROXxEoBVn1PsvCcH/AuOH6z/GS5bclTwZDqFyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwMeEEnzXsEqs0rAkyY0mbn04roTsGGHQ2Vu84oLsSQ=;
        b=1ADKbqeqHSQ5aAu7fkeQS7zyLJaca7nxP0z/Uk/Oa0w4UFaEq/HV/+4ydGiX97n/Rdni/g
        BRxuGhq2u2chwrBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support IIO free-running
 counters on Sapphire Rapids server
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-15-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-15-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547161864.395.15535431438570481380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0378c93a92e226d99f4672e66fe4c08ee7b19e2d
Gitweb:        https://git.kernel.org/tip/0378c93a92e226d99f4672e66fe4c08ee7b19e2d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:41 +02:00

perf/x86/intel/uncore: Support IIO free-running counters on Sapphire Rapids server

Several free-running counters for IIO uncore blocks are supported on
Sapphire Rapids server.

They are not enumerated in the discovery tables. Extend
generic_init_uncores() to support extra uncore types. The uncore types
for the free-running counters is inserted right after the uncore types
retrieved from the discovery table.

The number of the free-running counter boxes is calculated from the max
number of the corresponding standard boxes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-15-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c |  10 +-
 arch/x86/events/intel/uncore_discovery.h |   2 +-
 arch/x86/events/intel/uncore_snbep.c     | 135 +++++++++++++++++++++-
 3 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 6322df1..3049c64 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -569,7 +569,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 }
 
 struct intel_uncore_type **
-intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra)
 {
 	struct intel_uncore_discovery_type *type;
 	struct intel_uncore_type **uncores;
@@ -577,7 +577,7 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 	struct rb_node *node;
 	int i = 0;
 
-	uncores = kcalloc(num_discovered_types[type_id] + 1,
+	uncores = kcalloc(num_discovered_types[type_id] + num_extra + 1,
 			  sizeof(struct intel_uncore_type *), GFP_KERNEL);
 	if (!uncores)
 		return empty_uncore;
@@ -606,17 +606,17 @@ intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 
 void intel_uncore_generic_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR);
+	uncore_msr_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MSR, 0);
 }
 
 int intel_uncore_generic_uncore_pci_init(void)
 {
-	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI);
+	uncore_pci_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_PCI, 0);
 
 	return 0;
 }
 
 void intel_uncore_generic_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO);
+	uncore_mmio_uncores = intel_uncore_generic_init_uncores(UNCORE_ACCESS_MMIO, 0);
 }
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index b85655b..7280c8a 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -149,4 +149,4 @@ u64 intel_generic_uncore_pci_read_counter(struct intel_uncore_box *box,
 					  struct perf_event *event);
 
 struct intel_uncore_type **
-intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id, int num_extra);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9618662..9882549 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5752,6 +5752,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_IIO				1
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
@@ -5768,6 +5769,92 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_mdf,
 };
 
+enum perf_uncore_spr_iio_freerunning_type_id {
+	SPR_IIO_MSR_IOCLK,
+	SPR_IIO_MSR_BW_IN,
+	SPR_IIO_MSR_BW_OUT,
+
+	SPR_IIO_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters spr_iio_freerunning[] = {
+	[SPR_IIO_MSR_IOCLK]	= { 0x340e, 0x1, 0x10, 1, 48 },
+	[SPR_IIO_MSR_BW_IN]	= { 0x3800, 0x1, 0x10, 8, 48 },
+	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
+};
+
+static struct uncore_event_desc spr_uncore_iio_freerunning_events[] = {
+	/* Free-Running IIO CLOCKS Counter */
+	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
+	/* Free-Running IIO BANDWIDTH IN Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
+	/* Free-Running IIO BANDWIDTH OUT Counters */
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x30"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x31"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x32"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x33"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4,		"event=0xff,umask=0x34"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port4.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5,		"event=0xff,umask=0x35"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port5.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6,		"event=0xff,umask=0x36"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port6.unit,	"MiB"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7,		"event=0xff,umask=0x37"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_out_port7.unit,	"MiB"),
+	{ /* end: all zeroes */ },
+};
+
+static struct intel_uncore_type spr_uncore_iio_free_running = {
+	.name			= "iio_free_running",
+	.num_counters		= 17,
+	.num_freerunning_types	= SPR_IIO_FREERUNNING_TYPE_MAX,
+	.freerunning		= spr_iio_freerunning,
+	.ops			= &skx_uncore_iio_freerunning_ops,
+	.event_descs		= spr_uncore_iio_freerunning_events,
+	.format_group		= &skx_uncore_iio_freerunning_format_group,
+};
+
+#define UNCORE_SPR_MSR_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *spr_msr_uncores[UNCORE_SPR_MSR_EXTRA_UNCORES] = {
+	&spr_uncore_iio_free_running,
+};
+
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 					struct intel_uncore_type *from_type)
 {
@@ -5803,11 +5890,13 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 }
 
 static struct intel_uncore_type **
-uncore_get_uncores(enum uncore_access_type type_id)
+uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
+		    struct intel_uncore_type **extra)
 {
 	struct intel_uncore_type **types, **start_types;
+	int i;
 
-	start_types = types = intel_uncore_generic_init_uncores(type_id);
+	start_types = types = intel_uncore_generic_init_uncores(type_id, num_extra);
 
 	/* Only copy the customized features */
 	for (; *types; types++) {
@@ -5816,23 +5905,59 @@ uncore_get_uncores(enum uncore_access_type type_id)
 		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
 	}
 
+	for (i = 0; i < num_extra; i++, types++)
+		*types = extra[i];
+
 	return start_types;
 }
 
+static struct intel_uncore_type *
+uncore_find_type_by_id(struct intel_uncore_type **types, int type_id)
+{
+	for (; *types; types++) {
+		if (type_id == (*types)->type_id)
+			return *types;
+	}
+
+	return NULL;
+}
+
+static int uncore_type_max_boxes(struct intel_uncore_type **types,
+				 int type_id)
+{
+	struct intel_uncore_type *type;
+	int i, max = 0;
+
+	type = uncore_find_type_by_id(types, type_id);
+	if (!type)
+		return 0;
+
+	for (i = 0; i < type->num_boxes; i++) {
+		if (type->box_ids[i] > max)
+			max = type->box_ids[i];
+	}
+
+	return max + 1;
+}
+
 void spr_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR);
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
+						UNCORE_SPR_MSR_EXTRA_UNCORES,
+						spr_msr_uncores);
+
+	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 
 int spr_uncore_pci_init(void)
 {
-	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI);
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL);
 	return 0;
 }
 
 void spr_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO);
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
 }
 
 /* end of SPR uncore support */
