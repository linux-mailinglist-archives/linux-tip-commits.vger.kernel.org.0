Return-Path: <linux-tip-commits+bounces-7467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82AC7D356
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3CD3AA425
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236B2C0298;
	Sat, 22 Nov 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnZOoixd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LePeukLf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1E29A309;
	Sat, 22 Nov 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826523; cv=none; b=gXdDK1mxJr4DDv0vbNZMX4Vn9dr0mtwItcjOIyR/tjxnx0fS+ac+/YQg+Fi/SRvS2uUvkeP3LpnC5EjlOrb3RPgS6Ypc6X2KeXNRxi5gJbK1AEE0U6dKLmns5qq6I3iIv/f1lOVI0hwdcSUbgWPdyGdwNbq+Dc43+71j17j4uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826523; c=relaxed/simple;
	bh=3c3mt/b7mME6R4fJ9QF2dKoWOLWcJtNejdXJSxqvObg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BS8nWlEc/hENlp/7oHCX0V85TwX3zb8NsDogF+UIX1B+7XeDzgf3Y7MKL2wLQUdnvTPksAWtF8zBqRORy1JWIQ5MIe+dZwMj5s4jzPUKCtaBerPedGMuFkn7zbSHOh/MMzFPfc1k+VErBmbD1k2lbmApGEc0yJD6Ik5ZyiXIP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnZOoixd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LePeukLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5+7tNSbCSP8SrvlBiLx2HRFMCUL2CnYuyQopEYvydk=;
	b=tnZOoixdwN9FhwAIMF55BWuJyo8RvqZiOyAoc7MCwR3l3oBZnZtK1/LllBJqlSvNM6ZX24
	twprGl9gBYggyBK99EsEtoM5hKVJ7ZxRIabNvE0JAV/QCmkh8J9MeVH6+5tJLiRto3iGF/
	XLPNY/s1d2hLmLXSfA+suEeL61y8WC28Za/xE4I8o/EEzgap1CvGDpJb20nuK0x66ZuKwA
	ERttnzaalxpvD8MJbPG1n1Zk5+oUkMP0U/UU3XHx2fzSbwNqZwJ7quEJ1eK86CF4IH3IKz
	BNHCmwT1iwPejF95mOF+Qor+VFvAj7lUJItWQpOvlm+TxMi69zzg2rg3tCM31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5+7tNSbCSP8SrvlBiLx2HRFMCUL2CnYuyQopEYvydk=;
	b=LePeukLfrQA9X/1SCs1Qe3InScFxi9RyketN1WDK1acejFPyQCNnJ/EfkBsOLhaTRIBrZy
	rqJr7frhd14DVnAw==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce interface to display
 "io_alloc" support
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e8b116a8f424128b227734bb1d433c14af478d90.1762995456.git.babu.moger@amd.com>
References:
 <e8b116a8f424128b227734bb1d433c14af478d90.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651808.498.7055758162897751165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     48068e565045ee0c77fdb34225ac6dedb5871fc2
Gitweb:        https://git.kernel.org/tip/48068e565045ee0c77fdb34225ac6dedb58=
71fc2
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:31 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 22:49:42 +01:00

fs/resctrl: Introduce interface to display "io_alloc" support

Introduce the "io_alloc" resctrl file to the "info" area of a cache resource,
for example /sys/fs/resctrl/info/L3/io_alloc. "io_alloc" indicates support for
the "io_alloc" feature that allows direct insertion of data from I/O
devices into the cache.

Restrict exposing support for "io_alloc" to the L3 resource that is the only
resource where this feature can be backed by AMD's L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE). With that, the "io_alloc" file is
only visible to user space if the L3 resource supports "io_alloc".

Doing so makes the file visible for all cache resources though, for example
also L2 cache (if it supports cache allocation). As a consequence, add
capability for file to report expected "enabled" and "disabled", as well as
"not supported".

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/e8b116a8f424128b227734bb1d433c14af478d90.17629=
95456.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 15 +++++++++++++++
 fs/resctrl/ctrlmondata.c              | 21 +++++++++++++++++++++
 fs/resctrl/internal.h                 |  1 +
 fs/resctrl/rdtgroup.c                 | 22 ++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index d7a51ca..1089956 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -137,6 +137,21 @@ related to allocation:
 			"1":
 			      Non-contiguous 1s value in CBM is supported.
=20
+"io_alloc":
+		"io_alloc" enables system software to configure the portion of
+		the cache allocated for I/O traffic. File may only exist if the
+		system supports this feature on some of its cache resources.
+
+			"disabled":
+			      Resource supports "io_alloc" but the feature is disabled.
+			      Portions of cache used for allocation of I/O traffic cannot
+			      be configured.
+			"enabled":
+			      Portions of cache used for allocation of I/O traffic
+			      can be configured using "io_alloc_cbm".
+			"not supported":
+			      Support not available for this resource.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
=20
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54..78a8e7b 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -676,3 +676,24 @@ out:
 	rdtgroup_kn_unlock(of->kn);
 	return ret;
 }
+
+int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,=
 void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->cache.io_alloc_capable) {
+		if (resctrl_arch_get_io_alloc_enabled(r))
+			seq_puts(seq, "enabled\n");
+		else
+			seq_puts(seq, "disabled\n");
+	} else {
+		seq_puts(seq, "not supported\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index cf1fd82..a18ed88 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -426,6 +426,7 @@ int mbm_L3_assignments_show(struct kernfs_open_file *of, =
struct seq_file *s, voi
=20
 ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, siz=
e_t nbytes,
 				 loff_t off);
+int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,=
 void *v);
=20
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 41ce4b3..c1a603b 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1948,6 +1948,12 @@ static struct rftype res_common_files[] =3D {
 		.seq_show	=3D rdt_thread_throttle_mode_show,
 	},
 	{
+		.name		=3D "io_alloc",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_io_alloc_show,
+	},
+	{
 		.name		=3D "max_threshold_occupancy",
 		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
@@ -2138,6 +2144,20 @@ static void thread_throttle_mode_init(void)
 				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 }
=20
+/*
+ * The resctrl file "io_alloc" is added using L3 resource. However, it resul=
ts
+ * in this file being visible for *all* cache resources (eg. L2 cache),
+ * whether it supports "io_alloc" or not.
+ */
+static void io_alloc_init(void)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (r->cache.io_alloc_capable)
+		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
+					 RFTYPE_RES_CACHE);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4409,6 +4429,8 @@ int resctrl_init(void)
=20
 	thread_throttle_mode_init();
=20
+	io_alloc_init();
+
 	ret =3D resctrl_mon_resource_init();
 	if (ret)
 		return ret;

