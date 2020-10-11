Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDB28A8C3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgJKR6c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388504AbgJKR5q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:46 -0400
Date:   Sun, 11 Oct 2020 17:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e0L+P/YTESBg7M/w8fV++3Ef14HgHZ+nw9QyDkRKv9U=;
        b=JkeXN7aUthq+owMRw3QWPnfmThEG/E5U8pR4lQw8ikfpEiVCaWuLyVbpW5S0BzWseH3dC2
        ipI/uKpauqDT7PYQ5pWXPMGMv787Xs5aFP45BqX/RW82lNL6bjv7iRHmfzlkyQwZz5vXER
        nhgjh+WznEtOpM1MfJYUDa9N++ZZ9l5/5McgbnRKZ5WkdWLVGMfsn347WQSZlo7jTJYkj0
        vctYNxXQU7Gtt89ezjbLGWzGj3inCtmckoQ5KPWgimT07rs7N/+3c/oAPf4GfJ0eOlnBB+
        3sB5g8G/a0y3LZ3eWVrhkQhbwFzkibKWe1PPxUCWIZxhQ6PPu8aEk5vWNEJ3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e0L+P/YTESBg7M/w8fV++3Ef14HgHZ+nw9QyDkRKv9U=;
        b=q+n2zEocVt0ubbMjtLCGxza4O/tlmIwMVC3pjM60Cmfv5LU98AB25H3EsDEGSQza8inKZc
        e+9RlASKh2t25TCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Allow interrupts to be excluded from /proc/interrupts
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906374.7002.8222125509881938043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     83cfac95c01817819c2a51f0931d798d851f8a08
Gitweb:        https://git.kernel.org/tip/83cfac95c01817819c2a51f0931d798d851f8a08
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 May 2020 14:58:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:04:38 +01:00

genirq: Allow interrupts to be excluded from /proc/interrupts

A number of architectures implement IPI statistics directly,
duplicating the core kstat_irqs accounting. As we move IPIs to
being actual IRQs, we would end-up with a confusing display
in /proc/interrupts (where the IPIs would appear twice).

In order to solve this, allow interrupts to be flagged as
"hidden", which excludes them from /proc/interrupts.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   | 4 +++-
 kernel/irq/debugfs.c  | 1 +
 kernel/irq/proc.c     | 2 +-
 kernel/irq/settings.h | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 57205bb..63b9d96 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -71,6 +71,7 @@ enum irqchip_irq_state;
  *				  it from the spurious interrupt detection
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
+ * IRQ_HIDDEN			- Don't show up in /proc/interrupts
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -97,13 +98,14 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
+	IRQ_HIDDEN		= (1 << 20),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index b95ff5d..acabc0c 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -136,6 +136,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_PER_CPU_DEVID),
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
+	BIT_MASK_DESCR(_IRQ_HIDDEN),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d..72513ed 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc)
+	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs)
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index e43795c..403378b 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,6 +17,7 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
+	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -31,6 +32,7 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
+#define IRQ_HIDDEN		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -167,3 +169,8 @@ static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 {
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
 }
+
+static inline bool irq_settings_is_hidden(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_HIDDEN;
+}
