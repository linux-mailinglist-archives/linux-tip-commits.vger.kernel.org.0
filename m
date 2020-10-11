Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1291A28A8A0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgJKR52 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgJKR50 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:26 -0400
Date:   Sun, 11 Oct 2020 17:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36VfLLZq+lV4gIEi8U43UBqr0n3fH6Vnp/FfH4LCo+A=;
        b=sZOCumxVWIiIHPfYw8zElYoZwke2lhzksHgRLJHKkFgjtHJ0zrl3oG+YE96sMiVMU+gIR+
        2lXzZd3ZkD0GqZK3IV5a5qfijLXZtBqErjU2gtS8uD0770OhDTWR2lWLg3HbN0u3WPh56d
        yF7zKfUWoN9/vGER4KY2g7+eODOPj7z1XJayjG8jCNuwynnKcBssJFGlDqUqCIvb6y9nbP
        3we0p/NMucWYW36yj31JqX2JHQato3Gw9p3swC798s7SOjAy8jCgvGPozTgd3HtIPWuMeW
        MV2vp1A+M/udowmMOhR01l2u0DUyKW3Z3ODAV2nm30t2a2ayDINTenOmkGewkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36VfLLZq+lV4gIEi8U43UBqr0n3fH6Vnp/FfH4LCo+A=;
        b=MYWxH6dpTsETYZOU+m3SYQctIDIxIK6dzgyWc8oVnpJJvuUOtW/wLAKk+6kl6g+mXdFl0k
        cmTWHv8QXvNE08Aw==
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <mkshah@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601267524-20199-4-git-send-email-mkshah@codeaurora.org>
References: <1601267524-20199-4-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <160243904278.7002.3263028734776092188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     90428a8eb4947f9c7c905a178f3520dc7e2ee6d2
Gitweb:        https://git.kernel.org/tip/90428a8eb4947f9c7c905a178f3520dc7e2ee6d2
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Mon, 28 Sep 2020 10:02:01 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 06 Oct 2020 11:23:41 +01:00

genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag

An interrupt that is disabled/masked but set for wakeup may still need to
be able to wake up the system from sleep states like "suspend to RAM".

To that effect, introduce the IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag.
If the irqchip have this flag set, the irq PM code will enable/unmask
the irqs that are marked for wakeup, but that are in a disabled state.

On resume, such irqs will be restored back to their disabled state.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
[maz: commit message fix-up]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/1601267524-20199-4-git-send-email-mkshah@codeaurora.org
---
 include/linux/irq.h  | 49 ++++++++++++++++++++++++++-----------------
 kernel/irq/debugfs.c |  3 +++-
 kernel/irq/pm.c      | 34 ++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4df..a8b84b8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -215,6 +215,8 @@ struct irq_data {
  *				  from actual interrupt context.
  * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
  *				  irq_chip::irq_set_affinity() when deactivated.
+ * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
+ *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -240,6 +242,7 @@ enum {
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -319,6 +322,11 @@ static inline bool irqd_is_handle_enforce_irqctx(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_HANDLE_ENFORCE_IRQCTX;
 }
 
+static inline bool irqd_is_enabled_on_suspend(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_IRQ_ENABLED_ON_SUSPEND;
+}
+
 static inline bool irqd_is_wakeup_set(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
@@ -545,27 +553,30 @@ struct irq_chip {
 /*
  * irq_chip specific flags
  *
- * IRQCHIP_SET_TYPE_MASKED:	Mask before calling chip.irq_set_type()
- * IRQCHIP_EOI_IF_HANDLED:	Only issue irq_eoi() when irq was handled
- * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
- * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
- *				when irq enabled
- * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
- * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
- * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
- * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
- * IRQCHIP_SUPPORTS_NMI:	Chip can deliver NMIs, only for root irqchips
+ * IRQCHIP_SET_TYPE_MASKED:           Mask before calling chip.irq_set_type()
+ * IRQCHIP_EOI_IF_HANDLED:            Only issue irq_eoi() when irq was handled
+ * IRQCHIP_MASK_ON_SUSPEND:           Mask non wake irqs in the suspend path
+ * IRQCHIP_ONOFFLINE_ENABLED:         Only call irq_on/off_line callbacks
+ *                                    when irq enabled
+ * IRQCHIP_SKIP_SET_WAKE:             Skip chip.irq_set_wake(), for this irq chip
+ * IRQCHIP_ONESHOT_SAFE:              One shot does not require mask/unmask
+ * IRQCHIP_EOI_THREADED:              Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_SUPPORTS_LEVEL_MSI:        Chip can provide two doorbells for Level MSIs
+ * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
+ * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
+ *                                    in the suspend path if they are in disabled state
  */
 enum {
-	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
-	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
-	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
-	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
-	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
-	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
-	IRQCHIP_EOI_THREADED		= (1 <<  6),
-	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
-	IRQCHIP_SUPPORTS_NMI		= (1 <<  8),
+	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
+	IRQCHIP_EOI_IF_HANDLED			= (1 <<  1),
+	IRQCHIP_MASK_ON_SUSPEND			= (1 <<  2),
+	IRQCHIP_ONOFFLINE_ENABLED		= (1 <<  3),
+	IRQCHIP_SKIP_SET_WAKE			= (1 <<  4),
+	IRQCHIP_ONESHOT_SAFE			= (1 <<  5),
+	IRQCHIP_EOI_THREADED			= (1 <<  6),
+	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
+	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
+	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index b95ff5d..b6e1094 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -57,6 +57,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
+	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
 };
 
 static void
@@ -125,6 +126,8 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_DEFAULT_TRIGGER_SET),
 
 	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
+
+	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index c6c7e18..ce0adb2 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -69,12 +69,26 @@ void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action)
 
 static bool suspend_device_irq(struct irq_desc *desc)
 {
+	unsigned long chipflags = irq_desc_get_chip(desc)->flags;
+	struct irq_data *irqd = &desc->irq_data;
+
 	if (!desc->action || irq_desc_is_chained(desc) ||
 	    desc->no_suspend_depth)
 		return false;
 
-	if (irqd_is_wakeup_set(&desc->irq_data)) {
-		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	if (irqd_is_wakeup_set(irqd)) {
+		irqd_set(irqd, IRQD_WAKEUP_ARMED);
+
+		if ((chipflags & IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND) &&
+		     irqd_irq_disabled(irqd)) {
+			/*
+			 * Interrupt marked for wakeup is in disabled state.
+			 * Enable interrupt here to unmask/enable in irqchip
+			 * to be able to resume with such interrupts.
+			 */
+			__enable_irq(desc);
+			irqd_set(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND);
+		}
 		/*
 		 * We return true here to force the caller to issue
 		 * synchronize_irq(). We need to make sure that the
@@ -93,7 +107,7 @@ static bool suspend_device_irq(struct irq_desc *desc)
 	 * chip level. The chip implementation indicates that with
 	 * IRQCHIP_MASK_ON_SUSPEND.
 	 */
-	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
+	if (chipflags & IRQCHIP_MASK_ON_SUSPEND)
 		mask_irq(desc);
 	return true;
 }
@@ -137,7 +151,19 @@ EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
 static void resume_irq(struct irq_desc *desc)
 {
-	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	struct irq_data *irqd = &desc->irq_data;
+
+	irqd_clear(irqd, IRQD_WAKEUP_ARMED);
+
+	if (irqd_is_enabled_on_suspend(irqd)) {
+		/*
+		 * Interrupt marked for wakeup was enabled during suspend
+		 * entry. Disable such interrupts to restore them back to
+		 * original state.
+		 */
+		__disable_irq(desc);
+		irqd_clear(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND);
+	}
 
 	if (desc->istate & IRQS_SUSPENDED)
 		goto resume;
