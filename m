Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703A2C18DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgKWWwg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgKWWvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F402C061A4D;
        Mon, 23 Nov 2020 14:51:47 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WChWq7w517NOUgA+cWWFGuL2+07gDsOyhwjSE8ufMNM=;
        b=duJ9ZzQxxMwm2AaGtmnFcueSoCgVMloMlM41/JZHW9lyHpXU1VsJtI3yPpXpZ396XSbeb+
        AvZqKkxJejlfkDxQLkkTEe2LnlbWD/izyzfTB1Wnf8FtHzFHq31fGGAwEpnsXFLg+7xJ0/
        Aiaave56GpY8MOwKsSuggcWd3EUDR7RK3HQUsg0fbTllsDuTfqwo7GzivPMqIxSRJE62Q9
        0jLHwnlRP4yuGB7Wf5VZ4hv4XFAFpNSj14K44lj/JlLQn5ZRigZqFnpQpJAzRbVriBAVb0
        4SzCyJVJvEiUB5uA3HGBlThRSThVhDEDdnkFG8dNhxizNS4Br6oJFz7YXA3v+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WChWq7w517NOUgA+cWWFGuL2+07gDsOyhwjSE8ufMNM=;
        b=cOphk/+BoufYn9+oCx3NY1HKE+8S0zQYd2sl37QSxp+TF/Wde7OOk06mvXB3Jsl74DBWog
        aR3Z27Tuj9mpOCAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] preempt: Cleanup the macro maze a bit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.864469886@linutronix.de>
References: <20201113141733.864469886@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190436.11115.348651878036253643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15115830c88751ba83068aa37da996602ddc6a61
Gitweb:        https://git.kernel.org/tip/15115830c88751ba83068aa37da996602ddc6a61
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:06 +01:00

preempt: Cleanup the macro maze a bit

Make the macro maze consistent and prepare it for adding the RT variant for
BH accounting.

 - Use nmi_count() for the NMI portion of preempt count
 - Introduce in_hardirq() to make the naming consistent and non-ambiguos
 - Use the macros to create combined checks (e.g. in_task()) so the
   softirq representation for RT just falls into place.
 - Update comments and move the deprecated macros aside

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.864469886@linutronix.de

---
 include/linux/preempt.h | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0..7547857 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,31 +77,33 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+#define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
-				 | NMI_MASK))
+#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
- * Are we doing bottom half or hardware interrupt processing?
+ * Macros to retrieve the current execution context:
  *
- * in_irq()       - We're in (hard) IRQ context
+ * in_nmi()		- We're in NMI context
+ * in_hardirq()		- We're in hard IRQ context
+ * in_serving_softirq()	- We're in softirq context
+ * in_task()		- We're in task context
+ */
+#define in_nmi()		(nmi_count())
+#define in_hardirq()		(hardirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+
+/*
+ * The following macros are deprecated and should not be used in new code:
+ * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
- * in_serving_softirq() - We're in softirq context
- * in_nmi()       - We're in NMI context
- * in_task()	  - We're in task context
- *
- * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
- *       should not be used in new code.
  */
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_nmi()		(preempt_count() & NMI_MASK)
-#define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 
 /*
  * The preempt_count offset after preempt_disable();
