Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94291162BF
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2019 16:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLHPAI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Dec 2019 10:00:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36770 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfLHO6n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy17-0000Xb-GY; Sun, 08 Dec 2019 15:58:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 51FDE1C288B;
        Sun,  8 Dec 2019 15:58:33 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, nds32: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-14-bigeasy@linutronix.de>
References: <20191015191821.11479-14-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711317.21853.17697512297305072801.tip-bot2@tip-bot2>
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

Commit-ID:     10c1537b32e7667842ccefbc2970153784837c27
Gitweb:        https://git.kernel.org/tip/10c1537b32e7667842ccefbc2970153784837c27
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:34 +01:00

sched/rt, nds32: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the ex-exit code over to use CONFIG_PREEMPTION.

[bigeasy: +Kconfig]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: https://lore.kernel.org/r/20191015191821.11479-14-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/nds32/Kconfig          | 2 +-
 arch/nds32/kernel/ex-exit.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 12c06a8..e30298e 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -62,7 +62,7 @@ config GENERIC_HWEIGHT
 
 config GENERIC_LOCKBREAK
 	def_bool y
-	depends on PREEMPT
+	depends on PREEMPTION
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
index 1df02a7..6a2966c 100644
--- a/arch/nds32/kernel/ex-exit.S
+++ b/arch/nds32/kernel/ex-exit.S
@@ -72,7 +72,7 @@
 	restore_user_regs_last
 	.endm
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	.macro	preempt_stop
 	.endm
 #else
@@ -158,7 +158,7 @@ no_work_pending:
 /*
  * preemptive kernel
  */
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 resume_kernel:
 	gie_disable
 	lwi	$t0, [tsk+#TSK_TI_PREEMPT]
