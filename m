Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD11DA1B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgEST7Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgEST7X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:59:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F1C08C5C0;
        Tue, 19 May 2020 12:59:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OJ-0000Gu-Hd; Tue, 19 May 2020 21:59:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBC781C0820;
        Tue, 19 May 2020 21:58:49 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:49 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Avoid pointless code when CONTEXT_TRACKING=n
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134058.955968069@linutronix.de>
References: <20200505134058.955968069@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832973.17951.2686231000611165316.tip-bot2@tip-bot2>
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

Commit-ID:     cd19bff6935f29ad06513562b59ebdfe2d34eae4
Gitweb:        https://git.kernel.org/tip/cd19bff6935f29ad06513562b59ebdfe2d34eae4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 May 2020 20:03:04 +02:00

x86/entry/64: Avoid pointless code when CONTEXT_TRACKING=n

GAS cannot optimize out the test and conditional jump when context tracking
is disabled and CALL_enter_from_user_mode is an empty macro.

Wrap it in #ifdeffery. Will go away once all this is moved to C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134058.955968069@linutronix.de


---
 arch/x86/entry/entry_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7d40d10..f84b0f6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -889,12 +889,14 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 	TRACE_IRQS_OFF
 	.endif
 
+#ifdef CONFIG_CONTEXT_TRACKING
 	.if \paranoid == 0
 	testb	$3, CS(%rsp)
 	jz	.Lfrom_kernel_no_context_tracking_\@
 	CALL_enter_from_user_mode
 .Lfrom_kernel_no_context_tracking_\@:
 	.endif
+#endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer */
 
