Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886B42AEB2F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKKIYo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgKKIXV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:21 -0500
Date:   Wed, 11 Nov 2020 08:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9IifaIw0QwRvl6U2deNGkGSCFvonz6UPTCXLv5v2SM=;
        b=thSYj4JsGkYkaWaRomOWGgSYQiPEPbES6H2A2tIc+s+1cvOfhOmKjWlWA+vOTlY0qXa/rh
        nMwyfFJGY363M37cpYv0rlm7Sr4uOxWOi8GnBaxCKLN4ZlQMCpNpOl4mVMgo2o/8DpFEb5
        aozB/FaroUPuLx7i3BhjfXR3OhEPYYyjLHJxPi8X4dvJCl/Zumtsei/6WKSXMdiVPSw3KW
        GyihJ5cF1GIzvyzA0nL1TncgyfPOKfqYcKaZCdvFlNtpZPgYmQCNVkB+fWnggTxtRQc7C1
        AJdJvw9avMhi1hYX++vk7ScFiwJ1OwmKfZZPO7PtM01KTAODJMyKKt6AVExAeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082997;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9IifaIw0QwRvl6U2deNGkGSCFvonz6UPTCXLv5v2SM=;
        b=ToY68pLK9vUChdTZuXrxkVPx0U/GemtFWSIACav7gDu7E0aByLRxb8WOSCY/qO7xrLeq7M
        PhItbnLsPoblARCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, lockdep: Annotate ->pi_lock recursion
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.406912197@infradead.org>
References: <20201023102347.406912197@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299702.11244.2062481705202743132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ded467dc83ac7173f1532bb0faa25022ff8769e5
Gitweb:        https://git.kernel.org/tip/ded467dc83ac7173f1532bb0faa25022ff8769e5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Oct 2020 16:13:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:01 +01:00

sched, lockdep: Annotate ->pi_lock recursion

There's a valid ->pi_lock recursion issue where the actual PI code
tries to wake up the stop task. Make lockdep aware so it doesn't
complain about this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.406912197@infradead.org
---
 kernel/sched/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ea593c..9ce2fc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2658,6 +2658,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
+	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	struct task_struct *old_stop = cpu_rq(cpu)->stop;
 
@@ -2673,6 +2674,20 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 		sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
 
 		stop->sched_class = &stop_sched_class;
+
+		/*
+		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
+		 * adjust the effective priority of a task. As a result,
+		 * rt_mutex_setprio() can trigger (RT) balancing operations,
+		 * which can then trigger wakeups of the stop thread to push
+		 * around the current task.
+		 *
+		 * The stop task itself will never be part of the PI-chain, it
+		 * never blocks, therefore that ->pi_lock recursion is safe.
+		 * Tell lockdep about this by placing the stop->pi_lock in its
+		 * own class.
+		 */
+		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
 	}
 
 	cpu_rq(cpu)->stop = stop;
