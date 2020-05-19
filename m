Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1D1DA1CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 22:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgESUAQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgEST7L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:59:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8356DC08C5C0;
        Tue, 19 May 2020 12:59:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O2-00006H-DD; Tue, 19 May 2020 21:58:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 885E91C0845;
        Tue, 19 May 2020 21:58:40 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:40 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Mark fixup_bad_iret() noinstr
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.346741553@linutronix.de>
References: <20200505134903.346741553@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832045.17951.2009680848290295284.tip-bot2@tip-bot2>
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

Commit-ID:     68a05c6247d2aa67f5ada1009ffd19758e5914ea
Gitweb:        https://git.kernel.org/tip/68a05c6247d2aa67f5ada1009ffd19758e5914ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 19:53:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:52 +02:00

x86/traps: Mark fixup_bad_iret() noinstr

This is called from deep entry ASM in a situation where instrumentation
will cause more harm than providing useful information.

Switch from memmove() to memcpy() because memmove() can't be called
from noinstr code. 

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134903.346741553@linutronix.de


---
 arch/x86/kernel/traps.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 48468f6..b2b3656 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -578,7 +578,7 @@ struct bad_iret_stack {
 	struct pt_regs regs;
 };
 
-asmlinkage __visible notrace
+asmlinkage __visible noinstr
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 {
 	/*
@@ -589,19 +589,21 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 * just below the IRET frame) and we want to pretend that the
 	 * exception came from the IRET target.
 	 */
-	struct bad_iret_stack *new_stack =
-		(struct bad_iret_stack *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+	struct bad_iret_stack tmp, *new_stack =
+		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
-	/* Copy the IRET target to the new stack. */
-	memmove(&new_stack->regs.ip, (void *)s->regs.sp, 5*8);
+	/* Copy the IRET target to the temporary storage. */
+	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memmove(new_stack, s, offsetof(struct bad_iret_stack, regs.ip));
+	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+
+	/* Update the entry stack */
+	memcpy(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
 }
-NOKPROBE_SYMBOL(fixup_bad_iret);
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
