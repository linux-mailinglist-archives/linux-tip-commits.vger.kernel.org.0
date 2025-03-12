Return-Path: <linux-tip-commits+bounces-4157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B39A5E294
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BF41898B58
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB325DCF1;
	Wed, 12 Mar 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCEar7SR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIA1cGqA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB325D553;
	Wed, 12 Mar 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800037; cv=none; b=c0Sqbw4oN89iXGyfK6/Potd/m2H1tBZraGqRcTRmgdLADQKpM4Pp8iPtqg9RtxlrV5hJOLefMiaTM2/hahdSqpXnKo5eyohJeUdw861OAPfgV4fWaz2Rfeqe8yCY0+CwEjuu0Y6pXr6oOe9CFY2eeOB55M70a6kTW2Gql3sslow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800037; c=relaxed/simple;
	bh=KpFfhYGmIRntdP/OLtCQDfFkHW5UJerYdEmcfzc4qV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pyzYQ9X2+JdWtSARStHAoCaWM5HKenEi1BkT/ETKxNccEhlbkX7V89+O3N8VHrqe2/vsmI1WzotKvW7xUybO50dc8gH9qkHCLWqFdt9oWZiEh7/vNO6YckmlDKfDNhNm4g0X4wAnjZyQMZWzHaKo/75KLxY8yqnGplRekw/rAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCEar7SR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIA1cGqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/q5daCumh3uOfI5nBSigCHX0rWHjQ+/dkO2amjHDoQI=;
	b=ZCEar7SRptjVkiDB9Z3n4vjr8n0uL/sVBCLHKWR+VGu6/CZpehP+4x/7gDEL+nULo665al
	oeERFGXozVdODqKC/zjqJVp23g7rmRFaEVW86c3JMYLafU5XuejTPuUNLFNKwnv3aIZs3E
	TdHxJBZdBkJqmGUOtJ9vGSklYoem1h0/s2RS1sySLXIgJa3D2PZOG43PmaGmPhS5AsGflI
	N+SIIBRrt6QtW6trhRZj+iAwsp8aDZFvx70TYAy1e48FUpsvWJXB+QmUGl7MLpbqugM02Z
	jdqpW13RMpfPcQLmoNQbc5FZEBwKJKY2I93g7CvXfRCtIWobaXqMs02RsnMkAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/q5daCumh3uOfI5nBSigCHX0rWHjQ+/dkO2amjHDoQI=;
	b=JIA1cGqA2t9fmis1YUgQIOmilLd/RtEsRYgO1SNetuT5ivjBrC79DkKFLDkb/Rm4RYXKg+
	fxP7c2P7OxfX2VBg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Expose resctrl fs's init function to
 the rest of the kernel
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-12-james.morse@arm.com>
References: <20250311183715.16445-12-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003252.14745.14687879471569530856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8079565d177f5c4eac6c2ee2ac6c404eee76d500
Gitweb:        https://git.kernel.org/tip/8079565d177f5c4eac6c2ee2ac6c404eee76d500
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:54 +01:00

x86/resctrl: Expose resctrl fs's init function to the rest of the kernel

rdtgroup_init() needs exposing to the rest of the kernel so that arch code can
call it once it lives in core code. As this is one of the few functions
exposed, rename it to have "resctrl" in the name. The same goes for the exit
call.

Rename x86's arch code init functions for RDT to have an arch prefix to make
it clear these are part of the architecture code.

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
Link: https://lore.kernel.org/r/20250311183715.16445-12-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                |  3 +++
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d001ca4..2129951 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1061,7 +1061,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
 
-static int __init resctrl_late_init(void)
+static int __init resctrl_arch_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -1084,7 +1084,7 @@ static int __init resctrl_late_init(void)
 	if (state < 0)
 		return state;
 
-	ret = rdtgroup_init();
+	ret = resctrl_init();
 	if (ret) {
 		cpuhp_remove_state(state);
 		return ret;
@@ -1100,18 +1100,18 @@ static int __init resctrl_late_init(void)
 	return 0;
 }
 
-late_initcall(resctrl_late_init);
+late_initcall(resctrl_arch_late_init);
 
-static void __exit resctrl_exit(void)
+static void __exit resctrl_arch_exit(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	cpuhp_remove_state(rdt_online);
 
-	rdtgroup_exit();
+	resctrl_exit();
 
 	if (r->mon_capable)
 		rdt_put_mon_l3_config();
 }
 
-__exitcall(resctrl_exit);
+__exitcall(resctrl_arch_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f975cd6..8291f1b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -328,9 +328,6 @@ extern struct list_head rdt_all_groups;
 
 extern int max_name_width;
 
-int __init rdtgroup_init(void);
-void __exit rdtgroup_exit(void);
-
 /**
  * struct rftype - describe each file in the resctrl file system
  * @name:	File name
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 58b5b21..e8388d1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1027,7 +1027,7 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in rdtgroup_init().
+	 * control group, which will be setup later in resctrl_init().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 62d9a50..b2dad68 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4235,14 +4235,14 @@ out_unlock:
 }
 
 /*
- * rdtgroup_init - rdtgroup initialization
+ * resctrl_init - resctrl filesystem initialization
  *
  * Setup resctrl file system including set up root, create mount point,
- * register rdtgroup filesystem, and initialize files under root directory.
+ * register resctrl filesystem, and initialize files under root directory.
  *
  * Return: 0 on success or -errno
  */
-int __init rdtgroup_init(void)
+int __init resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4290,7 +4290,7 @@ cleanup_mountpoint:
 	return ret;
 }
 
-void __exit rdtgroup_exit(void)
+void __exit resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 31808b3..f1979e3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -402,4 +402,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int __init resctrl_init(void);
+void __exit resctrl_exit(void);
+
 #endif /* _RESCTRL_H */

