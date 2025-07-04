Return-Path: <linux-tip-commits+bounces-5997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DEAF8E4F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E605A78C0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE412ECD14;
	Fri,  4 Jul 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jng1KGgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWKv8Yit"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C12EBDE5;
	Fri,  4 Jul 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620408; cv=none; b=m0csX6nsg7posPvQoJ8aasGnz2flYUY7W6Pr7AQ+f1k/S+vuPn+S3+zclE3cjXSatIZVBYa0ELyarLRhcYoxLKJQjDzadxQgj+hzSf+w+plfjHEs2aZtOvpf2CJ9XGYnvyT0EYJlp8QrGFOSzUjJRUvqmGK5CT1R5h6/RVJ3A6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620408; c=relaxed/simple;
	bh=5xS+v0+LHTSAfPzbnw4Stpz+tm1lZx1IDKEGtDX2yJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sykCZeFDJPZyi0x+iMqZuHnVlwBk6NqN7pHwM8OwX7BzAj6kJW7qMEuKJQ2CGScYmcxAii3UNuV9VYOJ9DCGhJWjp3kkjQnk7xOHapR+EU0uamkuWwUQeN9EVyNa5rSRHYrJOjnO4yE/vrI08kftq76TA7gG2saZg26x0nz4uI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jng1KGgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWKv8Yit; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Jul 2025 09:13:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751620397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcfjN5D2uvsDnh9VSFZmaiQcovdMoR4Mohq3CtPiKK0=;
	b=jng1KGgP5QjTmccLrcBSk/5GU7tJ7z+icADjPr6bexoH4zqbWervVsvTKUzVgcGVfF8Tyi
	qx1fvleLX7eR+zNrWC+amKHDfRDXfF+kpWbgbLJ56QzVku5gzwgzbwb7lPdEwC5MyDM0XZ
	Max58K9TXQ/2sClFBYd1aLhqsOASw6JswP4RkbUMmAdd9FZNM560v9RLOlEuNYH5jhiSE5
	MaOs0pmZe9yZXl+Ul7TzNd4y0XZNFdJQ52QL2xsUUOvnjBD2jh2ZSQsc2OVjoCLJSf1URJ
	h5I2CU4T/cbmU/KQB8/+EB0MhsVK4zGPkgITEE8FeXkKWUNq9ELzG52z43u59w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751620397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcfjN5D2uvsDnh9VSFZmaiQcovdMoR4Mohq3CtPiKK0=;
	b=fWKv8Yit6+YCy26INFGw/oQFWUR04FVcv4FgOtrQe1INAPyHJuoXWOHk3faxPUR95Va1HC
	3MzHJwocAqO6C5Bw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Cc: Leon Romanovsky <leon@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630061059.1547-1-kprateek.nayak@amd.com>
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     02bb4259ca525efa39a2531cb630329fb87fc968
Gitweb:        https://git.kernel.org/tip/02bb4259ca525efa39a2531cb630329fb87fc968
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 30 Jun 2025 06:10:59 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 04 Jul 2025 10:35:56 +02:00

sched/fair: Use sched_domain_span() for topology_span_sane()

Leon noted a topology_span_sane() warning in their guest deployment
starting from v6.16-rc1 [1]. Debug that followed pointed to the
tl->mask() for the NODE domain being incorrectly resolved to that of the
highest NUMA domain.

tl->mask() for NODE is set to the sd_numa_mask() which depends on the
global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
set to the "tl->numa_level" during tl traversal in build_sched_domains()
calling sd_init() but was not reset before topology_span_sane().

Since "tl->numa_level" still reflected the old value from
build_sched_domains(), topology_span_sane() for the NODE domain trips
when the span of the last NUMA domain overlaps.

Instead of replicating the "sched_domains_curr_level" hack, Valentin
suggested using the spans from the sched_domain objects constructed
during build_sched_domains() which can also catch overlaps when the
domain spans are fixed up by build_sched_domain().

