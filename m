Return-Path: <linux-tip-commits+bounces-6623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EFB57848
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF7E2042ED
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58930597B;
	Mon, 15 Sep 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OF974aF+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z3ayptsB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED13054E3;
	Mon, 15 Sep 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935669; cv=none; b=cZWjw7okElf71UsgdsGg9oHr+zXe/HPe3TuJlolCl2Z5/UcSxpgvd8zN2qpMpsv6zeqOPkTxCTvQOVdKFExpHWq8eZdK3EmTyZHNxXTu3rV8YauO3MHyOBbaaYioXTca5PT8mCFYnNuHQdRIKCb5fColcRuBCBGNxBh2jGzZPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935669; c=relaxed/simple;
	bh=JlDyUugheG/FdAkXuu7Gu3c5UllDPQ0h+qeu1wFNkBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZrWCqwRwzLB77nJX67rLBcHzX4Yp9LLZhUdRo14K+M0RuUARCxPA+6+/tBdW7ZZ1spf5OTTn7JDrmrziUN4h8LMlaBMmIJXxZpSdeJP/bS0n5ryMTOVZagqeFTf0lFBEIcEkgSdSbjuiOh2MjjPhdvHBI+fRhERUiAEW4k05Yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OF974aF+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z3ayptsB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXZkFhXDaoWVc77J7tMn77iCaqEvhGfTUVgZZB+gWtg=;
	b=OF974aF+YuDOSQe48QYE73U4arFVU9oINh+iPa0fFQQHHdKbNwlvFU+PrazTUezRFbZmJS
	VCHbJfZVjN0yHekOS37usTxSgFSWcIOg+yhJK7i3RI9FPpUrw2HB6e1RbsmLjk9qxzuVC3
	AYwcuEGSrCWGzFG//+dqC7f1edxdGBphujFrOOVO3AcN4fRgRNLoY/uJfh8dPMVil/j8m5
	Ffn9eHCVT54QyzbwfWWpAqQ/C8Rtk+PCvsr64uYg2ZUcJIDhsfObDjOhtZzvzR/+wbuVUd
	xal+DWQbiqqj1gx4OmjyJdRplCVW8fXrExBSqWieFnyIZV1MbeoqeRzhmc++tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXZkFhXDaoWVc77J7tMn77iCaqEvhGfTUVgZZB+gWtg=;
	b=Z3ayptsBfV/mGfgppn0ZZufUpR5vOGGQAAO2IolfR9lG9j5VE3e4I1RXSgeGUJvqHF5ibI
	57OU75Jjkp82stDA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Add resctrl file to display number of
 assignable counters
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <1c0c15a872ee03456ba6c1c48f5489a792a1336e.1757108044.git.babu.moger@amd.com>
References:
 <1c0c15a872ee03456ba6c1c48f5489a792a1336e.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566462.709179.5612551622933037025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8c793336eaf8893a29626155d74615fe9f03e7f2
Gitweb:        https://git.kernel.org/tip/8c793336eaf8893a29626155d74615fe9f0=
3e7f2
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:10 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:12:09 +02:00

fs/resctrl: Add resctrl file to display number of assignable counters

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user.

Create 'num_mbm_cntrs' resctrl file that displays the number of counters
supported in each domain. 'num_mbm_cntrs' is only visible to user space when
the system supports "mbm_event" mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 11 +++++++++++-
 fs/resctrl/internal.h                 |  2 ++-
 fs/resctrl/monitor.c                  | 26 ++++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |  6 ++++++-
 4 files changed, 45 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index b692829..4eb2753 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -288,6 +288,17 @@ with the following files:
 	result in misleading values or display "Unavailable" if no counter is assig=
ned
 	to the event.
=20
+"num_mbm_cntrs":
+	The maximum number of counters (total of available and assigned counters) in
+	each domain when the system supports mbm_event mode.
+
+	For example, on a system with maximum of 32 memory bandwidth monitoring
+	counters in each of its L3 domains:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
+	  0=3D32;1=3D32
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 78aeb7e..7a12187 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -386,6 +386,8 @@ void *rdt_kn_parent_priv(struct kernfs_node *kn);
=20
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_fil=
e *s, void *v);
=20
+int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file =
*s, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 96231d5..112979e 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -912,6 +912,30 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_file=
 *of,
 	return 0;
 }
=20
+int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
+			       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *dom;
+	bool sep =3D false;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_putc(s, ';');
+
+		seq_printf(s, "%d=3D%d", dom->hdr.id, r->mon.num_mbm_cntrs);
+		sep =3D true;
+	}
+	seq_putc(s, '\n');
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return 0;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -957,6 +981,8 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_file_fflags_init("num_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 144585a..9d95d01 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1837,6 +1837,12 @@ static struct rftype res_common_files[] =3D {
 		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 	{
+		.name		=3D "num_mbm_cntrs",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_num_mbm_cntrs_show,
+	},
+	{
 		.name		=3D "min_cbm_bits",
 		.mode		=3D 0444,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,

