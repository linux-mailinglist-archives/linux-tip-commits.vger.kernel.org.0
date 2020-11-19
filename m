Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE83C2B910B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKSL3m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 06:29:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKSL3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 06:29:39 -0500
Date:   Thu, 19 Nov 2020 11:29:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605785376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8YXdnP+Nmj3s3U+MNRMdf+nz08Xzm1J5VBMWifNZzE=;
        b=T44NX0C+BiMgPsyiKyif9WesJ1RJ1qaBLGWj7Dn6wEReTNvnNlS5IZTxFuI+Q8ld61NzhL
        cUCKhWFhXZvUtGDSmrq6kodbfsvkctIZjjhK/r4sytZOTNUZv2FC/Ym363wUTXSqueKJ5K
        djF/x+Y/EXxsfiQqpWFUsq89m4JJseJcAzHObqzvmACZ5GC1+QNruhdb0KVmiuxu6Rp8la
        aqjFB6OWfGK9nBPrFrPNbDeN/MLjxSJlKRbf5DR+Km5C9bEKgySkXBi1RH9BiDrrHgFWc/
        ZomMOCKxz5lxzBQm3s/bqunq23JdS3HNQ2p6Fn145LRnHeyEycNLj1/8WbnrJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605785376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8YXdnP+Nmj3s3U+MNRMdf+nz08Xzm1J5VBMWifNZzE=;
        b=caKfdEkrtCWyoyFRWnQCa7pmH2ih0QoATkeIaxNg7M7V/vjpd0XJYaffg7iHVFp/rPEboA
        KOGf9FwQkxV54vBg==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Save AMD NodeId as cpu_die_id
Cc:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109210659.754018-2-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <160578537513.11244.11279002116385896537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     028c221ed1904af9ac3c5162ee98f48966de6b3d
Gitweb:        https://git.kernel.org/tip/028c221ed1904af9ac3c5162ee98f48966de6b3d
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 09 Nov 2020 21:06:56 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 11:43:13 +01:00

x86/CPU/AMD: Save AMD NodeId as cpu_die_id

AMD systems provide a "NodeId" value that represents a global ID
indicating to which "Node" a logical CPU belongs. The "Node" is a
physical structure equivalent to a Die, and it should not be confused
with logical structures like NUMA nodes. Logical nodes can be adjusted
based on firmware or other settings whereas the physical nodes/dies are
fixed based on hardware topology.

The NodeId value can be used when a physical ID is needed by software.

Save the AMD NodeId to struct cpuinfo_x86.cpu_die_id. Use the value
from CPUID or MSR as appropriate. Default to phys_proc_id otherwise.
Do so for both AMD and Hygon systems.

Drop the node_id parameter from cacheinfo_*_init_llc_id() as it is no
longer needed.

Update the x86 topology documentation.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201109210659.754018-2-Yazen.Ghannam@amd.com
---
 Documentation/x86/topology.rst   |  9 +++++++++
 arch/x86/include/asm/cacheinfo.h |  4 ++--
 arch/x86/kernel/cpu/amd.c        | 11 +++++------
 arch/x86/kernel/cpu/cacheinfo.c  |  6 +++---
 arch/x86/kernel/cpu/hygon.c      | 11 +++++------
 5 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index e297399..7f58010 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -41,6 +41,8 @@ Package
 Packages contain a number of cores plus shared resources, e.g. DRAM
 controller, shared caches etc.
 
+Modern systems may also use the term 'Die' for package.
+
 AMD nomenclature for package is 'Node'.
 
 Package-related topology information in the kernel:
@@ -53,11 +55,18 @@ Package-related topology information in the kernel:
 
     The number of dies in a package. This information is retrieved via CPUID.
 
+  - cpuinfo_x86.cpu_die_id:
+
+    The physical ID of the die. This information is retrieved via CPUID.
+
   - cpuinfo_x86.phys_proc_id:
 
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
 
+    Modern systems use this value for the socket. There may be multiple
+    packages within a socket. This value may differ from cpu_die_id.
+
   - cpuinfo_x86.logical_proc_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b63c7..86b2e0d 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_CACHEINFO_H
 #define _ASM_X86_CACHEINFO_H
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 6062ce5..2f1fbd8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -330,7 +330,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -340,7 +339,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->cpu_die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -360,15 +359,15 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c, cpu, node_id);
+		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->cpu_die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else
 		return;
 
@@ -393,7 +392,7 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
 
 static void amd_detect_ppin(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 57074cf..f9ac682 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -646,7 +646,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -657,7 +657,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
@@ -684,7 +684,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	}
 }
 
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ac6c30e..dc0840a 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -65,7 +65,6 @@ static void hygon_get_topology_early(struct cpuinfo_x86 *c)
  */
 static void hygon_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -75,7 +74,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->cpu_die_id  = ecx & 0xff;
 
 		c->cpu_core_id = ebx & 0xff;
 
@@ -93,14 +92,14 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		/* Socket ID is ApicId[6] for these processors. */
 		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
-		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
+		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->cpu_die_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->cpu_die_id;
 	} else
 		return;
 
@@ -123,7 +122,7 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->cpu_die_id = c->phys_proc_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
