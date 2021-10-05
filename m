Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467B9422A66
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhJEOOK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbhJEON6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:58 -0400
Date:   Tue, 05 Oct 2021 14:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6lIHKspeBO1zB67nNBKNb8KTrAIbqQkNmvMeBAhd8w=;
        b=oSr8SRbjLf+xrBE5cpsHoSq6rw4DmBrTSkTcF4M7Ym3OZlkNw5rzLPQh4RiGDaTRyRLDiv
        A1xgagQ2SmlaJP7lwQkw8p8S+qJviATo7Avp/cYajgSU/8HbOqqS/xh+15ryjc3+Td5gLo
        cgiFQlQkc/Bqp0IY5cy0v0Ffk9R+RVR6JtvdakJb6nekYkg2N18x3gyPyZ2Kh1LKCupDxp
        dlKnaKfRvRN5fxHusTkoUQBeLNSTE1Fs0XQ0s+2LRXVfUr/ZsCDLz4Cw0EfR4/pqQE6C2/
        xZGbKW1AGYA5+clCCVS1gcrkAxoPVZqNLobTTomYuuJL5vNoRu1vlCND+StW3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6lIHKspeBO1zB67nNBKNb8KTrAIbqQkNmvMeBAhd8w=;
        b=djPomEc6aCCUrIafRyiNOL2tNuaYvI5pWqlk4dXIV56XiyX31U1xJ2I7kLglguFsRsmJxk
        B7Cl5Q5Van7J2dAQ==
From:   "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/dl: Support sched_stat_runtime tracepoint for
 deadline sched class
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210905143547.4668-8-laoar.shao@gmail.com>
References: <20210905143547.4668-8-laoar.shao@gmail.com>
MIME-Version: 1.0
Message-ID: <163344312649.25758.13684886466720357839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     95fd58e8dadb7aa707628a2187c626bb897c49ec
Gitweb:        https://git.kernel.org/tip/95fd58e8dadb7aa707628a2187c626bb897c49ec
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:52 +02:00

sched/dl: Support sched_stat_runtime tracepoint for deadline sched class

The runtime of a DL task has already been there, so we only need to
add a tracepoint.

One difference between fair task and DL task is that there is no vruntime
in dl task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for DL task.

The output of this tracepoint for DL task as follows,
             top-36462   [047] d.h.  6083.452103: sched_stat_runtime: comm=top pid=36462 runtime=409898 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210905143547.4668-8-laoar.shao@gmail.com
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 51dd309..73fb33e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1268,6 +1268,8 @@ static void update_curr_dl(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
