Return-Path: <linux-tip-commits+bounces-6620-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D0B5783E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90AB3A62E2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFA304BAA;
	Mon, 15 Sep 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGIg+MBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTRpYyqq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D80303A38;
	Mon, 15 Sep 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935664; cv=none; b=mdsPHnibFqyyuGSe94fjxTfM8cpsPOiECyQ05dSYP+TwY0J/s/SzohZK7mVzfKyzcN+anvimFVDRVM36N15ST3aGmluYdxPPoKWXw4UMXhG+35p6+zof/oucJ2iKZ7hHoL4snhrlRjwLwo53HntrXEsDdRIPLOpAYttu8yqotus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935664; c=relaxed/simple;
	bh=LSNbp4/KeGpfOgfXclxPuj0w5DkGGCN7vaBiRHwlW7U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sxTcl4cq8DghLbGzm3QtCCHTgsvTEmKYtUhv83EzbDH6yTWjdmOHa+mbFDl9xmyGur2XwiqWtFYMtRnzbca+lggNI4kj44KgxpB5gCvXQE3Sx9Ol0he+GOkPyP4wsWZ1ibxj+8U5SBfgfMNLbRCBv7Tnc3aXXnKjN5tohTpPWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGIg+MBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTRpYyqq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYZCYqQINVCT7bUIjm7COACBZRF28UknTdY9RAH36+0=;
	b=HGIg+MBOlLN6iIwvStQjDYqajJi/fV7bK3A0yp+YX1/Rnr1vi2XUGULZBsfkZev150tN/f
	qvBlhoNo6PQrSfRc6C2At2W4OJOgv89hMLVz+G2OOyKCK8GRXmkDmJpLDorRPdj6HxsP+R
	dWdAL1RhoBpdYPkOKjcgENlM+cRyoI/aZHX0JRmJpePUnYIs9zmfzM8N44fv4q5tu2Ki3C
	a62SsQmrRCTHtN6AtH7wVq4prOBvkCYC3TfBd6tSvsUTSUy114l0D/SLBpUmR4x9cT7OCo
	u5+6yqi5iPJnqyavAXaCvjo/QN8TXwBUQC3HqSx6UorWW7Osnldu0A1Ens44wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYZCYqQINVCT7bUIjm7COACBZRF28UknTdY9RAH36+0=;
	b=eTRpYyqqW8isRx+V4PhGsBRhkT9xpymSwp9GIgMj7jbfANKdVN5D+YdeqMIxxRWwSd2Zvt
	qbD8kyrcBZTmK/CQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce event configuration field in
 struct mon_evt
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <1ce97c42836bd64d5e1bd4631235ef06f8600313.1757108044.git.babu.moger@amd.com>
References:
 <1ce97c42836bd64d5e1bd4631235ef06f8600313.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566013.709179.9038379168796512019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ebebda853633de389ba2c6737f8ca38405713e90
Gitweb:        https://git.kernel.org/tip/ebebda853633de389ba2c6737f8ca384057=
13e90
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:14 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:18:31 +02:00

fs/resctrl: Introduce event configuration field in struct mon_evt

When supported, mbm_event counter assignment mode allows the user to configure
events to track specific types of memory transactions.

Introduce an evt_cfg field in struct mon_evt to define the type of memory
transactions tracked by a monitoring event. Also add a helper function to get
the evt_cfg value.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/internal.h   |  5 +++++
 fs/resctrl/monitor.c    | 10 ++++++++++
 include/linux/resctrl.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4f372e8..1cddfff 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -56,6 +56,10 @@ static inline struct rdt_fs_context *rdt_fc2context(struct=
 fs_context *fc)
  * @evtid:		event id
  * @rid:		resource id for this event
  * @name:		name of the event
+ * @evt_cfg:		Event configuration value that represents the
+ *			memory transactions (e.g., READS_TO_LOCAL_MEM,
+ *			READS_TO_REMOTE_MEM) being tracked by @evtid.
+ *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
  * @enabled:		true if the event is enabled
  */
@@ -63,6 +67,7 @@ struct mon_evt {
 	enum resctrl_event_id	evtid;
 	enum resctrl_res_level	rid;
 	char			*name;
+	u32			evt_cfg;
 	bool			configurable;
 	bool			enabled;
 };
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 1fa82a6..f714e7b 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -882,6 +882,11 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id =
eventid)
 	       mon_event_all[eventid].enabled;
 }
=20
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
+{
+	return mon_event_all[evtid].evt_cfg;
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
@@ -1023,6 +1028,11 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask;
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask &
+								   (READS_TO_LOCAL_MEM |
+								    READS_TO_LOCAL_S_MEM |
+								    NON_TEMP_WRITE_TO_LOCAL_MEM);
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e013cab..87daa4c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -409,6 +409,8 @@ static inline bool resctrl_is_mbm_event(enum resctrl_even=
t_id eventid)
 		eventid <=3D QOS_L3_MBM_LOCAL_EVENT_ID);
 }
=20
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id eventid);
+
 /* Iterate over all memory bandwidth events */
 #define for_each_mbm_event_id(eventid)				\
 	for (eventid =3D QOS_L3_MBM_TOTAL_EVENT_ID;		\

