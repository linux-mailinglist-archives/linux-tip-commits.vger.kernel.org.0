Return-Path: <linux-tip-commits+bounces-7846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A926D0DC40
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96FA030146E7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C72D0618;
	Sat, 10 Jan 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4cjCRKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+kr4EzZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAA296BA9;
	Sat, 10 Jan 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074368; cv=none; b=FkyITuYhWDrLUhSE3gtT+JK0sC9n1YQbG5o8b/u/Vx8EI5GVvNhfgoEmz4/WAlKSlsiWs9erLYuqWlILVPBcV+rOCTRvo49lbLLfbl+tDtXxg+d1DXhF76ePD9rAVOCSbQqndShC6rjyx40ay5qyBeYrpz9kRFwpZ/4MJkFxZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074368; c=relaxed/simple;
	bh=47rIe7UxTQ0N+NbAuJyOsbIe9bNu0898ZMb7slG+X7c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jeKV0tJGxZ3qK3wS+be4/yHqgw93320oN9g5hn6182Hfe0f28Y7FH/sWihLqhfNqctV5rvk4Qgoe9TY78nU8e0VQoqdT2In4/1K/RtTKYlP+hQRo9EZXTFYZkg2t1br1MiUYZGSqgOB6Rm9TxmgM2Mj5tcGgsHqMDmleY5D2MTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4cjCRKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+kr4EzZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FRA5clGZrNT1kWl7yeiDAEtm8Pi2sTvTzvX1KG3tcJw=;
	b=Z4cjCRKDos/uPVMrgyYJEC628iKFAh5fBYNvL5Mjfv92RKjZhnZgcVBEEYGPe1xyPtCdtQ
	8ndPYqIDdhJyDM/JWLJdWnclRBDd7+DfH2ongz8LhwY+4ijQ/sf8HwXsvzzuWrjXJS6WVj
	5HDNP+TO0YbHMDyws5lXInd3eLOpCXxpnxKrXFQCznTU0UTqLT+gdJHHFM0LpQwLQghwIH
	X/LVOPnCEIlBgAsLR6sVfjZZ0SnBJ/XGjHYrWGOh/mtge57B14DW9PiUzVuJPpv1RVgiHn
	phwz+JpbsVXlfZyGRf3QIhARAA10n+60a52KR8bwDw/KSkSdX8BdzQVzZ62pxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FRA5clGZrNT1kWl7yeiDAEtm8Pi2sTvTzvX1KG3tcJw=;
	b=q+kr4EzZyTynN0PfpJD6stTqC3agg9uLcXCNMuCvOpXhxR1KqoUgXTjJl+VD/nMjdR8inj
	39GJGB0a7WDyQQBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Handle number of RMIDs supported by
 RDT_RESOURCE_PERF_PKG
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435559.510.4242982649449674896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     67640e333b983298be624a41c43e3a8ed4713a73
Gitweb:        https://git.kernel.org/tip/67640e333b983298be624a41c43e3a8ed47=
13a73
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:12 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 11:20:14 +01:00

x86/resctrl: Handle number of RMIDs supported by RDT_RESOURCE_PERF_PKG

There are now three meanings for "number of RMIDs":

1) The number for legacy features enumerated by CPUID leaf 0xF. This is the
   maximum number of distinct values that can be loaded into MSR_IA32_PQR_ASS=
OC.
   Note that systems with Sub-NUMA Cluster mode enabled will force scaling do=
wn
   the CPUID enumerated value by the number of SNC nodes per L3-cache.

2) The number of registers in MMIO space for each event. This is enumerated in
   the XML files and is the value initialized into event_group::num_rmid.

3) The number of "hardware counters" (this isn't a strictly accurate
   description of how things work, but serves as a useful analogy that does
   describe the limitations) feeding to those MMIO registers. This is enumera=
ted
   in telemetry_region::num_rmids returned by intel_pmt_get_regions_by_featur=
e().

Event groups with insufficient "hardware counters" to track all RMIDs are
difficult for users to use, since the system may reassign "hardware counters"
at any time. This means that users cannot reliably collect two consecutive
event counts to compute the rate at which events are occurring.

Disable such event groups by default. The user may override this with
a command line "rdt=3D" option. In this case limit an under-resourced event
group's number of possible monitor resource groups to the lowest number of
"hardware counters".

Scan all enabled event groups and assign the RDT_RESOURCE_PERF_PKG resource
"num_rmid" value to the smallest of these values as this value will be used
later to compare against the number of RMIDs supported by other resources to
determine how many monitoring resource groups are supported.

