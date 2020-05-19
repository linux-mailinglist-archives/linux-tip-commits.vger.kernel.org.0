Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955021DA21B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgESUCW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgEST6d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:58:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F1C08C5C1;
        Tue, 19 May 2020 12:58:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nf-0008E8-D8; Tue, 19 May 2020 21:58:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB4121C06DA;
        Tue, 19 May 2020 21:58:24 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:24 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Split int3 handler up
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.045220765@linutronix.de>
References: <20200505135314.045220765@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830471.17951.13148640036237320422.tip-bot2@tip-bot2>
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

Commit-ID:     f4f6b66fd8011eb5f24dec936faaa4cab2ca7ebc
Gitweb:        https://git.kernel.org/tip/f4f6b66fd8011eb5f24dec936faaa4cab2ca7ebc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Mar 2020 16:09:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:07 +02:00

x86/traps: Split int3 handler up

For code simplicity split up the int3 handler into a kernel and user part
which makes the code flow simpler to understand.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505135314.045220765@linutronix.de


---
 arch/x86/kernel/traps.c | 68 +++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0ad12df..21c8cfc 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -568,6 +568,35 @@ exit:
 	cond_local_irq_disable(regs);
 }
 
+static bool do_int3(struct pt_regs *regs)
+{
+	int res;
+
+#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
+	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
+			 SIGTRAP) == NOTIFY_STOP)
+		return true;
+#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
+
+#ifdef CONFIG_KPROBES
+	if (kprobe_int3_handler(regs))
+		return true;
+#endif
+	res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
+
+	return res == NOTIFY_STOP;
+}
+
+static void do_int3_user(struct pt_regs *regs)
+{
+	if (do_int3(regs))
+		return;
+
+	cond_local_irq_enable(regs);
+	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
+	cond_local_irq_disable(regs);
+}
+
 DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
@@ -585,37 +614,20 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	 * because the INT3 could have been hit in any context including
 	 * NMI.
 	 */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
 		idtentry_enter(regs);
-	else
-		nmi_enter();
-
-	instrumentation_begin();
-#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
-				SIGTRAP) == NOTIFY_STOP)
-		goto exit;
-#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
-
-#ifdef CONFIG_KPROBES
-	if (kprobe_int3_handler(regs))
-		goto exit;
-#endif
-
-	if (notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
-			SIGTRAP) == NOTIFY_STOP)
-		goto exit;
-
-	cond_local_irq_enable(regs);
-	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
-	cond_local_irq_disable(regs);
-
-exit:
-	instrumentation_end();
-	if (user_mode(regs))
+		instrumentation_begin();
+		do_int3_user(regs);
+		instrumentation_end();
 		idtentry_exit(regs);
-	else
+	} else {
+		nmi_enter();
+		instrumentation_begin();
+		if (!do_int3(regs))
+			die("int3", regs, 0);
+		instrumentation_end();
 		nmi_exit();
+	}
 }
 
 #ifdef CONFIG_X86_64
