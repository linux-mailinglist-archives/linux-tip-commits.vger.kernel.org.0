Return-Path: <linux-tip-commits+bounces-4142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4349A5E276
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E22B3BBE81
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E042580CA;
	Wed, 12 Mar 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgTUHn/G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nqi2UGX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D4253322;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800025; cv=none; b=grtf/UD+rWltx56S8kspbSBh89Hp3bFXTyEP/0/VFpyImNIdwUarkVEMYs9TLwfm4jlhd1iXrJi7rvXECI57lWkHN+dtMbK1O6UMACmuDxE+kj/vQFg73YQMHFV35JOmAdfehawptS/0zT7FmUWCzt4lAXcUlJ9Ds//p+q9HruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800025; c=relaxed/simple;
	bh=kdzp2MvUahiT+/kCdu2GKNLAwFBNpD9Im6xENPRJ6Vs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FXd3MvfzCRggn3Wk3wsioHuV4aa5JMspeI4SpP1wHZC2uPZpkvl0XpR9zT1+2OTBTRLobto2Jz3WcaEiSVSn0Gr16rhLlB+ri7nUixCHOSLYw4zcjQX0YnNBjII7rjSKMzRbflxJH9bTH5CYyPeE5x9YOYnRZZufiJaX1ybY4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgTUHn/G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nqi2UGX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7TQ+4PjJYlDAl71R00BL1fkcdhYNfyV9pHGh4e7eCw=;
	b=jgTUHn/GZJRcn4IxeBuC+3SmAjltgioMPVQw/F27ObN31YNFv2n0VkH/Dt9VoXQkywfbCh
	7XCC3R2fIgfrJU02WGL8Nh8+zHpo2CvsgweYpb0Yf3yaElD/PDuZTCtMrPGmKRNMxvD0/K
	ptY/osUouxpW1dwQ2LkEwaBREglBxrBvmo0uNLvv30U4Tp4ZCdKM7rEZgf30N3Ze+n23OD
	riGlbCXZ2CVFEa7DN5vgjxjNeEmDuQ7dqVMDyABMZl7onQgGzmzjdIqGQ/CspOCvkaExCH
	Qda706rQV9j3pVZ88yOXsoLZ7+zLN8OBfYS//Th3V7mj3BUJzKlzfhDasErHgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7TQ+4PjJYlDAl71R00BL1fkcdhYNfyV9pHGh4e7eCw=;
	b=4nqi2UGXwcaqiBQqgjjpYNWCAN6sEoAl+ceh+vRKr1JxjER/+/hwfPx4v1+S6zBpogyUDB
	CvwRjx4oeDLkf7CQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-27-james.morse@arm.com>
References: <20250311183715.16445-27-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002033.14745.11512774629570617548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4cf9acfc8f1a322576f0666b882d631cfdf714bf
Gitweb:        https://git.kernel.org/tip/4cf9acfc8f1a322576f0666b882d631cfdf714bf
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:11 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:33 +01:00

x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr

resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
and takes a struct rdtgroup as an argument.

After the filesystem code moves to /fs/, the definition of struct
rdtgroup will not be available to the architecture code.

The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
for the CLOSID. Embed that in the pseudo_lock_region as a closid,
and move the definition of struct pseudo_lock_region to resctrl.h.

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
Link: https://lore.kernel.org/r/20250311183715.16445-27-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h            |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 37 +---------------------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 12 +++----
 include/linux/resctrl.h                   | 39 ++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 86407db..011bf67 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -204,7 +204,7 @@ static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
 					     void *ctx) { };
 
 u64 resctrl_arch_get_prefetch_disable_bits(void);
