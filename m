Return-Path: <linux-tip-commits+bounces-1573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057292482B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AF128A33A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949C1CFD6B;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpjRtwRq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vkNzItSZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398851CF3E0;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948259; cv=none; b=AlvmuFnAfgipskQ8gpM8mkW9UFekIMEQpyUXEY2sY8l63UdGUIviccsDmVBy6ziXBc58DMgPEIUY+GxIAg1lXJh0WgYQkGhBRSoBUCG8/2jVkK3Fxbp1FlC50e93sLWb+POQvU720ye7NvG9kqKck5fWs8ZRLQYG0aMawMqoG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948259; c=relaxed/simple;
	bh=oMQvUSRtH/oYx3lD/FQZr0lkUMACa2bl2UNOd8PvIfU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RBtrj8vCpa5WGiQp4zCv2k57t9wcfqjDafcmeZAV9+XucK2X3/D7kRUEXg8Yp1nbsjbKGudL5N7xLRKS/RAY8exBF3DneR+cug8fOrYCQLJSnDqnjI0lE1XvIepYbQJOAOHXHupY2J5Gba5EOFpoXp+HxnLArf4A1/EFaW0+kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpjRtwRq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vkNzItSZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dR+DgmlZEd1pDjqDZYIK4/a+7lD35kkeQzbntnX71Ts=;
	b=HpjRtwRqR3XwT5tNvxQfCNv/sBJ6rqCsWC8WyIiGj1M5X77KrQOzhTabBZ57tGp6MLZnML
	1oiW01ghPjuCstfsFERtLh3XkJhOy4LhvxOpX2gyCFgbBihgAe2Dd97NtRmyt8YOtEyIec
	j2DHVMYQYxAnOjGZWvzjl0g1iYkrCej3QPLx57+wnbYYm1IVkDnzx5HNBw2M/Ouvc2IOST
	Q1tprvMozZt1EWi8+3jouo1jlEtOjs3Ey1FDMuQOFGHhAiFJ7gcVpRmF5lMplJaomEfHiy
	gEFLP/tOJZLwkB05/836P7uaslZbMo0aEz02PxPv4TaDoDVDhjIZPJVVCdjMiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dR+DgmlZEd1pDjqDZYIK4/a+7lD35kkeQzbntnX71Ts=;
	b=vkNzItSZywZyZ8n/wq8sWKzjk5jq3C8N5rt2AbqKH7b4DXKadzuoOhTlOG64XFI7FQe8My
	Mr3sxka1x/0EMjBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Block use of mba_MBps mount option on
 Sub-NUMA Cluster (SNC) systems
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-8-tony.luck@intel.com>
References: <20240628215619.76401-8-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825517.2215.364968821216240098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ac20aa423052553c005089b00f1e3caf79d3c1d3
Gitweb:        https://git.kernel.org/tip/ac20aa423052553c005089b00f1e3caf79d3c1d3
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:07 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems

When SNC is enabled there is a mismatch between the MBA control function
which operates at L3 cache scope and the MBM monitor functions which
measure memory bandwidth on each SNC node.

Block use of the mba_MBps when scopes for MBA/MBM do not match.

Improve user diagnostics by adding invalfc() message when mba_MBps
is not supported.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-8-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eb3bbfa..d3b0fa9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2335,14 +2335,18 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
 
 /*
  * MBA software controller is supported only if
- * MBM is supported and MBA is in linear scale.
+ * MBM is supported and MBA is in linear scale,
+ * and the MBM monitor scope is the same as MBA
+ * control scope.
  */
 static bool supports_mba_mbps(void)
 {
+	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	return (is_mbm_local_enabled() &&
-		r->alloc_capable && is_mba_linear());
+		r->alloc_capable && is_mba_linear() &&
+		r->ctrl_scope == rmbm->mon_scope);
 }
 
 /*
@@ -2750,6 +2754,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	struct fs_parse_result result;
+	const char *msg;
 	int opt;
 
 	opt = fs_parse(fc, rdt_fs_parameters, param, &result);
@@ -2764,8 +2769,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
+		msg = "mba_MBps requires local MBM and linear scale MBA at L3 scope";
 		if (!supports_mba_mbps())
-			return -EINVAL;
+			return invalfc(fc, msg);
 		ctx->enable_mba_mbps = true;
 		return 0;
 	case Opt_debug:

