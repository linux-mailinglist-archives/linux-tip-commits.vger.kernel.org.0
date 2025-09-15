Return-Path: <linux-tip-commits+bounces-6625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA3B57843
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A4B7AE576
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666F306487;
	Mon, 15 Sep 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NT+Robvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5z8jVvO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698D2FF154;
	Mon, 15 Sep 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935670; cv=none; b=UTVUbWRQWPcmpx5PIPax3eYXH/2Ft1AYi1xLNgDULpVcuVK+cvXx02E7DSBqoZJpx0q0pSNMfz+tOS8y+VgYioDbjjJcJ0GOeagsPFigMJwvoU6gTWHvXNvqxEoZPS9a2S2+Dv7mBUOt43+28NXXQPG6zKYJ2+Cdazjf/9eyJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935670; c=relaxed/simple;
	bh=IW7oM099iTPG8KritjgbGQBDzrRvINrZhpoo0+2vio8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D2IGC+JlGjhy/VIF+pWaqkNS8WWZ0+mq+KnZh44wDwCVWHXF+IAqJbqdzD4gCmjhyP2GBq9xF2MRiGd5fdP715IAaLJqyK/Y24qucxvSNUUQPPdYrugcgMgfi+B5BJmXnErjSLobDRqdUTQbWwVs53xr75Y3OR2G8uzjYoc6Mds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NT+Robvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5z8jVvO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skYVjOU06LXybnUIgwFSLB3TFTsfljxCB9lWhVbSIaM=;
	b=NT+RobvuixgMKSxTgsZt9IX5DOoQwm+WHezRZ3pRLPEUVCGz7eUHi6bJpPjPiKWo9Z2oX+
	4phU6Oop+K6f1QqbKg654aHW6m1kL9n78AbWAH5XSNtBT9WnHCmt7vzneNrkY7fqlTBZ34
	k8pp5rr2ZJYsqaSAGOxe1Rha7anhGQuMr4aFcVxHdjimcbJebZ5gJHhNmYxMTHOD6qkbB6
	bmpD2TrRiUaWh1lzLWpniG9k7UweTHW8k+hyewTkJBDSxRi9jtYzE2tb5ymH/X+truGZm2
	JXiNu/YOechcEnMyWTbBDCYh6Z6unQVxXXqw0s7Gfa0TQO2Lf7N5BZKHlyNDMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skYVjOU06LXybnUIgwFSLB3TFTsfljxCB9lWhVbSIaM=;
	b=C5z8jVvOVr4NQOu/GGRKZ+4peTFJQHhuCM+dK69DhcXveOhLou76v0HfCSheMxhmxrXZfQ
	AavCBnCGR+YnOMBA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce the interface to display
 monitoring modes
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8e49aa6d087f42a8f00a0263fc8d194f105d5fc1.1757108044.git.babu.moger@amd.com>
References:
 <8e49aa6d087f42a8f00a0263fc8d194f105d5fc1.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566581.709179.17458474591882900824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3b497c3f4f0427d940ec5c8600e840c8adc5cfbf
Gitweb:        https://git.kernel.org/tip/3b497c3f4f0427d940ec5c8600e840c8adc=
5cfbf
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:09 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:10:58 +02:00

fs/resctrl: Introduce the interface to display monitoring modes

Introduce the resctrl file "mbm_assign_mode" to list the supported counter
assignment modes.

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned. The hardware continues to track the assigned counter until it is
explicitly unassigned by the user. Each event within a resctrl group can be
assigned independently in this mode.

On AMD systems "mbm_event" mode is backed by the ABMC (Assignable Bandwidth
Monitoring Counters) hardware feature and is enabled by default.

The "default" mode is the existing mode that works without the explicit
counter assignment, instead relying on dynamic counter assignment by hardware
that may result in hardware not dedicating a counter resulting in monitoring
data reads returning "Unavailable".

Provide an interface to display the monitor modes on the system.

  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
  [mbm_event]
  default

Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check to support Arm64.

On x86, CONFIG_RESCTRL_ASSIGN_FIXED is not defined. On Arm64, it will be
defined when the "mbm_event" mode is supported.

Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check early to ensure the user
interface remains compatible with upcoming Arm64 support. IS_ENABLED() safely
evaluates to 0 when the configuration is not defined.

As a result, for MPAM, the display would be either:

  [default]

or

  [mbm_event]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 31 ++++++++++++++++++++++++++-
 fs/resctrl/internal.h                 |  4 +++-
 fs/resctrl/monitor.c                  | 30 +++++++++++++++++++++++++-
 fs/resctrl/rdtgroup.c                 |  9 +++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index c97fd77..b692829 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -257,6 +257,37 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=3D0x30;1=3D0x30;3=3D0x15;4=3D0x15
=20
+"mbm_assign_mode":
+	The supported counter assignment modes. The enclosed brackets indicate whic=
h mode
+	is enabled.
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_event]
+	  default
+
+	"mbm_event":
+
+	mbm_event mode allows users to assign a hardware counter to an RMID, event
+	pair and monitor the bandwidth usage as long as it is assigned. The hardware
+	continues to track the assigned counter until it is explicitly unassigned by
+	the user. Each event within a resctrl group can be assigned independently.
+
+	In this mode, a monitoring event can only accumulate data while it is backed
+	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and =
MON
+	group to specify which of the events should have a counter assigned. The nu=
mber
+	of counters available is described in the "num_mbm_cntrs" file. Changing the
+	mode may cause all counters on the resource to reset.
+
+	"default":
+
+	In default mode, resctrl assumes there is a hardware counter for each
+	event within every CTRL_MON and MON group. On AMD platforms, it is
+	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
+	events between reads resulting from hardware re-allocating counters. This c=
an
+	result in misleading values or display "Unavailable" if no counter is assig=
ned
+	to the event.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 7a57366..78aeb7e 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -382,6 +382,10 @@ bool closid_allocated(unsigned int closid);
=20
 int resctrl_find_cleanest_closid(void);
=20
+void *rdt_kn_parent_priv(struct kernfs_node *kn);
+
+int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_fil=
e *s, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index b578451..96231d5 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -882,6 +882,36 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id =
eventid)
 	       mon_event_all[eventid].enabled;
 }
=20
+int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	bool enabled;
+
+	mutex_lock(&rdtgroup_mutex);
+	enabled =3D resctrl_arch_mbm_cntr_assign_enabled(r);
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (enabled)
+			seq_puts(s, "[mbm_event]\n");
+		else
+			seq_puts(s, "[default]\n");
+
+		if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED)) {
+			if (enabled)
+				seq_puts(s, "default\n");
+			else
+				seq_puts(s, "mbm_event\n");
+		}
+	} else {
+		seq_puts(s, "[default]\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b6ab107..144585a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -975,7 +975,7 @@ static int rdt_last_cmd_status_show(struct kernfs_open_fi=
le *of,
 	return 0;
 }
=20
-static void *rdt_kn_parent_priv(struct kernfs_node *kn)
+void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
 	 * The parent pointer is only valid within RCU section since it can be
@@ -1912,6 +1912,13 @@ static struct rftype res_common_files[] =3D {
 		.write		=3D mbm_local_bytes_config_write,
 	},
 	{
+		.name		=3D "mbm_assign_mode",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D resctrl_mbm_assign_mode_show,
+		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
+	},
+	{
 		.name		=3D "cpus",
 		.mode		=3D 0644,
 		.kf_ops		=3D &rdtgroup_kf_single_ops,

