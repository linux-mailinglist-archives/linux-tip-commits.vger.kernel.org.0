Return-Path: <linux-tip-commits+bounces-6616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3798BB5782B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910FC204080
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE378302170;
	Mon, 15 Sep 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ms91yZs6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6e2CBNz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D1301484;
	Mon, 15 Sep 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935660; cv=none; b=XSGzfz9H8goD0IYeynAUjhoxt1EAcHzap78xE2VqyPID/0nlYhFENQcUwbdsHeYEcQMdXAVYOCun4t7eYNo92p+T/8lFUmRv5/RCGq/yHF4+F/f/KJL4I6XQXl19o3IwC0K79yjJAl8H4ENWoHLiv2dQnwyWHkdbqAJ+4mvmttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935660; c=relaxed/simple;
	bh=vygnaY4k/gOgG+T5ie5zP/z2AOfFqSmfHI7YDPydKw0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KroW+Fz1nzMOlQJz0+2V01YX6D8w9E4k5gmRosXG5VCnlfo1DTe4viGAjdd6WWJ9sLcH42Yu9xF07UVzZD4e5O2kEyPbrvY3u761YooTkTg9iwUjXeMQsAh0Ix+Ledv1hw0eZSH/bh2K5JNON3/a2OOQArNpQr4LdgtMXWstG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ms91yZs6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6e2CBNz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrWJlvtNrNEkbVtJe+oBKecze02c1P9mnIm4unKesfY=;
	b=ms91yZs6eAqw1dYaJ3HfBfnm4t9GGLQLm8N/qGGQS/Wsu7Cz9O/m8TtRZL+Vi5Raorvhae
	MMrjf/jVnIYEQDzHzKKHFqWdenEb4r2I/JfCdBuzKgY6TRTCDQBVyTEwivp88Qhtll5rv2
	PDTR25meUnrM2KTjo5/tmfZnXKKIoalCq/1vqfGrVlfYMkSUGZwVy8Hr69o9EoSdN2TZ/h
	zzSPtVdyfMzee4udEEk4OQpszhYAmW7YQ3lOmphWtltDNvYxfYc4uEKBUmIdUN4ofzJWTd
	b6ygHdR+kCBj9/EGIGUzXbeUbBjrMksh9XDSF/gWFls6DrU0sxw14GdxHhE+wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrWJlvtNrNEkbVtJe+oBKecze02c1P9mnIm4unKesfY=;
	b=S6e2CBNz10MB/cgSim4T+onr2wryrNN3aohmSfPCDVGTgTaVDf4nOoZwlQJi8Gb09jwK8E
	SmxI2BdIte+nh4AA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Pass struct rdtgroup instead of
 individual members
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <6cbebfc1f5e63d3c5dcbb6751ee7ccda9f38cf4b.1757108044.git.babu.moger@amd.com>
References:
 <6cbebfc1f5e63d3c5dcbb6751ee7ccda9f38cf4b.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565565.709179.8650016453258705604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     bc53eea6c2a1dea152a0073a2f2814b697ad197e
Gitweb:        https://git.kernel.org/tip/bc53eea6c2a1dea152a0073a2f2814b697a=
d197e
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:18 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:23:24 +02:00

fs/resctrl: Pass struct rdtgroup instead of individual members

Reading monitoring data for a monitoring group requires both the RMID and
CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
separately to several functions involved in retrieving event data.

When "mbm_event" counter assignment mode is enabled, a counter ID is required
to read event data. The counter ID is obtained through mbm_cntr_get(), which
expects a struct rdtgroup pointer.

Provide a pointer to the struct rdtgroup as parameter to functions involved in
retrieving event data to simplify access to RMID, CLOSID, and counter ID.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/monitor.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 2ed29ae..c815153 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -413,9 +413,11 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int =
cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
=20
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	int cpu =3D smp_processor_id();
+	u32 closid =3D rdtgrp->closid;
+	u32 rmid =3D rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
 	struct mbm_state *m;
 	int err, ret;
@@ -475,8 +477,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct=
 rmid_read *rr)
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
- * @closid:	The closid used to identify the cached mbm_state.
- * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rdtgrp:	resctrl group associated with the CLOSID and RMID to identify
+ *		the cached mbm_state.
  * @rr:		The struct rmid_read populated by __mon_event_count().
  *
  * Supporting function to calculate the memory bandwidth
@@ -484,9 +486,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struc=
t rmid_read *rr)
  * __mon_event_count() is compared with the chunks value from the previous
  * invocation. This must be called once per second to maintain values in MBp=
s.
  */
-static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	u64 cur_bw, bytes, cur_bytes;
+	u32 closid =3D rdtgrp->closid;
+	u32 rmid =3D rdtgrp->mon.rmid;
 	struct mbm_state *m;
=20
 	m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
@@ -515,7 +519,7 @@ void mon_event_count(void *info)
=20
 	rdtgrp =3D rr->rgrp;
=20
-	ret =3D __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
+	ret =3D __mon_event_count(rdtgrp, rr);
=20
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -526,8 +530,7 @@ void mon_event_count(void *info)
=20
 	if (rdtgrp->type =3D=3D RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->closid, entry->mon.rmid,
-					      rr) =3D=3D 0)
+			if (__mon_event_count(entry, rr) =3D=3D 0)
 				ret =3D 0;
 		}
 	}
@@ -658,7 +661,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct r=
dt_mon_domain *dom_mbm)
 }
=20
 static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
-				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
+				 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr =3D {0};
=20
@@ -672,30 +675,30 @@ static void mbm_update_one_event(struct rdt_resource *r=
, struct rdt_mon_domain *
 		return;
 	}
=20
-	__mon_event_count(closid, rmid, &rr);
+	__mon_event_count(rdtgrp, &rr);
=20
 	/*
 	 * If the software controller is enabled, compute the
 	 * bandwidth for this event id.
 	 */
 	if (is_mba_sc(NULL))
-		mbm_bw_count(closid, rmid, &rr);
+		mbm_bw_count(rdtgrp, &rr);
=20
 	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
=20
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-		       u32 closid, u32 rmid)
+		       struct rdtgroup *rdtgrp)
 {
 	/*
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
=20
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
=20
 /*
@@ -768,11 +771,11 @@ void mbm_handle_overflow(struct work_struct *work)
 	d =3D container_of(work, struct rdt_mon_domain, mbm_over.work);
=20
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp);
=20
 		head =3D &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp);
=20
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);

