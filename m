Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356221DEEDA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 May 2020 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgEVSEK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 May 2020 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSEK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 May 2020 14:04:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2BC061A0E;
        Fri, 22 May 2020 11:04:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcC1c-0002Ke-4Y; Fri, 22 May 2020 20:04:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF4F61C0095;
        Fri, 22 May 2020 20:04:03 +0200 (CEST)
Date:   Fri, 22 May 2020 18:04:03 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Fix unwind_get_return_address_ptr()
 for inactive tasks
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200522135435.vbxs7umku5pyrdbk@treble>
References: <20200522135435.vbxs7umku5pyrdbk@treble>
MIME-Version: 1.0
Message-ID: <159017064350.17951.16969339378626322681.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     187b96db5ca79423618dfa29a05c438c34f9e1f0
Gitweb:        https://git.kernel.org/tip/187b96db5ca79423618dfa29a05c438c34f9e1f0
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 22 May 2020 08:54:35 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 May 2020 19:55:17 +02:00

x86/unwind/orc: Fix unwind_get_return_address_ptr() for inactive tasks

Normally, show_trace_log_lvl() scans the stack, looking for text
addresses to print.  In parallel, it unwinds the stack with
unwind_next_frame().  If the stack address matches the pointer returned
by unwind_get_return_address_ptr() for the current frame, the text
address is printed normally without a question mark.  Otherwise it's
considered a breadcrumb (potentially from a previous call path) and it's
printed with a question mark to indicate that the address is unreliable
and typically can be ignored.

Since the following commit:

  f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")

... for inactive tasks, show_trace_log_lvl() prints *only* unreliable
addresses (prepended with '?').

That happens because, for the first frame of an inactive task,
unwind_get_return_address_ptr() returns the wrong return address
pointer: one word *below* the task stack pointer.  show_trace_log_lvl()
starts scanning at the stack pointer itself, so it never finds the first
'reliable' address, causing only guesses to being printed.

The first frame of an inactive task isn't a normal stack frame.  It's
actually just an instance of 'struct inactive_task_frame' which is left
behind by __switch_to_asm().  Now that this inactive frame is actually
exposed to callers, fix unwind_get_return_address_ptr() to interpret it
properly.

Fixes: f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200522135435.vbxs7umku5pyrdbk@treble
---
 arch/x86/kernel/unwind_orc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index fa79e42..7f969b2 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -320,12 +320,19 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
 {
+	struct task_struct *task = state->task;
+
 	if (unwind_done(state))
 		return NULL;
 
 	if (state->regs)
 		return &state->regs->ip;
 
+	if (task != current && state->sp == task->thread.sp) {
+		struct inactive_task_frame *frame = (void *)task->thread.sp;
+		return &frame->ret_addr;
+	}
+
 	if (state->sp)
 		return (unsigned long *)state->sp - 1;
 
