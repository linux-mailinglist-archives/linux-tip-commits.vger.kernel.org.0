Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D55A55B3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2019 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfIBMPR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Sep 2019 08:15:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbfIBMPQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Sep 2019 08:15:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4lE0-0004EU-75; Mon, 02 Sep 2019 14:14:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 95DC61C0793;
        Mon,  2 Sep 2019 14:14:23 +0200 (CEST)
Date:   Mon, 02 Sep 2019 12:14:23 -0000
From:   "tip-bot2 for Marco Ammon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Correct misc typos
Cc:     Marco Ammon <marco.ammon@fau.de>, Borislav Petkov <bp@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>, Pu Wen <puwen@hygon.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, trivial@kernel.org,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190902102436.27396-1-marco.ammon@fau.de>
References: <20190902102436.27396-1-marco.ammon@fau.de>
MIME-Version: 1.0
Message-ID: <156742646341.26803.3629648875044393473.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     32b1cbe380417f2ed80f758791179de6b05795ab
Gitweb:        https://git.kernel.org/tip/32b1cbe380417f2ed80f758791179de6b05795ab
Author:        Marco Ammon <marco.ammon@fau.de>
AuthorDate:    Mon, 02 Sep 2019 14:02:59 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 02 Sep 2019 14:02:59 +02:00

x86: Correct misc typos

Correct spelling typos in comments in different files under arch/x86/.

 [ bp: Merge into a single patch, massage. ]

Signed-off-by: Marco Ammon <marco.ammon@fau.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190902102436.27396-1-marco.ammon@fau.de
---
 arch/x86/include/asm/text-patching.h | 4 ++--
 arch/x86/kernel/alternative.c        | 6 +++---
 arch/x86/kernel/kprobes/opt.c        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 70c0996..5e8319b 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,8 +45,8 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  * no thread can be preempted in the instructions being modified (no iret to an
  * invalid instruction possible) or if the instructions are changed from a
  * consistent state to another consistent state atomically.
- * On the local CPU you need to be protected again NMI or MCE handlers seeing an
- * inconsistent instruction while you patch.
+ * On the local CPU you need to be protected against NMI or MCE handlers seeing
+ * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ccd3201..9d3a971 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -713,7 +713,7 @@ void __init alternative_instructions(void)
 	 * Don't stop machine check exceptions while patching.
 	 * MCEs only happen when something got corrupted and in this
 	 * case we must do something about the corruption.
-	 * Ignoring it is worse than a unlikely patching race.
+	 * Ignoring it is worse than an unlikely patching race.
 	 * Also machine checks tend to be broadcast and if one CPU
 	 * goes into machine check the others follow quickly, so we don't
 	 * expect a machine check to cause undue problems during to code
@@ -753,8 +753,8 @@ void __init alternative_instructions(void)
  * When you use this code to patch more than one byte of an instruction
  * you need to make sure that other CPUs cannot execute this code in parallel.
  * Also no thread must be currently preempted in the middle of these
- * instructions. And on the local CPU you need to be protected again NMI or MCE
- * handlers seeing an inconsistent instruction while you patch.
+ * instructions. And on the local CPU you need to be protected against NMI or
+ * MCE handlers seeing an inconsistent instruction while you patch.
  */
 void __init_or_module text_poke_early(void *addr, const void *opcode,
 				      size_t len)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9d4aede..b348dd5 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -403,7 +403,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 	len += RELATIVEJUMP_SIZE;
 
-	/* We have to use text_poke for instuction buffer because it is RO */
+	/* We have to use text_poke() for instruction buffer because it is RO */
 	text_poke(slot, buf, len);
 	ret = 0;
 out:
