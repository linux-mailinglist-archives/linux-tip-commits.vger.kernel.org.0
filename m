Return-Path: <linux-tip-commits+bounces-5287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85416AAC5D9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2274B4C459A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22219285406;
	Tue,  6 May 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTNKx2iy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMIFiVd0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F2284693;
	Tue,  6 May 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537631; cv=none; b=GbPvuMAc1Go75XZlo3YlJqv3nfvsyC7ajQpke5mEEjStabnVbvTPXJoONpxvpczX3j49viMIz/rL+xm3RWfZh4luetNG0VO/hUvMhiICf7ckdvlqwQb6iarbCE6GerM616mlWVjuYurc6KXWvbgpc78FvT5h8/ApYi5tkMSFKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537631; c=relaxed/simple;
	bh=i47geymWLtW2l/lgDtEWySoktdnpduEpUlmCvUhmeZo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uFz8ywaoigox5pDz1BuvSx1SQGsJ3S5XU/veAauDYtYDgu7WcHiF6wp0CJDylr/47nFy8vsKmWa4aXOPdH2eTN2KF+6vj1Hm/YgKl/Gn8jFqwxgWVfuNp/Adzg7Z3pjS4qSfi0cquwCR/9feMFbQ6wCkOvGNZePPr5NuMgX1pUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTNKx2iy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMIFiVd0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt/yYsVl96tDcBNZwaMC6t5aS5jq8P08zJkcZgpKbmU=;
	b=iTNKx2iyogax0CS42HttHtAnW/XjrCwMXsr5FfknL1qgef8yqteEjePOgbxHB7bKCaKzKZ
	5R21ijkkDw6/aVRArFOLxQKc0Mm7fUPQST0sPDmB0Dfu71sip4x4mzHTHoE1MOgvHx7y5i
	WAlMcKGTzuEsEP67m4hT4YRuTpwjUcU33UVJxvwjymaDBkQzsxqIF/Ze1GwPrq1yDEC4MR
	OtvPH9o1qa4War3MWpmtbb36jHfAtbyohQrdI1d2Gkc+gOd09qZhR+LMITviMcrkNs5Isn
	6Gm0m1yHw3ZKlRmC88Xh8ZXpmMGS8/kgzPVb72TX0Bojw7g5wJx2YofPi45UGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt/yYsVl96tDcBNZwaMC6t5aS5jq8P08zJkcZgpKbmU=;
	b=DMIFiVd0dNvnFKcNx7j6svxVcCssknF+OWAF3iZuT08k8PQb4PwLIRzq4I1eiC8es+JvgN
	PR0iaREt408XyeCg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] sh: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-34-jirislaby@kernel.org>
References: <20250319092951.37667-34-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762615.406.12105262370963935672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     efab433e07f16f16f94aa9df32a31230be8edad3
Gitweb:        https://git.kernel.org/tip/efab433e07f16f16f94aa9df32a31230be8edad3
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:07 +02:00

sh: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-34-jirislaby@kernel.org

---
 arch/sh/boards/mach-se/7343/irq.c  | 5 +++--
 arch/sh/boards/mach-se/7722/irq.c  | 2 +-
 arch/sh/boards/mach-x3proto/gpio.c | 2 +-
 drivers/sh/intc/irqdomain.c        | 5 ++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index f9f3b14..8241bde 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -47,8 +47,9 @@ static void __init se7343_domain_init(void)
 {
 	int i;
 
-	se7343_irq_domain = irq_domain_add_linear(NULL, SE7343_FPGA_IRQ_NR,
-						  &irq_domain_simple_ops, NULL);
+	se7343_irq_domain = irq_domain_create_linear(NULL, SE7343_FPGA_IRQ_NR,
+						     &irq_domain_simple_ops,
+						     NULL);
 	if (unlikely(!se7343_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
 		return;
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index efa96ed..9a460a8 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -46,7 +46,7 @@ static void __init se7722_domain_init(void)
 {
 	int i;
 
-	se7722_irq_domain = irq_domain_add_linear(NULL, SE7722_FPGA_IRQ_NR,
+	se7722_irq_domain = irq_domain_create_linear(NULL, SE7722_FPGA_IRQ_NR,
 						  &irq_domain_simple_ops, NULL);
 	if (unlikely(!se7722_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f82d3a6..c13d51b 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -108,7 +108,7 @@ int __init x3proto_gpio_setup(void)
 	if (unlikely(ret))
 		goto err_gpio;
 
-	x3proto_irq_domain = irq_domain_add_linear(NULL, NR_BASEBOARD_GPIOS,
+	x3proto_irq_domain = irq_domain_create_linear(NULL, NR_BASEBOARD_GPIOS,
 						   &x3proto_gpio_irq_ops, NULL);
 	if (unlikely(!x3proto_irq_domain))
 		goto err_irq;
diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c..ed7a570 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -59,10 +59,9 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 	 * tree penalty for linear cases with non-zero hwirq bases.
 	 */
 	if (irq_base == 0 && irq_end == (irq_base + hw->nr_vectors - 1))
-		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
-						  &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_linear(NULL, hw->nr_vectors, &intc_evt_ops, NULL);
 	else
-		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_tree(NULL, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
 }

