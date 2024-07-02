Return-Path: <linux-tip-commits+bounces-1582-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36492483E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8062E28A1D6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE0205E0A;
	Tue,  2 Jul 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uul3cpKb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8kUMMQR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8431CFD7C;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948264; cv=none; b=pOzuGRnYxS1N7KLUnhF7tHcVcUDoudIB1Flf64BJ1u0EOZxoblnbZHJLvDxChti+2ROVrD2eMdX/aQvI8SWzNy6q+2FVMtpgiiA9KW/RA2pPAcCxtiaiwaYE0eYuyD7l5lrktQfRH+IMMKy3Ze9KiRyjvphs8SlhIcxgnzhSx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948264; c=relaxed/simple;
	bh=vo8wVFWXBS1Lm+FiK9UxQFgDhBXVl7bBDXm2orqNGkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pttYRRkL2Wy3kMI7V9gdD5upnT4KPJtDhAH6poe1ymQk3jiuDQ/57VfMPES9tOACEw4C6zpN7qzIvt7yIk089Sx56FMRwvYNHtYNzeCscVb+lXLIGBkrIdBA+ySasJ5Fqqkcfu3lMx78AR9Wddr+voOnWD81aS6XTes2oM13kYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uul3cpKb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8kUMMQR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnOX6mfN8qk/IuaDzPpoWXl5xK2eqzHGO8xSWGSJrlM=;
	b=uul3cpKbeN2pHlHTFIAUTVK9EYhy+WstfyP2j4iVtSGEQZYXOSkF9t0cRO0gZQvHKjwjb/
	u3+1UPzvH4Lt/AW6gO0I26fZGlnToAkp6RMv4XGkhh/t4AHC34rvCs7TnE7gv5rdf2reIX
	xz2k7LAwQsKDOO6y5o7lswgXArRRQJv5wpCUePUg1k/cRxAGohHEQyt1g+bq9I9+mj6Byy
	a+Awh8OmSfLPK2j/Q3mJ60yg/gKFI5F+7UDUFb0PiQjayRAdD3XjBHwtdoGyO3g1+NHmhO
	FVpNp/gu3zmEedyMG8qW+J665e+SNy5hOn9pdTw4SBjZAhJbhY9PUbD8B/a9ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnOX6mfN8qk/IuaDzPpoWXl5xK2eqzHGO8xSWGSJrlM=;
	b=T8kUMMQRGJcTk1Uqv2YOgp4IH4zbIW8Pcg0XzHqOMEqh80rlD/Akx2QiPPAaRdCDAbxfYS
	KkXSnV4kAuABUxBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Split the rdt_domain and rdt_hw_domain
 structures
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-5-tony.luck@intel.com>
References: <20240628215619.76401-5-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825628.2215.10607093510279076897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     cae2bcb6a2c691ef7b537ad07e9819a5ed645bcc
Gitweb:        https://git.kernel.org/tip/cae2bcb6a2c691ef7b537ad07e9819a5ed645bcc
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:04 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Split the rdt_domain and rdt_hw_domain structures

The same rdt_domain structure is used for both control and monitor
functions. But this results in wasted memory as some of the fields are
only used by control functions, while most are only used for monitor
functions.

Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
just the fields required for control and monitoring respectively.

Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
and rdt_hw_mon_domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-5-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 71 +++++++++++-----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 ++++-----
 arch/x86/kernel/cpu/resctrl/internal.h    | 62 +++++++++++--------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 40 ++++++------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 64 ++++++++++----------
 include/linux/resctrl.h                   | 48 ++++++++-------
 7 files changed, 174 insertions(+), 145 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index edd9b2b..b4f2be7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -309,8 +309,8 @@ static void rdt_get_cdp_l2_config(void)
 
 static void mba_wrmsr_amd(struct msr_param *m)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(m->dom);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
@@ -333,8 +333,8 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 
 static void mba_wrmsr_intel(struct msr_param *m)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(m->dom);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
 
 	/*  Write the delay values for mba. */
@@ -344,17 +344,17 @@ static void mba_wrmsr_intel(struct msr_param *m)
 
 static void cat_wrmsr(struct msr_param *m)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(m->dom);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(m->dom);
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
+struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	lockdep_assert_cpus_held();
 
@@ -367,9 +367,9 @@ struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
 	return NULL;
 }
 
