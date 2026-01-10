Return-Path: <linux-tip-commits+bounces-7845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097EFD0DC43
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 671E7300FBCB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3DE2C08B1;
	Sat, 10 Jan 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WO2IdGDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GIXoo6/d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA692BF00A;
	Sat, 10 Jan 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074368; cv=none; b=VQhqNbsceBonD0gQ0mvpQundKb2dNU+FHGVtFK7H61Ti5tJ7mHGpPuKyrXb754vuZpU/AbaWUYcQQFFx9uk0sweVQyfHrUfKRuo4mwVeJ03bqnNIdtkpS9u6MCMRnLK/wwqqWuV596QtjlsuColF/40hBpnFM2DKwB/l8leNq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074368; c=relaxed/simple;
	bh=xNL7k1fKG/ZSiue7n20EdPiGW94IVNgWJj2aLH54xA4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=eZtPCFxI39umAs8cwXfO7IWlj6TrSiOfkE/RKIazA4kr0pdyElhE0FFGgyDiPeTjSn7w27gpUEqV6a0mU8JSK17kJp4jetWYFTxwEgbxhi6wPKHMpX2Mci68yyN0lEtD1BThWTp0cbYDTICAVqtYNXdCmbd3RZB2SJQpkG+xh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WO2IdGDl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GIXoo6/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074364;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/DM3CPCyOO+Bct4PmNAvUMyzAuahyg4beeDPle+8hOo=;
	b=WO2IdGDlUY/oLpKW7oaQ/JHhTJH4stBojwIptUyUHy0gGrZQAjIQCAv5ORizLADTK5FBM2
	QHVCZw98/CcQTHzek+C1e1mkIMW4Tj7VLCyd+Q/6t5YnIEn3MJq+/fGnAbQlElYl1TKEg3
	BELfbSPw0s1DG48m9mIr82grXF20Bk1qV9PQvrOAaT+nOhpD5uU8thcrVvf2DMYjC1RbNL
	CV8D6/g7DIuzMjqzFMpIeU8V9dR4ah+Kw9I79Zt51GovCeB+6NlD5aSF6xd5bg3gNfEtOO
	rrzud61l6EqOo8LP8zHB91L+S68XKWVcJx52CwxuXj09BSTHI+0z+vtA5F1j2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074364;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/DM3CPCyOO+Bct4PmNAvUMyzAuahyg4beeDPle+8hOo=;
	b=GIXoo6/d9yjuQK7ZcIei3S1fcJKeaQYiPr6r+yHm98ulHK86m5vc0XGHErA9rTSFBtpA4O
	kIUPPn0rLbN3kJBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Add architectural event pointer
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436299.510.16441167278232810798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8ccb1f8fa6a3dfde32cf33e7ded3558014e6cca2
Gitweb:        https://git.kernel.org/tip/8ccb1f8fa6a3dfde32cf33e7ded3558014e=
6cca2
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:05 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:37:08 +01:00

x86,fs/resctrl: Add architectural event pointer

The resctrl file system layer passes the domain, RMID, and event id to the
architecture to fetch an event counter.

Fetching a telemetry event counter requires additional information that is
private to the architecture, for example, the offset into MMIO space from
where the counter should be read.

Add mon_evt::arch_priv that architecture can use for any private data related
to the event. The resctrl filesystem initializes mon_evt::arch_priv when the
architecture enables the event and passes it back to architecture when needing
to fetch an event counter.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c    |  6 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c |  2 +-
 fs/resctrl/internal.h                 |  4 ++++
 fs/resctrl/monitor.c                  | 14 ++++++++++----
 include/linux/resctrl.h               |  7 +++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 595f7ea..509277b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -918,15 +918,15 @@ static __init bool get_rdt_mon_resources(void)
 	bool ret =3D false;
