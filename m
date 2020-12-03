Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85CD2CD240
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgLCJOH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:14:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgLCJOD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:03 -0500
Date:   Thu, 03 Dec 2020 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFBS9Ar7CYgrL0OKL4ivCXVwnlwojpwvEZ8sFPmcvsQ=;
        b=wVEZz0u/xVDMzJICQoi6s0AwuTeAytuebKjxmXOBc2+kAlpyNM75hTEbxKMg57vmC5nkcv
        rSmRigbC0SCgtpSgl1mYyzr+2rTfvr9I91b8eckvrBooyqxAp4ltnX7sDWZ6f34SbmEbvQ
        0C/RXnmS9/NrImbUqDbkpiFbpBMcLZDzWwr6NGWmLHLyEEs9QjIpvq/5aKASc36ZtRCIqG
        DA5EDAai3M9l9GbesF/JCChcxz5/y5slfufUuy1M+cwiVA+GQV/AvwLXX9mTKIyDmV4Rt+
        eLQTTlduDDnQ7oh4hEGIG0Q1OhxXWx01A6RbStDRIHS13EXDkufsnCUKC/WKPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFBS9Ar7CYgrL0OKL4ivCXVwnlwojpwvEZ8sFPmcvsQ=;
        b=p13/bQ6fks5XtQStTQMt91kDSBRyQgGhers4KyO/DMZONo3DGx1XpTw8UaRCXyWCzBt5bm
        6rLk7dQjPKTq5uAA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a=2E16068?=
 =?utf-8?q?23973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a=2E160682?=
 =?utf-8?q?3973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160698680037.3364.2097322976526631858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     65697a12a10f2ac8ab9ed1003134cac3cfb72b48
Gitweb:        https://git.kernel.org/tip/65697a12a10f2ac8ab9ed1003134cac3cfb72b48
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 01 Dec 2020 13:09:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:35 +01:00

sched: Fix kernel-doc markup

Kernel-doc requires that a kernel-doc markup to be immediately
below the function prototype, as otherwise it will rename it.
So, move sys_sched_yield() markup to the right place.

Also fix the cpu_util() markup: Kernel-doc markups
should use this format:
        identifier - description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org
---
 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7abbba..7af80c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6611,14 +6611,6 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	return ret;
 }
 
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
 static void do_sched_yield(void)
 {
 	struct rq_flags rf;
@@ -6636,6 +6628,14 @@ static void do_sched_yield(void)
 	schedule();
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
 SYSCALL_DEFINE0(sched_yield)
 {
 	do_sched_yield();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7e21ac..f5dceda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6330,7 +6330,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
  * @cpu: the CPU to get the utilization of
  *
  * The unit of the return value must be the one of capacity so we can compare
