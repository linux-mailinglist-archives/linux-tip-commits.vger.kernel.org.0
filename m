Return-Path: <linux-tip-commits+bounces-3395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD6A39661
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E872188B280
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622322D7BD;
	Tue, 18 Feb 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aP6iSxdH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5DVWDbWV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71ED1B983E;
	Tue, 18 Feb 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869429; cv=none; b=BIbqVTmDDAARsontuhV97SgmQ92XeU/7E5P0S8tUQB+EIJoO2y3YdUwR1RDliIKdfBGNK5DuICd2iyniYdSB7+sKj0uC82fs0Ez8fMzS07xSlT7PBaNnu1wcZsbX64rng6zGSgisIYHcf3SX3h9SC0Y0KuQH8/+Q6vtY5brlfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869429; c=relaxed/simple;
	bh=R6HFuTbkPNvCsFlkMkDeGH5kVhibZ0QoZDfJU9LgQOM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pY8L5UMvwbE9UisL4excfhIGXP6UntyUm8qMmPC6Fyu2cRQXv6jtnc0v7qs1ugYcsVM2AAEOVn7CA7aqbq7/RrUVXsIBybW+uWhwH7ilLO4UzE2zel7cIV/CWca/LlcWkUHlZTPe4z0Aocj1khpAwzfPz4tD9Lb+4fa1K0T7mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aP6iSxdH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5DVWDbWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:03:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeFmSESzqM/prt/lhSjzfju8D291RT8dTs2DGdfM6TQ=;
	b=aP6iSxdHOrguPZsN4ICO46ZP/+T3oEm/6lH0FI1IMy+PtYy7rcSBJZ883g8uve66wdau/j
	0u0iZDFWao8+LR/VclQbVQBahGAZV874a/qXI8Q8E63tyZqEPFP9nqiaMC8KQXwD7i2izl
	B3rgbaE12UJw6Pvrwz+z5wytFvxpj94hZNGbbe+BheUwk4WpwkU4vJljGq4kHly6JMpob4
	guu/FGbJdNf7/ozJMFU9wb1XXys0oXadHSKVh2x4CZXPpkuK3qA7cJulLfUZucQT2W3efV
	6ol+IeFKoQWZja5awbdJ/qJJ6PJlatzqBXMsr/WkX/Ua+VvEfKdbiVdiNzZOHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeFmSESzqM/prt/lhSjzfju8D291RT8dTs2DGdfM6TQ=;
	b=5DVWDbWVW1UgeEWEjvPKVh4zJZn1Ood56ARP2HdyNKvVS1N2gu+9S+bFNQb3Q09Sw6eYap
	ud7AaYp3CKMFuQDA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-imsic: Implement
 irq_force_complete_move() for IMSIC
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-9-apatel@ventanamicro.com>
References: <20250217085657.789309-9-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986942530.10177.15146218685799232683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     947958bcd0b32c8f0acf5e52062a4b6678913dd6
Gitweb:        https://git.kernel.org/tip/947958bcd0b32c8f0acf5e52062a4b6678913dd6
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:54 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:51:02 +01:00

irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC

Implement irq_force_complete_move() for IMSIC driver so that in-flight
vector movements on a CPU can be cleaned-up when the CPU goes down.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-9-apatel@ventanamicro.com

---
 drivers/irqchip/irq-riscv-imsic-platform.c | 32 +++++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.c    | 17 +++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.h    |  1 +-
 3 files changed, 50 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 9a5e7b4..b9e3f90 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -129,6 +129,37 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 
 	return IRQ_SET_MASK_OK_DONE;
 }
+
+static void imsic_irq_force_complete_move(struct irq_data *d)
+{
+	struct imsic_vector *mvec, *vec = irq_data_get_irq_chip_data(d);
+	unsigned int cpu = smp_processor_id();
+
+	if (WARN_ON(!vec))
+		return;
+
+	/* Do nothing if there is no in-flight move */
+	mvec = imsic_vector_get_move(vec);
+	if (!mvec)
+		return;
+
+	/* Do nothing if the old IMSIC vector does not belong to current CPU */
+	if (mvec->cpu != cpu)
+		return;
+
+	/*
+	 * The best we can do is force cleanup the old IMSIC vector.
+	 *
+	 * The challenges over here are same as x86 vector domain so
+	 * refer to the comments in irq_force_complete_move() function
+	 * implemented at arch/x86/kernel/apic/vector.c.
+	 */
+
+	/* Force cleanup in-flight move */
+	pr_info("IRQ fixup: irq %d move in progress, old vector cpu %d local_id %d\n",
+		d->irq, mvec->cpu, mvec->local_id);
+	imsic_vector_force_move_cleanup(vec);
+}
 #endif
 
 static struct irq_chip imsic_irq_base_chip = {
@@ -137,6 +168,7 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_unmask		= imsic_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= imsic_irq_set_affinity,
+	.irq_force_complete_move = imsic_irq_force_complete_move,
 #endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 1aeba76..eb0a9b6 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -311,6 +311,23 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	mvec = READ_ONCE(vec->move_prev);
+	WRITE_ONCE(vec->move_prev, NULL);
+	if (mvec)
+		imsic_vector_free(mvec);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
 static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
 				     struct imsic_vector *vec, bool is_old_vec,
 				     bool new_enable, struct imsic_vector *move_vec)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index f02842b..19dea0c 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -91,6 +91,7 @@ static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *ve
 	return READ_ONCE(vec->move_prev);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
 
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);

