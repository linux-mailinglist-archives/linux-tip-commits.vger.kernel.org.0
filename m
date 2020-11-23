Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A532C18E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgKWWwh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbgKWWvv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:51 -0500
Date:   Mon, 23 Nov 2020 22:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BJwrOxS8rNjDzQpYoKsYOqwsmWdoAX3rqCXki4ajGg=;
        b=cghmki5dg2PQPTCZT4coOcY57pBdhwRXx0dUdwTYHRtaaWqrQgWLch/24tLgmuw3i5MzMY
        jJDW0SINDCsEY2ErTSPuu2lqPNmQ8E0g86Sr0p5vMNm3xqSShkReIPMvwEnQZEH5ce+i5m
        iwGFAnW9pXmhkrAepfmGq7BkYlKyT1sUNi8iDmbqgQ1iIfOziEpChTcDv3S12UCQscJh/F
        Icz5e0HOrVLJbNyqGf8/99mIkMf8zAmGaDqOguFm5yxQMwfcGMUO9z/5incpDigBmejC/i
        Nu9lnlZhWDGXtdfGJMj5HLiwHuqH6QnGwUIctR/EAEST6PQrUKVxeP88z3I+fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BJwrOxS8rNjDzQpYoKsYOqwsmWdoAX3rqCXki4ajGg=;
        b=z+KFcoTiPOvBl6qa6EP3tksWPijLkamdPuvk3x1kBFv3M6cPMfXsbJbqYjEhxQNz0/4Fgw
        VfTsXsuwYQU8UfDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: irqstat: Get rid of duplicated declaration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.276505871@linutronix.de>
References: <20201113141733.276505871@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190736.11115.7355137821207330254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7fd70c65faacd39628ba5f670be6490010c8132f
Gitweb:        https://git.kernel.org/tip/7fd70c65faacd39628ba5f670be6490010c8132f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

ARM: irqstat: Get rid of duplicated declaration

irq_cpustat_t is exactly the same as the asm-generic one. Define
ack_bad_irq so the generic header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20201113141733.276505871@linutronix.de

---
 arch/arm/include/asm/hardirq.h | 11 +++--------
 arch/arm/include/asm/irq.h     |  2 ++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index b95848e..706efaf 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -2,16 +2,11 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
 #include <asm/irq.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
+#define ack_bad_irq ack_bad_irq
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d4114..1cbcc46 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,6 +31,8 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
