Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA24422A70
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhJEOOc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbhJEOOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:02 -0400
Date:   Tue, 05 Oct 2021 14:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jC5YUKVeo82cyr7A4Ga7lDpfSuqDBcWqyQuXLUOm1Ro=;
        b=FQJAzNct4U8HMuG0qDU8mxq4zUncv2rLeWbPNiofETq1nIEz5Mk9nwMzh51wN06w8bEDd6
        P2/N6K4+Dw5w6vm3XR8h1pt2BvH31HWJtMSmXd2M44AGG0Xc4gkMik+wTURJRnOk+sD/j8
        iPTXN5DX+kpg1FF8FKBmEl0qDzXU2TbfnmlcQBzIk7V9njs5+wk9pljbEZqiZ4/Dg5ypyi
        KHsPL9Mb2Vie5uyHhZPDCi8pcmh0zYJo/T5Y0RpUWxsosvL+29KZ2uM+dePx5q1QDOmRGX
        2+3vvuECOTGObI39y+UTlhLKrfLSa4MEWRcxyRwIX6ULA5q/6QsZyEISe0scBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jC5YUKVeo82cyr7A4Ga7lDpfSuqDBcWqyQuXLUOm1Ro=;
        b=UPW6gNe++hgfoB1Y6eGPCRc+NDwKmJue6awrwpfFFASw6X8fe4MRme0D0NhyQ4lsBugfEm
        frjmshy3xvs76PBQ==
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
Message-ID: <163344313032.25758.6902441477709070229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a2dcb276ff9287fcea103ca1a2436383e8583751
Gitweb:        https://git.kernel.org/tip/a2dcb276ff9287fcea103ca1a2436383e8583751
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:40 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:44 +02:00

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
index fd41abe..61d3e3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4530,9 +4530,9 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
