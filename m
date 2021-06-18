Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD13AC9C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhFRL0R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbhFRL0P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:15 -0400
Date:   Fri, 18 Jun 2021 11:24:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5SoUWDYEEesq6lJg5LH+dbuXXp5oeoo1vInVRnjWwQ=;
        b=0kwpphozppsXYnUB7u9MO770ehVQsYEAfohFQY70wp1hbSuA5l2K/8xPqhMFxEIF+iCV3U
        X1wYG5BtBITuM21WM+6uBaheW5Xk3SrUK3noDsZrPcgC3N9QWGOLszAA7M5Uw1mgIMpOWF
        EaJNNSxM3qVJCA7ZxCq0TDPH6PEBXqTn/j7TsoKyloBZwZn1bY63Ssk8jHO8QBVknkH7FY
        cu6UfEzeE0v2OheN1JjKnrvm/g5TNljEm/LWl+aph2k1tVYDG/3DJRoJU5z0qAxfAvDOKl
        cXsmNq+kXQYivGtAjJNUBFWUT0H6/YScOc+XQKQXilfvYMLIY2C+CoRlFBxB5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5SoUWDYEEesq6lJg5LH+dbuXXp5oeoo1vInVRnjWwQ=;
        b=bTieEDDDMzz3YyrQwg046tTabgqSgYKm06xMTBygULMp/+iuRHETK60ahC4iVCH6ME8dAb
        TpcJucVHDQtwm0Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Unbreak wakeups
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.160855222@infradead.org>
References: <20210611082838.160855222@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544513.19906.5579522519263051079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     37aadc687ab441bbcb693ddae613acf9afcea1ab
Gitweb:        https://git.kernel.org/tip/37aadc687ab441bbcb693ddae613acf9afcea1ab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:06 +02:00

sched: Unbreak wakeups

Remove broken task->state references and let wake_up_process() DTRT.

The anti-pattern in these patches breaks the ordering of ->state vs
COND as described in the comment near set_current_state() and can lead
to missed wakeups:

	(OoO load, observes RUNNING)<-.
	for (;;) {                    |
	  t->state = UNINTERRUPTIBLE; |
	  smp_mb();          ,----->  | (observes !COND)
                             |        /
	  if (COND) ---------'       |	COND = 1;
		break;		     `- if (t->state != RUNNING)
					  wake_up_process(t); // not done
	  schedule(); // forever waiting
	}
	t->state = TASK_RUNNING;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210611082838.160855222@infradead.org
---
 drivers/net/ethernet/qualcomm/qca_spi.c |  6 ++----
 drivers/usb/gadget/udc/max3420_udc.c    | 15 +++++----------
 drivers/usb/host/max3421-hcd.c          |  3 +--
 kernel/softirq.c                        |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index ab9b025..0a6b811 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -653,8 +653,7 @@ qcaspi_intr_handler(int irq, void *data)
 	struct qcaspi *qca = data;
 
 	qca->intr_req++;
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return IRQ_HANDLED;
@@ -777,8 +776,7 @@ qcaspi_netdev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netif_trans_update(dev);
 
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 3517954..34f4db5 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -509,8 +509,7 @@ static irqreturn_t max3420_vbus_handler(int irq, void *dev_id)
 			     ? USB_STATE_POWERED : USB_STATE_NOTATTACHED);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -529,8 +528,7 @@ static irqreturn_t max3420_irq_handler(int irq, void *dev_id)
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -1093,8 +1091,7 @@ static int max3420_wakeup(struct usb_gadget *gadget)
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 	return ret;
 }
@@ -1117,8 +1114,7 @@ static int max3420_udc_start(struct usb_gadget *gadget,
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
@@ -1137,8 +1133,7 @@ static int max3420_udc_stop(struct usb_gadget *gadget)
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index afd9174..e7a8e06 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1169,8 +1169,7 @@ max3421_irq_handler(int irq, void *dev_id)
 	struct spi_device *spi = to_spi_device(hcd->self.controller);
 	struct max3421_hcd *max3421_hcd = hcd_to_max3421(hcd);
 
-	if (max3421_hcd->spi_thread &&
-	    max3421_hcd->spi_thread->state != TASK_RUNNING)
+	if (max3421_hcd->spi_thread)
 		wake_up_process(max3421_hcd->spi_thread);
 	if (!test_and_set_bit(ENABLE_IRQ, &max3421_hcd->todo))
 		disable_irq_nosync(spi->irq);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4992853..5ddc3b1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -76,7 +76,7 @@ static void wakeup_softirqd(void)
 	/* Interrupts are disabled: no need to stop preemption */
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
 
-	if (tsk && tsk->state != TASK_RUNNING)
+	if (tsk)
 		wake_up_process(tsk);
 }
 
