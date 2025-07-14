Return-Path: <linux-tip-commits+bounces-6103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323FB03A64
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682F07AC508
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14DD23BCEF;
	Mon, 14 Jul 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJnW68Jq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jcCaFxrT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B6238171;
	Mon, 14 Jul 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484240; cv=none; b=FZi1l+QsPOdh9YIpYG8JDFtKCJaiy+J3bU1461sPJK4yEQJObv0X6qcHWLdEtbZxk9evm74RCm5wy5TE+TuuU+43soX+XPyKxURJ2VVnZSKhu2+P0hwG1RBG4PX0+uOIYBR5OT0t2KIqL6fY51iPgsPNYdxKX7OKa3Kd7ecQ7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484240; c=relaxed/simple;
	bh=IyJButhvWo/Mt9Stj5G4AuqMXuc4kPk+A5aKcVvjj3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mi50jTZsE6VLZd8NK8lawirDg3QOsij/GHf8MZj89ntFWeRKAlZ6MEGwgg5YYYbpB1bOHWtNZNBiGdhLqcTFI8VkiJRgTX3stwk1iFftQGEIDJuUG/vJ+X/P9xl+bWZ+vqpvrcR3ko/dVal0vpCdnN3bBMIZQqS5z687ob4ZdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJnW68Jq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jcCaFxrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlqnNJF2+AC3eQUzI4/1tQmZVDFDO4CREiam4y7TLf4=;
	b=BJnW68JqK2qFxc5BJV/NeYE2g1Gzx44g/ouNNOPK/fjRvrsxBMq5LPMwceuCyNV+d5uc0T
	Q6WAlVU+YWINl4VUgGv/j5vlnFyYi0qjd6Sz0cah7lC3DlMpnXpOihoZORZkR4IR+J03aO
	MCQC9La3ckVAePWCiKpc5RKOZYOGic+EUcCcTgdNF1pHDmtjwhwiW0MX7sGAQAxC3O6IwZ
	PxcvNOZgcauYDZIr590m7eFLfyijQpGBGVTfE1iW0Z6lefWtKVGSYILiBKLrhbOv556S9U
	dC0oojdzPGGqYL8+RT9FsHoEuyo+JTNXlbYw/of+q8fThxWVJDxf9QYtOrfAiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlqnNJF2+AC3eQUzI4/1tQmZVDFDO4CREiam4y7TLf4=;
	b=jcCaFxrTPz1v8iun0xaUdwAFpQk+367aEvp5M4L1lWffUi/BCW5wX1qsts68zYlwiRpvQ+
	ombViEv4pp8HkyAg==
From: "tip-bot2 for Li Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/smpboot: moves x86_topology to static
 initialize and truncate
Cc: Thomas Gleixner <tglx@linutronix.de>, Li Chen <chenl311@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710105715.66594-4-me@linux.beauty>
References: <20250710105715.66594-4-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423620.406.3273253849830165852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fbc2010d92e595dc13d8048db2419f963c8cb25e
Gitweb:        https://git.kernel.org/tip/fbc2010d92e595dc13d8048db2419f963c8cb25e
Author:        Li Chen <chenl311@chinatelecom.cn>
AuthorDate:    Thu, 10 Jul 2025 18:57:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:34 +02:00

x86/smpboot: moves x86_topology to static initialize and truncate

The #ifdeffery and the initializers in build_sched_topology() are just
disgusting.

Statically initialize the domain levels in the topology array and let
build_sched_topology() invalidate the package domain level when NUMA in
package is available.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250710105715.66594-4-me@linux.beauty
---
 arch/x86/kernel/smpboot.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 30e6df2..8038286 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -478,32 +478,30 @@ static int x86_cluster_flags(void)
  */
 static bool x86_has_numa_in_package;
 
-static struct sched_domain_topology_level x86_topology[6];
-
-static void __init build_sched_topology(void)
-{
-	int i = 0;
-
-	x86_topology[i++] = SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT);
+static struct sched_domain_topology_level x86_topology[] = {
+	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
-	x86_topology[i++] = SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS);
+	SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS),
 #endif
 #ifdef CONFIG_SCHED_MC
-	x86_topology[i++] = SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC);
+	SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC),
 #endif
-	/*
-	 * When there is NUMA topology inside the package skip the PKG domain
-	 * since the NUMA domains will auto-magically create the right spanning
-	 * domains based on the SLIT.
-	 */
-	if (!x86_has_numa_in_package)
-		x86_topology[i++] = SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG);
+	SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG),
+	{ NULL },
+};
 
+static void __init build_sched_topology(void)
+{
 	/*
-	 * There must be one trailing NULL entry left.
+	 * When there is NUMA topology inside the package invalidate the
+	 * PKG domain since the NUMA domains will auto-magically create the
+	 * right spanning domains based on the SLIT.
 	 */
-	BUG_ON(i >= ARRAY_SIZE(x86_topology) - 1);
+	if (x86_has_numa_in_package) {
+		unsigned int pkgdom = ARRAY_SIZE(x86_topology) - 2;
 
+		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
+	}
 	set_sched_topology(x86_topology);
 }
 

