Return-Path: <linux-tip-commits+bounces-3531-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53015A3DCBD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D1017F51C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F21FCCFF;
	Thu, 20 Feb 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYa5vCw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5m67Jh78"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A851FBC8A;
	Thu, 20 Feb 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061602; cv=none; b=V8puCukiYr5ej8taEtus7e6Aol2M5dbbKsRd9jNEPOrgE25d2JCgi4HPkEh2dLeSCqEFZKjo5EBiXPUhJFA8vOHTc4+fGA7G2Vpw8NQp9QfedL3uIHZ2YjKwR+IMx+RGiWo8DunrZibO4NHsHDUnNSmg2VeEv35c/yhcR5t7KdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061602; c=relaxed/simple;
	bh=OF98GBJKSuLpSqwLScNnzzcbnXuhYpEJhjsfgrna0ss=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rgAHEVpvG3BX93dcYo/9AGR6BtxwBMRyG+m8S9a3E8QoqWQAghxbscYUBrv0kPxX11I6vzIkpeNF0rz53AkuNYwlQEPn6r86L22w94B0V9Wo9/wzCL2rKrihLYIzd9SyXL5zQp1mrNXis7Nec/wO3q44Io0QljjnUJ6oz6p9I3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYa5vCw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5m67Jh78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 14:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M56ocqbE/O7hOZQQVgHROUzoK004e2cyL69pw2xbHUE=;
	b=gYa5vCw2P7oV2+II8wumj1VKlPRO5rLnObYjZ2zLkwMI4Adr3nl3wzUALDM4CQNX/SXR2T
	rpeElzoIvd4OXWxo7mm+7eHY6GbPyA0/ZnVfErUFXOdJQcAC8hXInlUyijkc9Grvqon1HS
	g7/QbtqziJC9TBqhG4ourQWax676mvmNq63hjd4bekBro3oNZxuxP/4PKd+ib72sTrxZws
	0jnuMivEgXw14BpfY5MFLOjHWECuZhzitr/J8pF34II5yE7tzx/7zfFZU44pDDwICpifLv
	wjSaE18gAZ5MA0WRWKTWJ7NnZWaFxR9cIVyc5odXeT8O3tv8u9mKIJvh7Q7Fsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M56ocqbE/O7hOZQQVgHROUzoK004e2cyL69pw2xbHUE=;
	b=5m67Jh78gufWES9sdugSM2j6LcdC4qZCneQLfKQnK4I836zlsXcjU37rgEmgM8wRS9ZYcZ
	3ANHLPRUAxafZ3BQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-imsic: Separate next and previous
 pointers in IMSIC vector
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-8-apatel@ventanamicro.com>
References: <20250217085657.789309-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174006159848.10177.152687308645350933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     0f67911e821c67ecfccc365a2103ce276a9a56fe
Gitweb:        https://git.kernel.org/tip/0f67911e821c67ecfccc365a2103ce276a9a56fe
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:53 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2025 15:19:26 +01:00

irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector

Currently, there is only one "move" pointer in struct imsic_vector so
during vector movement the old vector points to the new vector and new
vector points to itself.

To support forced cleanup of the old vector, add separate "move_next" and
"move_prev" pointers to struct imsic_vector, where during vector movement
the "move_next" pointer of the old vector points to the new vector and the
"move_prev" pointer of the new vector points to the old vector.

Both "move_next" and "move_prev" pointers are cleared separately by
__imsic_local_sync() with a restriction that "move_prev" on the new
CPU is cleared only after the old CPU has cleared "move_next".

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-8-apatel@ventanamicro.com


---
 drivers/irqchip/irq-riscv-imsic-early.c |  8 +-
 drivers/irqchip/irq-riscv-imsic-state.c | 96 ++++++++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  7 +-
 3 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index c5c2e69..b5def62 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -77,6 +77,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
+	/*
+	 * Process pending local synchronization instead of waiting
+	 * for per-CPU local timer to expire.
+	 */
+	imsic_local_sync_all(false);
+
 	chained_irq_enter(chip, desc);
 
 	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
@@ -120,7 +126,7 @@ static int imsic_starting_cpu(unsigned int cpu)
 	 * Interrupts identities might have been enabled/disabled while
 	 * this CPU was not running so sync-up local enable/disable state.
 	 */
-	imsic_local_sync_all();
+	imsic_local_sync_all(true);
 
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b97e6cd..1aeba76 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -124,10 +124,11 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, 
 	}
 }
 
-static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
 	struct imsic_local_config *mlocal;
 	struct imsic_vector *vec, *mvec;
+	bool ret = true;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -143,35 +144,75 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 			__imsic_id_clear_enable(i);
 
 		/*
-		 * If the ID was being moved to a new ID on some other CPU
-		 * then we can get a MSI during the movement so check the
-		 * ID pending bit and re-trigger the new ID on other CPU
-		 * using MMIO write.
+		 * Clear the previous vector pointer of the new vector only
+		 * after the movement is complete on the old CPU.
 		 */
