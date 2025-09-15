Return-Path: <linux-tip-commits+bounces-6606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9EAB5780F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E0616E860
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3E2FE593;
	Mon, 15 Sep 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buyN0hlC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGfsXoov"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D22FD1CB;
	Mon, 15 Sep 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935649; cv=none; b=rmj7/S6XCkgwmQDs6jW8Bp8ypAFqakB2y8A1PM2JLZW5kBFJJPvr5aoF7TDhjFJqOd4zp2FvaCEIbjAuqrCZLBawWBTPb4pCSPfXKR2dZgcX7WI2OCj/VN/sSzuXbmfmFqy8HE3tZk7LfrriHpt6htESzN2IvUxCfl5+/2QRzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935649; c=relaxed/simple;
	bh=jp6lkdwm1kU1rgIGPCGzlppOd+hV90OpOdESZBvfTaM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y/XfWq/4VM2GO21L2qgKDeRHPkwuPr84KZ4mJ6mt+OPW91ir9u4gfObYLq4lv9wAvXkv2dc5UTe8RW0XrS9cNQmNKWDxoq+aLEGqCoZMlz4I2H3nJWd0I6seiR/4GynGeQG5F768JCGgiuZA+Uidk2YrTA1q34grPxCewa3g+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buyN0hlC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGfsXoov; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kDbbnrQYKWVUiwa2ZXRZx3hTzbU31Yt75YobPgcwWc=;
	b=buyN0hlCqzyfSK8lq2pya2W8CpERHJL46QhblkDzUjtR2OObC+YQq5XLRJOQ7RM4sHExT9
	Pla32TIi+5ndFLM2wWzYbgVHQZh8nqMHGMpgYX0Gr0jRvQ6hgjenboHeStEnzupNLXXbmf
	1SfRdavGyf8Fc5BSYdeLDr/R0IAHlqY2j1IWyYlEIxofuBUeSHRmJdPUbwQyCccaPYAcom
	/JgJh38bTm5UhI5ggOdbMX1N6QINSLunVKD84qWMVEhdb2Yo1joRkWY4KmdUyrc38jVSpW
	H+/HBOl7l/rhFFBa7u1v2ojt69IEfhf2iYOoStAfGqaGIMsAfZIUG+K6dcWNKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kDbbnrQYKWVUiwa2ZXRZx3hTzbU31Yt75YobPgcwWc=;
	b=nGfsXoovU03HHTckr32WDag0T7xbSsAX0A/LT8wfsWOu9l4xVsrOmyoms1Qjb/sqd/n0Nh
	u78/hBwloZLxvgBg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce the interface to modify
 assignments in a group
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com>
References:
 <b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564412.709179.8478610566418953842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     88bee79640aea6192f98c8faae30e0013453479d
Gitweb:        https://git.kernel.org/tip/88bee79640aea6192f98c8faae30e001345=
3479d
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:28 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:47:17 +02:00

fs/resctrl: Introduce the interface to modify assignments in a group

Enable the mbm_l3_assignments resctrl file to be used to modify counter
assignments of CTRL_MON and MON groups when the "mbm_event" counter
assignment mode is enabled.

Process the assignment modifications in the following format:
<Event>:<Domain id>=3D<Assignment state>;<Domain id>=3D<Assignment state>

Event: A valid MBM event in the
       /sys/fs/resctrl/info/L3_MON/event_configs directory.

Domain ID: A valid domain ID. When writing, '*' applies the changes
	   to all domains.

Assignment states:

    _ : Unassign a counter.

    e : Assign a counter exclusively.

Examples:

  $ cd /sys/fs/resctrl
  $ cat /sys/fs/resctrl/mbm_L3_assignments
    mbm_total_bytes:0=3De;1=3De
    mbm_local_bytes:0=3De;1=3De

To unassign the counter associated with the mbm_total_bytes event on
domain 0:

  $ echo "mbm_total_bytes:0=3D_" > mbm_L3_assignments
  $ cat /sys/fs/resctrl/mbm_L3_assignments
    mbm_total_bytes:0=3D_;1=3De
    mbm_local_bytes:0=3De;1=3De

