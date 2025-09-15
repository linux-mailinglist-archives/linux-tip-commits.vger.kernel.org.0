Return-Path: <linux-tip-commits+bounces-6605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E5B5780D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E227D16E317
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444302FE05F;
	Mon, 15 Sep 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuTqP9+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Cu8ku0+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AF21FF48;
	Mon, 15 Sep 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935648; cv=none; b=R9EPtkCTK+p+KQRV7mqp3WJiu9PdnHgwOPL/FVofHE6uNEqwpZcCUhtJeG04r6j/NEGcrA7jWdjV9EfzagXQh1x3i5pXyL1394SYZXKn4nJciLo1eadRXsfV7U88Qt0mTIjR9QX/AjU1i8efpCvu79k9nsQN2khCeOVWPqiUgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935648; c=relaxed/simple;
	bh=fsERUsbJ8/FfcQ5G7HbwxRQoktS3qp0JtQFCCxHJPvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WRAAWSH3zG1HeikkrxCg6JzgKm7Y78fGmlRYPCJnY3wNvraYA/nkZ/wvg/HyR9pUG5l6pbO8/CQxEyFkZKJoMLAfhTmloA3OZrBOooiJ5Yh/HRaQS2OlCmHESl3zZ0rj38HBanHbf4Mir0uEyesHfhbkNBjonNez5/MkIL2inXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KuTqP9+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Cu8ku0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFfHEgKu6QhiRGbO9yNlkX8DPOpD7nn4URkmdJ41350=;
	b=KuTqP9+MjBNJaBJ4Y4VmfVj8gBLNyWNEVpsSlmtH2J1qbWklEiRSSbfEbqrEXG4sdTWi+O
	Vp9rJnYovhbB4D87Jx6k/zbI8KpyRw9uy3hSdEDZbGEmq7g6BqiYAyzUZoHZiI2MZ1zPP4
	SPwIIQCBvY5eFfMqcGuPd7kmhBhwrNDjJuRHBAUQpZpdoY129U+4G6giJE1ysOFIxykOhO
	BR2HunKIbYM8RFf2z1AcHbDDjVHfjyRG5Yu7C6yYfKeqnbyGPVNmLdoSp5BQCfu8lX4GWu
	Cz2s3rfikykXeUYJ/QD4QemBRV8IQnA8v+1SxI7gnNK3NL+9SeSlec/AZVsK+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFfHEgKu6QhiRGbO9yNlkX8DPOpD7nn4URkmdJ41350=;
	b=7Cu8ku0++UTVphYLv8Ljh0koJJYBM5UzAWN9G7zNLwpvBRsPmKRaMJ6IH7pSHfaxMHIZuR
	53HdPLrcVLLX4aCg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Disable BMEC event configuration when
 mbm_event mode is enabled
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <70cdd1e86129266844ebabafd9a31bb0a253b07d.1757108044.git.babu.moger@amd.com>
References:
 <70cdd1e86129266844ebabafd9a31bb0a253b07d.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793564294.709179.14093747429137836945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9f0209b857d2fc99c2a32bff1d7bfd54b314c29c
Gitweb:        https://git.kernel.org/tip/9f0209b857d2fc99c2a32bff1d7bfd54b31=
4c29c
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:29 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:48:19 +02:00

fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled

The BMEC (Bandwidth Monitoring Event Configuration) feature enables per-domain
event configuration. With BMEC the MBM events are configured using the
mbm_total_bytes_config or mbm_local_bytes_config files in

  /sys/fs/resctrl/info/L3_MON/

and the per-domain event configuration affects all monitor resource groups.

The mbm_event counter assignment mode enables counters to be assigned to RMID
(i.e. a monitor resource group), event pairs, with potentially unique event
configurations associated with every counter.

There may be systems that support both BMEC and mbm_event counter assignment
mode, but resctrl supporting both concurrently will present a conflicting
interface to the user with both per-domain and per RMID, event configurations
active at the same time.

The mbm_event counter assignment provides most flexibility to user space
and aligns with Arm's counter support. On systems that support both,
disable BMEC event configuration when mbm_event mode is enabled by hiding
the mbm_total_bytes_config or mbm_local_bytes_config files when mbm_event
mode is enabled. Ensure mon_features always displays accurate information
about monitor features.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/rdtgroup.c | 47 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bd4a115..0c404a1 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1150,7 +1150,8 @@ static int rdt_mon_features_show(struct kernfs_open_fil=
e *of,
 		if (mevt->rid !=3D r->rid || !mevt->enabled)
 			continue;
 		seq_printf(seq, "%s\n", mevt->name);
-		if (mevt->configurable)
+		if (mevt->configurable &&
+		    !resctrl_arch_mbm_cntr_assign_enabled(r))
 			seq_printf(seq, "%s_config\n", mevt->name);
 	}
=20
@@ -1799,6 +1800,44 @@ static ssize_t mbm_local_bytes_config_write(struct ker=
nfs_open_file *of,
 	return ret ?: nbytes;
 }
=20
+/*
+ * resctrl_bmec_files_show() =E2=80=94 Controls the visibility of BMEC-relat=
ed resctrl
+ * files. When @show is true, the files are displayed; when false, the files
+ * are hidden.
+ * Don't treat kernfs_find_and_get failure as an error, since this function =
may
+ * be called regardless of whether BMEC is supported or the event is enabled.
+ */
+static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_no=
de *l3_mon_kn,
+				    bool show)
+{
+	struct kernfs_node *kn_config, *mon_kn =3D NULL;
+	char name[32];
+
+	if (!l3_mon_kn) {
+		sprintf(name, "%s_MON", r->name);
+		mon_kn =3D kernfs_find_and_get(kn_info, name);
+		if (!mon_kn)
+			return;
+		l3_mon_kn =3D mon_kn;
+	}
+
+	kn_config =3D kernfs_find_and_get(l3_mon_kn, "mbm_total_bytes_config");
+	if (kn_config) {
+		kernfs_show(kn_config, show);
+		kernfs_put(kn_config);
+	}
+
+	kn_config =3D kernfs_find_and_get(l3_mon_kn, "mbm_local_bytes_config");
+	if (kn_config) {
+		kernfs_show(kn_config, show);
+		kernfs_put(kn_config);
+	}
+
+	/* Release the reference only if it was acquired */
+	if (mon_kn)
+		kernfs_put(mon_kn);
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] =3D {
 	{
@@ -2267,6 +2306,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char=
 *name,
 			ret =3D resctrl_mkdir_event_configs(r, kn_subdir);
 			if (ret)
 				return ret;
+			/*
+			 * Hide BMEC related files if mbm_event mode
+			 * is enabled.
+			 */
+			if (resctrl_arch_mbm_cntr_assign_enabled(r))
+				resctrl_bmec_files_show(r, kn_subdir, false);
 		}
 	}
=20

