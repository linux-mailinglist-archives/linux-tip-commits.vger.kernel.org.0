Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679CF422A6A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhJEOOM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51328 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhJEOOA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:00 -0400
Date:   Tue, 05 Oct 2021 14:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LbmlTMyhAyy+4IodFqJpZp/kv+c0QJufYRXZCIU4Nc=;
        b=VseMxB5LF4h+p9cN2EspA2ZlSpZXd/7ihQH2hLSXVFDSL+Xx2cGaWgNnLXM4K7JN2EtFXD
        qR4xQjOiB0QfqRbCweJu20c4Fb6FKwtPGkZvL8QNiCnwBHf3PwTeeGJ8XlsyFIUkCz0ITo
        +EBoAl/lc1htNTmiWo6uSO/NLFKkUheFtgmyqFsouNITMJfnH4bJNp8XCpNiAS7WoNpY12
        5lna3v410lazwtU58IhfF+gPrvcs4Cv7XzefWsgsfm5IGsUsIH6naa+V9L1o0cMhmihEr4
        bZVNCQDmCcyiD4A3uvEURhvv37WtZLbVJPvQQa/h9jefK6uYWxgNLhvXeFFqJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LbmlTMyhAyy+4IodFqJpZp/kv+c0QJufYRXZCIU4Nc=;
        b=rDRrB00/n/wwL+eaklc6M/QjOJSjllf4lIilVWFjCCsGxx0xqzcsnJvVcAm04/B7lEZfxm
        w1W+QiFsQExK6pBw==
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
Message-ID: <163344312778.25758.1766433794457376552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ed7b564cfdd0668efbd739d0b4e2d67797293f32
Gitweb:        https://git.kernel.org/tip/ed7b564cfdd0668efbd739d0b4e2d67797293f32
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:49 +02:00

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
 
