Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6232F9FA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCFLmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCFLmW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98310C061761;
        Sat,  6 Mar 2021 03:42:21 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dCIV3RARPTB2Ddls/K9NIfxTeofA4MH5caUqqCjyoc=;
        b=k0f9qWJLBfOYfiR1EdvTufXkPkafppTzGFo451EN20LwioqP/6Z+3kjDFA32ykq9xUiomG
        yRsDGDewDx/hamKQT4iwGOrHDiHcaeigoHlydk3BFY2WY+uozxdcTOF4YRZzp0fF676+K/
        9zbJmTjsKfvTCmBfRWHRuHqUqJ7k7nlLsDs5EReF3Rqu8DyVIEGl1mBJbc8jhNF+MTRw3i
        GNkZt6AJdQy0VfSd6WSAVgKvOBXo5DqA6IXCRefRWTnq7/2hHtfumGlFHj+2eIlj3XOByB
        vk4j7MghhjyRKlI7bFz1FlO3Mmfb2jZVA6m9yLYJyPdqcWfLH7dxFmkAGRtguw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dCIV3RARPTB2Ddls/K9NIfxTeofA4MH5caUqqCjyoc=;
        b=QfUtD1/CRe/NQ6f/ajCe5gVIGN14tb571y1IQFTtpEiQxDNiUY6sfcEW4EAZFa/m0NaZ48
        mnZyZ3vTU68x49Bg==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Meelis Roos <mroos@linux.ee>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210224030944.15232-1-song.bao.hua@hisilicon.com>
References: <20210224030944.15232-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161503093960.398.9740112381530449552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     585b6d2723dc927ebc4ad884c4e879e4da8bc21f
Gitweb:        https://git.kernel.org/tip/585b6d2723dc927ebc4ad884c4e879e4da8bc21f
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Wed, 24 Feb 2021 16:09:44 +13:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2

As long as NUMA diameter > 2, building sched_domain by sibling's child
domain will definitely create a sched_domain with sched_group which will
span out of the sched_domain:

               +------+         +------+        +-------+       +------+
               | node |  12     |node  | 20     | node  |  12   |node  |
               |  0   +---------+1     +--------+ 2     +-------+3     |
               +------+         +------+        +-------+       +------+

domain0        node0            node1            node2          node3

domain1        node0+1          node0+1          node2+3        node2+3
                                                 +
domain2        node0+1+2                         |
             group: node0+1                      |
               group:node2+3 <-------------------+

when node2 is added into the domain2 of node0, kernel is using the child
domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
the span of the domain including node0+1+2.

This will make load_balance() run based on screwed avg_load and group_type
in the sched_group spanning out of the sched_domain, and it also makes
select_task_rq_fair() pick an idle CPU outside the sched_domain.

Real servers which suffer from this problem include Kunpeng920 and 8-node
Sun Fire X4600-M2, at least.

Here we move to use the *child* domain of the *child* domain of node2's
domain2 as the new added sched_group. At the same, we re-use the lower
level sgc directly.
               +------+         +------+        +-------+       +------+
               | node |  12     |node  | 20     | node  |  12   |node  |
               |  0   +---------+1     +--------+ 2     +-------+3     |
               +------+         +------+        +-------+       +------+

domain0        node0            node1          +- node2          node3
                                               |
domain1        node0+1          node0+1        | node2+3        node2+3
                                               |
domain2        node0+1+2                       |
             group: node0+1                    |
               group:node2 <-------------------+

While the lower level sgc is re-used, this patch only changes the remote
sched_groups for those sched_domains playing grandchild trick, therefore,
sgc->next_update is still safe since it's only touched by CPUs that have
the group span as local group. And sgc->imbalance is also safe because
sd_parent remains the same in load_balance and LB only tries other CPUs
from the local group.
Moreover, since local groups are not touched, they are still getting
roughly equal size in a TL. And should_we_balance() only matters with
local groups, so the pull probability of those groups are still roughly
equal.

Tested by the below topology:
qemu-system-aarch64  -M virt -nographic \
 -smp cpus=8 \
 -numa node,cpus=0-1,nodeid=0 \
 -numa node,cpus=2-3,nodeid=1 \
 -numa node,cpus=4-5,nodeid=2 \
 -numa node,cpus=6-7,nodeid=3 \
 -numa dist,src=0,dst=1,val=12 \
 -numa dist,src=0,dst=2,val=20 \
 -numa dist,src=0,dst=3,val=22 \
 -numa dist,src=1,dst=2,val=22 \
 -numa dist,src=2,dst=3,val=12 \
 -numa dist,src=1,dst=3,val=24 \
 -m 4G -cpu cortex-a57 -kernel arch/arm64/boot/Image

