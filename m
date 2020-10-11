Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DD28A8B7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbgJKR6N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388531AbgJKR5u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:50 -0400
Date:   Sun, 11 Oct 2020 17:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8DudYgSkM2D0VuamNCrK3pYx1IForzwit4mo4/gaACA=;
        b=0l06sRemV7ct9IiXV4GIUw/47uNEEbCPKZFJ/1OuNyL3X/JVFonoc4y3gz5ETa+KCeomaD
        NO8k9iTHtwygl7D0S3Ty3Gx48xgVMDiMLbLk8ym7bS2KsWP42nLvIOZM5dQpX+MPRZaSr/
        C8qS43+WGZO3tvg/gvOllOs4oOn6/sln3os9cW3woHiFOBeEakMOhd2wvwQxsWglk0CmlK
        o8dqMRnGcvnQhgHICrbo1husxiv4T5/wiERgiqF6Z8YlbX+E/GHezCLrdw9pXtloWJwBdX
        xlYXwVT4ZaeOT+uI/9zO87NX9olOi9Im1ahIUQQBey8MDfnWsHBmNlSpQcjGGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8DudYgSkM2D0VuamNCrK3pYx1IForzwit4mo4/gaACA=;
        b=vovOB/cdbHrBjXjXO7AChNmdSwiYfvSXQZcw7MeI6HQ5RuOQcrRjkwX/oZCavEmrbtlpGc
        /3xILrQWHFQhxqBw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Walk the irq_data hierarchy when resending an
 interrupt
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906784.7002.10488063746795323213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cd1752d34ef33d68d82ef9dcc699b4eaa17c07fc
Gitweb:        https://git.kernel.org/tip/cd1752d34ef33d68d82ef9dcc699b4eaa17c07fc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 26 Aug 2020 18:37:50 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Sep 2020 18:25:23 +01:00

genirq: Walk the irq_data hierarchy when resending an interrupt

On resending an interrupt, we only check the outermost irqchip for
a irq_retrigger callback. However, this callback could be implemented
at an inner level. Use irq_chip_retrigger_hierarchy() in this case.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/resend.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index c48ce19..8ccd32a 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -86,6 +86,18 @@ static int irq_sw_resend(struct irq_desc *desc)
 }
 #endif
 
+static int try_retrigger(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_retrigger)
+		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irq_chip_retrigger_hierarchy(&desc->irq_data);
+#else
+	return 0;
+#endif
+}
+
 /*
  * IRQ resend
  *
@@ -113,8 +125,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
 
 	desc->istate &= ~IRQS_PENDING;
 
-	if (!desc->irq_data.chip->irq_retrigger ||
-	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+	if (!try_retrigger(desc))
 		err = irq_sw_resend(desc);
 
 	/* If the retrigger was successfull, mark it with the REPLAY bit */
