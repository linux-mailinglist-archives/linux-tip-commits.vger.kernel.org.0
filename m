Return-Path: <linux-tip-commits+bounces-6612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9DB5781D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3911A25391
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DAA301465;
	Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRNHqfjs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAZuY5z8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03722FFDF7;
	Mon, 15 Sep 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935657; cv=none; b=JwzNkxul05jGSP2XPBK+Tc48q+etd3mx2yS5VAmozkZn6/M1O3s7Ic8M90dyR/ku5g/fwDsBJrZ2q/Ci4djkPI6uQ2ArAV88lNZwacupf9WDfBolbcTbp+bpndjVSiljjj/c09mxs1PrHUgwXxRJsSB+363feewD63zHgFnylBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935657; c=relaxed/simple;
	bh=0nGzNC5V6edpC0toWopgvcrVu++Jx8ffHyWFdWpVicQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=InEp1R5r+KVf/PkIZ43CDrK7ysokkQaTvkDc/zqd7qRH1hOvAd80xm6WuJu5WDI+UgeFdf+uI1sKTK5Abgfx+6orjajx9cQ9ZfR62Ug+FUcZe78HieTci2pvmYpUIptGoi5TqpzBupMwIY87oClgwz35lvhbXM9Dskz8s2r+c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRNHqfjs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAZuY5z8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytVJZuvNqZF1OBwIAHRy13jBkSHjYUvm4Ed576GLINA=;
	b=DRNHqfjssfxcOC7bZriu8y+n82VU05xufsQx6jLDI/y2iPXh52Om+dGlUISw69TpwNawsO
	AHCuUC6xEqh8pAxbX3GE4hTGs3nMFlDB+Jyne/lhux2o0S3RUfcC8ZNQwfcW507uUqDQVr
	lctokm+L3kettDQCQpOH1o+UnX3sovEbq8SFZL0tJjC7g6R6xc1Mxd8avAC2SI341uMjlc
	UACFgmKbboE5cWf76lw+WZWhwyhVsAxL58zIrbJxzC8cu67XYDHZe4PEkwh8XB9ZD1I+G8
	1MT9S3zmdVFtdkPrMtyxxRZed12i0EaxPZpDPqpA8WGQkndkDaqAxzP8nWF50A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytVJZuvNqZF1OBwIAHRy13jBkSHjYUvm4Ed576GLINA=;
	b=fAZuY5z873H9DhasjFcOD0ekjzspq8PjOdm+60iRrTs7/pfXLd50Q6qxoTxzP/jh9yu5aE
	6rHSAiOmZfKAQiAA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Add event configuration directory under
 info/L3_MON/
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0c76ad2d0a9c8399d242742f23dfaf077e61e900.1757108044.git.babu.moger@amd.com>
References:
 <0c76ad2d0a9c8399d242742f23dfaf077e61e900.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564999.709179.10773915165023324129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ea274cbeaf8f0667267b347e3f84797439cdab4e
Gitweb:        https://git.kernel.org/tip/ea274cbeaf8f0667267b347e3f84797439c=
dab4e
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:23 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:39:38 +02:00

fs/resctrl: Add event configuration directory under info/L3_MON/

The "mbm_event" counter assignment mode allows the user to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned. The user can specify the memory transaction(s) for the counter to
track.

When this mode is supported, the /sys/fs/resctrl/info/L3_MON/event_configs
directory contains a sub-directory for each MBM event that can be assigned to
a counter.  The MBM event sub-directory contains a file named "event_filter"
that is used to view and modify which memory transactions the MBM event is
configured with.

Create /sys/fs/resctrl/info/L3_MON/event_configs directory on resctrl mount
and pre-populate it with directories for the two existing MBM events:
mbm_total_bytes and mbm_local_bytes. Create the "event_filter" file within
each MBM event directory with the needed *show() that displays the memory
transactions with which the MBM event is configured.

Example:
  $ mount -t resctrl resctrl /sys/fs/resctrl
  $ cd /sys/fs/resctrl/
  $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
    local_reads,remote_reads,local_non_temporal_writes,
    remote_non_temporal_writes,local_reads_slow_memory,
    remote_reads_slow_memory,dirty_victim_writes_all

  $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
    local_reads,local_non_temporal_writes,local_reads_slow_memory

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 33 +++++++++++++++-
 fs/resctrl/internal.h                 |  4 ++-
 fs/resctrl/monitor.c                  | 56 +++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 | 59 +++++++++++++++++++++++++-
 include/linux/resctrl_types.h         |  3 +-
 5 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 4c24c5f..ddd95f1 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -310,6 +310,39 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
 	  0=3D30;1=3D30
