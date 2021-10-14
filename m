Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7042D7F9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJNLS3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhJNLS2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:28 -0400
Date:   Thu, 14 Oct 2021 11:16:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6UR2OlLDyB6jFaxE08F3F/aaHTVTeoyO0WAiOMLqJw=;
        b=nPIjGvBMqED+1r+Zm9zY3zvinWxCJIYoHUisHBeBkMiEu7kmvgfkISdf9jsHWqS8c2yBo/
        1iZ+Mww61k6QXTiKRGDXjEx7gV4RURVqOfg6AT87VV78mAl0NYdkIQ/MIF90cte2ybUO50
        xaO+TIx0D4wtlre6bsMt0JRsDLgXHwqlYjVZrsS9MFr888dwBdmmH54bR45LsFyXCh41co
        BXE2oiAd1+mCvtn9ICbUcD1/0f1lX5q/0EsJjUf9HVmqSHYMlxjVqvsdEy/Ma1vAbTywtZ
        5xM3ZUbOkd5mPniNzlr1/Cr2MtbANUz39XgGxTQt+qcY7XnCnZHQ60oAzlkEjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6UR2OlLDyB6jFaxE08F3F/aaHTVTeoyO0WAiOMLqJw=;
        b=YCD3O6EDdIZsx7NQYvE9Rg9JU58cU6jLVaryet+tMXm6xQUjisbxst2GEUKModko8haZ18
        lklBM1qbh5DfT4Bg==
From:   "tip-bot2 for Bharata B Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Replace hard-coded number by a define
 in numa_task_group()
Cc:     Bharata B Rao <bharata@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211004105706.3669-2-bharata@amd.com>
References: <20211004105706.3669-2-bharata@amd.com>
MIME-Version: 1.0
Message-ID: <163421018174.25758.14726733202790335036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7a2341fc1fec0b8b3580be4226ea244756d3a1b3
Gitweb:        https://git.kernel.org/tip/7a2341fc1fec0b8b3580be4226ea244756d3a1b3
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Mon, 04 Oct 2021 16:27:03 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

sched/numa: Replace hard-coded number by a define in numa_task_group()

While allocating group fault stats, task_numa_group()
is using a hard coded number 4. Replace this by
NR_NUMA_HINT_FAULT_STATS.

No functionality change in this commit.

Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20211004105706.3669-2-bharata@amd.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2468d1d..fc0a0ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2438,7 +2438,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 
 	if (unlikely(!deref_curr_numa_group(p))) {
 		unsigned int size = sizeof(struct numa_group) +
-				    4*nr_node_ids*sizeof(unsigned long);
+				    NR_NUMA_HINT_FAULT_STATS *
+				    nr_node_ids * sizeof(unsigned long);
 
 		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
 		if (!grp)
