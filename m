Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6B2C18E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgKWWwh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbgKWWvu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6CC0613CF;
        Mon, 23 Nov 2020 14:51:50 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHaQ7+aWpYd1G52BS6Q30yEkqRRE2IvI6iKwqutbdBM=;
        b=fPdMOwD/ojXzpkcsWfjnJgY030V0mWJlW004Knw52LFAa0cIXRnuFb/dqbVPPnTgg6sOHd
        /QRLQZh2MrU6xxAxYGEQkkH8JbhVQA4hhfcYsBrj5C+oNchKyrF3ktaLeYTDHfyf99pKo0
        loy15RurwEdK7uzs6TiFics/Wn6YdaD1Jk3sF8aUSzwvJ+bBDSMu8E9m4AFpN+qNh8EtqF
        WndeB52qcVPCzm9c7i18WuumM4nTGQ2XKq+o5kYoPrqgL7OqZXg+89z3LCTl84iPvbjAp+
        5Ejdt/Z7dmk/wUhfDGz1Eaj9hlDiIavCTLH+m8ptBvKBYyGBCI5ilBPYE1eugw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHaQ7+aWpYd1G52BS6Q30yEkqRRE2IvI6iKwqutbdBM=;
        b=Ds91ym0fjDOTY5wlHtJ7IM4mw5nA3HyjEmHhGGph9utS2rCUFl89EsU+ZyjD+0t5z9WKD0
        E1IjzjFAR/910xBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] um/irqstat: Get rid of the duplicated declarations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.156361337@linutronix.de>
References: <20201113141733.156361337@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190799.11115.15507871466882450295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e83694a7b249de63beb1d8b45474b796dce3cd45
Gitweb:        https://git.kernel.org/tip/e83694a7b249de63beb1d8b45474b796dce3cd45
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

um/irqstat: Get rid of the duplicated declarations

irq_cpustat_t and ack_bad_irq() are exactly the same as the asm-generic
ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.156361337@linutronix.de

---
 arch/um/include/asm/hardirq.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796..52e2c36 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,22 +2,7 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-#include <linux/irq.h>
-
-#ifndef ack_bad_irq
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
-#endif
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
