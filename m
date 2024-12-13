Return-Path: <linux-tip-commits+bounces-3060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379139F17B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834F3188F79F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF47192D91;
	Fri, 13 Dec 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oa8CcNks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fn3yIN0v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716B191F98;
	Fri, 13 Dec 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123762; cv=none; b=i8iWMD4ROavPWWopRscG9t+aI5EFBxDhsdWF8RaL/PmpniaxWBNQkBlbsmMfHET4RP1oy2nAQZSstQiPsXteDWVGZYh//FW/i3DRLcpNSy1kUc/DYG7V028h9DkEvamQGqpd0L56PRVoppBhCuS0uOgl7SdZCj1tlEh1+s4sBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123762; c=relaxed/simple;
	bh=R5JKdSXbxjWbX4YsEa+D5vmmU4GiG3taURRcWuiVT7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bI+U4JivanTMadymieNHCCQdE0g2Gf+de4F3Vybpb8iSbR5QpDY9vFqDV00lilSeBhNW3VFOMy/UzXgP1jZghfF/gYQwjTnjX+lNUhcntlPKmB3M3H6FRfFYy2p7dLZdfu4muOhv/kX/QIwXpsztYGIGN5VaXGDVJj7d2D8RZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oa8CcNks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fn3yIN0v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPO4vmbWUyyCPvr0UVKobwheYWKXcPIjSMCcAuBEUNw=;
	b=Oa8CcNksq/q/Mbvja8U1qHbkURaj8UG7Bjf4B7RKCle1a8Q7VC1h0Uxpd7G+kHPycwND0o
	1y3Rrora6jKaQ/jkAKz7bzDKapN9Bs/rgMvuInLvjdb4JwHXl6qE70AIPDZn0Lg66i5yQ5
	HRlp4mqTN6tQPFAHnuLRDxb4u718RUHla1QSoXN8HMnZhbi+tedUpku992rzWJF2YJ+oqR
	i74tqvd+uqu2o13veXosYNPmeqmI5vkZHJfug4x1KlxRJUwn+u82q7XoKxMrWb2Cx2Xs/I
	zdW0Pior8HP16t/8lTTvPUSKK7pg+I6zNwCEr7cTGjvOdCmfrwcg4yxHK6VMmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPO4vmbWUyyCPvr0UVKobwheYWKXcPIjSMCcAuBEUNw=;
	b=fn3yIN0vbbTQ4dmEOu9ZDDTK+D6PxThOl5pYRBRdiITzdKjj1SqixJgDDrD01SqlNiup5n
	we2ddS+7zNkI1cDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add "mba_MBps_event" file to CTRL_MON
 directories
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-7-tony.luck@intel.com>
References: <20241206163148.83828-7-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412375768.412.2860360757166478405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f5cd0e316f14d79c9eb0cf8fe7e60cee3a657aa8
Gitweb:        https://git.kernel.org/tip/f5cd0e316f14d79c9eb0cf8fe7e60cee3a657aa8
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:46 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 12 Dec 2024 11:27:28 +01:00

x86/resctrl: Add "mba_MBps_event" file to CTRL_MON directories

The "mba_MBps" mount option provides an alternate method to control memory
bandwidth. Instead of specifying allowable bandwidth as a percentage of
maximum possible, the user provides a MiB/s limit value.

In preparation to allow the user to pick the memory bandwidth monitoring event
used as input to the feedback loop, provide a file in each CTRL_MON group
directory that shows the event currently in use. Note that this file is only
visible when the "mba_MBps" mount option is in use.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-7-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 30 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 10 +++++++-
 3 files changed, 42 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a..5fa37b4 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -518,6 +518,36 @@ static int smp_mon_event_count(void *arg)
 	return 0;
 }
 
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+
+	if (rdtgrp) {
+		switch (rdtgrp->mba_mbps_event) {
+		case QOS_L3_MBM_LOCAL_EVENT_ID:
+			seq_puts(s, "mbm_local_bytes\n");
+			break;
+		case QOS_L3_MBM_TOTAL_EVENT_ID:
+			seq_puts(s, "mbm_total_bytes\n");
+			break;
+		default:
+			pr_warn_once("Bad event %d\n", rdtgrp->mba_mbps_event);
+			ret = -EINVAL;
+			break;
+		}
+	} else {
+		ret = -ENOENT;
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 542d01c..1bd61ed 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -610,6 +610,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain *d,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0659b8e..6eb930b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1951,6 +1951,12 @@ static struct rftype res_common_files[] = {
 		.fflags		= RFTYPE_CTRL_BASE,
 	},
 	{
+		.name		= "mba_MBps_event",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mba_mbps_event_show,
+	},
+	{
 		.name		= "mode",
 		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
@@ -2355,6 +2361,7 @@ static int set_mba_sc(bool mba_sc)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rdt_ctrl_domain *d;
+	unsigned long fflags;
 	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
@@ -2369,6 +2376,9 @@ static int set_mba_sc(bool mba_sc)
 			d->mbps_val[i] = MBA_MAX_MBPS;
 	}
 
+	fflags = mba_sc ? RFTYPE_CTRL_BASE | RFTYPE_MON_BASE : 0;
+	resctrl_file_fflags_init("mba_MBps_event", fflags);
+
 	return 0;
 }
 

