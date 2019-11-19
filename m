Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5D1029EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2019 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfKSQ5L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Nov 2019 11:57:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfKSQ5L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o2-0007JA-QA; Tue, 19 Nov 2019 17:56:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 668341C19CB;
        Tue, 19 Nov 2019 17:56:46 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:46 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/kprobe: Add comments to arch_{,un}optimize_kprobes()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132458.401696663@infradead.org>
References: <20191111132458.401696663@infradead.org>
MIME-Version: 1.0
Message-ID: <157418260634.12247.3206870563865681175.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     654920255149b034ad5a8aee6b02cfa16e65e9c0
Gitweb:        https://git.kernel.org/tip/654920255149b034ad5a8aee6b02cfa16e65e9c0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 11 Nov 2019 14:02:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 13:13:08 +01:00

x86/kprobe: Add comments to arch_{,un}optimize_kprobes()

Add a few words describing how it is safe to overwrite the 4 bytes
after a kprobe. In specific it is possible the JMP.d32 required for
the optimized kprobe overwrites multiple instructions.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.401696663@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 26e0d6c..3f45b5c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -414,8 +414,12 @@ err:
 }
 
 /*
- * Replace breakpoints (int3) with relative jumps.
+ * Replace breakpoints (INT3) with relative jumps (JMP.d32).
  * Caller must call with locking kprobe_mutex and text_mutex.
+ *
+ * The caller will have installed a regular kprobe and after that issued
+ * syncrhonize_rcu_tasks(), this ensures that the instruction(s) that live in
+ * the 4 bytes after the INT3 are unused and can now be overwritten.
  */
 void arch_optimize_kprobes(struct list_head *oplist)
 {
@@ -441,7 +445,13 @@ void arch_optimize_kprobes(struct list_head *oplist)
 	}
 }
 
-/* Replace a relative jump with a breakpoint (int3).  */
+/*
+ * Replace a relative jump (JMP.d32) with a breakpoint (INT3).
+ *
+ * After that, we can restore the 4 bytes after the INT3 to undo what
+ * arch_optimize_kprobes() scribbled. This is safe since those bytes will be
+ * unused once the INT3 lands.
+ */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	arch_arm_kprobe(&op->kp);
