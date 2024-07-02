Return-Path: <linux-tip-commits+bounces-1570-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C0924828
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2ACB254E4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E941CFD4A;
	Tue,  2 Jul 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EOClkJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ls59tAOM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AE1CF3CB;
	Tue,  2 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948258; cv=none; b=eOMHIDwoDJEhdXQv5vMyr9bdJTWhhycYc2DQP6ztffBdN7M27a8SZw8ZqO8VZWqYmEI81jX/7l/1x4ON21aLGiqL5W+9Hp9+wha84YopQr4uChIJm2kvfM/E8yqWTpyxAI9XxD8HeRn/MvIYQ4IS4zcoTq16HEeMigGimOAWXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948258; c=relaxed/simple;
	bh=BwkbYIs/ydrxU7l8UeB77R16927BE2m28sxF8KogjMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X/R8/p2kkgfD3EQnJGrn8jZahZIk7HGzDMjrrdQPK2m5z3SkqZSBpLFMtNuF1W9VKEeGHzA7XMhLHwPuevDapIwKAcvh9LXy7QeL842wksgK8TfegosuZnLdxF+jaOGIH2PRj6s2i3+WdgHes+CPm2vido2QkkenOMXPxauuJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EOClkJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ls59tAOM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr1ESg9cG/Rf5DgHE5J9dylXeWdnDb4B2q2tQK8HRjY=;
	b=2EOClkJG5bq/SPZcbtWyHeyS+a5w/4j7c87WppOzxWOPeN2ABFM7yTOoQy2H2D4Oin4OVm
	YI3JTJpnBSm9UyfZgAmqb6jks8LAPJV+IDQRidjyKtWxl7cY6+PxZBBMxZM/+WVAKZxaHM
	pxw6zyMVnvok9X4jULf6mijYE/UqfXupdBigm5koZiyx1CBvbI8b2I2Dq6DtH9fVlglyNz
	oyn5JgSLu0eqBg3+aL6cknutoByhx+dz6azDQEifiCb9JlJWd8U+5q/Yer4XEGmeWIMvwO
	hpJN6iEB1rnvcKawWeImQV7Cgcj7MqffnNT8+yQBzonsggPiocj46luedG8ReA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr1ESg9cG/Rf5DgHE5J9dylXeWdnDb4B2q2tQK8HRjY=;
	b=Ls59tAOMWusEd5+InwExYCLZhf9Ys1hAh0UkyUJsfWzH21LRiCqlOIxerW1x8AVNVt5Qlw
	U5CyzU4OykrO4zCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Refactor mkdir_mondata_subdir() with a
 helper function
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-12-tony.luck@intel.com>
References: <20240628215619.76401-12-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825382.2215.16970529684204186008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     603cf1e28838a01e4f140c3054ce147f8b087d08
Gitweb:        https://git.kernel.org/tip/603cf1e28838a01e4f140c3054ce147f8b087d08
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:11 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function

In Sub-NUMA Cluster (SNC) mode Linux must create the monitor
files in the original "mon_L3_XX" directories and also in each
of the "mon_sub_L3_YY" directories.

Refactor mkdir_mondata_subdir() to move the creation of monitoring files
into a helper function to avoid the need to duplicate code later.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-12-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 +++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d044358..9c38ddc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3025,14 +3025,37 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct rmid_read rr = {0};
+	union mon_data_bits priv;
+	struct mon_evt *mevt;
+	int ret;
+
+	if (WARN_ON(list_empty(&r->evt_list)))
+		return -EPERM;
+
+	priv.u.rid = r->rid;
+	priv.u.domid = d->hdr.id;
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		priv.u.evtid = mevt->evtid;
+		ret = mon_addfile(kn, mevt->name, priv.priv);
+		if (ret)
+			return ret;
+
+		if (is_mbm_event(mevt->evtid))
+			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
+	}
+
+	return 0;
+}
+
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct rmid_read rr = {0};
-	union mon_data_bits priv;
 	struct kernfs_node *kn;
-	struct mon_evt *mevt;
 	char name[32];
 	int ret;
 
@@ -3046,22 +3069,10 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_destroy;
 
-	if (WARN_ON(list_empty(&r->evt_list))) {
-		ret = -EPERM;
+	ret = mon_add_all_files(kn, d, r, prgrp);
+	if (ret)
 		goto out_destroy;
-	}
 
-	priv.u.rid = r->rid;
-	priv.u.domid = d->hdr.id;
-	list_for_each_entry(mevt, &r->evt_list, list) {
-		priv.u.evtid = mevt->evtid;
-		ret = mon_addfile(kn, mevt->name, priv.priv);
-		if (ret)
-			goto out_destroy;
-
-		if (is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
-	}
 	kernfs_activate(kn);
 	return 0;
 

