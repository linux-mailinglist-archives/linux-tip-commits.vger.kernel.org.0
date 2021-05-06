Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF337537A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhEFMPI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhEFMPE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E1C0613ED;
        Thu,  6 May 2021 05:14:05 -0700 (PDT)
Date:   Thu, 06 May 2021 12:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSvFbLIjk74W8yD1rpTaoXfaIOhGdQXdT9Ru7usZd7A=;
        b=BURXdjDpEdqfv6pnLjx0wP+Op49E5YU7Ee7PCScIlIBnGMR/635rdxyvKTbrX2BYdMr7Am
        om9de+o2710XM9dt0UFiPDtDRpKZYA16zbVqIog7Mmh4IFyAP+OvaOo0iJKKXtaauA+kFH
        ODO72eay7a4/1AAnWm3iLQ8UX++QiS+npMyYRODEEvjCJw38D9eEbrMSk2BIPyD6lVDeWa
        44Dp+Jh0fbweXvb6nG1B6KMRi+THK9XkqwbrhMYlyKXTcj3geY+1XnN490RRAgG6MSKKKA
        AjSQE6M7m0N+WfVWuTHh7sxRrKR0W1gg3ilL0acUFIwe1BflDmMgiGVLtTo4QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSvFbLIjk74W8yD1rpTaoXfaIOhGdQXdT9Ru7usZd7A=;
        b=JFyCRd4YFPnDcdmnFijzY5dPmm9et3tITr8mK31gLsdZsAhMLJwgmkhNTREvsRozh712MU
        7ID5GC5r8xoeqWBQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] sched/vtime: Move guest enter/exit vtime accounting
 to vtime.h
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-6-seanjc@google.com>
References: <20210505002735.1684165-6-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324370.29796.4261476367596129273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6f922b89e5518143920b10e3643e556d9df58d94
Gitweb:        https://git.kernel.org/tip/6f922b89e5518143920b10e3643e556d9df58d94
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 04 May 2021 17:27:32 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:11 +02:00

sched/vtime: Move guest enter/exit vtime accounting to vtime.h

Provide separate helpers for guest enter vtime accounting (in addition to
the existing guest exit helpers), and move all vtime accounting helpers
to vtime.h where the existing #ifdef infrastructure can be leveraged to
better delineate the different types of accounting.  This will also allow
future cleanups via deduplication of context tracking code.

Opportunstically delete the vtime_account_kernel() stub now that all
callers are wrapped with CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210505002735.1684165-6-seanjc@google.com

---
 include/linux/context_tracking.h | 17 +-----------
 include/linux/vtime.h            | 46 ++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 4f45562..56c648b 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -137,14 +137,6 @@ static __always_inline void context_tracking_guest_exit(void)
 		__context_tracking_exit(CONTEXT_GUEST);
 }
 
-static __always_inline void vtime_account_guest_exit(void)
-{
-	if (vtime_accounting_enabled_this_cpu())
-		vtime_guest_exit(current);
-	else
-		current->flags &= ~PF_VCPU;
-}
-
 static __always_inline void guest_exit_irqoff(void)
 {
 	context_tracking_guest_exit();
@@ -163,20 +155,13 @@ static __always_inline void guest_enter_irqoff(void)
 	 * to flush.
 	 */
 	instrumentation_begin();
-	vtime_account_kernel(current);
-	current->flags |= PF_VCPU;
+	vtime_account_guest_enter();
 	rcu_virt_note_context_switch(smp_processor_id());
 	instrumentation_end();
 }
 
 static __always_inline void context_tracking_guest_exit(void) { }
 
-static __always_inline void vtime_account_guest_exit(void)
-{
-	vtime_account_kernel(current);
-	current->flags &= ~PF_VCPU;
-}
-
 static __always_inline void guest_exit_irqoff(void)
 {
 	instrumentation_begin();
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 6a43175..3684487 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -3,21 +3,18 @@
 #define _LINUX_KERNEL_VTIME_H
 
 #include <linux/context_tracking_state.h>
+#include <linux/sched.h>
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 #include <asm/vtime.h>
 #endif
 
-
-struct task_struct;
-
 /*
  * Common vtime APIs
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void vtime_account_kernel(struct task_struct *tsk);
 extern void vtime_account_idle(struct task_struct *tsk);
-#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
-static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -55,6 +52,18 @@ static inline void vtime_flush(struct task_struct *tsk) { }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
 extern void vtime_task_switch(struct task_struct *prev);
 
+static __always_inline void vtime_account_guest_enter(void)
+{
+	vtime_account_kernel(current);
+	current->flags |= PF_VCPU;
+}
+
+static __always_inline void vtime_account_guest_exit(void)
+{
+	vtime_account_kernel(current);
+	current->flags &= ~PF_VCPU;
+}
+
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
 
 /*
@@ -86,12 +95,37 @@ static inline void vtime_task_switch(struct task_struct *prev)
 		vtime_task_switch_generic(prev);
 }
 
+static __always_inline void vtime_account_guest_enter(void)
+{
+	if (vtime_accounting_enabled_this_cpu())
+		vtime_guest_enter(current);
+	else
+		current->flags |= PF_VCPU;
+}
+
+static __always_inline void vtime_account_guest_exit(void)
+{
+	if (vtime_accounting_enabled_this_cpu())
+		vtime_guest_exit(current);
+	else
+		current->flags &= ~PF_VCPU;
+}
+
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
-static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
+static __always_inline void vtime_account_guest_enter(void)
+{
+	current->flags |= PF_VCPU;
+}
+
+static __always_inline void vtime_account_guest_exit(void)
+{
+	current->flags &= ~PF_VCPU;
+}
+
 #endif
 
 