N.B. Change type of resctrl_mon::num_rmid to u32 to match its usage and the
type of event_group::num_rmid so that min(r->num_rmid, e->num_rmid) won't
complain about mixing signed and unsigned types.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 53 +++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                   |  2 +-
 include/linux/resctrl.h                 |  2 +-
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index dc25e8d..aba9971 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -22,6 +22,7 @@
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
+#include <linux/minmax.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -60,10 +61,14 @@ struct pmt_event {
  *			Valid if the system supports the event group,
  *			NULL otherwise.
  * @force_off:		True when "rdt" command line or architecture code disables
- *			this event group.
+ *			this event group due to insufficient RMIDs.
  * @force_on:		True when "rdt" command line overrides disable of this
  *			event group.
  * @guid:		Unique number per XML description file.
+ * @num_rmid:		Number of RMIDs supported by this group. May be
+ *			adjusted downwards if enumeration from
+ *			intel_pmt_get_regions_by_feature() indicates fewer
+ *			RMIDs can be tracked simultaneously.
  * @mmio_size:		Number of bytes of MMIO registers for this group.
  * @num_events:		Number of events in this group.
  * @evts:		Array of event descriptors.
@@ -76,6 +81,7 @@ struct event_group {
=20
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
+	u32				num_rmid;
 	size_t				mmio_size;
 	unsigned int			num_events;
 	struct pmt_event		evts[] __counted_by(num_events);
@@ -90,6 +96,7 @@ struct event_group {
 static struct event_group energy_0x26696143 =3D {
 	.pfname		=3D "energy",
 	.guid		=3D 0x26696143,
+	.num_rmid	=3D 576,
 	.mmio_size	=3D XML_MMIO_SIZE(576, 2, 3),
 	.num_events	=3D 2,
 	.evts		=3D {
@@ -104,6 +111,7 @@ static struct event_group energy_0x26696143 =3D {
 static struct event_group perf_0x26557651 =3D {
 	.pfname		=3D "perf",
 	.guid		=3D 0x26557651,
+	.num_rmid	=3D 576,
 	.mmio_size	=3D XML_MMIO_SIZE(576, 7, 3),
 	.num_events	=3D 7,
 	.evts		=3D {
@@ -198,6 +206,23 @@ static bool group_has_usable_regions(struct event_group =
*e, struct pmt_feature_g
 	return usable_regions;
 }
=20
+static bool all_regions_have_sufficient_rmid(struct event_group *e, struct p=
mt_feature_group *p)
+{
+	struct telemetry_region *tr;
+
+	for (int i =3D 0; i < p->count; i++) {
+		if (!p->regions[i].addr)
+			continue;
+		tr =3D &p->regions[i];
+		if (tr->num_rmids < e->num_rmid) {
+			e->force_off =3D true;
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 {
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resc=
trl;
@@ -209,6 +234,27 @@ static bool enable_events(struct event_group *e, struct =
pmt_feature_group *p)
 	if (!group_has_usable_regions(e, p))
 		return false;
=20
+	/*
+	 * Only enable event group with insufficient RMIDs if the user requested
+	 * it from the kernel command line.
+	 */
+	if (!all_regions_have_sufficient_rmid(e, p) && !e->force_on) {
+		pr_info("%s %s:0x%x monitoring not enabled due to insufficient RMIDs\n",
+			r->name, e->pfname, e->guid);
+		return false;
+	}
+
+	for (int i =3D 0; i < p->count; i++) {
+		if (!p->regions[i].addr)
+			continue;
+		/*
+		 * e->num_rmid only adjusted lower if user (via rdt=3D kernel
+		 * parameter) forces an event group with insufficient RMID
+		 * to be enabled.
+		 */
+		e->num_rmid =3D min(e->num_rmid, p->regions[i].num_rmids);
+	}
+
 	for (int j =3D 0; j < e->num_events; j++) {
 		if (!resctrl_enable_mon_event(e->evts[j].id, true,
 					      e->evts[j].bin_bits, &e->evts[j]))
@@ -219,6 +265,11 @@ static bool enable_events(struct event_group *e, struct =
pmt_feature_group *p)
 		return false;
 	}
=20
+	if (r->mon.num_rmid)
+		r->mon.num_rmid =3D min(r->mon.num_rmid, e->num_rmid);
+	else
+		r->mon.num_rmid =3D e->num_rmid;
+
 	return true;
 }
=20
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b9363a9..90c4a19 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1158,7 +1158,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *=
of,
 {
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
=20
-	seq_printf(seq, "%d\n", r->mon.num_rmid);
+	seq_printf(seq, "%u\n", r->mon.num_rmid);
=20
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 451eb45..006e57f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -295,7 +295,7 @@ enum resctrl_schema_fmt {
  *			events of monitor groups created via mkdir.
  */
 struct resctrl_mon {
-	int			num_rmid;
+	u32			num_rmid;
 	unsigned int		mbm_cfg_mask;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;