-struct rdt_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
+struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 
 	lockdep_assert_cpus_held();
 
@@ -440,18 +440,23 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 		*dc = r->default_ctrl;
 }
 
-static void domain_free(struct rdt_hw_domain *hw_dom)
+static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
+{
+	kfree(hw_dom->ctrl_val);
+	kfree(hw_dom);
+}
+
+static void mon_domain_free(struct rdt_hw_mon_domain *hw_dom)
 {
 	kfree(hw_dom->arch_mbm_total);
 	kfree(hw_dom->arch_mbm_local);
-	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
 
-static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
 	u32 *dc;
 
@@ -476,7 +481,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_dom)
 {
 	size_t tsize;
 
@@ -515,10 +520,10 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int err;
 
 	lockdep_assert_held(&domain_list_lock);
@@ -533,7 +538,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	if (hdr) {
 		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
 			return;
-		d = container_of(hdr, struct rdt_domain, hdr);
+		d = container_of(hdr, struct rdt_ctrl_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
@@ -553,7 +558,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (domain_setup_ctrlval(r, d)) {
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 		return;
 	}
 
@@ -563,7 +568,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 	}
 }
 
@@ -571,9 +576,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
 	struct list_head *add_pos = NULL;
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_mon_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 	int err;
 
 	lockdep_assert_held(&domain_list_lock);
@@ -588,7 +593,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	if (hdr) {
 		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
 			return;
-		d = container_of(hdr, struct rdt_domain, hdr);
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 		return;
@@ -604,7 +609,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
 	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
-		domain_free(hw_dom);
+		mon_domain_free(hw_dom);
 		return;
 	}
 
@@ -614,7 +619,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		domain_free(hw_dom);
+		mon_domain_free(hw_dom);
 	}
 }
 
@@ -629,9 +634,9 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	lockdep_assert_held(&domain_list_lock);
 
@@ -651,8 +656,8 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
 		return;
 
-	d = container_of(hdr, struct rdt_domain, hdr);
-	hw_dom = resctrl_to_arch_dom(d);
+	d = container_of(hdr, struct rdt_ctrl_domain, hdr);
+	hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
 	if (cpumask_empty(&d->hdr.cpu_mask)) {
@@ -661,12 +666,12 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		synchronize_rcu();
 
 		/*
-		 * rdt_domain "d" is going to be freed below, so clear
+		 * rdt_ctrl_domain "d" is going to be freed below, so clear
 		 * its pointer from pseudo_lock_region struct.
 		 */
 		if (d->plr)
 			d->plr->d = NULL;
-		domain_free(hw_dom);
+		ctrl_domain_free(hw_dom);
 
 		return;
 	}
@@ -675,9 +680,9 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_mon_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 
 	lockdep_assert_held(&domain_list_lock);
 
@@ -697,15 +702,15 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
 		return;
 
-	d = container_of(hdr, struct rdt_domain, hdr);
-	hw_dom = resctrl_to_arch_dom(d);
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
+	hw_dom = resctrl_to_arch_mon_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
 	if (cpumask_empty(&d->hdr.cpu_mask)) {
 		resctrl_offline_mon_domain(r, d);
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
-		domain_free(hw_dom);
+		mon_domain_free(hw_dom);
 
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 8cc3672..3b93836 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -60,7 +60,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 }
 
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d)
+	     struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -139,7 +139,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * resource type.
  */
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d)
+	      struct rdt_ctrl_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct resctrl_staged_config *cfg;
@@ -208,8 +208,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
+	struct rdt_ctrl_domain *d;
 	char *dom = NULL, *id;
-	struct rdt_domain *d;
 	unsigned long dom_id;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
@@ -272,11 +272,11 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 	}
 }
 
-int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, t);
 	struct msr_param msr_param;
 
@@ -297,17 +297,17 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct msr_param msr_param;
+	struct rdt_ctrl_domain *d;
 	enum resctrl_conf_type t;
-	struct rdt_domain *d;
 	u32 idx;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		hw_dom = resctrl_to_arch_dom(d);
+		hw_dom = resctrl_to_arch_ctrl_dom(d);
 		msr_param.res = NULL;
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
 			cfg = &hw_dom->d_resctrl.staged_config[t];
