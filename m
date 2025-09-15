Return-Path: <linux-tip-commits+bounces-6617-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02766B5782C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EFB445FCF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836730277C;
	Mon, 15 Sep 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qcWgXNF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDZZKnt2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D13019B8;
	Mon, 15 Sep 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935661; cv=none; b=G5cn2Xl42pfrwsddx8tlKdyfHyqPQLGp+wuuhrg4EpIC+YJZXwv1wiR+v4nQ6lIvUHoiEXliTWUL16pMdkDiGhFT9W9G53Fyvq0fxlEdZKcqfHhXraZzDksgqlQiT9FSPhSR2EnIDurhyUbq6+A96S2vNk7qxH2CFSknR5C3Kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935661; c=relaxed/simple;
	bh=E6C8LKL1uGyIQ9s+4dYMCWQqw2CbgIWLsklBECGA224=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=afHIj8/ODvNZufYd/rZGYjfCL10S+eYcTKfLZJNrr7yMxlVIRPFjNDdXErPTNpgNIamHYKEC6Th9wZvAhuwYrnxpsIoblDMWvqmVueKvdRi66zRD0e83huDt/BXfkX0uR1GvklP0L9xbVc+32hqZ8fSGoKxW96/zAe8FBZ6v5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qcWgXNF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDZZKnt2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxrejPxY18qw8FAfh9j6rcwIuhxuHytjVFr9sts47P0=;
	b=qcWgXNF2RiCugFo0a+RhLuAYs3JRCnwokORB0W2P9WwrIi75+otRQmncxePCNZKvCaOyjG
	4ucOwpm4zhsqgqssk0KuAh/rgXPklyiJ/CMNOuOfg5IB21PPb+dcMviClp/dAKg2dsBVHZ
	O18WkrMQ40xmDTN4xBZD2ESa5Ru3xNv8CjwOpI0p5Ee0/MMEs2fgG96ESDAeBJcCpvYpT1
	fqC+L1xw4H3JY042Fz1zGhCmEetS66yZ4g73mI7uvWfVaYOqV9T6yuo/1NX9u2A3A2A3hp
	/LgyhsMdNZmOxIcf+XM9cunlBZHNQ3UMQkuc9Ha8KEtzjN4J+6/ODWpiOQyPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxrejPxY18qw8FAfh9j6rcwIuhxuHytjVFr9sts47P0=;
	b=RDZZKnt2z05NQYwUdXv8XuOFyJG4EQSw8/kohIT4U151mmn/QAwFw5rYBlgbsxhFFfrFyt
	/sjFZas3skn+76AA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] fs/resctrl: Add the functionality to unassign MBM events
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <5778d712535bd0b39d965f3e1089ce851f232e7f.1757108044.git.babu.moger@amd.com>
References:
 <5778d712535bd0b39d965f3e1089ce851f232e7f.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565675.709179.10332281384410397406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     aab2c5088cdb26e80d51ffbe72d24ab23fa1533e
Gitweb:        https://git.kernel.org/tip/aab2c5088cdb26e80d51ffbe72d24ab23fa=
1533e
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:17 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:22:24 +02:00

fs/resctrl: Add the functionality to unassign MBM events

The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
counters that can be assigned to RMID, event pairs and monitor bandwidth usage
as long as it is assigned. If all the counters are in use, the kernel logs the
error message "Failed to allocate counter for <event> in domain <id>" in
/sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.

To make space for a new assignment, users must unassign an already assigned
counter and retry the assignment again.

Add the functionality to unassign and free the counters in the domain.  Also,
add the helper rdtgroup_unassign_cntrs() to unassign counters in the group.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/internal.h |  2 +-
 fs/resctrl/monitor.c  | 66 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 762705d..c6b66d4 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -398,6 +398,8 @@ int resctrl_available_mbm_cntrs_show(struct kernfs_open_f=
ile *of, struct seq_fil
=20
 void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
=20
+void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 106e9bd..2ed29ae 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -405,6 +405,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct=
 rdt_mon_domain *d,
 	return -ENOSPC;
 }
=20
+/*
+ * mbm_cntr_free() - Clear the counter ID configuration details in the domai=
n @d.
+ */
+static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
+{
+	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
+}
+
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu =3D smp_processor_id();
@@ -1043,6 +1051,64 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
 }
=20
+/*
+ * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configu=
ration
+ * for the event pointed to by @mevt within the domain @d and resctrl group =
@rdtgrp.
+ */
+static void rdtgroup_free_unassign_cntr(struct rdt_resource *r, struct rdt_m=
on_domain *d,
+					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	cntr_id =3D mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+
+	/* If there is no cntr_id assigned, nothing to do */
+	if (cntr_id < 0)
+		return;
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, c=
ntr_id, false);
+
+	mbm_cntr_free(d, cntr_id);
+}
+
+/*
+ * rdtgroup_unassign_cntr_event() - Unassign a hardware counter associated w=
ith
+ * the event structure @mevt from the domain @d and the group @rdtgrp. Unass=
ign
+ * the counters from all the domains if @d is NULL else unassign from @d.
+ */
+static void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rd=
tgroup *rdtgrp,
+					 struct mon_evt *mevt)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(mevt->rid);
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list)
+			rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	} else {
+		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	}
+}
+
+/*
+ * rdtgroup_unassign_cntrs() - Unassign the counters associated with MBM eve=
nts.
+ *			       Called when a group is deleted.
+ */
+void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {

