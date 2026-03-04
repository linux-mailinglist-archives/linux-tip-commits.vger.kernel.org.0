Return-Path: <linux-tip-commits+bounces-8351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG3pBU9aqGmZtgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 17:14:07 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799A203F42
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61A63448EAB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C734D4F8;
	Wed,  4 Mar 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhltWEm0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7riZ8uQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED23491D0;
	Wed,  4 Mar 2026 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639179; cv=none; b=oWQ7dVjfNvsbBxtWTnXOIzxmDHXbrRTT1/TBCCzURZf1b2SBGRWtn3WHIorog/Oydf4UJhfiA8SSkM5IcHwd7Lr9yKZWYnQxb8CgpEfwKd9l3D/mCHaHBK/drR6IqdV05vSvMrp4v7kRFihUT/7aUzVlpbOxMl0o9bWg4Wals1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639179; c=relaxed/simple;
	bh=oi1OoPTLHiLAj2d2z0JneD+SBC0MBuSAHf0Jx69wSTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U+gErnI/ym4YUWVTXmg3FvMmlXmP8tgSkSEKWeoPNhsxMpESNVTdKi5GR3W8E0DJkmL6iT2NyMYAHL0zfxCOPbc7oeDruqqRBuNjWUhfduE38HD9jolMuBmkDG6tuZ5R5Z/XslONkcelLZDpREfsy4X3cvPibUBEz2L1fGMUe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhltWEm0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7riZ8uQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 15:46:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772639176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6whXGb3X6a3PBADReTwiswPH/4ElbJBqyLtV3f7yaKg=;
	b=MhltWEm0gpRjxdhk9p/0iNOFVd3i1ibyy48qnPLmNS6arifZcWFfJWpI5gpARpPmckN4ZO
	YTA3upM5okg472C47pJ5XB7poiOikLLN/7jwuu+Xdt9HpsWRGySDxFA21KtPG+O5IYQq8U
	HLMTb00WR7QDIVp3PiC7lM0f/KowriidbboDsLslbhnrv5PUSA8E/rkkSJ0Upthgwp2yiw
	vdC2BqfCEZeUm5HYDH9qcVhLM6umJ21/X+F/SJUEG7QE4gptO/6Mz2IyZPLq1syr7zgLYK
	HKeyGxKxNf2e60BYa/sEIU3FlHEbpc+XodMWGY/8s3XvGgak2TJ/+9QFI2Namg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772639176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6whXGb3X6a3PBADReTwiswPH/4ElbJBqyLtV3f7yaKg=;
	b=J7riZ8uQx3PqFiIHWiDNRa31FFm1jnCVzfzQ2Wl1mpz+nHpDsOkMx/PIcWsnWL9L8FiKvf
	v+GstAG1v2Ra2IBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topo: Fix SNC topology mess
Cc: Kyle Meyer <kyle.meyer@hpe.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303110100.238361290@infradead.org>
References: <20260303110100.238361290@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177263917515.1647592.4845806078021816504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6799A203F42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8351-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:replyto,hpe.com:email,linutronix.de:dkim,infradead.org:email]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     528d89a4707e5bfd86e30823c45dbb66877df900
Gitweb:        https://git.kernel.org/tip/528d89a4707e5bfd86e30823c45dbb66877=
df900
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Mar 2026 11:55:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 16:35:09 +01:00

x86/topo: Fix SNC topology mess

