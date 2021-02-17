Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48031DA26
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBQNSq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhBQNSU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:20 -0500
Date:   Wed, 17 Feb 2021 13:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0fYHDJuJETMJsp5SXPR/4h6qRFGQn1sH+35hAaR3KI=;
        b=wnJ11txNeBe9r88myasosjfiqBKd57HiAs9qWIb1vFd0xbDknLevsH1ArDpxV3VEBDmVGl
        h1vvf33ecSl5xYBrCq3yct81e/cIti994aZ7u+jJ1l2XQlWa0d+EMFxS+6jsfYoKOxVmFk
        5f+0nRUOPX4rFSqIW6s4gfIu3CrOxC9USmvMrDM0pqk+4vjWQwoJDJCyRiFgmMdfl77Vob
        mPgMI+p2OC0pqmzej/U0SLFX3TpQDA4ozyBVq5pY+QzjyxDnodxFEcHIVwxchq99hUIkAQ
        k96Mx0S7nuvSt89lk3mB0aPFE6J2w5HXbbmu576SxDUoQb4d6r8Nt/08LKW01w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0fYHDJuJETMJsp5SXPR/4h6qRFGQn1sH+35hAaR3KI=;
        b=BUEZkqtSjLuVgp3v1RzCbG0K4jnep9jUQ6pdO3ha0Of3d6eh+We1k+XD2bAVA5arGvmr9B
        wDQhkbBBIs+ZiPCg==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Fix sched_domain_topology_level
 alloc in sched_init_numa()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
References: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
MIME-Version: 1.0
Message-ID: <161356785681.20312.13022545187499987936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     71e5f6644fb2f3304fcb310145ded234a37e7cc1
Gitweb:        https://git.kernel.org/tip/71e5f6644fb2f3304fcb310145ded234a37e7cc1
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Mon, 01 Feb 2021 10:53:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:05 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
