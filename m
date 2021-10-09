Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7064278DB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbhJIKKL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:10:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbhJIKJg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:36 -0400
Date:   Sat, 09 Oct 2021 10:07:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU7OlDsRy/o682Zt01xRzlowEyfGs+MYw8QBWIkHcGE=;
        b=qNOa0CZpaalG85wn/zVu5/avQh3DDRRTW6FZvewMdMHFNYzVX2L2ZjSNAPhJ2wlWZ0wf5O
        6TuVHgL6HFpDhrrncYNF9UOrQNQQq8syxQP75nkN4SkTX8IQKXfX04UzroRdIDjzNuSg1g
        kujKYwYoK65QlW6cHh4/Wz0HsvwLK9nv2Sm9b6QGoKff5FcR7dfFJQao+ZPR9ESxRbSfR3
        1HvlFt/0xX0V9mJZXU+fpykYXk9MSVmnIqVKOLZ7rDuPVUzKX2ucTpgnUB2W7vmSTbexdM
        Av4PZ1nzocDacWo5EpBGddOTADa1bMwDeYKRTDmEdL2oGdbMEzXfIsDJWy8kmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pU7OlDsRy/o682Zt01xRzlowEyfGs+MYw8QBWIkHcGE=;
        b=UIe0VBNZG+C3J4BwwjHvFcg53/tNsUQOprce6B/KiAaZKDky+SW4D2ZnFVluM7nVcDOR6H
        oaMejXWhBqyldACQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,livepatch: Use wake_up_if_idle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929151723.162004989@infradead.org>
References: <20210929151723.162004989@infradead.org>
MIME-Version: 1.0
Message-ID: <163377405832.25758.6730763114934839783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2aa45be430a031c10d5f4a5bf3329ff8413a9187
Gitweb:        https://git.kernel.org/tip/2aa45be430a031c10d5f4a5bf3329ff8413a9187
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Sep 2021 22:16:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:16 +02:00

sched,livepatch: Use wake_up_if_idle()

Make sure to prod idle CPUs so they call klp_update_patch_state().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929151723.162004989@infradead.org
---
 kernel/livepatch/transition.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 75251e9..5683ac0 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -413,8 +413,11 @@ void klp_try_complete_transition(void)
 	for_each_possible_cpu(cpu) {
 		task = idle_task(cpu);
 		if (cpu_online(cpu)) {
-			if (!klp_try_switch_task(task))
+			if (!klp_try_switch_task(task)) {
 				complete = false;
+				/* Make idle task go through the main loop. */
+				wake_up_if_idle(cpu);
+			}
 		} else if (task->patch_state != klp_target_state) {
 			/* offline idle tasks can be switched immediately */
 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
