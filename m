Return-Path: <linux-tip-commits+bounces-6634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DFB57868
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED42B169315
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD23090DD;
	Mon, 15 Sep 2025 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NdzZCdTm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXOeyeqy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7593081D9;
	Mon, 15 Sep 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935681; cv=none; b=ut+FK8QXQJFRCxSQIU86vqUSuaaFhm8x5Erzo5zNcaDsH8fXRNrnfF5yu5b4U6t/vG74EdhmyHlyzKejwYW2gs/sDZOCErIbMsqlxRD+Hf1a0x75ycq4ZR2uOZv3pU1Sv+02Jr9WWubTNdh0QVAnXn4hgsPj2a2PDeS4sf1t7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935681; c=relaxed/simple;
	bh=wzrdAxu+1/M+j9ewntKRMLCiELF55iWk2yC3xOVxF5Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ofnoa/SeRyZSwUFr9QNst/q/LTb6anb5vygl63z+I+h9T8fvkmwdnxVXZZfKmpeNxwGH6xBYK14n/8YKzTsjotrz9SnTl7m1S9RFat1ggWKpHPP6m7hiyGHDpaOaw8AkrZr1s+iPOzj7EUac/p/roS3+NwA+5yJRcTE14sXqKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NdzZCdTm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXOeyeqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBBtxiMI4A4Ypfsz3Q3l8HHHy1gQ8Z0qMWvWe1LTBOU=;
	b=NdzZCdTmT+45JE92BG1SdClU2S3RmMCX13CfY57l4luVr/p5nMLmqa3x6o7JhKJbPgixsp
	I+Ay+LM+7s1gSce0OJaszr9oPsS+vIZkPYPcn6+jG4poIM81q2UjfNVTVSvMfH9wSks5w9
	GkStVbEKUT/lm2Gf4g6mVZLl8ffz/0XXJVp17Xneb6Zb2vPPGK47e9XrC1TetLsdKAOIK3
	uuKRA6fUfzIau2Zdn9U2L7Yqd8dXOMFbPp11mdDs/OPk6ElLQVn+GLJax4bxgty3KL44ES
	TustK2DTx/KwfQy9xRA1klHvfe0UD8bXpqtu2g1B7dXm7dhLJavrhhi1mWs6mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBBtxiMI4A4Ypfsz3Q3l8HHHy1gQ8Z0qMWvWe1LTBOU=;
	b=iXOeyeqy7JuTlAkQeQAbvVQUNbNHSWylT74NQb0LhA5vLzjzlVhbY0+ESr/SP1/7+CW2LQ
	0MTGYI8st6Z83NAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Consolidate monitor event descriptions
Cc: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Fenghua Yu <fenghuay@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <633fa2733eeeb3017db567fac3466fb64530bc47.1757108044.git.babu.moger@amd.com>
References:
 <633fa2733eeeb3017db567fac3466fb64530bc47.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567597.709179.13967505297275088456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     09f37134464cc03baf5cb8eab2d99db27ee73217
Gitweb:        https://git.kernel.org/tip/09f37134464cc03baf5cb8eab2d99db27ee=
73217
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:00 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 11:46:08 +02:00

x86,fs/resctrl: Consolidate monitor event descriptions

There are currently only three monitor events, all associated with the
RDT_RESOURCE_L3 resource. Growing support for additional events will be easier
with some restructuring to have a single point in file system code where all
attributes of all events are defined.

Place all event descriptions into an array mon_event_all[]. Doing this has the
beneficial side effect of removing the need for rdt_resource::evt_list.

Add resctrl_event_id::QOS_FIRST_EVENT for a lower bound on range checks for
event ids and as the starting index to scan mon_event_all[].

Drop the code that builds evt_list and change the two places where the list is
scanned to scan mon_event_all[] instead using a new helper macro
for_each_mon_event().

Architecture code now informs file system code which events are available with
resctrl_enable_mon_event().

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 12 ++++--
 fs/resctrl/internal.h              | 13 ++++--
 fs/resctrl/monitor.c               | 63 ++++++++++++++---------------
 fs/resctrl/rdtgroup.c              | 11 ++---
 include/linux/resctrl.h            |  4 +-
 include/linux/resctrl_types.h      | 12 ++++--
 6 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 187d527..7fcae25 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -864,12 +864,18 @@ static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
