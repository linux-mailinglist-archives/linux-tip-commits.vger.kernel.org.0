Return-Path: <linux-tip-commits+bounces-8350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNHmIXtUqGnUtAAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:49:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2F203438
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 16:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 218B2307529A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11834B437;
	Wed,  4 Mar 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3RCXKDId";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mjltz6o6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC634A784;
	Wed,  4 Mar 2026 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639179; cv=none; b=nMG3BRK7E2q6S0DkXOjGzi5C+Jnj51+0AVKVFH7miksNkUVZ+oqMpPPQ7KBF3FVMzEUjKMO2nWxDTImLAUAJoYJfimdqGeNMeHPsPU6YCACRcnyjcFXlKEzc0ThJYC+5ZxPsDpdITLHf3HPDLnQE19NqyyUKq4gC+9wGAx4hHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639179; c=relaxed/simple;
	bh=8Wzo78QPwlgG/J5l/RSYjQXr/kDjVVdrGf8Zeu1C6Oc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P5GHI14Z08nR/Zq7Q2SKhSPSZxCJpZztxv0w8nMiKYkdGH6W7VsEU9cfi+XASp6FWpI0CeUz20uVqz0fPenPdvyD7W1zehgUVtWN42C9x8KGl6gadQZH8q6SR/97ccvf7ZsOGP3IrrnSdaBUsPq/n05PK7GY2GDsMaJP0ZpPGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3RCXKDId; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mjltz6o6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 15:46:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772639175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YArgdDFYSaCC4GrAuakfKjUywYStxwdtlaIg/AKQjU=;
	b=3RCXKDId3OBMpqK1AiBGXsa6V9Ry1nteLbplE/+prKhveTsu3C0g775LhgRFsrhglS771j
	qDuvP4StgeAVWUYFaC2DQC67NkRwfQtXYf1RlxOnckEw5/kmYOM8FA1LfWpqls03rdClR9
	ccJryP89sg7S8OshDTzDXrDdoUwxCxnRPevNt2zbXwp8nSFsnZhAct6vJs69U3mlwj9fwM
	1/rD8Du3hdDwf8IGIwpBV1Z2EAEgjOP4BSrriWb6+SJ8oPvhO9IYHgyR7yfFe5v9B0Z3j1
	dG5wpIsTypuLao0kHlegWx9+M6nxbrSkS67rNNShFoXnCB0qoJuGVoUmQl2M0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772639175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YArgdDFYSaCC4GrAuakfKjUywYStxwdtlaIg/AKQjU=;
	b=Mjltz6o6qSZiCucsHCOwEKfkBuLS5jLoCSzWlTPmWUAFg79m9akLALPTsiZGor7oCGVu1F
	aeGp+w8h4LXnzSBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix SNC detection
Cc: Tony Luck <tony.luck@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303110100.367976706@infradead.org>
References: <20260303110100.367976706@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177263917393.1647592.6057050710859194701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27F2F203438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8350-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,intel.com:email,msgid.link:url,linutronix.de:dkim]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     59674fc9d0bfd96ce8a776680ee1cf22c28c9ac7
Gitweb:        https://git.kernel.org/tip/59674fc9d0bfd96ce8a776680ee1cf22c28=
c9ac7
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 03 Mar 2026 11:55:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 16:35:09 +01:00

x86/resctrl: Fix SNC detection

Now that the x86 topology code has a sensible nodes-per-package
measure, that does not depend on the online status of CPUs, use this
to divinate the SNC mode.

Note that when Cluster on Die (CoD) is configured on older systems this
will also show multiple NUMA nodes per package. Intel Resource Director
Technology is incomaptible with CoD. Print a warning and do not use the
fixup MSR_RMID_SNC_CONFIG.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Link: https://patch.msgid.link/aaCxbbgjL6OZ6VMd@agluck-desk3
Link: https://patch.msgid.link/20260303110100.367976706@infradead.org
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 36 +++-----------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index e6a1542..9bd87ba 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -364,7 +364,7 @@ void arch_mon_domain_online(struct rdt_resource *r, struc=
t rdt_l3_mon_domain *d)
 		msr_clear_bit(MSR_RMID_SNC_CONFIG, 0);
 }
=20
-/* CPU models that support MSR_RMID_SNC_CONFIG */
+/* CPU models that support SNC and MSR_RMID_SNC_CONFIG */
 static const struct x86_cpu_id snc_cpu_ids[] __initconst =3D {
 	X86_MATCH_VFM(INTEL_ICELAKE_X, 0),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, 0),
@@ -375,40 +375,14 @@ static const struct x86_cpu_id snc_cpu_ids[] __initcons=
t =3D {
 	{}
 };
=20
-/*
- * There isn't a simple hardware bit that indicates whether a CPU is running
- * in Sub-NUMA Cluster (SNC) mode. Infer the state by comparing the
- * number of CPUs sharing the L3 cache with CPU0 to the number of CPUs in
- * the same NUMA node as CPU0.
- * It is not possible to accurately determine SNC state if the system is
- * booted with a maxcpus=3DN parameter. That distorts the ratio of SNC nodes
- * to L3 caches. It will be OK if system is booted with hyperthreading
- * disabled (since this doesn't affect the ratio).
- */
 static __init int snc_get_config(void)
 {
-	struct cacheinfo *ci =3D get_cpu_cacheinfo_level(0, RESCTRL_L3_CACHE);
-	const cpumask_t *node0_cpumask;
-	int cpus_per_node, cpus_per_l3;
-	int ret;
-
-	if (!x86_match_cpu(snc_cpu_ids) || !ci)
-		return 1;
+	int ret =3D topology_num_nodes_per_package();
=20
-	cpus_read_lock();
-	if (num_online_cpus() !=3D num_present_cpus())
-		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
-	cpus_read_unlock();
-
-	node0_cpumask =3D cpumask_of_node(cpu_to_node(0));
-
-	cpus_per_node =3D cpumask_weight(node0_cpumask);
-	cpus_per_l3 =3D cpumask_weight(&ci->shared_cpu_map);
-
-	if (!cpus_per_node || !cpus_per_l3)
+	if (ret > 1 && !x86_match_cpu(snc_cpu_ids)) {
+		pr_warn("CoD enabled system? Resctrl not supported\n");
 		return 1;
-
-	ret =3D cpus_per_l3 / cpus_per_node;
+	}
=20
 	/* sanity check: Only valid results are 1, 2, 3, 4, 6 */
 	switch (ret) {

