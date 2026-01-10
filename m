Return-Path: <linux-tip-commits+bounces-7848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D9D0DC6D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C4FA307AFAC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF72D8391;
	Sat, 10 Jan 2026 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZUt2IvUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrhEIgBJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4E28134C;
	Sat, 10 Jan 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074369; cv=none; b=DWHixabGgB1yWAc2rvBCXUYWEpkxbX1T3VbT2GbcH8y5TUxhBntlT6rPu1QsHW3qxp+MJuHOsw5hrKvpwnxsaBui/axfE2LXwFFlp0mvD8s1eUTQEa2Cu24LJh8twb/38wZukkn5EiJDVcBXk0KwRFuSONVfFWpoVmFJKKm4huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074369; c=relaxed/simple;
	bh=4PQxsXkmUTz0XCDy4u4tF3HFGwy/8B1b8cHkqTYFtiY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZMYXZJIO/wFCiU3mpIlMrp58wkPnPk/0Je+J5Ji9KZy6NhtA4mrTABGGDjI26a5Shjz1vSY2iqAuPpskqsGyxChpIufAOcSnvOo+Ei9lIiJ9b69Jvxa6jFEpqyccjeEYInuRtng9H8X7toUXbgo1hgGBJ935Mz4zyrtZ9OyNMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZUt2IvUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrhEIgBJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=24ZIa+ZX3C3P/6MKVcF1IC6Sz+a+0gJqvU5gKA6ylGs=;
	b=ZUt2IvUn9EuYDl5oZo1IgSUuMc0dt5o7YxltqipDGdZ/bTzmkTR1Y9jH7aIPWnan89QCQ2
	iFmB/WKfz0HznKvt4kfOVpzUJTItZdtGXOvCPPAAaH9Bypy/5wMEeM5npDClQCfuWi1keM
	OC0P5DSAKwuRPUk9JylUcXAZFiQ9udFxJfPhsCLIdxtvTLYeJkvWsJeunp1ZGB5xjcYP7H
	BrHvAzdqVc82EmmrFLF9R7Gm+/tPK8tax5tNUPvshdZwzCYeKC5kepBLM4Epow0B4geUJ4
	lWfq+U9hWP1TCHjoj5kyqWryysUaRoZ1LxacQX0GCxUJ4YnMgHg89GmCfBeoHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=24ZIa+ZX3C3P/6MKVcF1IC6Sz+a+0gJqvU5gKA6ylGs=;
	b=rrhEIgBJYPFlYfY3ymuliN1SID/xabxIXWOhdLT38tp31zHgjytkvbZkDyLUENCb/jZEB+
	ekD2ZsNuXYtOI+Dg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Handle domain creation/deletion for
 RDT_RESOURCE_PERF_PKG
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435775.510.16712181685635787207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f4e0cd80d3e7c31327459008b01d63804838a89d
Gitweb:        https://git.kernel.org/tip/f4e0cd80d3e7c31327459008b01d6380483=
8a89d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:10 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:36:41 +01:00

x86,fs/resctrl: Handle domain creation/deletion for RDT_RESOURCE_PERF_PKG

The L3 resource has several requirements for domains. There are per-domain
structures that hold the 64-bit values of counters, and elements to keep
track of the overflow and limbo threads.

None of these are needed for the PERF_PKG resource. The hardware counters
are wide enough that they do not wrap around for decades.

Define a new rdt_perf_pkg_mon_domain structure which just consists of the
standard rdt_domain_hdr to keep track of domain id and CPU mask.

Update resctrl_online_mon_domain() for RDT_RESOURCE_PERF_PKG. The only action
needed for this resource is to create and populate domain directories if a
domain is added while resctrl is mounted.

Similarly resctrl_offline_mon_domain() only needs to remove domain directorie=
s.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c      | 17 ++++++++++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 29 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h  | 13 +++++++++++-
 fs/resctrl/rdtgroup.c                   | 17 +++++++++-----
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 509277b..2514f15 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -580,6 +580,10 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resou=
rce *r)
 		if (!hdr)
 			l3_mon_domain_setup(cpu, id, r, add_pos);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		if (!hdr)
