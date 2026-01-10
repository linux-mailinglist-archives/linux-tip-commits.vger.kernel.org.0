Return-Path: <linux-tip-commits+bounces-7847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86707D0DC67
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CF4307154B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137292D4805;
	Sat, 10 Jan 2026 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W2mHHtxL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VNjCgd0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3F2773FC;
	Sat, 10 Jan 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074369; cv=none; b=jGD7SGBQgHjOtvlLe/YXEmsxjz5VHlBiCm4qzqc9HhW2v0EAS+cE+LepJomZA7W9SWIalMjFjmRHyF7XOkt8LIiolnT92YXOUfXG1MCUfVgXOh5J/KFjotJDbsqVIvvmsmdPhR+deQt9t87cZPr7O21so2FsHZwXi7n7VwNUDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074369; c=relaxed/simple;
	bh=nCzGDeuQFP+lGrsMQwq0Or/n7Z90y8TqjqUQb/5k57k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bWCqOXrKannIQpDiS4AtOvOIxW7C0gRXF/v62pxXB1dioh9IsbMj9KUb5bFYfOW0jXqjm4Yuhnl0EV0C0aMB7AesMyMMQB9Ryqi+jOYCUGqrS4gteF9SGtVLJUuob2fwhXwpjKjOQuJZNgCin1c080dU3vLKkzK5Ia1QXL8RPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W2mHHtxL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VNjCgd0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XXzrRSjVSnxtHSxYDly80NMVzkFygLSRw0JXBhdaquE=;
	b=W2mHHtxLPgU+gRtBfCMfaQn7k+H9mG5ic9ehO+Cx5Mr4pMGkxupfP9MVtl44F1Ps8dK6xg
	9Zba3sA65olmzPOnot5GAF4Uuocjtpe1H7JfHnufV6G9RVOhlKuzMvGfvbNKBtTEBX02/6
	QuDYJ+D0xzcr06QEAxDpS4i1lzOvU+oCf/MVojNhZTKEZH86L5hIsl3KM7WOQN4fqu+2ru
	eqZCARThQAJVxYBziOj+/ul97LVDowBwUx+JbsaN10x6yg6PunLiCczANk7Bw1TntqFvyS
	YS+w7Iad95q37l4TjKOg6NJ32DkxJ/WZOm1DU+ISIeuHdvB9SvQ0XnhKtqa6ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XXzrRSjVSnxtHSxYDly80NMVzkFygLSRw0JXBhdaquE=;
	b=4VNjCgd0/2Cg1/Ei4pjx42ZJwKt7+Y/2q1J9ZfdzwogF8sWztseouKGoAxK9srAaWeiDlV
	E7LgCWdSN+i/EHDA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Fill in details of events for
 performance and energy GUIDs
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436401.510.14413609881190165755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8f6b6ad69b50bf16bb762ffafbfa44a4884f9a17
Gitweb:        https://git.kernel.org/tip/8f6b6ad69b50bf16bb762ffafbfa44a4884=
f9a17
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:04 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:37:07 +01:00

x86,fs/resctrl: Fill in details of events for performance and energy GUIDs

The telemetry event aggregators of the Intel Clearwater Forest CPU support two
RMID-based feature types: "energy" with GUID 0x26696143=C2=B9, and "perf" with
GUID 0x26557651=C2=B2.

The event counter offsets in an aggregator's MMIO space are arranged in groups
for each RMID.

E.g., the "energy" counters for GUID 0x26696143 are arranged like this:

  MMIO offset:0x0000 Counter for RMID 0 PMT_EVENT_ENERGY
  MMIO offset:0x0008 Counter for RMID 0 PMT_EVENT_ACTIVITY
  MMIO offset:0x0010 Counter for RMID 1 PMT_EVENT_ENERGY
  MMIO offset:0x0018 Counter for RMID 1 PMT_EVENT_ACTIVITY
  ...
  MMIO offset:0x23F0 Counter for RMID 575 PMT_EVENT_ENERGY
  MMIO offset:0x23F8 Counter for RMID 575 PMT_EVENT_ACTIVITY

After all counters there are three status registers that provide indications
of how many times an aggregator was unable to process event counts, the time
stamp for the most recent loss of data, and the time stamp of the most recent
successful update.

  MMIO offset:0x2400 AGG_DATA_LOSS_COUNT
  MMIO offset:0x2408 AGG_DATA_LOSS_TIMESTAMP
  MMIO offset:0x2410 LAST_UPDATE_TIMESTAMP