-int resctrl_arch_pseudo_lock_fn(void *_rdtgrp);
+int resctrl_arch_pseudo_lock_fn(void *_plr);
 int resctrl_arch_measure_cycles_lat_fn(void *_plr);
 int resctrl_arch_measure_l2_residency(void *_plr);
 int resctrl_arch_measure_l3_residency(void *_plr);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8d35bb4..0d13006 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -209,43 +209,6 @@ struct mongroup {
 };
 
 /**
- * struct pseudo_lock_region - pseudo-lock region information
- * @s:			Resctrl schema for the resource to which this
- *			pseudo-locked region belongs
- * @d:			RDT domain to which this pseudo-locked region
- *			belongs
- * @cbm:		bitmask of the pseudo-locked region
- * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
- *			completion
- * @thread_done:	variable used by waitqueue to test if pseudo-locking
- *			thread completed
- * @cpu:		core associated with the cache on which the setup code
- *			will be run
- * @line_size:		size of the cache lines
- * @size:		size of pseudo-locked region in bytes
- * @kmem:		the kernel memory associated with pseudo-locked region
- * @minor:		minor number of character device associated with this
- *			region
- * @debugfs_dir:	pointer to this region's directory in the debugfs
- *			filesystem
- * @pm_reqs:		Power management QoS requests related to this region
- */
-struct pseudo_lock_region {
-	struct resctrl_schema	*s;
-	struct rdt_ctrl_domain	*d;
-	u32			cbm;
-	wait_queue_head_t	lock_thread_wq;
-	int			thread_done;
-	int			cpu;
-	unsigned int		line_size;
-	unsigned int		size;
-	void			*kmem;
-	unsigned int		minor;
-	struct dentry		*debugfs_dir;
-	struct list_head	pm_reqs;
-};
-
-/**
  * struct rdtgroup - store rdtgroup's data in resctrl file system.
  * @kn:				kernfs node
  * @rdtgroup_list:		linked list for all rdtgroups
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 90044a0..01fa789 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -414,7 +414,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 
 /**
  * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
- * @_rdtgrp: resource group to which pseudo-lock region belongs
+ * @_plr: the pseudo-lock region descriptor
  *
  * This is the core pseudo-locking flow.
  *
@@ -431,10 +431,9 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
+int resctrl_arch_pseudo_lock_fn(void *_plr)
 {
-	struct rdtgroup *rdtgrp = _rdtgrp;
-	struct pseudo_lock_region *plr = rdtgrp->plr;
+	struct pseudo_lock_region *plr = _plr;
 	u32 rmid_p, closid_p;
 	unsigned long i;
 	u64 saved_msr;
@@ -494,7 +493,8 @@ int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
 	 * pseudo-locked followed by reading of kernel memory to load it
 	 * into the cache.
 	 */
-	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, plr->closid);
+
 	/*
 	 * Cache was flushed earlier. Now access kernel memory to read it
 	 * into cache region associated with just activated plr->closid.
@@ -1312,7 +1312,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_run_on_cpu(resctrl_arch_pseudo_lock_fn, rdtgrp,
+	thread = kthread_run_on_cpu(resctrl_arch_pseudo_lock_fn, plr,
 				    plr->cpu, "pseudo_lock/%u");
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 914df24..226cc5c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -58,6 +58,45 @@ enum resctrl_conf_type {
 
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
+/*
+ * struct pseudo_lock_region - pseudo-lock region information
+ * @s:			Resctrl schema for the resource to which this
+ *			pseudo-locked region belongs
+ * @closid:		The closid that this pseudo-locked region uses
+ * @d:			RDT domain to which this pseudo-locked region
+ *			belongs
+ * @cbm:		bitmask of the pseudo-locked region
+ * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
+ *			completion
+ * @thread_done:	variable used by waitqueue to test if pseudo-locking
+ *			thread completed
+ * @cpu:		core associated with the cache on which the setup code
+ *			will be run
+ * @line_size:		size of the cache lines
+ * @size:		size of pseudo-locked region in bytes
+ * @kmem:		the kernel memory associated with pseudo-locked region
+ * @minor:		minor number of character device associated with this
+ *			region
+ * @debugfs_dir:	pointer to this region's directory in the debugfs
+ *			filesystem
+ * @pm_reqs:		Power management QoS requests related to this region
+ */
+struct pseudo_lock_region {
+	struct resctrl_schema	*s;
+	u32			closid;
+	struct rdt_ctrl_domain	*d;
+	u32			cbm;
+	wait_queue_head_t	lock_thread_wq;
+	int			thread_done;
+	int			cpu;
+	unsigned int		line_size;
+	unsigned int		size;
+	void			*kmem;
+	unsigned int		minor;
+	struct dentry		*debugfs_dir;
+	struct list_head	pm_reqs;
+};
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded

