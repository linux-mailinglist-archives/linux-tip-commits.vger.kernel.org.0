Return-Path: <linux-tip-commits+bounces-6609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D0B57813
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D244C3A7990
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4E2FFDE2;
	Mon, 15 Sep 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHlmfWDk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9m7W9rTR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE52FF16A;
	Mon, 15 Sep 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935652; cv=none; b=Ji07Xnk9X68dHOO1xRJa0P0EDcn7FFUjP/G/eRU+xpj22B8Llu8zAFNgUomsGcKb9T/FDJrrpPM23D1Ec9sJF5qZpD0E3pySaPowI18nG9aT+abuPTIMYyaEFIMuv3hcdhdHmW01z8OLB5kzNqGRhK8iGRoCaCQ2UuVLSaLSoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935652; c=relaxed/simple;
	bh=/QsUchtKipSt6a6BFUxTjfRlXBNExb2OO7HPgg8XhUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IAlohIWwELCMDZzbfbqtKmjHRhsQ0TLPWyFQzSsI+q89GQ9gNw6Q60v4Jqjt8t4So9owjLLKTOhTvw6PLdK7159JR+8HP9TvZzYfcxz3/Hl5l1uB42pwW8TBt5xwPqHtqXorlHVX9ZihDL+sVgj2+oeinY75BcYf2tVtIZbn7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHlmfWDk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9m7W9rTR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pVqTR7jURxaNrYd80LSloQkE87ObOl805mlHkuBgYw=;
	b=EHlmfWDkjTyZoblZts+2zxBvKkPzj9dYLqzEzebK40vDJZwRFlwumQZdb6axte4xSK4CJC
	pceG1K2gUdCoWMoWQyHgsaAFQSId3VR6I2c/NukHtr4qWKAxrosomChzBdC9OoMCT4v69q
	MEe32dQCp9pKRX24lrlMI9E1lOY8g04SgauTR7CcOrLHJu5tZ82dhQ3y6/DmfIezc58WbT
	8xnvIloAinHBC8JPZJoRE5ZE7C//Bq68nHeF2S7dJbwGQpidbqpL3YJHVR+TTw2A7RKo6e
	yI9QgRrg1A8HlxW4OmZdrWb47Bjyu/YjQH6cFv7FmelpVou4vYF2vwrHVbmphQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pVqTR7jURxaNrYd80LSloQkE87ObOl805mlHkuBgYw=;
	b=9m7W9rTRJWDhI4XEGEXJveKd7aHVSSGodIBIAa1VHbGS0TNiGjkVcESpJ4Ys+K+u7mMSPg
	+R4e7HCmKFFZ1iCA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Auto assign counters on mkdir and clean
 up on group removal
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <db4240e3d815c3f193402b36723995427ec358b0.1757108044.git.babu.moger@amd.com>
References:
 <db4240e3d815c3f193402b36723995427ec358b0.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564649.709179.7546602399978052699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ef712fe97ec575657abb12d76837867dd8b8a0ed
Gitweb:        https://git.kernel.org/tip/ef712fe97ec575657abb12d76837867dd8b=
8a0ed
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:26 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:44:04 +02:00

fs/resctrl: Auto assign counters on mkdir and clean up on group removal

Resctrl provides a user-configurable option mbm_assign_on_mkdir that
determines if a counter will automatically be assigned to an RMID, event pair
when its associated monitor group is created via mkdir.

Enable mbm_assign_on_mkdir by default to automatically assign counters to
the two default events (MBM total and MBM local) of a new monitoring group
created via mkdir. This maintains backward compatibility with original
resctrl support for these two events.

Unassign and free counters belonging to a monitoring group when the group
is deleted.

Monitor group creation does not fail if a counter cannot be assigned to one or
both events. There may be limited counters and users have the flexibility to
modify counter assignments at a later time. Log the error message "Failed to
allocate counter for <event> in domain <id>" in
/sys/fs/resctrl/info/last_cmd_status when a new monitoring group is created
but counter assignment failed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/monitor.c  |  4 +++-
 fs/resctrl/rdtgroup.c | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index deca953..9cb3341 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1231,7 +1231,8 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
+	    !r->mon.mbm_assign_on_mkdir)
 		return;
=20
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
@@ -1503,6 +1504,7 @@ int resctrl_mon_resource_init(void)
 								   (READS_TO_LOCAL_MEM |
 								    READS_TO_LOCAL_S_MEM |
 								    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		r->mon.mbm_assign_on_mkdir =3D true;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c7ea42c..48f9814 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2713,6 +2713,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_info;
=20
+		rdtgroup_assign_cntrs(&rdtgroup_default);
+
 		ret =3D mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
@@ -2751,8 +2753,10 @@ out_mondata:
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(&rdtgroup_default);
 		kernfs_remove(kn_mongrp);
+	}
 out_info:
 	kernfs_remove(kn_info);
 out_closid_exit:
@@ -2897,6 +2901,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtg=
rp)
=20
 	head =3D &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
=20
@@ -2937,6 +2942,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
=20
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
=20
 		kernfs_remove(rdtgrp->kn);
@@ -3021,6 +3028,7 @@ static void resctrl_fs_teardown(void)
 		return;
=20
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
@@ -3501,9 +3509,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgrou=
p *rdtgrp)
 	}
 	rdtgrp->mon.rmid =3D ret;
=20
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	ret =3D mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
+		rdtgroup_unassign_cntrs(rdtgrp);
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
@@ -3513,8 +3524,10 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgrou=
p *rdtgrp)
=20
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(rgrp);
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
+	}
 }
=20
 /*
@@ -3790,6 +3803,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, =
cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
=20
 	rdtgrp->flags =3D RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
=20
 	/*
@@ -3837,6 +3853,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp,=
 cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
=20
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
=20

