Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948A133F46F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhCQPtc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhCQPs7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:59 -0400
Date:   Wed, 17 Mar 2021 15:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKBK8RYUSeZipkI/UAiDgqwln+269jPhdXHoA98dtHo=;
        b=YaazKJ6qDtA2HOK9yhUGOgwAuRVd1IIwd6+zRIXptEiiVU7fKzE4uVJCnSGaXLV1SHoI9b
        LccwRamEk8AEPuq2cUMRuLH7UaIiLBXxFqDm8CEoek+GKgWebxXbVnCGYcxJm4/TNeOQev
        aDLAf79IWeoWnx7y/fN4QnN0NYieUlzbYAf+OydS7n7Xv2Un62qX6fOv3JDcFrKG8+doIG
        cRfd7t6lDHeJE68//tCJ0zPWfRvcWsivkAtQrjsFm6JlMfEhpWU9nUylob1JKJkHzoSskE
        XxijpjJguDg3U5Apu/4UFJG5AilwXOrlSq1MZhDDIcyneHZ+9GhBL/KJYeQD8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKBK8RYUSeZipkI/UAiDgqwln+269jPhdXHoA98dtHo=;
        b=YhFeKUkHb+mOBihcdBwo6xcDvpE53/6yfbKWoMS73RVauDLbYN0TczS+6AbCmdesNf7gvS
        xoJAwEvOy6GkFPDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Replace spin wait in tasklet_kill()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.890532921@linutronix.de>
References: <20210309084241.890532921@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613819.398.10622320225082354684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     697d8c63c4a2991a22a896a5e6adcdbb28fefe56
Gitweb:        https://git.kernel.org/tip/697d8c63c4a2991a22a896a5e6adcdbb28fefe56
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Mar 2021 09:42:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:57 +01:00

tasklets: Replace spin wait in tasklet_kill()

tasklet_kill() spin waits for TASKLET_STATE_SCHED to be cleared invoking
yield() from inside the loop. yield() is an ill defined mechanism and the
result might still be wasting CPU cycles in a tight loop which is
especially painful in a guest when the CPU running the tasklet is scheduled
out.

tasklet_kill() is used in teardown paths and not performance critical at
all. Replace the spin wait with wait_var_event().

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.890532921@linutronix.de

---
 kernel/softirq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ef6429a..ba89ca7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -532,10 +532,12 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
-static bool tasklet_should_run(struct tasklet_struct *t)
+static bool tasklet_clear_sched(struct tasklet_struct *t)
 {
-	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+		wake_up_var(&t->state);
 		return true;
+	}
 
 	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
 		  t->use_callback ? "callback" : "func",
@@ -563,7 +565,7 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (tasklet_should_run(t)) {
+				if (tasklet_clear_sched(t)) {
 					if (t->use_callback)
 						t->callback(t);
 					else
@@ -623,13 +625,11 @@ void tasklet_kill(struct tasklet_struct *t)
 	if (in_interrupt())
 		pr_notice("Attempt to kill tasklet from interrupt\n");
 
-	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		do {
-			yield();
-		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
-	}
+	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
+		wait_var_event(&t->state, !test_bit(TASKLET_STATE_SCHED, &t->state));
+
 	tasklet_unlock_wait(t);
-	clear_bit(TASKLET_STATE_SCHED, &t->state);
+	tasklet_clear_sched(t);
 }
 EXPORT_SYMBOL(tasklet_kill);
 
