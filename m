Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA02244D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGQUAh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 16:00:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgGQUAV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:21 -0400
Date:   Fri, 17 Jul 2020 20:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1I97U0TT3uXpJbqxNt/LwiDjZDNDMtityzyhEbsMyY=;
        b=Bq3G3xQSm1ML0uMpEij0RmRKp9Q/aqO6HNhPk4rkIJH8IBJ2oN6o5mMv4Oiyp98NUBUH/X
        lmE1BvRknyL/3hPaGaBZL3v8huri7hRJfxRsHCPMbJX/As5C0rnzpHm7j5e+evrX20IURy
        /4njtSowQx88LT5CC7hjgXv2ON4e36llhtfRzlln4EqiieeMQbia7i35UnmgS/JIjke1Ox
        6YuSmCmx5a25oklE3aLCoIhCI+OCrzoUiFqHFQlRcZABu3KyhgZvmeCTYMQP+8ldk/2mhU
        HY6FP/XbHfBI3qtAZvScPATxKJzqilolx1NtiD5z4yNIdJxh5dJT/d0aNx3KEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1I97U0TT3uXpJbqxNt/LwiDjZDNDMtityzyhEbsMyY=;
        b=0+Q3YUgyfgtQCsl8ocRuc9yfKYFQpjmAl4HwACx2LCSyWJ+fnsPnjcknvui6sOtyrMZIiP
        Ntz547fn9lU326Cg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Optimize _next_timer_interrupt() level iteration
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-7-frederic@kernel.org>
References: <20200717140551.29076-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601874.4006.7136157578578364489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     001ec1b3925da0d51847c23fc0aa4129282db526
Gitweb:        https://git.kernel.org/tip/001ec1b3925da0d51847c23fc0aa4129282db526
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:22 +02:00

timers: Optimize _next_timer_interrupt() level iteration

If a level has a timer that expires before reaching the next level, there
is no need to iterate further.

The next level is reached when the 3 lower bits of the current level are
cleared. If the next event happens before/during that, the next levels
won't provide an earlier expiration.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-7-frederic@kernel.org

---
 kernel/time/timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af1c08b..9abc417 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1526,6 +1526,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	clk = base->clk;
 	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
 		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
+		unsigned long lvl_clk = clk & LVL_CLK_MASK;
 
 		if (pos >= 0) {
 			unsigned long tmp = clk + (unsigned long) pos;
@@ -1533,6 +1534,13 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 			tmp <<= LVL_SHIFT(lvl);
 			if (time_before(tmp, next))
 				next = tmp;
+
+			/*
+			 * If the next expiration happens before we reach
+			 * the next level, no need to check further.
+			 */
+			if (pos <= ((LVL_CLK_DIV - lvl_clk) & LVL_CLK_MASK))
+				break;
 		}
 		/*
 		 * Clock for the next level. If the current level clock lower
@@ -1570,7 +1578,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		 * So the simple check whether the lower bits of the current
 		 * level are 0 or not is sufficient for all cases.
 		 */
-		adj = clk & LVL_CLK_MASK ? 1 : 0;
+		adj = lvl_clk ? 1 : 0;
 		clk >>= LVL_CLK_SHIFT;
 		clk += adj;
 	}
