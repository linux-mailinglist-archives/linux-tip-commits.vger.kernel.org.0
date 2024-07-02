Return-Path: <linux-tip-commits+bounces-1568-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116E924824
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BB7B249C5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B41CF3CC;
	Tue,  2 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jpSfIwxH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GCz0Oo5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A601CE08C;
	Tue,  2 Jul 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948256; cv=none; b=gVzraf21fh1nR9rWiHBhTE7cEBNd89Jrh/Y6ykvYHGLGKaxjnJNKXEV8TWIGKgi7o9PlzkCHENUfnckg38Y51Q35J35GmuyJeGK6NLTZJ40Mk3vH8jF11jvGllMyf+7GC2E03zg2M3dZeZp+eaO5oLvI0a9zKAUAlkDV6/Q69Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948256; c=relaxed/simple;
	bh=jLAlgI+FhQ/IFkymc3E8k00dm+lFH4OdM8tytIxAzqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z6PGQyEc1yDdeP7GCCenz8BFILexYQAWhgKuqJuxCUQxN1EA5El9+fpuwa90/aGmrVZHvnuKVn4e1EqmQnb3hWDsCxDXbmrBP1ANmlmvDp56lGDdQASnK3dsrsw2S7DHkEh6RHV/9FRuaKtd8B0N5cLEpYsnBPhgyV/hLAMz2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jpSfIwxH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GCz0Oo5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3gwBeRDAJe9r75Ocz8NYHn0+UQTYeavY4F4GLva8zg=;
	b=jpSfIwxHdkAQcOU6Q70yU/Mycv0Gdg73L1iNlywgEHnzu1SP23dcvRWcbw4EClhRzs4swB
	LSqJDz6aQ5/OPS4ORjvrqGBemEkvqRxQ5jSF+TWGl0thqvbe+Sr6iKFJ0AecpaT4G5JuF5
	DWsPlR8kSFIbsBgr4pJpM3tr35e+6ylHkCqIINeGzwn+Y4YlhU3+BNh4318Qefen/cxTNZ
	1c1BUJ8tGhogQTXiVxRqPxkrEBUWS7WFxqgrQ03Mzm3gveJKcRia4MLlPlqB2Bhs6ZQ09h
	cMEx9hUvcqXYBgTaT/UULl2tStYdE/p+xdS9xIi7VeXctReZYDy7CpOjRn3XWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3gwBeRDAJe9r75Ocz8NYHn0+UQTYeavY4F4GLva8zg=;
	b=3GCz0Oo5N8MAEzPLrvhPjjKunJEgpdKMjLEr3Hz7esFIe+clt4L1mzpIWNdqdT5A5VEyHY
	viaH5QfHlb/baJAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fill out rmid_read structure for
 smp_call*() to read a counter
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-16-tony.luck@intel.com>
References: <20240628215619.76401-16-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825243.2215.15309243956805882948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     c8c7d3d904b76c45fe2b5dc982fb5090d12a63af
Gitweb:        https://git.kernel.org/tip/c8c7d3d904b76c45fe2b5dc982fb5090d12a63af
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:15 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:57:19 +02:00

x86/resctrl: Fill out rmid_read structure for smp_call*() to read a counter

mon_event_read() fills out most fields of the struct rmid_read that is passed
via an smp_call*() function to a CPU that is part of the correct domain to
read the monitor counters.

With Sub-NUMA Cluster (SNC) mode there are now two cases to handle:

1) Reading a file that returns a value for a single domain.
   + Choose the CPU to execute from the domain cpu_mask

2) Reading a file that must sum across domains sharing an L3 cache
   instance.
   + Indicate to called code that a sum is needed by passing a NULL
     rdt_mon_domain pointer.
   + Choose the CPU from the L3 shared_cpu_map.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-16-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4d76ff3..50fa1fe 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -515,7 +515,7 @@ static int smp_mon_event_count(void *arg)
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    int evtid, int first)
+		    cpumask_t *cpumask, int evtid, int first)
 {
 	int cpu;
 
@@ -536,7 +536,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
-	cpu = cpumask_any_housekeeping(&d->hdr.cpu_mask, RESCTRL_PICK_ANY_CPU);
+	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
 	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
@@ -545,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	 * counters on some platforms if its called in IRQ context.
 	 */
 	if (tick_nohz_full_cpu(cpu))
-		smp_call_function_any(&d->hdr.cpu_mask, mon_event_count, rr, 1);
+		smp_call_function_any(cpumask, mon_event_count, rr, 1);
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
@@ -574,16 +574,40 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-
 	r = &rdt_resources_all[resid].r_resctrl;
-	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
-	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+
+	if (md.u.sum) {
+		/*
+		 * This file requires summing across all domains that share
+		 * the L3 cache id that was provided in the "domid" field of the
+		 * mon_data_bits union. Search all domains in the resource for
+		 * one that matches this cache id.
+		 */
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (d->ci->id == domid) {
+				rr.ci = d->ci;
+				mon_event_read(&rr, r, NULL, rdtgrp,
+					       &d->ci->shared_cpu_map, evtid, false);
+				goto checkresult;
+			}
+		}
 		ret = -ENOENT;
 		goto out;
+	} else {
+		/*
+		 * This file provides data from a single domain. Search
+		 * the resource to find the domain with "domid".
+		 */
+		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
 	}
-	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
-	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
+checkresult:
 
 	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 13d8622..16982d1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -632,7 +632,7 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    int evtid, int first);
+		    cpumask_t *cpumask, int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 58e53f1..d7163b7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3070,7 +3070,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 			return ret;
 
 		if (!do_sum && is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
+			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
 	}
 
 	return 0;

