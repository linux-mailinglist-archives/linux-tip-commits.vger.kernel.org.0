Return-Path: <linux-tip-commits+bounces-4139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CFA5E26B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865081898BDE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053F250BE9;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZx5Dc34";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNfFh7Ip"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB82356D8;
	Wed, 12 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800022; cv=none; b=fbr0TO4XDAMhCwjDawDKmiIcHPwlODzi2kfnAFCBpMZi2RUXmJbUCSFdexf7Y8iBFiaaJ/E/eXa8ibKP8fZYb56w+ExnBGPl2/h5LMzG8sH7GwQ+w7PcN8J8brzuQ8tJx2i6UCtyl2HCmHWF3Xg76kLDhHPVcFtLUGgOMYQHUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800022; c=relaxed/simple;
	bh=Oo+wj5WTItArvyK5govqtpV5u3IMIKxHLwGt/e15Rr8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QMbeKqOv+SlJTyrhfJEz7hrY+dJ34JyYq+XiTIhKROquxA3yFX4G444U2kfJJWcrZNIqSyddXGoAxpC9Dyin1ZU/XGkXxjGwHocVivOsyu/WcXq4s1pXLQ92iMYL0IZsoIR8As/WcVdO5xLlrR1TyURjm0zTvDFX/tGhbJ/WgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZx5Dc34; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNfFh7Ip; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU8fMC2f2ss7t5LryrUbgIveCJxEzgz/Kpd7BOjYbsU=;
	b=JZx5Dc34Q4dS+mn3TiGTPiZBpK7wAzH5uB7JKr00Cw9GHnmZqJPw4q81l1g9vuUjg2Ey0k
	T3vTXReGRkSUMZNWSM8x6Jm3PWT23NVM90BwvLKVGYvFYJRQcu9+T9emE1Ms2gIT+09aWL
	p19e0u/kV6mefyjUn0EI7pz8BKvSVP+CdO6BcBjN3ACEVzm+RmXJSj83F0aA+3Ga+fZFxF
	VXRhRlwTxavS/5WqVhPUWN96ZAhD7to2KhW7rOYyAtxwxInQrsTIWvHGkVRFAbEhOkjhVV
	3JIgxMfkYg5s3Z4WUkzSg6EHZhrlky7s023JVI4gHyMpBrbqv0iukgK/puESqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU8fMC2f2ss7t5LryrUbgIveCJxEzgz/Kpd7BOjYbsU=;
	b=rNfFh7IpncMdDa1ExXWbl+oQG4sxx4ExtU2gwTs5yGoqdjgcTm4N1B6GyJSLGdM262/1tI
	d+ai1c9GLhtvdpCQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move get_config_index() to a header
Cc: Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-30-james.morse@arm.com>
References: <20250311183715.16445-30-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180001778.14745.7862486195213062297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f62b4e45e0b467cba75ae816338b996c6dc4dafa
Gitweb:        https://git.kernel.org/tip/f62b4e45e0b467cba75ae816338b996c6dc4dafa
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:14 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:54 +01:00

x86/resctrl: Move get_config_index() to a header

get_config_index() is used by the architecture specific code to map
a CLOSID+type pair to an index in the configuration arrays.

MPAM needs to do this too to preserve the ABI to user-space, there is no
reason to do it differently.

Move the helper to a header file to allow all architectures that either
use or emulate CDP to use the same pattern of CLOSID values. Moving
this to a header file means it must be marked inline, which matches
the existing compiler choice for this static function.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-30-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
 include/linux/resctrl.h                   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1ecc932..0a0ac5f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -287,25 +287,12 @@ next:
 	return -EINVAL;
 }
 
-static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
-{
-	switch (type) {
-	default:
-	case CDP_NONE:
-		return closid;
-	case CDP_CODE:
-		return closid * 2 + 1;
-	case CDP_DATA:
-		return closid * 2;
-	}
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	u32 idx = get_config_index(closid, t);
+	u32 idx = resctrl_get_config_index(closid, t);
 	struct msr_param msr_param;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
@@ -342,7 +329,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = get_config_index(closid, t);
+			idx = resctrl_get_config_index(closid, t);
 			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
 			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
@@ -462,7 +449,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
-	u32 idx = get_config_index(closid, type);
+	u32 idx = resctrl_get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 226cc5c..880351c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
  */
 void resctrl_arch_mon_event_config_read(void *config_info);
 
+/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
+static inline u32 resctrl_get_config_index(u32 closid,
+					   enum resctrl_conf_type type)
+{
+	switch (type) {
+	default:
+	case CDP_NONE:
+		return closid;
+	case CDP_CODE:
+		return closid * 2 + 1;
+	case CDP_DATA:
+		return closid * 2;
+	}
+}
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.

