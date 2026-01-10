Return-Path: <linux-tip-commits+bounces-7843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD14D0DC3D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01C033004EC7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAC29B778;
	Sat, 10 Jan 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlKIBhdr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfdGc8Kk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9122BEC45;
	Sat, 10 Jan 2026 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074366; cv=none; b=oHQS0i/BLIOJMwQzZJeld5oZE3y/py5Ke9+RLomCkgGvtkjRkYkEw9jvBZnu3z8ucrpjTJroZmRbWO59XS89KS+2ACcGsafZgNgABn9LxIKggzfM2ghPauQm3Avub9SMZYhExAb4gx4rld7s/iX3hxKBkctjn6eAnoeBz4ZxCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074366; c=relaxed/simple;
	bh=Jo3VQ6Ai2uNAiCdhoxlDWR/q35n54UGG0VwJ2yjv7hg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oPpoqOx84ynAS6g/BFtbu0kJjeKmS0JmWl0JGlBAA93cV3tb3pyyyjHxsKcLm4LYq/i6OeB/HrnkuirbaQngBp+X5MqSTS6CdZE1CWDWbVPWfbyomaGYsCd/UQJiRt8EbK5eqgOX7MxGV+YeVpSMTdnrcbd5XuBwoBJlHUceGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlKIBhdr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfdGc8Kk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IXYV9Utt77OUAkREOYsp7dqNPRKDht4zs1HF4v9LWss=;
	b=MlKIBhdr9JjTjnsbF5rf0YcW3/E5CeCzLCQ6QTGYkScOwd76zO82SS43HOFiO1nlKntCAD
	4oFn4zdVRsEMs0bc9xZNzAZ0QSN6LgmJXRaYj2jtTuvjtJEQ639mKS3Ifq5kNcDzmekG3W
	ttTC4RhwnEgke9XSCCRylTgVTyiceXMcytmXKeoOZXCUXom7Uy1exA7a7oXfOjOnedbKRj
	w263r/ErV6JqA6yTfNjsgJR2v35u+upRJD4/7V3gYBD0xWdjtJfLSeSKX9P14AX7w83w7C
	E6GJugrELF7VqDdizTxXS/SHs/5JmFO9rPCRsEXul2lt1pCBmj/nkWCdaqqFwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IXYV9Utt77OUAkREOYsp7dqNPRKDht4zs1HF4v9LWss=;
	b=SfdGc8KkgLsqyWfOgCg6dRQ+3/xdH5l+bss2OJTz4qsoAsIh8V2DioaFiVQNc3KIkkrgQS
	Ju1CwlWKZDMV4+Aw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] fs/resctrl: Refactor rmdir_mondata_subdir_allrdtgrp()
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435882.510.3454113946711939080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     93d9fd89995181d7ff420752328cc8b4b228f100
Gitweb:        https://git.kernel.org/tip/93d9fd89995181d7ff420752328cc8b4b22=
8f100
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:09 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:02:58 +01:00

fs/resctrl: Refactor rmdir_mondata_subdir_allrdtgrp()

Clearing a monitor group's mon_data directory is complicated because of the
support for Sub-NUMA Cluster (SNC) mode.

Refactor the SNC case into a helper function to make it easier to add support
for a new telemetry resource.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/rdtgroup.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6314819..57139f9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3229,28 +3229,24 @@ static void mon_rmdir_one_subdir(struct kernfs_node *=
pkn, char *name, char *subn
 }
=20
 /*
- * Remove all subdirectories of mon_data of ctrl_mon groups
- * and monitor groups for the given domain.
- * Remove files and directories containing "sum" of domain data
- * when last domain being summed is removed.
+ * Remove files and directories for one SNC node. If it is the last node
+ * sharing an L3 cache, then remove the upper level directory containing
+ * the "sum" files too.
  */
-static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain_hdr *hdr)
+static void rmdir_mondata_subdir_allrdtgrp_snc(struct rdt_resource *r,
+					       struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_l3_mon_domain *d;
 	char subname[32];
-	bool snc_mode;
 	char name[32];
=20
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return;
=20
 	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
-	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : hdr->id);
-	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
+	sprintf(name, "mon_%s_%02d", r->name, d->ci_id);
+	sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
=20
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
@@ -3261,6 +3257,30 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_=
resource *r,
 }
=20
 /*
+ * Remove all subdirectories of mon_data of ctrl_mon groups
+ * and monitor groups for the given domain.
+ */
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_domain_hdr *hdr)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	char name[32];
+
+	if (r->rid =3D=3D RDT_RESOURCE_L3 && r->mon_scope =3D=3D RESCTRL_L3_NODE) {
+		rmdir_mondata_subdir_allrdtgrp_snc(r, hdr);
+		return;
+	}
+
+	sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+	}
+}
+
+/*
  * Create a directory for a domain and populate it with monitor files. Create
  * summing monitors when @hdr is NULL. No need to initialize summing monitor=
s.
  */

