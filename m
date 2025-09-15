Return-Path: <linux-tip-commits+bounces-6610-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8AB57818
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68457203E15
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC61F3009C0;
	Mon, 15 Sep 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGTYNgrv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIKIUGws"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD52FFDF6;
	Mon, 15 Sep 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935654; cv=none; b=H1fL8rkMyGzLxlzq6m3Rs61aYiWqnAvP+PUaz066xa4OxQycwSLGJxAgzncYGBLMH0Jr9mYidRfVfRTPmFR5J0QLV7tJuCvPfq97WssWmTiWkv+hPjL9+wq07PZk2DkYPh+o5PIt8V4qVc+IeHu9T+vFPMX7RqRlcUV7p75b7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935654; c=relaxed/simple;
	bh=mmOKh+EbxBMoZ3uED8PsUk6yrQB6boNbZ7gRO9WLvGk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QLEjGnbkRqIjcBmGZ4RJdadsDczngRJD3tx1mA6D2N738qi6BCoYovLmff35MQ6HNy9MRtjGULx2Uq6zDe0pQyzdi3+qyo/XzHqOujmwbK6h+1Ky6tCbS3qe/55CDhc+NKXgsHP9bRVKN8y17ol/VaX9ruvLecOaf+3myVWV2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGTYNgrv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIKIUGws; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tImi+asJdGclsrRN/vLfq+P49+1xvY9UEGMkmzh0fLc=;
	b=KGTYNgrvziAkyJrJ56koNpxW1NDeA0I5IdJ70X+fW9il4khBo8x2E0LPtzXg8+xU+FP+jj
	BH+u4e2aJMaxS5+d4u7QzDXCJc/P0T1fknh28xbG5l2b/5JgfoYIw5eoSsG/J25krHweSk
	ev9wmI8xRxx+FoGONhEIyn2LsDv5LW+CmPe8K+j1PQXX8+d17urO1UwRFdDGSxgRpxDt2D
	ApUUotjZq2VAIsmTOWjF4pio9jnKuq+9ClMSQblTjYOW1Gi46Kz/NMLiAcGie7ify93wix
	+6rGqU7nEEcB50//6E+rwVRoVYGxdoxE+GbFnplFt2jbvm8oYcjTk7p5IzIZJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tImi+asJdGclsrRN/vLfq+P49+1xvY9UEGMkmzh0fLc=;
	b=VIKIUGwstpoTp6fxp5hJcnKDfI5qnqNrxslTHqyCObSRQ9WcifDw7eQwTX8i71U1TRTxUr
	XvRwQZG6ee9n45BQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Provide interface to update the event
 configurations
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <1468bf627842614be7bb3d35c177b1022c39311e.1757108044.git.babu.moger@amd.com>
References:
 <1468bf627842614be7bb3d35c177b1022c39311e.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564884.709179.6220500280545864729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f9ae5913d47cda67481a4f54cc3273d3d1d00a01
Gitweb:        https://git.kernel.org/tip/f9ae5913d47cda67481a4f54cc3273d3d1d=
00a01
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:24 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:40:38 +02:00

fs/resctrl: Provide interface to update the event configurations

When "mbm_event" counter assignment mode is enabled, users can modify the
event configuration by writing to the 'event_filter' resctrl file.  The event
configurations for mbm_event mode are located in
/sys/fs/resctrl/info/L3_MON/event_configs/.

Update the assignments of all CTRL_MON and MON resource groups when the event
configuration is modified.

Example:
  $ mount -t resctrl resctrl /sys/fs/resctrl

  $ cd /sys/fs/resctrl/

  $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
    local_reads,local_non_temporal_writes,local_reads_slow_memory

  $ echo "local_reads,local_non_temporal_writes" >
    info/L3_MON/event_configs/mbm_total_bytes/event_filter

  $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
    local_reads,local_non_temporal_writes

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst |  12 +++-
 fs/resctrl/internal.h                 |   3 +-
 fs/resctrl/monitor.c                  | 114 +++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |   3 +-
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index ddd95f1..2e840ef 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -343,6 +343,18 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_fil=
ter
 	  local_reads,local_non_temporal_writes,local_reads_slow_memory
=20
+	Modify the event configuration by writing to the "event_filter" file within
+	the "event_configs" directory. The read/write "event_filter" file contains =
the
+	configuration of the event that reflects which memory transactions are coun=
ted by it.
+
+	For example::
+
+	  # echo "local_reads, local_non_temporal_writes" >
+	    /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_fil=
ter
+	   local_reads,local_non_temporal_writes
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9bf2e2f..90d3e4a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -407,6 +407,9 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
=20
 int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, voi=
d *v);
=20
+ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nb=
ytes,
+			   loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 7179f98..ccb9726 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1192,6 +1192,120 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
 					     &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
 }
=20
+static int resctrl_parse_mem_transactions(char *tok, u32 *val)
+{
+	u32 temp_val =3D 0;
+	char *evt_str;
+	bool found;
+	int i;
+
+next_config:
+	if (!tok || tok[0] =3D=3D '\0') {
+		*val =3D temp_val;
+		return 0;
+	}
+
+	/* Start processing the strings for each memory transaction type */
+	evt_str =3D strim(strsep(&tok, ","));
+	found =3D false;
+	for (i =3D 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (!strcmp(mbm_transactions[i].name, evt_str)) {
+			temp_val |=3D mbm_transactions[i].val;
+			found =3D true;
+			break;
+		}
+	}
+
+	if (!found) {
+		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
+		return -EINVAL;
+	}
+
+	goto next_config;
+}
+
+/*
+ * rdtgroup_update_cntr_event - Update the counter assignments for the event
+ *				in a group.
+ * @r:		Resource to which update needs to be done.
+ * @rdtgrp:	Resctrl group.
+ * @evtid:	MBM monitor event.
+ */
+static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgro=
up *rdtgrp,
+				       enum resctrl_event_id evtid)
+{
+	struct rdt_mon_domain *d;
+	int cntr_id;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		cntr_id =3D mbm_cntr_get(r, d, rdtgrp, evtid);
+		if (cntr_id >=3D 0)
+			rdtgroup_assign_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					     rdtgrp->closid, cntr_id, true);
+	}
+}
+
+/*
+ * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the ev=
ent
+ *				   for all the groups.
+ * @mevt	MBM Monitor event.
+ */
+static void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(mevt->rid);
+	struct rdtgroup *prgrp, *crgrp;
+
+	/*
+	 * Find all the groups where the event is assigned and update the
+	 * configuration of existing assignments.
+	 */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		rdtgroup_update_cntr_event(r, prgrp, mevt->evtid);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
+	}
+}
+
+ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nb=
ytes,
+			   loff_t off)
+{
+	struct mon_evt *mevt =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r;
+	u32 evt_cfg =3D 0;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] =3D '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	r =3D resctrl_arch_get_resource(mevt->rid);
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	ret =3D resctrl_parse_mem_transactions(buf, &evt_cfg);
+	if (!ret && mevt->evt_cfg !=3D evt_cfg) {
+		mevt->evt_cfg =3D evt_cfg;
+		resctrl_update_cntr_allrdtgrp(mevt);
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8f0c403..e90bc80 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1925,9 +1925,10 @@ static struct rftype res_common_files[] =3D {
 	},
 	{
 		.name		=3D "event_filter",
-		.mode		=3D 0444,
+		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D event_filter_show,
+		.write		=3D event_filter_write,
 	},
 	{
 		.name		=3D "mbm_assign_mode",

