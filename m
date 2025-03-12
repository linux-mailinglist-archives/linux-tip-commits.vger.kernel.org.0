Return-Path: <linux-tip-commits+bounces-4152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BAA5E289
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A790517C273
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15525D1F4;
	Wed, 12 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osGDAqM9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVuNm4v8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E525BAB4;
	Wed, 12 Mar 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800032; cv=none; b=PV/RQpkzNxmtEotmpM33tbf/5PygyphH8MHhpqF8dlEAECXYd8E8DwVBlalDKZaZTHD47lTso4KMVq8Bwq8CHPI+Qwyvv4SiVzGM8YSA5WApTKcsPdM6+4fpSzKSlHQA/rzA8zk56OrphQb83c2F5telkYl2WkW76WA24crYMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800032; c=relaxed/simple;
	bh=sGEpY/FbPMSW+WyWWKaTI2W4P9YKN/GDXHM9hNL08kc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aH//nPeI4rGVxRPFrDp+j1+TFjD0aufYYupc/mUT3iHmcpPMWEYBr+MLdIZapyeXs+R3txMEBI92lxNiJ/VxITubnLO1gx/ym6+ycQGU+oYdDBqXIETv9hH0Px7jl2bZPmtNxktcg/erdClCaOEsB6uSi48tI6cCWPRFu3Zud3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osGDAqM9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVuNm4v8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5m5n4SC2TIcKBkCS4OfzmolVWa3HDMXCRziN3OEF9Y=;
	b=osGDAqM9xjcyyFEoeAkVLsD6+l/q3IVmo8WRapK4hiLajdnpGrPRyc6YZPwO4DpE7Nld6X
	DyJQB1WgZRK9Y52aTPaQFWVRqoEABeRUECcAhNt5bDsRTyFYSzWCocLi0rBKehYUf6qTTi
	Z6tY9oKy5O7dz/a68smvK19ci61/b5u63WWcJDHDs5gHapaFRQ7VFxZ3qWZmHTwhOKxIvA
	+EY2zdCVuYplbqj9ThaH0dynJzokgCJeylukN9NSouFd0MYUj3pG42RX/vxW5sYsrUU7Q2
	MHberIHKFntJF4d2NOd03qNK2Ide8NQlkCR7J/auBFtReWL1c5YdMDyTc1wQ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5m5n4SC2TIcKBkCS4OfzmolVWa3HDMXCRziN3OEF9Y=;
	b=aVuNm4v8T6JFK6ADU9WZosvXWbRlQyyUiAFK9agKgqwYrNzUhSgdz8coldu9kVtHlQVDv8
	ZwwZVfAMjJnsf8Cw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Move monitor init work to a resctrl init call
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-17-james.morse@arm.com>
References: <20250311183715.16445-17-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002851.14745.13965399828209194118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4b6bdbf27fcee16944911155293771b880344ef0
Gitweb:        https://git.kernel.org/tip/4b6bdbf27fcee16944911155293771b880344ef0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:01 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:21 +01:00

x86/resctrl: Move monitor init work to a resctrl init call

rdt_get_mon_l3_config() is called from the arch's resctrl_arch_late_init(),
and initialises both architecture specific fields, such as hw_res->mon_scale
and resctrl filesystem fields by calling dom_data_init().

To separate the filesystem and architecture parts of resctrl, this function
needs splitting up.

Add resctrl_mon_resource_init() to do the filesystem specific work, and call
it from resctrl_init(). This runs later, but is still before the filesystem is
mounted and the rmid_ptrs[] array can be used.

  [ bp: Massage commit message. ]

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
Link: https://lore.kernel.org/r/20250311183715.16445-17-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 40 +++++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 22 +++++++++++++-
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 73005ca..70fbb90 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -586,13 +586,14 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit resctrl_mon_resource_exit(void);
+void resctrl_mon_resource_exit(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
+int __init resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 15e8c01..1730ba8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1040,7 +1040,7 @@ out_unlock:
 	return err;
 }
 
-static void __exit dom_data_exit(struct rdt_resource *r)
+static void dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -1176,12 +1176,40 @@ static __init int snc_get_config(void)
 	return ret;
 }
 
+/**
+ * resctrl_mon_resource_init() - Initialise global monitoring structures.
+ *
+ * Allocate and initialise global monitor resources that do not belong to a
+ * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * Called once during boot after the struct rdt_resource's have been configured
+ * but before the filesystem is mounted.
+ * Resctrl's cpuhp callbacks may be called before this point to bring a domain
+ * online.
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
+int __init resctrl_mon_resource_init(void)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	int ret;
+
+	if (!r->mon_capable)
+		return 0;
+
+	ret = dom_data_init(r);
+	if (ret)
+		return ret;
+
+	l3_mon_evt_init(r);
+
+	return 0;
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
-	int ret;
 
 	snc_nodes_per_l3_cache = snc_get_config();
 
@@ -1211,10 +1239,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1234,14 +1258,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
-	l3_mon_evt_init(r);
-
 	r->mon_capable = true;
 
 	return 0;
 }
 
-void __exit resctrl_mon_resource_exit(void)
+void resctrl_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 42c48e7..badac3f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4102,6 +4102,19 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	mutex_unlock(&rdtgroup_mutex);
 }
 
+/**
+ * domain_setup_mon_state() -  Initialise domain monitoring structures.
+ * @r:	The resource for the newly online domain.
+ * @d:	The newly online domain.
+ *
+ * Allocate monitor resources that belong to this domain.
+ * Called when the first CPU of a domain comes online, regardless of whether
+ * the filesystem is mounted.
+ * During boot this may be called before global allocations have been made by
+ * resctrl_mon_resource_init().
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -4252,10 +4265,16 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
-	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
+	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
 
+	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
+	if (ret) {
+		resctrl_mon_resource_exit();
+		return ret;
+	}
+
 	ret = register_filesystem(&rdt_fs_type);
 	if (ret)
 		goto cleanup_mountpoint;
@@ -4287,6 +4306,7 @@ int __init resctrl_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	resctrl_mon_resource_exit();
 
 	return ret;
 }

