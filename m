Return-Path: <linux-tip-commits+bounces-6845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE3BE272F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5254D3E1261
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E711322A3E;
	Thu, 16 Oct 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZafQ7Hm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4+80QRL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DA321426;
	Thu, 16 Oct 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607228; cv=none; b=Evw3/c3Uv0LmPg6p4xQUh1eKBZkngvzXoVdzQPtY20kEeWTNGQy3riM8ijKuY5dzDmLCojX65XugCMChNoSZRxVioBIja591qb7lA2T48Dj4xG13Rvl6yty1y7SqO/fKyM6TVjRtwechwuRVNIL8BESb6M4hAS5RFLdUztPpOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607228; c=relaxed/simple;
	bh=X2Ra2ncmGjg2tUsrb9AzWkFjIoIK1kNksyzTjDeIcsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jZgnVt4TuvbK9bPGtZKDPePdzVd9xmmoaW3sXbhHt/gqNhR+sEple4mK6e6qBS7Rc7uXzrOl6/8MYDM+ZM1EnzzDTykercRomvIExc/OZjy/Ms6t3eZK6LJZsUPwJ5IA9z/u79r71ATe2v+kniH2+CyKNNpesOj8nuiSDQJ725E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZafQ7Hm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4+80QRL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0k4Z+Dzzvq1HSNMcqpKu6J5QE7jG6OJNz9gGAoQmNM=;
	b=0ZafQ7HmS1tlhTOD9mu+JPknqHomu15nQF1hmL5V21uGc7Y3VRYXG4OrhNAZmBonANoipq
	uRZI98MzkBdQcQ2KwyJTTKhKR4pANHmyttDQ/6y2ylkHHX3fwcgWY/pYCQ430mLCzdrZEw
	1qI/xtQY7hpsOJREpGhMNOw6qzRjHDkf/B88p7WW1MWHKTa3hK4BeVgrEcWRwQHHiz9Q2w
	Vnwl1R5RUzm3YDmKTGPFu9lQWPo063r5H/WVuwiR4m68YOQbHT5Iz7SOcokBj2pEC2tVGZ
	LcC4D3d4OAoSw7nY5z84aDR7pfMwTk6d9A3vDROfrMtYOiqyCrIrWDkonXFFXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0k4Z+Dzzvq1HSNMcqpKu6J5QE7jG6OJNz9gGAoQmNM=;
	b=n4+80QRLZvvVlQAtAbdaru78ltSIcDAH/YoAX566A9ClIr0S8G2tieEuwQkzvNaIT9FtHO
	tiK1tgUUdDAkZYBA==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Fix sched domain build error for
 GNR, CWF in SNC-3 mode
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca5825acdcc966590030f159ff3164518cadf8045=2E1759515?=
 =?utf-8?q?405=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Ca5825acdcc966590030f159ff3164518cadf8045=2E17595154?=
 =?utf-8?q?05=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722329.709179.14453004072336192791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4d6dd05d07d00bc3bd91183dab4d75caa8018db9
Gitweb:        https://git.kernel.org/tip/4d6dd05d07d00bc3bd91183dab4d75caa80=
18db9
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 03 Oct 2025 12:31:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:50 +02:00

sched/topology: Fix sched domain build error for GNR, CWF in SNC-3 mode

It is possible for Granite Rapids (GNR) and Clearwater Forest
(CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
is enabled, each die will become a separate NUMA node in the package
with different distances between dies within the same package.

For example, on GNR, we see the following numa distances for a 2 socket
system with 3 dies per socket:

    package 1       package2
	----------------
	|               |
    ---------       ---------
    |   0   |       |   3   |
    ---------       ---------
	|               |
    ---------       ---------
    |   1   |       |   4   |
    ---------       ---------
	|               |
    ---------       ---------
    |   2   |       |   5   |
    ---------       ---------
	|               |
	----------------

node distances:
node     0    1    2    3    4    5
0:   	10   15   17   21   28   26
1:   	15   10   15   23   26   23
2:   	17   15   10   26   23   21
3:   	21   28   26   10   15   17
4:   	23   26   23   15   10   15
5:   	26   23   21   17   15   10

The node distances above led to 2 problems:

1. Asymmetric routes taken between nodes in different packages led to
asymmetric scheduler domain perspective depending on which node you
are on.  Current scheduler code failed to build domains properly with
asymmetric distances.

2. Multiple remote distances to respective tiles on remote package create
too many levels of domain hierarchies grouping different nodes between
remote packages.

For example, the above GNR topology lead to NUMA domains below:

Sched domains from the perspective of a CPU in node 0, where the number
in bracket represent node number.

NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3]
NUMA-level 3    [0,1,2,3] [5]
NUMA-level 4    [0,1,2,3,5] [4]

