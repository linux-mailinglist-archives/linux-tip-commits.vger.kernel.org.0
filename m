Return-Path: <linux-tip-commits+bounces-2911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE09DFFF6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726A7162C3D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183E2036FD;
	Mon,  2 Dec 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyhyTI7w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9/JLB2no"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEC20103D;
	Mon,  2 Dec 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138062; cv=none; b=dvYxpKmUPUU2ihxBj8mFUj6HsA5Ey+h1XEhpY4rZVRrXAeMd6BDYezn1iEwBOU7EVKaGlcl0DqJRf5pwmJOvgOZJw1AkMLfZAwnrx40G0wQIrylUPuPYvgqVKVWCYVx7zIdl8uHg/YvX7/EVhD9l4NlWW8hm/x6rHDkBxFvdVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138062; c=relaxed/simple;
	bh=O5vaUCD0R7QHdzss/DFOQEmpckAtNuTS8fLe4beqpiE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VrZeTrcwlBlaIFIzfRI9Lf+07DWnI9kWe0eWvM6wwjNqiZBPVOXVcv54zoHbKAF/SrsMKKbQjIIOYF6Zecc5ZYan0rSQ6xP/ynFDaYJBcLT6/HsJcsAoQ8opiSUsZVinlznY2KtT+SD06780XGHM5Dr2r8iNmvlZ5X55gmVdZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IyhyTI7w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9/JLB2no; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0jw6uMwJDNNUDgw5ni8gpVQ4eon7jt4wpKLI29eZu4=;
	b=IyhyTI7wUwuUeKb3afA/nDcXUtIUn66i4wvmj0Ho0McL3ajKjr/D1wGMBXffvBF/re09Pp
	bZIo+fKZG4/RZClT/mYE8OcJTlARxMCO2ekMQObs3fmZz9+b2mWCGSyKPoeltNftWtE86H
	bVLzVuDInN6/fQ1otvVMeBNsMYnKMAzEySOekBIHWddVqxtT9eFGUIapG89Qi4YSo+Ian8
	e/g8UeANaYx4bprsAaojxPOhmOaPE+gY9E58EvYp6lT63XYgZBeOKemcE9hHtYAn/aQNmQ
	JPrDqVrepxIVicyZSo4/Zc2Y7IN6VBxyDt5Of8mRdQkwq2LSeOW/mmhtH2V6KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0jw6uMwJDNNUDgw5ni8gpVQ4eon7jt4wpKLI29eZu4=;
	b=9/JLB2noj/+ef2swmNwo44lgTDW+i0XpA+8F27+klSdI+YinSPzzXiTQXKKGv0ttvvJf45
	TWJSdjsWn2pHxSDQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/topology: Introduce topology_logical_core_id()
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-3-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-3-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805852.412.8999350746579137537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e4b444347795a1ecc083895582bc2e7f288a22e4
Gitweb:        https://git.kernel.org/tip/e4b444347795a1ecc083895582bc2e7f288a22e4
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:07:58 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:35 +01:00

x86/topology: Introduce topology_logical_core_id()

On x86, topology_core_id() returns a unique core ID within the PKG
domain. Looking at match_smt() suggests that a core ID just needs to be
unique within a LLC domain. For use cases such as the core RAPL PMU,
there exists a need for a unique core ID across the entire system with
multiple PKG domains. Introduce topology_logical_core_id() to derive a
unique core ID across the system.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Link: https://lore.kernel.org/r/20241115060805.447565-3-Dhananjay.Ugwekar@amd.com
---
 Documentation/arch/x86/topology.rst   | 4 ++++
 arch/x86/include/asm/processor.h      | 1 +
 arch/x86/include/asm/topology.h       | 1 +
 arch/x86/kernel/cpu/debugfs.c         | 1 +
 arch/x86/kernel/cpu/topology_common.c | 1 +
 5 files changed, 8 insertions(+)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 7352ab8..c12837e 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -135,6 +135,10 @@ Thread-related topology information in the kernel:
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
     "core_id."
 
+  - topology_logical_core_id();
+
+    The logical core ID to which a thread belongs.
+
 
 
 System topology examples
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c097581..cfd8a55 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -98,6 +98,7 @@ struct cpuinfo_topology {
 	// Logical ID mappings
 	u32			logical_pkg_id;
 	u32			logical_die_id;
+	u32			logical_core_id;
 
 	// AMD Node ID and Nodes per Package info
 	u32			amd_node_id;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index fd41103..3973cb9 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -143,6 +143,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
+#define topology_logical_core_id(cpu)		(cpu_data(cpu).topo.logical_core_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 10719ab..cacfd3f 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -25,6 +25,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "cpu_type:            %s\n", get_topology_cpu_type_name(c));
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "logical_core_id:     %u\n", c->topo.logical_core_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 8277c64..b5a5e14 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -185,6 +185,7 @@ static void topo_set_ids(struct topo_scan *tscan, bool early)
 	if (!early) {
 		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
 		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+		c->topo.logical_core_id = topology_get_logical_id(apicid, TOPO_CORE_DOMAIN);
 	}
 
 	/* Package relative core ID */

