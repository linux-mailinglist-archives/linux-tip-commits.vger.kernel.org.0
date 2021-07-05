Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5563BB860
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhGEH4a (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhGEH40 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD2C0613E4;
        Mon,  5 Jul 2021 00:53:49 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZFEry0FNIj9h3eRqM2bm8nsskfhGJkRSkTtzl4ODXI=;
        b=pKAAxHFrYB8BwhuLFdbXeBZep3rkYt64XG+LgZvy9goIGK4GLodPTP2v29VGkeyjc0Y2oP
        2mGRyhlvK4BWpe65WnZnxZ6YuMmocLzDqZXvEDghz4tyjaUWybi/tJ4lIprcIVp+5mRmLw
        NkPaP4oLQzQBt0KYI53vXmKRIpd8+dS5d3D8TZMeyIupFfjWaTcNMklxrM3+G3uHdhzQGv
        SxLN6534sB2lbnCDfJAxsvAcaOv2F+apSPoLwY+I+GHGdTL0qEcqIoHQVxghymIqH9F+hG
        DUS2qDg3bCjYQmA/5Hr041TWTeMjnzIAv1nEENfVsSTJul7VgznvFvwvKHe8og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZFEry0FNIj9h3eRqM2bm8nsskfhGJkRSkTtzl4ODXI=;
        b=c+nKQXZVlLxkblvqGbSW5rinLZw4YSLxwJbu1nOY1wySDRcN+hm5+MI64Rjzg+1T8ot4kI
        zKOZcHknV5qU4uBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server framework
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-2-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162722.395.795111830712921025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c54c53d9921adef2c239cb43d5a936b63c57ebf0
Gitweb:        https://git.kernel.org/tip/c54c53d9921adef2c239cb43d5a936b63c57ebf0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:36 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server framework

Intel Sapphire Rapids supports a discovery mechanism, that allows an
uncore driver to discover the different components ("boxes") of the
chip.

All the generic information of the uncore boxes should be retrieved from
the discovery tables. This has been enabled with the commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
use_discovery to indicate the case. The uncore driver doesn't need to
hard code the generic information for each uncore box.
But we still need to enable various functionality that cannot be
directly discovered.

To support these functionalities, the Sapphire Rapids server framework
is introduced here. Each specific uncore unit will be added into the
framework in the following patches.

Add use_discovery to indicate that the discovery mechanism is required
for the platform. Currently, Intel Sapphire Rapids is one of the
platforms.

The box ID from the discovery table is the accurate index. Use it if
applicable.

All the undiscovered platform-specific features will be hard code in the
spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
to only overwrite these features.

The specific uncore unit hasn't been added here. From user's
perspective, there is nothing changed for now.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           | 26 +++++--
 arch/x86/events/intel/uncore.h           |  3 +-
 arch/x86/events/intel/uncore_discovery.c |  2 +-
 arch/x86/events/intel/uncore_discovery.h |  3 +-
 arch/x86/events/intel/uncore_snbep.c     | 87 +++++++++++++++++++++++-
 5 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9bf4dbb..b941cee 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -865,9 +865,13 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 			sprintf(pmu->name, "uncore_%s", type->name);
 		else
 			sprintf(pmu->name, "uncore");
-	} else
-		sprintf(pmu->name, "uncore_%s_%d", type->name, pmu->pmu_idx);
-
+	} else {
+		/*
+		 * Use the box ID from the discovery table if applicable.
+		 */
+		sprintf(pmu->name, "uncore_%s_%d", type->name,
+			type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx);
+	}
 }
 
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
@@ -1663,6 +1667,7 @@ struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
+	bool	use_discovery;
 };
 
 static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
@@ -1765,6 +1770,13 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
 	.mmio_init = snr_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
+	.cpu_init = spr_uncore_cpu_init,
+	.pci_init = spr_uncore_pci_init,
+	.mmio_init = spr_uncore_mmio_init,
+	.use_discovery = true,
+};
+
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
@@ -1809,6 +1821,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
@@ -1832,8 +1845,13 @@ static int __init intel_uncore_init(void)
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
-	} else
+	} else {
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
+		if (uncore_no_discover && uncore_init->use_discovery)
+			return -ENODEV;
+		if (uncore_init->use_discovery && !intel_uncore_has_discovery_tables())
+			return -ENODEV;
+	}
 
 	if (uncore_init->pci_init) {
 		pret = uncore_init->pci_init();
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 187d728..fa0e938 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -608,6 +608,9 @@ void snr_uncore_mmio_init(void);
 int icx_uncore_pci_init(void);
 void icx_uncore_cpu_init(void);
 void icx_uncore_mmio_init(void);
+int spr_uncore_pci_init(void);
+void spr_uncore_cpu_init(void);
+void spr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index aba9bff..93148e2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -568,7 +568,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 	return true;
 }
 
-static struct intel_uncore_type **
+struct intel_uncore_type **
 intel_uncore_generic_init_uncores(enum uncore_access_type type_id)
 {
 	struct intel_uncore_discovery_type *type;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 1d65293..d7ccc8a 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -129,3 +129,6 @@ void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
 void intel_uncore_generic_uncore_mmio_init(void);
+
+struct intel_uncore_type **
+intel_uncore_generic_init_uncores(enum uncore_access_type type_id);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7622762..c100616 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
 #include "uncore.h"
+#include "uncore_discovery.h"
 
 /* SNB-EP pci bus to socket mapping */
 #define SNBEP_CPUNODEID			0x40
@@ -5504,3 +5505,89 @@ void icx_uncore_mmio_init(void)
 }
 
 /* end of ICX uncore support */
+
+/* SPR uncore support */
+
+#define UNCORE_SPR_NUM_UNCORE_TYPES		12
+
+static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
+					struct intel_uncore_type *from_type)
+{
+	if (!to_type || !from_type)
+		return;
+
+	if (from_type->name)
+		to_type->name = from_type->name;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->event_mask)
+		to_type->event_mask = from_type->event_mask;
+	if (from_type->event_mask_ext)
+		to_type->event_mask_ext = from_type->event_mask_ext;
+	if (from_type->fixed_ctr)
+		to_type->fixed_ctr = from_type->fixed_ctr;
+	if (from_type->fixed_ctl)
+		to_type->fixed_ctl = from_type->fixed_ctl;
+	if (from_type->fixed_ctr_bits)
+		to_type->fixed_ctr_bits = from_type->fixed_ctr_bits;
+	if (from_type->num_shared_regs)
+		to_type->num_shared_regs = from_type->num_shared_regs;
+	if (from_type->constraints)
+		to_type->constraints = from_type->constraints;
+	if (from_type->ops)
+		to_type->ops = from_type->ops;
+	if (from_type->event_descs)
+		to_type->event_descs = from_type->event_descs;
+	if (from_type->format_group)
+		to_type->format_group = from_type->format_group;
+}
+
+static struct intel_uncore_type **
+uncore_get_uncores(enum uncore_access_type type_id)
+{
+	struct intel_uncore_type **types, **start_types;
+
+	start_types = types = intel_uncore_generic_init_uncores(type_id);
+
+	/* Only copy the customized features */
+	for (; *types; types++) {
+		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
+			continue;
+		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
+	}
+
+	return start_types;
+}
+
+void spr_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR);
+}
+
+int spr_uncore_pci_init(void)
+{
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI);
+	return 0;
+}
+
+void spr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO);
+}
+
+/* end of SPR uncore support */
