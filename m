Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE617D331
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Mar 2020 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHKOm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Mar 2020 06:14:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgCHKOm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx5-0004nZ-7p; Sun, 08 Mar 2020 11:14:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F51F1C220A;
        Sun,  8 Mar 2020 11:14:29 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide interrupt injection mechanism
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130623.990928309@linutronix.de>
References: <20200306130623.990928309@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366246912.28353.2257142404263650679.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     acd26bcf362708594ea081ef55140e37d0854ed2
Gitweb:        https://git.kernel.org/tip/acd26bcf362708594ea081ef55140e37d0854ed2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:06:42 +01:00

genirq: Provide interrupt injection mechanism

Error injection mechanisms need a half ways safe way to inject interrupts as
invoking generic_handle_irq() or the actual device interrupt handler
directly from e.g. a debugfs write is not guaranteed to be safe.

On x86 generic_handle_irq() is unsafe due to the hardware trainwreck which
is the base of x86 interrupt delivery and affinity management.

Move the irq debugfs injection code into a separate function which can be
used by error injection code as well.

The implementation prevents at least that state is corrupted, but it cannot
close a very tiny race window on x86 which might result in a stale and not
serviced device interrupt under very unlikely circumstances.

This is explicitly for debugging and testing and not for production use or
abuse in random driver code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20200306130623.990928309@linutronix.de

---
 include/linux/interrupt.h |  2 +-
 kernel/irq/Kconfig        |  5 ++++-
 kernel/irq/chip.c         |  2 +-
 kernel/irq/debugfs.c      | 34 +------------------------
 kernel/irq/internals.h    |  2 +-
 kernel/irq/resend.c       | 53 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c5fe60e..80f637c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -248,6 +248,8 @@ extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
 extern int prepare_percpu_nmi(unsigned int irq);
 extern void teardown_percpu_nmi(unsigned int irq);
 
+extern int irq_inject_interrupt(unsigned int irq);
+
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index f92d9a6..20d501a 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -43,6 +43,10 @@ config GENERIC_IRQ_MIGRATION
 config AUTO_IRQ_AFFINITY
        bool
 
+# Interrupt injection mechanism
+config GENERIC_IRQ_INJECTION
+	bool
+
 # Tasklet based software resend for pending interrupts on enable_irq()
 config HARDIRQS_SW_RESEND
        bool
@@ -127,6 +131,7 @@ config SPARSE_IRQ
 config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
 	depends on DEBUG_FS
+	select GENERIC_IRQ_INJECTION
 	default n
 	---help---
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b3fa2d8..41e7e37 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -278,7 +278,7 @@ int irq_startup(struct irq_desc *desc, bool resend, bool force)
 		}
 	}
 	if (resend)
-		check_irq_resend(desc);
+		check_irq_resend(desc, false);
 
 	return ret;
 }
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 0c60779..4f9f844 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -190,39 +190,7 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 		return -EFAULT;
 
 	if (!strncmp(buf, "trigger", size)) {
-		unsigned long flags;
-		int err;
-
-		/* Try the HW interface first */
-		err = irq_set_irqchip_state(irq_desc_get_irq(desc),
-					    IRQCHIP_STATE_PENDING, true);
-		if (!err)
-			return count;
-
-		/*
-		 * Otherwise, try to inject via the resend interface,
-		 * which may or may not succeed.
-		 */
-		chip_bus_lock(desc);
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
-		/*
-		 * Don't allow injection when the interrupt is:
-		 *  - Level or NMI type
-		 *  - not activated
-		 *  - replaying already
-		 */
-		if (irq_settings_is_level(desc) ||
-		    !irqd_is_activated(&desc->irq_data) ||
-		    (desc->istate & (IRQS_NMI | IRQS_REPLAY))) {
-			err = -EINVAL;
-		} else {
-			desc->istate |= IRQS_PENDING;
-			err = check_irq_resend(desc);
-		}
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-		chip_bus_sync_unlock(desc);
+		int err = irq_inject_interrupt(irq_desc_get_irq(desc));
 
 		return err ? err : count;
 	}
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 8980859..7db284b 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -108,7 +108,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
-int check_irq_resend(struct irq_desc *desc);
+int check_irq_resend(struct irq_desc *desc, bool inject);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index bef72dc..27634f4 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -91,7 +91,7 @@ static int irq_sw_resend(struct irq_desc *desc)
  *
  * Is called with interrupts disabled and desc->lock held.
  */
-int check_irq_resend(struct irq_desc *desc)
+int check_irq_resend(struct irq_desc *desc, bool inject)
 {
 	int err = 0;
 
@@ -108,7 +108,7 @@ int check_irq_resend(struct irq_desc *desc)
 	if (desc->istate & IRQS_REPLAY)
 		return -EBUSY;
 
-	if (!(desc->istate & IRQS_PENDING))
+	if (!(desc->istate & IRQS_PENDING) && !inject)
 		return 0;
 
 	desc->istate &= ~IRQS_PENDING;
@@ -122,3 +122,52 @@ int check_irq_resend(struct irq_desc *desc)
 		desc->istate |= IRQS_REPLAY;
 	return err;
 }
+
+#ifdef CONFIG_GENERIC_IRQ_INJECTION
+/**
+ * irq_inject_interrupt - Inject an interrupt for testing/error injection
+ * @irq:	The interrupt number
+ *
+ * This function must only be used for debug and testing purposes!
+ *
+ * Especially on x86 this can cause a premature completion of an interrupt
+ * affinity change causing the interrupt line to become stale. Very
+ * unlikely, but possible.
+ *
+ * The injection can fail for various reasons:
+ * - Interrupt is not activated
+ * - Interrupt is NMI type or currently replaying
+ * - Interrupt is level type
+ * - Interrupt does not support hardware retrigger and software resend is
+ *   either not enabled or not possible for the interrupt.
+ */
+int irq_inject_interrupt(unsigned int irq)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	int err;
+
+	/* Try the state injection hardware interface first */
+	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
+		return 0;
+
+	/* That failed, try via the resend mechanism */
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/*
+	 * Only try to inject when the interrupt is:
+	 *  - not NMI type
+	 *  - activated
+	 */
+	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
+		err = -EINVAL;
+	else
+		err = check_irq_resend(desc, true);
+
+	irq_put_desc_busunlock(desc, flags);
+	return err;
+}
+EXPORT_SYMBOL_GPL(irq_inject_interrupt);
+#endif