+			intel_aet_mon_domain_setup(cpu, id, r, add_pos);
+		break;
 	default:
 		pr_warn_once("Unknown resource rid=3D%d\n", r->rid);
 		break;
@@ -679,6 +683,19 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_re=
source *r)
 		l3_mon_domain_free(hw_dom);
 		break;
 	}
+	case RDT_RESOURCE_PERF_PKG: {
+		struct rdt_perf_pkg_mon_domain *pkgd;
+
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_PERF_PKG=
))
+			return;
+
+		pkgd =3D container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr);
+		resctrl_offline_mon_domain(r, hdr);
+		list_del_rcu(&hdr->list);
+		synchronize_rcu();
+		kfree(pkgd);
+		break;
+	}
 	default:
 		pr_warn_once("Unknown resource rid=3D%d\n", r->rid);
 		break;
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index 96d627e..9351fe5 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -14,15 +14,20 @@
 #include <linux/bits.h>
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
+#include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gfp_types.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
 #include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/topology.h>
 #include <linux/types.h>
@@ -283,3 +288,27 @@ int intel_aet_read_event(int domid, u32 rmid, void *arch=
_priv, u64 *val)
=20
 	return valid ? 0 : -EINVAL;
 }
+
+void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
+				struct list_head *add_pos)
+{
+	struct rdt_perf_pkg_mon_domain *d;
+	int err;
+
+	d =3D kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
+	if (!d)
+		return;
+
+	d->hdr.id =3D id;
+	d->hdr.type =3D RESCTRL_MON_DOMAIN;
+	d->hdr.rid =3D RDT_RESOURCE_PERF_PKG;
+	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+	list_add_tail_rcu(&d->hdr.list, add_pos);
+
+	err =3D resctrl_online_mon_domain(r, &d->hdr);
+	if (err) {
+		list_del_rcu(&d->hdr.list);
+		synchronize_rcu();
+		kfree(d);
+	}
+}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 10743f5..3b228b2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -88,6 +88,14 @@ static inline struct rdt_hw_l3_mon_domain *resctrl_to_arch=
_mon_dom(struct rdt_l3
 }
=20
 /**
+ * struct rdt_perf_pkg_mon_domain - CPUs sharing an package scoped resctrl m=
onitor resource
+ * @hdr:	common header for different domain types
+ */
+struct rdt_perf_pkg_mon_domain {
+	struct rdt_domain_hdr	hdr;
+};
+
+/**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
  * @dom:       The domain to update
@@ -226,6 +234,8 @@ void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_reso=
urce *r);
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
 int intel_aet_read_event(int domid, u32 rmid, void *arch_priv, u64 *val);
+void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
+				struct list_head *add_pos);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
@@ -233,6 +243,9 @@ static inline int intel_aet_read_event(int domid, u32 rmi=
d, void *arch_priv, u64
 {
 	return -EINVAL;
 }
+
+static inline void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_re=
source *r,
+					      struct list_head *add_pos) { }
 #endif
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 57139f9..b9363a9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4308,11 +4308,6 @@ void resctrl_offline_mon_domain(struct rdt_resource *r=
, struct rdt_domain_hdr *h
=20
 	mutex_lock(&rdtgroup_mutex);
=20
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		goto out_unlock;
-
-	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
-
 	/*
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
@@ -4320,6 +4315,13 @@ void resctrl_offline_mon_domain(struct rdt_resource *r=
, struct rdt_domain_hdr *h
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, hdr);
=20
+	if (r->rid !=3D RDT_RESOURCE_L3)
+		goto out_unlock;
+
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		goto out_unlock;
+
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) && has_busy_rmid(d)=
) {
@@ -4416,6 +4418,9 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_domain_hdr *hdr
=20
 	mutex_lock(&rdtgroup_mutex);
=20
+	if (r->rid !=3D RDT_RESOURCE_L3)
+		goto mkdir;
+
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		goto out_unlock;
=20
@@ -4433,6 +4438,8 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_domain_hdr *hdr
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
=20
+mkdir:
+	err =3D 0;
 	/*
 	 * If the filesystem is not mounted then only the default resource group
 	 * exists. Creation of its directories is deferred until mount time

