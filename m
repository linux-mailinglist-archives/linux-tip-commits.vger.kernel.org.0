Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A881940D939
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhIPMA4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbhIPMAv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FAAC061768;
        Thu, 16 Sep 2021 04:59:31 -0700 (PDT)
Date:   Thu, 16 Sep 2021 11:59:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ju5wpRy5VCaPdOH7TPFt5oHq8rBah+cvHqE9dNm/Q+A=;
        b=c9CEY2RJ8v9V3oi9eNQnh6XIhdpWY9wdojObRzoIBLmYFnx12YuZ4I+/K6azSTKRN6Ul7C
        c7b95/qv3l/rsKnODBOvY3Y4iB2LZBv4nKvYx/WFqIrWUhY5YQArvII18f/rrj/lp5XKv3
        8h3aSS5XJoM0f8VvV+ODPFI8e2+3NemSEZEKyKBDKTORPgnvBSO2I5NT8kzS5ijSXa0R6e
        W0V8j/w5GjXsFcDWD/6it8CThULAA8hzPrvk6Zp9113f3AZI9TW6bbok5jBuY8UOdHlZVT
        /Xstv86GsJ76rK319G8DcfFGWdGCRAj+pFhN3+3GYbZa0giTtDvfQhF/czZHJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793569;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ju5wpRy5VCaPdOH7TPFt5oHq8rBah+cvHqE9dNm/Q+A=;
        b=xowXicWbhPDcg0JLJO1w45+8OF7nowDpQk6Oo+x7AfdYUubIkhD4E1Y3DUJk6idXl3tuCY
        awJ/0RjO0hPHlLAA==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Support sched_stat_runtime tracepoint for
 RT sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-6-laoar.shao@gmail.com>
References: <20210905143547.4668-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163179356891.25758.1697118289025220625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     75ded49a19c6b655bba7ff9e5541daef4f882d78
Gitweb:        https://git.kernel.org/tip/75ded49a19c6b655bba7ff9e5541daef4f882d78
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:48:59 +02:00

sched/rt: Support sched_stat_runtime tracepoint for RT sched class

The runtime of a RT task has already been there, so we only need to
add a tracepoint.

One difference between fair task and RT task is that there is no vruntime
in RT task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for RT task.

The output of this tracepoint for RT task as follows,
          stress-9748    [039] d.h.   113.519352: sched_stat_runtime: comm=stress pid=9748 runtime=997573 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.520352: sched_stat_runtime: comm=stress pid=9748 runtime=997627 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.521352: sched_stat_runtime: comm=stress pid=9748 runtime=998203 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210905143547.4668-6-laoar.shao@gmail.com
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 95a7c3a..5d25111 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1012,6 +1012,8 @@ static void update_curr_rt(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
