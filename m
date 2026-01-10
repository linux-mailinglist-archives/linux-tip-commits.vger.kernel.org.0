Return-Path: <linux-tip-commits+bounces-7852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F9D0DC94
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5048230A88AA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C192E093F;
	Sat, 10 Jan 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BcvjVxeO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTW4jYNt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D471B4F1F;
	Sat, 10 Jan 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074371; cv=none; b=iNKqIrTPxwirF4eyi2RKWc+V79t50aQeFxErUX6XN6mi5DqATkELm0LFTvNgVyZziNy66gTpINc5Zmoxt6J2iHD3xRK9NRXHlvmNS0vlbSYgGYNfRPwGeo/FLVCK4v8DUtsAHVb67R5bvXDALtTuVwDDENUgYNrEGqW7QsS05ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074371; c=relaxed/simple;
	bh=bhgoRyyD4wzmRuWzRCxn6Oci193JlbvtkUS/HNeNp68=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PG7CLzFqoYUxng/HNZIr7EA55Ps51y3G/aaxQFFhs/JMdiymRBYBHDkfwlnuNex5Ca91afcpA5LP6JMQ9HYRAv5kZWQRAxXnm85teJI0FKDrwz+Xa7xaWKZEk9fcBdMkWOvgy8KcQAOJlPkFf+TwzRjCo6HM5P9kpBRSEy6Y/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BcvjVxeO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTW4jYNt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0pfszFbZW7dq6QKdlWSwRAoAf4wEWPUw1J0NzN7Nl4I=;
	b=BcvjVxeOxtoKmKT0B+m0b8AddfPgIUxOLEdEZPo4dLh4eUZal3KJT1yHYOEg3XOLNxkaME
	jQoim6/R+j7q1XZuW899qx6PHkpHbU4bEroETrW4yipjMEX/xzv4UHej1lx+SZirh2UVlI
	Pm0pWOClZikEAEiOVILDT/7UKbmgx0bZQXD9Eng80mo6LXUBqCkDqYm6RNCjEnEKVMBPkz
	dkX/hEUdaB/17veGa/JsJHu2T3YwQXup8xI1XyZSRwnAUGyiGvapSD01ZNKX5NL2WLp00y
	CJs4prvOjpzdPoteTegdc8PxD2b/GgFFqn+QoVXG2Hah6JyM7hiIE6rJl7Jhng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0pfszFbZW7dq6QKdlWSwRAoAf4wEWPUw1J0NzN7Nl4I=;
	b=mTW4jYNtmcaLWCv3H6ScmRh6CzrfzShYt7NLoGTIUSmmYjkUN+LR78DWkNLanp6bsNEdnG
	RBwukLdsHeJ1PrAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Find and enable usable telemetry events
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436195.510.51374234126414285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7e6df9614546ae7eb1f1b2074d7b6039bb01540d
Gitweb:        https://git.kernel.org/tip/7e6df9614546ae7eb1f1b2074d7b6039bb0=
1540d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:06 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:02:45 +01:00

x86/resctrl: Find and enable usable telemetry events

Every event group has a private copy of the data of all telemetry event
aggregators (aka "telemetry regions") tracking its feature type. Included
may be regions that have the same feature type but tracking different GUID
from the event group's.

Traverse the event group's telemetry region data and mark all regions that
are not usable by the event group as unusable by clearing those regions'
MMIO addresses. A region is considered unusable if:
1) GUID does not match the GUID of the event group.
2) Package ID is invalid.
3) The enumerated size of the MMIO region does not match the expected
   value from the XML description file.

Hereafter any telemetry region with an MMIO address is considered valid for
the event group it is associated with.

Enable all the event group's events as long as there is at least one usable
region from where data for its events can be read. Enabling of an event can
fail if the same event has already been enabled as part of another event
group. It should never happen that the same event is described by different
GUID supported by the same system so just WARN (via resctrl_enable_mon_event(=
))
and skip the event.

