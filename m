Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E151844D7CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 15:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhKKOHj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 09:07:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26302 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhKKOHi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 09:07:38 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hqjyh02GCzbhtD;
        Thu, 11 Nov 2021 21:59:56 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 22:04:46 +0800
Received: from [10.174.177.123] (10.174.177.123) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 22:04:46 +0800
Subject: Re: [tip: sched/urgent] arch_topology: Fix missing clear
 cluster_cpumask in remove_cpu_topology()
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>, <x86@kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>
References: <20211110095856.469360-1-bobo.shaobowang@huawei.com>
 <163663334743.414.10124522817525306307.tip-bot2@tip-bot2>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <08ab122c-efbb-982a-ed9d-15e05f5bec0d@huawei.com>
Date:   Thu, 11 Nov 2021 22:04:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <163663334743.414.10124522817525306307.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.123]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Peter,

      I have sent v2 with adding Fixes flag and reproduce method,

      merging v2 version patch can be more appropriate.

      Thanks.

- Wang ShaoBo

在 2021/11/11 20:22, tip-bot2 for Wang ShaoBo 写道:
> The following commit has been merged into the sched/urgent branch of tip:
>
> Commit-ID:     4cc4cc28ec4154c4f1395648ab67ac9fd3e71fdc
> Gitweb:        https://git.kernel.org/tip/4cc4cc28ec4154c4f1395648ab67ac9fd3e71fdc
> Author:        Wang ShaoBo <bobo.shaobowang@huawei.com>
> AuthorDate:    Wed, 10 Nov 2021 17:58:56 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 11 Nov 2021 13:09:33 +01:00
>
> arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()
>
> When testing cpu online and offline, warning happened like this:
>
> [  146.746743] WARNING: CPU: 92 PID: 974 at kernel/sched/topology.c:2215 build_sched_domains+0x81c/0x11b0
> [  146.749988] CPU: 92 PID: 974 Comm: kworker/92:2 Not tainted 5.15.0 #9
> [  146.750402] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.79 08/21/2021
> [  146.751213] Workqueue: events cpuset_hotplug_workfn
> [  146.751629] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  146.752048] pc : build_sched_domains+0x81c/0x11b0
> [  146.752461] lr : build_sched_domains+0x414/0x11b0
> [  146.752860] sp : ffff800040a83a80
> [  146.753247] x29: ffff800040a83a80 x28: ffff20801f13a980 x27: ffff20800448ae00
> [  146.753644] x26: ffff800012a858e8 x25: ffff800012ea48c0 x24: 0000000000000000
> [  146.754039] x23: ffff800010ab7d60 x22: ffff800012f03758 x21: 000000000000005f
> [  146.754427] x20: 000000000000005c x19: ffff004080012840 x18: ffffffffffffffff
> [  146.754814] x17: 3661613030303230 x16: 30303078303a3239 x15: ffff800011f92b48
> [  146.755197] x14: ffff20be3f95cef6 x13: 2e6e69616d6f642d x12: 6465686373204c4c
> [  146.755578] x11: ffff20bf7fc83a00 x10: 0000000000000040 x9 : 0000000000000000
> [  146.755957] x8 : 0000000000000002 x7 : ffffffffe0000000 x6 : 0000000000000002
> [  146.756334] x5 : 0000000090000000 x4 : 00000000f0000000 x3 : 0000000000000001
> [  146.756705] x2 : 0000000000000080 x1 : ffff800012f03860 x0 : 0000000000000001
> [  146.757070] Call trace:
> [  146.757421]  build_sched_domains+0x81c/0x11b0
> [  146.757771]  partition_sched_domains_locked+0x57c/0x978
> [  146.758118]  rebuild_sched_domains_locked+0x44c/0x7f0
> [  146.758460]  rebuild_sched_domains+0x2c/0x48
> [  146.758791]  cpuset_hotplug_workfn+0x3fc/0x888
> [  146.759114]  process_one_work+0x1f4/0x480
> [  146.759429]  worker_thread+0x48/0x460
> [  146.759734]  kthread+0x158/0x168
> [  146.760030]  ret_from_fork+0x10/0x20
> [  146.760318] ---[ end trace 82c44aad6900e81a ]---
>
> For some architectures like risc-v and arm64 which use common code
> clear_cpu_topology() in shutting down CPUx, When CONFIG_SCHED_CLUSTER
> is set, cluster_sibling in cpu_topology of each sibling adjacent
> to CPUx is missed clearing, this causes checking failed in
> topology_span_sane() and rebuilding topology failure at end when CPU online.
>
> Different sibling's cluster_sibling in cpu_topology[] when CPU92 offline
> (CPU 92, 93, 94, 95 are in one cluster):
>
> Before revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [92-95]   [92-95]   [92-95]
>
> After revision:
> CPU                 [92]      [93]      [94]      [95]
> cluster_sibling     [92]     [93-95]   [93-95]   [93-95]
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Link: https://lore.kernel.org/r/20211110095856.469360-1-bobo.shaobowang@huawei.com
> ---
>   drivers/base/arch_topology.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 981e72a..ff16a36 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -677,6 +677,8 @@ void remove_cpu_topology(unsigned int cpu)
>   		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
>   	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
>   		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
> +	for_each_cpu(sibling, topology_cluster_cpumask(cpu))
> +		cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
>   	for_each_cpu(sibling, topology_llc_cpumask(cpu))
>   		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
>   
> .
