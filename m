Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49557171F3D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2020 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgB0Od0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Feb 2020 09:33:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbgB0Od0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Feb 2020 09:33:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7KE5-0006Yr-Dk; Thu, 27 Feb 2020 15:33:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA3791C2170;
        Thu, 27 Feb 2020 15:33:20 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:33:20 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Stop using ist_enter/exit() in do_int3()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225220217.150607679@linutronix.de>
References: <20200225220217.150607679@linutronix.de>
MIME-Version: 1.0
Message-ID: <158281400060.28353.1918321204020549760.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     65c668f5faebf549db086b7a6841b6f4187b4e4f
Gitweb:        https://git.kernel.org/tip/65c668f5faebf549db086b7a6841b6f4187b4e4f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 25 Feb 2020 22:36:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Feb 2020 15:28:39 +01:00

x86/traps: Stop using ist_enter/exit() in do_int3()

#BP is not longer using IST and using ist_enter() and ist_exit() makes it
harder to change ist_enter() and ist_exit()'s behavior.  Instead open-code
the very small amount of required logic.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200225220217.150607679@linutronix.de


---
 arch/x86/kernel/traps.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7ffb6f4..c0bc9df 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -572,14 +572,20 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 		return;
 
 	/*
-	 * Use ist_enter despite the fact that we don't use an IST stack.
-	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
-	 * mode or even during context tracking state changes.
+	 * Unlike any other non-IST entry, we can be called from a kprobe in
+	 * non-CONTEXT_KERNEL kernel mode or even during context tracking
+	 * state changes.  Make sure that we wake up RCU even if we're coming
+	 * from kernel code.
 	 *
-	 * This means that we can't schedule.  That's okay.
+	 * This means that we can't schedule even if we came from a
+	 * preemptible kernel context.  That's okay.
 	 */
-	ist_enter(regs);
+	if (!user_mode(regs)) {
+		rcu_nmi_enter();
+		preempt_disable();
+	}
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
 				SIGTRAP) == NOTIFY_STOP)
@@ -600,7 +606,10 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	cond_local_irq_disable(regs);
 
 exit:
-	ist_exit(regs);
+	if (!user_mode(regs)) {
+		preempt_enable_no_resched();
+		rcu_nmi_exit();
+	}
 }
 NOKPROBE_SYMBOL(do_int3);
 
