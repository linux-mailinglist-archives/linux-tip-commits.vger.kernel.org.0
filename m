Return-Path: <linux-tip-commits+bounces-3064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B99F17BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432D3164E50
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A101A7AC7;
	Fri, 13 Dec 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ydv46IR3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiOG5OhX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED119CC0F;
	Fri, 13 Dec 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123767; cv=none; b=hzSYswuJHBWRl1ixrrIWAn9uaZkMx4u+a7xmfvq48chUcGrSsMDhyQLEgQcZgOcwePFJG+d7tE6SH33ZTYEYBpAcnk5up+cNGop72wpzOpIWiePwvKepc5KJbHRFpbdPQvfKsIEmZpCvbCqbyToTdx7ftGuUGERNQYsyNAmPpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123767; c=relaxed/simple;
	bh=dd3amfx8Cq3OBTjkzHy1e6U8i50YR3qWWmA/q3MPq9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bDb/PIHjizXQLxO4Ag6obz8Xxkva9XVcxYLyXUX5A5hmXbBhRIdb65QQs57OanfZVVj3fEL+oWpkmzk0O6aXCjym2TzTFpUwvkmj8bSEEWNmrpiCflwJppWsO2PTfE07hZzZ2aXqJH7473WuzqcoBC+vyz4T58fpbBCi7GcVX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ydv46IR3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiOG5OhX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXxgaaQRrUMjnTUi7HqtCbuo3qGWFsRF/P2c2EH5UkE=;
	b=Ydv46IR3TJgwRR/p6jx7+fB+QnOo8mNiREhazmIBWMNrfXp7yMEwqMOpA6UL+yo0dBJnpj
	zmu5QaJu5sF+RAxqA46cftneLVJ0BAA7th1qlcH8rRXnX8KejLdP+tpEvCnn2jgkNuls7I
	BYlbfJJVxeXHJ4e8xHxU7godROUbwaeN6E1FCTu7gA4zdfpkLsTJ6vcQ1+Q03ruMZkgNe/
	nGqEptXPgO3bFVe4KwqeCqsCrUzJ9vD25dOOjgWuwFuzmZfeMGka79bi3t8WhfaAi/T8W1
	HyvBEVLEeUxsblh4L1D3Kiswr/cnYVwTRH0TzQevHZa5xs9vBd3iV8SYQJiq0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXxgaaQRrUMjnTUi7HqtCbuo3qGWFsRF/P2c2EH5UkE=;
	b=hiOG5OhXCcVkEGzSDoto/FmWlrqmm4/0kScTffg6hMEX0OH13IYXNutnpBv+sxClYIBEWa
	8w8O40oY8rUibCDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Prepare for per-CTRL_MON group mba_MBps control
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-3-tony.luck@intel.com>
References: <20241206163148.83828-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412376318.412.3198202331107137086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     3b49c37a2f4657730dd38a050b9d221363889dea
Gitweb:        https://git.kernel.org/tip/3b49c37a2f4657730dd38a050b9d221363889dea
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:42 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 11:13:48 +01:00

x86/resctrl: Prepare for per-CTRL_MON group mba_MBps control

Resctrl uses local memory bandwidth event as input to the feedback loop when
the mba_MBps mount option is used. This means that this mount option cannot be
used on systems that only support monitoring of total bandwidth.

Prepare to allow users to choose the input event independently for each
CTRL_MON group by adding a global variable "mba_mbps_default_event" used to
set the default event for each CTRL_MON group, and a new field
"mba_mbps_event" in struct rdtgroup to track which event is used for each
CTRL_MON group.

Notes:

1) Both of these are only used when the user mounts the filesystem with the
   "mba_MBps" option.
2) Only check for support of local bandwidth event when initializing
   mba_mbps_default_event. Support for total bandwidth event can be added
   after other routines in resctrl have been updated to handle total bandwidth
   event.

  [ bp: Move mba_mbps_default_event extern into the arch header. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-3-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  3 +++
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f3ee585..94bf559 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -963,6 +963,9 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
+	if (is_mbm_local_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+
 	return !rdt_get_mon_l3_config(r);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index faaff9d..542d01c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -283,6 +283,7 @@ struct pseudo_lock_region {
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
  * @mode:			mode of resource group
+ * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
  * @plr:			pseudo-locked region
  */
 struct rdtgroup {
@@ -295,6 +296,7 @@ struct rdtgroup {
 	enum rdt_group_type		type;
 	struct mongroup			mon;
 	enum rdtgrp_mode		mode;
+	enum resctrl_event_id		mba_mbps_event;
 	struct pseudo_lock_region	*plr;
 };
 
@@ -508,6 +510,7 @@ extern struct mutex rdtgroup_mutex;
 extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
+extern enum resctrl_event_id mba_mbps_default_event;
 
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
@@ -651,5 +654,4 @@ void resctrl_file_fflags_init(const char *config, unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
-
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d333570..8a52b25 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -65,6 +65,15 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+/*
+ * Memory bandwidth monitoring event to use for the default CTRL_MON group
+ * and each new CTRL_MON group created by the user.  Only relevant when
+ * the filesystem is mounted with the "mba_MBps" option so it does not
+ * matter that it remains uninitialized on systems that do not support
+ * the "mba_MBps" option.
+ */
+enum resctrl_event_id mba_mbps_default_event;
+
 static bool resctrl_debug;
 
 void rdt_last_cmd_clear(void)
@@ -2353,6 +2362,8 @@ static int set_mba_sc(bool mba_sc)
 
 	r->membw.mba_sc = mba_sc;
 
+	rdtgroup_default.mba_mbps_event = mba_mbps_default_event;
+
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		for (i = 0; i < num_closid; i++)
 			d->mbps_val[i] = MBA_MAX_MBPS;
@@ -3611,6 +3622,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 			rdt_last_cmd_puts("kernfs subdir error\n");
 			goto out_del_list;
 		}
+		if (is_mba_sc(NULL))
+			rdtgrp->mba_mbps_event = mba_mbps_default_event;
 	}
 
 	goto out_unlock;

