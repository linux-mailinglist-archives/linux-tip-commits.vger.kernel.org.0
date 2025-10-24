Return-Path: <linux-tip-commits+bounces-6992-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F51C07EE9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60D81AA51CD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D782C0323;
	Fri, 24 Oct 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Qw7/0FR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7v9h8va"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2B2C026D;
	Fri, 24 Oct 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334774; cv=none; b=EG1pM83pZc1w8Ss+RiscAh/7Y2mNJ4lr/adq5WkOaA5YEhpPzMcZ5voYdOOSXh2Gg0kj9B3akfsNElwDIVjjOa+z6AOOqieT1cBfyI77peMLsPsShCfMnOS0cqPkcIHkx62fjIQAo8pLLwN6m8McmwJXaFQeXH3ni54PA01DpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334774; c=relaxed/simple;
	bh=On5izLQ/YlmnQ7Fcw/gdc8KmrsRYdbEh6A4+KGqz85U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=paLc1zIvywj0n3ry56vDw3/UHgSITLCy98mMrOFmEnRgBbzK5+ZmuY4yufkWa01OSs8xzJK4qBElIfugYw4myyPrnKbmHwvXiCcG1Z4NaJW2tQXKUuVEdCKIpWV7Ts2OQ33kgTTmK4VIZnl2TpKmu/KntV+poC1U5T+YPqfXsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Qw7/0FR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7v9h8va; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 19:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761334770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IuTJ2Bp79Kamo9ndCp3m3ejE0b7ItpLYkuRjjjTj8c=;
	b=2Qw7/0FRuZLLJGQ0l3pAUaq9tCgU9iVt+q3al6WlLBhzZ/RTKFdTQ5Ejp8AYjr0LLbciOy
	Wu52VpnHH0wjj1rGA6MnAsqV3qsc0/LSPNkT2UtJonMCtoWVZJFpoGer6umvW2+SuQdAMO
	6laBpbx+8tABpPS3OWRWMIetAlEAJovF2r+wQW/a195XNV6meF/ZG0u9Sly0ZxNZNMWDwK
	N+3vPa8ivy02X+bb7Y6FbTF8TVSK1FvZdXg8UVLqw3Awe3Q3dZpOjX15xfHZlMzxWWruuT
	zvoxHt21HJYG5SSAmV0aZpJvuIDRMSMmkZVHh1m/Q5AFsQBpS/wMwZDeHylNgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761334770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IuTJ2Bp79Kamo9ndCp3m3ejE0b7ItpLYkuRjjjTj8c=;
	b=K7v9h8vaDm8/d7xoiUNJlhjPdqXCfbCzz1ypZQKRR3CJZa99v0WF0d9UdWked0yOLMw+48
	AlDaRo5GP1Sud5Cw==
From: "tip-bot2 for Charles Mirabile" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/sifive-plic: Cache the interrupt enable state
Cc: Charles Mirabile <cmirabil@redhat.com>,
 Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251024083647.475239-4-lzampier@redhat.com>
References: <20251024083647.475239-4-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133476873.2601451.10215997570733785792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     14ff9e54dd14339776afff78e2d29e0edb3a4402
Gitweb:        https://git.kernel.org/tip/14ff9e54dd14339776afff78e2d29e0edb3=
a4402
Author:        Charles Mirabile <cmirabil@redhat.com>
AuthorDate:    Fri, 24 Oct 2025 09:36:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 21:34:32 +02:00

irqchip/sifive-plic: Cache the interrupt enable state

Optimize the PLIC driver by maintaining the interrupt enable state in the
handler's enable_save array during normal operation rather than only during
suspend/resume. This eliminates the need to read enable registers during
suspend and makes the enable state immediately available for other
purposes.

Let __plic_toggle() update both the hardware registers and the cached
enable_save state atomically within the existing enable_lock protection.

That allows to remove the suspend-time enable register reading since
handler::enable_save now always reflects the current state.

[ tglx: Massaged change log ]

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024083647.475239-4-lzampier@redhat.com
---
 drivers/irqchip/irq-sifive-plic.c | 36 ++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index cbd7697..d518a8b 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -94,15 +94,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
=20
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
=20
-static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
+static void __plic_toggle(struct plic_handler *handler, int hwirq, int enabl=
e)
 {
-	u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *base =3D handler->enable_base;
 	u32 hwirq_mask =3D 1 << (hwirq % 32);
+	int group =3D hwirq / 32;
+	u32 value;
+
+	value =3D readl(base + group);
=20
 	if (enable)
-		writel(readl(reg) | hwirq_mask, reg);
+		value |=3D hwirq_mask;
 	else
-		writel(readl(reg) & ~hwirq_mask, reg);
+		value &=3D ~hwirq_mask;
+
+	handler->enable_save[group] =3D value;
+	writel(value, base + group);
 }
=20
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
@@ -110,7 +117,7 @@ static void plic_toggle(struct plic_handler *handler, int=
 hwirq, int enable)
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&handler->enable_lock, flags);
-	__plic_toggle(handler->enable_base, hwirq, enable);
+	__plic_toggle(handler, hwirq, enable);
 	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
=20
@@ -247,33 +254,16 @@ static int plic_irq_set_type(struct irq_data *d, unsign=
ed int type)
=20
 static int plic_irq_suspend(void)
 {
-	unsigned int i, cpu;
-	unsigned long flags;
-	u32 __iomem *reg;
 	struct plic_priv *priv;
=20
 	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
=20
 	/* irq ID 0 is reserved */
-	for (i =3D 1; i < priv->nr_irqs; i++) {
+	for (unsigned int i =3D 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
=20
-	for_each_present_cpu(cpu) {
-		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
-
-		if (!handler->present)
-			continue;
-
-		raw_spin_lock_irqsave(&handler->enable_lock, flags);
-		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
-			reg =3D handler->enable_base + i * sizeof(u32);
-			handler->enable_save[i] =3D readl(reg);
-		}
-		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
-	}
-
 	return 0;
 }
=20

