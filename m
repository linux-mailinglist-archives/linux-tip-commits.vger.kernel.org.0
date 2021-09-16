Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9006040D941
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhIPMBE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbhIPMAy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3072C0613CF;
        Thu, 16 Sep 2021 04:59:33 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:59:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ol3fZGCyJT1wVKos2VLXEk/1aUNdYsozN88GQN84voc=;
        b=CWv/cz8teUIUFkWkd1uy7HNDc4EXXSmBSjqVjaiAFoaNZs67qLzJNvoxjQur1YlqvBFcvP
        7zZEG1qfrd7h9HLbziE5feg9MDNSf3k/CJTqUpRWd8asv10aA4Vysn/s4eOqizC8z34aAv
        KtHmGWiZbrNlmwks/srjIWwF3P22jS7egTdZleDT5nVDfPl1Un6yb9ylPiWqaAlZ8ADBcK
        uFXWFRZ1WYkM/Nl5DI8cRuNOW/cuVONTy1Xo5KOoyhM7bg0sGHZCsbZT/ZYeqOxJ2BxfcA
        +nxH7kRhZf6vSbcjAyJXT8a3zZ5LvtyczYVQx9Mb/C0LM8KSSQje/Yut2q7j2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ol3fZGCyJT1wVKos2VLXEk/1aUNdYsozN88GQN84voc=;
        b=5fuiu6poIin4nCzEANlKwYSbKa15tgndsWe0KqU/MaIjWaVvu0PdSju5Oi975vS23NSIez
        QgGwf12n46YJDeAQ==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use __schedstat_set() in set_next_entity()
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-2-laoar.shao@gmail.com>
References: <20210905143547.4668-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163179357151.25758.3430253645020974508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5855e81a4a3b6eb8967bff760e7d1f1b82228525
Gitweb:        https://git.kernel.org/tip/5855e81a4a3b6eb8967bff760e7d1f1b82228525
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:40 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:48:58 +02:00

sched/fair: Use __schedstat_set() in set_next_entity()

schedstat_enabled() has been already checked, so we can use
__schedstat_set() directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20210905143547.4668-2-laoar.shao@gmail.com
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3594884..148b830 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4501,9 +4501,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
-			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
+		__schedstat_set(se->statistics.slice_max,
+				max((u64)se->statistics.slice_max,
+				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