Note that it is architecturally possible that some telemetry events are only
supported by a subset of the packages in the system. It is not expected that
systems will ever do this. If they do the user will see event files in resctrl
that always return "Unavailable".

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 63 +++++++++++++++++++++++-
 fs/resctrl/monitor.c                    | 10 ++--
 include/linux/resctrl.h                 |  2 +-
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index 8e042b5..7d0bd7b 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -16,9 +16,11 @@
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
+#include <linux/printk.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
 #include <linux/stddef.h>
+#include <linux/topology.h>
 #include <linux/types.h>
=20
 #include "internal.h"
@@ -110,12 +112,69 @@ static struct event_group *known_event_groups[] =3D {
 	     _peg < &known_event_groups[ARRAY_SIZE(known_event_groups)];	\
 	     _peg++)
=20
-/* Stub for now */
-static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+static bool skip_telem_region(struct telemetry_region *tr, struct event_grou=
p *e)
 {
+	if (tr->guid !=3D e->guid)
+		return true;
+	if (tr->plat_info.package_id >=3D topology_max_packages()) {
+		pr_warn("Bad package %u in guid 0x%x\n", tr->plat_info.package_id,
+			tr->guid);
+		return true;
+	}
+	if (tr->size !=3D e->mmio_size) {
+		pr_warn("MMIO space wrong size (%zu bytes) for guid 0x%x. Expected %zu byt=
es.\n",
+			tr->size, e->guid, e->mmio_size);
+		return true;
+	}
+
 	return false;
 }
=20
+static bool group_has_usable_regions(struct event_group *e, struct pmt_featu=
re_group *p)
+{
+	bool usable_regions =3D false;
+
+	for (int i =3D 0; i < p->count; i++) {
+		if (skip_telem_region(&p->regions[i], e)) {
+			/*
+			 * Clear the address field of regions that did not pass the checks in
+			 * skip_telem_region() so they will not be used by intel_aet_read_event().
+			 * This is safe to do because intel_pmt_get_regions_by_feature() allocates
+			 * a new pmt_feature_group structure to return to each caller and only ma=
kes
+			 * use of the pmt_feature_group::kref field when intel_pmt_put_feature_gr=
oup()
+			 * returns the structure.
+			 */
+			p->regions[i].addr =3D NULL;
+
+			continue;
+		}
+		usable_regions =3D true;
+	}
+
+	return usable_regions;
+}
+
+static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resc=
trl;
+	int skipped_events =3D 0;
+
+	if (!group_has_usable_regions(e, p))
+		return false;
+
+	for (int j =3D 0; j < e->num_events; j++) {
+		if (!resctrl_enable_mon_event(e->evts[j].id, true,
+					      e->evts[j].bin_bits, &e->evts[j]))
+			skipped_events++;
+	}
+	if (e->num_events =3D=3D skipped_events) {
+		pr_info("No events enabled in %s %s:0x%x\n", r->name, e->pfname, e->guid);
+		return false;
+	}
+
+	return true;
+}
+
 static enum pmt_feature_id lookup_pfid(const char *pfname)
 {
 	if (!strcmp(pfname, "energy"))
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index af43a33..9af08b6 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -997,25 +997,27 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
 	MON_EVENT(PMT_EVENT_UOPS_RETIRED,		"uops_retired",		RDT_RESOURCE_PERF_PKG,	=
false),
 };
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
+bool resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
 			      unsigned int binary_bits, void *arch_priv)
 {
 	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS ||
 			 binary_bits > MAX_BINARY_BITS))
-		return;
+		return false;
 	if (mon_event_all[eventid].enabled) {
 		pr_warn("Duplicate enable for event %d\n", eventid);
-		return;
+		return false;
 	}
 	if (binary_bits && !mon_event_all[eventid].is_floating_point) {
 		pr_warn("Event %d may not be floating point\n", eventid);
-		return;
+		return false;
 	}
=20
 	mon_event_all[eventid].any_cpu =3D any_cpu;
 	mon_event_all[eventid].binary_bits =3D binary_bits;
 	mon_event_all[eventid].arch_priv =3D arch_priv;
 	mon_event_all[eventid].enabled =3D true;
+
+	return true;
 }
=20
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2c64a43..451eb45 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -414,7 +414,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
+bool resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
 			      unsigned int binary_bits, void *arch_priv);
=20
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);

