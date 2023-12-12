Return-Path: <linux-tip-commits+bounces-18-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4980EF57
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1849E1F2150D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23180745D7;
	Tue, 12 Dec 2023 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zfsLQsc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vd+sjz6P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FCD5;
	Tue, 12 Dec 2023 06:52:41 -0800 (PST)
Date: Tue, 12 Dec 2023 14:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702392760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z8tpZKqZ4UtXMm//5sO6ZKH1IbaOHgpQQp7lY2ai5U=;
	b=3zfsLQscP/6RK9Dr7FHmjpSo+JO0zkF+VZVtR/iToB6gwWwGTko7C6o4yctrhDyUstTmNt
	i4/5s9aNQtp8HHW2BAoauk3T6aZKsa6gJVCtc4w+BVzYDNQkIrVJt+FL+yfL69QHvLJJ/8
	PmFQEf6UA7o7u5BfMN2J0UYiiyLSORhVQFSsS6ZLCcyZn011MZ3VaAbEfEMKw6Owgq3vZ9
	UP8lrYcDke70mSH6gVC36KO2AQ+gcfcCMM2w1FFpX3mXzuiqQ0eRSby/BK92lNpXPRPrVG
	6UT3S4ARoaRDV+tyqFInoYCP0QWi071/z0hmh5j9s2iEMoG435qtkhZAVEN0KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702392760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z8tpZKqZ4UtXMm//5sO6ZKH1IbaOHgpQQp7lY2ai5U=;
	b=Vd+sjz6PcIbYtijpY7NH47GvJWvwifNCec8CA7txEFDPVhky3UxDo63BtQyLSoWYb4mbmx
	nW6hsz5PtOSE/LDQ==
From: "tip-bot2 for Max Filippov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-xtensa-pic: Clean up
Cc: Max Filippov <jcmvbkbc@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231208163857.82644-1-jcmvbkbc@gmail.com>
References: <20231208163857.82644-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170239275928.398.14591907265015447414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     69ffab9b9e698248cbb4042e47f82afb00dc1bb4
Gitweb:        https://git.kernel.org/tip/69ffab9b9e698248cbb4042e47f82afb00dc1bb4
Author:        Max Filippov <jcmvbkbc@gmail.com>
AuthorDate:    Fri, 08 Dec 2023 08:38:57 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:45:39 +01:00

irqchip/irq-xtensa-pic: Clean up

  - get rid of the cached_irq_mask variable
  - use BIT() macro instead of bit shifts
  - drop .disable and .enable as they are equivalent to the default
    implementations

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231208163857.82644-1-jcmvbkbc@gmail.com
---
 drivers/irqchip/irq-xtensa-pic.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index 0c18d1f..f9d6fce 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -12,6 +12,7 @@
  * Kevin Chea
  */
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
@@ -19,8 +20,6 @@
 #include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
 
-unsigned int cached_irq_mask;
-
 /*
  * Device Tree IRQ specifier translation function which works with one or
  * two cell bindings. First cell value maps directly to the hwirq number.
@@ -44,34 +43,30 @@ static const struct irq_domain_ops xtensa_irq_domain_ops = {
 
 static void xtensa_irq_mask(struct irq_data *d)
 {
-	cached_irq_mask &= ~(1 << d->hwirq);
-	xtensa_set_sr(cached_irq_mask, intenable);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_unmask(struct irq_data *d)
-{
-	cached_irq_mask |= 1 << d->hwirq;
-	xtensa_set_sr(cached_irq_mask, intenable);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask &= ~BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
 }
 
-static void xtensa_irq_enable(struct irq_data *d)
+static void xtensa_irq_unmask(struct irq_data *d)
 {
-	xtensa_irq_unmask(d);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_disable(struct irq_data *d)
-{
-	xtensa_irq_mask(d);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask |= BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
 }
 
 static void xtensa_irq_ack(struct irq_data *d)
 {
-	xtensa_set_sr(1 << d->hwirq, intclear);
+	xtensa_set_sr(BIT(d->hwirq), intclear);
 }
 
 static int xtensa_irq_retrigger(struct irq_data *d)
 {
-	unsigned int mask = 1u << d->hwirq;
+	unsigned int mask = BIT(d->hwirq);
 
 	if (WARN_ON(mask & ~XCHAL_INTTYPE_MASK_SOFTWARE))
 		return 0;
@@ -81,8 +76,6 @@ static int xtensa_irq_retrigger(struct irq_data *d)
 
 static struct irq_chip xtensa_irq_chip = {
 	.name		= "xtensa",
-	.irq_enable	= xtensa_irq_enable,
-	.irq_disable	= xtensa_irq_disable,
 	.irq_mask	= xtensa_irq_mask,
 	.irq_unmask	= xtensa_irq_unmask,
 	.irq_ack	= xtensa_irq_ack,

