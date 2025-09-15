Return-Path: <linux-tip-commits+bounces-6618-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76DB57837
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779073A1FB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD763043CA;
	Mon, 15 Sep 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXPZEwes";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbkJDDje"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F103302774;
	Mon, 15 Sep 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935663; cv=none; b=cxr5ESgqUkwUNyKuE3do6nfSwCAk4sa9ZeWD/nlW/7uc5REc/QWJxXKwtl8RQBSr87JRVNSKcmAagBpQwnf6DyZ7ZMf6p8W/I+bwvbabUPEu2/TDpbeik26PcRkP+wxNUCfe/fUbvqn0GQkkS1r2f1NgI7oxrdWyNGZ1hfwYNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935663; c=relaxed/simple;
	bh=LzoVvEwnPgiXHY4fD8CZje5Gbx5gKYXi/ACzvl203CA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JhhFTyU0wcac4VEtZVkvdymNSizT9Ka6XiWQfraKPZJJyuzmncJiXPa+4zGhNgHuZ2ggRX3HDuJaITz/+gew7Ih7WwwHT03lsn2uwPHs6JO9p2xH3li3WsT6HK2km/kYajd8Sb1BogxngRwIl4wlUnjdSQVmWOGRKruRLPuXNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FXPZEwes; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbkJDDje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qnPE9Gh7NdrNViz/h0FORCYI8Fi0wHvRzL+uQ63HBs=;
	b=FXPZEwesdm9N0RlwItD6gM3EfWhuxFVO0B7JPERXzvoNFc0RKqCPnwwrDaVpk9GzQ8SScM
	Ify+3vSJuLnnvTN6uhYPIGoS3u/V7TfQZ27UhWkpm5ErlR288ZVj4PVOUL0lgmEEtaQMdn
	irg7TFvYornl6wUcnm7g27zMSgHw/G/zGrM2ufoQAaXT6Z9zWcGeTH8r3WWyRcTCed/01e
	3v34j8lr+ZahrFkWYBCbtU0evSQWLK621T7ifCyrZvnEhYccG82ImNTVpuvG15szZQItg7
	uVhKWT2SkNpTjllrwrtrQ8Bc+A+eE1FF3Ccj/L6QDpdGzGlVHG//2HW22l89Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qnPE9Gh7NdrNViz/h0FORCYI8Fi0wHvRzL+uQ63HBs=;
	b=JbkJDDje14tpKoxCter8rPgD8/ywIIMILzKhq8CebWjLI8P5MW5NZ5NzV4EmV97TFLEpT2
	QNg/VfiYYNH4CyCw==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] fs/resctrl: Add the functionality to assign MBM events
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <25421710af9c3110ee6dfc1fa25b8f59de99454d.1757108044.git.babu.moger@amd.com>
References:
 <25421710af9c3110ee6dfc1fa25b8f59de99454d.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565796.709179.1761353517263868070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     bd85310efd71b9e7809e1b95fe7a60fde42e62db
Gitweb:        https://git.kernel.org/tip/bd85310efd71b9e7809e1b95fe7a60fde42=
e62db
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:16 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:21:24 +02:00

fs/resctrl: Add the functionality to assign MBM events

When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
number of counters that can be assigned to RMID, event pairs and monitor
bandwidth usage as long as it is assigned.

Add the functionality to allocate and assign a counter to an RMID, event
pair in the domain. Also, add the helper rdtgroup_assign_cntrs() to assign
counters in the group.

Log the error message "Failed to allocate counter for <event> in domain
<id>" in /sys/fs/resctrl/info/last_cmd_status if all the counters are in
use. Exit on the first failure when assigning counters across all the
domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/internal.h |   2 +-
 fs/resctrl/monitor.c  | 156 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 1cddfff..762705d 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -396,6 +396,8 @@ int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *o=
f, struct seq_file *s,=20
 int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq=
_file *s,
 				     void *v);
=20
+void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f714e7b..106e9bd 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -356,6 +356,55 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_do=
main *d, u32 closid,
 	return state ? &state[idx] : NULL;
 }
=20
+/*
+ * mbm_cntr_get() - Return the counter ID for the matching @evtid and @rdtgr=
p.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOENT on failure.
+ */
+static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	if (!r->mon.mbm_cntr_assignable)
+		return -ENOENT;
+
+	if (!resctrl_is_mbm_event(evtid))
+		return -ENOENT;
+
+	for (cntr_id =3D 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp =3D=3D rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid =3D=3D evtid)
+			return cntr_id;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * mbm_cntr_alloc() - Initialize and return a new counter ID in the domain @=
d.
+ * Caller must ensure that the specified event is not assigned already.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOSPC on failure.
+ */
+static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
+			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id =3D 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (!d->cntr_cfg[cntr_id].rdtgrp) {
+			d->cntr_cfg[cntr_id].rdtgrp =3D rdtgrp;
+			d->cntr_cfg[cntr_id].evtid =3D evtid;
+			return cntr_id;
+		}
+	}
+
+	return -ENOSPC;
+}
+
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu =3D smp_processor_id();
@@ -887,6 +936,113 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
=20
+/*
+ * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RM=
ID
+ * pair in the domain.
+ *
+ * Assign the counter if @assign is true else unassign the counter. Reset the
+ * associated non-architectural state.
+ */
+static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
+				 enum resctrl_event_id evtid, u32 rmid, u32 closid,
+				 u32 cntr_id, bool assign)
+{
+	struct mbm_state *m;
+
+	resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
+
+	m =3D get_mbm_state(d, closid, rmid, evtid);
+	if (m)
+		memset(m, 0, sizeof(*m));
+}
+
+/*
+ * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the=
 event
+ * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon=
_domain *d,
+				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	/* No action required if the counter is assigned already. */
+	cntr_id =3D mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id >=3D 0)
+		return 0;
+
+	cntr_id =3D mbm_cntr_alloc(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id < 0) {
+		rdt_last_cmd_printf("Failed to allocate counter for %s in domain %d\n",
+				    mevt->name, d->hdr.id);
+		return cntr_id;
+	}
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, c=
ntr_id, true);
+
+	return 0;
+}
+
+/*
+ * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
+ * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d =
is
+ * NULL; otherwise, assign the counter to the specified domain @d.
+ *
+ * If all counters in a domain are already in use, rdtgroup_alloc_assign_cnt=
r()
+ * will fail. The assignment process will abort at the first failure encount=
ered
+ * during domain traversal, which may result in the event being only partial=
ly
+ * assigned.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgr=
oup *rdtgrp,
+				      struct mon_evt *mevt)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(mevt->rid);
+	int ret =3D 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret =3D rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret =3D rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+	}
+
+	return ret;
+}
+
+/*
+ * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
+ *			     a new group is created.
+ *
+ * Each group can accommodate two counters per domain: one for the total
+ * event and one for the local event. Assignments may fail due to the limited
+ * number of counters. However, it is not necessary to fail the group creati=
on
+ * and thus no failure is returned. Users have the option to modify the
+ * counter assignments after the group has been created.
+ */
+void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {

