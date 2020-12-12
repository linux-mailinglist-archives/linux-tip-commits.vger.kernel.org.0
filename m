Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91D42D8696
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407357AbgLLNDp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438960AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E4C0611CD;
        Sat, 12 Dec 2020 04:58:46 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlLS4zuELpmyBB0r77+brO8S40F0TIcGoUk45xpK1Ic=;
        b=kp8OudaDJ/WfuU4rqCEHseabsu968PSKaB4eQKDAsrv0mViLUVmTXkRsj8pdITfSd7eow2
        u/dhhJDvaEt1qirZbTiTZt96+z5C4qpnMizqLGV5mbHq9AjY9n0WKojIOr6MGqRdJTm0MT
        iDxLLtOe88lCdbAWPyeFjjCblPHM9iCqcz1BLcpRI5lucHWOLP+9C183gKPiXNTRkhNkiA
        IWoCCz80wZcTbXUIcKlsfEJ3hYYBiBU86gtaXrup6otOs9pqDMsCiltAW/RfBCMViO2GGt
        TRKExbKH989biNMA+IxZN1S4sTHrED5oi1gypzzMGQhin4f4yindjAtKmXmuIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlLS4zuELpmyBB0r77+brO8S40F0TIcGoUk45xpK1Ic=;
        b=HX0BUWN4Y78ZzTgfjr/FXNA3CGNVkAz+N2cnxx86G2rEqiUcdaiQlsCykTLKPr3BkhsJOW
        KvFiKlZGKqd232DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move status flag checks to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194042.703779349@linutronix.de>
References: <20201210194042.703779349@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792185.3364.6052947970564908929.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a578bb32cb1a46676caae72dc0c668630ab40c1f
Gitweb:        https://git.kernel.org/tip/a578bb32cb1a46676caae72dc0c668630ab40c1f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Move status flag checks to core

These checks are used by modules and prevent the removal of the export of
irq_to_desc(). Move the accessor into the core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.703779349@linutronix.de

---
 include/linux/irqdesc.h | 17 +++++------------
 kernel/irq/manage.c     | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 385a4fa..308d7db 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -223,28 +223,21 @@ irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
 	data->chip = chip;
 }
 
+bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
+
 static inline bool irq_balancing_disabled(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
+	return irq_check_status_bit(irq, IRQ_NO_BALANCING_MASK);
 }
 
 static inline bool irq_is_percpu(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_PER_CPU;
+	return irq_check_status_bit(irq, IRQ_PER_CPU);
 }
 
 static inline bool irq_is_percpu_devid(unsigned int irq)
 {
-	struct irq_desc *desc;
-
-	desc = irq_to_desc(irq);
-	return desc->status_use_accessors & IRQ_PER_CPU_DEVID;
+	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
 }
 
 static inline void
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1767515..49950c3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2769,3 +2769,23 @@ bool irq_has_action(unsigned int irq)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_has_action);
+
+/**
+ * irq_check_status_bit - Check whether bits in the irq descriptor status are set
+ * @irq:	The linux irq number
+ * @bitmask:	The bitmask to evaluate
+ *
+ * Returns: True if one of the bits in @bitmask is set
+ */
+bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
+{
+	struct irq_desc *desc;
+	bool res = false;
+
+	rcu_read_lock();
+	desc = irq_to_desc(irq);
+	if (desc)
+		res = !!(desc->status_use_accessors & bitmask);
+	rcu_read_unlock();
+	return res;
+}
