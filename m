Return-Path: <linux-tip-commits+bounces-4149-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D0A5E285
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFAF19C01D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3D25C6F9;
	Wed, 12 Mar 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4uGwcmb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBn/4bX2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998E258CF1;
	Wed, 12 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800031; cv=none; b=iWpXogzIzHErDMTl3Y+u1u7DFR/eymzR+YCc3cCIyDOEWsG0UhxY0l8tlwZJDN8PjIYnfDOO9khSvKtJF0NILUW1rD1XV/Eek1yzZMxhnoSUpPt+wjykDfj8m4NZYL5ty21OEYjBSc5D5Kqy0qKyybok2eIgg1MekhUuJPI/0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800031; c=relaxed/simple;
	bh=iooWwg7u9MYcouq5wHwH730QWOkqmlqAy7YcpNxhw0Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lyZm9b1hULk8LjnWwmvQyU9vCjxHPKz9faHzPsGvPPVLZ5r7xHOrGXSGKZM0L4BuwqkCvNV+ZqRc2jCYGwRXSrl+xfq6QVtxMeedCg7SwTIDholVHYwBxGxbWfek/SuvZfAhl3i/sLv870qbp8K3CzG4fZ7YrE649kvR1aELVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4uGwcmb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBn/4bX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN9SNzMpOmnVgMySKim0YzCuhIy7mrsf8xr16D0d/Zc=;
	b=j4uGwcmbNzpecwHd3fyLuTgY2p+5DUKTnlDaSEJjDpZdxF73G/D3i5Gp9j+fIUSvwFmKuj
	goY0Liu78A/jAYVuv0P880+AtFPyiGPTO5QVPVT4GB2r7WdVD9yFYJzcU+J5j9qzA3yiL3
	01VyztxFZyEqvzr8lV0UJEQy8b32kG7n3FbbRmNZfAjZ/kTE1/nSQ9Ki5zlUB7A1A2PMK8
	RQP6NrltcTRPdA/TCmdVVi7kdd8SMQuiIzYrnEPJZGoyXAsK7Bo/uxV5daz+wGalQVpkod
	DfJi3BVls5zfytW+zmg3aKxW3HMM+57Ag/SkAcaiY4ohr3+4mRkrkt46/PFg1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN9SNzMpOmnVgMySKim0YzCuhIy7mrsf8xr16D0d/Zc=;
	b=iBn/4bX2soUeE+TSiqLRJA+02gLrXhWRMSdU8fb9/oRfwPzMwD46Jcywv2Qb9GLz0x2nHt
	x1WuN3rUcPU1HcAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add resctrl_arch_is_evt_configurable()
 to abstract BMEC
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-20-james.morse@arm.com>
References: <20250311183715.16445-20-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002634.14745.5918421025187616444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d81826f87a80a86cc5963ff3c44f05700ded3fc9
Gitweb:        https://git.kernel.org/tip/d81826f87a80a86cc5963ff3c44f05700ded3fc9
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:04 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:45 +01:00

x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC

When BMEC is supported the resctrl event can be configured in a number of
ways. This depends on architecture support. rdt_get_mon_l3_config() modifies
the struct mon_evt and calls resctrl_file_fflags_init() to create the files
that allow the configuration.

Splitting this into separate architecture and filesystem parts would require
the struct mon_evt and resctrl_file_fflags_init() to be exposed.

Instead, add resctrl_arch_is_evt_configurable(), and use this from
resctrl_mon_resource_init() to initialise struct mon_evt and call
resctrl_file_fflags_init().

resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't obviously
benefit from being inlined. Putting it in core.c will allow rdt_cpu_has() to
eventually become static.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-20-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c    | 15 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c | 22 +++++++++++-----------
 include/linux/resctrl.h               |  2 ++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index eba210d..6f0d1bb 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -830,6 +830,21 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+{
+	if (!rdt_cpu_has(X86_FEATURE_BMEC))
+		return false;
+
+	switch (evt) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL);
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL);
+	default:
+		return false;
+	}
+}
+
 static __init bool get_mem_config(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d883ed5..27d9831 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1202,6 +1202,17 @@ int __init resctrl_mon_resource_init(void)
 
 	l3_mon_evt_init(r);
 
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
+		mbm_total_event.configurable = true;
+		resctrl_file_fflags_init("mbm_total_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
+		mbm_local_event.configurable = true;
+		resctrl_file_fflags_init("mbm_local_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+
 	return 0;
 }
 
@@ -1245,17 +1256,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
-
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-			mbm_total_event.configurable = true;
-			resctrl_file_fflags_init("mbm_total_bytes_config",
-						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-		}
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-			mbm_local_event.configurable = true;
-			resctrl_file_fflags_init("mbm_local_bytes_config",
-						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-		}
 	}
 
 	r->mon_capable = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a392480..cc76f30 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -309,6 +309,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.

