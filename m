Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85573182B9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBKAvT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBKAvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:07 -0500
Date:   Thu, 11 Feb 2021 00:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5IjVgqPId2cFMAuEW2DPBY1CxG8DUyPvcjHrQNn0iM=;
        b=L6ZHyUcTRnsZzVa8tkMwDkQMBIyllQV5Utfym8qYAIbrSxO2IEoA+G5CEbjrsiTMiHjTxg
        +eKmnMyYCVI9cNAR8anbiYY+TktugTtw5krIciChzOvYk7X3KTDR25Wy+44d2XwHZjIXU1
        TrRd2Meah91tqYnuHCmJP885vualmlexddpDIrRM//yS0yNPbKjnIPYyurYl6cGzjcyq8c
        CCE9pevPdYm2MZdaofSnOmeuzJH+nbVayZWMnw0kwUxmZ+tODDj+oyh7gZCE4l7Ks2lvcw
        e4VfJ3bUFBy6sznZG3I2hztvwtiFGZ2VH7YAFR7TF6x3hSbu0oPfmiONAnaxsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5IjVgqPId2cFMAuEW2DPBY1CxG8DUyPvcjHrQNn0iM=;
        b=Kqo/pOJP7lnXZwg6k7QJtyQPLGLVmOBneRoQgv9sll2/NNNNr6qFUrGcAVwVGQTxlJyktS
        poRNe978pc2ZWOAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/softirq/64: Inline do_softirq_own_stack()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002513.382806685@linutronix.de>
References: <20210210002513.382806685@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462370.23325.14952958631693787504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     72f40a2823d6e16229ab58b898c6f22044e5222f
Gitweb:        https://git.kernel.org/tip/72f40a2823d6e16229ab58b898c6f22044e5222f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:17 +01:00

x86/softirq/64: Inline do_softirq_own_stack()

There is no reason to have this as a seperate function for a single caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002513.382806685@linutronix.de

---
 arch/x86/include/asm/irq_stack.h     |  3 +--
 arch/x86/include/asm/softirq_stack.h | 11 +++++++++++
 arch/x86/kernel/irq_64.c             |  5 -----
 3 files changed, 12 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/include/asm/softirq_stack.h

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 1b82f92..9b2a0ff 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -194,7 +194,7 @@
  * interrupts are pending to be processed. The interrupt stack cannot be in
  * use here.
  */
-#define run_softirq_on_irqstack()					\
+#define do_softirq_own_stack()						\
 {									\
 	__this_cpu_write(hardirq_stack_inuse, true);			\
 	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
@@ -202,7 +202,6 @@
 }
 
 #else /* CONFIG_X86_64 */
-
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
 {									\
diff --git a/arch/x86/include/asm/softirq_stack.h b/arch/x86/include/asm/softirq_stack.h
new file mode 100644
index 0000000..889d53d
--- /dev/null
+++ b/arch/x86/include/asm/softirq_stack.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SOFTIRQ_STACK_H
+#define _ASM_X86_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_X86_64
+# include <asm/irq_stack.h>
+#else
+# include <asm-generic/softirq_stack.h>
+#endif
+
+#endif
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index f335c39..1c0fb96 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,8 +74,3 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return 0;
 	return map_irq_stack(cpu);
 }
-
-void do_softirq_own_stack(void)
-{
-	run_softirq_on_irqstack();
-}
