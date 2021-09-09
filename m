Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00594404727
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhIIImi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIIImi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 04:42:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBDAC061575;
        Thu,  9 Sep 2021 01:41:29 -0700 (PDT)
Date:   Thu, 09 Sep 2021 08:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631176888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0U2cZc7rtlXLSl5Ut13BZAl+dsb0fx7pHYS0hNY80+M=;
        b=PYESbBmLkOuHTT9yUJjpXuv8yIKQyF/e4GVEyiX7h4gU0EmieId/9r3k2Q7qjRvbolN2cX
        eyy/duIzSZ6A/Zcep9q7pTQ7AXMtbnDOXet+4TjeDFcx3NbcwgfzUsCnLM5AwYtCKjC2DM
        lKfI+FkmC1K2FoWg8NC2aDIzis2Y0khjm/FfLsKsAlbuv9Um3VvtTKlHFMhOqLoPVdYZer
        1VS6fj71zqPp3Id88MAflkgtVk9UkBp+bDGzmEot5MeTNW910i1i5BR+j9AKAs6t6FyW4w
        eCaYwVje9fLLmGoTGUdHm/j+RSqUGQC8UH6dj2nN1numRoMQ8/vpt4G14FW3UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631176888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0U2cZc7rtlXLSl5Ut13BZAl+dsb0fx7pHYS0hNY80+M=;
        b=Jqg+/5qc4JaHuuKuLeYLP+0hVLcsC/Jt628d21YXP0BztXnO/+NE3aMiJOo4WuSM3hjmbW
        jmAAfCqZpnUO9JAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/idle: Make the idle timer expire in hard
 interrupt context
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210906113034.jgfxrjdvxnjqgtmc@linutronix.de>
References: <20210906113034.jgfxrjdvxnjqgtmc@linutronix.de>
MIME-Version: 1.0
Message-ID: <163117688696.25758.3102227714043855534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9848417926353daa59d2b05eb26e185063dbac6e
Gitweb:        https://git.kernel.org/tip/9848417926353daa59d2b05eb26e185063dbac6e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 06 Sep 2021 13:30:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Sep 2021 10:36:16 +02:00

sched/idle: Make the idle timer expire in hard interrupt context

The intel powerclamp driver will setup a per-CPU worker with RT
priority. The worker will then invoke play_idle() in which it remains in
the idle poll loop until it is stopped by the timer it started earlier.

That timer needs to expire in hard interrupt context on PREEMPT_RT.
Otherwise the timer will expire in ksoftirqd as a SOFT timer but that task
won't be scheduled on the CPU because its priority is lower than the
priority of the worker which is in the idle loop.

Always expire the idle timer in hard interrupt context.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210906113034.jgfxrjdvxnjqgtmc@linutronix.de

---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 912b47a..d17b0a5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -379,10 +379,10 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	it.timer.function = idle_inject_timer_fn;
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	while (!READ_ONCE(it.done))
 		do_idle();
