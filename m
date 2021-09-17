Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A490B40F8F0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhIQNSl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhIQNSl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 09:18:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF5C061574;
        Fri, 17 Sep 2021 06:17:19 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631884638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewnHYro6uaY+5l5yUUr1AOc7s6xZ1HuPk8C4Qes+wro=;
        b=TqKTZYPlLxANSHncdrhyElA/dZx6D2VgYm1CgI2XOe1PYVxa7/ers9aF/b6gGD0uBPUWA4
        zF9xLt4PFSt2gFwAKk2J9Wx8eSPZL2op9O8FJWNPbxLjMqC7ZemrAqJERpIz1rrfDkZWub
        dNp/G85FrkvSVVnOdYTIZHH42Sr3VjLhAZYzhw/bufIb4O4R3x3Ze8cw6r1S6IfcT+j0xn
        c3ypY8LgMF7hV9bHN8LI9tck8g1q7xKJNQs72ZK3rFr/d7ioLb084PO7zwUggKk6t6GMI3
        Y230yDn5AHRf4PYVHBlrTNk7MoZgN/21I7sI5CEex2rvzacC/3ZPRYSE0NBp6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631884638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewnHYro6uaY+5l5yUUr1AOc7s6xZ1HuPk8C4Qes+wro=;
        b=0ZJigEdCOBK3OidM/989DGWFv7nPOTG83YSpKRFjFxjF5PzOYUGgFX0KXxZyuCTZzz78So
        BAek1BJDbdrqzOCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move prio assignment into the newly created thread
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
References: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
MIME-Version: 1.0
Message-ID: <163188463696.25758.6952810439232292789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e739f98b4b11337a4e3865364b8922a9e5ad32b6
Gitweb:        https://git.kernel.org/tip/e739f98b4b11337a4e3865364b8922a9e5ad32b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Nov 2020 12:38:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:22 +02:00

genirq: Move prio assignment into the newly created thread

With enabled threaded interrupts the nouveau driver reported the
following:

| Chain exists of:
|   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
|
|  Possible unsafe locking scenario:
|
|        CPU0                    CPU1
|        ----                    ----
|   lock(&cpuset_rwsem);
|                                lock(&device->mutex);
|                                lock(&cpuset_rwsem);
|   lock(&mm->mmap_lock#2);

The device->mutex is nvkm_device::mutex.

Unblocking the lockchain at `cpuset_rwsem' is probably the easiest
thing to do.  Move the priority assignment to the start of the newly
created thread.

Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: Patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b392483..7405e38 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1259,6 +1259,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
 
+	sched_set_fifo(current);
+
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
 					   &action->thread_flags))
 		handler_fn = irq_forced_thread_fn;
@@ -1424,8 +1426,6 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_set_fifo(t);
-
 	/*
 	 * We keep the reference to the task struct even if
 	 * the thread dies to avoid that the interrupt code
