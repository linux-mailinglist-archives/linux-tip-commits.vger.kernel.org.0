Return-Path: <linux-tip-commits+bounces-6627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2BB57857
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B7D1884969
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4C306B28;
	Mon, 15 Sep 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJ4HYtpn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xb47EVPC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE53306B06;
	Mon, 15 Sep 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935675; cv=none; b=sGvBzkQ6wK8OuDlA8juIRamxf4vj6+yM2n+PWbvhz+rzq3683FrN5RxgyGLYF+SlBMXY47gW1Vavzv9UXZlan/+3e3zqf7Bw/YUGiDLVtSu7CUgPJxKJnSDScj4Cba2Rhb68ZlXEsDJYCiznBxQ1hJJH+8p7wAiU6BcflxObvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935675; c=relaxed/simple;
	bh=+q2tOuGmqGmxcFzs4HYqZ/V5oTjVBiMd/7HFgXvyyjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ai6SpxRpIWmbQEdIk/CDxghOQN/hWhi3BZZiVOFIlVqgNT6Lk5ojCoDaBQftxhwgRTxgqmAHj9IEKwrGa66Z4QwPVxw86y+FFcDXgacyViTkxz2JiunghLfL4I5WVKE0st3m/qS+3OiUcdTjttISUrwzjZgwcCzjsOGx5ewab+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJ4HYtpn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xb47EVPC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx8g5vHE9MfNADi8ODeITB+5wdojkswjnu2cg3tAeYo=;
	b=PJ4HYtpnqEFyMaMAhSyIbvS++RtNc3AO68KQfawJnIyu9Nf+9L8JZDYhcV7dV+mW91pSc2
	FaLv2EvIeDIsSKIZy4RPvulziBVeUMSLq2pByxrxpmHxx8Ljy4oj347fXtpMBvFynFuirt
	bad0O+tCM+TUnquQWVfmg/ZoLHiMYU1NV4tWZ1sZY6Sw7U1WiNQvdb1eWMYWmFb4PJLmPk
	I3E/tK//JwlD5np4rfZhU0bsteg+wMVlG69hGxen6rshUtnu1xo5pFgNovIUNw2ISDkq0n
	sOGx2Ma/uRuvwko4rn+g2Io1zBNGM0IHCSOSX1oapKSEPaosabjso3thIyYs3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx8g5vHE9MfNADi8ODeITB+5wdojkswjnu2cg3tAeYo=;
	b=Xb47EVPC9D8D8Hv+uPFsz2LlMy44gIaOn7LNf1zRcZCP763CepfKPgpK7LvANA9G29/5M4
	gzWtBqIIp26gPiAg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Consolidate monitoring related data
 from rdt_resource
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <ceed1b206c22c9bf8b7c2ddbc8287758694e707a.1757108044.git.babu.moger@amd.com>
References:
 <ceed1b206c22c9bf8b7c2ddbc8287758694e707a.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566921.709179.11958368812522296770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5ad68c8f965fed78c61f2ac7aea933f06bb50032
Gitweb:        https://git.kernel.org/tip/5ad68c8f965fed78c61f2ac7aea933f06bb=
50032
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:07:01 +02:00

x86,fs/resctrl: Consolidate monitoring related data from rdt_resource

The cache allocation and memory bandwidth allocation feature properties are
consolidated into struct resctrl_cache and struct resctrl_membw respectively.

In preparation for more monitoring properties that will clobber the existing
resource struct more, re-organize the monitoring specific properties to also
be in a separate structure.

Also convert "bandwidth sources" terminology to "memory transactions" to have
consistency within resctrl for related monitoring features.

  [ bp: Massage commit message. ]

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++-----
 fs/resctrl/rdtgroup.c                 |  6 +++---
 include/linux/resctrl.h               | 18 +++++++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index b07b12a..267e920 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -107,7 +107,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
=20
 	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D num_rmid */
-	return r->num_rmid;
+	return r->mon.num_rmid;
 }
=20
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -541,7 +541,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resour=
ce *r)
=20
 	arch_mon_domain_online(r, d);
=20
-	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index f01db20..2558b1b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -130,7 +130,7 @@ static int logical_rmid_to_physical_rmid(int cpu, int lrm=
id)
 	if (snc_nodes_per_l3_cache =3D=3D 1)
 		return lrmid;
=20
-	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->mon.num_rmi=
d;
 }
=20
 static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *v=
al)
@@ -205,7 +205,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, =
struct rdt_mon_domain *
 			continue;
 		idx =3D MBM_STATE_IDX(eventid);
 		memset(hw_dom->arch_mbm_states[idx], 0,
-		       sizeof(*hw_dom->arch_mbm_states[0]) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_states[0]) * r->mon.num_rmid);
 	}
 }
=20
@@ -344,7 +344,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
=20
 	resctrl_rmid_realloc_limit =3D boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale =3D boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_=
cache;
-	r->num_rmid =3D (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_c=
ache;
+	r->mon.num_rmid =3D (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_=
l3_cache;
 	hw_res->mbm_width =3D MBM_CNTR_WIDTH_BASE;
=20
 	if (mbm_offset > 0 && mbm_offset <=3D MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -359,7 +359,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold =3D resctrl_rmid_realloc_limit / r->num_rmid;
+	threshold =3D resctrl_rmid_realloc_limit / r->mon.num_rmid;
=20
 	/*
 	 * Because num_rmid may not be a power of two, round the value
@@ -373,7 +373,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
=20
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		r->mbm_cfg_mask =3D ecx & MAX_EVT_CONFIG_BITS;
+		r->mon.mbm_cfg_mask =3D ecx & MAX_EVT_CONFIG_BITS;
 	}
=20
 	r->mon_capable =3D true;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a6047e9..b6ab107 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1135,7 +1135,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *=
of,
 {
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
=20
-	seq_printf(seq, "%d\n", r->num_rmid);
+	seq_printf(seq, "%d\n", r->mon.num_rmid);
=20
 	return 0;
 }
@@ -1731,9 +1731,9 @@ next:
 	}
=20
 	/* Value from user cannot be more than the supported set of events */
-	if ((val & r->mbm_cfg_mask) !=3D val) {
+	if ((val & r->mon.mbm_cfg_mask) !=3D val) {
 		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x=
\n",
-				    r->mbm_cfg_mask);
+				    r->mon.mbm_cfg_mask);
 		return -EINVAL;
 	}
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 478d7a9..fe2af6c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -256,37 +256,45 @@ enum resctrl_schema_fmt {
 };
=20
 /**
+ * struct resctrl_mon - Monitoring related data of a resctrl resource.
+ * @num_rmid:		Number of RMIDs available.
+ * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
+ *			monitoring events can be configured.
+ */
+struct resctrl_mon {
+	int			num_rmid;
+	unsigned int		mbm_cfg_mask;
+};
+
+/**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
- * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
+ * @mon:		Monitoring related data.
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
- *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
-	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
+	struct resctrl_mon	mon;
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
=20

