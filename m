Return-Path: <linux-tip-commits+bounces-474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD46C85AB1E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Feb 2024 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74387282DB6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Feb 2024 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2D4EB59;
	Mon, 19 Feb 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxg973ik";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPZUQH43"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F908335CC;
	Mon, 19 Feb 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367853; cv=none; b=Lbst4l1r8aCdUs2/BdSoiH7W3MsIfzQZlYCceVXZsetA2sfVIYs5BMEDD/pYTM5+WIZt5Jos+2YCP2zzaX7LBUvabg9t94EijUjhck1wEXlcOij1i5uoYdf0QYJFoHRb3Nn9mqPV5Sxv6TaASt558AICjgNOTvhrj3HMZGkzE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367853; c=relaxed/simple;
	bh=DJbv8PlTs7Q0u1jWJ944PqXLpVfpNCj/q/6b102ToMw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hE6Yf8HkN0ykj/UNWgSlzVQ585SZAoOcufFBjBHEaWTVMPrUzpGgHErEzDbRqq2dkA08Y1Znch1hXBRRL1cGvhRzcI2N5fRxZsK0DFRbPAj3Pygp8EuC22AId7/gwbWgUDGEtMouZjFZWiFPQc+qhNqHxtkUbRUxfFGVWNl4+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxg973ik; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPZUQH43; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2Kc2tviYJUv0wSM+PXJ2wt5GBpL9zGXMsSD7iNX6aQ=;
	b=lxg973ikBd2tvq79QwOnqVqN5oe1jqytRJdM1cAP9fdNe9b/4G345ktj5y2aN9AxaLS7/V
	8hHdSSLYehQh3Ol2QJqvcgJKgywWUx38bzyDAqjVCSKhpMyJlU6SWmJjLEQoT94LmmwIMk
	HXxEEGNNV18lnS7YjjhNyqVSWK7IyLKWW3wwH0zAl11Ru9SM1U157Ynf6EbHMC7BUtvvlf
	rmlH1JqCZxfiQsiWltfUfUOHHWFkRSnEx28BM7KJaBSCVoWlLVWU9NcApgganp7aTXvY7f
	zqOGUTX7LEXYpgYIOhBhmiX7Os8vJgg0uLYwyw4TqibzemPXhtbKScP+XruZgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2Kc2tviYJUv0wSM+PXJ2wt5GBpL9zGXMsSD7iNX6aQ=;
	b=VPZUQH435oamxnJnbjzNVhzT4Utv8uOh6TglP+sdt0ECGtewMhwQD3Py7tKgVH95Y/4vRr
	UTMHvd6tOVoWaiAQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make resctrl_mounted checks explicit
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-17-james.morse@arm.com>
References: <20240213184438.16675-17-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836784854.398.11745838351691603695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     13e5769debf09588543db83836c524148873929f
Gitweb:        https://git.kernel.org/tip/13e5769debf09588543db83836c524148873929f
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:30 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Make resctrl_mounted checks explicit

The rdt_enable_key is switched when resctrl is mounted, and used to prevent
a second mount of the filesystem. It also enables the architecture's context
switch code.

This requires another architecture to have the same set of static keys, as
resctrl depends on them too. The existing users of these static keys are
implicitly also checking if the filesystem is mounted.

Make the resctrl_mounted checks explicit: resctrl can keep track of whether it
has been mounted once. This doesn't need to be combined with whether the arch
code is context switching the CLOSID.

rdt_mon_enable_key is never used just to test that resctrl is mounted, but does
also have this implication. Add a resctrl_mounted to all uses of
rdt_mon_enable_key.

This will allow the static key changing to be moved behind resctrl_arch_ calls.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-17-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e089d1a..9bfda69 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -144,6 +144,7 @@ extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
 extern struct list_head resctrl_schema_all;
+extern bool resctrl_mounted;
 
 enum rdt_group_type {
 	RDTCTRL_GROUP = 0,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9b503e6..d5d8a58 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -813,7 +813,11 @@ void mbm_handle_overflow(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	/*
+	 * If the filesystem has been unmounted this work no longer needs to
+	 * run.
+	 */
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -846,7 +850,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	if (!static_branch_likely(&rdt_mon_enable_key))
+	/*
+	 * When a domain comes online there is no guarantee the filesystem is
+	 * mounted. If not, there is no need to catch counter overflow.
+	 */
+	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
 		return;
 	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
 	dom->mbm_work_cpu = cpu;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e42cbdf..857fbbc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -42,6 +42,9 @@ LIST_HEAD(rdt_all_groups);
 /* list of entries for the schemata file */
 LIST_HEAD(resctrl_schema_all);
 
+/* The filesystem can only be mounted once. */
+bool resctrl_mounted;
+
 /* Kernel fs node for "info" directory under root */
 static struct kernfs_node *kn_info;
 
@@ -881,7 +884,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
 	mutex_lock(&rdtgroup_mutex);
 
 	/* Return empty if resctrl has not been mounted. */
-	if (!static_branch_unlikely(&rdt_enable_key)) {
+	if (!resctrl_mounted) {
 		seq_puts(s, "res:\nmon:\n");
 		goto unlock;
 	}
@@ -2608,7 +2611,7 @@ static int rdt_get_tree(struct fs_context *fc)
 	/*
 	 * resctrl file system can only be mounted once.
 	 */
-	if (static_branch_unlikely(&rdt_enable_key)) {
+	if (resctrl_mounted) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2669,8 +2672,10 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (rdt_mon_capable)
 		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
 
-	if (rdt_alloc_capable || rdt_mon_capable)
+	if (rdt_alloc_capable || rdt_mon_capable) {
 		static_branch_enable_cpuslocked(&rdt_enable_key);
+		resctrl_mounted = true;
+	}
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
@@ -2944,6 +2949,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
+	resctrl_mounted = false;
 	kernfs_kill_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
@@ -3913,7 +3919,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
 	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		rmdir_mondata_subdir_allrdtgrp(r, d->id);
 
 	if (is_mbm_enabled())
@@ -3990,8 +3996,13 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (is_llc_occupancy_enabled())
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
-	/* If resctrl is mounted, add per domain monitor data directories. */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
+	/*
+	 * If the filesystem is not mounted then only the default resource group
+	 * exists. Creation of its directories is deferred until mount time
+	 * by rdt_get_tree() calling mkdir_mondata_all().
+	 * If resctrl is mounted, add per domain monitor data directories.
+	 */
+	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
 		mkdir_mondata_subdir_allrdtgrp(r, d);
 
 	return 0;

