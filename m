Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1430824A10C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHSODh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 10:03:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39572 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgHSOCt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:49 -0400
Date:   Wed, 19 Aug 2020 14:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llQb2frl0t3QALWrupXqVAU9xpefRqbgivvPTvQsMbQ=;
        b=H/7S94U2gvB2Qm8S8g80AZYcSKYnHoEDFV+hzmjtf7uZr6PHVsghSOfymfeyAZtWOdBeFO
        +vKQeZ27sT89PiLleJTIfueCVqcK/R42yOB2FB6i36L2ZnS8KzefKJbZo9oZErZzPsm3gD
        GNQPWRHIzsQ5ki6tLQBUPBiv2jlhlEKMsAhW/D/3kVdiaSFYqWFPoMcEB7VLRrK6huaNrX
        tPJr7v04T836GB+OJSfEbadesZrIZ3hZEObHRHQ65T9kzazHC902Fb8GzqgpawDrkaMdsH
        xf6ft4APE715uYhHpCKRa3uyjagMBXWZqQq84y3Vbxnlyo+b6ntB22nFyJ2hPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llQb2frl0t3QALWrupXqVAU9xpefRqbgivvPTvQsMbQ=;
        b=thAPeY5ENnUji31xtnr+6IVFXrzcSimFRQINELm8Hnlub9o+nqCvYIDqzbV1E29kc6vOuB
        fexQ6bJo6SB78aDQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove SD_SERIALIZE degeneration
 special case
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-10-valentin.schneider@arm.com>
References: <20200817113003.20802-10-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576630.3192.4985078690584482914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ab65afb094c7b2e954e8d56ffbc7df843211c2c8
Gitweb:        https://git.kernel.org/tip/ab65afb094c7b2e954e8d56ffbc7df843211c2c8
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/topology: Remove SD_SERIALIZE degeneration special case

If there is only a single NUMA node in the system, the only NUMA topology
level that will be generated will be NODE (identity distance), which
doesn't have SD_SERIALIZE.

This means we don't need this special case in sd_parent_degenerate(), as
having the NODE level "naturally" covers it. Thus, remove it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-10-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 38e6671..c662c53 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -183,11 +183,9 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 		return 0;
 
 	/* Flags needing groups don't count if only 1 group in parent */
-	if (parent->groups == parent->groups->next) {
+	if (parent->groups == parent->groups->next)
 		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
-		if (nr_node_ids == 1)
-			pflags &= ~SD_SERIALIZE;
-	}
+
 	if (~cflags & pflags)
 		return 0;
 
