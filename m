Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D090343F896
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhJ2IMH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:12:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhJ2IMH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:12:07 -0400
Date:   Fri, 29 Oct 2021 08:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx39K8rNJl8V4POPKV1lScHaGXhlx70GURe5GaV+m68=;
        b=y5kmjNdUhkN8PHXQwuWEoubsoRAHu5as1KMGgPOo9aDUcrc5ECl7UATfvRzB8hzVLqq4ho
        F5KO6fWYeqVm0gb6OzyUARN2CxQu6qe0UAOntYmw7C+i0JCvTZmb/NSHlHEn29koIrSU3P
        fsOQeNdxDCd80WTNLWuJE7h8aLxBMzoxEXNZG3gNLjEbz9G7/4+ZCDcsj4O+qcjMWBa072
        Q/GlXqYST1mV7pmZxpdPO21wynfK3OKjryjjbJNZSWKAnrDTk2fREjl9YExh2qf6JTfc1u
        KBJdqZbDnTezINIAc+9I0ZXU7O6p7ohnb8TNm3FLcJhTyfE1ejpXZlSsvuC6Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xx39K8rNJl8V4POPKV1lScHaGXhlx70GURe5GaV+m68=;
        b=0JPUNd8SvjAykuX1NDm9t3KM85K+htps2oBn9G1wqqnz/32Ji8vER+rDa2cmR/CwVcRfE4
        qNEhUV3M0ITXbKBA==
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Reduce cache line misses in
 __x2apic_send_IPI_mask()
Cc:     Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211007143556.574911-1-eric.dumazet@gmail.com>
References: <20211007143556.574911-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Message-ID: <163549497726.626.15251847744417014026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     cc95a07fef06a2c7917acd827b3a8322772969eb
Gitweb:        https://git.kernel.org/tip/cc95a07fef06a2c7917acd827b3a8322772969eb
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 07 Oct 2021 07:35:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Oct 2021 10:02:17 +02:00

x86/apic: Reduce cache line misses in __x2apic_send_IPI_mask()

Using per-cpu storage for @x86_cpu_to_logical_apicid is not optimal.

Broadcast IPI will need at least one cache line per cpu to access this
field.

__x2apic_send_IPI_mask() is using standard bitmask operators.

By converting x86_cpu_to_logical_apicid to an array, we divide by 16x
number of needed cache lines, because we find 16 values per cache
line. CPU prefetcher can kick nicely.

Also move @cluster_masks to READ_MOSTLY section to avoid false sharing.

Tested on a dual socket host with 256 cpus, cost for a full broadcast
is now 11 usec instead of 33 usec.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211007143556.574911-1-eric.dumazet@gmail.com
---
 arch/x86/kernel/apic/x2apic_cluster.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index f4da9bb..e696e22 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -15,9 +15,15 @@ struct cluster_mask {
 	struct cpumask	mask;
 };
 
-static DEFINE_PER_CPU(u32, x86_cpu_to_logical_apicid);
+/*
+ * __x2apic_send_IPI_mask() possibly needs to read
+ * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
+ * Using per cpu variable would cost one cache line per cpu.
+ */
+static u32 *x86_cpu_to_logical_apicid __read_mostly;
+
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
-static DEFINE_PER_CPU(struct cluster_mask *, cluster_masks);
+static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;
 
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
@@ -27,7 +33,7 @@ static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 static void x2apic_send_IPI(int cpu, int vector)
 {
-	u32 dest = per_cpu(x86_cpu_to_logical_apicid, cpu);
+	u32 dest = x86_cpu_to_logical_apicid[cpu];
 
 	/* x2apic MSRs are special and need a special fence: */
 	weak_wrmsr_fence();
@@ -58,7 +64,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 
 		dest = 0;
 		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
-			dest |= per_cpu(x86_cpu_to_logical_apicid, clustercpu);
+			dest |= x86_cpu_to_logical_apicid[clustercpu];
 
 		if (!dest)
 			continue;
@@ -94,7 +100,7 @@ static void x2apic_send_IPI_all(int vector)
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
-	return per_cpu(x86_cpu_to_logical_apicid, cpu);
+	return x86_cpu_to_logical_apicid[cpu];
 }
 
 static void init_x2apic_ldr(void)
@@ -103,7 +109,7 @@ static void init_x2apic_ldr(void)
 	u32 cluster, apicid = apic_read(APIC_LDR);
 	unsigned int cpu;
 
-	this_cpu_write(x86_cpu_to_logical_apicid, apicid);
+	x86_cpu_to_logical_apicid[smp_processor_id()] = apicid;
 
 	if (cmsk)
 		goto update;
@@ -166,12 +172,21 @@ static int x2apic_dead_cpu(unsigned int dead_cpu)
 
 static int x2apic_cluster_probe(void)
 {
+	u32 slots;
+
 	if (!x2apic_mode)
 		return 0;
 
+	slots = max_t(u32, L1_CACHE_BYTES/sizeof(u32), nr_cpu_ids);
+	x86_cpu_to_logical_apicid = kcalloc(slots, sizeof(u32), GFP_KERNEL);
+	if (!x86_cpu_to_logical_apicid)
+		return 0;
+
 	if (cpuhp_setup_state(CPUHP_X2APIC_PREPARE, "x86/x2apic:prepare",
 			      x2apic_prepare_cpu, x2apic_dead_cpu) < 0) {
 		pr_err("Failed to register X2APIC_PREPARE\n");
+		kfree(x86_cpu_to_logical_apicid);
+		x86_cpu_to_logical_apicid = NULL;
 		return 0;
 	}
 	init_x2apic_ldr();