=20
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
-		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false, 0);
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false, 0, NULL);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false, 0);
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false, 0, NULL);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false, 0);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false, 0, NULL);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_ABMC))
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 2060521..6929614 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -240,7 +240,7 @@ static u64 get_corrected_val(struct rdt_resource *r, stru=
ct rdt_l3_mon_domain *d
=20
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hd=
r,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *ignored)
+			   void *arch_priv, u64 *val, void *ignored)
 {
 	struct rdt_hw_l3_mon_domain *hw_dom;
 	struct rdt_l3_mon_domain *d;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 50d88e9..399f625 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -66,6 +66,9 @@ static inline struct rdt_fs_context *rdt_fc2context(struct =
fs_context *fc)
  * @binary_bits:	number of fixed-point binary bits from architecture,
  *			only valid if @is_floating_point is true
  * @enabled:		true if the event is enabled
+ * @arch_priv:		Architecture private data for this event.
+ *			The @arch_priv provided by the architecture via
+ *			resctrl_enable_mon_event().
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
@@ -77,6 +80,7 @@ struct mon_evt {
 	bool			is_floating_point;
 	unsigned int		binary_bits;
 	bool			enabled;
+	void			*arch_priv;
 };
=20
 extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9729aca..af43a33 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -137,9 +137,11 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool for=
ce_free)
 	struct rmid_entry *entry;
 	u32 idx, cur_idx =3D 1;
 	void *arch_mon_ctx;
+	void *arch_priv;
 	bool rmid_dirty;
 	u64 val =3D 0;
=20
+	arch_priv =3D mon_event_all[QOS_L3_OCCUP_EVENT_ID].arch_priv;
 	arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
 	if (IS_ERR(arch_mon_ctx)) {
 		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
@@ -160,7 +162,7 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool forc=
e_free)
=20
 		entry =3D __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val,
+					   QOS_L3_OCCUP_EVENT_ID, arch_priv, &val,
 					   arch_mon_ctx)) {
 			rmid_dirty =3D true;
 		} else {
@@ -456,7 +458,8 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, =
struct rmid_read *rr)
 						 rr->evt->evtid, &tval);
 	else
 		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->hdr, closid, rmid,
-						 rr->evt->evtid, &tval, rr->arch_mon_ctx);
+						 rr->evt->evtid, rr->evt->arch_priv,
+						 &tval, rr->arch_mon_ctx);
 	if (rr->err)
 		return rr->err;
=20
@@ -501,7 +504,8 @@ static int __l3_mon_event_count_sum(struct rdtgroup *rdtg=
rp, struct rmid_read *r
 		if (d->ci_id !=3D rr->ci->id)
 			continue;
 		err =3D resctrl_arch_rmid_read(rr->r, &d->hdr, closid, rmid,
-					     rr->evt->evtid, &tval, rr->arch_mon_ctx);
+					     rr->evt->evtid, rr->evt->arch_priv,
+					     &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val +=3D tval;
 			ret =3D 0;
@@ -993,7 +997,8 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
 	MON_EVENT(PMT_EVENT_UOPS_RETIRED,		"uops_retired",		RDT_RESOURCE_PERF_PKG,	=
false),
 };
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu, u=
nsigned int binary_bits)
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
+			      unsigned int binary_bits, void *arch_priv)
 {
 	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS ||
 			 binary_bits > MAX_BINARY_BITS))
@@ -1009,6 +1014,7 @@ void resctrl_enable_mon_event(enum resctrl_event_id eve=
ntid, bool any_cpu, unsig
=20
 	mon_event_all[eventid].any_cpu =3D any_cpu;
 	mon_event_all[eventid].binary_bits =3D binary_bits;
+	mon_event_all[eventid].arch_priv =3D arch_priv;
 	mon_event_all[eventid].enabled =3D true;
 }
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 861e63e..2c64a43 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -415,7 +415,7 @@ u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
 void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
-			      unsigned int binary_bits);
+			      unsigned int binary_bits, void *arch_priv);
=20
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
=20
@@ -532,6 +532,9 @@ void resctrl_arch_pre_mount(void);
  *			only.
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
+ * @arch_priv:		Architecture private data for this event.
+ *			The @arch_priv provided by the architecture via
+ *			resctrl_enable_mon_event().
  * @val:		result of the counter read in bytes.
  * @arch_mon_ctx:	An architecture specific value from
  *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
@@ -549,7 +552,7 @@ void resctrl_arch_pre_mount(void);
  */
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hd=
r,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *arch_mon_ctx);
+			   void *arch_priv, u64 *val, void *arch_mon_ctx);
=20
 /**
  * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts

