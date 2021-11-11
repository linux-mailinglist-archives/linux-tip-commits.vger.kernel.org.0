Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96944D68E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhKKMZT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49432 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKKMZS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:18 -0500
Date:   Thu, 11 Nov 2021 12:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93JjTXojAwar/DPQCFh8F6txySliOW1IQDkrWTe5p2s=;
        b=r3e1ObmrPuc8kxM9Zy/t+5PZ/G9sGlysal8VCXl6oxpmCmg8IYZwoIQnQAmwRBuRyE/ucU
        zi74Li2WE/1osdHvyTRUwYf7CwjcATh5Tm5A37YPtAPrwhbu22a51lP4U7rFb2NgykHBew
        imFbLODL7cEr4vWnMaXfyu1aYn1bY18kUvczWzXqcsDpjAuzPsLJwQrhKRUpG246aWjHpa
        lHfijH/kT/H2wrv9s5HTDhzKsxuQd0aqN6bVB8a9Ji3lcoPTTeVkIufGKhPpD0wW7tQB5u
        nv2cJL2RY/NDVAtltm/SoHEzkbVc3/kQik0ED+FIffKIJF4oYWc7ZckBlR4Tfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93JjTXojAwar/DPQCFh8F6txySliOW1IQDkrWTe5p2s=;
        b=uIGRH6YR7Mg795V5RhSw1StM6VkB/WsdyyW2Nzv+Ijy4VAD8x5bZvLtEU0ne9uDGtgcqzu
        yryVd0D+0Tcc9pBw==
From:   "tip-bot2 for Wang ShaoBo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] arch_topology: Fix missing clear cluster_cpumask
 in remove_cpu_topology()
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Message-ID: <163663334743.414.10124522817525306307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4cc4cc28ec4154c4f1395648ab67ac9fd3e71fdc
Gitweb:        https://git.kernel.org/tip/4cc4cc28ec4154c4f1395648ab67ac9fd3e71fdc
Author:        Wang ShaoBo <bobo.shaobowang@huawei.com>
AuthorDate:    Wed, 10 Nov 2021 17:58:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:33 +01:00

arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()

When testing cpu online and offline, warning happened like this:

[  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
[  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
[  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
[  146.751213] Workqueue: events cpuset_hotplug_workfn
[  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  146.752048] pc : build_sched_domains+0x81c/0x11b0
[  146.752461] lr : build_sched_domains+0x414/0x11b0
[  146.752860] sp : ffff800040a83a80
[  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
[  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
[  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
[  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
[  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
[  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
[  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
[  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
[  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
[  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
[  146.757070] Call trace:
[  146.757421]  build_sched_domains+0x81c/0x11b0
[  146.757771]  partition_sched_domains_locked+0x57c/0x978
[  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
[  146.758460]  rebuild_sched_domains+0x2c/0x48
[  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
[  146.759114]  process_one_work+0x1f4/0x480
[  146.759429]  worker_thread+0x48/0x460
[  146.759734]  kthread+0x158/0x168
[  146.760030]  ret_from_fork+0x10/0x20
[  146.760318] ---[ end trace 82c44aad6900e81a ]---

For some architectures like risc-v and arm64 which use common code
clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
is set, cluster_sibling in cpu_topology of each sibling adjacent
to CPUx is missed clearing, this causes checking failed in
topology_span_sane() and rebuilding topology failure at end when CPU online.

Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
(CPU 92, 93, 94, 95 are in one cluster):

Before revision:
CPU                 [92]      [93]      [94]      [95]
cluster_sibling     [92]     [92-95]   [92-95]   [92-95]

After revision:
CPU                 [92]      [93]      [94]      [95]
cluster_sibling     [92]     [93-95]   [93-95]   [93-95]

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Barry Song <song.bao.hua@hisilicon.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20211110095856.469360-1-bobo.shaobowang@huawei.com
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 981e72a..ff16a36 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -677,6 +677,8 @@ void remove_cpu_topology(unsigned int cpu)
 		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+	for_each_cpu(sibling, topology_cluster_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
 	for_each_cpu(sibling, topology_llc_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
 
