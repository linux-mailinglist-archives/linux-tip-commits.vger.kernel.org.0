Return-Path: <linux-tip-commits+bounces-6608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95EB57814
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0951A252A8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681682FFDDD;
	Mon, 15 Sep 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrNyzkJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVDl3v5Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907D2FF16D;
	Mon, 15 Sep 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935652; cv=none; b=t6V63TY5vitgiC1QRF/UlWs/r3pAzBbyry7t49u2+i7vjG1WplB7w8NMQEnDstkABLiOhF6PQgm/8AWy0jm30hAbdwLKL/w14xXaGMM2ka81jj+m2GY8/UBQmpTe89QPzGnbRObUnJ1Mld4IOUwFgFQaPDYcqoauIPy/58qERDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935652; c=relaxed/simple;
	bh=MpG1DCGKkRWq75BPIydi4h+ebLjDP/fE8X48oa4tSKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TdQYo7vL3zZ81Zm89lJqpenrNtRc3E6rGded0epT0ghW/wcZx1X3Di5aRS2vJDnbqtjuoNN1yz0pZjwo3Fl5DZy+oTKKk+Klvdy3991POF1WnmePmvXWdclzaCbBLEs5LAHAwjKVAXbQ/k12Fa5RsLf6oC3GL/2yuTmrT3y34WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrNyzkJh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVDl3v5Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaqyYysfAKLT+KJPS4ckhsahu0/fp5FBf9nCvwGdlXM=;
	b=FrNyzkJhMFLa7hvETTLLcySVyoKrdYqiKBGFPi/0ctiH1qsI/EWUhKf7DrI2DDS+b9UbEa
	7IxbPUo12Ma9cvYkP77/nn+kzWE/gGquUJXU2aRYlUkqNStgr+gpSBva0fS4VoXTORCig3
	dF3Gn9wMKubaTGkU6StOZbutB4f2H1CkQ5tfXCbr43JJKUVoG4nByHaJl2zrL9scHzSFxy
	XJrlzEV9BaYcVNw0PTPP/d3fH02oNeb1b1qp/NGvPcVME7MYk20ibUq3TTgdVZbN3d2NLC
	eaCvQhuHjgUh10DvB9snI6HkaK7nhhGDrAqIjrxpTjHDScxHNqeNl0XBiIrrUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaqyYysfAKLT+KJPS4ckhsahu0/fp5FBf9nCvwGdlXM=;
	b=OVDl3v5YVJzt2hxkbIGKF3h1xltisfIsYJP3yNO2vg+umPg1cO5jRw+Zh5q/r+l8SAIIkg
	fJb2XxwNt2PAcbDQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce mbm_assign_on_mkdir to enable
 assignments on mkdir
Cc: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <3b73498a18ddd94b0c6ab5568a23ec42b62af52a.1757108044.git.babu.moger@amd.com>
References:
 <3b73498a18ddd94b0c6ab5568a23ec42b62af52a.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564768.709179.535972769252007231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ac1df9bb0ba3ae94137fb494cd9efc598f65d826
Gitweb:        https://git.kernel.org/tip/ac1df9bb0ba3ae94137fb494cd9efc598f6=
5d826
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:25 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:42:02 +02:00

fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on mkdir

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned.

Introduce a user-configurable option that determines if a counter will
automatically be assigned to an RMID, event pair when its associated
monitor group is created via mkdir. Accessible when "mbm_event" counter
assignment mode is enabled.

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 20 ++++++++++-
 fs/resctrl/internal.h                 |  6 +++-
 fs/resctrl/monitor.c                  | 53 ++++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |  7 +++-
 include/linux/resctrl.h               |  3 +-
 5 files changed, 89 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 2e840ef..1de815b 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -355,6 +355,26 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_fil=
ter
 	   local_reads,local_non_temporal_writes
=20
+"mbm_assign_on_mkdir":
+	Exists when "mbm_event" counter assignment mode is supported. Accessible
+	only when "mbm_event" counter assignment mode is enabled.
+
+	Determines if a counter will automatically be assigned to an RMID, MBM event
+	pair when its associated monitor group is created via mkdir. Enabled by def=
ault
+	on boot, also when switched from "default" mode to "mbm_event" counter assi=
gnment
+	mode. Users can disable this capability by writing to the interface.
+
+	"0":
+		Auto assignment is disabled.
+	"1":
+		Auto assignment is enabled.
+
+	Example::
+
+	  # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  0
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 90d3e4a..66c677c 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -410,6 +410,12 @@ int event_filter_show(struct kernfs_open_file *of, struc=
t seq_file *seq, void *v
 ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nb=
ytes,
 			   loff_t off);
=20
+int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
+				     struct seq_file *s, void *v);
+
+ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char =
*buf,
+					  size_t nbytes, loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index ccb9726..deca953 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1027,6 +1027,57 @@ out_unlock:
 	return ret;
 }
=20
+int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of, struct seq=
_file *s,
+				     void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	int ret =3D 0;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+
+ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char =
*buf,
+					  size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	bool value;
+	int ret;
+
+	ret =3D kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	r->mon.mbm_assign_on_mkdir =3D value;
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret ?: nbytes;
+}
+
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RM=
ID
  * pair in the domain.
@@ -1457,6 +1508,8 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
+		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
+					 RFTYPE_RES_CACHE);
 	}
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index e90bc80..c7ea42c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1809,6 +1809,13 @@ static struct rftype res_common_files[] =3D {
 		.fflags		=3D RFTYPE_TOP_INFO,
 	},
 	{
+		.name		=3D "mbm_assign_on_mkdir",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_mbm_assign_on_mkdir_show,
+		.write		=3D resctrl_mbm_assign_on_mkdir_write,
+	},
+	{
 		.name		=3D "num_closids",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0415265..a7d9271 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -277,12 +277,15 @@ enum resctrl_schema_fmt {
  *			monitoring events can be configured.
  * @num_mbm_cntrs:	Number of assignable counters.
  * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
+ * @mbm_assign_on_mkdir:True if counters should automatically be assigned to=
 MBM
+ *			events of monitor groups created via mkdir.
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
+	bool			mbm_assign_on_mkdir;
 };
=20
 /**

