Return-Path: <linux-tip-commits+bounces-7851-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F117D0DC91
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EF8309845E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81A2DE6F5;
	Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtNAEeqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9tc9LKMu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B412C2349;
	Sat, 10 Jan 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074371; cv=none; b=hJvaeZP/Di+G+jdKe2w/hrrKwC8BJbk/H2tiInFgK5smNNkcUvGIjmQsQOto+CQbNcC5D19So9Ogozd/36vwGceIt817VXzLZWj2RpsZAly1pemXOwH1Yfb9ZReaFf9JNw/FaMQMslofVsoPCbDNtxeJV7z2DFG6HnGfeEgF6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074371; c=relaxed/simple;
	bh=l4+bHvAEFBG4+gYLUwy/XjCksE/SgxT0hL2JcnCLOfw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pR/AUddVSxtqX0TiMTleX+mVCeYH6L1iSLW2YEvodJ0+y32z9WepGe94ighNmdWQ2ZUuuq429xqeVq2mav7pnRYed6tMaoq5Zgvk2x4RNJLs/roTQwc5C9XTnFk9ajkIzoryOaehqH0XKxgmMKBfdlCsbKt5MuD81k8IwpURkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtNAEeqr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9tc9LKMu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I6lFmudP3sBkR1jcJUKEgQAKUl2vd7TuO2jwl6OwGHo=;
	b=dtNAEeqr+CDOplvPMVVkF9/Pe9rCIUDBwYA5A+YFjzd6HS3QBppeH1bl0pU4RWsP5GOJGX
	6T4fSH7iLiqkivnTDjXNXVNcCo+FvyOOmPbHlhO3xx6VNmNxxvrS9v7O27ZTj/6HldlEwE
	j414jtnFfiwZjzMtmqG4/424w0HRYOvq9oq16SJ43hV5U1QGeuoRBCWdkVWq8G5HvWwP8W
	i/AIoY0SxYE6ZQ/oPme8k9n4cGinW4dWuztzp3GISIygS6jM5Bgk8vlJBFsGHimb405Aqw
	+AxkEQ9hVXZ+CopNJvK/Mgis/E1S2x2rxCCtFyMHxF3K4RfxqeULuWFnckEfAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=I6lFmudP3sBkR1jcJUKEgQAKUl2vd7TuO2jwl6OwGHo=;
	b=9tc9LKMudx974cPEOG+IAInckti0U0bazy/dTaSLNjgHFnGyLKfsHQsDiJgb54DCAovKGv
	CU6bxIsQEwspPyBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Emphasize that L3 monitoring resource is
 required for summing domains
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436629.510.1738228861981963421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     db64994d115e7c2cd72fec11b854467e97169379
Gitweb:        https://git.kernel.org/tip/db64994d115e7c2cd72fec11b854467e971=
69379
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:02 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:37:07 +01:00

fs/resctrl: Emphasize that L3 monitoring resource is required for summing dom=
ains

The feature to sum event data across multiple domains supports systems with
Sub-NUMA Cluster (SNC) mode enabled. The top-level monitoring files in each
"mon_L3_XX" directory provide the sum of data across all SNC nodes sharing an
L3 cache instance while the "mon_sub_L3_YY" sub-directories provide the event
data of the individual nodes.

SNC is only associated with the L3 resource and domains and as a result the
flow handling the sum of event data implicitly assumes it is working with
the L3 resource and domains.

Reading of telemetry events does not require to sum event data so this feature
can remain dedicated to SNC and keep the implicit assumption of working with
the L3 resource and domains.

Add a WARN to where the implicit assumption of working with the L3 resource
is made and add comments on how the structure controlling the event sum
feature is used.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/ctrlmondata.c | 8 +++++++-
 fs/resctrl/internal.h    | 4 ++--
 fs/resctrl/rdtgroup.c    | 3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index f319fd1..cc4237c 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -677,7 +677,6 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of =3D m->private;
 	enum resctrl_res_level resid;
-	struct rdt_l3_mon_domain *d;
 	struct rdt_domain_hdr *hdr;
 	struct rmid_read rr =3D {0};
 	struct rdtgroup *rdtgrp;
@@ -705,6 +704,13 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	r =3D resctrl_arch_get_resource(resid);
=20
 	if (md->sum) {
+		struct rdt_l3_mon_domain *d;
+
+		if (WARN_ON_ONCE(resid !=3D RDT_RESOURCE_L3)) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0110d11..50d88e9 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -92,8 +92,8 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
  * @list:            Member of the global @mon_data_kn_priv_list list.
  * @rid:             Resource id associated with the event file.
  * @evt:             Event structure associated with the event file.
- * @sum:             Set when event must be summed across multiple
- *                   domains.
+ * @sum:             Set for RDT_RESOURCE_L3 when event must be summed
+ *                   across multiple domains.
  * @domid:           When @sum is zero this is the domain to which
  *                   the event file belongs. When @sum is one this
  *                   is the id of the L3 cache that all domains to be
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a06cefd..a2ad99a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3096,7 +3096,8 @@ static void rmdir_all_sub(void)
  * @rid:    The resource id for the event file being created.
  * @domid:  The domain id for the event file being created.
  * @mevt:   The type of event file being created.
- * @do_sum: Whether SNC summing monitors are being created.
+ * @do_sum: Whether SNC summing monitors are being created. Only set
+ *	    when @rid =3D=3D RDT_RESOURCE_L3.
  */
 static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domi=
d,
 					struct mon_evt *mevt,

