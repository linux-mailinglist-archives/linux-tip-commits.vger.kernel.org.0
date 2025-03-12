Return-Path: <linux-tip-commits+bounces-4138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED7A5E268
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1490B17528E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0524A064;
	Wed, 12 Mar 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G88ir4Ii";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8tPh4i2x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D022DF8D;
	Wed, 12 Mar 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800022; cv=none; b=a7fjOzh9EopvBZjc28KJLoaawC8UBts2/QbT0zPIp4XJdE/uLl/g7nTMKFndVTMAf7dL12mwTvrANRDRr8LRMdRegASDGN9d07LVhAui3On5cnCuJyZcM6r4ra1OsiCwcimtUkL0+go1ETO+hUCZAaJQjmYo5J7Jue0uP2hZd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800022; c=relaxed/simple;
	bh=FcMnXU3mEnLxU8VKwzzn/zWoWJZBhZPcp3UYfj+8tWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NLIWfqHg+dqqa27ghN6fQEvHUmpXB56J2VIa9S9m2Idv3jro/5pQbt+lLPkwXXrLJICQjEqqyMesUIuL8pCCe5cUR1le/f11bBCWjROez3Ax5i0TKMdnFzyEB/JtOANBVFC2GeXxLpw6HOd9hMUOXIaAXNwI0UNocXU1ypPkljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G88ir4Ii; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8tPh4i2x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz+RpLic19MX4bLS6gh67Yr0UWDiEOC3u5GMMAWKII0=;
	b=G88ir4IiKGcMRKy8MbH4/UjGKY4fYKi8DBtQXvC+qir4sRbwjVkSh80elccABg+4z5FzzE
	CpoCo8+yvg01VigH2C9BjnMOG/WMntwG04hbLUtXlVOcNnTuXVma01TFYkSY+2Z0REsM6c
	kTmzj27jpcqmnW9Nzcc+MTXPvjf9SCazr0aKJImTl5eNf8UDNraUSnxNBRX5zgSaxWFIdk
	6mrttLycOGA6MqOY6PPFrXqnivcillAa3uh4KMF1VqqhTgLAYK0ELAmRzvNKf6G77TtK/Z
	/6vrKN//E1N13YfHRQ2ohNBTynxFxRaWvjm2MRjfY5c/TSPTwkb+ZDhFbLtlGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz+RpLic19MX4bLS6gh67Yr0UWDiEOC3u5GMMAWKII0=;
	b=8tPh4i2xWAUJ/yT+CRnsZy7B8eLz8IBIcjEbPlbZXBK6wVUj+bQ27cifDYlA4/BSJ8+Rup
	sYoyZwG7v2cpbYAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu()
 to live with their callers
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-31-james.morse@arm.com>
References: <20250311183715.16445-31-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180001282.14745.4934382896961256317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     823beb31e55673bf2fd21374e095eec73a761ee7
Gitweb:        https://git.kernel.org/tip/823beb31e55673bf2fd21374e095eec73a761ee7
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:15 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:58 +01:00

x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their callers

Each of get_{mon,ctrl}_domain_from_cpu() only has one caller.

Once the filesystem code is moved to /fs/, there is no equivalent to
core.c.

Move these functions to each live next to their caller. This allows
them to be made static and the header file entries to be removed.

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
Link: https://lore.kernel.org/r/20250311183715.16445-31-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 30 +-------------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++++-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e590dd3..cf29681 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -347,36 +347,6 @@ static void cat_wrmsr(struct msr_param *m)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
-{
-	struct rdt_ctrl_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
-struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
-{
-	struct rdt_mon_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->mon_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
 {
 	return resctrl_to_arch_res(r)->num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0d13006..c44c5b4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -475,8 +475,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
-struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
-struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 83f9012..a93ed7d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -718,6 +718,22 @@ void mon_event_count(void *info)
 		rr->err = 0;
 }
 
+static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu,
+							struct rdt_resource *r)
+{
+	struct rdt_ctrl_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
 /*
  * Feedback loop for MBA software controller (mba_sc)
  *
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5fc60c9..c6274d4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4257,6 +4257,22 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 	}
 }
 
+static struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu,
+						      struct rdt_resource *r)
+{
+	struct rdt_mon_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
 void resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);

