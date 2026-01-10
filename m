Return-Path: <linux-tip-commits+bounces-7850-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2941D0DC89
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 477153093B26
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CD2DCF6C;
	Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DtWPw9F6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGj1mm6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A22C15BB;
	Sat, 10 Jan 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074370; cv=none; b=AfWwbnH8v5DDoIdi+xRF3nPgFSmQLdzvD5JE4wGTQ914/ik+nULcRofhqRhcpH4TV/qlzzjP9chzJEzvb+7XIJ2E9jEpWftq0P/r0AY45B0xn7oHaD081awLkd+e/+RxA7G7k6DnWfmzNmHrENT6KGDiObyHPP44uta9f3UhDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074370; c=relaxed/simple;
	bh=wmpWI662NQRLUh3Wn86LAzodAXbiIRv5ndQpV7INy64=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LvRgth/NMdaDwOs1kUAi5i8Vq02Gh5aWA+avDghPjI9gN5eeKAaUI58TkyeYzTHqHP3t5o1BCv45T5MqO01azMUpr2240uRBmIZLfKVBUH4wshmia9GQEOgZaWIdFi/fuazCN1DDddzCSPgBNQq9IM85ehZ0NIb4QiYcUV4PSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DtWPw9F6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGj1mm6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yGC2PASlUUW7OS0H5eT/A8VFv91x5j/YqM2KNZFLuKM=;
	b=DtWPw9F6qCzhrQ3CqK4s6DUNYTAyqQuk3bP3c8BVn0YDZmG6Uhl0SwqWXkTk6wIjx9MTaR
	GnrUy7Ojc0QtdV6G5CqyOZ2xsqn69EdWzNpx45ftwUpq15ncuK857X7Y1d/45Xl8lNHF1q
	Fo07Ge6A0d8T2U/c4DckBUJCuls/U81bwfRdB4HxTk1Q94+0UZxAejCUe/ReZcEkBPdOe/
	qfWpTCe3HH66YquJpgy2F1uKlKz6yxJSUiX/sXwZp7gAWFdxUg80wmGk680Kl5ojzk8BVb
	DHF9F7JMqUquUMX436zFSkHnoENXQew4R2VtvVoDatGhmFJAMKeAXO4HB7Hv0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yGC2PASlUUW7OS0H5eT/A8VFv91x5j/YqM2KNZFLuKM=;
	b=HGj1mm6NxxoI7Z+15Hdy7V9HhLMynm3MmCiuSXCqLYDcuxMp9xRQD+YFJykS0AGN7NFZ0Q
	ueqfQ1L41HWTTzCw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Discover hardware telemetry events
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436526.510.457466654572021245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     1fb2daa60de640efb13f907d43d72d28763f696c
Gitweb:        https://git.kernel.org/tip/1fb2daa60de640efb13f907d43d72d28763=
f696c
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 08 Jan 2026 09:42:26 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:37:07 +01:00

x86/resctrl: Discover hardware telemetry events

Each CPU collects data for telemetry events that it sends to the nearest
telemetry event aggregator either when the value of MSR_IA32_PQR_ASSOC.RMID
changes, or when a two millisecond timer expires.

There is a feature type ("energy" or "perf"), GUID, and MMIO region associated
with each aggregator. This combination links to an XML description of the
set of telemetry events tracked by the aggregator. XML files are published
by Intel in a GitHub repository=C2=B9.

The telemetry event aggregators maintain per-RMID per-event counts of the
total seen for all the CPUs. There may be multiple telemetry event aggregators
per package.

There are separate sets of aggregators for each feature type. Aggregators
in a set may have different GUIDs. All aggregators with the same feature
type and GUID are symmetric keeping counts for the same set of events for
the CPUs that provide data to them.

The XML file for each aggregator provides the following information:
0) Feature type of the events ("perf" or "energy")
1) Which telemetry events are tracked by the aggregator.
2) The order in which the event counters appear for each RMID.
3) The value type of each event counter (integer or fixed-point).
4) The number of RMIDs supported.
5) Which additional aggregator status registers are included.
6) The total size of the MMIO region for an aggregator.

Introduce struct event_group that condenses the relevant information from
an XML file. Hereafter an "event group" refers to a group of events of a
particular feature type (event_group::pfname set to "energy" or "perf") with
a particular GUID.

Use event_group::pfname to determine the feature id needed to obtain the
aggregator details. It will later be used in console messages and with the
rdt=3D boot parameter.

The INTEL_PMT_TELEMETRY driver enumerates support for telemetry events.
This driver provides intel_pmt_get_regions_by_feature() to list all available
telemetry event aggregators of a given feature type. The list includes the
"guid", the base address in MMIO space for the region where the event counters
are exposed, and the package id where the all the CPUs that report to this
aggregator are located.