Per 4d6dd05d07d0 ("sched/topology: Fix sched domain build error for GNR, CWF =
in
SNC-3 mode"), the original crazy SNC-3 SLIT table was:

node distances:
node     0    1    2    3    4    5
    0:   10   15   17   21   28   26
    1:   15   10   15   23   26   23
    2:   17   15   10   26   23   21
    3:   21   28   26   10   15   17
    4:   23   26   23   15   10   15
    5:   26   23   21   17   15   10

And per:

  https://lore.kernel.org/lkml/20250825075642.GQ3245006@noisy.programming.kic=
ks-ass.net/

The suggestion was to average the off-trace clusters to restore sanity.

However, 4d6dd05d07d0 implements this under various assumptions:

 - anything GNR/CWF with numa_in_package;
 - there will never be more than 2 packages;
 - the off-trace cluster will have distance >20

And then HPE shows up with a machine that matches the
Vendor-Family-Model checks but looks like this:

Here's an 8 socket (2 chassis) HPE system with SNC enabled:

node   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
  0:  10  12  16  16  16  16  18  18  40  40  40  40  40  40  40  40
  1:  12  10  16  16  16  16  18  18  40  40  40  40  40  40  40  40
  2:  16  16  10  12  18  18  16  16  40  40  40  40  40  40  40  40
  3:  16  16  12  10  18  18  16  16  40  40  40  40  40  40  40  40
  4:  16  16  18  18  10  12  16  16  40  40  40  40  40  40  40  40
  5:  16  16  18  18  12  10  16  16  40  40  40  40  40  40  40  40
  6:  18  18  16  16  16  16  10  12  40  40  40  40  40  40  40  40
  7:  18  18  16  16  16  16  12  10  40  40  40  40  40  40  40  40
  8:  40  40  40  40  40  40  40  40  10  12  16  16  16  16  18  18
  9:  40  40  40  40  40  40  40  40  12  10  16  16  16  16  18  18
 10:  40  40  40  40  40  40  40  40  16  16  10  12  18  18  16  16
 11:  40  40  40  40  40  40  40  40  16  16  12  10  18  18  16  16
 12:  40  40  40  40  40  40  40  40  16  16  18  18  10  12  16  16
 13:  40  40  40  40  40  40  40  40  16  16  18  18  12  10  16  16
 14:  40  40  40  40  40  40  40  40  18  18  16  16  16  16  10  12
 15:  40  40  40  40  40  40  40  40  18  18  16  16  16  16  12  10

 10 =3D Same chassis and socket
 12 =3D Same chassis and socket (SNC)
 16 =3D Same chassis and adjacent socket
 18 =3D Same chassis and non-adjacent socket
 40 =3D Different chassis

Turns out, the 'max 2 packages' thing is only relevant to the SNC-3 parts, the
smaller parts do 8 sockets (like usual). The above SLIT table is sane, but
violates the previous assumptions and trips a WARN.

Now that the topology code has a sensible measure of nodes-per-package, we can
use that to divinate the SNC mode at hand, and only fix up SNC-3 topologies.

There is a 'healthy' amount of paranoia code validating the assumptions on the
SLIT table, a simple pr_err(FW_BUG) print on failure and a fallback to using
the regular table. Lets see how long this lasts :-)

Fixes: 4d6dd05d07d0 ("sched/topology: Fix sched domain build error for GNR, C=
WF in SNC-3 mode")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://patch.msgid.link/20260303110100.238361290@infradead.org
---
 arch/x86/kernel/smpboot.c | 190 +++++++++++++++++++++++++++----------
 1 file changed, 143 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index db3e481..294a8ea 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -506,33 +506,149 @@ static void __init build_sched_topology(void)
 }
=20
 #ifdef CONFIG_NUMA
