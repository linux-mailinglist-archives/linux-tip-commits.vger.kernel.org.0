Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5B2C18E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgKWWwg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbgKWWvs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:48 -0500
Date:   Mon, 23 Nov 2020 22:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtbwtuthCMyWZtYKy2CitxXHe9u0PniaV5k+QHIuqxQ=;
        b=XoeN5FX6uS1IxuFO0pUiiTfTtnbw1HMXLaz4cifDKZZQoilFjBDf4cQXsqT6nNG/7gI2KM
        z/Zwto+i2IVqHP0ZjdQGzhVhH2SApzTSj609LlOXYZq24MO0JUcVg3jEjH5y54kgtDWjUJ
        +Oz7C+WsI2nU2Tm2075c47vV6k87IxlZJjtCVbDs/Hr8tmBWp6Ina+VfYeDYFiVxvrYcjC
        38He10iIpqAYJkmh1OKrvSRDFuLRoMYRSUwO4f+CGTjd2wQtmnYPVELWn8R6I09Dygo8C/
        jotPAaDabLGQHn4SR1AQ4hP5GTH71HcCUKDBKUgfdemgXTGbokNHToHBBlHkbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtbwtuthCMyWZtYKy2CitxXHe9u0PniaV5k+QHIuqxQ=;
        b=KR2uEaX3JPuXP46V7eoM/AOXbdDraywl0ozqFmh/jVsUSvmZFbOBkmXJh8XkVEqmu1MREU
        mMeepR5An6D4zkAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqstat: Move declaration into asm-generic/hardirq.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.737377332@linutronix.de>
References: <20201113141733.737377332@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190496.11115.15671434156465410153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e091bc90cd2d65f48e4688faead2911558d177d7
Gitweb:        https://git.kernel.org/tip/e091bc90cd2d65f48e4688faead2911558d177d7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:06 +01:00

irqstat: Move declaration into asm-generic/hardirq.h

Move the declaration of the irq_cpustat per cpu variable to
asm-generic/hardirq.h and remove the now empty linux/irq_cpustat.h header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.737377332@linutronix.de

---
 include/asm-generic/hardirq.h |  3 ++-
 include/linux/irq_cpustat.h   | 24 ------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)
 delete mode 100644 include/linux/irq_cpustat.h

diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index f5dd997..7317e82 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -12,7 +12,8 @@ typedef struct {
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
 #include <linux/irq.h>
 
 #ifndef ack_bad_irq
diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
deleted file mode 100644
index 78fb2de..0000000
--- a/include/linux/irq_cpustat.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __irq_cpustat_h
-#define __irq_cpustat_h
-
-/*
- * Contains default mappings for irq_cpustat_t, used by almost every
- * architecture.  Some arch (like s390) have per cpu hardware pages and
- * they define their own mappings for irq_stat.
- *
- * Keith Owens <kaos@ocs.com.au> July 2000.
- */
-
-
-/*
- * Simple wrappers reducing source bloat.  Define all irq_stat fields
- * here, even ones that are arch dependent.  That way we get common
- * definitions instead of differing sets for each arch.
- */
-
-#ifndef __ARCH_IRQ_STAT
-DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#endif
-
-#endif	/* __irq_cpustat_h */