Call INTEL_PMT_TELEMETRY's intel_pmt_get_regions_by_feature() for each event
group to obtain a private copy of that event group's aggregator data. Duplica=
te
the aggregator data between event groups that have the same feature type
but different GUID. Further processing on this private copy will be unique
to the event group.

  =C2=B9https://github.com/intel/Intel-PMT

  [ bp: Zap text explaining the code, s/guid/GUID/g ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/Kconfig                        |  13 +++-
 arch/x86/kernel/cpu/resctrl/Makefile    |   1 +-
 arch/x86/kernel/cpu/resctrl/core.c      |   4 +-
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 109 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h  |   8 ++-
 5 files changed, 135 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/resctrl/intel_aet.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8052729..0d874a9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -540,6 +540,19 @@ config X86_CPU_RESCTRL
=20
 	  Say N if unsure.
=20
+config X86_CPU_RESCTRL_INTEL_AET
+	bool "Intel Application Energy Telemetry"
+	depends on X86_CPU_RESCTRL && CPU_SUP_INTEL && INTEL_PMT_TELEMETRY=3Dy && I=
NTEL_TPMI=3Dy
+	help
+	  Enable per-RMID telemetry events in resctrl.
+
+	  Intel feature that collects per-RMID execution data
+	  about energy consumption, measure of frequency independent
+	  activity and other performance metrics. Data is aggregated
+	  per package.
+
+	  Say N if unsure.
+
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
 	depends on X86_64
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resct=
rl/Makefile
index d8a04b1..273ddfa 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_X86_CPU_RESCTRL)		+=3D core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)		+=3D ctrlmondata.o
+obj-$(CONFIG_X86_CPU_RESCTRL_INTEL_AET)	+=3D intel_aet.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+=3D pseudo_lock.o
=20
 # To allow define_trace.h's recursive include:
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index f3d7e22..595f7ea 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -738,6 +738,8 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
=20
 void resctrl_arch_pre_mount(void)
 {
+	if (!intel_aet_get_events())
+		return;
 }
=20
 enum {
@@ -1099,6 +1101,8 @@ late_initcall(resctrl_arch_late_init);
=20
 static void __exit resctrl_arch_exit(void)
 {
+	intel_aet_exit();
+
 	cpuhp_remove_state(rdt_online);
=20
 	resctrl_exit();
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
new file mode 100644
index 0000000..4045647
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Resource Director Technology(RDT)
+ * - Intel Application Energy Telemetry
+ *
+ * Copyright (C) 2025 Intel Corporation
+ *
+ * Author:
+ *    Tony Luck <tony.luck@intel.com>
+ */
+
+#define pr_fmt(fmt)   "resctrl: " fmt
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/intel_pmt_features.h>
+#include <linux/intel_vsec.h>
+#include <linux/resctrl.h>
+#include <linux/stddef.h>
+
+#include "internal.h"
+
+/**
+ * struct event_group - Events with the same feature type ("energy" or "perf=
") and GUID.
+ * @pfname:		PMT feature name ("energy" or "perf") of this event group.
+ * @pfg:		Points to the aggregated telemetry space information
+ *			returned by the intel_pmt_get_regions_by_feature()
+ *			call to the INTEL_PMT_TELEMETRY driver that contains
+ *			data for all telemetry regions of type @pfname.
+ *			Valid if the system supports the event group,
+ *			NULL otherwise.
+ */
+struct event_group {
+	/* Data fields for additional structures to manage this group. */
+	const char			*pfname;
+	struct pmt_feature_group	*pfg;
+};
+
+static struct event_group *known_event_groups[] =3D {
+};
+
+#define for_each_event_group(_peg)						\
+	for (_peg =3D known_event_groups;						\
+	     _peg < &known_event_groups[ARRAY_SIZE(known_event_groups)];	\
+	     _peg++)
+
+/* Stub for now */
+static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	return false;
+}
+
+static enum pmt_feature_id lookup_pfid(const char *pfname)
+{
+	if (!strcmp(pfname, "energy"))
+		return FEATURE_PER_RMID_ENERGY_TELEM;
+	else if (!strcmp(pfname, "perf"))
+		return FEATURE_PER_RMID_PERF_TELEM;
+
+	pr_warn("Unknown PMT feature name '%s'\n", pfname);
+
+	return FEATURE_INVALID;
+}
+
+/*
+ * Request a copy of struct pmt_feature_group for each event group. If there=
 is
+ * one, the returned structure has an array of telemetry_region structures,
+ * each element of the array describes one telemetry aggregator. The
+ * telemetry aggregators may have different GUIDs so obtain duplicate struct
+ * pmt_feature_group for event groups with same feature type but different
+ * GUID. Post-processing ensures an event group can only use the telemetry
+ * aggregators that match its GUID. An event group keeps a pointer to its
+ * struct pmt_feature_group to indicate that its events are successfully
+ * enabled.
+ */
+bool intel_aet_get_events(void)
+{
+	struct pmt_feature_group *p;
+	enum pmt_feature_id pfid;
+	struct event_group **peg;
+	bool ret =3D false;
+
+	for_each_event_group(peg) {
+		pfid =3D lookup_pfid((*peg)->pfname);
+		p =3D intel_pmt_get_regions_by_feature(pfid);
+		if (IS_ERR_OR_NULL(p))
+			continue;
+		if (enable_events(*peg, p)) {
+			(*peg)->pfg =3D p;
+			ret =3D true;
+		} else {
+			intel_pmt_put_feature_group(p);
+		}
+	}
+
+	return ret;
+}
+
+void __exit intel_aet_exit(void)
+{
+	struct event_group **peg;
+
+	for_each_event_group(peg) {
+		if ((*peg)->pfg) {
+			intel_pmt_put_feature_group((*peg)->pfg);
+			(*peg)->pfg =3D NULL;
+		}
+	}
+}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 11d0699..f2e6e35 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -222,4 +222,12 @@ void __init intel_rdt_mbm_apply_quirk(void);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
=20
+#ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
+bool intel_aet_get_events(void);
+void __exit intel_aet_exit(void);
+#else
+static inline bool intel_aet_get_events(void) { return false; }
+static inline void __exit intel_aet_exit(void) { }
+#endif
+
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */

