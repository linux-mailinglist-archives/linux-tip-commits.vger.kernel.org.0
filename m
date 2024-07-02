Return-Path: <linux-tip-commits+bounces-1581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C292483C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F9B26826
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D1201249;
	Tue,  2 Jul 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSsoUFk1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NecdR+Y3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D51CFD7D;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948262; cv=none; b=kn1XXFl9dRUUObC/kDc7Dz82mo6lfEH85NreARbjcIrjLaP/lbHfY/GMX3z4G2QFur/LYTLytPJXTjWTYP/sawM8sAkgABx3cjioDjbsiPeGqsLW9bf5WyPX2mGYqQukumZ5WfmkM2dQNmZm+NQy1fi30waceAbWHB5eltdiuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948262; c=relaxed/simple;
	bh=ieVnSoYTxlyvt6PcP2bKHGgEwiN2XBfBCcUdM2TvDfs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y8UbJhD3N7G0B8oQb1J5LnMVoao/BVLe+HugVUhGk+2Ux9UlkmXSYjS6iXAngm9GomBg7TfGRsElfM35YbjStxaepQBDPtbQaVf0wsbgjax29zVE527j3JV9WCte+OK9juHOnxO/y2XOgPMh5plZ4FQPk1/P/FJM8IzZiKBSPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSsoUFk1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NecdR+Y3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV6kViyCL9L9q8wYydQpzYujWNSkXIAKXWjwJU8XcIA=;
	b=iSsoUFk1LPeVWrpG9uvAHURCXg4nYgFCB8tP/1r1j6DjZUn8eQ72OcjWzWpfLkYs3B9X+s
	tviehbYEOXroFS3ITK3R/0ep6nYAu2wcUYC4sJrQtuLi+pLbosnxWVgS6f9N9Fq0+7QnLe
	pcNOUxnV4iRT30lA8KqhqN2NyCYu3d907qDuV/0lvEFGdRnEHM2d4OT5RWQ87QQIbJtk8K
	80e4NCuMNWQLYv7LSIf1ubLdehZFDI+ukmQroSv6u4JxSkHCZm/OFtuJJvMiBj6+AG74bW
	I6Uuxn/6Ly7h3LWLM/dc8e9OtfqYjKx5FEU4yc5uuGCgEra1J5s1PkG4X1D1EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV6kViyCL9L9q8wYydQpzYujWNSkXIAKXWjwJU8XcIA=;
	b=NecdR+Y3N3iV0B3xEunIrvIY7Ejwn6wXdiqI6nk1/X1IToarIiWPnDlQpkDvQj+DOEukMy
	KwrlkMicRFlHngAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Prepare for different scope for
 control/monitor operations
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-4-tony.luck@intel.com>
References: <20240628215619.76401-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825663.2215.17379376620417046681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     cd84f72b6a5c10f79f19fab67b0edfbc4fdbc5b1
Gitweb:        https://git.kernel.org/tip/cd84f72b6a5c10f79f19fab67b0edfbc4fdbc5b1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:03 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:53 +02:00

x86/resctrl: Prepare for different scope for control/monitor operations

Resctrl assumes that control and monitor operations on a resource are
performed at the same scope.

Prepare for systems that use different scope (specifically Intel needs
to split the RDT_RESOURCE_L3 resource to use L3 scope for cache control
and NODE scope for cache occupancy and memory bandwidth monitoring).

Create separate domain lists for control and monitor operations.

Note that errors during initialization of either control or monitor
functions on a domain would previously result in that domain being
excluded from both control and monitor operations. Now the domains are
allocated independently it is no longer required to disable both control
and monitor operations if either fail.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-4-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 224 ++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  12 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |   7 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |   4 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  60 +++---
 include/linux/resctrl.h                   |  25 +-
 7 files changed, 240 insertions(+), 96 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 96fff44..edd9b2b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -60,7 +60,8 @@ static void mba_wrmsr_intel(struct msr_param *m);
 static void cat_wrmsr(struct msr_param *m);
 static void mba_wrmsr_amd(struct msr_param *m);
 
-#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
+#define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
+#define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
 
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
@@ -68,8 +69,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_L3),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.mon_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
+			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -82,8 +85,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
-			.scope			= RESCTRL_L2_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_L2),
+			.ctrl_scope		= RESCTRL_L2_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
@@ -96,8 +99,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_MBA),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -108,8 +111,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
-			.scope			= RESCTRL_L3_CACHE,
-			.domains		= domain_init(RDT_RESOURCE_SMBA),
+			.ctrl_scope		= RESCTRL_L3_CACHE,
+			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
@@ -349,13 +352,28 @@ static void cat_wrmsr(struct msr_param *m)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
+struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
 	lockdep_assert_cpus_held();
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
+struct rdt_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
 			return d;
@@ -379,26 +397,26 @@ void rdt_ctrl_update(void *arg)
 }
 
 /*
- * rdt_find_domain - Find a domain in a resource that matches input resource id
+ * rdt_find_domain - Search for a domain id in a resource domain list.
  *
- * Search resource r's domain list to find the resource id. If the resource
- * id is found in a domain, return the domain. Otherwise, if requested by
- * caller, return the first domain whose id is bigger than the input id.
- * The domain list is sorted by id in ascending order.
+ * Search the domain list to find the domain id. If the domain id is
+ * found, return the domain. NULL otherwise.  If the domain id is not
+ * found (and NULL returned) then the first domain with id bigger than
+ * the input id can be returned to the caller via @pos.
  */
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos)
+struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
+				       struct list_head **pos)
 {
-	struct rdt_domain *d;
+	struct rdt_domain_hdr *d;
 	struct list_head *l;
 
-	list_for_each(l, &r->domains) {
-		d = list_entry(l, struct rdt_domain, hdr.list);
+	list_for_each(l, h) {
+		d = list_entry(l, struct rdt_domain_hdr, list);
 		/* When id is found, return its domain. */
-		if (id == d->hdr.id)
+		if (id == d->id)
 			return d;
 		/* Stop searching when finding id's position in sorted list. */
-		if (id < d->hdr.id)
+		if (id < d->id)
 			break;
 	}
 
@@ -494,38 +512,29 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	return -EINVAL;
 }
 
-/*
- * domain_add_cpu - Add a cpu to a resource's domain list.
- *
- * If an existing domain in the resource r's domain list matches the cpu's
- * resource id, add the cpu in the domain.
- *
- * Otherwise, a new domain is allocated and inserted into the right position
- * in the domain list sorted by id in ascending order.
- *
- * The order in the domain list is visible to users when we print entries
- * in the schemata file and schemata input is validated to have the same order
- * as this list.
- */
-static void domain_add_cpu(int cpu, struct rdt_resource *r)
+static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
-	int id = get_domain_id_from_scope(cpu, r->scope);
+	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
 	struct rdt_domain *d;
 	int err;
 
 	lockdep_assert_held(&domain_list_lock);
 
 	if (id < 0) {
-		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->scope, r->name);
+		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->ctrl_scope, r->name);
 		return;
 	}
 
-	d = rdt_find_domain(r, id, &add_pos);
+	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
+	if (hdr) {
+		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+			return;
+		d = container_of(hdr, struct rdt_domain, hdr);
 
-	if (d) {
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
 			rdt_domain_reconfigure_cdp(r);
@@ -538,23 +547,70 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
+	d->hdr.type = RESCTRL_CTRL_DOMAIN;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	rdt_domain_reconfigure_cdp(r);
 
-	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
+	if (domain_setup_ctrlval(r, d)) {
 		domain_free(hw_dom);
 		return;
 	}
 
-	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	list_add_tail_rcu(&d->hdr.list, add_pos);
+
+	err = resctrl_online_ctrl_domain(r, d);
+	if (err) {
+		list_del_rcu(&d->hdr.list);
+		synchronize_rcu();
+		domain_free(hw_dom);
+	}
+}
+
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
+	struct rdt_domain *d;
+	int err;
+
+	lockdep_assert_held(&domain_list_lock);
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
+	if (hdr) {
+		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+			return;
+		d = container_of(hdr, struct rdt_domain, hdr);
+
+		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		return;
+	}
+
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
+		return;
+
+	d = &hw_dom->d_resctrl;
+	d->hdr.id = id;
+	d->hdr.type = RESCTRL_MON_DOMAIN;
+	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+
+	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
 		domain_free(hw_dom);
 		return;
 	}
 
 	list_add_tail_rcu(&d->hdr.list, add_pos);
 
-	err = resctrl_online_domain(r, d);
+	err = resctrl_online_mon_domain(r, d);
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
@@ -562,30 +618,45 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	}
 }
 
-static void domain_remove_cpu(int cpu, struct rdt_resource *r)
+static void domain_add_cpu(int cpu, struct rdt_resource *r)
+{
+	if (r->alloc_capable)
+		domain_add_cpu_ctrl(cpu, r);
+	if (r->mon_capable)
+		domain_add_cpu_mon(cpu, r);
+}
+
+static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
-	int id = get_domain_id_from_scope(cpu, r->scope);
+	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
 	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
 	struct rdt_domain *d;
 
 	lockdep_assert_held(&domain_list_lock);
 
 	if (id < 0) {
-		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->scope, r->name);
+		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->ctrl_scope, r->name);
 		return;
 	}
 
-	d = rdt_find_domain(r, id, NULL);
-	if (!d) {
-		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
+	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
+	if (!hdr) {
+		pr_warn("Can't find control domain for id=%d for CPU %d for resource %s\n",
+			id, cpu, r->name);
 		return;
 	}
+
+	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
+		return;
+
+	d = container_of(hdr, struct rdt_domain, hdr);
 	hw_dom = resctrl_to_arch_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
 	if (cpumask_empty(&d->hdr.cpu_mask)) {
-		resctrl_offline_domain(r, d);
+		resctrl_offline_ctrl_domain(r, d);
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
 
@@ -601,6 +672,53 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	}
 }
 
+static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct rdt_hw_domain *hw_dom;
+	struct rdt_domain_hdr *hdr;
+	struct rdt_domain *d;
+
+	lockdep_assert_held(&domain_list_lock);
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
+	if (!hdr) {
+		pr_warn("Can't find monitor domain for id=%d for CPU %d for resource %s\n",
+			id, cpu, r->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+		return;
+
+	d = container_of(hdr, struct rdt_domain, hdr);
+	hw_dom = resctrl_to_arch_dom(d);
+
+	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
+	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		resctrl_offline_mon_domain(r, d);
+		list_del_rcu(&d->hdr.list);
+		synchronize_rcu();
+		domain_free(hw_dom);
+
+		return;
+	}
+}
+
+static void domain_remove_cpu(int cpu, struct rdt_resource *r)
+{
+	if (r->alloc_capable)
+		domain_remove_cpu_ctrl(cpu, r);
+	if (r->mon_capable)
+		domain_remove_cpu_mon(cpu, r);
+}
+
 static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 6246f48..8cc3672 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -231,7 +231,7 @@ next:
 		return -EINVAL;
 	}
 	dom = strim(dom);
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
@@ -306,7 +306,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 		msr_param.res = NULL;
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
@@ -450,7 +450,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	lockdep_assert_cpus_held();
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -556,6 +556,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	struct rdt_domain_hdr *hdr;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -576,11 +577,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 
 	r = &rdt_resources_all[resid].r_resctrl;
-	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
 		ret = -ENOENT;
 		goto out;
 	}
+	d = container_of(hdr, struct rdt_domain, hdr);
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f1d9268..377679b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -558,8 +558,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
-				   struct list_head **pos);
+struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
+				       struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
@@ -578,7 +578,8 @@ int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
-struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ab8a198..82a44de 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -490,7 +490,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		/*
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
@@ -687,7 +687,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	pmbm_data = &dom_mbm->mbm_local[idx];
 
-	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
+	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index df45c83..bdcf95f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,7 +292,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	enum resctrl_scope scope = plr->s->res->scope;
+	enum resctrl_scope scope = plr->s->res->ctrl_scope;
 	struct cacheinfo *ci;
 	int ret;
 
@@ -854,7 +854,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * associated with them.
 	 */
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(d_i, &r->domains, hdr.list) {
+		list_for_each_entry(d_i, &r->ctrl_domains, hdr.list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
 					   &d_i->hdr.cpu_mask);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b6ba77c..17d4610 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -98,7 +98,7 @@ void rdt_staged_configs_clear(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(dom, &r->domains, hdr.list)
+		list_for_each_entry(dom, &r->ctrl_domains, hdr.list)
 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 }
@@ -1021,7 +1021,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
 		sw_shareable = 0;
@@ -1343,7 +1343,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
 			continue;
 		has_cache = true;
-		list_for_each_entry(d, &r->domains, hdr.list) {
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 			ctrl = resctrl_arch_get_config(r, d, closid,
 						       s->conf_type);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
@@ -1454,11 +1454,11 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	struct cacheinfo *ci;
 	int num_b;
 
-	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+	if (WARN_ON_ONCE(r->ctrl_scope != RESCTRL_L2_CACHE && r->ctrl_scope != RESCTRL_L3_CACHE))
 		return size;
 
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
-	ci = get_cpu_cacheinfo_level(cpumask_any(&d->hdr.cpu_mask), r->scope);
+	ci = get_cpu_cacheinfo_level(cpumask_any(&d->hdr.cpu_mask), r->ctrl_scope);
 	if (ci)
 		size = ci->size / r->cache.cbm_len * num_b;
 
@@ -1514,7 +1514,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		type = schema->conf_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
-		list_for_each_entry(d, &r->domains, hdr.list) {
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1604,7 +1604,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
 
@@ -1728,7 +1728,7 @@ next:
 		return -EINVAL;
 	}
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			mbm_config_write_domain(r, d, evtid, val);
 			goto next;
@@ -2276,7 +2276,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 		return -ENOMEM;
 
 	r_l = &rdt_resources_all[level].r_resctrl;
-	list_for_each_entry(d, &r_l->domains, hdr.list) {
+	list_for_each_entry(d, &r_l->ctrl_domains, hdr.list) {
 		if (r_l->cache.arch_has_per_cpu_cfg)
 			/* Pick all the CPUs in the domain instance */
 			for_each_cpu(cpu, &d->hdr.cpu_mask)
@@ -2361,7 +2361,7 @@ static int set_mba_sc(bool mba_sc)
 
 	r->membw.mba_sc = mba_sc;
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		for (i = 0; i < num_closid; i++)
 			d->mbps_val[i] = MBA_MAX_MBPS;
 	}
@@ -2700,7 +2700,7 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-		list_for_each_entry(dom, &r->domains, hdr.list)
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
 	}
@@ -2824,10 +2824,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
 
 	/*
 	 * Disable resource control for this resource by setting all
-	 * CBMs in all domains to the maximum mask value. Pick one CPU
+	 * CBMs in all ctrl_domains to the maximum mask value. Pick one CPU
 	 * from each domain to update the MSRs below.
 	 */
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		hw_dom = resctrl_to_arch_dom(d);
 
 		for (i = 0; i < hw_res->num_closid; i++)
@@ -3098,7 +3098,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	list_for_each_entry(dom, &r->domains, hdr.list) {
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
 			return ret;
@@ -3280,7 +3280,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 	struct rdt_domain *d;
 	int ret;
 
-	list_for_each_entry(d, &s->res->domains, hdr.list) {
+	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
 		ret = __init_one_rdt_domain(d, s, closid);
 		if (ret < 0)
 			return ret;
@@ -3295,7 +3295,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
-	list_for_each_entry(d, &r->domains, hdr.list) {
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (is_mba_sc(r)) {
 			d->mbps_val[closid] = MBA_MAX_MBPS;
 			continue;
@@ -3926,15 +3926,19 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	mutex_lock(&rdtgroup_mutex);
 
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
 		mba_sc_domain_destroy(r, d);
 
-	if (!r->mon_capable)
-		goto out_unlock;
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	mutex_lock(&rdtgroup_mutex);
 
 	/*
 	 * If resctrl is mounted, remove all the
@@ -3960,7 +3964,6 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	domain_destroy_mon_state(d);
 
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -3995,7 +3998,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	int err = 0;
 
@@ -4004,11 +4007,18 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
 		/* RDT_RESOURCE_MBA is never mon_capable */
 		err = mba_sc_domain_allocate(r, d);
-		goto out_unlock;
 	}
 
-	if (!r->mon_capable)
-		goto out_unlock;
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
+}
+
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	mutex_lock(&rdtgroup_mutex);
 
 	err = domain_setup_mon_state(r, d);
 	if (err)
@@ -4073,7 +4083,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	if (!l3->mon_capable)
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, l3);
+	d = get_mon_domain_from_cpu(cpu, l3);
 	if (d) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f63fcf1..96ddf9f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -58,15 +58,22 @@ struct resctrl_staged_config {
 	bool			have_new_ctrl;
 };
 
+enum resctrl_domain_type {
+	RESCTRL_CTRL_DOMAIN,
+	RESCTRL_MON_DOMAIN,
+};
+
 /**
  * struct rdt_domain_hdr - common header for different domain types
  * @list:		all instances of this resource
  * @id:			unique id for this instance
+ * @type:		type of this instance
  * @cpu_mask:		which CPUs share this resource
  */
 struct rdt_domain_hdr {
 	struct list_head		list;
 	int				id;
+	enum resctrl_domain_type	type;
 	struct cpumask			cpu_mask;
 };
 
@@ -169,10 +176,12 @@ enum resctrl_scope {
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
- * @scope:		Scope of this resource
+ * @ctrl_scope:		Scope of this resource for control functions
+ * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
- * @domains:		RCU list of all domains for this resource
+ * @ctrl_domains:	RCU list of all control domains for this resource
+ * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
@@ -187,10 +196,12 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-	enum resctrl_scope	scope;
+	enum resctrl_scope	ctrl_scope;
+	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
-	struct list_head	domains;
+	struct list_head	ctrl_domains;
+	struct list_head	mon_domains;
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
@@ -236,8 +247,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
 

