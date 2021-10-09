Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D24278D5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbhJIKKG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhJIKJd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:33 -0400
Date:   Sat, 09 Oct 2021 10:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRynp10FMB8n1zXNOynPWE7FCbO32hD7d4B1vXsz9Fc=;
        b=RaL8Psx2sp1zimjDVF9COQagDo+ZCVS2QUuZ7lpp62rd1dgX51FnaEsk3WAeVgMXTs2h7f
        tPpAi8esZ8x1gg9WU/ZyTPlbiXwIuT3N23fV8BlExNgOwfBm8kjaSkh0GyLgv85G2veh4x
        pJHHHmwyC7IbJq8vogfVq4CcqdHoG6DWRcAEbpKg6o7N+idAX2QlydcBWfOOWhXeNzmuds
        uK2lmEZVFOssTKldcj7h0WJz5Kt51ZRAmqPOiPn9Fg4+O3TiD1VSYLzK6ZRNcNCq8ApMVn
        Awn0NNsf6WR9wjOYZefP6uoIudl7JywMZciHM+9ZbvnAM9lzOIFwTsCVRhLRNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRynp10FMB8n1zXNOynPWE7FCbO32hD7d4B1vXsz9Fc=;
        b=SW2KWsXtH//3ZrtZRpNEmi72ndibm7N235J2J/nVuvOhU37obsA/8z8DEyXn6CgX/HKUDU
        nZ87UqywTJPjzRCA==
From:   "tip-bot2 for Yicong Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove unused numa_distance in
 cpu_attach_domain()
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Barry Song <baohua@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210915063158.80639-1-yangyicong@hisilicon.com>
References: <20210915063158.80639-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163377405464.25758.14162385949343259307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f43df9225fcad9b07a4ef4d0fe4c3ad2fb4ce82d
Gitweb:        https://git.kernel.org/tip/f43df9225fcad9b07a4ef4d0fe4c3ad2fb4ce82d
Author:        Yicong Yang <yangyicong@hisilicon.com>
AuthorDate:    Wed, 15 Sep 2021 14:31:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:17 +02:00

sched/topology: Remove unused numa_distance in cpu_attach_domain()

numa_distance in cpu_attach_domain() is introduced in
commit b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")
to warn user when NUMA diameter > 2 as we'll misrepresent
the scheduler topology structures at that time. This is
fixed by Barry in commit 585b6d2723dc ("sched/topology: fix the issue
groups don't span domain->span for NUMA diameter > 2") and
numa_distance is unused now. So remove it.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20210915063158.80639-1-yangyicong@hisilicon.com
---
 kernel/sched/topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c56faae..5af3edd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
-	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -732,9 +731,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		}
 	}
 
-	for (tmp = sd; tmp; tmp = tmp->parent)
-		numa_distance += !!(tmp->flags & SD_NUMA);
-
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