To unassign the counter associated with the mbm_total_bytes event on
all the domains:

  $ echo "mbm_total_bytes:*=3D_" > mbm_L3_assignments
  $ cat /sys/fs/resctrl/mbm_L3_assignments
    mbm_total_bytes:0=3D_;1=3D_
    mbm_local_bytes:0=3De;1=3De

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 151 ++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |   3 +-
 fs/resctrl/monitor.c                  | 139 +++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |   3 +-
 4 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index a2b7240..f60f6a9 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -522,7 +522,8 @@ When monitoring is enabled all MON groups may also contai=
n:
 	Event: A valid MBM event in the
 	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
=20
-	Domain ID: A valid domain ID.
+	Domain ID: A valid domain ID. When writing, '*' applies the changes
+		   to all the domains.
=20
 	Assignment states:
=20
@@ -540,6 +541,35 @@ When monitoring is enabled all MON groups may also conta=
in:
 	   mbm_total_bytes:0=3De;1=3De
 	   mbm_local_bytes:0=3De;1=3De
=20
+	Assignments can be modified by writing to the interface.
+
+	Examples:
+
+	To unassign the counter associated with the mbm_total_bytes event on domain=
 0:
+	::
+
+	 # echo "mbm_total_bytes:0=3D_" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=3D_;1=3De
+	   mbm_local_bytes:0=3De;1=3De
+
+	To unassign the counter associated with the mbm_total_bytes event on all th=
e domains:
+	::
+
+	 # echo "mbm_total_bytes:*=3D_" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=3D_;1=3D_
+	   mbm_local_bytes:0=3De;1=3De
+
+	To assign a counter associated with the mbm_total_bytes event on all domain=
s in
+	exclusive mode:
+	::
+
+	 # echo "mbm_total_bytes:*=3De" > /sys/fs/resctrl/mbm_L3_assignments
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=3De;1=3De
+	   mbm_local_bytes:0=3De;1=3De
+
 When the "mba_MBps" mount option is used all CTRL_MON groups will also conta=
in:
=20
 "mba_MBps_event":
@@ -1585,6 +1615,125 @@ View the llc occupancy snapshot::
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
   11234000
=20
+
+Examples on working with mbm_assign_mode
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+a. Check if MBM counter assignment mode is supported.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  [mbm_event]
+  default
+
+The "mbm_event" mode is detected and enabled.
+
+b. Check how many assignable counters are supported.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
+  0=3D32;1=3D32
+
+c. Check how many assignable counters are available for assignment in each d=
omain.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
+  0=3D30;1=3D30
+
+d. To list the default group's assign states.
+::
+
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=3De;1=3De
+  mbm_local_bytes:0=3De;1=3De
+
+e.  To unassign the counter associated with the mbm_total_bytes event on dom=
ain 0.
+::
+
+  # echo "mbm_total_bytes:0=3D_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=3D_;1=3De
+  mbm_local_bytes:0=3De;1=3De
+
+f. To unassign the counter associated with the mbm_total_bytes event on all =
domains.
+::
+
+  # echo "mbm_total_bytes:*=3D_" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignment
+  mbm_total_bytes:0=3D_;1=3D_
+  mbm_local_bytes:0=3De;1=3De
+
+g. To assign a counter associated with the mbm_total_bytes event on all doma=
ins in
+exclusive mode.
+::
+
+  # echo "mbm_total_bytes:*=3De" > /sys/fs/resctrl/mbm_L3_assignments
+  # cat /sys/fs/resctrl/mbm_L3_assignments
+  mbm_total_bytes:0=3De;1=3De
+  mbm_local_bytes:0=3De;1=3De
+
+h. Read the events mbm_total_bytes and mbm_local_bytes of the default group.=
 There is