w/o patch, we get lots of "groups don't span domain->span":
[    0.802139] CPU0 attaching sched-domain(s):
[    0.802193]  domain-0: span=0-1 level=MC
[    0.802443]   groups: 0:{ span=0 cap=1013 }, 1:{ span=1 cap=979 }
[    0.802693]   domain-1: span=0-3 level=NUMA
[    0.802731]    groups: 0:{ span=0-1 cap=1992 }, 2:{ span=2-3 cap=1943 }
[    0.802811]    domain-2: span=0-5 level=NUMA
[    0.802829]     groups: 0:{ span=0-3 cap=3935 }, 4:{ span=4-7 cap=3937 }
[    0.802881] ERROR: groups don't span domain->span
[    0.803058]     domain-3: span=0-7 level=NUMA
[    0.803080]      groups: 0:{ span=0-5 mask=0-1 cap=5843 }, 6:{ span=4-7 mask=6-7 cap=4077 }
[    0.804055] CPU1 attaching sched-domain(s):
[    0.804072]  domain-0: span=0-1 level=MC
[    0.804096]   groups: 1:{ span=1 cap=979 }, 0:{ span=0 cap=1013 }
[    0.804152]   domain-1: span=0-3 level=NUMA
[    0.804170]    groups: 0:{ span=0-1 cap=1992 }, 2:{ span=2-3 cap=1943 }
[    0.804219]    domain-2: span=0-5 level=NUMA
[    0.804236]     groups: 0:{ span=0-3 cap=3935 }, 4:{ span=4-7 cap=3937 }
[    0.804302] ERROR: groups don't span domain->span
[    0.804520]     domain-3: span=0-7 level=NUMA
[    0.804546]      groups: 0:{ span=0-5 mask=0-1 cap=5843 }, 6:{ span=4-7 mask=6-7 cap=4077 }
[    0.804677] CPU2 attaching sched-domain(s):
[    0.804687]  domain-0: span=2-3 level=MC
[    0.804705]   groups: 2:{ span=2 cap=934 }, 3:{ span=3 cap=1009 }
[    0.804754]   domain-1: span=0-3 level=NUMA
[    0.804772]    groups: 2:{ span=2-3 cap=1943 }, 0:{ span=0-1 cap=1992 }
[    0.804820]    domain-2: span=0-5 level=NUMA
[    0.804836]     groups: 2:{ span=0-3 mask=2-3 cap=3991 }, 4:{ span=0-1,4-7 mask=4-5 cap=5985 }
[    0.804944] ERROR: groups don't span domain->span
[    0.805108]     domain-3: span=0-7 level=NUMA
[    0.805134]      groups: 2:{ span=0-5 mask=2-3 cap=5899 }, 6:{ span=0-1,4-7 mask=6-7 cap=6125 }
[    0.805223] CPU3 attaching sched-domain(s):
[    0.805232]  domain-0: span=2-3 level=MC
[    0.805249]   groups: 3:{ span=3 cap=1009 }, 2:{ span=2 cap=934 }
[    0.805319]   domain-1: span=0-3 level=NUMA
[    0.805336]    groups: 2:{ span=2-3 cap=1943 }, 0:{ span=0-1 cap=1992 }
[    0.805383]    domain-2: span=0-5 level=NUMA
[    0.805399]     groups: 2:{ span=0-3 mask=2-3 cap=3991 }, 4:{ span=0-1,4-7 mask=4-5 cap=5985 }
[    0.805458] ERROR: groups don't span domain->span
[    0.805605]     domain-3: span=0-7 level=NUMA
[    0.805626]      groups: 2:{ span=0-5 mask=2-3 cap=5899 }, 6:{ span=0-1,4-7 mask=6-7 cap=6125 }
[    0.805712] CPU4 attaching sched-domain(s):
[    0.805721]  domain-0: span=4-5 level=MC
[    0.805738]   groups: 4:{ span=4 cap=984 }, 5:{ span=5 cap=924 }
[    0.805787]   domain-1: span=4-7 level=NUMA
[    0.805803]    groups: 4:{ span=4-5 cap=1908 }, 6:{ span=6-7 cap=2029 }
[    0.805851]    domain-2: span=0-1,4-7 level=NUMA
[    0.805867]     groups: 4:{ span=4-7 cap=3937 }, 0:{ span=0-3 cap=3935 }
[    0.805915] ERROR: groups don't span domain->span
[    0.806108]     domain-3: span=0-7 level=NUMA
[    0.806130]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=5985 }, 2:{ span=0-3 mask=2-3 cap=3991 }
[    0.806214] CPU5 attaching sched-domain(s):
[    0.806222]  domain-0: span=4-5 level=MC
[    0.806240]   groups: 5:{ span=5 cap=924 }, 4:{ span=4 cap=984 }
[    0.806841]   domain-1: span=4-7 level=NUMA
[    0.806866]    groups: 4:{ span=4-5 cap=1908 }, 6:{ span=6-7 cap=2029 }
[    0.806934]    domain-2: span=0-1,4-7 level=NUMA
[    0.806953]     groups: 4:{ span=4-7 cap=3937 }, 0:{ span=0-3 cap=3935 }
[    0.807004] ERROR: groups don't span domain->span
[    0.807312]     domain-3: span=0-7 level=NUMA
[    0.807386]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=5985 }, 2:{ span=0-3 mask=2-3 cap=3991 }
[    0.807686] CPU6 attaching sched-domain(s):
[    0.807710]  domain-0: span=6-7 level=MC
[    0.807750]   groups: 6:{ span=6 cap=1017 }, 7:{ span=7 cap=1012 }
[    0.807840]   domain-1: span=4-7 level=NUMA
[    0.807870]    groups: 6:{ span=6-7 cap=2029 }, 4:{ span=4-5 cap=1908 }
[    0.807952]    domain-2: span=0-1,4-7 level=NUMA
[    0.807985]     groups: 6:{ span=4-7 mask=6-7 cap=4077 }, 0:{ span=0-5 mask=0-1 cap=5843 }
[    0.808045] ERROR: groups don't span domain->span
[    0.808257]     domain-3: span=0-7 level=NUMA
[    0.808571]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6125 }, 2:{ span=0-5 mask=2-3 cap=5899 }
[    0.808848] CPU7 attaching sched-domain(s):
[    0.808860]  domain-0: span=6-7 level=MC
[    0.808880]   groups: 7:{ span=7 cap=1012 }, 6:{ span=6 cap=1017 }
[    0.808953]   domain-1: span=4-7 level=NUMA
[    0.808974]    groups: 6:{ span=6-7 cap=2029 }, 4:{ span=4-5 cap=1908 }
[    0.809034]    domain-2: span=0-1,4-7 level=NUMA
[    0.809055]     groups: 6:{ span=4-7 mask=6-7 cap=4077 }, 0:{ span=0-5 mask=0-1 cap=5843 }
[    0.809128] ERROR: groups don't span domain->span
[    0.810361]     domain-3: span=0-7 level=NUMA
[    0.810400]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=5961 }, 2:{ span=0-5 mask=2-3 cap=5903 }