The original warning was reproducble on the follwoing NUMA topology
reported by Leon:

    $ sudo numactl -H
    available: 5 nodes (0-4)
    node 0 cpus: 0 1
    node 0 size: 2927 MB
    node 0 free: 1603 MB
    node 1 cpus: 2 3
    node 1 size: 3023 MB
    node 1 free: 3008 MB
    node 2 cpus: 4 5
    node 2 size: 3023 MB
    node 2 free: 3007 MB
    node 3 cpus: 6 7
    node 3 size: 3023 MB
    node 3 free: 3002 MB
    node 4 cpus: 8 9
    node 4 size: 3022 MB
    node 4 free: 2718 MB
    node distances:
    node   0   1   2   3   4
      0:  10  39  38  37  36
      1:  39  10  38  37  36
      2:  38  38  10  37  36
      3:  37  37  37  10  36
      4:  36  36  36  36  10

The above topology can be mimicked using the following QEMU cmd that was
used to reproduce the warning and test the fix:

     sudo qemu-system-x86_64 -enable-kvm -cpu host \
     -m 20G -smp cpus=10,sockets=10 -machine q35 \
     -object memory-backend-ram,size=4G,id=m0 \
     -object memory-backend-ram,size=4G,id=m1 \
     -object memory-backend-ram,size=4G,id=m2 \
     -object memory-backend-ram,size=4G,id=m3 \
     -object memory-backend-ram,size=4G,id=m4 \
     -numa node,cpus=0-1,memdev=m0,nodeid=0 \
     -numa node,cpus=2-3,memdev=m1,nodeid=1 \
     -numa node,cpus=4-5,memdev=m2,nodeid=2 \
     -numa node,cpus=6-7,memdev=m3,nodeid=3 \
     -numa node,cpus=8-9,memdev=m4,nodeid=4 \
     -numa dist,src=0,dst=1,val=39 \
     -numa dist,src=0,dst=2,val=38 \
     -numa dist,src=0,dst=3,val=37 \
     -numa dist,src=0,dst=4,val=36 \
     -numa dist,src=1,dst=0,val=39 \
     -numa dist,src=1,dst=2,val=38 \
     -numa dist,src=1,dst=3,val=37 \
     -numa dist,src=1,dst=4,val=36 \
     -numa dist,src=2,dst=0,val=38 \
     -numa dist,src=2,dst=1,val=38 \
     -numa dist,src=2,dst=3,val=37 \
     -numa dist,src=2,dst=4,val=36 \
     -numa dist,src=3,dst=0,val=37 \
     -numa dist,src=3,dst=1,val=37 \
     -numa dist,src=3,dst=2,val=37 \
     -numa dist,src=3,dst=4,val=36 \
     -numa dist,src=4,dst=0,val=36 \
     -numa dist,src=4,dst=1,val=36 \
     -numa dist,src=4,dst=2,val=36 \
     -numa dist,src=4,dst=3,val=36 \
     ...

Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
Reported-by: Leon Romanovsky <leon@kernel.org>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20250630061059.1547-1-kprateek.nayak@amd.com
---
 kernel/sched/topology.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe4..0e46068 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2403,6 +2403,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
+		struct sd_data *sdd = &tl->data;
 
 		/* NUMA levels are allowed to overlap */
 		if (tl->flags & SDTL_OVERLAP)
@@ -2418,22 +2419,24 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
+			struct cpumask *sd_span = sched_domain_span(sd);
 			int id;
 
 			/* lowest bit set in this mask is used as a unique id */
-			id = cpumask_first(tl_cpu_mask);
+			id = cpumask_first(sd_span);
 
 			if (cpumask_test_cpu(id, id_seen)) {
-				/* First CPU has already been seen, ensure identical spans */
-				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+				/* First CPU has already been seen, ensure identical sd spans */
+				sd = *per_cpu_ptr(sdd->sd, id);
+				if (!cpumask_equal(sched_domain_span(sd), sd_span))
 					return false;
 			} else {
 				/* First CPU hasn't been seen before, ensure it's a completely new span */
-				if (cpumask_intersects(tl_cpu_mask, covered))
+				if (cpumask_intersects(sd_span, covered))
 					return false;
 
-				cpumask_or(covered, covered, tl_cpu_mask);
+				cpumask_or(covered, covered, sd_span);
 				cpumask_set_cpu(id, id_seen);
 			}
 		}

