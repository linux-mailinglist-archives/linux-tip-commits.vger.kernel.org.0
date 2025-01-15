Return-Path: <linux-tip-commits+bounces-3262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E7A12CEC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740183A6397
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AC1D9A54;
	Wed, 15 Jan 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2sRhxyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1mUtAQC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81771D63C7;
	Wed, 15 Jan 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974041; cv=none; b=E6sYN8PSu0Gt3VQqAVl4INyNtLO0Hnc8mzezOzfqLYBnDs1pohJqB3U0Xbd1GaJxro/o0BAGB7Fyx/Qxf+JOj95bxpcVBJEKqpKczJrAb/Gl/PoMr6+RQIKeY3ycKF8nhNkyQbhGZ5SPCZVo6lEkgffHEmr92Tt022FJBehcz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974041; c=relaxed/simple;
	bh=OYRfBZBakSj97u2oSwXjbjOzzvQPCaGAQY2kI2992zM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hAhwQoaLsFCVYodOGtgVIw1/2+MbN2C8fKzUqJlrEvsl127b/HLKr4hk6ZbYsqHwC+xujrIA7Am/i4KuaB6XxdrmsRUig2UoQnNw2KO+cgWvFKriE/EgnUkkd8UbDlaPCBLTm8t33NnUo4cr2xAa9oiFPTz8Gr750tdmieprkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2sRhxyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1mUtAQC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 20:47:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736974037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LGbIQUCdO3C5QO8TCjmHk4E209xgIaGA9AtxvyJXrY=;
	b=C2sRhxyj52GgqYTG245h8hzb7TiDM7xCa0WEgdf08KFVWMvDUgEdaecH61nE/AqGfQkn7t
	h43c/7U9ldul6QwHqP4sVQR940E0rnBbLlY0hrGVixh0Ao8BeXCGi+eMKc6vHaSERl14Wh
	t0MiKZ0xEqzDd4YyLx6e4niWQzHNY3Uh/A1QgVoqQ0Z+1TWFeBAkWgrEwvQq0iA56Za8z+
	/80WHaLpURPH0CDavJAqgtMeiKN46jvf8B0UywF/ONX2qJfnxZJcX5LyVKEAVA9sQcQ4Z3
	6xOLbMgyrIGReDab37deIOA6qCDknbgzFaMnRruRyJyIWZzTqbpnTcmvoXMaPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736974037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LGbIQUCdO3C5QO8TCjmHk4E209xgIaGA9AtxvyJXrY=;
	b=w1mUtAQCLGLw4y8FTGxX9uv6mIvFZ+xU1mD4NJzufWBDOKgTJcCS1lTQM7/8TXPXi9Yosj
	BEjn2gvDL+L54zCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove IRQ_MOVE_PCNTXT and related code
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210103335.626707225@linutronix.de>
References: <20241210103335.626707225@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173697403723.31546.14262799732132154010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f94a18249b7f9131f3ca8eacf07f21050747ebd7
Gitweb:        https://git.kernel.org/tip/f94a18249b7f9131f3ca8eacf07f21050747ebd7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:34:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 21:38:53 +01:00

genirq: Remove IRQ_MOVE_PCNTXT and related code

Now that x86 is converted over to use the IRQCHIP_MOVE_DEFERRED flags,
remove IRQ*_MOVE_PCNTXT and related code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241210103335.626707225@linutronix.de


---
 arch/x86/Kconfig       |  1 -
 include/linux/irq.h    | 12 +-----------
 kernel/irq/chip.c      | 14 --------------
 kernel/irq/debugfs.c   |  1 -
 kernel/irq/internals.h |  2 +-
 kernel/irq/settings.h  |  6 ------
 6 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index df0fd72..9d7bd0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,7 +173,6 @@ config X86
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
-	select GENERIC_PENDING_IRQ_CHIPFLAGS	if SMP
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6e02154..8daa17f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -64,7 +64,6 @@ enum irqchip_irq_state;
  * IRQ_NOAUTOEN			- Interrupt is not automatically enabled in
  *				  request/setup_irq()
  * IRQ_NO_BALANCING		- Interrupt cannot be balanced (affinity set)
- * IRQ_MOVE_PCNTXT		- Interrupt can be migrated from process context
  * IRQ_NESTED_THREAD		- Interrupt nests into another thread
  * IRQ_PER_CPU_DEVID		- Dev_id is a per-cpu variable
  * IRQ_IS_POLLED		- Always polled by another interrupt. Exclude
