Return-Path: <linux-tip-commits+bounces-4156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C976A5E293
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D7716BFDD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DF25DB15;
	Wed, 12 Mar 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hrgdBIPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHxW/E/6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294225D53D;
	Wed, 12 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800036; cv=none; b=DPU1QXSZHZ1migG9meceeXhw+LJvUUif61DrtRPLHufE1TdZ65NyH5uvRndzfwZzj6xBG+ZB88KjSQa+PxkYTgc/Pw0880padr2Vmh2bUaNyJzewBWurSaUD25WNNFbIHT0rfFNWsfi8sLAe2blalSF0cBgcWiDwFweSReK3RGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800036; c=relaxed/simple;
	bh=xz79v/kXBSqS+dBFRwR3PXjzIXl363ibkr7voH7mVjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c06K3TvoAYqnpLBAdM0xcSss6mI5tRtp0d3VAwcyLEONjZAP8vqxAypNlL+47O9Akn8p6hmh2FsOWBG7J7OggpJwL0XvEcjvRIguuQT+mIKX5FVvwJI6k3uWzqfyPym1W9dffasC3YYEy4C69oFwlXvLPrLdmrDzwKuEg7X8DNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hrgdBIPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHxW/E/6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9MiDMxAMFYXy95Wo0hr7hjOTgj4Sz+FG8M7DtLrHLs=;
	b=hrgdBIPPglzj70oOjPkwY7L7XEV2h4djeqJM5+z1Hgc34x7NibCp1rleSi0ZGr+y/pI2p6
	qAnM5gG4sM1XYzC7MktO5Kh2RFwSo7/zpv627mPZDJEEX9dhM00XEi52F0Si7sz7kUfy/m
	mZM72P7jom22bGe9lTtMXsae7kziT9q1vwiLSmUWQYwmB9esoRKabodIdMUElpmxYElq/D
	5++TPbyIALQN2c8gZMTshQvRe0eTmg90el0OQ5zTNlRiOoDge4ZzhWtrZ7FYsRsdtYSwog
	49OvpW7hpDGxKq3bqSAy/VWqQzj0leg2mHGnYNhgmjvX9WbTWeNtHIhS2aeEvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9MiDMxAMFYXy95Wo0hr7hjOTgj4Sz+FG8M7DtLrHLs=;
	b=yHxW/E/6ZV+YSxrZLExA663ie3frWWz1smcaEP4upJHHEgT9nE0siCBQx3U4oNlzM5LSKS
	AfqNVgLPc2/i3kAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move rdt_find_domain() to be visible to
 arch and fs code
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-13-james.morse@arm.com>
References: <20250311183715.16445-13-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003177.14745.4871486365540928129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e3d5138cefbffa8ea1bf8aab3629268bc3381219
Gitweb:        https://git.kernel.org/tip/e3d5138cefbffa8ea1bf8aab3629268bc3381219
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:22:56 +01:00

x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code

rdt_find_domain() finds a domain given a resource and a cache-id.  This is
used by both the architecture code and the filesystem code.

After the filesystem code moves to live in /fs/, this helper is either
duplicated by all architectures, or needs exposing by the filesystem code.

Add the declaration to the global header file. As it's now globally visible,
and has only a handful of callers, swap the 'rdt' for 'resctrl'. Move the
function to live with its caller in ctrlmondata.c as the filesystem code will
not have anything corresponding to core.c.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-13-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 38 ++--------------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 24 +++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 include/linux/resctrl.h                   | 14 ++++++++-
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2129951..850cb86 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -394,36 +394,6 @@ void rdt_ctrl_update(void *arg)
 	hw_res->msr_update(m);
 }
 
-/*
- * rdt_find_domain - Search for a domain id in a resource domain list.
- *
- * Search the domain list to find the domain id. If the domain id is
- * found, return the domain. NULL otherwise.  If the domain id is not
- * found (and NULL returned) then the first domain with id bigger than
- * the input id can be returned to the caller via @pos.
- */
-struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
-				       struct list_head **pos)
-{
-	struct rdt_domain_hdr *d;
-	struct list_head *l;
-
-	list_for_each(l, h) {
-		d = list_entry(l, struct rdt_domain_hdr, list);
-		/* When id is found, return its domain. */
-		if (id == d->id)
-			return d;
-		/* Stop searching when finding id's position in sorted list. */
-		if (id < d->id)
-			break;
-	}
-
-	if (pos)
-		*pos = l;
-
-	return NULL;
-}
-
 static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -534,7 +504,7 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
+	hdr = resctrl_find_domain(&r->ctrl_domains, id, &add_pos);
 	if (hdr) {
 		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
 			return;
@@ -589,7 +559,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
+	hdr = resctrl_find_domain(&r->mon_domains, id, &add_pos);
 	if (hdr) {
 		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
 			return;
@@ -654,7 +624,7 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
+	hdr = resctrl_find_domain(&r->ctrl_domains, id, NULL);
 	if (!hdr) {
 		pr_warn("Can't find control domain for id=%d for CPU %d for resource %s\n",
 			id, cpu, r->name);
@@ -700,7 +670,7 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
+	hdr = resctrl_find_domain(&r->mon_domains, id, NULL);
 	if (!hdr) {
 		pr_warn("Can't find monitor domain for id=%d for CPU %d for resource %s\n",
 			id, cpu, r->name);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 5d87f27..763317e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -610,6 +610,28 @@ int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
+					   struct list_head **pos)
+{
+	struct rdt_domain_hdr *d;
+	struct list_head *l;
+
+	list_for_each(l, h) {
+		d = list_entry(l, struct rdt_domain_hdr, list);
+		/* When id is found, return its domain. */
+		if (id == d->id)
+			return d;
+		/* Stop searching when finding id's position in sorted list. */
+		if (id < d->id)
+			break;
+	}
+
+	if (pos)
+		*pos = l;
+
+	return NULL;
+}
+
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
@@ -695,7 +717,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 * This file provides data from a single domain. Search
 		 * the resource to find the domain with "domid".
 		 */
-		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		hdr = resctrl_find_domain(&r->mon_domains, domid, NULL);
 		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
 			ret = -ENOENT;
 			goto out;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8291f1b..da73404 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -581,8 +581,6 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
 int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
 int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 			     umode_t mask);
-struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
-				       struct list_head **pos);
 ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f1979e3..93d9a43 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -373,6 +373,20 @@ static inline void resctrl_arch_rmid_read_context_check(void)
 }
 
 /**
+ * resctrl_find_domain() - Search for a domain id in a resource domain list.
+ * @h:		The domain list to search.
+ * @id:		The domain id to search for.
+ * @pos:	A pointer to position in the list id should be inserted.
+ *
+ * Search the domain list to find the domain id. If the domain id is
+ * found, return the domain. NULL otherwise.  If the domain id is not
+ * found (and NULL returned) then the first domain with id bigger than
+ * the input id can be returned to the caller via @pos.
+ */
+struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
+					   struct list_head **pos);
+
+/**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
  *			       and eventid.
  * @r:		The domain's resource.

