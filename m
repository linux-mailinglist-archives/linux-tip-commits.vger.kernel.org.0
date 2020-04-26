Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A141B8D08
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 08:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgDZGry (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbgDZGrx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 02:47:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE4C061A0C;
        Sat, 25 Apr 2020 23:47:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4o-0008Ta-PM; Sun, 26 Apr 2020 08:47:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 677391C0330;
        Sun, 26 Apr 2020 08:47:42 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:42 -0000
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
Cc:     Miroslav Benes <mbenes@suse.cz>, Jann Horn <jannh@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <68c33e17ae5963854916a46f522624f8e1d264f2.1587808742.git.jpoimboe@redhat.com>
References: <68c33e17ae5963854916a46f522624f8e1d264f2.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788366202.28353.15767352618686056076.tip-bot2@tip-bot2>
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

Commit-ID:     f977df7b7ca45a4ac4b66d30a8931d0434c394b1
Gitweb:        https://git.kernel.org/tip/f977df7b7ca45a4ac4b66d30a8931d0434c394b1
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Sat, 25 Apr 2020 05:03:04 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:28 +02:00

x86/entry/64: Fix unwind hints in rewind_stack_do_exit()

The LEAQ instruction in rewind_stack_do_exit() moves the stack pointer
directly below the pt_regs at the top of the task stack before calling
do_exit(). Tell the unwinder to expect pt_regs.

Fixes: 8c1f75587a18 ("x86/entry/64: Add unwind hint annotations")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/68c33e17ae5963854916a46f522624f8e1d264f2.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 34a5889..9fe0d5c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1739,7 +1739,7 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
-	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
+	UNWIND_HINT_REGS
 
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
