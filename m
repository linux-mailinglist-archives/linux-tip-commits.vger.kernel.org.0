Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D817FC8A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Mar 2020 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgCJNCZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Mar 2020 09:02:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgCJNCW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Mar 2020 09:02:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jBeWY-0000Is-7k; Tue, 10 Mar 2020 14:02:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 499CD1C2233;
        Tue, 10 Mar 2020 14:02:17 +0100 (CET)
Date:   Tue, 10 Mar 2020 13:02:16 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Trace irqflags unconditionally as ON
 when returning to user space
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200308222609.314596327@linutronix.de>
References: <20200308222609.314596327@linutronix.de>
MIME-Version: 1.0
Message-ID: <158384533691.28353.9671125002002974218.tip-bot2@tip-bot2>
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

Commit-ID:     810f80a61be8c1d4a574082737f7a18c7459fa7b
Gitweb:        https://git.kernel.org/tip/810f80a61be8c1d4a574082737f7a18c7459fa7b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 08 Mar 2020 23:24:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Mar 2020 13:56:32 +01:00

x86/entry/64: Trace irqflags unconditionally as ON when returning to user space

User space cannot disable interrupts any longer so trace return to user space
unconditionally as IRQS_ON.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200308222609.314596327@linutronix.de
---
 arch/x86/entry/entry_32.S | 2 +-
 arch/x86/entry/entry_64.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 80df781..b67bae7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1088,7 +1088,7 @@ SYM_FUNC_START(entry_INT80_32)
 	STACKLEAK_ERASE
 
 restore_all:
-	TRACE_IRQS_IRET
+	TRACE_IRQS_ON
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f2bb91e..0e9504f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -174,7 +174,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_IRETQ		/* we're about to change IF */
+	TRACE_IRQS_ON			/* return enables interrupts */
 
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
@@ -619,7 +619,7 @@ ret_from_intr:
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_IRETQ
+	TRACE_IRQS_ON
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
