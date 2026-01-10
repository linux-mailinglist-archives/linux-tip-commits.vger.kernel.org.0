Return-Path: <linux-tip-commits+bounces-7838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F70D0DC25
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14863301F249
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055A22B8B6;
	Sat, 10 Jan 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HdIsMSMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg4dW2Bp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8122581;
	Sat, 10 Jan 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074355; cv=none; b=adEYbkbocKNAZyoFSQD/VK+7ekTvTc6tRmYR/lYNGXMmjUPvNyeJZHG7tv05kVk/i5iiwJFyQlcGBozjEtHKcl1espYseFVQaojOb2y7XwK3NAR4cF9BEYlgfMcjKX9hjpe91CO3/CucNklxyg0vdTCyyxj4ytpYCu5Ml5xu4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074355; c=relaxed/simple;
	bh=GufGBrDKSwqgDum2yrXnD2jk1x2VHTJqf+Rh301vgiM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VEjGylLaoDIVbr99sFfH96QLGq24QcYsfZbIOCIjzGdpIteAAzp1SCtgbVP/X9MjubFjiXiFlqBdeu7T3efP4R7gtU1CVCA3fyfik3eOuiIhD5e66YSwdvY7Css8g6zq3EFCo7ft16lvDQ0VYj15IzSBCOcDJ/IqoYTPBj9rx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HdIsMSMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg4dW2Bp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fUaVDfJdgx2aN57HAsem8cfaN2p8C9bCyHVQiKlSJT8=;
	b=HdIsMSMQa8GTnWMltLyczRPHkgjYnGA4JIoD8a3UKqxJ6e8Tp5QV6Y8g2wx3YbaRBMxfX5
	9y+fjrmWqiX7yhjnnTUv7DMaHZr20VOyuMIWc4ZHPHqbqOESvyNSIW1nt26SETHmgVU7OL
	Tm/6R6gXVVO3i5dMsA5NxxjlXlBbmM6ECycpIMZG98AjebsveUf7zJ1qS32CTuT+wdtfDw
	FEHjfgYa6+BCKVHfRyyGzSru3vyrvmupJ0OzoIO5sUayw1xHhzotWZYAi63/dJBydER9ON
	fj0zcBaGZRI6WuWuZUsSBhdtw/NjY5JQ2qlhbu3fxri9ZNmztw918vu/0sKeFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fUaVDfJdgx2aN57HAsem8cfaN2p8C9bCyHVQiKlSJT8=;
	b=bg4dW2Bpe49iyfrN/vF3U9+CzRCfa7yB9I9fwSOM4Af36lln4epBdFTlGl5wi4rCgA6zit
	cGoQAZUhGtpIiRCw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Enable RDT_RESOURCE_PERF_PKG
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807430536.510.732440227351484733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4bbfc90122e974ccbd9aa80c964413052b9519f3
Gitweb:        https://git.kernel.org/tip/4bbfc90122e974ccbd9aa80c964413052b9=
519f3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 08 Jan 2026 09:42:27 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 11:48:13 +01:00

x86/resctrl: Enable RDT_RESOURCE_PERF_PKG

Since telemetry events are enumerated on resctrl mount the RDT_RESOURCE_PERF_=
PKG
resource is not considered "monitoring capable" during early resctrl initiali=
zation.
This means that the domain list for RDT_RESOURCE_PERF_PKG is not built when t=
he CPU
hotplug notifiers are registered and run for the first time right after resct=
rl
initialization.

Mark the RDT_RESOURCE_PERF_PKG as "monitoring capable" upon successful teleme=
try
event enumeration to ensure future CPU hotplug events include this resource a=
nd
initialize its domain list for CPUs that are already online.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c      | 16 ++++++++++++++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 0da44ca..9fcc06e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -766,8 +766,24 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
=20
 void resctrl_arch_pre_mount(void)
 {
+	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resc=
trl;
+	int cpu;
+
 	if (!intel_aet_get_events())
 		return;
+
+	/*
+	 * Late discovery of telemetry events means the domains for the
+	 * resource were not built. Do that now.
+	 */
+	cpus_read_lock();
+	mutex_lock(&domain_list_lock);
+	r->mon_capable =3D true;
+	rdt_mon_capable =3D true;
+	for_each_online_cpu(cpu)
+		domain_add_cpu_mon(cpu, r);
+	mutex_unlock(&domain_list_lock);
+	cpus_read_unlock();
 }
=20
 enum {
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index aba9971..89b8b61 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -270,6 +270,12 @@ static bool enable_events(struct event_group *e, struct =
pmt_feature_group *p)
 	else
 		r->mon.num_rmid =3D e->num_rmid;
=20
+	if (skipped_events)
+		pr_info("%s %s:0x%x monitoring detected (skipped %d events)\n", r->name,
+			e->pfname, e->guid, skipped_events);
+	else
+		pr_info("%s %s:0x%x monitoring detected\n", r->name, e->pfname, e->guid);
+
 	return true;
 }
=20

