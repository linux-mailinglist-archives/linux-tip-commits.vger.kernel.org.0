Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4B2C419F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgKYOCz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgKYOCz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109AC061A4E;
        Wed, 25 Nov 2020 06:02:55 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pu7D3c8JU8s2gUIpZFKkkhuhamo7U7DI6Vsa8fo2LAE=;
        b=EwfOxotB9J/LZ+PzaG4WvBNeI+u5XnVDsQnbVYCgiXk9gySIFT+QT1gwwv6oearJ2QHAVV
        hnDHRtbYzyDo5OOEmIv0xelck6Xa5gR8gSihQ/XdETLPGf4aNM3epYOqKuEkdFpRbsm0RH
        bYRVkMfGnsPQAMAt9LTCkLvUethIsleDJa+ZjPK8PB1eIpQNJNIH7u3vLI2HAJx/yj4yIL
        p9LFlxJlwyJ+mmovFbLC/+gp23B8nSKETK1/Y6LogEWcMRwRkI6NwVxVHTvNjPyeMoV3hH
        Y+RFCvS92LgPSTEYXAslQML0BsmVpaLVvvBSFFTF7KrCbViPY2SiwTJCC7qmVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pu7D3c8JU8s2gUIpZFKkkhuhamo7U7DI6Vsa8fo2LAE=;
        b=7AnYlwJTLKZQstJG9+wKo8X8zIJlF6PA9T3EfviQXyFHtM+T3MUoTt3M5nLBspCbA+Jex9
        yGA/g+Nt0XUvuUCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Optimize irq_work_single()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160631297234.3364.2065279310175508183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2914b0ba61a9d253535e51af16c7122a8148995d
Gitweb:        https://git.kernel.org/tip/2914b0ba61a9d253535e51af16c7122a8148995d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Jun 2020 22:28:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:49 +01:00

irq_work: Optimize irq_work_single()

Trade one atomic op for a full memory barrier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/irqflags.h |  8 ++++----
 kernel/irq_work.c        | 29 +++++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index fef2d43..8de0e13 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -107,14 +107,14 @@ do {						\
 		  current->irq_config = 0;			\
 	  } while (0)
 
-# define lockdep_irq_work_enter(__work)					\
+# define lockdep_irq_work_enter(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 1;			\
 	  } while (0)
-# define lockdep_irq_work_exit(__work)					\
+# define lockdep_irq_work_exit(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 0;			\
 	  } while (0)
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index fbff25a..e8da1e7 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -34,7 +34,7 @@ static bool irq_work_claim(struct irq_work *work)
 	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
-	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
+	 * The pairing smp_mb() in irq_work_single() makes sure
 	 * everything we did before is visible.
 	 */
 	if (oflags & IRQ_WORK_PENDING)
@@ -136,22 +136,27 @@ void irq_work_single(void *arg)
 	int flags;
 
 	/*
-	 * Clear the PENDING bit, after this point the @work
-	 * can be re-used.
-	 * Make it immediately visible so that other CPUs trying
-	 * to claim that work don't rely on us to handle their data
-	 * while we are in the middle of the func.
+	 * Clear the PENDING bit, after this point the @work can be re-used.
+	 * The PENDING bit acts as a lock, and we own it, so we can clear it
+	 * without atomic ops.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
+	flags = atomic_read(&work->node.a_flags);
+	flags &= ~IRQ_WORK_PENDING;
+	atomic_set(&work->node.a_flags, flags);
+
+	/*
+	 * See irq_work_claim().
+	 */
+	smp_mb();
 
-	lockdep_irq_work_enter(work);
+	lockdep_irq_work_enter(flags);
 	work->func(work);
-	lockdep_irq_work_exit(work);
+	lockdep_irq_work_exit(flags);
+
 	/*
-	 * Clear the BUSY bit and return to the free state if
-	 * no-one else claimed it meanwhile.
+	 * Clear the BUSY bit, if set, and return to the free state if no-one
+	 * else claimed it meanwhile.
 	 */
-	flags &= ~IRQ_WORK_PENDING;
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 
