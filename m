Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10F7348E85
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYLIl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYLIj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48818C06174A;
        Thu, 25 Mar 2021 04:08:39 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:08:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616670517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5FJf/9gAfhIa69rIi7DlZbWHqYsyI+QVnFdy6ztUbg=;
        b=Q1wCsXYrSZsNRQNR8Ylyn6G+H2VUd767Up7kOa1WN/ij/I4NHdv7S4LQ95nkPPnaUV/ScB
        vN0BeovfDFYSjG8qpddWMOMEJ5V7gWU2P+6oKSRkIIY/SlVZUWuRn3yE6IGg87WoesaNQS
        dDRHFENUS8YPvNxMne3vm5cmuIvh9iR+mlsEA0ZR3x1Vw3dPcmXiHKHtnv0ZRRiTw8WfUi
        yDCPwa3biBAA4V/2jpIRhI+cwlWeSBnQ+D6hB3PeItb216CBatU/aWZPLMy8luuuPgg65i
        9FR00XHe0ArT5f3u380LUvnNor3Itbl2nKX1tp6jDX80GH1HvFf/jZz9DrLnXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616670517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5FJf/9gAfhIa69rIi7DlZbWHqYsyI+QVnFdy6ztUbg=;
        b=T7iGkjfM9yOPo0EKGbE1I7JIKsm1jYYlbST0DabFqvIge+b2MWn7Z1k5R8X7oLvYrjSgFV
        jAyl+8q3ahnj5YAg==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove redundant cpumask_and() in
 init_overlap_sched_group()
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210325023140.23456-1-song.bao.hua@hisilicon.com>
References: <20210325023140.23456-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161667051732.398.15690730249125096642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0a2b65c03e9b47493e1442bf9c84badc60d9bffb
Gitweb:        https://git.kernel.org/tip/0a2b65c03e9b47493e1442bf9c84badc60d9bffb
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Thu, 25 Mar 2021 15:31:40 +13:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 11:41:23 +01:00

sched/topology: Remove redundant cpumask_and() in init_overlap_sched_group()

mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
it must be a subset of sched_group_span(sg).

So the cpumask_and() call is redundant - remove it.

[ mingo: Adjusted the changelog a bit. ]

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Link: https://lore.kernel.org/r/20210325023140.23456-1-song.bao.hua@hisilicon.com
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f2066d6..d1aec24 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -934,7 +934,7 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	int cpu;
 
 	build_balance_mask(sd, sg, mask);
-	cpu = cpumask_first_and(sched_group_span(sg), mask);
+	cpu = cpumask_first(mask);
 
 	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
 	if (atomic_inc_return(&sg->sgc->ref) == 1)
