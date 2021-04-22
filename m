Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF08367B2C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhDVHgi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhDVHgi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:38 -0400
Date:   Thu, 22 Apr 2021 07:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQIR49X3a8EPFMim+gGYyslpsaOL4EwyuqTbW13sbaM=;
        b=nsZhPZgWpJ51urs2ysZ8JuNBUHg0KFz4jn8PXTBmUwZiuZDgM7XO9xZ8YMuI2ID6ZJub8T
        W4xEC8074nvKCRa5/2IykQ+u3SF3Umi/W8Q8EOGqfEESFHsZZ1lYGBdWKkEr3ZLa3AEvbw
        l5B+j7dNC8laZ7S0dL1kjp+bqus4u934l/TXBDOZeLAZDhgYOd3caA1YB/F2Cmokce4G3e
        JWIhKWpXA4YzGHg1E9fjXoRlGGXuerrU1QqoG5ixEk117zFGkh+Kai9RYZA7C6h8RLksoR
        dkBTEUpo12J9SNJOd9SJ9XmxMIRisI0/oDSDUF9Mqoo3JBSMdeeRb/JInsG1VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQIR49X3a8EPFMim+gGYyslpsaOL4EwyuqTbW13sbaM=;
        b=W31EBaJW80UEo5YWWs3MhBxCYZuwfy1pLgCUCV6MedAHf6dtz9CNPHL7aDwW/entEObre7
        Hp3ynzaN0yi1FlAQ==
From:   "tip-bot2 for Charan Teja Reddy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,psi: Handle potential task count underflow
 bugs more gracefully
Cc:     Charan Teja Reddy <charante@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
References: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Message-ID: <161907696243.29796.7158274571257481076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d10a13d1e4c349b76f1c675a874a7f981d6d3b4
Gitweb:        https://git.kernel.org/tip/9d10a13d1e4c349b76f1c675a874a7f981d6d3b4
Author:        Charan Teja Reddy <charante@codeaurora.org>
AuthorDate:    Fri, 16 Apr 2021 20:32:16 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:41 +02:00

sched,psi: Handle potential task count underflow bugs more gracefully

psi_group_cpu->tasks, represented by the unsigned int, stores the
number of tasks that could be stalled on a psi resource(io/mem/cpu).
Decrementing these counters at zero leads to wrapping which further
leads to the psi_group_cpu->state_mask is being set with the
respective pressure state. This could result into the unnecessary time
sampling for the pressure state thus cause the spurious psi events.
This can further lead to wrong actions being taken at the user land
based on these psi events.

Though psi_bug is set under these conditions but that just for debug
purpose. Fix it by decrementing the ->tasks count only when it is
non-zero.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/1618585336-37219-1-git-send-email-charante@codeaurora.org
---
 kernel/sched/psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index d1212f1..db27b69 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -699,14 +699,15 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
 			continue;
-		if (groupc->tasks[t] == 0 && !psi_bug) {
+		if (groupc->tasks[t]) {
+			groupc->tasks[t]--;
+		} else if (!psi_bug) {
 			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
 					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
-		groupc->tasks[t]--;
 	}
 
 	for (t = 0; set; set &= ~(1 << t), t++)
