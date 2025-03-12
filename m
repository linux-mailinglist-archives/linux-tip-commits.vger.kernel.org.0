Return-Path: <linux-tip-commits+bounces-4162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD2A5E2A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C73BC484
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0925F992;
	Wed, 12 Mar 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgOIaG1s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjpDNIK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5525E817;
	Wed, 12 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800042; cv=none; b=iWhQUBA1zWHeFrUaIhL+FkNvx9ffHpA9nL7xNRFwDyp/I/PpC9t553ASJOg+/B2imKFEaNG2aGNGStPAtq4yKB9THzFjvK7lpMVqyANbtw6wTIajxD/hf8TGTYwThOaBrfRb4KtgA6gDJW1kURS9I9yg1QtqbJedi7Rb7KpbnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800042; c=relaxed/simple;
	bh=WxG0Ek7ELZx4Jhl88ofMlJcbmL4+792+KAbhxBlQN50=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tmYCSvCHR8MVyd4eZ0aGLVLLDHNe1RNcxD6JElYsJJA/+30GcEjjvTEd8tt52IkgMsr9Muc2w3Scj+pBUvaHJ6fTlKmJ6cgdAAz/QUj8bheRmY/4C4M6+2GSXWN5Jwg5XOPnBdhDIrCRsXGrB9dgi+e+3ZEkxsOqfNE1qiexfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgOIaG1s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjpDNIK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq0Z5tPyqBPs0WdFIlkyk8kWp8l5nm3GzkBmSYW4BRg=;
	b=xgOIaG1s9g5ySG/P7P2S/R9mI15GDLqmi78lUU6dhinIDR1sMUo736pUbJnHPtYzOKClzJ
	qt7pXCMkRALYjCA3hpfSf8/HplogiSy/ZZKlxdMfMwvqi1jKG6okJOXOh2cqS3CS9Gzidl
	HqL5nGSF9aVyflVHXPnOOFLuBUIlqOcTD9h6qrYcH3aDeLtNtSuWv50hdRdKrzxGGyq+7X
	P531VgNFpo98++C0UCG+STahZquxHtyqgfyMbwNzAc14WHDy0gIg/1s3x3fz/3kzyJAyg2
	/MPNEkHBb6tK1BAduiMAEozPO1UujqGTp+ZcamhwIVykV5Vajb1mth04m/n/KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq0Z5tPyqBPs0WdFIlkyk8kWp8l5nm3GzkBmSYW4BRg=;
	b=TjpDNIK3h6h2oaYUx/BU43y19ejo+JOnXMSMB3qDJEWJ89vndDnhkaIP9KQKQjtH/1rkMH
	wn8qWEKALfmCUuCQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Remove data_width and the tabular format
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-7-james.morse@arm.com>
References: <20250311183715.16445-7-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003687.14745.12857836521662809331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     43312b8ea1c61abbc5e3bdc87fe2e18f755d549d
Gitweb:        https://git.kernel.org/tip/43312b8ea1c61abbc5e3bdc87fe2e18f755d549d
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:51 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:36 +01:00

x86/resctrl: Remove data_width and the tabular format

The resctrl architecture code provides a data_width for the controls of each
resource. This is used to zero pad all control values in the schemata file so
they appear in columns. The same is done with the resource names to complete
the visual effect. e.g.

  | SMBA:0=2048
  |   L3:0=00ff

AMD platforms discover their maximum bandwidth for the MB resource from
firmware, but hard-code the data_width to 4. If the maximum bandwidth requires
more digits - the tabular format is silently broken.  This is also broken when
the mba_MBps mount option is used as the field width isn't updated. If new
schema are added resctrl will need to be able to determine the maximum width.
The benefit of this pretty-printing is questionable.

Instead of handling runtime discovery of the data_width for AMD platforms,
remove the feature. These fields are always zero padded so should be harmless
to remove if the whole field has been treated as a number.  In the above
example, this would now look like this:

  | SMBA:0=2048
  |   L3:0=ff

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-7-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 26 +----------------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 10 ++++++--
 include/linux/resctrl.h                   |  2 +--
 5 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 542503a..754fb65 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -44,12 +44,6 @@ static DEFINE_MUTEX(domain_list_lock);
 DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 /*
- * Used to store the max resource name width and max resource data width
- * to display the schemata in a tabular format
- */
-int max_name_width, max_data_width;
-
-/*
  * Global boolean for rdt_alloc which is true if any
  * resource allocation is enabled.
  */
@@ -228,7 +222,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 			return false;
 		r->membw.arch_needs_linear = false;
 	}
-	r->data_width = 3;
 
 	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
@@ -269,8 +262,6 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
-	/* Max value is 2048, Data width should be 4 in decimal */
-	r->data_width = 4;
 
 	r->alloc_capable = true;
 
@@ -290,7 +281,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -786,20 +776,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Choose a width for the resource name and resource data based on the
- * resource that has widest name and cbm.
- */
-static __init void rdt_init_padding(void)
-{
-	struct rdt_resource *r;
-
-	for_each_alloc_capable_rdt_resource(r) {
-		if (r->data_width > max_data_width)
-			max_data_width = r->data_width;
-	}
-}
-
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
@@ -1102,8 +1078,6 @@ static int __init resctrl_late_init(void)
 	if (!get_rdt_resources())
 		return -ENODEV;
 
-	rdt_init_padding();
-
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
 				  resctrl_arch_online_cpu,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index c763cb4..59610b2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -487,8 +487,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
-			   ctrl_val);
+		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b5543bd..f975cd6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -326,7 +326,7 @@ struct rdtgroup {
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
-extern int max_name_width, max_data_width;
+extern int max_name_width;
 
 int __init rdtgroup_init(void);
 void __exit rdtgroup_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e7862d0..1e0bae1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -57,6 +57,12 @@ static struct kernfs_node *kn_mongrp;
 /* Kernel fs node for "mon_data" directory under root */
 static struct kernfs_node *kn_mondata;
 
+/*
+ * Used to store the max resource name width to display the schemata names in
+ * a tabular format.
+ */
+int max_name_width;
+
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
@@ -2613,10 +2619,10 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 	switch (r->schema_fmt) {
 	case RESCTRL_SCHEMA_BITMAP:
-		s->fmt_str = "%d=%0*x";
+		s->fmt_str = "%d=%x";
 		break;
 	case RESCTRL_SCHEMA_RANGE:
-		s->fmt_str = "%d=%0*u";
+		s->fmt_str = "%d=%u";
 		break;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 736b9a9..e1a982a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -214,7 +214,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
@@ -232,7 +231,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	int			data_width;
 	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;

