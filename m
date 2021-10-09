Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB474278E3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbhJIKKe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbhJIKJz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE749C061768;
        Sat,  9 Oct 2021 03:07:37 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vc9bUmwUenb2AbaKD/LC6gUdCWLxIFOR811QfgvC84=;
        b=EZwrcesmOPXvLkQNtxJA1sVxf7x0qxa99a2tLYlOJU6ttXiVNbe9oYCWYLoGkfUikm/ZwZ
        vvRkPesc+U6sI78VBuKcRCdmDvKIiDbQZPeWJ9btRKf+3CYAoZWapLTg/7/sCEoa7Vieyf
        gyer40F0TTdN6Q23GsnsDih1W8AHCR7ddBGVhRWl/2yKkKeMV65VgEFaMROG1k/7iATJcY
        cJEwwRpThZ/gYlRt0r5bTLAsDxgvBdYd0lSqmnZGTf/wsRxhGHFC8sgSwQgEiK0cZIbONH
        JtFwlv6nUfY9p8UfknLZscB7XrgwHG/uePdkGb6zN0JdbOl1pB4DkrGT3mv9Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vc9bUmwUenb2AbaKD/LC6gUdCWLxIFOR811QfgvC84=;
        b=krpQENxtaDCh4PTrXdES0q3Ksl3gH+UbgE6hDejqjnqC3WXRthlcJAmj70ZY4wvUJqdTYt
        ox7qOmvZ6iNQ8aAQ==
From:   "tip-bot2 for Bharata B Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix a few comments
Cc:     Bharata B Rao <bharata@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211004105706.3669-4-bharata@amd.com>
References: <20211004105706.3669-4-bharata@amd.com>
MIME-Version: 1.0
Message-ID: <163377405554.25758.10181319411831045382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2294d6f5131b6b226d28828bd60e6fbc69962e84
Gitweb:        https://git.kernel.org/tip/2294d6f5131b6b226d28828bd60e6fbc69962e84
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Mon, 04 Oct 2021 16:27:05 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:16 +02:00

sched/numa: Fix a few comments

Fix a few comments to help understand them better.

Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20211004105706.3669-4-bharata@amd.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfbd5ef..87db481 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2074,7 +2074,7 @@ static void numa_migrate_preferred(struct task_struct *p)
 }
 
 /*
- * Find out how many nodes on the workload is actively running on. Do this by
+ * Find out how many nodes the workload is actively running on. Do this by
  * tracking the nodes from which NUMA hinting faults are triggered. This can
  * be different from the set of nodes where the workload's memory is currently
  * located.
@@ -2128,7 +2128,7 @@ static void update_task_scan_period(struct task_struct *p,
 
 	/*
 	 * If there were no record hinting faults then either the task is
-	 * completely idle or all activity is areas that are not of interest
+	 * completely idle or all activity is in areas that are not of interest
 	 * to automatic numa balancing. Related to that, if there were failed
 	 * migration then it implies we are migrating too quickly or the local
 	 * node is overloaded. In either case, scan slower
