Return-Path: <linux-tip-commits+bounces-7466-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB320C7D353
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C133AA04A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6629DB61;
	Sat, 22 Nov 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGleXu62";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFhX5OfE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34D279DA2;
	Sat, 22 Nov 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826522; cv=none; b=ZlCNMUHJflF/5nNuq9YPus6nPRzEKSYtsHxHTPdBl5MYAfd9YMFvfSR5lLTcp3gcUxjns6iie20+gSlPrMu91Y3vdACN0ZLp8l6yBIlIB/CibHD164yoIlSXjfPZl1puJqPmBWnwNjLfyxHLQnel1OKe6LcsmJGK0uabZ4eQjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826522; c=relaxed/simple;
	bh=tLWK9WJQ9qMHF/yQMRibGqPGzY95+a6O86UkL4rJKlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g3jwIea4TCvGd+/kYw0idum1E0UvHD1Tv2N3ttyhFFbLTrKLodo22Yd5B/Rf7ZnmenqSw5WcGvXs7lsUPG7j8SQ31F/uLQgPTE4wiPbkIVhkPupiWh+kFmL1Z6270UJi2ZHOQzroRaAW2d7jdhjJ6bqLua8AX7bKKs1zNRTDVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGleXu62; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFhX5OfE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kxqgSmmkTY5tSscUDFCh9Nr2yezeHf3AT2gghXKtKY=;
	b=QGleXu629n6p8SkddP7nFDQvF7tFoRZMQdo+Ln9klh89L9Zlajf+FaUkKAqcMCm6N+2O2w
	BHRyujPNl+2wVfRLgqzy5HdsvjP1C2tVe280R6G75fGi8KbtrFpAjnycB+69XTYG52Fazo
	PMh4IhsA6Rib3zp4vbOx1rYgQdpqnM3uPGtR6eYU7SU8oJ/JQfXTHOrOID/FyabMCoJU4m
	nwLsq2jNKXvK1sxpocixw6pI4Ny0UVYThXZIyCVA6zS68LiudStkvX0Fs90AFe/G6RCc2F
	gjOlVHZ1CrNMjtCeioURoC+BmvwUJed4s1TN+pkMpai+/SN8khKgu40e8Ig4JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kxqgSmmkTY5tSscUDFCh9Nr2yezeHf3AT2gghXKtKY=;
	b=kFhX5OfEQ0/vkfKM1o2PYTuJO38Pq/h5VUPjMizzFsJCY9v1i5VuRy403fSIkujb65wOat
	igdTiL93X+QYwMCg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c7d3037795e653e22b02d8fc73ca80d9b075031c.1762995456.git.babu.moger@amd.com>
References:
 <c7d3037795e653e22b02d8fc73ca80d9b075031c.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651699.498.7967616194319369474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9445c7059c1c3b097ec8e924eb374df84770bee5
Gitweb:        https://git.kernel.org/tip/9445c7059c1c3b097ec8e924eb374df8477=
0bee5
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:32 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 23:01:54 +01:00

fs/resctrl: Add user interface to enable/disable io_alloc feature

AMD's SDCIAE forces all SDCI lines to be placed into the L3 cache portions
identified by the highest-supported L3_MASK_n register, where n is the maximum
supported CLOSID.

To support this, when io_alloc resctrl feature is enabled, reserve the highest
CLOSID exclusively for I/O allocation traffic making it no longer available f=
or
general CPU cache allocation.

Introduce user interface to enable/disable io_alloc feature and encourage use=
rs
to enable io_alloc only when running workloads that can benefit from this
functionality. On enable, initialize the io_alloc CLOSID with all usable CBMs
across all the domains.

Since CLOSIDs are managed by resctrl fs, it is least invasive to make "io_all=
oc
is supported by maximum supported CLOSID" part of the initial resctrl fs
support for io_alloc. Take care to minimally (only in error messages) expose
this use of CLOSID for io_alloc to user space so that this is not required fr=
om
other architectures that may support io_alloc differently in the future.

When resctrl is mounted with "-o cdp" to enable code/data prioritization,
there are two L3 resources that can support I/O allocation: L3CODE and
L3DATA.  From resctrl fs perspective the two resources share a CLOSID and
the architecture's available CLOSID are halved to support this.

The architecture's underlying CLOSID used by SDCIAE when CDP is enabled is the
CLOSID associated with the CDP_CODE resource, but from resctrl's perspective
there is only one CLOSID for both CDP_CODE and CDP_DATA. CDP_DATA is thus not
usable for general (CPU) cache allocation nor I/O allocation.

Keep the CDP_CODE and CDP_DATA I/O alloc status in sync to avoid any confusion
to user space.  That is, enabling io_alloc on CDP_CODE does so on CDP_DATA and
vice-versa, and keep the I/O allocation CBMs of CDP_CODE and CDP_DATA in sync.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/c7d3037795e653e22b02d8fc73ca80d9b075031c.17629=
95456.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst |  30 ++++++-
 fs/resctrl/ctrlmondata.c              | 126 +++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |  11 ++-
 fs/resctrl/rdtgroup.c                 |  24 ++++-
 4 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 1089956..91c71e2 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -73,6 +73,11 @@ The 'info' directory contains information about the enabled
 resources. Each resource has its own subdirectory. The subdirectory
 names reflect the resource names.
=20
+Most of the files in the resource's subdirectory are read-only, and
+describe properties of the resource. Resources that support global
+configuration options also include writable files that can be used
+to modify those settings.
+
 Each subdirectory contains the following files with respect to
 allocation:
=20
@@ -152,6 +157,31 @@ related to allocation:
 			"not supported":
 			      Support not available for this resource.