@@ -93,7 +92,6 @@ enum {
 	IRQ_NOREQUEST		= (1 << 11),
 	IRQ_NOAUTOEN		= (1 << 12),
 	IRQ_NO_BALANCING	= (1 << 13),
-	IRQ_MOVE_PCNTXT		= (1 << 14),
 	IRQ_NESTED_THREAD	= (1 << 15),
 	IRQ_NOTHREAD		= (1 << 16),
 	IRQ_PER_CPU_DEVID	= (1 << 17),
@@ -105,7 +103,7 @@ enum {
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
-	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
+	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
 	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
 
@@ -201,8 +199,6 @@ struct irq_data {
  * IRQD_LEVEL			- Interrupt is level triggered
  * IRQD_WAKEUP_STATE		- Interrupt is configured for wakeup
  *				  from suspend
- * IRQD_MOVE_PCNTXT		- Interrupt can be moved in process
- *				  context
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
@@ -233,7 +229,6 @@ enum {
 	IRQD_AFFINITY_SET		= BIT(12),
 	IRQD_LEVEL			= BIT(13),
 	IRQD_WAKEUP_STATE		= BIT(14),
-	IRQD_MOVE_PCNTXT		= BIT(15),
 	IRQD_IRQ_DISABLED		= BIT(16),
 	IRQD_IRQ_MASKED			= BIT(17),
 	IRQD_IRQ_INPROGRESS		= BIT(18),
@@ -338,11 +333,6 @@ static inline bool irqd_is_wakeup_set(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
 }
 
-static inline bool irqd_can_move_in_process_context(struct irq_data *d)
-{
-	return __irqd_to_state(d) & IRQD_MOVE_PCNTXT;
-}
-
 static inline bool irqd_irq_disabled(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_IRQ_DISABLED;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7989da2..c901436 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -47,13 +47,6 @@ int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 		return -EINVAL;
 
 	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
-
-	if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
-		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
-			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
-		else
-			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
-	}
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1129,13 +1122,6 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
 
-	/* Keep this around until x86 is converted over */
-	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
-		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
-		if (irq_settings_can_move_pcntxt(desc))
-			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
-	}
-
 	tmp = irq_settings_get_trigger_mask(desc);
 	if (tmp != IRQ_TYPE_NONE)
 		trigger = tmp;
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 975eb8d..ca142b9 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -109,7 +109,6 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_NO_BALANCING),
 
 	BIT_MASK_DESCR(IRQD_SINGLE_TARGET),
-	BIT_MASK_DESCR(IRQD_MOVE_PCNTXT),
 	BIT_MASK_DESCR(IRQD_AFFINITY_SET),
 	BIT_MASK_DESCR(IRQD_SETAFFINITY_PENDING),
 	BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index b61fc64..a979523 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -421,7 +421,7 @@ irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
 {
-	return irqd_can_move_in_process_context(data);
+	return !(data->chip->flags & IRQCHIP_MOVE_DEFERRED);
 }
 static inline bool irq_move_pending(struct irq_data *data)
 {
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 7b7efb1..00b3bd1 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -11,7 +11,6 @@ enum {
 	_IRQ_NOREQUEST		= IRQ_NOREQUEST,
 	_IRQ_NOTHREAD		= IRQ_NOTHREAD,
 	_IRQ_NOAUTOEN		= IRQ_NOAUTOEN,
-	_IRQ_MOVE_PCNTXT	= IRQ_MOVE_PCNTXT,
 	_IRQ_NO_BALANCING	= IRQ_NO_BALANCING,
 	_IRQ_NESTED_THREAD	= IRQ_NESTED_THREAD,
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
@@ -142,11 +141,6 @@ static inline void irq_settings_set_noprobe(struct irq_desc *desc)
 	desc->status_use_accessors |= _IRQ_NOPROBE;
 }
 
-static inline bool irq_settings_can_move_pcntxt(struct irq_desc *desc)
-{
-	return desc->status_use_accessors & _IRQ_MOVE_PCNTXT;
-}
-
 static inline bool irq_settings_can_autoenable(struct irq_desc *desc)
 {
 	return !(desc->status_use_accessors & _IRQ_NOAUTOEN);