@@ -430,10 +430,10 @@ out:
 	return ret ?: nbytes;
 }
 
-u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	u32 idx = get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
@@ -442,7 +442,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
-	struct rdt_domain *dom;
+	struct rdt_ctrl_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
@@ -514,7 +514,7 @@ static int smp_mon_event_count(void *arg)
 }
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
 	int cpu;
@@ -557,11 +557,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
 	struct rdt_domain_hdr *hdr;
+	struct rdt_mon_domain *d;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	struct rdt_domain *d;
 	struct rmid_read rr;
 	int ret = 0;
 
@@ -582,7 +582,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		ret = -ENOENT;
 		goto out;
 	}
-	d = container_of(hdr, struct rdt_domain, hdr);
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 377679b..135190e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -147,7 +147,7 @@ union mon_data_bits {
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
-	struct rdt_domain	*d;
+	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
 	int			err;
@@ -232,7 +232,7 @@ struct mongroup {
  */
 struct pseudo_lock_region {
 	struct resctrl_schema	*s;
-	struct rdt_domain	*d;
+	struct rdt_ctrl_domain	*d;
 	u32			cbm;
 	wait_queue_head_t	lock_thread_wq;
 	int			thread_done;
@@ -355,25 +355,41 @@ struct arch_mbm_state {
 };
 
 /**
- * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
- *			  a resource
+ * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
+ *			       a resource for a control function
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ *
+ * Members of this structure are accessed via helpers that provide abstraction.
+ */
+struct rdt_hw_ctrl_domain {
+	struct rdt_ctrl_domain		d_resctrl;
+	u32				*ctrl_val;
+};
+
+/**
+ * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that share
+ *			      a resource for a monitor function
+ * @d_resctrl:	Properties exposed to the resctrl file system
  * @arch_mbm_total:	arch private state for MBM total bandwidth
  * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
-struct rdt_hw_domain {
-	struct rdt_domain		d_resctrl;
-	u32				*ctrl_val;
+struct rdt_hw_mon_domain {
+	struct rdt_mon_domain		d_resctrl;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
 };
 
-static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
+static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
+{
+	return container_of(r, struct rdt_hw_ctrl_domain, d_resctrl);
+}
+
+static inline struct rdt_hw_mon_domain *resctrl_to_arch_mon_dom(struct rdt_mon_domain *r)
 {
-	return container_of(r, struct rdt_hw_domain, d_resctrl);
+	return container_of(r, struct rdt_hw_mon_domain, d_resctrl);
 }
 
 /**
@@ -385,7 +401,7 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
-	struct rdt_domain	*dom;
+	struct rdt_ctrl_domain	*dom;
 	u32			low;
 	u32			high;
 };
@@ -458,9 +474,9 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 }
 
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d);
+	      struct rdt_ctrl_domain *d);
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d);
+	     struct rdt_ctrl_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
@@ -564,22 +580,22 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive);
-unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm);
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
 int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
-struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
-struct rdt_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
+struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
@@ -590,19 +606,19 @@ bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
-void mbm_setup_overflow_handler(struct rdt_domain *dom,
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
 			     int exclude_cpu);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_domain *d);
-void __check_limbo(struct rdt_domain *d, bool force_free);
+bool has_busy_rmid(struct rdt_mon_domain *d);
+void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 82a44de..89d7e6f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -209,7 +209,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
@@ -228,11 +228,11 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 	return NULL;
 }
 
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 unused, u32 rmid,
 			     enum resctrl_event_id eventid)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct arch_mbm_state *am;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
@@ -248,9 +248,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  * Assumes that hardware counters are also reset and thus that there is
  * no need to record initial non-zero counts.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 
 	if (is_mbm_total_enabled())
 		memset(hw_dom->arch_mbm_total, 0,
@@ -269,12 +269,12 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
 	int ret;
@@ -320,7 +320,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  * decrement the count. If the busy count gets to zero on an RMID, we
  * free the RMID
  */
-void __check_limbo(struct rdt_domain *d, bool force_free)
+void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -378,7 +378,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
 }
 
-bool has_busy_rmid(struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 
@@ -479,7 +479,7 @@ int alloc_rmid(u32 closid)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 	u32 idx;
 
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -531,7 +531,7 @@ void free_rmid(u32 closid, u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
+static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
 	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
@@ -667,12 +667,12 @@ void mon_event_count(void *info)
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_ctrl_domain *dom_mba;
 	struct rdt_resource *r_mba;
-	struct rdt_domain *dom_mba;
 	u32 cur_bw, user_bw, idx;
 	struct list_head *head;
 	struct rdtgroup *entry;
@@ -733,7 +733,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 }
 
-static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
+static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 		       u32 closid, u32 rmid)
 {
 	struct rmid_read rr;
@@ -791,12 +791,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
-	d = container_of(work, struct rdt_domain, cqm_limbo.work);
+	d = container_of(work, struct rdt_mon_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
@@ -819,7 +819,7 @@ void cqm_handle_limbo(struct work_struct *work)
  * @exclude_cpu:   Which CPU the handler should not run on,
  *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
  */
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
 			     int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
@@ -836,9 +836,9 @@ void mbm_handle_overflow(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *d;
 	struct list_head *head;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
@@ -851,7 +851,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	d = container_of(work, struct rdt_domain, mbm_over.work);
+	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
@@ -885,7 +885,7 @@ out_unlock:
  * @exclude_cpu:   Which CPU the handler should not run on,
  *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
  */
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_ms,
 				int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index bdcf95f..70f0069 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -809,7 +809,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
  * Return: true if @cbm overlaps with pseudo-locked region on @d, false
  * otherwise.
  */
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm)
 {
 	unsigned int cbm_len;
 	unsigned long cbm_b;
@@ -836,11 +836,11 @@ bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm
  *         if it is not possible to test due to memory allocation issue,
  *         false otherwise.
  */
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
 {
+	struct rdt_ctrl_domain *d_i;
 	cpumask_var_t cpu_with_psl;
 	struct rdt_resource *r;
-	struct rdt_domain *d_i;
 	bool ret = false;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 17d4610..eb3bbfa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -92,8 +92,8 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 void rdt_staged_configs_clear(void)
 {
+	struct rdt_ctrl_domain *dom;
 	struct rdt_resource *r;
-	struct rdt_domain *dom;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -1012,7 +1012,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	unsigned long sw_shareable = 0, hw_shareable = 0;
 	unsigned long exclusive = 0, pseudo_locked = 0;
 	struct rdt_resource *r = s->res;
-	struct rdt_domain *dom;
+	struct rdt_ctrl_domain *dom;
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
@@ -1243,7 +1243,7 @@ static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
  *
  * Return: false if CBM does not overlap, true if it does.
  */
-static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 				    unsigned long cbm, int closid,
 				    enum resctrl_conf_type type, bool exclusive)
 {
@@ -1298,7 +1298,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
  *
  * Return: true if CBM overlap detected, false if there is no overlap
  */
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
 	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
@@ -1329,10 +1329,10 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	int closid = rdtgrp->closid;
+	struct rdt_ctrl_domain *d;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
-	struct rdt_domain *d;
 	u32 ctrl;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
@@ -1448,7 +1448,7 @@ out:
  * bitmap functions work correctly.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
-				  struct rdt_domain *d, unsigned long cbm)
+				  struct rdt_ctrl_domain *d, unsigned long cbm)
 {
 	unsigned int size = 0;
 	struct cacheinfo *ci;
@@ -1476,9 +1476,9 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 {
 	struct resctrl_schema *schema;
 	enum resctrl_conf_type type;
+	struct rdt_ctrl_domain *d;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 	unsigned int size;
 	int ret = 0;
 	u32 closid;
@@ -1590,7 +1590,7 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
 {
 	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
 }
@@ -1598,7 +1598,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
 	struct mon_config_info mon_info = {0};
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	bool sep = false;
 
 	cpus_read_lock();
@@ -1657,7 +1657,7 @@ static void mon_event_config_write(void *info)
 }
 
 static void mbm_config_write_domain(struct rdt_resource *r,
-				    struct rdt_domain *d, u32 evtid, u32 val)
+				    struct rdt_mon_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
 
@@ -1698,7 +1698,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
-	struct rdt_domain *d;
+	struct rdt_mon_domain *d;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
@@ -2257,9 +2257,9 @@ static inline bool is_mba_linear(void)
 static int set_cache_qos_cfg(int level, bool enable)
 {
 	void (*update)(void *arg);
+	struct rdt_ctrl_domain *d;
 	struct rdt_resource *r_l;
 	cpumask_var_t cpu_mask;
-	struct rdt_domain *d;
 	int cpu;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
@@ -2309,7 +2309,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
-static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	int cpu = cpumask_any(&d->hdr.cpu_mask);
@@ -2327,7 +2327,7 @@ static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
 }
 
 static void mba_sc_domain_destroy(struct rdt_resource *r,
-				  struct rdt_domain *d)
+				  struct rdt_ctrl_domain *d)
 {
 	kfree(d->mbps_val);
 	d->mbps_val = NULL;
@@ -2353,7 +2353,7 @@ static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 	u32 num_closid = resctrl_arch_get_num_closid(r);
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
@@ -2625,7 +2625,7 @@ static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	unsigned long flags = RFTYPE_CTRL_BASE;
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	struct rdt_resource *r;
 	int ret;
 
@@ -2810,9 +2810,9 @@ static int rdt_init_fs_context(struct fs_context *fc)
 static int reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom;
+	struct rdt_hw_ctrl_domain *hw_dom;
 	struct msr_param msr_param;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int i;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
@@ -2828,7 +2828,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * from each domain to update the MSRs below.
 	 */
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		hw_dom = resctrl_to_arch_dom(d);
+		hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
@@ -3021,7 +3021,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain *d,
+				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	union mon_data_bits priv;
@@ -3070,7 +3070,7 @@ out_destroy:
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_domain *d)
+					   struct rdt_mon_domain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -3092,7 +3092,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_domain *dom;
+	struct rdt_mon_domain *dom;
 	int ret;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
@@ -3197,7 +3197,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
  * Set the RDT domain up to start off with all usable allocations. That is,
  * all shareable and unused bits. All-zero CBM is invalid.
  */
-static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
+static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
@@ -3277,7 +3277,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
  */
 static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 	int ret;
 
 	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
@@ -3293,7 +3293,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
-	struct rdt_domain *d;
+	struct rdt_ctrl_domain *d;
 
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (is_mba_sc(r)) {
@@ -3919,14 +3919,14 @@ static void __init rdtgroup_setup_default(void)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-static void domain_destroy_mon_state(struct rdt_domain *d)
+static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -3936,7 +3936,7 @@ void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -3967,7 +3967,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
@@ -3998,7 +3998,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
 {
 	int err = 0;
 
@@ -4014,7 +4014,7 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return err;
 }
 
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	int err;
 
@@ -4069,8 +4069,8 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 void resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_mon_domain *d;
 	struct rdtgroup *rdtgrp;
-	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
 	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 96ddf9f..aa2c22a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -78,7 +78,23 @@ struct rdt_domain_hdr {
 };
 
 /**
- * struct rdt_domain - group of CPUs sharing a resctrl resource
+ * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
+ * @hdr:		common header for different domain types
+ * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		When mba_sc is enabled, this holds the array of user
+ *			specified control values for mba_sc in MBps, indexed
+ *			by closid
+ */
+struct rdt_ctrl_domain {
+	struct rdt_domain_hdr		hdr;
+	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
+};
+
+/**
+ * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
@@ -87,13 +103,8 @@ struct rdt_domain_hdr {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
- * @plr:		pseudo-locked region (if any) associated with domain
- * @staged_config:	parsed configuration to be applied
- * @mbps_val:		When mba_sc is enabled, this holds the array of user
- *			specified control values for mba_sc in MBps, indexed
- *			by closid
  */
-struct rdt_domain {
+struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
@@ -102,9 +113,6 @@ struct rdt_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
-	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
-	u32				*mbps_val;
 };
 
 /**
@@ -208,7 +216,7 @@ struct rdt_resource {
 	const char		*format_str;
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
-						 struct rdt_domain *d);
+						 struct rdt_ctrl_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
@@ -242,15 +250,15 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
  */
-int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
 
-u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
-int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
 
@@ -279,7 +287,7 @@ void resctrl_offline_cpu(unsigned int cpu);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *arch_mon_ctx);
 
@@ -312,7 +320,7 @@ static inline void resctrl_arch_rmid_read_context_check(void)
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 closid, u32 rmid,
 			     enum resctrl_event_id eventid);
 
@@ -325,7 +333,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;

