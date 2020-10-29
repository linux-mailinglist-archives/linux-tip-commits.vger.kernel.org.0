Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6F29E9A5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJ2Kvs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgJ2Kvs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:48 -0400
Date:   Thu, 29 Oct 2020 10:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnAx6hs49oZk5Hoy0RzC8oqhKzyeWv2amQouykxFI44=;
        b=zdyyxhXKFkw2XrRB/mp88p9tskjXVRW2TRAMmNIBe5d+RM+3Mbc4mG2XljWopCAO7Lwl8A
        /HGT2DpxjjuM0f46PpQ9R0U/vBHuMeLWQ4x7G5sHybckSoZ7AdHzhuhOFZ1lJ7P9OS7wFt
        cq/3XRqvoP2fbi8xt11qGulUD39u0abXYToAvOEpQHMu7frcR2t4rW7PnpkKs9NskBTNvS
        AHDRN3qXO1jeNQQcqfVZEw33zNvy7Pu/oDkzvNM6/MqnZprTl4lHhytd/zsv07t3uMIvT3
        nODsdDXzvkuWK39T1szyIv0FeIT5j/mGP6lYRN+gyLDLWxPmRNZlWYxKeoy2mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnAx6hs49oZk5Hoy0RzC8oqhKzyeWv2amQouykxFI44=;
        b=DIB0Qalj1vaBQUsJLAqABwC4I/xbto9sVIV3SRapYgJIgpqQ0stg0t5KIQ4CJp8LMYMbzL
        toafk0xiQtg6/sCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Reenable interrupts in do_sched_yield()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
References: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160396870555.397.15054957150434769625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     345a957fcc95630bf5535d7668a59ed983eb49a7
Gitweb:        https://git.kernel.org/tip/345a957fcc95630bf5535d7668a59ed983eb49a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 20 Oct 2020 16:46:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:31 +01:00

sched: Reenable interrupts in do_sched_yield()

do_sched_yield() invokes schedule() with interrupts disabled which is
not allowed. This goes back to the pre git era to commit a6efb709806c
("[PATCH] irqlock patch 2.5.27-H6") in the history tree.

Reenable interrupts and remove the misleading comment which "explains" it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/87r1pt7y5c.fsf@nanos.tec.linutronix.de
---
 kernel/sched/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7..6f533bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6094,12 +6094,8 @@ static void do_sched_yield(void)
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
 
-	/*
-	 * Since we are going to call schedule() anyway, there's
-	 * no need to preempt or enable interrupts:
-	 */
 	preempt_disable();
-	rq_unlock(rq, &rf);
+	rq_unlock_irq(rq, &rf);
 	sched_preempt_enable_no_resched();
 
 	schedule();