Define event_group structures for both of these aggregator types and define
the events tracked by the aggregators in the file system code.

PMT_EVENT_ENERGY and PMT_EVENT_ACTIVITY are produced in fixed point format.
File system code must output as floating point values.

  =C2=B9https://github.com/intel/Intel-PMT/blob/main/xml/CWF/OOBMSM/RMID-ENER=
GY/cwf_aggregator.xml
  =C2=B2https://github.com/intel/Intel-PMT/blob/main/xml/CWF/OOBMSM/RMID-PERF=
/cwf_aggregator.xml

  [ bp: Massage commit message. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 66 ++++++++++++++++++++++++-
 fs/resctrl/monitor.c                    | 35 +++++++------
 include/linux/resctrl_types.h           | 11 ++++-
 3 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index 4045647..8e042b5 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -11,16 +11,34 @@
=20
 #define pr_fmt(fmt)   "resctrl: " fmt
=20
+#include <linux/compiler_types.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/resctrl.h>
+#include <linux/resctrl_types.h>
 #include <linux/stddef.h>
+#include <linux/types.h>
=20
 #include "internal.h"
=20
 /**
+ * struct pmt_event - Telemetry event.
+ * @id:		Resctrl event id.
+ * @idx:	Counter index within each per-RMID block of counters.
+ * @bin_bits:	Zero for integer valued events, else number bits in fraction
+ *		part of fixed-point.
+ */
+struct pmt_event {
+	enum resctrl_event_id	id;
+	unsigned int		idx;
+	unsigned int		bin_bits;
+};
+
+#define EVT(_id, _idx, _bits) { .id =3D _id, .idx =3D _idx, .bin_bits =3D _b=
its }
+
+/**
  * struct event_group - Events with the same feature type ("energy" or "perf=
") and GUID.
  * @pfname:		PMT feature name ("energy" or "perf") of this event group.
  * @pfg:		Points to the aggregated telemetry space information
@@ -29,14 +47,62 @@
  *			data for all telemetry regions of type @pfname.
  *			Valid if the system supports the event group,
  *			NULL otherwise.
+ * @guid:		Unique number per XML description file.
+ * @mmio_size:		Number of bytes of MMIO registers for this group.
+ * @num_events:		Number of events in this group.
+ * @evts:		Array of event descriptors.
  */
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
 	const char			*pfname;
 	struct pmt_feature_group	*pfg;
+
+	/* Remaining fields initialized from XML file. */
+	u32				guid;
+	size_t				mmio_size;
+	unsigned int			num_events;
+	struct pmt_event		evts[] __counted_by(num_events);
+};
+
+#define XML_MMIO_SIZE(num_rmids, num_events, num_extra_status) \
+		      (((num_rmids) * (num_events) + (num_extra_status)) * sizeof(u64))
+
+/*
+ * Link: https://github.com/intel/Intel-PMT/blob/main/xml/CWF/OOBMSM/RMID-EN=
ERGY/cwf_aggregator.xml
+ */
+static struct event_group energy_0x26696143 =3D {
+	.pfname		=3D "energy",
+	.guid		=3D 0x26696143,
+	.mmio_size	=3D XML_MMIO_SIZE(576, 2, 3),
+	.num_events	=3D 2,
+	.evts		=3D {
+		EVT(PMT_EVENT_ENERGY, 0, 18),
+		EVT(PMT_EVENT_ACTIVITY, 1, 18),
+	}
+};
+
+/*
+ * Link: https://github.com/intel/Intel-PMT/blob/main/xml/CWF/OOBMSM/RMID-PE=
RF/cwf_aggregator.xml
+ */
+static struct event_group perf_0x26557651 =3D {
+	.pfname		=3D "perf",
+	.guid		=3D 0x26557651,
+	.mmio_size	=3D XML_MMIO_SIZE(576, 7, 3),
+	.num_events	=3D 7,
+	.evts		=3D {
+		EVT(PMT_EVENT_STALLS_LLC_HIT, 0, 0),
+		EVT(PMT_EVENT_C1_RES, 1, 0),
+		EVT(PMT_EVENT_UNHALTED_CORE_CYCLES, 2, 0),
+		EVT(PMT_EVENT_STALLS_LLC_MISS, 3, 0),
+		EVT(PMT_EVENT_AUTO_C6_RES, 4, 0),
+		EVT(PMT_EVENT_UNHALTED_REF_CYCLES, 5, 0),
+		EVT(PMT_EVENT_UOPS_RETIRED, 6, 0),
+	}
 };
