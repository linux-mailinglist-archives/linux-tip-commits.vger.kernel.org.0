Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA42383BDB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 May 2021 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhEQSFa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 May 2021 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbhEQSFa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 May 2021 14:05:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D3C061573;
        Mon, 17 May 2021 11:04:13 -0700 (PDT)
Date:   Mon, 17 May 2021 18:04:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621274651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVVsjS4gE508M6ufojwqsi0pI/e/0gs/TfNR2SbI2ps=;
        b=pnhp6LZgAOoo+JJ1SXaknzxdxp3E4xfS3nKyz0ev+MQyOwlv+qvNdjIZ9QwQx0XDQUyXT0
        GkuBQLYeXVmy2vrzOvziWwdGuSubsOzZDl4Jjx5Pv9NAMq+Gp0p7KrsYGOfMmlxo2JSZNe
        1Tg63+JcCJGGCo+16QnVg9NXubv/jyayFtIuhBCbJTTGbZ2JusvwvTJhnXqJ9b7knGt7Nm
        82kttyiEAImnJBbfCzLYaP6YSCoWVUAP5bFDh3vsRq9C0wvD4l8TCQ+QhIZsREZP810KDR
        NuZOKJQ4nRKR8bLCglr2HjT3NGShMhYE/5NikkGLo6eUh01bX7xY9Ojso4moag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621274651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVVsjS4gE508M6ufojwqsi0pI/e/0gs/TfNR2SbI2ps=;
        b=PSlTjkqR86O8itXXi7KEXG9XGloD+cQa/WsDGtqjtOtP6Ps2w9KJYjuE8Ky09aUrdM+J+w
        a32beAr48bwPd4CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add a IRQF_NO_DEBUG flag
Cc:     Thomas Gleixner <tglx@linutronix.de>, clg@kaod.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <7a8ad02f-63a8-c1aa-fdd1-39d973593d02@kaod.org>
References: <7a8ad02f-63a8-c1aa-fdd1-39d973593d02@kaod.org>
MIME-Version: 1.0
Message-ID: <162127465017.29796.12832262210298013693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c2b1063e8feb2115537addce10f36c0c82d11d9b
Gitweb:        https://git.kernel.org/tip/c2b1063e8feb2115537addce10f36c0c82d=
11d9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Apr 2021 08:23:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 May 2021 20:01:35 +02:00

genirq: Add a IRQF_NO_DEBUG flag

The whole call to note_interrupt() can be avoided or return early when
interrupts would be marked accordingly. For IPI handlers which always
return HANDLED the whole procedure is pretty pointless to begin with.

Add a IRQF_NO_DEBUG flag and mark the interrupt accordingly if supplied
when the interrupt is requested.

When noirqdebug is set on the kernel commandline, then the interrupt is
marked unconditionally so that there is only one condition in the hotpath
to evaluate.

 [ clg: Add changelog ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/7a8ad02f-63a8-c1aa-fdd1-39d973593d02@kaod.org
---
 include/linux/interrupt.h |  3 +++
 include/linux/irq.h       |  2 ++
 kernel/irq/chip.c         |  2 +-
 kernel/irq/handle.c       |  2 +-
 kernel/irq/manage.c       |  5 +++++
 kernel/irq/settings.h     | 12 ++++++++++++
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850..a52109c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,6 +64,8 @@
  * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request=
 it.
  *                Users will enable it explicitly by enable_irq() or enable_=
nmi()
  *                later.
+ * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handl=
ers,
+ *		   depends on IRQF_PERCPU.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -78,6 +80,7 @@
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
 #define IRQF_NO_AUTOEN		0x00080000
+#define IRQF_NO_DEBUG		0x00100000
=20
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 31b347c..8e9a9ae 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
  */
 enum {
 	IRQ_TYPE_NONE		=3D 0x00000000,
@@ -99,6 +100,7 @@ enum {
 	IRQ_IS_POLLED		=3D (1 << 18),
 	IRQ_DISABLE_UNLAZY	=3D (1 << 19),
 	IRQ_HIDDEN		=3D (1 << 20),
+	IRQ_NO_DEBUG		=3D (1 << 21),
 };
=20
 #define IRQF_MODIFY_MASK	\
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8cc8e57..7f04c7d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -481,7 +481,7 @@ void handle_nested_irq(unsigned int irq)
 	for_each_action_of_desc(desc, action)
 		action_ret |=3D action->thread_fn(action->irq, action->dev_id);
=20
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
=20
 	raw_spin_lock_irq(&desc->lock);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 762a928..221d80c 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
=20
 	add_interrupt_randomness(desc->irq_data.irq, flags);
=20
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
 	return retval;
 }
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356..7bdd09e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1686,8 +1686,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, s=
truct irqaction *new)
 		if (new->flags & IRQF_PERCPU) {
 			irqd_set(&desc->irq_data, IRQD_PER_CPU);
 			irq_settings_set_per_cpu(desc);
+			if (new->flags & IRQF_NO_DEBUG)
+				irq_settings_set_no_debug(desc);
 		}
=20
+		if (noirqdebug)
+			irq_settings_set_no_debug(desc);
+
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |=3D IRQS_ONESHOT;
=20
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 403378b..7b7efb1 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		=3D IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	=3D IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		=3D IRQ_HIDDEN,
+	_IRQ_NO_DEBUG		=3D IRQ_NO_DEBUG,
 	_IRQF_MODIFY_MASK	=3D IRQF_MODIFY_MASK,
 };
=20
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_NO_DEBUG		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
=20
@@ -174,3 +176,13 @@ static inline bool irq_settings_is_hidden(struct irq_des=
c *desc)
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline void irq_settings_set_no_debug(struct irq_desc *desc)
+{
+	desc->status_use_accessors |=3D _IRQ_NO_DEBUG;
+}
+
+static inline bool irq_settings_no_debug(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NO_DEBUG;
+}
