Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4B3AC9C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhFRL0P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhFRL0O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:14 -0400
Date:   Fri, 18 Jun 2021 11:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR6oELuwkW7w79xFGGRD+NGTdIakf+EWLs1EYMdVTPA=;
        b=GgEbZcsJBifFS9ReFobwt2w5MfBIgRMohuN/3IPD6ATfjQcvA9GgbLbm4HSl7PdKc0Hy4D
        WydQFR4v3I24aAuoh64iW4tSJjsLfFZQuN8MofSbgPORyXy9tOjyDmxk/Vd6ASUjqphK5n
        6AZ+EtMg2BLL3+//Lwk5ciGvcOBPy91nrJgFQDxuHEZ9OdybXtp5PDcy84h5q08Hc3v3A9
        W9JfnWwX1ErWYcFjoyW7IQa2yjdJIRMUgNAi0kR8CdYaXQ9Cie9fPbI7gX0U+DjJply4PT
        oiy1yPcbn7RG1nJ4lYs9T+QwdVcqrXI9YwvErxqSfAeRtKvEdNFbKMwhxLp1/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR6oELuwkW7w79xFGGRD+NGTdIakf+EWLs1EYMdVTPA=;
        b=V92/XsppnnKbulTg/8o7hnltpdlNRtXpWgylTuafPhtAu7XqpZjYWfrOj6x39ptH59/SCN
        HvpkrcyJ0AwVCfDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,perf,kvm: Fix preemption condition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.285099381@infradead.org>
References: <20210611082838.285099381@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544396.19906.14021527012259454118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3ba9f93b12361e005dd65fcc8072b42e3189f4f4
Gitweb:        https://git.kernel.org/tip/3ba9f93b12361e005dd65fcc8072b42e3189f4f4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:07 +02:00

sched,perf,kvm: Fix preemption condition

When ran from the sched-out path (preempt_notifier or perf_event),
p->state is irrelevant to determine preemption. You can get preempted
with !task_is_running() just fine.

The right indicator for preemption is if the task is still on the
runqueue in the sched-out path.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20210611082838.285099381@infradead.org
---
 kernel/events/core.c | 7 +++----
 virt/kvm/kvm_main.c  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6e..fd89000 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8682,13 +8682,12 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
-	if (!sched_in && task->state == TASK_RUNNING)
+	if (!sched_in && task->on_rq) {
 		switch_event.event_id.header.misc |=
 				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
+	}
 
-	perf_iterate_sb(perf_event_switch_output,
-		       &switch_event,
-		       NULL);
+	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL);
 }
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6a6bc7a..5f166eb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5025,7 +5025,7 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 {
 	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
-	if (current->state == TASK_RUNNING) {
+	if (current->on_rq) {
 		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}