=20
 static struct event_group *known_event_groups[] =3D {
+	&energy_0x26696143,
+	&perf_0x26557651,
 };
=20
 #define for_each_event_group(_peg)						\
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 844cf68..9729aca 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -965,27 +965,32 @@ out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
+#define MON_EVENT(_eventid, _name, _res, _fp)	\
+	[_eventid] =3D {				\
+	.name			=3D _name,	\
+	.evtid			=3D _eventid,	\
+	.rid			=3D _res,		\
+	.is_floating_point	=3D _fp,		\
+}
+
 /*
  * All available events. Architecture code marks the ones that
  * are supported by a system using resctrl_enable_mon_event()
  * to set .enabled.
  */
 struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
-	[QOS_L3_OCCUP_EVENT_ID] =3D {
-		.name	=3D "llc_occupancy",
-		.evtid	=3D QOS_L3_OCCUP_EVENT_ID,
-		.rid	=3D RDT_RESOURCE_L3,
-	},
-	[QOS_L3_MBM_TOTAL_EVENT_ID] =3D {
-		.name	=3D "mbm_total_bytes",
-		.evtid	=3D QOS_L3_MBM_TOTAL_EVENT_ID,
-		.rid	=3D RDT_RESOURCE_L3,
-	},
-	[QOS_L3_MBM_LOCAL_EVENT_ID] =3D {
-		.name	=3D "mbm_local_bytes",
-		.evtid	=3D QOS_L3_MBM_LOCAL_EVENT_ID,
-		.rid	=3D RDT_RESOURCE_L3,
-	},
+	MON_EVENT(QOS_L3_OCCUP_EVENT_ID,		"llc_occupancy",	RDT_RESOURCE_L3,	false),
+	MON_EVENT(QOS_L3_MBM_TOTAL_EVENT_ID,		"mbm_total_bytes",	RDT_RESOURCE_L3,	f=
alse),
+	MON_EVENT(QOS_L3_MBM_LOCAL_EVENT_ID,		"mbm_local_bytes",	RDT_RESOURCE_L3,	f=
alse),
+	MON_EVENT(PMT_EVENT_ENERGY,			"core_energy",		RDT_RESOURCE_PERF_PKG,	true),
+	MON_EVENT(PMT_EVENT_ACTIVITY,			"activity",		RDT_RESOURCE_PERF_PKG,	true),
+	MON_EVENT(PMT_EVENT_STALLS_LLC_HIT,		"stalls_llc_hit",	RDT_RESOURCE_PERF_PK=
G,	false),
+	MON_EVENT(PMT_EVENT_C1_RES,			"c1_res",		RDT_RESOURCE_PERF_PKG,	false),
+	MON_EVENT(PMT_EVENT_UNHALTED_CORE_CYCLES,	"unhalted_core_cycles",	RDT_RESOU=
RCE_PERF_PKG,	false),
+	MON_EVENT(PMT_EVENT_STALLS_LLC_MISS,		"stalls_llc_miss",	RDT_RESOURCE_PERF_=
PKG,	false),
+	MON_EVENT(PMT_EVENT_AUTO_C6_RES,		"c6_res",		RDT_RESOURCE_PERF_PKG,	false),
+	MON_EVENT(PMT_EVENT_UNHALTED_REF_CYCLES,	"unhalted_ref_cycles",	RDT_RESOURC=
E_PERF_PKG,	false),
+	MON_EVENT(PMT_EVENT_UOPS_RETIRED,		"uops_retired",		RDT_RESOURCE_PERF_PKG,	=
false),
 };
=20
 void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu, u=
nsigned int binary_bits)
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index acfe078..a5f56fa 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -50,6 +50,17 @@ enum resctrl_event_id {
 	QOS_L3_MBM_TOTAL_EVENT_ID	=3D 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	=3D 0x03,
=20
+	/* Intel Telemetry Events */
+	PMT_EVENT_ENERGY,
+	PMT_EVENT_ACTIVITY,
+	PMT_EVENT_STALLS_LLC_HIT,
+	PMT_EVENT_C1_RES,
+	PMT_EVENT_UNHALTED_CORE_CYCLES,
+	PMT_EVENT_STALLS_LLC_MISS,
+	PMT_EVENT_AUTO_C6_RES,
+	PMT_EVENT_UNHALTED_REF_CYCLES,
+	PMT_EVENT_UOPS_RETIRED,
+
 	/* Must be the last */
 	QOS_NUM_EVENTS,
 };

