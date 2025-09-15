Return-Path: <linux-tip-commits+bounces-6604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24502B5780B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDD016386D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E72FA0DB;
	Mon, 15 Sep 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSlv4F+6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyfGXNbb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A52F5331;
	Mon, 15 Sep 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935646; cv=none; b=aDL2PDXCLmgRgfJMUKUXIL2bamjcBwAgpUgLlBzNLQZiOyFSduVzokdVCqpAlwsKrAhxmUu/Vu3BswKsjuMWpCOcZUI6bc2x0JKi8VeTmeRybxiDn3h1LTgbKAU1a6hg7FiCJJ9wO7nhEW+KERp6gWwBZVFTZUFfZecBjDZPFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935646; c=relaxed/simple;
	bh=c451kDSzxUo3/MEjZl6QapkzRN1oMROkJqCZld9nviU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l0yOWTt6JS0w3OWUyxVuJWHwUMWGI1wyOWpd8I6u8d9bW3Cwmmg5Wu4tR4Zg77X3N0m563o0a6+2yDfZ54n8ctpgs17Z3D8mfxRq0qOxzhSbPF0PiuLHR9JEmhq7//9F8VESzPpGOlgVtBhOsGE0Wm8boQ20b6+iitoY6Pzk/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eSlv4F+6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DyfGXNbb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OPcYusePNzz8YOSovQluesj3n1EkuvSPmpnINn/r8o=;
	b=eSlv4F+6XUEPKNCsbBXHsXtLsG1iOmowdNZ33wBSG8rGc8+hDlHRXnTffq+yeoQw//afyz
	+XmXwe7NCNe18yQ2Y6wrjeW4AcE2ONHR4CmLAe5HaB9DOA8h4InS58yolPuALgoWoKOE1y
	8BDRa/t/YDtRrHraSWHDwHO1IrpnJaoGpgATREC8/ZV2ongtHMdNLUsY6YNFjjPXZRw7sr
	SEdTUfZ9RtC4bVJxnQJ743/SCN381TSBpd3hwLfCxeT6b0gD2qWm1uNL2+tgxHhFsIHCiE
	nVNyAqFKpqeWslkwieYLTneQVxmTYbnO3ewqQ0SuwpvVn/XSC2jc5axFov0nNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OPcYusePNzz8YOSovQluesj3n1EkuvSPmpnINn/r8o=;
	b=DyfGXNbbRlA+oQ47wHIKfc9SiRTrX3WJtWZofJEc4dZLMicINCv7pAAh6nqiL37rObGjpa
	YjMpsmEb4N+3teBg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce the interface to switch
 between monitor modes
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <22585f963c8b3c042cb7acfd663d497225fb0f75.1757108044.git.babu.moger@amd.com>
References:
 <22585f963c8b3c042cb7acfd663d497225fb0f75.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564174.709179.1003557688903099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8004ea01cf6338298e0c6ab055bc3ec659ce381b
Gitweb:        https://git.kernel.org/tip/8004ea01cf6338298e0c6ab055bc3ec659c=
e381b
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:30 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:49:18 +02:00

fs/resctrl: Introduce the interface to switch between monitor modes

Resctrl subsystem can support two monitoring modes, "mbm_event" or "default".
In mbm_event mode, monitoring event can only accumulate data while it is
backed by a hardware counter. In "default" mode, resctrl assumes there is
a hardware counter for each event within every CTRL_MON and MON group.

Introduce mbm_assign_mode resctrl file to switch between mbm_event and default
modes.

Example:
To list the MBM monitor modes supported:
  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
  [mbm_event]
  default

To enable the "mbm_event" counter assignment mode:
  $ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the "default" monitoring mode:
  $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

Reset MBM event counters automatically as part of changing the mode.  Clear
both architectural and non-architectural event states to prevent overflow
conditions during the next event read. Clear assignable counter configuration
on all the domains. Also, enable auto assignment when switching to "mbm_event"
mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst |  22 +++++-
 fs/resctrl/internal.h                 |   6 ++-
 fs/resctrl/monitor.c                  | 100 +++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |   7 +-
 4 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index f60f6a9..006d23a 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -259,7 +259,8 @@ with the following files:
=20
 "mbm_assign_mode":
 	The supported counter assignment modes. The enclosed brackets indicate whic=
h mode
-	is enabled.
+	is enabled. The MBM events associated with counters may reset when "mbm_ass=
ign_mode"
+	is changed.
 	::
=20
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
@@ -279,6 +280,15 @@ with the following files:
 	of counters available is described in the "num_mbm_cntrs" file. Changing the
 	mode may cause all counters on the resource to reset.
