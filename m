Return-Path: <linux-tip-commits+bounces-3225-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AFFA11D3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8361D1617AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE13DABFE;
	Wed, 15 Jan 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phVg2gMI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGHulHQ7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21852361C0;
	Wed, 15 Jan 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932642; cv=none; b=AvdKZeaGyDhDbPmzGC+lh9QdwIxFz0Pu0Jgje+QES4FCWplLBGxXGp8pmUtszBv6FSHWS+1bVy6MbsJGFC80kxvcQEL8rjqlhIdFN797ByMEe1ZUYkYUZaa8yWp+at5rt8PIlIQXoAxssbP8RMtiTDKr1uslWJY2lj5LgsdIGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932642; c=relaxed/simple;
	bh=SH642xZImW7SpVHPYwDym+RHNG8umAq9n7/12AwRC6M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=brpG4wRSn2EGJ6Fzaq1uZqe0eHyTrhy8ieqfHn/PvU9uWp6F7tzkQWvdssLaXMKgUJgpujMc9xzYHSr0CarWJPScghqYGYcAVdmsTl6lfEOnaJtYVUjNUnB97pwo7CAbLsjziIUSnU69lQswpvvv3VYvzOxQ69t6gwEAdPwWli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=phVg2gMI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGHulHQ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kofgrsq3uVVy3klS/XxALrR9cpoRokvbDLHy0mOp5p4=;
	b=phVg2gMIQ5ImrXxKE5ba5wbsxLB23wXztYth2UrpuQWlzdvpj96Xfu40MBJV0/W5Rpubud
	lulxy/2SRN0jRt8NixyhxhKi1GRtZgfAyNprHIbvHA09oSL2dWXeo1yWvd0qsTAx0AnORR
	1lzuFQVDd9CNknzCmsPwBpzILZ1p1YVobc+dQcLJ+f89CVlOFZDc77H2pFX8Cky4qmjl8O
	iZrPPZUzEs3VfalomZTPkcKyPvHNyQ19AqUP+VvzF2YT/RHA82KhrsU2kaqCI8PlJsvKaD
	nlo1c/cKaddMT/IgGQqd0qYmXe3uqErn0ESWDRRItw0PN1Za4Equd4wh6u7l/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kofgrsq3uVVy3klS/XxALrR9cpoRokvbDLHy0mOp5p4=;
	b=ZGHulHQ7QFVewwQpS4lklYjHF+8+oBhbcC4G8QOH6kwc8zw5vxSkGjx3ge0KrFftPmnJ+p
	hJENJzLpnmjBpUDg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/topology: Use x86_sched_itmt_flags for PKG
 domain unconditionally
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-6-kprateek.nayak@amd.com>
References: <20241223043407.1611-6-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263603.31546.9929728705198865576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e1bc02646527fc1ed74f00eb599b2b74d49671c7
Gitweb:        https://git.kernel.org/tip/e1bc02646527fc1ed74f00eb599b2b74d49671c7
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:04 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:24 +01:00

x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally

x86_sched_itmt_flags() returns SD_ASYM_PACKING if ITMT support is
enabled by the system. Without ITMT support being enabled, it returns 0
similar to current x86_die_flags() on non-Hybrid systems
(!X86_HYBRID_CPU and !X86_FEATURE_AMD_HETEROGENEOUS_CORES)

On Intel systems that enable ITMT support, either the MC domain
coincides with the PKG domain, or in case of multiple MC groups
within a PKG domain, either Sub-NUMA Cluster (SNC) is enabled or the
processor features Hybrid core layout (X86_HYBRID_CPU) which leads to
three distinct possibilities:

o If PKG and MC domains coincide, PKG domain is degenerated by
  sd_parent_degenerate() when building sched domain topology.

o If SNC is enabled, PKG domain is never added since
  "x86_has_numa_in_package" is set and the topology will instead contain
  NODE and NUMA domains.

o On X86_HYBRID_CPU which contains multiple MC groups within the PKG,
  the PKG domain requires x86_sched_itmt_flags().

Thus, on Intel systems that contains multiple MC groups within the PKG
and enables ITMT support, the PKG domain requires
x86_sched_itmt_flags(). In all other cases PKG domain is either never
added or is degenerated. Thus, returning x86_sched_itmt_flags()
unconditionally at PKG domain on Intel systems should not lead to any
functional changes.

On AMD systems with multiple LLCs (MC groups) within a PKG domain,
enabling ITMT support requires setting SD_ASYM_PACKING to the PKG domain
since the core rankings are assigned PKG-wide.

Core rankings on AMD processors is currently set by the amd-pstate
driver when Preferred Core feature is supported. A subset of systems that
support Preferred Core feature can be detected using
X86_FEATURE_AMD_HETEROGENEOUS_CORES however, this does not cover all the
systems that support Preferred Core ranking.

Detecting Preferred Core support on AMD systems requires inspecting CPPC
Highest Perf on all present CPUs and checking if it differs on at least
one CPU. Previous suggestion to use a synthetic feature to detect
Preferred Core support [1] was found to be non-trivial to implement
since BSP alone cannot detect if Preferred Core is supported and by the
time AP comes up, alternatives are patched and setting a X86_FEATURE_*
then is not possible.

Since x86 processors enabling ITMT support that consists multiple
non-NUMA MC groups within a PKG requires SD_ASYM_PACKING flag set at the
PKG domain, return x86_sched_itmt_flags unconditionally for the PKG
domain.

Since x86_die_flags() would have just returned x86_sched_itmt_flags()
after the change, remove the unnecessary wrapper and pass
x86_sched_itmt_flags() directly as the flags function.

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241223043407.1611-6-kprateek.nayak@amd.com
---
 arch/x86/kernel/smpboot.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6e30089..ef63b1c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -489,15 +489,6 @@ static int x86_cluster_flags(void)
 }
 #endif
 
-static int x86_die_flags(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
-	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
-		return x86_sched_itmt_flags();
-
-	return 0;
-}
-
 /*
  * Set if a package/die has multiple NUMA nodes inside.
  * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
@@ -533,7 +524,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(PKG)
+			cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(PKG)
 		};
 	}
 

