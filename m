Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4330BBB8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBBKEw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 05:04:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhBBKEg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 05:04:36 -0500
Date:   Tue, 02 Feb 2021 10:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHkQjcIJISF7VdAccGV3vYha0ihor2eS+78j/IAVZdc=;
        b=vwzbInZ6cZ72hq1BZaCB+Se8iZgQk5zPNxPQ7pOBTeTn13ek6MMUT0rJYmvShcAX6Nbgng
        TOgRBapuPdtm/FIYiQGHyfupCTU/fgVdjYqVMk93dz6EzqXzb4yMnbqavs/FMVWI4Fw/MI
        ezLv0F+vnB8Vc4E5IUppB/SWv7BNVghwlWmp5d/MHWqOrqsPhI7yxZ8IpC5oCnPbUinIaH
        rsthFOQXEuoWJ3uuoG2wjsBxtOB83JBiIvfK8GPVuQqdgK+nSaxNCCN8Z7tHjE670wHMPm
        WlhCopSsQmzZ/LL5Nob1d4DfZfcn3nB8LnF+kGoYdg+zyvDr52i2nTaeyWDZ3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHkQjcIJISF7VdAccGV3vYha0ihor2eS+78j/IAVZdc=;
        b=Pc69Lh5XIuER+qbI0AEeuh/If7mrhZBs6N0JqGG5JpQQek5d2J6iAjzD6+80UDuLnDu+lD
        p15J7nVUXpwM6RAw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Fix sched_domain_topology_level
 alloc in sched_init_numa()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
References: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
MIME-Version: 1.0
Message-ID: <161226023248.23325.3813577782629568153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e972d92d52a1f691498add14feb2ee5902d02404
Gitweb:        https://git.kernel.org/tip/e972d92d52a1f691498add14feb2ee5902d02404
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Mon, 01 Feb 2021 10:53:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:39 +01:00

sched/topology: Fix sched_domain_topology_level alloc in sched_init_numa()

Commit "sched/topology: Make sched_init_numa() use a set for the
deduplicating sort" allocates 'i + nr_levels (level)' instead of
'i + nr_levels + 1' sched_domain_topology_level.

This led to an Oops (on Arm64 juno with CONFIG_SCHED_DEBUG):

sched_init_domains
  build_sched_domains()
    __free_domain_allocs()
      __sdt_free() {
	...
        for_each_sd_topology(tl)
	  ...
          sd = *per_cpu_ptr(sdd->sd, j); <--
	  ...
      }

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Barry Song <song.bao.hua@hisilicon.com>
Link: https://lkml.kernel.org/r/6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bf5c9bd..09d3504 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1702,7 +1702,7 @@ void sched_init_numa(void)
 	/* Compute default topology size */
 	for (i = 0; sched_domain_topology[i].mask; i++);
 
-	tl = kzalloc((i + nr_levels) *
+	tl = kzalloc((i + nr_levels + 1) *
 			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