=20
+	Moving to mbm_event counter assignment mode requires users to assign the co=
unters
+	to the events. Otherwise, the MBM event counters will return 'Unassigned' w=
hen read.
+
+	The mode is beneficial for AMD platforms that support more CTRL_MON
+	and MON groups than available hardware counters. By default, this
+	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
+	Monitoring Counters) capability, ensuring counters remain assigned even
+	when the corresponding RMID is not actively used by any processor.
+
 	"default":
=20
 	In default mode, resctrl assumes there is a hardware counter for each
@@ -288,6 +298,16 @@ with the following files:
 	result in misleading values or display "Unavailable" if no counter is assig=
ned
 	to the event.
=20
+	* To enable "mbm_event" counter assignment mode:
+	  ::
+
+	    # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable "default" monitoring mode:
+	  ::
+
+	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
 "num_mbm_cntrs":
 	The maximum number of counters (total of available and assigned counters) in
 	each domain when the system supports mbm_event mode.
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index c69b1da..cf1fd82 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -396,6 +396,12 @@ void *rdt_kn_parent_priv(struct kernfs_node *kn);
=20
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_fil=
e *s, void *v);
=20
+ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off);
+
+void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_=
mon_kn,
+			     bool show);
+
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file =
*s, void *v);
=20
 int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq=
_file *s,
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f388dbc..50c2446 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1079,6 +1079,33 @@ out_unlock:
 }
=20
 /*
+ * mbm_cntr_free_all() - Clear all the counter ID configuration details in t=
he
+ *			 domain @d. Called when mbm_assign_mode is changed.
+ */
+static void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain =
*d)
+{
+	memset(d->cntr_cfg, 0, sizeof(*d->cntr_cfg) * r->mon.num_mbm_cntrs);
+}
+
+/*
+ * resctrl_reset_rmid_all() - Reset all non-architecture states for all the
+ *			      supported RMIDs.
+ */
+static void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_do=
main *d)
+{
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+	enum resctrl_event_id evt;
+	int idx;
+
+	for_each_mbm_event_id(evt) {
+		if (!resctrl_is_mon_event_enabled(evt))
+			continue;
+		idx =3D MBM_STATE_IDX(evt);
+		memset(d->mbm_states[idx], 0, sizeof(*d->mbm_states[0]) * idx_limit);
+	}
+}
+
+/*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RM=
ID
  * pair in the domain.
  *
@@ -1388,6 +1415,79 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_fi=
le *of,
 	return 0;
 }
=20
+ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *d;
+	int ret =3D 0;
+	bool enable;
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
+	if (!strcmp(buf, "default")) {
+		enable =3D 0;
+	} else if (!strcmp(buf, "mbm_event")) {
+		if (r->mon.mbm_cntr_assignable) {
+			enable =3D 1;
+		} else {
+			ret =3D -EINVAL;
+			rdt_last_cmd_puts("mbm_event mode is not supported\n");
+			goto out_unlock;
+		}
+	} else {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Unsupported assign mode\n");
+		goto out_unlock;
+	}
+
+	if (enable !=3D resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		ret =3D resctrl_arch_mbm_cntr_assign_set(r, enable);
+		if (ret)
+			goto out_unlock;
+
+		/* Update the visibility of BMEC related files */
+		resctrl_bmec_files_show(r, NULL, !enable);
+
+		/*
+		 * Initialize the default memory transaction values for
+		 * total and local events.
+		 */
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask;
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask &
+									   (READS_TO_LOCAL_MEM |
+									    READS_TO_LOCAL_S_MEM |
+									    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		/* Enable auto assignment when switching to "mbm_event" mode */
+		if (enable)
+			r->mon.mbm_assign_on_mkdir =3D true;
+		/*
+		 * Reset all the non-achitectural RMID state and assignable counters.
+		 */
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			mbm_cntr_free_all(r, d);
+			resctrl_reset_rmid_all(r, d);
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
 			       struct seq_file *s, void *v)
 {
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0c404a1..0320360 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1807,8 +1807,8 @@ static ssize_t mbm_local_bytes_config_write(struct kern=
fs_open_file *of,
  * Don't treat kernfs_find_and_get failure as an error, since this function =
may
  * be called regardless of whether BMEC is supported or the event is enabled.
  */
-static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_no=
de *l3_mon_kn,
-				    bool show)
+void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_=
mon_kn,
+			     bool show)
 {
 	struct kernfs_node *kn_config, *mon_kn =3D NULL;
 	char name[32];
@@ -1985,9 +1985,10 @@ static struct rftype res_common_files[] =3D {
 	},
 	{
 		.name		=3D "mbm_assign_mode",
-		.mode		=3D 0444,
+		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D resctrl_mbm_assign_mode_show,
+		.write		=3D resctrl_mbm_assign_mode_write,
 		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{

