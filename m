Return-Path: <linux-tip-commits+bounces-1567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC7924820
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF6E1C25782
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2A1CE0AB;
	Tue,  2 Jul 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJ+xmLls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpkaqUdE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7501CE088;
	Tue,  2 Jul 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948255; cv=none; b=aBF6d2ajKbygPpDTUGelf6WNnTXJRfgoDUhvTALxRUuNt4yZQYo9FYlhGXhFzpxliO2pD7pv43lhZh1GyRPc2AHHWs0Vllu8NwFKWci9ijFXgkpnbphtjF/wk0+gibHZwA0Dhb5fxjkv4QG0rlhCqaj+JvvHAqq/TQvNoED8jeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948255; c=relaxed/simple;
	bh=VG6Hq4/h7KDP0q5H1EJ7GmtURSB1tyDoNlkPyrDZjHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N14KjBqLkXY9TNQVQWM9wtY3YIlBbvPULKxp7wrp1mqMFzQLQVJuQnUVhCWUpcximbG7H+15+32LCuEfSl7T+pK4Yc7lYdHC06KC2XCR+iuuMJ3uHlIlr2PMcpUNzmClnVsgDlZMP9UYrErzZlp9k+z0Rq8o3unc/WB+V8DYEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJ+xmLls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpkaqUdE; arc=none smtp.client-ip=193.142.43.55
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
	bh=KRKP8icRR/2QpFvlaLpebPvPm25weRkY9nBWbi8gmMY=;
	b=KJ+xmLlsU9iZXbkpua8av/bA/bMCNeZ40KAqSaei9pEl1q9UHt7WDX6vgC4FWDYZqk8zzi
	zwI/XDn4zsOhRe8Tzrm0woyjqM/w+OkGML9G/C/rlFGBz+hK8Ahac/pUa/tQx10CDGsw0y
	ZfFY7J8BjpsePaFJvQfi/qdUOqZxvJsoFyn6OoCt+zquSqeJ//ARsGXgo2lFo3mpLt+TA7
	UoSNu4lnXEcY+cX8h6ySYcU397jOU+xVmgSxvRE1VGKrsHQfcIUHOAc/ZdpYBZacmYN4gr
	VoEHVL+dT0ttwVQ9WjdWw8wrMh4VLPx6/cUhJggzAYHq0yjFuBkljeJq6rxHbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRKP8icRR/2QpFvlaLpebPvPm25weRkY9nBWbi8gmMY=;
	b=wpkaqUdEJxwHNKhGZ5CxYdhQlWiUy+mUk16eZZjnvbQcrUy12Y29Tm7GJhJtguWFH5/Lae
	nEMGsgS4rLT92KCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Make __mon_event_count() handle sum domains
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-17-tony.luck@intel.com>
References: <20240628215619.76401-17-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825208.2215.17506703249107280689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9fbb303ec949a376f3cbdf6a2b66ad2212c24ebc
Gitweb:        https://git.kernel.org/tip/9fbb303ec949a376f3cbdf6a2b66ad2212c24ebc
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:16 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:57:22 +02:00

x86/resctrl: Make __mon_event_count() handle sum domains

Legacy resctrl monitor files must provide the sum of event values across
all Sub-NUMA Cluster (SNC) domains that share an L3 cache instance.

There are now two cases:
1) A specific domain is provided in struct rmid_read
   This is either a non-SNC system, or the request is to read data
   from just one SNC node.
2) Domain pointer is NULL. In this case the cacheinfo field in struct
   rmid_read indicates that all SNC nodes that share that L3 cache
   instance should have the event read and return the sum of all
   values.

Update the CPU sanity check. The existing check that an event is read
from a CPU in the requested domain still applies when reading a single
domain. But when summing across domains a more relaxed check that the
current CPU is in the scope of the L3 cache instance is appropriate
since the MSRs to read events are scoped at L3 cache level.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-17-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 51 +++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ca309c9..ca486d0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -324,9 +324,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
-		return -EINVAL;
-
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 	if (ret)
@@ -592,7 +589,10 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
+	int cpu = smp_processor_id();
+	struct rdt_mon_domain *d;
 	struct mbm_state *m;
+	int err, ret;
 	u64 tval = 0;
 
 	if (rr->first) {
@@ -603,14 +603,47 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
-					 &tval, rr->arch_mon_ctx);
-	if (rr->err)
-		return rr->err;
+	if (rr->d) {
+		/* Reading a single domain, must be on a CPU in that domain. */
+		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+			return -EINVAL;
+		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->err)
+			return rr->err;
 
-	rr->val += tval;
+		rr->val += tval;
 
-	return 0;
+		return 0;
+	}
+
+	/* Summing domains that share a cache, must be on a CPU for that cache. */
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+		return -EINVAL;
+
+	/*
+	 * Legacy files must report the sum of an event across all
+	 * domains that share the same L3 cache instance.
+	 * Report success if a read from any domain succeeds, -EINVAL
+	 * (translated to "Unavailable" for user space) if reading from
+	 * all domains fail for any reason.
+	 */
+	ret = -EINVAL;
+	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
+		if (d->ci->id != rr->ci->id)
+			continue;
+		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (!err) {
+			rr->val += tval;
+			ret = 0;
+		}
+	}
+
+	if (ret)
+		rr->err = ret;
+
+	return ret;
 }
 
 /*