=20
+		The feature can be modified by writing to the interface, for example:
+
+		To enable::
+
+			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
+
+		To disable::
+
+			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
+
+		The underlying implementation may reduce resources available to
+		general (CPU) cache allocation. See architecture specific notes
+		below. Depending on usage requirements the feature can be enabled
+		or disabled.
+
+		On AMD systems, io_alloc feature is supported by the L3 Smart
+		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
+		io_alloc is the highest CLOSID supported by the resource. When
+		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
+		no longer available for general (CPU) cache allocation. When CDP is
+		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
+		for the instruction cache (CDP_CODE), making this CLOSID no longer
+		available for general (CPU) cache allocation for both the CDP_CODE
+		and CDP_DATA resources.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
=20
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 78a8e7b..454fdf3 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -697,3 +697,129 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, =
struct seq_file *seq, voi
=20
 	return 0;
 }
+
+/*
+ * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
+ * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
+ * is in the supported range.
+ */
+static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
+{
+	return io_alloc_closid < closids_supported();
+}
+
+/*
+ * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
+ * and unused) cache portions.
+ */
+static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
+{
+	enum resctrl_conf_type peer_type;
+	struct rdt_resource *r =3D s->res;
+	struct rdt_ctrl_domain *d;
+	int ret;
+
+	rdt_staged_configs_clear();
+
+	ret =3D rdtgroup_init_cat(s, closid);
+	if (ret < 0)
+		goto out;
+
+	/* Keep CDP_CODE and CDP_DATA of io_alloc CLOSID's CBM in sync. */
+	if (resctrl_arch_get_cdp_enabled(r->rid)) {
+		peer_type =3D resctrl_peer_type(s->conf_type);
+		list_for_each_entry(d, &s->res->ctrl_domains, hdr.list)
+			memcpy(&d->staged_config[peer_type],
+			       &d->staged_config[s->conf_type],
+			       sizeof(d->staged_config[0]));
+	}
+
+	ret =3D resctrl_arch_update_domains(r, closid);
+out:
+	rdt_staged_configs_clear();
+	return ret;
+}
+
+/*
+ * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
+ * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
+ * resource. Note that if Code Data Prioritization (CDP) is enabled, the num=
ber
+ * of available CLOSIDs is reduced by half.
+ */
+static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+{
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		return resctrl_arch_get_num_closid(r) / 2  - 1;
+	else
+		return resctrl_arch_get_num_closid(r) - 1;
+}
+
+ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+	char const *grp_name;
+	u32 io_alloc_closid;
+	bool enable;
+	int ret;
+
+	ret =3D kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
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
+	/* If the feature is already up to date, no action is needed. */
+	if (resctrl_arch_get_io_alloc_enabled(r) =3D=3D enable)
+		goto out_unlock;
+
+	io_alloc_closid =3D resctrl_io_alloc_closid(r);
+	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
+		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %u is not available\n",
+				    io_alloc_closid);
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	if (enable) {
+		if (!closid_alloc_fixed(io_alloc_closid)) {
+			grp_name =3D rdtgroup_name_by_closid(io_alloc_closid);
+			WARN_ON_ONCE(!grp_name);
+			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %u for io_alloc is used by %s gr=
oup\n",
+					    io_alloc_closid, grp_name ? grp_name : "another");
+			ret =3D -ENOSPC;
+			goto out_unlock;
+		}
+
+		ret =3D resctrl_io_alloc_init_cbm(s, io_alloc_closid);
+		if (ret) {
+			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
+			closid_free(io_alloc_closid);
+			goto out_unlock;
+		}
+	} else {
+		closid_free(io_alloc_closid);
+	}
+
+	ret =3D resctrl_arch_io_alloc_enable(r, enable);
+	if (enable && ret) {
+		rdt_last_cmd_puts("Failed to enable io_alloc feature\n");
+		closid_free(io_alloc_closid);
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index a18ed88..145e22f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -390,6 +390,8 @@ void rdt_staged_configs_clear(void);
=20
 bool closid_allocated(unsigned int closid);
=20
+bool closid_alloc_fixed(u32 closid);
+
 int resctrl_find_cleanest_closid(void);
=20
 void *rdt_kn_parent_priv(struct kernfs_node *kn);
@@ -428,6 +430,15 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file=
 *of, char *buf, size_t=20
 				 loff_t off);
 int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,=
 void *v);
=20
+int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
+
+enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
+
+ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off);
+
+const char *rdtgroup_name_by_closid(u32 closid);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c1a603b..9f9bd31 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -226,6 +226,11 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, closid_free_map);
 }
=20
+bool closid_alloc_fixed(u32 closid)
+{
+	return __test_and_clear_bit(closid, closid_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1247,7 +1252,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *=
of,
 	return 0;
 }
=20
-static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_ty=
pe)
+enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 {
 	switch (my_type) {
 	case CDP_CODE:
@@ -1838,6 +1843,18 @@ void resctrl_bmec_files_show(struct rdt_resource *r, s=
truct kernfs_node *l3_mon_
 		kernfs_put(mon_kn);
 }
=20
+const char *rdtgroup_name_by_closid(u32 closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid =3D=3D closid)
+			return rdt_kn_name(rdtgrp->kn);
+	}
+
+	return NULL;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] =3D {
 	{
@@ -1949,9 +1966,10 @@ static struct rftype res_common_files[] =3D {
 	},
 	{
 		.name		=3D "io_alloc",
-		.mode		=3D 0444,
+		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D resctrl_io_alloc_show,
+		.write          =3D resctrl_io_alloc_write,
 	},
 	{
 		.name		=3D "max_threshold_occupancy",
@@ -3501,7 +3519,7 @@ static int __init_one_rdt_domain(struct rdt_ctrl_domain=
 *d, struct resctrl_schem
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
-static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
+int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
 	struct rdt_ctrl_domain *d;
 	int ret;

