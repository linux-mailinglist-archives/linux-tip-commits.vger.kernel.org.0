Return-Path: <linux-tip-commits+bounces-4148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE3A5E281
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E1C172E60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19B25B673;
	Wed, 12 Mar 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6/7SbFX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgIV/5t3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C49282F1;
	Wed, 12 Mar 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800030; cv=none; b=M/JLLTN/cFKBZQV5+Iiij5VhQjZNJH0E0SxVbkhd4+kHw0oaHdMZGJAEBSZNSruViVb5D7q7QlAV9qH9+n6NWpjUSxCrX+6NaHX4K4n3f9vJwAxyvaHATcVYl4Z2IcTmSXsbjyr0Tn296PHiYDNj1NvqN8MrcBsFOUyMNush00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800030; c=relaxed/simple;
	bh=Rcv+TZJkplQ1npvLz7Jw/Sp0kmsuInfDPHslNzK2tzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gm8BdBCwwU4pJYFxsvov+gqGpgUZCZYyzrYo8mX7UMzhiTWdtH8tL9aQ/gi+/CCmPtNIScXG9HKL0qG7Az3eiRVNB4uDNUWIP0f7vOwexCP40Fy91kTSSRT2YraZcWDnaH7BgiEqPR9aeJW/TCbPMT8ZRrBz5Gg7teImNcIX7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6/7SbFX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HgIV/5t3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG+KAxMRwj4pTVa1Ljq4AsVhE1xi+/Vl1PWRPLmDOCg=;
	b=p6/7SbFXyXUKbdIECJjmrwHnLKQrNPeRutsNoYQZD88wwclr6NbEROAtUdXftHpNUIozo9
	HYXDhij3Sw/coo49sg3LsbOjfJ+NrxNtqmo8hXdXlbiYRMnSmkhiwhcKZld/9ECZ/1Jrn2
	rDI72HWWvYwIGUvTAKrh2U/uEWhq/aG7/QeNia5F/tkPLq0JbjVxrMwRDJiXqLy1f8cskv
	nhqJpPwl25exMPVEY4rWYRwmk3M074KW05Fu47rDG093T8OtkE7EFsAaeV6mdieKJaaJrc
	e1lMEeIlR81h9AXc3eO/4cBuAOmD1nHnd2qkT0PhDSR1xre49ip+UHtBwphqXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG+KAxMRwj4pTVa1Ljq4AsVhE1xi+/Vl1PWRPLmDOCg=;
	b=HgIV/5t3rzMDXckAqIH90Xu9HHpqxx0ASNoB3fnkULL5b36DfuXw9LjTOmqxGumhKcGx93
	H6pOyKSThlTkx7Ag==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Change mon_event_config_{read,write}()
 to be arch helpers
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-21-james.morse@arm.com>
References: <20250311183715.16445-21-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002552.14745.12297322861336551129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     650680d651aaf409f097ad904c3fea6c4b3a0884
Gitweb:        https://git.kernel.org/tip/650680d651aaf409f097ad904c3fea6c4b3a0884
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:05 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:49 +01:00

x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers

mon_event_config_{read,write}() are called via IPI and access model specific
registers to do their work.

To support another architecture, this needs abstracting.

Rename mon_event_config_{read,write}() to have a "resctrl_arch_" prefix, and
move their struct mon_config_info parameter into <linux/resctrl.h>.  This
allows another architecture to supply an implementation of these.

As struct mon_config_info is now exposed globally, give it a 'resctrl_'
prefix. MPAM systems need access to the domain to do this work, add the
resource and domain to struct resctrl_mon_config_info.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-21-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++-------------
 include/linux/resctrl.h                | 31 +++++++++++++++++-
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eb32fbc..e7d1d8b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1580,11 +1580,6 @@ out:
 	return ret;
 }
 
-struct mon_config_info {
-	u32 evtid;
-	u32 mon_config;
-};
-
 #define INVALID_CONFIG_INDEX   UINT_MAX
 
 /**
@@ -1609,31 +1604,32 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
-static void mon_event_config_read(void *info)
+void resctrl_arch_mon_event_config_read(void *_config_info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *config_info = _config_info;
 	unsigned int index;
 	u64 msrval;
 
-	index = mon_event_config_index_get(mon_info->evtid);
+	index = mon_event_config_index_get(config_info->evtid);
 	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		pr_warn_once("Invalid event id %d\n", config_info->evtid);
 		return;
 	}
 	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
 
 	/* Report only the valid event configuration bits */
-	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
+	config_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
 {
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
+	smp_call_function_any(&mon_info->d->hdr.cpu_mask,
+			      resctrl_arch_mon_event_config_read, mon_info, 1);
 }
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info;
+	struct resctrl_mon_config_info mon_info;
 	struct rdt_mon_domain *dom;
 	bool sep = false;
 
@@ -1644,9 +1640,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
+		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
+		mon_info.r = r;
+		mon_info.d = dom;
 		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		mondata_config_read(&mon_info);
 
 		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
 		sep = true;
@@ -1679,30 +1677,32 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void mon_event_config_write(void *info)
+void resctrl_arch_mon_event_config_write(void *_config_info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *config_info = _config_info;
 	unsigned int index;
 
-	index = mon_event_config_index_get(mon_info->evtid);
+	index = mon_event_config_index_get(config_info->evtid);
 	if (index == INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		pr_warn_once("Invalid event id %d\n", config_info->evtid);
 		return;
 	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
 }
 
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
-	struct mon_config_info mon_info = {0};
+	struct resctrl_mon_config_info mon_info = {0};
 
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
+	mon_info.r = r;
+	mon_info.d = d;
 	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
+	mondata_config_read(&mon_info);
 	if (mon_info.mon_config == val)
 		return;
 
@@ -1714,7 +1714,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_arch_mon_event_config_write,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index cc76f30..90b6563 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -270,6 +270,13 @@ struct resctrl_cpu_defaults {
 	u32 rmid;
 };
 
+struct resctrl_mon_config_info {
+	struct rdt_resource	*r;
+	struct rdt_mon_domain	*d;
+	u32			evtid;
+	u32			mon_config;
+};
+
 /**
  * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
  *					 Call via IPI.
@@ -311,6 +318,30 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 __init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
+/**
+ * resctrl_arch_mon_event_config_write() - Write the config for an event.
+ * @config_info: struct resctrl_mon_config_info describing the resource, domain
+ *		 and event.
+ *
+ * Reads resource, domain and eventid from @config_info and writes the
+ * event config_info->mon_config into hardware.
+ *
+ * Called via IPI to reach a CPU that is a member of the specified domain.
+ */
+void resctrl_arch_mon_event_config_write(void *config_info);
+
+/**
+ * resctrl_arch_mon_event_config_read() - Read the config for an event.
+ * @config_info: struct resctrl_mon_config_info describing the resource, domain
+ *		 and event.
+ *
+ * Reads resource, domain and eventid from @config_info and reads the
+ * hardware config value into config_info->mon_config.
+ *
+ * Called via IPI to reach a CPU that is a member of the specified domain.
+ */
+void resctrl_arch_mon_event_config_read(void *config_info);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.

