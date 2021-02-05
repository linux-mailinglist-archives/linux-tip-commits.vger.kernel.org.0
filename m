Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68B311879
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Feb 2021 03:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBFCiy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 21:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhBFCfl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B8EC08ECB3;
        Fri,  5 Feb 2021 15:02:46 -0800 (PST)
Date:   Fri, 05 Feb 2021 23:02:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612566124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LOsQTwDP/ai7UXsadQ+J88AwnIFE80vqMo3/CzfP0k=;
        b=r+dZDM0H/Z5a7svUXVoAUmCMB/DvfYBc7CHX9JiyoNudDBr9WfXuAp1fd1QS6otO6n819X
        Lw3+GTBZf+59NJ9l23SVT67yBuzj59k64zfN9ao3tbBM65EvnZRG/ztPKs+gLP1/K3P13L
        EDMFfy0wy33W0Pjq4U5lcN8qZGv6jJ0g1e7+znKAY2cmMQYurrA0WUq35KWaHFObcLZd02
        Y1vUywEsMmkuaQfDUjCknMUC8u8N3Z8ZP/GGaFSFKxFzNqmMFkDOL0QIFQr5ZC0Mc9W8Pb
        4MH7xpZEWi/oHoucUbUW7yUHR2b488f1n/jchkO3+WVQYxLbQ/BRcpNEV4pelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612566124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LOsQTwDP/ai7UXsadQ+J88AwnIFE80vqMo3/CzfP0k=;
        b=CiSli1pMSWPurGrkRABIZcxegPwuI0ALwDOP963m3aAInIYIWNZQy2CnxCAeJ1XVIhzhM0
        6KI0VyF7/WwtGjAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] Revert "lib: Restrict cpumask_local_spread to
 houskeeping CPUs"
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com,
        davem@davemloft.net, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87y2g26tnt.fsf@nanos.tec.linutronix.de>
References: <87y2g26tnt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <161256612371.23325.1950977719055014944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2452483d9546de1c540f330469dc4042ff089731
Gitweb:        https://git.kernel.org/tip/2452483d9546de1c540f330469dc4042ff089731
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 05 Feb 2021 23:28:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Feb 2021 23:28:29 +01:00

Revert "lib: Restrict cpumask_local_spread to houskeeping CPUs"

This reverts commit 1abdfe706a579a702799fce465bceb9fb01d407c.

This change is broken and not solving any problem it claims to solve.

Robin reported that cpumask_local_spread() now returns any cpu out of
cpu_possible_mask in case that NOHZ_FULL is disabled (runtime or compile
time). It can also return any offline or not-present CPU in the
housekeeping mask. Before that it was returning a CPU out of
online_cpu_mask.

While the function is racy against CPU hotplug if the caller does not
protect against it, the actual use cases are not caring much about it as
they use it mostly as hint for:

 - the user space affinity hint which is unused by the kernel
 - memory node selection which is just suboptimal
 - network queue affinity which might fail but is handled gracefully

But the occasional fail vs. hotplug is very different from returning
anything from possible_cpu_mask which can have a large amount of offline
CPUs obviously.

The changelog of the commit claims:

 "The current implementation of cpumask_local_spread() does not respect
  the isolated CPUs, i.e., even if a CPU has been isolated for Real-Time
  task, it will return it to the caller for pinning of its IRQ
  threads. Having these unwanted IRQ threads on an isolated CPU adds up
  to a latency overhead."

The only correct part of this changelog is:

 "The current implementation of cpumask_local_spread() does not respect
  the isolated CPUs."

Everything else is just disjunct from reality.

Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: abelits@marvell.com
Cc: davem@davemloft.net
Link: https://lore.kernel.org/r/87y2g26tnt.fsf@nanos.tec.linutronix.de
---
 lib/cpumask.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 3592402..c3c76b8 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -6,7 +6,6 @@
 #include <linux/export.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
-#include <linux/sched/isolation.h>
 
 /**
  * cpumask_next - get the next cpu in a cpumask
@@ -206,27 +205,22 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-	int cpu, hk_flags;
-	const struct cpumask *mask;
+	int cpu;
 
-	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
-	mask = housekeeping_cpumask(hk_flags);
 	/* Wrap: we always want a cpu. */
-	i %= cpumask_weight(mask);
+	i %= num_online_cpus();
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, mask) {
+		for_each_cpu(cpu, cpu_online_mask)
 			if (i-- == 0)
 				return cpu;
-		}
 	} else {
 		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
+		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
 			if (i-- == 0)
 				return cpu;
-		}
 
-		for_each_cpu(cpu, mask) {
+		for_each_cpu(cpu, cpu_online_mask) {
 			/* Skip NUMA nodes, done above. */
 			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
 				continue;
