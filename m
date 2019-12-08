Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51D31162A1
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2019 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLHO7S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Dec 2019 09:59:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLHO6z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy1D-0000dm-2R; Sun, 08 Dec 2019 15:58:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 25ED51C2891;
        Sun,  8 Dec 2019 15:58:35 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, ARC: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-5-bigeasy@linutronix.de>
References: <20191015191821.11479-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711503.21853.468122012806693188.tip-bot2@tip-bot2>
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

Commit-ID:     916591722c7543570843b54d5896121146b498f5
Gitweb:        https://git.kernel.org/tip/916591722c7543570843b54d5896121146b498f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:32 +01:00

sched/rt, ARC: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Link: https://lore.kernel.org/r/20191015191821.11479-5-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arc/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 72be012..1f6bb18 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -337,11 +337,11 @@ resume_user_mode_begin:
 resume_kernel_mode:
 
 	; Disable Interrupts from this point on
-	; CONFIG_PREEMPT: This is a must for preempt_schedule_irq()
-	; !CONFIG_PREEMPT: To ensure restore_regs is intr safe
+	; CONFIG_PREEMPTION: This is a must for preempt_schedule_irq()
+	; !CONFIG_PREEMPTION: To ensure restore_regs is intr safe
 	IRQ_DISABLE	r9
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 	; Can't preempt if preemption disabled
 	GET_CURR_THR_INFO_FROM_SP   r10
