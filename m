Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA440D934
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhIPMAv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbhIPMAu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:50 -0400
Date:   Thu, 16 Sep 2021 11:59:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVnYm8U0Vave4AV6/8VUVq42aW96+VGtV3hZmDXyZYg=;
        b=G1yqf5uJV3qRPoZwxWxErIN2Rb2RqZ6QSAul9FiTa9WSiosjV/763Syf7WZn9szoBJlzDv
        2G6t/+sAio0+s7ofdke+HO0RRo94dLabH7EjEJ0+BkwA5mUmjtfnDPRWa7R/Jo8VyzQa+O
        +BRjEXzDRCoPIhpRTwqlbxzY4w5sGoDSI1VWUKVswdwkjkFTpGK+1hoTp3qNUAmiU80GuM
        p4ZRGXWZFA5k0IFCB0RmtdAj3G3DBThT6CjXkZlnhj8BsGtZJ9A64FGYzJLP7xbPU86QhS
        ywYxh6ZUqjoRKiOBXW/RsEClkyiSRXhDqPaeuQ2lMRj+mE9oJYU6MeoQ2LEH8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVnYm8U0Vave4AV6/8VUVq42aW96+VGtV3hZmDXyZYg=;
        b=Uyvt3fmkCuZ7PEQyBvQG57P4vnOPDw4YXBBGwf1q5R/XIUPmXcxQSdHVsRS3JhCuRTY91a
        ztkdFa4shTPe4XAQ==
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
Message-ID: <163179356772.25758.9198635373218689234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     db4570a26807a7a955a5dc58e0bea3fc2b1d7c23
Gitweb:        https://git.kernel.org/tip/db4570a26807a7a955a5dc58e0bea3fc2b1d7c23
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Sun, 05 Sep 2021 14:35:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:00 +02:00

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
 
