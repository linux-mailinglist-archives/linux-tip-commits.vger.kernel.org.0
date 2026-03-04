Return-Path: <linux-tip-commits+bounces-8352-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJJQMdBcqGmZtgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8352-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 17:24:48 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406882042B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53716303779A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88634B438;
	Wed,  4 Mar 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcUHgMrW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKlxgCWM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDF34B1AD;
	Wed,  4 Mar 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639180; cv=none; b=dtymROBVN0IxvqllBT14ojpmAil0059vXxcOWarF7K5EVH161xnbUylt2mXmb7CwQbBxNQw8nxChxa7bExdAb9lAXe3UTWZCGxhBpT5NE9ht0EVfwOxBT1haaZ2y/mkB/yw4/MDXqz8UlLw/1W33WUHw1r6Rxm8y9Z66Wco3ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639180; c=relaxed/simple;
	bh=fU2hF7vQMAxBxabpJL/1bcWkI4C2FzlqMsnqOBqmX5s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CW1znPiYndPsifPiD2q4ULjIQXtaKTF7lUuUFtbfhOD9G0QK0nCmqLWNC/V8JE1LiyShumIj2lQqlJElAORaxFb1iAI2CSEpKQsqat7Ebf1EW/x4ikPDOOVN16YWA0bUZPTbG1gP/ZM0W6biVokFI4CGMLWA/QCHjhXU5hI9C24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcUHgMrW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKlxgCWM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 15:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772639177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEsz9buGsBxqxNGo+mMF7mtVAArPc0OhKnnw2M8ONMk=;
	b=NcUHgMrWE755YYJnf3QZkRx3cWLLmWimk1ssbKsFezF1ZtC0OZvn353K8GGSM0cqguTNl4
	r6cxhP2YJSqLZE2+9Ie3tMU6NGa3a0uw1eRlHq4IRIqX4T6f2Wpc+0Cbm0dt54RWChvIsC
	O7RiSIAMd/CIjSat24bm5JBl+1cLuzTgSo6Dy/HDND4BQQh6s5Reeaq0jHqiZbJuOeEs4g
	oJ0wJJM+eU9rkyEff22HKNDAjiIDRR9m4BDs3Wsz8WvYvFJX6Akc0T5+iWqQwJ3q0bsby6
	stlLi5tyBJOjphb0nh9vvs5wDhQ1HHz/JCBMw6qSsSlNlHEbD/0/n0k6iCpZBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772639177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEsz9buGsBxqxNGo+mMF7mtVAArPc0OhKnnw2M8ONMk=;
	b=LKlxgCWMRx/d3rM6k8LMvkeic5/DINQNFdNqi5n1+lBiNedJj7I8S7zTuxnn4zuWF1zSIA
	qc57w6jH8YPW4BDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topo: Replace x86_has_numa_in_package
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 Chen Yu <yu.c.chen@intel.com>, Kyle Meyer <kyle.meyer@hpe.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303110100.123701837@infradead.org>
References: <20260303110100.123701837@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177263917630.1647592.7303732626779361776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 406882042B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8352-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,infradead.org:email,intel.com:email,vger.kernel.org:replyto,hpe.com:email,amd.com:email,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     717b64d58cff6fb97f97be07e382ed7641167a56
Gitweb:        https://git.kernel.org/tip/717b64d58cff6fb97f97be07e382ed76411=
67a56
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Mar 2026 11:55:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 16:35:08 +01:00

x86/topo: Replace x86_has_numa_in_package

.. with the brand spanking new topology_num_nodes_per_package().

Having the topology setup determine this value during MADT/SRAT parsing before
SMP bringup avoids having to detect this situation when building the SMP
topology masks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://patch.msgid.link/20260303110100.123701837@infradead.org
---
 arch/x86/kernel/smpboot.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5cd6950..db3e481 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -468,13 +468,6 @@ static int x86_cluster_flags(void)
 }
 #endif
=20
-/*
- * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
- * Sub-NUMA Clustering have this.
- */
-static bool x86_has_numa_in_package;
-
 static struct sched_domain_topology_level x86_topology[] =3D {
 	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
@@ -496,7 +489,7 @@ static void __init build_sched_topology(void)
 	 * PKG domain since the NUMA domains will auto-magically create the
 	 * right spanning domains based on the SLIT.
 	 */
-	if (x86_has_numa_in_package) {
+	if (topology_num_nodes_per_package() > 1) {
 		unsigned int pkgdom =3D ARRAY_SIZE(x86_topology) - 2;
=20
 		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
@@ -550,7 +543,7 @@ int arch_sched_node_distance(int from, int to)
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_ATOM_DARKMONT_X:
=20
-		if (!x86_has_numa_in_package || topology_max_packages() =3D=3D 1 ||
+		if (topology_max_packages() =3D=3D 1 || topology_num_nodes_per_package() =
=3D=3D 1 ||
 		    d < REMOTE_DISTANCE)
 			return d;
=20
@@ -606,7 +599,7 @@ void set_cpu_sibling_map(int cpu)
 		o =3D &cpu_data(i);
=20
 		if (match_pkg(c, o) && !topology_same_node(c, o))
-			x86_has_numa_in_package =3D true;
+			WARN_ON_ONCE(topology_num_nodes_per_package() =3D=3D 1);
=20
 		if ((i =3D=3D cpu) || (has_smt && match_smt(c, o)))
 			link_mask(topology_sibling_cpumask, cpu, i);