-		mvec = READ_ONCE(vec->move);
-		WRITE_ONCE(vec->move, NULL);
-		if (mvec && mvec != vec) {
+		mvec = READ_ONCE(vec->move_prev);
+		if (mvec) {
+			/*
+			 * If the old vector has not been updated then
+			 * try again in the next sync-up call.
+			 */
+			if (READ_ONCE(mvec->move_next)) {
+				ret = false;
+				continue;
+			}
+
+			WRITE_ONCE(vec->move_prev, NULL);
+		}
+
+		/*
+		 * If a vector was being moved to a new vector on some other
+		 * CPU then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU using
+		 * MMIO write.
+		 */
+		mvec = READ_ONCE(vec->move_next);
+		if (mvec) {
 			if (__imsic_id_read_clear_pending(i)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
+			WRITE_ONCE(vec->move_next, NULL);
 			imsic_vector_free(&lpriv->vectors[i]);
 		}
 
 skip:
 		bitmap_clear(lpriv->dirty_bitmap, i, 1);
 	}
+
+	return ret;
 }
 
-void imsic_local_sync_all(void)
+#ifdef CONFIG_SMP
+static void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	if (!timer_pending(&lpriv->timer)) {
+		lpriv->timer.expires = jiffies + 1;
+		add_timer_on(&lpriv->timer, smp_processor_id());
+	}
+}
+#else
+static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+}
+#endif
+
+void imsic_local_sync_all(bool force_all)
 {
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	__imsic_local_sync(lpriv);
+
+	if (force_all)
+		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	if (!__imsic_local_sync(lpriv))
+		__imsic_local_timer_start(lpriv);
+
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
 
@@ -190,12 +231,7 @@ void imsic_local_delivery(bool enable)
 #ifdef CONFIG_SMP
 static void imsic_local_timer_callback(struct timer_list *timer)
 {
-	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	__imsic_local_sync(lpriv);
-	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+	imsic_local_sync_all(false);
 }
 
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
@@ -216,14 +252,11 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu == smp_processor_id()) {
-			__imsic_local_sync(lpriv);
-			return;
+			if (__imsic_local_sync(lpriv))
+				return;
 		}
 
-		if (!timer_pending(&lpriv->timer)) {
-			lpriv->timer.expires = jiffies + 1;
-			add_timer_on(&lpriv->timer, cpu);
-		}
+		__imsic_local_timer_start(lpriv);
 	}
 }
 #else
@@ -278,8 +311,9 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
-static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsic_vector *vec,
-				     bool new_enable, struct imsic_vector *new_move)
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
+				     struct imsic_vector *vec, bool is_old_vec,
+				     bool new_enable, struct imsic_vector *move_vec)
 {
 	unsigned long flags;
 	bool enabled;
@@ -289,7 +323,10 @@ static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsi
 	/* Update enable and move details */
 	enabled = READ_ONCE(vec->enable);
 	WRITE_ONCE(vec->enable, new_enable);
-	WRITE_ONCE(vec->move, new_move);
+	if (is_old_vec)
+		WRITE_ONCE(vec->move_next, move_vec);
+	else
+		WRITE_ONCE(vec->move_prev, move_vec);
 
 	/* Mark the vector as dirty and synchronize */
 	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
@@ -322,8 +359,8 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 	 * interrupt on the old vector while device was being moved
 	 * to the new vector.
 	 */
-	enabled = imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
-	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+	enabled = imsic_vector_move_update(old_lpriv, old_vec, true, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, false, enabled, old_vec);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -386,7 +423,8 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 	vec = &lpriv->vectors[local_id];
 	vec->hwirq = hwirq;
 	vec->enable = false;
-	vec->move = NULL;
+	vec->move_next = NULL;
+	vec->move_prev = NULL;
 
 	return vec;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 391e442..f02842b 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -23,7 +23,8 @@ struct imsic_vector {
 	unsigned int				hwirq;
 	/* Details accessed using local lock held */
 	bool					enable;
-	struct imsic_vector			*move;
+	struct imsic_vector			*move_next;
+	struct imsic_vector			*move_prev;
 };
 
 struct imsic_local_priv {
@@ -74,7 +75,7 @@ static inline void __imsic_id_clear_enable(unsigned long id)
 	__imsic_eix_update(id, 1, false, false);
 }
 
-void imsic_local_sync_all(void);
+void imsic_local_sync_all(bool force_all);
 void imsic_local_delivery(bool enable);
 
 void imsic_vector_mask(struct imsic_vector *vec);
@@ -87,7 +88,7 @@ static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
 
 static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
 {
-	return READ_ONCE(vec->move);
+	return READ_ONCE(vec->move_prev);
 }
 
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);

