Return-Path: <linux-tip-commits+bounces-7465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8498C7D368
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A8DD34EC2F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B6296BC4;
	Sat, 22 Nov 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M6clIqno";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xeCt9AhE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D527603A;
	Sat, 22 Nov 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826520; cv=none; b=TFvAMIZxxaAKfMbD2TZ+MKaM/ST7szjxR6OYrQ6160q+sRoyMLHFEQaLsiM3Uz8UEhLU2qmeIKT3Q4QARZl3AdvVrtl+QmKGjWluCAAdpEDTcylIp+FEdYdwwgAYAUupsBcdZnG+sgHQ7tZNr9VI1HhsrhSFE3YYceL0CqaxGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826520; c=relaxed/simple;
	bh=sNcY1SaaocwdDUTT3WfQz3lYr2huC/ajCczEMQW8zuU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=We7g0CrPgHb8BME9VD0frr03sbEjJvtjUFhMI6FkuD/D5a0d5X0gmKXNVlabbUr2J2J3dEVTpIGUUn3OSrSbRq6JTgmcQbqwqB7kavxM+5TYlQ7ZAT06BlrzoxWrDuVJuYfXEX1QHys4zfne0ADR63l+gblpyg9+9eYtkWvBiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M6clIqno; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xeCt9AhE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yI13rcSCzupyPuolTD/uJZWtCH+4dHPWkxiP8ChceU=;
	b=M6clIqnoXHvuvScLmhu/itReRlmPAK3jhaxoK53mugsJAHJNVxFtNupotei7syAA9SgDR2
	l9SkTm0kXMToY0kIvt9dJAKtRnfpRxO+1KQY5ZbXNlkNHaMfbKIEXJPHZOPfAIu5tiTwFC
	oYvOArm6H4+ekvc3QYsLtcZ6rXP6bc4vMgqHD207QD/zNmNe9AOgwBxuD8GrRUiVgLJOpo
	3TcCVsVQ0WwTYPFqcAMAL35xs1N4vXPpmrPnluh1mmv8XXrxznVOm8PL82qqS+KrUcMDW2
	YxtHngBt+Rqavucrh0g6KpxrR4+IaUSr7qE9tVqMKEbO2+W0irC25gcTcTLp8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yI13rcSCzupyPuolTD/uJZWtCH+4dHPWkxiP8ChceU=;
	b=xeCt9AhEHzb1RnHuW3EIg/4Nwhhol1EEkstH6s5TWYqabb8Yx669Xdf4OiTzc+TSj1KMGP
	94N5QgalCwn6UECQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] fs/resctrl: Introduce interface to display io_alloc CBMs
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <55a3ff66a70e7ce8239f022e62b334e9d64af604.1762995456.git.babu.moger@amd.com>
References:
 <55a3ff66a70e7ce8239f022e62b334e9d64af604.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651593.498.17898036111535286825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     77b662326200135fe72cedc47fb1b0e5679d604d
Gitweb:        https://git.kernel.org/tip/77b662326200135fe72cedc47fb1b0e5679=
d604d
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:33 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Nov 2025 11:37:21 +01:00

fs/resctrl: Introduce interface to display io_alloc CBMs

Introduce the "io_alloc_cbm" resctrl file to display the capacity bitmasks
(CBMs) that represent the portions of each cache instance allocated
for I/O traffic on a cache resource that supports the "io_alloc" feature.

io_alloc_cbm resides in the info directory of a cache resource, for example,
/sys/fs/resctrl/info/L3/. Since the resource name is part of the path, it
is not necessary to display the resource name as done in the schemata file.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with the CDP_CODE resource and that CLOSID becomes unusable for
the CDP_DATA resource. The highest CLOSID of CDP_CODE and CDP_DATA resources
will be kept in sync to ensure consistent user interface. In preparation for
this, access the CBMs for I/O traffic through highest CLOSID of either
CDP_CODE or CDP_DATA resource.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/55a3ff66a70e7ce8239f022e62b334e9d64af604.17629=
95456.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 19 +++++++++++-
 fs/resctrl/ctrlmondata.c              | 45 ++++++++++++++++++++++++--
 fs/resctrl/internal.h                 |  2 +-
 fs/resctrl/rdtgroup.c                 | 11 +++++-
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 91c71e2..e799453 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -182,6 +182,25 @@ related to allocation:
 		available for general (CPU) cache allocation for both the CDP_CODE
 		and CDP_DATA resources.
=20
+"io_alloc_cbm":
+		Capacity bitmasks that describe the portions of cache instances to
+		which I/O traffic from supported I/O devices are routed when "io_alloc"
+		is enabled.
+
+		CBMs are displayed in the following format:
+
+			<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=3Dffff;1=3Dffff
+
+		When CDP is enabled "io_alloc_cbm" associated with the CDP_DATA and CDP_CO=
DE
+		resources may reflect the same values. For example, values read from and
+		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
+		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
=20
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 454fdf3..1ac89b1 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -381,7 +381,8 @@ out:
 	return ret ?: nbytes;
 }
=20
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int=
 closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema,
+		      char *resource_name, int closid)
 {
 	struct rdt_resource *r =3D schema->res;
 	struct rdt_ctrl_domain *dom;
@@ -391,7 +392,8 @@ static void show_doms(struct seq_file *s, struct resctrl_=
schema *schema, int clo
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
=20
-	seq_printf(s, "%*s:", max_name_width, schema->name);
+	if (resource_name)
+		seq_printf(s, "%*s:", max_name_width, resource_name);
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
@@ -437,7 +439,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			closid =3D rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
 				if (closid < schema->num_closid)
-					show_doms(s, schema, closid);
+					show_doms(s, schema, schema->name, closid);
 			}
 		}
 	} else {
@@ -823,3 +825,40 @@ out_unlock:
=20
 	return ret ?: nbytes;
 }
+
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *=
seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+	int ret =3D 0;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret =3D -ENODEV;
+		goto out_unlock;
+	}
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * When CDP is enabled, the CBMs of the highest CLOSID of CDP_CODE and
+	 * CDP_DATA are kept in sync. As a result, the io_alloc CBMs shown for
+	 * either CDP resource are identical and accurately represent the CBMs
+	 * used for I/O.
+	 */
+	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 145e22f..779a575 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -438,6 +438,8 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *o=
f, char *buf,
 			       size_t nbytes, loff_t off);
=20
 const char *rdtgroup_name_by_closid(u32 closid);
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *=
seq,
+			      void *v);
=20
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9f9bd31..ac326db 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1972,6 +1972,12 @@ static struct rftype res_common_files[] =3D {
 		.write          =3D resctrl_io_alloc_write,
 	},
 	{
+		.name		=3D "io_alloc_cbm",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_io_alloc_cbm_show,
+	},
+	{
 		.name		=3D "max_threshold_occupancy",
 		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
@@ -2171,9 +2177,12 @@ static void io_alloc_init(void)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
-	if (r->cache.io_alloc_capable)
+	if (r->cache.io_alloc_capable) {
 		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("io_alloc_cbm",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
+	}
 }
=20
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)

