Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8979F40F756
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhIQMVW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhIQMVV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:21:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB32C061574;
        Fri, 17 Sep 2021 05:19:59 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:19:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631881197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2s7qTglXSBuvGug7dB5uw5vJhD9pMfjtPCKb7qrxts=;
        b=y0U6tiJTt6ROrZQ3OFODldqZ+leZr05mg0Se4jylJxqcBlK21f4idWkUrmVFXiSxM4/sJT
        8GbgEHA76+AjDkuVcOCqeqnbjmq4kC4pdXD33nUDBZgZf7JoWs3+0mQuRMbW+JqPPogPqe
        LtZbc6lGrnGTrCAOFnKx5s/eKiBXuCHZIxHSh+rYiOspQ51M5Q2bRq8eFlwbFZd7zJjUxK
        aXt9wRZSo8i5F9Qrq9zDsSL07/y3Kj8NAp3u6PxTg5NTI7aSPyOrJdeGdmjZz6lnLlzjUp
        RJpTESOy5SmE13bk6atjXjFLPEVYqIkydGO1r2iW3toYLMEsNTfiRY/LebEvQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631881197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2s7qTglXSBuvGug7dB5uw5vJhD9pMfjtPCKb7qrxts=;
        b=TWmPVpCpJxKmix8PBNGN/5d5WOQWfaN228tULPS0N+zZWyATfW/HWBWDGTiRCZTbybfjac
        OAw03xpsikwBjGDA==
From:   "tip-bot2 for Josh Cartwright" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Update irq_set_irqchip_state documentation
Cc:     Josh Cartwright <joshc@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210917103055.92150-1-bigeasy@linutronix.de>
References: <20210917103055.92150-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163188119618.25758.16760455206397555458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e1a6af4b000c39148ab407362fcce3ab63b186f2
Gitweb:        https://git.kernel.org/tip/e1a6af4b000c39148ab407362fcce3ab63b186f2
Author:        Josh Cartwright <joshc@ni.com>
AuthorDate:    Fri, 17 Sep 2021 12:30:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Sep 2021 14:15:21 +02:00

genirq: Update irq_set_irqchip_state documentation

On RT kernels, the use of migrate_disable()/migrate_enable() is sufficient
to guarantee a task isn't moved to another CPU.  Update the
irq_set_irqchip_state() documentation to reflect this.

Signed-off-by: Josh Cartwright <joshc@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210917103055.92150-1-bigeasy@linutronix.de

---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 27667e8..b392483 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2827,7 +2827,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	This call sets the internal irqchip state of an interrupt,
  *	depending on the value of @which.
  *
- *	This function should be called with preemption disabled if the
+ *	This function should be called with migration disabled if the
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