=20
-	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
+	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
 		rdt_mon_features |=3D (1 << QOS_L3_OCCUP_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		rdt_mon_features |=3D (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		rdt_mon_features |=3D (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
=20
 	if (!rdt_mon_features)
 		return false;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9a8cf6f..7a57366 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -52,19 +52,26 @@ static inline struct rdt_fs_context *rdt_fc2context(struc=
t fs_context *fc)
 }
=20
 /**
- * struct mon_evt - Entry in the event list of a resource
+ * struct mon_evt - Properties of a monitor event
  * @evtid:		event id
+ * @rid:		resource id for this event
  * @name:		name of the event
  * @configurable:	true if the event is configurable
- * @list:		entry in &rdt_resource->evt_list
+ * @enabled:		true if the event is enabled
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
+	enum resctrl_res_level	rid;
 	char			*name;
 	bool			configurable;
-	struct list_head	list;
+	bool			enabled;
 };
=20
+extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
+
+#define for_each_mon_event(mevt) for (mevt =3D &mon_event_all[QOS_FIRST_EVEN=
T];	\
+				      mevt < &mon_event_all[QOS_NUM_EVENTS]; mevt++)
+
 /**
  * struct mon_data - Monitoring details for each event file.
  * @list:            Member of the global @mon_data_kn_priv_list list.
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 7326c28..d5bf3e0 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -842,38 +842,39 @@ out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
-static struct mon_evt llc_occupancy_event =3D {
-	.name		=3D "llc_occupancy",
-	.evtid		=3D QOS_L3_OCCUP_EVENT_ID,
-};
-
-static struct mon_evt mbm_total_event =3D {
-	.name		=3D "mbm_total_bytes",
-	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,
-};
-
-static struct mon_evt mbm_local_event =3D {
-	.name		=3D "mbm_local_bytes",
-	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,
-};
-
 /*
- * Initialize the event list for the resource.
- *
- * Note that MBM events are also part of RDT_RESOURCE_L3 resource
- * because as per the SDM the total and local memory bandwidth
- * are enumerated as part of L3 monitoring.
+ * All available events. Architecture code marks the ones that
+ * are supported by a system using resctrl_enable_mon_event()
+ * to set .enabled.
  */
-static void l3_mon_evt_init(struct rdt_resource *r)
+struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
+	[QOS_L3_OCCUP_EVENT_ID] =3D {
+		.name	=3D "llc_occupancy",
+		.evtid	=3D QOS_L3_OCCUP_EVENT_ID,
+		.rid	=3D RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_TOTAL_EVENT_ID] =3D {
+		.name	=3D "mbm_total_bytes",
+		.evtid	=3D QOS_L3_MBM_TOTAL_EVENT_ID,
+		.rid	=3D RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_LOCAL_EVENT_ID] =3D {
+		.name	=3D "mbm_local_bytes",
+		.evtid	=3D QOS_L3_MBM_LOCAL_EVENT_ID,
+		.rid	=3D RDT_RESOURCE_L3,
+	},
+};
+
+void resctrl_enable_mon_event(enum resctrl_event_id eventid)
 {
-	INIT_LIST_HEAD(&r->evt_list);
+	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS))
+		return;
+	if (mon_event_all[eventid].enabled) {
+		pr_warn("Duplicate enable for event %d\n", eventid);
+		return;
+	}
=20
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
+	mon_event_all[eventid].enabled =3D true;
 }
=20
 /**
@@ -900,15 +901,13 @@ int resctrl_mon_resource_init(void)
 	if (ret)
 		return ret;
=20
-	l3_mon_evt_init(r);
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		mbm_total_event.configurable =3D true;
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable =3D true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		mbm_local_event.configurable =3D true;
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].configurable =3D true;
 		resctrl_file_fflags_init("mbm_local_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5f0b7cf..ab943a5 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1152,7 +1152,9 @@ static int rdt_mon_features_show(struct kernfs_open_fil=
e *of,
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
 	struct mon_evt *mevt;
=20
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid !=3D r->rid || !mevt->enabled)
+			continue;
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -3054,10 +3056,9 @@ static int mon_add_all_files(struct kernfs_node *kn, s=
truct rdt_mon_domain *d,
 	struct mon_evt *mevt;
 	int ret, domid;
=20
-	if (WARN_ON(list_empty(&r->evt_list)))
-		return -EPERM;
-
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid !=3D r->rid || !mevt->enabled)
+			continue;
 		domid =3D do_sum ? d->ci_id : d->hdr.id;
 		priv =3D mon_get_kn_priv(r->rid, domid, mevt, do_sum);
 		if (WARN_ON_ONCE(!priv))
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894..2944042 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -269,7 +269,6 @@ enum resctrl_schema_fmt {
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @evt_list:		List of monitoring events
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
  *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -287,7 +286,6 @@ struct rdt_resource {
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	struct list_head	evt_list;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
@@ -372,6 +370,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
+void resctrl_enable_mon_event(enum resctrl_event_id eventid);
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
=20
 /**
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a25fb9c..2dadbc5 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,11 +34,15 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
=20
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
+/* Event IDs */
 enum resctrl_event_id {
+	/* Must match value of first event below */
+	QOS_FIRST_EVENT			=3D 0x01,
+
+	/*
+	 * These values match those used to program IA32_QM_EVTSEL before
+	 * reading IA32_QM_CTR on RDT systems.
+	 */
 	QOS_L3_OCCUP_EVENT_ID		=3D 0x01,
 	QOS_L3_MBM_TOTAL_EVENT_ID	=3D 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	=3D 0x03,

