Return-Path: <linux-tip-commits+bounces-5315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA4AAC75D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D630464C13
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEAD281374;
	Tue,  6 May 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKwlPaa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dC45q5M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0BE280CE7;
	Tue,  6 May 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540269; cv=none; b=F94wyJfdzyHBkiMyUa2pJE8zclpZgowgH9xZcKKlG7RQAokKK5x7LUtZDkMOSvQnc/MKxR+cHgKCDav4h3paegrHNiCxBNVfKyl5Nhg4sfP07cm16CDky6t+LAUwd6pBAKjjNqeVxELZNsvqmGvp3V7OJw7BTvdMqriuF8Qio/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540269; c=relaxed/simple;
	bh=W6dfSad2uy5WnlRA97aDoDQm1eGWo3XNY+IkBZEd4cE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UpM5u2dMrry7xfXeeYYq2B8wRjsSbxSPW0RD1GLzvUDyaFCV9fDanfsIwdpDH36BEOI7ezm3HB/VNfYxhMYsStX69NQHGVcfgFJUTYz8v0S4tfFOwDW9Sy3nEzxtFwn0yvKnPXXQApeW7azsBrU5tTuqcXw2CENrX4tfBzp+eKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKwlPaa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dC45q5M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 14:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746540266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PpvyVQeOjMM3o+aZNLl7eBcR/6aJlqx+7G+r6CDzHE=;
	b=PKwlPaa0A/6BAsMYI/LwS10UhVu5DituCH5rSsUtvUyG+xmdsDxefL7NlqukuULWJP+C/e
	2Ua+mlBgyh5d2XXhukBg5Vmf/SKyYAluG8IQIEwULDeKgAYIYkSQ5wVW4ADBdQiZVDjUxJ
	GUghvYX3LyWbd4Wk7oKzGj7YvhyxO/QLAushuujJnj0O83dQKuh5O+KOuFkiaaOE8rRWl3
	dPlZ8RTgXFpcE2FSUtvvmINlRB43bxe7lEmu23nyn4S703OE5nZq/5jcKQcNdW7CbWJWZq
	90mgu1XP+9yJIyeLEyzXjOXKVUm8HjUm+eRHkrfag28Ssdbk8C9QgQYz0FNMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746540266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PpvyVQeOjMM3o+aZNLl7eBcR/6aJlqx+7G+r6CDzHE=;
	b=9dC45q5MBfYj0iM2jI1NM8+0WW1rX065y0wANFFsAUbC0IGOLvLrgEzY7VsxuIj048fJ7i
	PwsfOhlh7E5zRYDA==
From: "tip-bot2 for Alexey Charkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-vt8500: Use a dedicated chained
 handler function
Cc: Alexey Charkov <alchark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506-vt8500-intc-updates-v2-4-a3a0606cf92d@gmail.com>
References: <20250506-vt8500-intc-updates-v2-4-a3a0606cf92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654026539.406.15907785585373973018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     49f92d3859cdd8534a1cd15037f950c483a5de40
Gitweb:        https://git.kernel.org/tip/49f92d3859cdd8534a1cd15037f950c483a5de40
Author:        Alexey Charkov <alchark@gmail.com>
AuthorDate:    Tue, 06 May 2025 16:46:17 +04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 15:58:26 +02:00

irqchip/irq-vt8500: Use a dedicated chained handler function

Current code for the chained interrupt controller maps its interrupts on
the parent but doesn't register a separate chained handler, instead
needlessly calling enable_irq() on an unactivated parent interrupt, causing
a boot time WARN_ON from the common code.

The common handler meanwhile loops through all registered interrupt
controllers in an arbitrary order and tries to handle active interrupts
in each of them, which is fragile.

Use common infrastructure for handling chained interrupts instead.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250506-vt8500-intc-updates-v2-4-a3a0606cf92d@gmail.com

---
 drivers/irqchip/irq-vt8500.c | 59 +++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index debca89..15134cb 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
@@ -66,6 +67,8 @@ struct vt8500_irq_data {
 /* Global variable for accessing io-mem addresses */
 static struct vt8500_irq_data intc[VT8500_INTC_MAX];
 static u32 active_cnt = 0;
+/* Primary interrupt controller data */
+static struct vt8500_irq_data *primary_intc;
 
 static void vt8500_irq_ack(struct irq_data *d)
 {
@@ -163,28 +166,38 @@ static const struct irq_domain_ops vt8500_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+static inline void vt8500_handle_irq_common(struct vt8500_irq_data *intc)
+{
+	unsigned long irqnr = readl_relaxed(intc->base) & 0x3F;
+	unsigned long stat;
+
+	/*
+	 * Highest Priority register default = 63, so check that this
+	 * is a real interrupt by checking the status register
+	 */
+	if (irqnr == 63) {
+		stat = readl_relaxed(intc->base + VT8500_ICIS + 4);
+		if (!(stat & BIT(31)))
+			return;
+	}
+
+	generic_handle_domain_irq(intc->domain, irqnr);
+}
+
 static void __exception_irq_entry vt8500_handle_irq(struct pt_regs *regs)
 {
-	u32 stat, i;
-	int irqnr;
-	void __iomem *base;
-
-	/* Loop through each active controller */
-	for (i=0; i<active_cnt; i++) {
-		base = intc[i].base;
-		irqnr = readl_relaxed(base) & 0x3F;
-		/*
-		  Highest Priority register default = 63, so check that this
-		  is a real interrupt by checking the status register
-		*/
-		if (irqnr == 63) {
-			stat = readl_relaxed(base + VT8500_ICIS + 4);
-			if (!(stat & BIT(31)))
-				continue;
-		}
+	vt8500_handle_irq_common(primary_intc);
+}
 
-		generic_handle_domain_irq(intc[i].domain, irqnr);
-	}
+static void vt8500_handle_irq_chained(struct irq_desc *desc)
+{
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct vt8500_irq_data *intc = d->host_data;
+
+	chained_irq_enter(chip, desc);
+	vt8500_handle_irq_common(intc);
+	chained_irq_exit(chip, desc);
 }
 
 static int __init vt8500_irq_init(struct device_node *node,
@@ -212,8 +225,6 @@ static int __init vt8500_irq_init(struct device_node *node,
 		goto out;
 	}
 
-	set_handle_irq(vt8500_handle_irq);
-
 	vt8500_init_irq_hw(intc[active_cnt].base);
 
 	pr_info("vt8500-irq: Added interrupt controller\n");
@@ -224,10 +235,14 @@ static int __init vt8500_irq_init(struct device_node *node,
 	if (of_irq_count(node) != 0) {
 		for (i = 0; i < of_irq_count(node); i++) {
 			irq = irq_of_parse_and_map(node, i);
-			enable_irq(irq);
+			irq_set_chained_handler_and_data(irq, vt8500_handle_irq_chained,
+							 &intc[active_cnt]);
 		}
 
 		pr_info("vt8500-irq: Enabled slave->parent interrupts\n");
+	} else {
+		primary_intc = &intc[active_cnt];
+		set_handle_irq(vt8500_handle_irq);
 	}
 out:
 	return 0;

