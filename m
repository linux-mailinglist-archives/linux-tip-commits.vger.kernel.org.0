Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988E74278EB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244860AbhJIKL0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbhJIKLJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:11:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C73C061766;
        Sat,  9 Oct 2021 03:08:05 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxGF5UOJQfw7+9wUWMu1Tx4xQKP9/wM+jsZq4Zi4npI=;
        b=DXF5G5KA/XI0HfO/9Hk1KuVNWa46Ktpxxm4FzMFeooHqYlItHlV9UmgUPdhfRoxxwBbeah
        vfNYvceWqNhJcUkHehpekuJsfA4t+4tFfgcYLOPJSby6IVWNdRRehFDhJxy/jmKzExGWzK
        1dGn3VG7hLuJDa4OxDVJviNemAEhshJn1sQ+xODBpAefq0oEnZxtE0YzWq9h6vxTMOHj+K
        pP+FjLG/h6VM/iRM4LuSyBlBi4zPskbsFXduOr+xwDvZslVBjZo8tDVxj0RhOkiXOvVHR7
        N8Fs4OGvFNKeFzTENOU3Vjf7hl6AHLCyqYOca1Q7s4e6qn2FKTY8OzWlpmfEnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxGF5UOJQfw7+9wUWMu1Tx4xQKP9/wM+jsZq4Zi4npI=;
        b=b6bentPECHmVymhb9E/GelGGwn0+6ap8kuV9N+DqZtOdVpH31hP9CEroZ02tG9pnNjIrZM
        dzDcREdbNwpHAyAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify wake_up_*idle*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929152428.769328779@infradead.org>
References: <20210929152428.769328779@infradead.org>
MIME-Version: 1.0
Message-ID: <163377405910.25758.17028287781805092417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8850cb663b5cda04d33f9cfbc38889d73d3c8e24
Gitweb:        https://git.kernel.org/tip/8850cb663b5cda04d33f9cfbc38889d73d3c8e24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Sep 2021 22:16:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:15 +02:00

sched: Simplify wake_up_*idle*()

Simplify and make wake_up_if_idle() more robust, also don't iterate
the whole machine with preempt_disable() in it's caller:
wake_up_all_idle_cpus().

This prepares for another wake_up_if_idle() user that needs a full
do_idle() cycle.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929152428.769328779@infradead.org
---
 kernel/sched/core.c | 14 +++++---------
 kernel/smp.c        |  6 +++---
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 74db3c3..3b55ef9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3695,15 +3695,11 @@ void wake_up_if_idle(int cpu)
 	if (!is_idle_task(rcu_dereference(rq->curr)))
 		goto out;
 
-	if (set_nr_if_polling(rq->idle)) {
-		trace_sched_wake_idle_without_ipi(cpu);
-	} else {
-		rq_lock_irqsave(rq, &rf);
-		if (is_idle_task(rq->curr))
-			smp_send_reschedule(cpu);
-		/* Else CPU is not idle, do nothing here: */
-		rq_unlock_irqrestore(rq, &rf);
-	}
+	rq_lock_irqsave(rq, &rf);
+	if (is_idle_task(rq->curr))
+		resched_curr(rq);
+	/* Else CPU is not idle, do nothing here: */
+	rq_unlock_irqrestore(rq, &rf);
 
 out:
 	rcu_read_unlock();
diff --git a/kernel/smp.c b/kernel/smp.c
index f43ede0..ad0b68a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,14 +1170,14 @@ void wake_up_all_idle_cpus(void)
 {
 	int cpu;
 
-	preempt_disable();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
+		if (cpu == raw_smp_processor_id())
 			continue;
 
 		wake_up_if_idle(cpu);
 	}
-	preempt_enable();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
