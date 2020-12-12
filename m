Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C225A2D86B5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438889AbgLLM7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 07:59:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438901AbgLLM7c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:32 -0500
Date:   Sat, 12 Dec 2020 12:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw9+vN6VNeTFsSnjEu5cBMevoJjTtsafUElMV/CY+Fs=;
        b=neQntvKialOYujLnWc12+1jKiOZl8uwyqWqBWGG7Q8sq30u9xAElxxTVuzIvwYqM57DMOP
        rgnfJhMCSJRbkJvUf8oya4rFZOQKtNIh9SlBXni/ayEXZon4H4EB+hMdexW7joWdQWUaSU
        fGdQ59g16tnPUmC6yfNTwdIwYSKlRTwxsOnwHRR9ZlqWFq/2NXLEGoinJnnANc0lUZ773+
        lobccHq9R7m7EOExpGF2nA4bVS3ly6DBRyYyz0UtrO2EweUQDOnC9z7EuUQ6ZZHqhdA0Nf
        itka3N63EMJ6cPGzRTQ3PwLajZokDy/AbHj+7OqQxWBM8+n2RtzuhwPIlJx4iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw9+vN6VNeTFsSnjEu5cBMevoJjTtsafUElMV/CY+Fs=;
        b=MujjXGIKJM7kjPA27zuRvSEYNjfKFahiUVrOZugzgtCEguGfLUJ5x78QZ8zn0aj3mTykf3
        TXZpjE/Lt4KssoCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move irq_set_lockdep_class() to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194042.860029489@linutronix.de>
References: <20201210194042.860029489@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792160.3364.6971604740060856051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a07d244f00de679c66643e89eba6e1baa62d3517
Gitweb:        https://git.kernel.org/tip/a07d244f00de679c66643e89eba6e1baa62d3517
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:02 +01:00

genirq: Move irq_set_lockdep_class() to core

irq_set_lockdep_class() is used from modules and requires irq_to_desc() to
be exported. Move it into the core code which lifts another requirement for
the export.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194042.860029489@linutronix.de

---
 include/linux/irqdesc.h | 10 ++++------
 kernel/irq/irqdesc.c    | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 308d7db..4a1d016 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -240,16 +240,14 @@ static inline bool irq_is_percpu_devid(unsigned int irq)
 	return irq_check_status_bit(irq, IRQ_PER_CPU_DEVID);
 }
 
+void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
+			     struct lock_class_key *request_class);
 static inline void
 irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 		      struct lock_class_key *request_class)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc) {
-		lockdep_set_class(&desc->lock, lock_class);
-		lockdep_set_class(&desc->request_mutex, request_class);
-	}
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		__irq_set_lockdep_class(irq, lock_class, request_class);
 }
 
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e810eb9..f309869 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -968,3 +968,17 @@ unsigned int kstat_irqs_usr(unsigned int irq)
 	rcu_read_unlock();
 	return sum;
 }
+
+#ifdef CONFIG_LOCKDEP
+void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
+			     struct lock_class_key *request_class)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (desc) {
+		lockdep_set_class(&desc->lock, lock_class);
+		lockdep_set_class(&desc->request_mutex, request_class);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_set_lockdep_class);
+#endif