-static int sched_avg_remote_distance;
-static int avg_remote_numa_distance(void)
+/*
+ * Test if the on-trace cluster at (N,N) is symmetric.
+ * Uses upper triangle iteration to avoid obvious duplicates.
+ */
+static bool slit_cluster_symmetric(int N)
 {
-	int i, j;
-	int distance, nr_remote, total_distance;
-
-	if (sched_avg_remote_distance > 0)
-		return sched_avg_remote_distance;
-
-	nr_remote =3D 0;
-	total_distance =3D 0;
-	for_each_node_state(i, N_CPU) {
-		for_each_node_state(j, N_CPU) {
-			distance =3D node_distance(i, j);
-
-			if (distance >=3D REMOTE_DISTANCE) {
-				nr_remote++;
-				total_distance +=3D distance;
-			}
+	int u =3D topology_num_nodes_per_package();
+
+	for (int k =3D 0; k < u; k++) {
+		for (int l =3D k; l < u; l++) {
+			if (node_distance(N + k, N + l) !=3D
+			    node_distance(N + l, N + k))
+				return false;
 		}
 	}
-	if (nr_remote)
-		sched_avg_remote_distance =3D total_distance / nr_remote;
-	else
-		sched_avg_remote_distance =3D REMOTE_DISTANCE;
=20
-	return sched_avg_remote_distance;
+	return true;
+}
+
+/*
+ * Return the package-id of the cluster, or ~0 if indeterminate.
+ * Each node in the on-trace cluster should have the same package-id.
+ */
+static u32 slit_cluster_package(int N)
+{
+	int u =3D topology_num_nodes_per_package();
+	u32 pkg_id =3D ~0;
+
+	for (int n =3D 0; n < u; n++) {
+		const struct cpumask *cpus =3D cpumask_of_node(N + n);
+		int cpu;
+
+		for_each_cpu(cpu, cpus) {
+			u32 id =3D topology_logical_package_id(cpu);
+
+			if (pkg_id =3D=3D ~0)
+				pkg_id =3D id;
+			if (pkg_id !=3D id)
+				return ~0;
+		}
+	}
+
+	return pkg_id;
+}
+
+/*
+ * Validate the SLIT table is of the form expected for SNC, specifically:
+ *
+ *  - each on-trace cluster should be symmetric,
+ *  - each on-trace cluster should have a unique package-id.
+ *
+ * If you NUMA_EMU on top of SNC, you get to keep the pieces.
+ */
+static bool slit_validate(void)
+{
+	int u =3D topology_num_nodes_per_package();
+	u32 pkg_id, prev_pkg_id =3D ~0;
+
+	for (int pkg =3D 0; pkg < topology_max_packages(); pkg++) {
+		int n =3D pkg * u;
+
+		/*
+		 * Ensure the on-trace cluster is symmetric and each cluster
+		 * has a different package id.
+		 */
+		if (!slit_cluster_symmetric(n))
+			return false;
+		pkg_id =3D slit_cluster_package(n);
+		if (pkg_id =3D=3D ~0)
+			return false;
+		if (pkg && pkg_id =3D=3D prev_pkg_id)
+			return false;
+
+		prev_pkg_id =3D pkg_id;
+	}
+
+	return true;
+}
+
+/*
+ * Compute a sanitized SLIT table for SNC; notably SNC-3 can end up with
+ * asymmetric off-trace clusters, reflecting physical assymmetries. However
+ * this leads to 'unfortunate' sched_domain configurations.
+ *
+ * For example dual socket GNR with SNC-3:
+ *
+ * node distances:
+ * node     0    1    2    3    4    5
+ *     0:   10   15   17   21   28   26
+ *     1:   15   10   15   23   26   23
+ *     2:   17   15   10   26   23   21
+ *     3:   21   28   26   10   15   17
+ *     4:   23   26   23   15   10   15
+ *     5:   26   23   21   17   15   10
+ *
+ * Fix things up by averaging out the off-trace clusters; resulting in:
+ *
+ * node     0    1    2    3    4    5
+ *     0:   10   15   17   24   24   24
+ *     1:   15   10   15   24   24   24
+ *     2:   17   15   10   24   24   24
+ *     3:   24   24   24   10   15   17
+ *     4:   24   24   24   15   10   15
+ *     5:   24   24   24   17   15   10
+ */
+static int slit_cluster_distance(int i, int j)
+{
+	static int slit_valid =3D -1;
+	int u =3D topology_num_nodes_per_package();
+	long d =3D 0;
+	int x, y;
+
+	if (slit_valid < 0) {
+		slit_valid =3D slit_validate();
+		if (!slit_valid)
+			pr_err(FW_BUG "SLIT table doesn't have the expected form for SNC -- fixup=
 disabled!\n");
+		else
+			pr_info("Fixing up SNC SLIT table.\n");
+	}
+
+	/*
+	 * Is this a unit cluster on the trace?
+	 */
+	if ((i / u) =3D=3D (j / u) || !slit_valid)
+		return node_distance(i, j);
+
+	/*
+	 * Off-trace cluster.
+	 *
+	 * Notably average out the symmetric pair of off-trace clusters to
+	 * ensure the resulting SLIT table is symmetric.
+	 */
+	x =3D i - (i % u);
+	y =3D j - (j % u);
+
+	for (i =3D x; i < x + u; i++) {
+		for (j =3D y; j < y + u; j++) {
+			d +=3D node_distance(i, j);
+			d +=3D node_distance(j, i);
+		}
+	}
+
+	return d / (2*u*u);
 }
=20
 int arch_sched_node_distance(int from, int to)
@@ -542,34 +658,14 @@ int arch_sched_node_distance(int from, int to)
 	switch (boot_cpu_data.x86_vfm) {
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_ATOM_DARKMONT_X:
-
-		if (topology_max_packages() =3D=3D 1 || topology_num_nodes_per_package() =
=3D=3D 1 ||
-		    d < REMOTE_DISTANCE)
+		if (topology_max_packages() =3D=3D 1 ||
+		    topology_num_nodes_per_package() < 3)
 			return d;
=20
 		/*
-		 * With SNC enabled, there could be too many levels of remote
-		 * NUMA node distances, creating NUMA domain levels
-		 * including local nodes and partial remote nodes.
-		 *
-		 * Trim finer distance tuning for NUMA nodes in remote package
-		 * for the purpose of building sched domains. Group NUMA nodes
-		 * in the remote package in the same sched group.
-		 * Simplify NUMA domains and avoid extra NUMA levels including
-		 * different remote NUMA nodes and local nodes.
-		 *
-		 * GNR and CWF don't expect systems with more than 2 packages
-		 * and more than 2 hops between packages. Single average remote
-		 * distance won't be appropriate if there are more than 2
-		 * packages as average distance to different remote packages
-		 * could be different.
+		 * Handle SNC-3 asymmetries.
 		 */
-		WARN_ONCE(topology_max_packages() > 2,
-			  "sched: Expect only up to 2 packages for GNR or CWF, "
-			  "but saw %d packages when building sched domains.",
-			  topology_max_packages());
-
-		d =3D avg_remote_numa_distance();
+		return slit_cluster_distance(from, to);
 	}
 	return d;
 }

