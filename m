Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F62375376
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhEFMPF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhEFMPE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:04 -0400
Date:   Thu, 06 May 2021 12:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0Dt/zW1hwiEl/UMDN13Dnj6M730TnbzvhqpvIpUEkc=;
        b=Rx0BvFkdcC1/RGMPblDzXnNAyy1ZxQVCnunJOVgzpg2VD+X5L2Jmwmt/pzh4s9lI95blh1
        IiWBeT9Fr1wkhOcRhJqAfsou2d9k1guts9GouaS0r9LS9S1h+shfPRedOZuV6b7GLiGAoN
        Cnkknur9t7AOmFk2OlhdXMYzqLqhLLd6qlLFHnXaR8xN5xZLcgXjlJOhWlmNIVJam5RT6k
        GtglMiZ1zFjkDBN8yiNYikpWY/79Xf8Wvjl4hyQplSbWd0siVXbB2qJivdxELPe016ZK2R
        Y3FReeLor8sIKffDSxxPZ3DG4ISt9gE2YMNggP8dmR7xpOtgrlhEv5D//VEQ6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0Dt/zW1hwiEl/UMDN13Dnj6M730TnbzvhqpvIpUEkc=;
        b=mCn/1PsPEPBfsiXKwLiLMrcR0wR4ikpq+WXnYe5KbSiNU1gzDvAV19YSeFTP4/yNAXK2HZ
        EwpKFOl457Hp7CBA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] sched/vtime: Move vtime accounting external
 declarations above inlines
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-5-seanjc@google.com>
References: <20210505002735.1684165-5-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324416.29796.11768717404848175384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b41c723b203e19480c26f2ec8f04eedc03d34b34
Gitweb:        https://git.kernel.org/tip/b41c723b203e19480c26f2ec8f04eedc03d34b34
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 04 May 2021 17:27:31 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:11 +02:00

sched/vtime: Move vtime accounting external declarations above inlines

Move the blob of external declarations (and their stubs) above the set of
inline definitions (and their stubs) for vtime accounting.  This will
allow a future patch to bring in more inline definitions without also
having to shuffle large chunks of code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Link: https://lore.kernel.org/r/20210505002735.1684165-5-seanjc@google.com

---
 include/linux/vtime.h | 74 +++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 041d652..6a43175 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -11,6 +11,43 @@
 struct task_struct;
 
 /*
+ * Common vtime APIs
+ */
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+extern void vtime_account_kernel(struct task_struct *tsk);
+extern void vtime_account_idle(struct task_struct *tsk);
+#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
+static inline void vtime_account_kernel(struct task_struct *tsk) { }
+#endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+extern void arch_vtime_task_switch(struct task_struct *tsk);
+extern void vtime_user_enter(struct task_struct *tsk);
+extern void vtime_user_exit(struct task_struct *tsk);
+extern void vtime_guest_enter(struct task_struct *tsk);
+extern void vtime_guest_exit(struct task_struct *tsk);
+extern void vtime_init_idle(struct task_struct *tsk, int cpu);
+#else /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN  */
+static inline void vtime_user_enter(struct task_struct *tsk) { }
+static inline void vtime_user_exit(struct task_struct *tsk) { }
+static inline void vtime_guest_enter(struct task_struct *tsk) { }
+static inline void vtime_guest_exit(struct task_struct *tsk) { }
+static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
+#endif
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
+extern void vtime_flush(struct task_struct *tsk);
+#else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
+static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
+static inline void vtime_account_softirq(struct task_struct *tsk) { }
+static inline void vtime_account_hardirq(struct task_struct *tsk) { }
+static inline void vtime_flush(struct task_struct *tsk) { }
+#endif
+
+/*
  * vtime_accounting_enabled_this_cpu() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
@@ -57,43 +94,6 @@ static inline void vtime_task_switch(struct task_struct *prev) { }
 
 #endif
 
-/*
- * Common vtime APIs
- */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
-extern void vtime_account_kernel(struct task_struct *tsk);
-extern void vtime_account_idle(struct task_struct *tsk);
-#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
-static inline void vtime_account_kernel(struct task_struct *tsk) { }
-#endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
-extern void vtime_user_enter(struct task_struct *tsk);
-extern void vtime_user_exit(struct task_struct *tsk);
-extern void vtime_guest_enter(struct task_struct *tsk);
-extern void vtime_guest_exit(struct task_struct *tsk);
-extern void vtime_init_idle(struct task_struct *tsk, int cpu);
-#else /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN  */
-static inline void vtime_user_enter(struct task_struct *tsk) { }
-static inline void vtime_user_exit(struct task_struct *tsk) { }
-static inline void vtime_guest_enter(struct task_struct *tsk) { }
-static inline void vtime_guest_exit(struct task_struct *tsk) { }
-static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
-#endif
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
-extern void vtime_account_softirq(struct task_struct *tsk);
-extern void vtime_account_hardirq(struct task_struct *tsk);
-extern void vtime_flush(struct task_struct *tsk);
-#else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
-static inline void vtime_account_softirq(struct task_struct *tsk) { }
-static inline void vtime_account_hardirq(struct task_struct *tsk) { }
-static inline void vtime_flush(struct task_struct *tsk) { }
-#endif
-
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
