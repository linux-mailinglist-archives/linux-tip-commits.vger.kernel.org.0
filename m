Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508251D575B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 May 2020 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEORRe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 May 2020 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgEORRe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 May 2020 13:17:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD9C061A0C;
        Fri, 15 May 2020 10:17:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZdxe-0005OG-40; Fri, 15 May 2020 19:17:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 77A2B1C007F;
        Fri, 15 May 2020 19:17:25 +0200 (CEST)
Date:   Fri, 15 May 2020 17:17:25 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/unwind/orc: Fix error handling in __unwind_start()
Cc:     Pavel Machek <pavel@denx.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com>
References: <d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158956304535.17951.17376884758306410761.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     71c95825289f585014fe9741b051d32a7a916680
Gitweb:        https://git.kernel.org/tip/71c95825289f585014fe9741b051d32a7a916680
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 14 May 2020 15:31:10 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 May 2020 10:35:08 +02:00

x86/unwind/orc: Fix error handling in __unwind_start()

The unwind_state 'error' field is used to inform the reliable unwinding
code that the stack trace can't be trusted.  Set this field for all
errors in __unwind_start().

Also, move the zeroing out of the unwind_state struct to before the ORC
table initialization check, to prevent the caller from reading
uninitialized data if the ORC table is corrupted.

Fixes: af085d9084b4 ("stacktrace/x86: add function for detecting reliable stack traces")
Fixes: d3a09104018c ("x86/unwinder/orc: Dont bail on stack overflow")
Fixes: 98d0c8ebf77e ("x86/unwind/orc: Prevent unwinding before ORC initialization")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d6ac7215a84ca92b895fdd2e1aa546729417e6e6.1589487277.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 5b0bd85..fa79e42 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -617,23 +617,23 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
-	if (!orc_init)
-		goto done;
-
 	memset(state, 0, sizeof(*state));
 	state->task = task;
 
+	if (!orc_init)
+		goto err;
+
 	/*
 	 * Refuse to unwind the stack of a task while it's executing on another
 	 * CPU.  This check is racy, but that's ok: the unwinder has other
 	 * checks to prevent it from going off the rails.
 	 */
 	if (task_on_another_cpu(task))
-		goto done;
+		goto err;
 
 	if (regs) {
 		if (user_mode(regs))
-			goto done;
+			goto the_end;
 
 		state->ip = regs->ip;
 		state->sp = regs->sp;
@@ -666,6 +666,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		 * generate some kind of backtrace if this happens.
 		 */
 		void *next_page = (void *)PAGE_ALIGN((unsigned long)state->sp);
+		state->error = true;
 		if (get_stack_info(next_page, state->task, &state->stack_info,
 				   &state->stack_mask))
 			return;
@@ -691,8 +692,9 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 
 	return;
 
-done:
+err:
+	state->error = true;
+the_end:
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
-	return;
 }
 EXPORT_SYMBOL_GPL(__unwind_start);
