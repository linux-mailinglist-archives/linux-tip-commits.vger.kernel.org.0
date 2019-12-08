Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB01162A6
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2019 16:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLHO73 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Dec 2019 09:59:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLHO6w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy1F-0000ah-3h; Sun, 08 Dec 2019 15:58:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BBFA21C2890;
        Sun,  8 Dec 2019 15:58:34 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, csky: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Guo Ren <guoren@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-7-bigeasy@linutronix.de>
References: <20191015191821.11479-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711461.21853.16937521050987954666.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     365a795a13326df11a5114d2b6067ca2a6d53364
Gitweb:        https://git.kernel.org/tip/365a795a13326df11a5114d2b6067ca2a6d53364
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:33 +01:00

sched/rt, csky: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20191015191821.11479-7-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/csky/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7a5b67..0077063 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -277,7 +277,7 @@ ENTRY(csky_irq)
 	zero_fp
 	psrset	ee
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	mov	r9, sp			/* Get current stack  pointer */
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10			/* Get thread_info */
@@ -294,7 +294,7 @@ ENTRY(csky_irq)
 	mov	a0, sp
 	jbsr	csky_do_IRQ
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	subi	r12, 1
 	stw	r12, (r9, TINFO_PREEMPT)
 	cmpnei	r12, 0