Sched domains from the perspective of a CPU in node 4
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,2]
NUMA-level 3    [0,2,3,4,5] [1]

Scheduler group peers for load balancing from the perspective of CPU 0
and 4 are different.  Improper task could be chosen for load balancing
between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
in 0 or 2 that are in same package as node 1 first.  But instead tasks
in the remote package node 3, 4, 5 could be chosen with an equal chance
and could lead to excessive remote package migrations and imbalance of
load between packages.  We should not group partial remote nodes and
local nodes together.
Simplify the remote distances for CWF and GNR for the purpose of
sched domains building, which maintains symmetry and leads to a more
reasonable load balance hierarchy.

The sched domains from the perspective of a CPU in node 0 NUMA-level 1
is now
NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3,4,5]

The sched domains from the perspective of a CPU in node 4 NUMA-level 1
is now
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,1,2]

We have the same balancing perspective from node 0 or node 4.  Loads are
now balanced equally between packages.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
---
 arch/x86/kernel/smpboot.c | 70 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289ab..5709c9c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -515,6 +515,76 @@ static void __init build_sched_topology(void)
 	set_sched_topology(topology);
 }
=20
+#ifdef CONFIG_NUMA
+static int sched_avg_remote_distance;
+static int avg_remote_numa_distance(void)
+{
+	int i, j;
+	int distance, nr_remote, total_distance;
+
+	if (sched_avg_remote_distance > 0)
+		return sched_avg_remote_distance;
+
+	nr_remote =3D 0;
+	total_distance =3D 0;
+	for_each_node_state(i, N_CPU) {
+		for_each_node_state(j, N_CPU) {
+			distance =3D node_distance(i, j);
+
+			if (distance >=3D REMOTE_DISTANCE) {
+				nr_remote++;
+				total_distance +=3D distance;
+			}
+		}
+	}
+	if (nr_remote)
+		sched_avg_remote_distance =3D total_distance / nr_remote;
+	else
+		sched_avg_remote_distance =3D REMOTE_DISTANCE;
+
+	return sched_avg_remote_distance;
+}
+
+int arch_sched_node_distance(int from, int to)
+{
+	int d =3D node_distance(from, to);
+
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_ATOM_DARKMONT_X:
+
+		if (!x86_has_numa_in_package || topology_max_packages() =3D=3D 1 ||
+		    d < REMOTE_DISTANCE)
+			return d;
+
+		/*
+		 * With SNC enabled, there could be too many levels of remote
+		 * NUMA node distances, creating NUMA domain levels
+		 * including local nodes and partial remote nodes.
+		 *
+		 * Trim finer distance tuning for NUMA nodes in remote package
+		 * for the purpose of building sched domains. Group NUMA nodes
+		 * in the remote package in the same sched group.
+		 * Simplify NUMA domains and avoid extra NUMA levels including
+		 * different remote NUMA nodes and local nodes.
+		 *
+		 * GNR and CWF don't expect systems with more than 2 packages
+		 * and more than 2 hops between packages. Single average remote
+		 * distance won't be appropriate if there are more than 2
+		 * packages as average distance to different remote packages
+		 * could be different.
+		 */
+		WARN_ONCE(topology_max_packages() > 2,
+			  "sched: Expect only up to 2 packages for GNR or CWF, "
+			  "but saw %d packages when building sched domains.",
+			  topology_max_packages());
+
+		d =3D avg_remote_numa_distance();
+	}
+	return d;
+}
+#endif /* CONFIG_NUMA */
+
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt =3D __max_threads_per_core > 1;

