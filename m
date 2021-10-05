Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DBA422A88
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJEOPN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhJEOO3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D398C061749;
        Tue,  5 Oct 2021 07:12:18 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/gU/mWFuyfWCuisv6UgtYV1qEFHp4D877OI1IX9YIg=;
        b=MvBWe4fR1fYeTJBsGQuQWoUMTwYwBtu+MiXtVFpA4BndsaZ+c2it2dEk7YI1EguJzOoPwv
        EAtUmJFxunBJ4YgbEJW8R4j6rROo8f86N3BIQ/UrC7tuIQCRJVdqCNyxFy1xWSLCKgjtmT
        JUlDo4QW4N4psw1A1SU1zGJ80Zq8RxBas380F0Wdk70HfsVx5gCu3/SC3ROjTrmIgMXdGF
        3bR8hUQfxOAKpJ8PmRsVO0x1w/gqZoy+45dY4qH++t37eFsdCNOoROzP5oTlzY6cizqXla
        QxJZYTwBanavscuFRFMYQQAEz8r4lKbfYlDCdS/9Vqlm7+zHVeDMmIHlUW1fWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/gU/mWFuyfWCuisv6UgtYV1qEFHp4D877OI1IX9YIg=;
        b=CG4gC8vo7HpW4nsB2zUrkrQA5AvTTMpak0kYsUKhOVaoOd8j2AFEB98joy9S7f1crA5a/v
        zihTTB3vSiyO1hCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210826170408.vm7rlj7odslshwch@linutronix.de>
References: <20210826170408.vm7rlj7odslshwch@linutronix.de>
MIME-Version: 1.0
Message-ID: <163344313615.25758.6716658962039922651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c33627e9a1143afb988fb98d917c4a2faa16f9d9
Gitweb:        https://git.kernel.org/tip/c33627e9a1143afb988fb98d917c4a2faa16f9d9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 26 Aug 2021 19:04:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:32 +02:00

sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD

With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
During boot kthread_bind() is used for the creation of per-CPU threads
and then hangs in wait_task_inactive() if the ksoftirqd is not
yet up and running.
The hang disappeared since commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

but enabling function trace on boot reliably leads to the freeze on boot
behaviour again.
The timer in wait_task_inactive() can not be directly used by a user
interface to abuse it and create a mass wake up of several tasks at the
same time leading to long sections with disabled interrupts.
Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.

Switch the timer to HRTIMER_MODE_REL_HARD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210826170408.vm7rlj7odslshwch@linutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba412..2672694 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3251,7 +3251,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
