Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3332FA0E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCFLmh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCFLmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:25 -0500
Date:   Sat, 06 Mar 2021 11:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdBR0ohv2b5rkxY/JtiPsnG6VuYWf5wGS8A4oo6zBhE=;
        b=3SxoNDGeXMxAk9mjGcjJK3L7TfwDjDU+MNXs6JeJZoAp84JkuXzdRqFrHVMoRELbaRc0RV
        285K7qyuGxBffIeUyiG+wYKl32By9HFrvqv/cMC8/NmYtt1j+z8fu5RPvORxL2Qq0bQwew
        va6SQNTlbrLIFbrvfR1Pd7TcFmCXNtrlo0ZFTSYLtYxvRagFWGcJyrEyUG3tbZWvSTqKxp
        vxeOnL029LRIrCJcKadGjsua+2ybxTz7MvySHHK2on3cvxUNmN2oT/YP303BSUEGprc7Xu
        QNy0n7A2+2A+lhYkU9mtcPMSC13CtWAIh10K3dTP5p1AxkbD5q6R49ctbv+bww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdBR0ohv2b5rkxY/JtiPsnG6VuYWf5wGS8A4oo6zBhE=;
        b=VbQ0cPumIFyJNWN4Ua33QZbc/mmpHb6xSnjEvJqaX+GeeSZGJlwIsk2Nc+9yqlGTxOKmfa
        El5ZUWj3bXuXX9Dw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/membarrier: fix missing local execution of
 ipi_sync_rq_state()
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        #@tip-bot2.tec.linutronix.de, 5.4.x+@tip-bot2.tec.linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com>
References: <74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com>
MIME-Version: 1.0
Message-ID: <161503094441.398.6645773108420979518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ce29ddc47b91f97e7f69a0fb7cbb5845f52a9825
Gitweb:        https://git.kernel.org/tip/ce29ddc47b91f97e7f69a0fb7cbb5845f52a9825
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 17 Feb 2021 11:56:51 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:21 +01:00

sched/membarrier: fix missing local execution of ipi_sync_rq_state()

The function sync_runqueues_membarrier_state() should copy the
membarrier state from the @mm received as parameter to each runqueue
currently running tasks using that mm.

However, the use of smp_call_function_many() skips the current runqueue,
which is unintended. Replace by a call to on_each_cpu_mask().

Fixes: 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy load")
Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org # 5.4.x+
Link: https://lore.kernel.org/r/74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com
---
 kernel/sched/membarrier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index acdae62..b5add64 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -471,9 +471,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	}
 	rcu_read_unlock();
 
-	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);
-	preempt_enable();
+	on_each_cpu_mask(tmpmask, ipi_sync_rq_state, mm, true);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
