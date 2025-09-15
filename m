Return-Path: <linux-tip-commits+bounces-6622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2BB57845
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71421A25E4E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E93054DD;
	Mon, 15 Sep 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mN4HJpzE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UhhNJPq6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BF2FE59F;
	Mon, 15 Sep 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935667; cv=none; b=mwpefXkJpHyut+d3jaIE7G32GNjus3ywmnpJm952H3fHAHuUPe7L0mRWK+3C6U2hemFXpHFcYPUVk/ZdHCZshkFs8+86TpKsXudc5pepgMn63ZhvJ7+fnXk4XTi5ChLGvES/QfnuXVXXbU8dpfydMEMYkArwWdECD/W1papNW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935667; c=relaxed/simple;
	bh=rvdocw3ESSyq7DkdlrPN9ew4AmFsIYJznpowTfBri2o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xz1XXEQGLXluIBrwaIiur+mANQjgQYpOJn4iC7XqHtQm8TZKkOnvMQ5wy0SuZM8KzdvOkv6XcNC5jvIQ1Nt6pMYR2mpPutw/RiULxLeE9VbOyvPGxXhoUG8PuhQ5fk0Ou8516x7q6udQWcAaymjqqLyFmGFnDNgSQ5bnBE0pg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mN4HJpzE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UhhNJPq6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XC+a1ILye5ke2pBFGz4XAozu4aNOg2eiZdTc0oA7t7s=;
	b=mN4HJpzEZlc27CI+DrKQfC2526WFaQlKhbD2R4SmhGVxLR7BVOVKIQ1KQcolpT3DdbO2Ro
	id0hb56L+bHMpx/Itb9eVvjQMKXJ71ET6p8y9onYEGncdz1SffOuC0VU7oWVz66caoEHJ4
	Lr/A5dw9LBq59fBi8l7ioaFFNILPolT5FJ136/VnTV+kTF2bnBbB9tEIz8S0G5i/Y6cPvw
	IU5O17pjpkAClFVRxmY00MjLw5dNafMjF6JVrnbso+WR0RX+8lmkyL17XAaIGVJuESanK8
	3ztD1IGd5lg8ehV4duzCxovAF+axR5NymSL/eoYz5Wr45vrU7xbILndxxk7U3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XC+a1ILye5ke2pBFGz4XAozu4aNOg2eiZdTc0oA7t7s=;
	b=UhhNJPq6YmqWpSOQfoExt0l68hwcmE2MGFcQZSD7zc12bV0DW8KOtht034FMbdOt4PwTTh
	yAVbkzwl+sGO+YCg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce interface to display number of
 free MBM counters
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <346cf41a45abc2091ce188a098aa61838a12cc22.1757108044.git.babu.moger@amd.com>
References:
 <346cf41a45abc2091ce188a098aa61838a12cc22.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566237.709179.1847450032640035995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     16ff6b038fb3b64aa033efdc95d673239610e1a6
Gitweb:        https://git.kernel.org/tip/16ff6b038fb3b64aa033efdc95d67323961=
0e1a6
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:12 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:16:11 +02:00

fs/resctrl: Introduce interface to display number of free MBM counters

Introduce the "available_mbm_cntrs" resctrl file to display the number of
counters available for assignment in each domain when "mbm_event" mode is
enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 11 +++++++-
 fs/resctrl/internal.h                 |  3 ++-
 fs/resctrl/monitor.c                  | 44 ++++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |  6 ++++-
 4 files changed, 64 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 4eb2753..446736d 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -299,6 +299,17 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
 	  0=3D32;1=3D32
=20
+"available_mbm_cntrs":
+	The number of counters available for assignment in each domain when mbm_eve=
nt
+	mode is enabled on the system.
+
+	For example, on a system with 30 available [hardware] assignable counters
+	in each of its L3 domains:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
+	  0=3D30;1=3D30
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 7a12187..4f372e8 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -388,6 +388,9 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_file =
*of, struct seq_file *s
=20
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file =
*s, void *v);
=20
+int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq=
_file *s,
+				     void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 112979e..1fa82a6 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -936,6 +936,48 @@ int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *=
of,
 	return 0;
 }
=20
+int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
+				     struct seq_file *s, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *dom;
+	bool sep =3D false;
+	u32 cntrs, i;
+	int ret =3D 0;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_putc(s, ';');
+
+		cntrs =3D 0;
+		for (i =3D 0; i < r->mon.num_mbm_cntrs; i++) {
+			if (!dom->cntr_cfg[i].rdtgrp)
+				cntrs++;
+		}
+
+		seq_printf(s, "%d=3D%u", dom->hdr.id, cntrs);
+		sep =3D true;
+	}
+	seq_putc(s, '\n');
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -983,6 +1025,8 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("available_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 61f7b68..2e1d0a2 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1823,6 +1823,12 @@ static struct rftype res_common_files[] =3D {
 		.fflags		=3D RFTYPE_MON_INFO,
 	},
 	{
+		.name		=3D "available_mbm_cntrs",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_available_mbm_cntrs_show,
+	},
+	{
 		.name		=3D "num_rmids",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,

