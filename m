Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9EB32D137
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhCDKyz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbhCDKyh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 05:54:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2286C061574;
        Thu,  4 Mar 2021 02:53:56 -0800 (PST)
Date:   Thu, 04 Mar 2021 10:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614855234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsx4a8IHEfZZw/d9DzhB8dHktlgqETbDO7zWi3iuZgo=;
        b=tr+PfyNG7J7tsV56fLRcgmPKAzMRjlJ2hLvETAKUgKyej161La2e5lYK0H/WIa0o8ISQud
        zpnyq/zyx15G3b0UGdkiQV30ORAPJeW+q+owCC2k5NwoYEqu0/Jt1jbar2xQBe6tNh+wxW
        bSeC2JajZ4o4wuJ2TxoomK3dFS677nEC1qa4Fy1e+xVAlSPYqtjvw8xhnFusEkQYGXrl+i
        VB9w8+kiyg1I9PR5LuXathxt/zA1/wpqlZnQaJeENME98sjKV3LPelz5376vV3xi2JiE/9
        0mymECjDxmsTWMSKSYwxAOvom9x1r1eDK5OSTfVqeBcPKJJdRiqgKBXZhCe1lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614855234;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsx4a8IHEfZZw/d9DzhB8dHktlgqETbDO7zWi3iuZgo=;
        b=NbhMBvpMk+9CuzZfh6CzE2PAWBYvoKfBL29hwNlKEiL82M891uvrQxl7yxVXZixobCenmr
        aqRzLtWdKnKyiVAQ==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dmitry.torokhov@gmail.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210302224916.13980-2-song.bao.hua@hisilicon.com>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161485523394.398.10007682711343433706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e749df1bbd23f4472082210650514548d8a39e9b
Gitweb:        https://git.kernel.org/tip/e749df1bbd23f4472082210650514548d8a39e9b
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Wed, 03 Mar 2021 11:49:15 +13:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Mar 2021 11:47:52 +01:00

genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

Many drivers don't want interrupts enabled automatically via request_irq().
So they are handling this issue by either way of the below two:

(1)
  irq_set_status_flags(irq, IRQ_NOAUTOEN);
  request_irq(dev, irq...);

(2)
  request_irq(dev, irq...);
  disable_irq(irq);

The code in the second way is silly and unsafe. In the small time gap
between request_irq() and disable_irq(), interrupts can still come.

The code in the first way is safe though it's subobtimal.

Add a new IRQF_NO_AUTOEN flag which can be handed in by drivers to
request_irq() and request_nmi(). It prevents the automatic enabling of the
requested interrupt/nmi in the same safe way as #1 above. With that the
various usage sites of #1 and #2 above can be simplified and corrected.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dmitry.torokhov@gmail.com
Link: https://lore.kernel.org/r/20210302224916.13980-2-song.bao.hua@hisilicon.com

---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/manage.c       | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 967e257..76f1161 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -61,6 +61,9 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
+ * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request it.
+ *                Users will enable it explicitly by enable_irq() or enable_nmi()
+ *                later.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -74,6 +77,7 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_NO_AUTOEN		0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dec3f73..97c231a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1693,7 +1693,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 		}
 
-		if (irq_settings_can_autoenable(desc)) {
+		if (!(new->flags & IRQF_NO_AUTOEN) &&
+		    irq_settings_can_autoenable(desc)) {
 			irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 		} else {
 			/*
@@ -2086,10 +2087,15 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	 * which interrupt is which (messes up the interrupt freeing
 	 * logic etc).
 	 *
+	 * Also shared interrupts do not go well with disabling auto enable.
+	 * The sharing interrupt might request it while it's still disabled
+	 * and then wait for interrupts forever.
+	 *
 	 * Also IRQF_COND_SUSPEND only makes sense for shared interrupts and
 	 * it cannot be set along with IRQF_NO_SUSPEND.
 	 */
 	if (((irqflags & IRQF_SHARED) && !dev_id) ||
+	    ((irqflags & IRQF_SHARED) && (irqflags & IRQF_NO_AUTOEN)) ||
 	    (!(irqflags & IRQF_SHARED) && (irqflags & IRQF_COND_SUSPEND)) ||
 	    ((irqflags & IRQF_NO_SUSPEND) && (irqflags & IRQF_COND_SUSPEND)))
 		return -EINVAL;
@@ -2245,7 +2251,8 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 
 	desc = irq_to_desc(irq);
 
-	if (!desc || irq_settings_can_autoenable(desc) ||
+	if (!desc || (irq_settings_can_autoenable(desc) &&
+	    !(irqflags & IRQF_NO_AUTOEN)) ||
 	    !irq_settings_can_request(desc) ||
 	    WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
 	    !irq_supports_nmi(desc))
