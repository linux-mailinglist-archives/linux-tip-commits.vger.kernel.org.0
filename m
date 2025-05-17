Return-Path: <linux-tip-commits+bounces-5651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A0ABA961
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5EF7AAA01
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38DB208961;
	Sat, 17 May 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eixgz7+F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqcOjxal"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21E1EBFE0;
	Sat, 17 May 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476185; cv=none; b=KmgrNQnj5gougfEJpqMCKpdRNbOA+yvDWU2YWfcOhLlhu53SLmQG/9Vhh81gCCZGlGcDJPnjKvRXbTcyFzmav8Ulf4qtBMPiuY3HB1s6d/n5B5ddNx8ehXQkGmbkhm2JBYyGJ7cksBFICL23nVaxG2KHo2AZ0VV6qchmb0ItJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476185; c=relaxed/simple;
	bh=1LmAh78B5dLScJILXSD97EUTEtmoDzhOjs6z/46Vgy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E0NfCDi5bnPEVqTbe8bJM59xLPQgmrG97mKhGhCd9oL2BzCPZUegcQufJRLhmh4HTT0qqj29PgamjZv0dbJHPVhnvC4NtZNqo4JNL7AjGR0/An3tZ/3vfIlul0eRXM3MBCLYgDMH7KGKNjfuznxO2LXj5MLET2zU0AarQfa1xrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eixgz7+F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqcOjxal; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMvU3pWGtA7jFKzkvUfmgiiwhZrXtbiJVaxO386WDi8=;
	b=Eixgz7+FU/Qyys85u+GAJp0W8Su7bJyoAgjUyD3ILCpG+4cu7MuYfYkk14zhKDftzQnqCe
	lLdDh9TRtdsB51RcCXTAqaOSp0ixI5Gp5gkvwcX0S5+pChBIZfF6WyTmsHov3X1yfxqx0h
	vhVWSEVkGEWfghbHwzMVMGzlCNMLCiARedBoFhgl1q9Ohuc3+eOUWh0Q/US6xcpqoMvR3t
	7PqsD7C5aZ6OqwYb1B+agG4OfUiJJz4sLhGzQEcezXspYTracJ1d3r6JpNOZRgnJfTwOjz
	2lPtHOuIkyqPCWMOhPsjzT2lVG5OQzYIiNXEOVSpw/0RDMx/QPbQt54U4TjvqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMvU3pWGtA7jFKzkvUfmgiiwhZrXtbiJVaxO386WDi8=;
	b=uqcOjxalLY9JlqM75KmQeXk9JEcPj450oS7PCotiIWAAkI0/wDyIJIbQurIIluPInu+BZB
	jeVXaTHbGS9l5DAQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Drop __init/__exit on assorted symbols
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-10-james.morse@arm.com>
References: <20250515165855.31452-10-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618096.406.10252267034014472358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     bc740420d7ae7878696d5ad9f3dbcb11e2599b2e
Gitweb:        https://git.kernel.org/tip/bc740420d7ae7878696d5ad9f3dbcb11e2599b2e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:39 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 21:06:02 +02:00

x86/resctrl: Drop __init/__exit on assorted symbols

Because ARM's MPAM controls are probed using MMIO, resctrl can't be
initialised until enough CPUs are online to have determined the system-wide
supported num_closid. Arm64 also supports 'late onlined secondaries', where
only a subset of CPUs are online during boot.

These two combine to mean the MPAM driver may not be able to initialise
resctrl until user-space has brought 'enough' CPUs online.

To allow MPAM to initialise resctrl after __init text has been free'd, remove
all the __init markings from resctrl.

The existing __exit markings cause these functions to be removed by the linker
as it has never been possible to build resctrl as a module. MPAM has an error
interrupt which causes the driver to reset and disable itself. Remove the
__exit markings to allow the MPAM driver to tear down resctrl when an error
occurs.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-10-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 6 +++---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cf29681..31538c6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -737,7 +737,7 @@ struct rdt_options {
 	bool	force_off, force_on;
 };
 
-static struct rdt_options rdt_options[]  __initdata = {
+static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
@@ -777,7 +777,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-bool __init rdt_cpu_has(int flag)
+bool rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
@@ -797,7 +797,7 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
-__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	if (!rdt_cpu_has(X86_FEATURE_BMEC))
 		return false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 25b61e4..576383a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -472,13 +472,13 @@ int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void resctrl_mon_resource_exit(void);
-bool __init rdt_cpu_has(int flag);
+bool rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
-int __init resctrl_mon_resource_init(void);
+int resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a93ed7d..73e3fe4 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1204,7 +1204,7 @@ static __init int snc_get_config(void)
  *
  * Returns 0 for success, or -ENOMEM.
  */
-int __init resctrl_mon_resource_init(void)
+int resctrl_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e48c61..cfd846c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4144,7 +4144,7 @@ static void rdtgroup_destroy_root(void)
 	rdtgroup_default.kn = NULL;
 }
 
-static void __init rdtgroup_setup_default(void)
+static void rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -4376,7 +4376,7 @@ out_unlock:
  *
  * Return: 0 on success or -errno
  */
-int __init resctrl_init(void)
+int resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4433,7 +4433,7 @@ cleanup_mountpoint:
 	return ret;
 }
 
-static bool __exit resctrl_online_domains_exist(void)
+static bool resctrl_online_domains_exist(void)
 {
 	struct rdt_resource *r;
 
@@ -4471,7 +4471,7 @@ static bool __exit resctrl_online_domains_exist(void)
  * resctrl_arch_get_resource() must continue to return struct rdt_resources
  * with the correct rid field to ensure the filesystem can be unmounted.
  */
-void __exit resctrl_exit(void)
+void resctrl_exit(void)
 {
 	cpus_read_lock();
 	WARN_ON_ONCE(resctrl_online_domains_exist());
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 880351c..b8f8240 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -358,7 +358,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
-__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
  * resctrl_arch_mon_event_config_write() - Write the config for an event.
@@ -514,7 +514,7 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-int __init resctrl_init(void);
-void __exit resctrl_exit(void);
+int resctrl_init(void);
+void resctrl_exit(void);
 
 #endif /* _RESCTRL_H */

