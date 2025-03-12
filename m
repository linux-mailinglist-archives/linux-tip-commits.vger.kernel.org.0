Return-Path: <linux-tip-commits+bounces-4151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EEA5E28C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F299C3B6CD3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1125D1E5;
	Wed, 12 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cR6L4N3l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0i69FzqN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEF25B68E;
	Wed, 12 Mar 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800032; cv=none; b=fspXnJwZ5IddwZylAVH0uX4X/SQI60My6O9h5c5IGg6K3wo2JycoFnj8naFQU+w+K9VMo7JxN+9+3J2lA6m/MGrC2bhgE5Qy7y9/5jYLbGrSBf4/Sr7Gu4oKYKWwoiQyJ0UinJ9Bxipg3pDk51Bm0R7h6NsaMi80hs14/MVxe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800032; c=relaxed/simple;
	bh=+cVv0wvrZ5POpYz2gs9MfqPK/1Ci7niLDKDfxr0ZmOo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gzlHgCGoYYRPOJkchbCePbevJous+fLUlf6A0Z60fLKbCKkkboRBILA9f1YHMD2hv7jo82+DVSTazV5y2Bdem8cJGSC1W8+Q1br+cgpFuiSWsmZlWxwNZIpxKLh3gtUER3P9A7hOjWkwh8uoR355UczQFQz9l+7UCahCIfY0v98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cR6L4N3l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0i69FzqN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTl666/Q35C5tHBj8gV1LoWeo4JiCK5AuKRYiSSJ5+8=;
	b=cR6L4N3lPEHvs7+MezPbZGyUGn8bXSGI17a5+ceEkU9+gfmFWdEMGGFo9shl/3CfWrWK1z
	KaOG5r1J2BOJXX5BNBvJn57QoqeRV5/0A/LYVW4jX7KlIQ11/COsRiB7cu64v5IW82zgOj
	UjFUHxtcLWL2C7bUj9EsBHxC86T2/+CWrtXigyEIjwilEGbXD1WMCFH4m+qJglQwj9Cd4b
	o+fw1aHL63T9S52aKQ0LEVn83i2ju85MLKeKjhtlz9XDzOr+NohdOENmu71rOXSsaDv5u0
	eV9DQeWWLHxcoH2s5VoljTrLDf4GYoFb0v7Fv8H5xqmyx6X+QljKwGSH1IsWRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTl666/Q35C5tHBj8gV1LoWeo4JiCK5AuKRYiSSJ5+8=;
	b=0i69FzqNWxjERFdDmxcHmfk8c/3taasj6uhsT8OB8inBefogFAUI+JjJjrEcWHCzW2X7Ix
	rHNvvcvmMbZdzoCQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-18-james.morse@arm.com>
References: <20250311183715.16445-18-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002784.14745.9886263851895536247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     88464bff035ecb28f8bf52dd9728fdc1aca228f9
Gitweb:        https://git.kernel.org/tip/88464bff035ecb28f8bf52dd9728fdc1aca228f9
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:02 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:30 +01:00

x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers

The for_each_*_rdt_resource() helpers walk the architecture's array of
structures, using the resctrl visible part as an iterator. These became
over-complex when the structures were split into a filesystem and
architecture-specific struct. This approach avoided the need to touch every
call site, and was done before there was a helper to retrieve a resource by
rid.

Once the filesystem parts of resctrl are moved to /fs/, both the arch's
resource array, and the definition of those structures is no longer
accessible. To support resctrl, each architecture would have to provide
equally complex macros.

Rewrite the macro to make use of resctrl_arch_get_resource(), and move these
to include/linux/resctrl.h so existing x86 arch code continues to use them.

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
Link: https://lore.kernel.org/r/20250311183715.16445-18-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 29 +-------------------------
 include/linux/resctrl.h                | 18 ++++++++++++++++-
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 70fbb90..82dbc16 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -475,14 +475,6 @@ extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 extern enum resctrl_event_id mba_mbps_default_event;
 
-static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
-{
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
-
-	hw_res++;
-	return &hw_res->r_resctrl;
-}
-
 static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 {
 	return rdt_resources_all[l].cdp_enabled;
@@ -492,27 +484,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
-/*
- * To return the common struct rdt_resource, which is contained in struct
- * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
- */
-#define for_each_rdt_resource(r)					      \
-	for (r = &rdt_resources_all[0].r_resctrl;			      \
-	     r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;	      \
-	     r = resctrl_inc(r))
-
-#define for_each_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable || r->mon_capable)
-
-#define for_each_alloc_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable)
-
-#define for_each_mon_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->mon_capable)
-
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 487b965..a392480 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,24 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/* Walk all possible resources, with variants for only controls or monitors. */
+#define for_each_rdt_resource(_r)						\
+	for ((_r) = resctrl_arch_get_resource(0);				\
+	     (_r) && (_r)->rid < RDT_NUM_RESOURCES;				\
+	     (_r) = resctrl_arch_get_resource((_r)->rid + 1))
+
+#define for_each_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable || (r)->mon_capable)
+
+#define for_each_alloc_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable)
+
+#define for_each_mon_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->mon_capable)
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.