w/ patch, we don't get "groups don't span domain->span" any more:
[    1.486271] CPU0 attaching sched-domain(s):
[    1.486820]  domain-0: span=0-1 level=MC
[    1.500924]   groups: 0:{ span=0 cap=980 }, 1:{ span=1 cap=994 }
[    1.515717]   domain-1: span=0-3 level=NUMA
[    1.515903]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
[    1.516989]    domain-2: span=0-5 level=NUMA
[    1.517124]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }
[    1.517369]     domain-3: span=0-7 level=NUMA
[    1.517423]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7 mask=6-7 cap=4054 }
[    1.520027] CPU1 attaching sched-domain(s):
[    1.520097]  domain-0: span=0-1 level=MC
[    1.520184]   groups: 1:{ span=1 cap=994 }, 0:{ span=0 cap=980 }
[    1.520429]   domain-1: span=0-3 level=NUMA
[    1.520487]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
[    1.520687]    domain-2: span=0-5 level=NUMA
[    1.520744]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }
[    1.520948]     domain-3: span=0-7 level=NUMA
[    1.521038]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7 mask=6-7 cap=4054 }
[    1.522068] CPU2 attaching sched-domain(s):
[    1.522348]  domain-0: span=2-3 level=MC
[    1.522606]   groups: 2:{ span=2 cap=1003 }, 3:{ span=3 cap=986 }
[    1.522832]   domain-1: span=0-3 level=NUMA
[    1.522885]    groups: 2:{ span=2-3 cap=1989 }, 0:{ span=0-1 cap=1974 }
[    1.523043]    domain-2: span=0-5 level=NUMA
[    1.523092]     groups: 2:{ span=0-3 mask=2-3 cap=4037 }, 4:{ span=4-5 cap=1949 }
[    1.523302]     domain-3: span=0-7 level=NUMA
[    1.523352]      groups: 2:{ span=0-5 mask=2-3 cap=5986 }, 6:{ span=0-1,4-7 mask=6-7 cap=6102 }
[    1.523748] CPU3 attaching sched-domain(s):
[    1.523774]  domain-0: span=2-3 level=MC
[    1.523825]   groups: 3:{ span=3 cap=986 }, 2:{ span=2 cap=1003 }
[    1.524009]   domain-1: span=0-3 level=NUMA
[    1.524086]    groups: 2:{ span=2-3 cap=1989 }, 0:{ span=0-1 cap=1974 }
[    1.524281]    domain-2: span=0-5 level=NUMA
[    1.524331]     groups: 2:{ span=0-3 mask=2-3 cap=4037 }, 4:{ span=4-5 cap=1949 }
[    1.524534]     domain-3: span=0-7 level=NUMA
[    1.524586]      groups: 2:{ span=0-5 mask=2-3 cap=5986 }, 6:{ span=0-1,4-7 mask=6-7 cap=6102 }
[    1.524847] CPU4 attaching sched-domain(s):
[    1.524873]  domain-0: span=4-5 level=MC
[    1.524954]   groups: 4:{ span=4 cap=958 }, 5:{ span=5 cap=991 }
[    1.525105]   domain-1: span=4-7 level=NUMA
[    1.525153]    groups: 4:{ span=4-5 cap=1949 }, 6:{ span=6-7 cap=2006 }
[    1.525368]    domain-2: span=0-1,4-7 level=NUMA
[    1.525428]     groups: 4:{ span=4-7 cap=3955 }, 0:{ span=0-1 cap=1974 }
[    1.532726]     domain-3: span=0-7 level=NUMA
[    1.532811]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=6003 }, 2:{ span=0-3 mask=2-3 cap=4037 }
[    1.534125] CPU5 attaching sched-domain(s):
[    1.534159]  domain-0: span=4-5 level=MC
[    1.534303]   groups: 5:{ span=5 cap=991 }, 4:{ span=4 cap=958 }
[    1.534490]   domain-1: span=4-7 level=NUMA
[    1.534572]    groups: 4:{ span=4-5 cap=1949 }, 6:{ span=6-7 cap=2006 }
[    1.534734]    domain-2: span=0-1,4-7 level=NUMA
[    1.534783]     groups: 4:{ span=4-7 cap=3955 }, 0:{ span=0-1 cap=1974 }
[    1.536057]     domain-3: span=0-7 level=NUMA
[    1.536430]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=6003 }, 2:{ span=0-3 mask=2-3 cap=3896 }
[    1.536815] CPU6 attaching sched-domain(s):
[    1.536846]  domain-0: span=6-7 level=MC
[    1.536934]   groups: 6:{ span=6 cap=1005 }, 7:{ span=7 cap=1001 }
[    1.537144]   domain-1: span=4-7 level=NUMA
[    1.537262]    groups: 6:{ span=6-7 cap=2006 }, 4:{ span=4-5 cap=1949 }
[    1.537553]    domain-2: span=0-1,4-7 level=NUMA
[    1.537613]     groups: 6:{ span=4-7 mask=6-7 cap=4054 }, 0:{ span=0-1 cap=1805 }
[    1.537872]     domain-3: span=0-7 level=NUMA
[    1.537998]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6102 }, 2:{ span=0-5 mask=2-3 cap=5845 }
[    1.538448] CPU7 attaching sched-domain(s):
[    1.538505]  domain-0: span=6-7 level=MC
[    1.538586]   groups: 7:{ span=7 cap=1001 }, 6:{ span=6 cap=1005 }
[    1.538746]   domain-1: span=4-7 level=NUMA
[    1.538798]    groups: 6:{ span=6-7 cap=2006 }, 4:{ span=4-5 cap=1949 }
[    1.539048]    domain-2: span=0-1,4-7 level=NUMA
[    1.539111]     groups: 6:{ span=4-7 mask=6-7 cap=4054 }, 0:{ span=0-1 cap=1805 }
[    1.539571]     domain-3: span=0-7 level=NUMA
[    1.539610]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6102 }, 2:{ span=0-5 mask=2-3 cap=5845 }

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Meelis Roos <mroos@linux.ee>
Link: https://lkml.kernel.org/r/20210224030944.15232-1-song.bao.hua@hisilicon.com
---
 kernel/sched/topology.c | 91 ++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d3504..12f8058 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -723,35 +723,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 	for (tmp = sd; tmp; tmp = tmp->parent)
 		numa_distance += !!(tmp->flags & SD_NUMA);
 
