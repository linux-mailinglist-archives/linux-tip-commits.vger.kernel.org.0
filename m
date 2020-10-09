Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD8288F77
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbgJIRCH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:02:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389936AbgJIRB3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:29 -0400
Date:   Fri, 09 Oct 2020 17:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SE7Czp+opUNx4ncsSvp0lItuPv8IWzF11iong+Ft6LY=;
        b=y6fVjPPUBagujRcAmhIwv5Inp3Sf5edELAhK1A6oy1ftqN9X+IH4F60+FuVYDXIyG2uBcv
        6qzITS5hoTYlmL7ScxUpcX1gzGfwSQQpZJYQItHOU//HgXoBWrYbzutkps2cTL9CiRXj6s
        uy8/eZR9Zm+4ETHwZGNIvW4s7kDE4t48GBIPawyhTrG8g1nwof0ecMdsFM+NkHqbtXacH4
        0BIO19wD2FwS9lnTkzCF6eR7sYbze8iigb9qM92WEyYWL2tFm4Np5PsbfplFAPXcfjRjcf
        mFNhmF2H+uV5DnRW+KNizBQEjQp/dVoHrfCvmuaTmoa9E8hbzreoTVEhzbWdjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SE7Czp+opUNx4ncsSvp0lItuPv8IWzF11iong+Ft6LY=;
        b=20+dVflXkAjCJ5MDWEzGiaJQuByQTGupuFOln6VsgXR45l3GfWHg4qQeSqqwMoLXbBt4Tc
        pBoh1x3okDTL2xAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sched: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288549.7002.94618164546835622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4a291f57d97ce1c14d286b2451573ccbb3b43022
Gitweb:        https://git.kernel.org/tip/4a291f57d97ce1c14d286b2451573ccbb3b43022
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:30:49 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:21 -07:00

sched: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 6 +-----
 lib/Kconfig.debug   | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3..1c304a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3706,8 +3706,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * finish_task_switch() for details.
 	 *
 	 * finish_task_switch() will drop rq->lock() and lower preempt_count
-	 * and the preempt_enable() will end up enabling preemption (on
-	 * PREEMPT_COUNT kernels).
+	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
 	rq = finish_task_switch(prev);
@@ -7308,9 +7307,6 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (irqs_disabled())
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > preempt_offset)
 		return;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4d0574..52af6ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1320,7 +1320,6 @@ config DEBUG_LOCKDEP
 
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
-	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
