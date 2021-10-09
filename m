Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC94278DA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbhJIKKL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbhJIKJg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:36 -0400
Date:   Sat, 09 Oct 2021 10:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m54HmauTfJyDhMz+3BwljSv9nHwcDn58lgjMVccyOPA=;
        b=A0mS4dAKZj7SOhSCQ2e5SyTXLh72ECYS4NSxFV73x3WwEJxfyVQ5BIEsHfJUs+nCqOG2xG
        cCU5hNC4wF7rkgheB+PjkWGPqa9NBYg7cP98lE20cESPcibZ3nf6DEWZ/SLj64QU6vPyCS
        /uetmzS0TzK7aRM4p0nCe8QDATfUCjB1MzszVjI8uGvFlDkMX9sLjw+yK+6wT2psWCvKt+
        D1mp2lYtheZBD4NPKbiSuu7ZeQC8fEdE1lJo3Ez7yy9XcSIyRK3crtTgqETo2daZpPQErD
        kaCiyHsQgBlfsZtowrJHLB3gUrOzcaln45cdOzCi+fJPlrm0Su+07MXZs4KDug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m54HmauTfJyDhMz+3BwljSv9nHwcDn58lgjMVccyOPA=;
        b=31PLFUN5SxDdP3i8tcwErXtw2T+lW3pAeqXEpv0qMQkdOSPhz9VFo3BT5hp0bZhn9zZuhq
        w+7IxiC5BJafMdBA==
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
Message-ID: <163377405761.25758.2274556193360842826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b6153093de41186e2c534ffffb8ce81b1666b110
Gitweb:        https://git.kernel.org/tip/b6153093de41186e2c534ffffb8ce81b1666b110
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Mon, 04 Oct 2021 16:27:03 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:16 +02:00

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
