Return-Path: <linux-tip-commits+bounces-6607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8FB57811
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B46A17073F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252092FF149;
	Mon, 15 Sep 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDl//hJY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1ob1Vpa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7962FC871;
	Mon, 15 Sep 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935650; cv=none; b=qXZILSknyospVWUpR1W2kZd8/MGAneqWZ00jO46ux1GWyzFHGSQlhUxwNIRea7+6/s1OT3buE4lL8nQJrzp4ieyhuxcHFxXtwYO5SC7Z9LGr82A6wX29l4pgYN9iqpsjXC1CGs3+1D24FtsX92yuCpOLzyrNSaqspow1LYZ/rRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935650; c=relaxed/simple;
	bh=yReWwhrELVA71dhKSy1AemEWPKIj5SvubhIcwdHNh8E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dx1Sh4AGuNQignRXrfoYcnBbxF6EoAgPlF5nry26LWoRAIVSMcrwZfMuUIlXENXvGAepV7OJP3MEfA6J8SAtA8XLgQA5lQz+PgqAV6NtpV97VRt7DOd4tjjOTDsAtYxbjZiGDc4DNg3Uv2FwFkUQq2icoSClVdFy638mtSOK0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDl//hJY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1ob1Vpa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U68cdXJAuFPZ9LfFdVn/2hx42iBjZlCLf5Ihd2iN8q4=;
	b=vDl//hJY/ZFadgJuw05GTODZk2RUjrG7BHaQYucaANL9HS48UZNIJiiOefPMJMFU8IRunQ
	R5roJ7YBWOsAxpkBWR8NUPahUZm1aB1tlrGXLEqdRxwWgmpndr+QYGeqWCl5eNP4NZ/mWT
	8ssx3dqBpW8oQqbkohlFpdSQxcvplz5xlRQgt6vrtKNG/Yn0QspkZhd3dR4oEHkEOqTQ3+
	HHNkk3VQizzdd6CKlzsAdzf5yTJ3H8/FuAOKm9jj2A14a8RpSoskd+Ozsch0LTihLgI5ca
	sK4n/6YI8lJEpNTxmB+ORVLsAPaFZqnX/MNMLqfydVJiCW5IDmGZkzPErRSmkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U68cdXJAuFPZ9LfFdVn/2hx42iBjZlCLf5Ihd2iN8q4=;
	b=A1ob1VpafMpmMrAcBOmPGvU0MSQ5gpaU2pHVe8PrJd5l/52lWpj/erijrLxDHRCsYRvZEJ
	s7sBCA1+1VaHl+Bg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce mbm_L3_assignments to list
 assignments in a group
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <fdcb23bc9061a9e1b8d99e922b234c02db561ff1.1757108044.git.babu.moger@amd.com>
References:
 <fdcb23bc9061a9e1b8d99e922b234c02db561ff1.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564532.709179.12752119155462957544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     cba8222880b88d96f3ed6c8a115e335e552b83a1
Gitweb:        https://git.kernel.org/tip/cba8222880b88d96f3ed6c8a115e335e552=
b83a1
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:27 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:45:34 +02:00

fs/resctrl: Introduce mbm_L3_assignments to list assignments in a group

Introduce the mbm_L3_assignments resctrl file associated with CTRL_MON and MON
resource groups to display the counter assignment states of the resource group
when "mbm_event" counter assignment mode is enabled.

Display the list in the following format:
<Event>:<Domain id>=3D<Assignment state>;<Domain id>=3D<Assignment state>

Event: A valid MBM event listed in
      /sys/fs/resctrl/info/L3_MON/event_configs directory.

Domain ID: A valid domain ID.

The assignment state can be one of the following:

_ : No counter assigned.

e : Counter assigned exclusively.

Example:
To list the assignment states for the default group
  $ cd /sys/fs/resctrl
  $ cat /sys/fs/resctrl/mbm_L3_assignments
  mbm_total_bytes:0=3De;1=3De
  mbm_local_bytes:0=3De;1=3De

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 31 ++++++++++++++++-
 fs/resctrl/internal.h                 |  2 +-
 fs/resctrl/monitor.c                  | 49 ++++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |  6 +++-
 4 files changed, 88 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 1de815b..a2b7240 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -509,6 +509,37 @@ When monitoring is enabled all MON groups will also cont=
ain:
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
=20
+When monitoring is enabled all MON groups may also contain:
+
+"mbm_L3_assignments":
+	Exists when "mbm_event" counter assignment mode is supported and lists the
+	counter assignment states of the group.
+
+	The assignment list is displayed in the following format:
+
+	<Event>:<Domain ID>=3D<Assignment state>;<Domain ID>=3D<Assignment state>
+
+	Event: A valid MBM event in the
+	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
+
+	Domain ID: A valid domain ID.
+
+	Assignment states:
+
+	_ : No counter assigned.
+
+	e : Counter assigned exclusively.
+
+	Example:
+
+	To display the counter assignment states for the default group.
+	::
+
+	 # cd /sys/fs/resctrl
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=3De;1=3De
+	   mbm_local_bytes:0=3De;1=3De
+
 When the "mba_MBps" mount option is used all CTRL_MON groups will also conta=
in:
=20
 "mba_MBps_event":
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 66c677c..43297b3 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -416,6 +416,8 @@ int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_f=
ile *of,
 ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char =
*buf,
 					  size_t nbytes, loff_t off);
=20
+int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s,=
 void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9cb3341..b692a0e 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1454,6 +1454,54 @@ out_unlock:
 	return ret;
 }
=20
+int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s,=
 void *v)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	struct mon_evt *mevt;
+	int ret =3D 0;
+	bool sep;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret =3D -ENOENT;
+		goto out_unlock;
+	}
+
+	rdt_last_cmd_clear();
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid !=3D r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt-=
>evtid))
+			continue;
+
+		sep =3D false;
+		seq_printf(s, "%s:", mevt->name);
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (sep)
+				seq_putc(s, ';');
+
+			if (mbm_cntr_get(r, d, rdtgrp, mevt->evtid) < 0)
+				seq_printf(s, "%d=3D_", d->hdr.id);
+			else
+				seq_printf(s, "%d=3De", d->hdr.id);
+
+			sep =3D true;
+		}
+		seq_putc(s, '\n');
+	}
+
+out_unlock:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1512,6 +1560,7 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
 	}
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 48f9814..519aa6a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1938,6 +1938,12 @@ static struct rftype res_common_files[] =3D {
 		.write		=3D event_filter_write,
 	},
 	{
+		.name		=3D "mbm_L3_assignments",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D mbm_L3_assignments_show,
+	},
+	{
 		.name		=3D "mbm_assign_mode",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,