=20
+"event_configs":
+	Directory that exists when "mbm_event" counter assignment mode is supported.
+	Contains a sub-directory for each MBM event that can be assigned to a count=
er.
+
+	Two MBM events are supported by default: mbm_local_bytes and mbm_total_byte=
s.
+	Each MBM event's sub-directory contains a file named "event_filter" that is
+	used to view and modify which memory transactions the MBM event is configur=
ed
+	with. The file is accessible only when "mbm_event" counter assignment mode =
is
+	enabled.
+
+	List of memory transaction types supported:
+
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+	Name			    Description
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+	dirty_victim_writes_all     Dirty Victims from the QOS domain to all types =
of memory
+	remote_reads_slow_memory    Reads to slow memory in the non-local NUMA doma=
in
+	local_reads_slow_memory     Reads to slow memory in the local NUMA domain
+	remote_non_temporal_writes  Non-temporal writes to non-local NUMA domain
+	local_non_temporal_writes   Non-temporal writes to local NUMA domain
+	remote_reads                Reads to memory in the non-local NUMA domain
+	local_reads                 Reads to memory in the local NUMA domain
+	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+	For example::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_fil=
ter
+	  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_wr=
ites,
+	  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_fil=
ter
+	  local_reads,local_non_temporal_writes,local_reads_slow_memory
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 2f1f2ef..9bf2e2f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -241,6 +241,8 @@ struct rdtgroup {
=20
 #define RFTYPE_DEBUG			BIT(10)
=20
+#define RFTYPE_ASSIGN_CONFIG		BIT(11)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
=20
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
@@ -403,6 +405,8 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
=20
 void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
=20
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, voi=
d *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 5532705..7179f98 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -972,6 +972,61 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
=20
+/**
+ * struct mbm_transaction - Memory transaction an MBM event can be configure=
d with.
+ * @name:	Name of memory transaction (read, write ...).
+ * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to
+ *		represent the memory transaction within an event's configuration.
+ */
+struct mbm_transaction {
+	char	name[32];
+	u32	val;
+};
+
+/* Decoded values for each type of memory transaction. */
+static struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] =3D {
+	{"local_reads", READS_TO_LOCAL_MEM},
+	{"remote_reads", READS_TO_REMOTE_MEM},
+	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
+	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
+	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
+	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
+	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
+};
+
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, voi=
d *v)
+{
+	struct mon_evt *mevt =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r;
+	bool sep =3D false;
+	int ret =3D 0, i;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	r =3D resctrl_arch_get_resource(mevt->rid);
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	for (i =3D 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (mevt->evt_cfg & mbm_transactions[i].val) {
+			if (sep)
+				seq_putc(seq, ',');
+			seq_printf(seq, "%s", mbm_transactions[i].name);
+			sep =3D true;
+		}
+	}
+	seq_putc(seq, '\n');
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RM=
ID
  * pair in the domain.
@@ -1287,6 +1342,7 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 	}
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 2e1d0a2..8f0c403 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1924,6 +1924,12 @@ static struct rftype res_common_files[] =3D {
 		.write		=3D mbm_local_bytes_config_write,
 	},
 	{
+		.name		=3D "event_filter",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D event_filter_show,
+	},
+	{
 		.name		=3D "mbm_assign_mode",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
@@ -2183,10 +2189,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, cons=
t char *name,
 	return ret;
 }
=20
+static int resctrl_mkdir_event_configs(struct rdt_resource *r, struct kernfs=
_node *l3_mon_kn)
+{
+	struct kernfs_node *kn_subdir, *kn_subdir2;
+	struct mon_evt *mevt;
+	int ret;
+
+	kn_subdir =3D kernfs_create_dir(l3_mon_kn, "event_configs", l3_mon_kn->mode=
, NULL);
+	if (IS_ERR(kn_subdir))
+		return PTR_ERR(kn_subdir);
+
+	ret =3D rdtgroup_kn_set_ugid(kn_subdir);
+	if (ret)
+		return ret;
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid !=3D r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt-=
>evtid))
+			continue;
+
+		kn_subdir2 =3D kernfs_create_dir(kn_subdir, mevt->name, kn_subdir->mode, m=
evt);
+		if (IS_ERR(kn_subdir2)) {
+			ret =3D PTR_ERR(kn_subdir2);
+			goto out;
+		}
+
+		ret =3D rdtgroup_kn_set_ugid(kn_subdir2);
+		if (ret)
+			goto out;
+
+		ret =3D rdtgroup_add_files(kn_subdir2, RFTYPE_ASSIGN_CONFIG);
+		if (ret)
+			break;
+	}
+
+out:
+	return ret;
+}
+
 static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
+	struct rdt_resource *r;
 	int ret;
=20
 	kn_subdir =3D kernfs_create_dir(kn_info, name,
@@ -2199,8 +2243,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char=
 *name,
 		return ret;
=20
 	ret =3D rdtgroup_add_files(kn_subdir, fflags);
-	if (!ret)
-		kernfs_activate(kn_subdir);
+	if (ret)
+		return ret;
+
+	if ((fflags & RFTYPE_MON_INFO) =3D=3D RFTYPE_MON_INFO) {
+		r =3D priv;
+		if (r->mon.mbm_cntr_assignable) {
+			ret =3D resctrl_mkdir_event_configs(r, kn_subdir);
+			if (ret)
+				return ret;
+		}
+	}
+
+	kernfs_activate(kn_subdir);
=20
 	return ret;
 }
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index d983516..acfe078 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,6 +34,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
=20
+/* Number of memory transactions that an MBM event can be configured with */
+#define NUM_MBM_TRANSACTIONS		7
+
 /* Event IDs */
 enum resctrl_event_id {
 	/* Must match value of first event below */

