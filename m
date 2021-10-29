Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9A43FA77
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJ2KKJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2KKI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 06:10:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C353C061570;
        Fri, 29 Oct 2021 03:07:40 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635502058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVxcUjcq1BazLaUtF4z53V37M+WyqjYxE3ysd0nVm3M=;
        b=F1TNF7L7QrofZmQUAEckI0cnlRU+wS7ECpsZ1Jqhtx9fToSVjXvw0aYZf/2Y720ZkvMhpj
        CJlnmaibPbxH0xIXzCgQ/tLFyZFcTTpPghYCeW04n2SHHUBBm1/HwQY4hlxl3i2ldJtja0
        kpcm0kTzUapYnpfhCcUnNvZ9wJ1VnT/R76ePIc0fw3Lb6ZvE5cTv5kwFg8zfnJGSTLXUFI
        bWhg7ia6sfzPxBp9yVBTruj7mp30yJOZqLPCEVGlMsbEU5kg+1yKHPJVEIn2ClXjJ+2970
        igF2dontXmjcyeilZyEajAU4ig62cij7FjNSb2+Rhn3DGWDq/I+6WHW2MIl13w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635502058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVxcUjcq1BazLaUtF4z53V37M+WyqjYxE3ysd0nVm3M=;
        b=SaeVsiNI8kPmv9QSIt6Dno5iS1SpMwzXRR6ka2PESCSyn6tbX3ETs4I39wrdOFL9cGt2RI
        qYBg9VQvux8TApBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/softirq: Disable softirq stacks on PREEMPT_RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210924161245.2357247-1-bigeasy@linutronix.de>
References: <20210924161245.2357247-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163550205685.626.13652003305172772138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     441e90369344d229c0f04024ea5d4d51f06b137d
Gitweb:        https://git.kernel.org/tip/441e90369344d229c0f04024ea5d4d51f06b137d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 24 Sep 2021 18:12:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 27 Sep 2021 12:28:32 +02:00

x86/softirq: Disable softirq stacks on PREEMPT_RT

PREEMPT_RT preempts softirqs and the current implementation avoids
do_softirq_own_stack() and only uses __do_softirq().

Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
ensure that do_softirq_own_stack() is not used which is not expected.

 [ bigeasy: commit description. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210924161245.2357247-1-bigeasy@linutronix.de
---
 arch/x86/include/asm/irq_stack.h | 3 +++
 arch/x86/kernel/irq_32.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c..ea0c5ab 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -185,6 +185,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
+#ifndef CONFIG_PREEMPT_RT
 #define ASM_CALL_SOFTIRQ						\
 	"call %P[__func]				\n"
 
@@ -201,6 +202,8 @@
 	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
+#endif
+
 #else /* CONFIG_X86_64 */
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 044902d..e5dd6da 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,6 +132,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	return 0;
 }
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
@@ -148,6 +149,7 @@ void do_softirq_own_stack(void)
 
 	call_on_stack(__do_softirq, isp);
 }
+#endif
 
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
