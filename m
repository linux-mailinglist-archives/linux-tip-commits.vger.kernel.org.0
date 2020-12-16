Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3772DBEFE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Dec 2020 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgLPKvS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Dec 2020 05:51:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPKvR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Dec 2020 05:51:17 -0500
Date:   Wed, 16 Dec 2020 10:50:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608115836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEwc4nHd01xm9jPjlGvYAIHXbRgLHMpudepR0qrTCK4=;
        b=TBUaaIXf5IMpCMJShm3hmkhbUTWhSvhetQc8F1S8Guy+W+EedGqdqLH+jm9Wks4+sM1bCR
        XtZ8p6VMYpH0oX5ttN60r6XXx5/Tpg7Odbz/vmRZvu2pxiECD5qPuegL8NVVxpSOqxV1+i
        wvj+Akg4u9OiAtALh1Gfylkw/7LqN3pt/XaOBzS4kWj8ohi1y/+ZJUejIOPZBC/QmmKnQG
        kzHZEIk93IZ9f6LZjq47Au+ZKXfXpH9gW6C2hcN+CNbDMNNCIXMKfRJLljTqGWdRMM0Ymo
        yqMmGHV9MMml8uT46oulwM+/PSgx0qz5BEsrO7PzVyJCrMn7P5uJ80wsR3ci5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608115836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEwc4nHd01xm9jPjlGvYAIHXbRgLHMpudepR0qrTCK4=;
        b=mcIaRiU4KvbH6gXmqaDBEXEjubLcVAYnwdgDU3YFW79yhmIo+DHFqfhqntGJ0z39RfAzkn
        Ne3+0O5uV2OSmEDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Remove bogus boot "safety" check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201206212002.725238293@linutronix.de>
References: <20201206212002.725238293@linutronix.de>
MIME-Version: 1.0
Message-ID: <160811583514.3364.2591740619189396728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ba8ea8e7dd6e1662e34e730eadfc52aa6816f9dd
Gitweb:        https://git.kernel.org/tip/ba8ea8e7dd6e1662e34e730eadfc52aa6816f9dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:12:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Dec 2020 11:26:27 +01:00

tick/sched: Remove bogus boot "safety" check

can_stop_idle_tick() checks whether the do_timer() duty has been taken over
by a CPU on boot. That's silly because the boot CPU always takes over with
the initial clockevent device.

But even if no CPU would have installed a clockevent and taken over the
duty then the question whether the tick on the current CPU can be stopped
or not is moot. In that case the current CPU would have no clockevent
either, so there would be nothing to keep ticking.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201206212002.725238293@linutronix.de

---
 kernel/time/tick-sched.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a9e6893..5fbc748 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -991,13 +991,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		 */
 		if (tick_do_timer_cpu == cpu)
 			return false;
-		/*
-		 * Boot safety: make sure the timekeeping duty has been
-		 * assigned before entering dyntick-idle mode,
-		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
-		 */
-		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
-			return false;
 
 		/* Should not happen for nohz-full */
 		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