-	/*
-	 * FIXME: Diameter >=3 is misrepresented.
-	 *
-	 * Smallest diameter=3 topology is:
-	 *
-	 *   node   0   1   2   3
-	 *     0:  10  20  30  40
-	 *     1:  20  10  20  30
-	 *     2:  30  20  10  20
-	 *     3:  40  30  20  10
-	 *
-	 *   0 --- 1 --- 2 --- 3
-	 *
-	 * NUMA-3	0-3		N/A		N/A		0-3
-	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
-	 *
-	 * NUMA-2	0-2		0-3		0-3		1-3
-	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
-	 *
-	 * NUMA-1	0-1		0-2		1-3		2-3
-	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
-	 *
-	 * NUMA-0	0		1		2		3
-	 *
-	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
-	 * group span isn't a subset of the domain span.
-	 */
-	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
-
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
@@ -982,6 +953,31 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 }
 
+static struct sched_domain *
+find_descended_sibling(struct sched_domain *sd, struct sched_domain *sibling)
+{
+	/*
+	 * The proper descendant would be the one whose child won't span out
+	 * of sd
+	 */
+	while (sibling->child &&
+	       !cpumask_subset(sched_domain_span(sibling->child),
+			       sched_domain_span(sd)))
+		sibling = sibling->child;
+
+	/*
+	 * As we are referencing sgc across different topology level, we need
+	 * to go down to skip those sched_domains which don't contribute to
+	 * scheduling because they will be degenerated in cpu_attach_domain
+	 */
+	while (sibling->child &&
+	       cpumask_equal(sched_domain_span(sibling->child),
+			     sched_domain_span(sibling)))
+		sibling = sibling->child;
+
+	return sibling;
+}
+
 static int
 build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 {
@@ -1015,6 +1011,41 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
+		/*
+		 * Usually we build sched_group by sibling's child sched_domain
+		 * But for machines whose NUMA diameter are 3 or above, we move
+		 * to build sched_group by sibling's proper descendant's child
+		 * domain because sibling's child sched_domain will span out of
+		 * the sched_domain being built as below.
+		 *
+		 * Smallest diameter=3 topology is:
+		 *
+		 *   node   0   1   2   3
+		 *     0:  10  20  30  40
+		 *     1:  20  10  20  30
+		 *     2:  30  20  10  20
+		 *     3:  40  30  20  10
+		 *
+		 *   0 --- 1 --- 2 --- 3
+		 *
+		 * NUMA-3       0-3             N/A             N/A             0-3
+		 *  groups:     {0-2},{1-3}                                     {1-3},{0-2}
+		 *
+		 * NUMA-2       0-2             0-3             0-3             1-3
+		 *  groups:     {0-1},{1-3}     {0-2},{2-3}     {1-3},{0-1}     {2-3},{0-2}
+		 *
+		 * NUMA-1       0-1             0-2             1-3             2-3
+		 *  groups:     {0},{1}         {1},{2},{0}     {2},{3},{1}     {3},{2}
+		 *
+		 * NUMA-0       0               1               2               3
+		 *
+		 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
+		 * group span isn't a subset of the domain span.
+		 */
+		if (sibling->child &&
+		    !cpumask_subset(sched_domain_span(sibling->child), span))
+			sibling = find_descended_sibling(sd, sibling);
+
 		sg = build_group_from_child_sched_domain(sibling, cpu);
 		if (!sg)
 			goto fail;
@@ -1022,7 +1053,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
-		init_overlap_sched_group(sd, sg);
+		init_overlap_sched_group(sibling, sg);
 
 		if (!first)
 			first = sg;