+no change in reading the events with the assignment.
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
+  779247936
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
+  562324232
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  212122123
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  121212144
+
+i. Check the event configurations.
+::
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filt=
er
+  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_wri=
tes,
+  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filt=
er
+  local_reads,local_non_temporal_writes,local_reads_slow_memory
+
+j. Change the event configuration for mbm_local_bytes.
+::
+
+  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, r=
emote_reads" >
+  /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+
+  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filt=
er
+  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
+
+k. Now read the local events again. The first read may come back with "Unava=
ilable"
+status. The subsequent read of mbm_local_bytes will display the current valu=
e.
+::
+
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  Unavailable
+  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
+  2252323
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  Unavailable
+  # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
+  1566565
+
+l. Users have the option to go back to 'default' mbm_assign_mode if required=
. This can be
+done using the following command. Note that switching the mbm_assign_mode ma=
y reset all
+the MBM counters (and thus all MBM events) of all the resctrl groups.
+::
+
+  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+  mbm_event
+  [default]
+
+m. Unmount the resctrl filesystem.
+::
+
+  # umount /sys/fs/resctrl/
+
 Intel RDT Errata
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 43297b3..c69b1da 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -418,6 +418,9 @@ ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_o=
pen_file *of, char *buf
=20
 int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s,=
 void *v);
=20
+ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, siz=
e_t nbytes,
+				 loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index b692a0e..f388dbc 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1502,6 +1502,145 @@ out_unlock:
 	return ret;
 }
=20
+/*
+ * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
+ * event name.
+ */
+static struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, cha=
r *name)
+{
+	struct mon_evt *mevt;
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid =3D=3D r->rid && mevt->enabled &&
+		    resctrl_is_mbm_event(mevt->evtid) &&
+		    !strcmp(mevt->name, name))
+			return mevt;
+	}
+
+	return NULL;
+}
+
+static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain =
*d,
+					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int ret =3D 0;
+
+	if (!assign || strlen(assign) !=3D 1)
+		return -EINVAL;
+
+	switch (*assign) {
+	case 'e':
+		ret =3D rdtgroup_assign_cntr_event(d, rdtgrp, mevt);
+		break;
+	case '_':
+		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgr=
oup *rdtgrp,
+					char *event, char *tok)
+{
+	struct rdt_mon_domain *d;
+	unsigned long dom_id =3D 0;
+	char *dom_str, *id_str;
+	struct mon_evt *mevt;
+	int ret;
+
+	mevt =3D mbm_get_mon_event_by_name(r, event);
+	if (!mevt) {
+		rdt_last_cmd_printf("Invalid event %s\n", event);
+		return -ENOENT;
+	}
+
+next:
+	if (!tok || tok[0] =3D=3D '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str =3D strim(strsep(&tok, ";"));
+
+	id_str =3D strsep(&dom_str, "=3D");
+
+	/* Check for domain id '*' which means all domains */
+	if (id_str && *id_str =3D=3D '*') {
+		ret =3D rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
+		if (ret)
+			rdt_last_cmd_printf("Assign operation '%s:*=3D%s' failed\n",
+					    event, dom_str);
+		return ret;
+	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing domain id\n");
+		return -EINVAL;
+	}
+
+	/* Verify if the dom_id is valid */
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id =3D=3D dom_id) {
+			ret =3D rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
+			if (ret) {
+				rdt_last_cmd_printf("Assign operation '%s:%ld=3D%s' failed\n",
+						    event, dom_id, dom_str);
+				return ret;
+			}
+			goto next;
+		}
+	}
+
+	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+	return -EINVAL;
+}
+
+ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdtgroup *rdtgrp;
+	char *token, *event;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] =3D '\0';
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
+		rdtgroup_kn_unlock(of->kn);
+		return -EINVAL;
+	}
+
+	while ((token =3D strsep(&buf, "\n")) !=3D NULL) {
+		/*
+		 * The write command follows the following format:
+		 * "<Event>:<Domain ID>=3D<Assignment state>"
+		 * Extract the event name first.
+		 */
+		event =3D strsep(&token, ":");
+
+		ret =3D resctrl_parse_mbm_assignment(r, rdtgrp, event, token);
+		if (ret)
+			break;
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 519aa6a..bd4a115 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1939,9 +1939,10 @@ static struct rftype res_common_files[] =3D {
 	},
 	{
 		.name		=3D "mbm_L3_assignments",
-		.mode		=3D 0444,
+		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D mbm_L3_assignments_show,
+		.write		=3D mbm_L3_assignments_write,
 	},
 	{
 		.name		=3D "mbm_assign_mode",

