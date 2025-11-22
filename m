Return-Path: <linux-tip-commits+bounces-7464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47766C7D34D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46E83A9E9C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5854202F9C;
	Sat, 22 Nov 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vyaLUC8y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNUg87IW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E593264614;
	Sat, 22 Nov 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826520; cv=none; b=DMcl8U1e4oUoEctmLNXJY8rzIG3yKbgzH46+92QzqSHna/igjP4VxZO/GMpK//pCg2pvCNErkZST2bWyXguCTvYOcrJ6rA2LCWH9U9a8RNoDIPqklFIkQiuZpVXF7ulbEY+qEdAAEnmIFOFINQpwHD5KeQfdwED6OLmqgeMqmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826520; c=relaxed/simple;
	bh=nTmDC+h7btFXniGxyGjLRnPykzRQZ9UHg1LcMvK8oRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gDnnP3UNdOORvvb5g5HnResDTssl+9qoeRXSDWzt9186GQStE6QXp5pD5MKgUsDWyZyd3nrCuNnLDMKSGbkkVqdxCidbR+FJI6hftFUbCLSUwWbVWzICpa7vo+JS5pixkHx/xetAAR0IY+xzZXknJGfFsWenuanSUbfcLH/slLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vyaLUC8y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNUg87IW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTagcREjhf04j100W5y9H9T5WtMIJ3FJP3R+akMxaQs=;
	b=vyaLUC8ylHoKwmMHD+sXmIRwR9j9BmmIWhO2ciUn3EfekO9g7vtjsxeaXYgH1VzwwYKMhh
	ZT6e/x1LH7x5fk0+XA5TTLR/9yEyTXViVlaW8tduXioh300fqcrJIXFYvIJQFC3IIsPtIt
	+kd7bx4FrlJ+mEIMEQKnbfbzykSqjEveNMQNM/V8mKPHyau6wB83Euxq/l61yu/h3jun3T
	g/TBORGwpufCCD5P179JBwbq8yoGWAjiSaEZKgcJxXw0FA7xhQgaEAQGowtWho71svD4Lw
	LLVXub9bK/YLmc7Lfm4rZSpCG4kyhuXlxMWy0gnM6PGrvBr3eapyBHoVntFF6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTagcREjhf04j100W5y9H9T5WtMIJ3FJP3R+akMxaQs=;
	b=rNUg87IWbRwPyQA1EnATuTm9wqlaiDlCzoO2uCbXCYv5hOZ9oggoOhyUWKtQVTMMjFiuOa
	Hj4Mw19MUfMpP9CQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce interface to modify io_alloc
 capacity bitmasks
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <67609641b03ccfba18a8ee0bf9dbd1f3dcbecda3.1762995456.git.babu.moger@amd.com>
References:
 <67609641b03ccfba18a8ee0bf9dbd1f3dcbecda3.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651370.498.7261884444268596925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     28fa2cce7a8388f09e457f1e24241ca6d5e985d8
Gitweb:        https://git.kernel.org/tip/28fa2cce7a8388f09e457f1e24241ca6d5e=
985d8
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:35 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Nov 2025 14:28:31 +01:00

fs/resctrl: Introduce interface to modify io_alloc capacity bitmasks

The io_alloc feature in resctrl enables system software to configure the
portion of the cache allocated for I/O traffic. When supported, the
io_alloc_cbm file in resctrl provides access to capacity bitmasks (CBMs)
allocated for I/O devices.

Enable users to modify io_alloc CBMs by writing to the io_alloc_cbm resctrl
file when the io_alloc feature is enabled.

Mirror the CBMs between CDP_CODE and CDP_DATA when CDP is enabled to present
consistent I/O allocation information to user space.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/67609641b03ccfba18a8ee0bf9dbd1f3dcbecda3.17629=
95456.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 12 +++-
 fs/resctrl/ctrlmondata.c              | 93 ++++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |  2 +-
 fs/resctrl/rdtgroup.c                 |  3 +-
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index e799453..bbc4b6c 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -196,6 +196,18 @@ related to allocation:
 			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
 			0=3Dffff;1=3Dffff
=20
+		CBMs can be configured by writing to the interface.
+
+		Example::
+
+			# echo 1=3Dff > /sys/fs/resctrl/info/L3/io_alloc_cbm
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=3Dffff;1=3D00ff
+
+			# echo "0=3Dff;1=3Df" > /sys/fs/resctrl/info/L3/io_alloc_cbm
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=3D00ff;1=3D000f
+
 		When CDP is enabled "io_alloc_cbm" associated with the CDP_DATA and CDP_CO=
DE
 		resources may reflect the same values. For example, values read from and
 		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index c43bede..332918f 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -864,3 +864,96 @@ out_unlock:
 	cpus_read_unlock();
 	return ret;
 }
+
+static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
+				       struct resctrl_schema *s, u32 closid)
+{
+	enum resctrl_conf_type peer_type;
+	struct rdt_parse_data data;
+	struct rdt_ctrl_domain *d;
+	char *dom =3D NULL, *id;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] =3D=3D '\0')
+		return 0;
+
+	dom =3D strsep(&line, ";");
+	id =3D strsep(&dom, "=3D");
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain\n");
+		return -EINVAL;
+	}
+
+	dom =3D strim(dom);
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (d->hdr.id =3D=3D dom_id) {
+			data.buf =3D dom;
+			data.mode =3D RDT_MODE_SHAREABLE;
+			data.closid =3D closid;
+			if (parse_cbm(&data, s, d))
+				return -EINVAL;
+			/*
+			 * Keep io_alloc CLOSID's CBM of CDP_CODE and CDP_DATA
+			 * in sync.
+			 */
+			if (resctrl_arch_get_cdp_enabled(r->rid)) {
+				peer_type =3D resctrl_peer_type(s->conf_type);
+				memcpy(&d->staged_config[peer_type],
+				       &d->staged_config[s->conf_type],
+				       sizeof(d->staged_config[0]));
+			}
+			goto next;
+		}
+	}
+
+	return -EINVAL;
+}
+
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+	u32 io_alloc_closid;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] =3D '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
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
+	io_alloc_closid =3D resctrl_io_alloc_closid(r);
+
+	rdt_staged_configs_clear();
+	ret =3D resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
+	if (ret)
+		goto out_clear_configs;
+
+	ret =3D resctrl_arch_update_domains(r, io_alloc_closid);
+
+out_clear_configs:
+	rdt_staged_configs_clear();
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 779a575..e1eda74 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -440,6 +440,8 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *o=
f, char *buf,
 const char *rdtgroup_name_by_closid(u32 closid);
 int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *=
seq,
 			      void *v);
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off);
=20
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ac326db..3614974 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1973,9 +1973,10 @@ static struct rftype res_common_files[] =3D {
 	},
 	{
 		.name		=3D "io_alloc_cbm",
-		.mode		=3D 0444,
+		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,
 		.seq_show	=3D resctrl_io_alloc_cbm_show,
+		.write		=3D resctrl_io_alloc_cbm_write,
 	},
 	{
 		.name		=3D "max_threshold_occupancy",

