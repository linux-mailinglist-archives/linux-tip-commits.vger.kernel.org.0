Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2433D589
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Mar 2021 15:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhCPOKz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Mar 2021 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbhCPOKw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Mar 2021 10:10:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0EC06174A;
        Tue, 16 Mar 2021 07:10:51 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615903844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00vj/oGI9J6csZrOK5auiX4d5Ugy0cCdUyH8sVEbrEc=;
        b=TrGt+b8RLkK3rTCfs94yBGMCdsD1XiJGHweLzvmSpzpHN0ou56YwEG35kWL6VizgqPm6H2
        S0FAAZJd3h6iQsx7eJj15INltVQADiNFVIJJMx5W7yRmYM6kg5yEudy5tohcZCnsmyQeGD
        L2hll0nnosOcx/ui/9U2Gt3eC7WmIkR0QarMRpihxcgoKV4nZK8I3fogENlOGOC63+us9Q
        9eHIMSijw+4kD4fZZ2CVJICkVkwpAftVlbT+tUdPXONk/WNVHLMIOVRCsJHTzMhtjvx7M4
        JGb2QVZPl55EE6vY8+JObMXIpWlOIkX+gPwHapOKpXfH8Duj3Y0h8nDdtc8+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615903844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00vj/oGI9J6csZrOK5auiX4d5Ugy0cCdUyH8sVEbrEc=;
        b=4jDaNsY+m1PXT/CxGN38TEpsOT2QnjEg4RhKTVFwLqykDGVnNoBhUJA6cK8YDrqM4NSwCX
        zIu+yEI//aBbKyBQ==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklet: Remove tasklet_kill_immediate
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210306213658.12862-1-dave@stgolabs.net>
References: <20210306213658.12862-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161590384415.398.14627173979951504972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3a0ade0c521a542f8a25e96ce8ea0dfaa532ac75
Gitweb:        https://git.kernel.org/tip/3a0ade0c521a542f8a25e96ce8ea0dfaa532ac75
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Sat, 06 Mar 2021 13:36:58 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 16 Mar 2021 15:06:31 +01:00

tasklet: Remove tasklet_kill_immediate

Ever since RCU was converted to softirq, it has no users.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20210306213658.12862-1-dave@stgolabs.net

---
 include/linux/interrupt.h |  1 -
 kernel/softirq.c          | 32 --------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 76f1161..2b98156 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -716,7 +716,6 @@ static inline void tasklet_enable(struct tasklet_struct *t)
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
-extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 extern void tasklet_setup(struct tasklet_struct *t,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4..8b44ab9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -658,38 +658,6 @@ static void run_ksoftirqd(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/*
- * tasklet_kill_immediate is called to remove a tasklet which can already be
- * scheduled for execution on @cpu.
- *
- * Unlike tasklet_kill, this function removes the tasklet
- * _immediately_, even if the tasklet is in TASKLET_STATE_SCHED state.
- *
- * When this function is called, @cpu must be in the CPU_DEAD state.
- */
-void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu)
-{
-	struct tasklet_struct **i;
-
-	BUG_ON(cpu_online(cpu));
-	BUG_ON(test_bit(TASKLET_STATE_RUN, &t->state));
-
-	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
-		return;
-
-	/* CPU is dead, so no lock needed. */
-	for (i = &per_cpu(tasklet_vec, cpu).head; *i; i = &(*i)->next) {
-		if (*i == t) {
-			*i = t->next;
-			/* If this was the tail element, move the tail ptr */
-			if (*i == NULL)
-				per_cpu(tasklet_vec, cpu).tail = i;
-			return;
-		}
-	}
-	BUG();
-}
-
 static int takeover_tasklets(unsigned int cpu)
 {
 	/* CPU is dead, so no lock needed. */
