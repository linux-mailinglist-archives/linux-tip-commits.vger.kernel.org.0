Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C213182BB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhBKAvV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBKAvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:09 -0500
Date:   Thu, 11 Feb 2021 00:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XVOHnUUrTxPAaH3KOwdh/vGwIiTcz9Kgj265LbFboA=;
        b=Exrc3H/QCYCNtIcy3nZFqSm85vwS/fApPPrHE7ZYgozrv/B5tgX9DLN6Q2aoPeAatxFTAo
        QPwHer5qHl8EQNJ339rC7HQT23z2pVMezaNvg66aPXzkJEf1njzgeqQdq3DGxdvUGXmOhl
        AcUzusv4NbKO6loTk/LO6j0BfpkLi3RIxgrQ8orsRrU2basiwv+tLSTEiw1/XKNosmqkWw
        jxaVSUTi0cfO4xcVUkfZcSS4jFFeMtFA9qEE39Zedu2OQgSNeL7aqZfDV91uH/lxxMnErE
        vGpg16ZAb5Ujb5npSYkwxSzMt/I19giM3SRep3m9tceDKQs/pgJx1yMfTba+tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XVOHnUUrTxPAaH3KOwdh/vGwIiTcz9Kgj265LbFboA=;
        b=ejuFf95yUcHPaSgMXcGzZUbBE5RuYrQ3YpLQSIx+B3m3BSfYBmE1SQJdBsQ7j0JZICFc95
        DwO6MxzZfzWjefDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/apic: Split out spurious handling code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.469379641@linutronix.de>
References: <20210210002512.469379641@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462610.23325.8050669891207216296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3c5e0267ec3e6ed7d3f1793273cbf0beb4f86a74
Gitweb:        https://git.kernel.org/tip/3c5e0267ec3e6ed7d3f1793273cbf0beb4f86a74
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:14 +01:00

x86/apic: Split out spurious handling code

sysvec_spurious_apic_interrupt() calls into the handling body of
__spurious_interrupt() which is not obvious as that function is declared
inside the DEFINE_IDTENTRY_IRQ(spurious_interrupt) macro.

As __spurious_interrupt() is currently always inlined this ends up with two
copies of the same code for no reason.

Split the handling function out and invoke it from both entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.469379641@linutronix.de


---
 arch/x86/kernel/apic/apic.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6bd20c0..02956c0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2133,18 +2133,11 @@ void __init register_lapic_address(unsigned long address)
  * Local APIC interrupts
  */
 
-/**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
- * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
- *
- * This is invoked from ASM entry code to catch all interrupts which
- * trigger on an entry which is routed to the common_spurious idtentry
- * point.
- *
- * Also called from sysvec_spurious_apic_interrupt().
+/*
+ * Common handling code for spurious_interrupt and spurious_vector entry
+ * points below. No point in allowing the compiler to inline it twice.
  */
-DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+static noinline void handle_spurious_interrupt(u8 vector)
 {
 	u32 v;
 
@@ -2179,9 +2172,23 @@ out:
 	trace_spurious_apic_exit(vector);
 }
 
+/**
+ * spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @vector:	The vector number
+ *
+ * This is invoked from ASM entry code to catch all interrupts which
+ * trigger on an entry which is routed to the common_spurious idtentry
+ * point.
+ */
+DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+{
+	handle_spurious_interrupt(vector);
+}
+
 DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
 {
-	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	handle_spurious_interrupt(SPURIOUS_APIC_VECTOR);
 }
 
 /*
