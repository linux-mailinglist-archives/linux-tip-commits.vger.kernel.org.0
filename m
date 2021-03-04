Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1732CED2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 09:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhCDIwp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 03:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhCDIwU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 03:52:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C73C06175F;
        Thu,  4 Mar 2021 00:51:40 -0800 (PST)
Date:   Thu, 04 Mar 2021 08:51:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614847896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF5T/oM0xIFrRq6MAf0rXEWInAZVAeVJD5ZWqjmSnSA=;
        b=noU/dIAft1w9lYMbxfIwlYyNqNwY3KY4Vgpe6J/cfwgqElVNp1ZPv+U1b4Gyn4vy0ce2AO
        snP1jWZxRK7zhmv2nPi1/lwVHv/VL9Cy75qj18lw4iWdhRzTCToUueqNt5/MQ9OlW3mjT8
        80/4vqSq0Xdgi7Si9XeghWQooWl8WSKMj3FpSfRLdZ6HOvbPp0DprcllWkTdpjHaQ2ttix
        TrxduChJsjqvIjNwDMLTsnKfj3zaaAlmWLZAwCrS5BkDehnaaqSroK5uxGQFMuwzdvAsRb
        c8fB1ePdMpC5sOARQs/NKGoLB1Ftt0Se/D5LFnePWd+03dUlr8c51v9duZjfDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614847896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF5T/oM0xIFrRq6MAf0rXEWInAZVAeVJD5ZWqjmSnSA=;
        b=4Uz+1D08Y260zHulD/u4UBsOXYUKU5260jxXEulz58QjxsSme4bXljG/KEO5uMnfJLJ+CW
        rzsmSsT/HxW5HVCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Disable KASAN checking in the ORC
 unwinder, part 2
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, stable@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
References: <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161484789559.398.7368272714633477349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     38b6eb474ed2df3d159396c3d4312c8a7b2d5196
Gitweb:        https://git.kernel.org/tip/38b6eb474ed2df3d159396c3d4312c8a7b2d5196
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 05 Feb 2021 08:24:02 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 16:56:29 +01:00

x86/unwind/orc: Disable KASAN checking in the ORC unwinder, part 2

KASAN reserves "redzone" areas between stack frames in order to detect
stack overruns.  A read or write to such an area triggers a KASAN
"stack-out-of-bounds" BUG.

Normally, the ORC unwinder stays in-bounds and doesn't access the
redzone.  But sometimes it can't find ORC metadata for a given
instruction.  This can happen for code which is missing ORC metadata, or
for generated code.  In such cases, the unwinder attempts to fall back
to frame pointers, as a best-effort type thing.

This fallback often works, but when it doesn't, the unwinder can get
confused and go off into the weeds into the KASAN redzone, triggering
the aforementioned KASAN BUG.

But in this case, the unwinder's confusion is actually harmless and
working as designed.  It already has checks in place to prevent
off-stack accesses, but those checks get short-circuited by the KASAN
BUG.  And a BUG is a lot more disruptive than a harmless unwinder
warning.

Disable the KASAN checks by using READ_ONCE_NOCHECK() for all stack
accesses.  This finishes the job started by commit 881125bfe65b
("x86/unwind: Disable KASAN checking in the ORC unwinder"), which only
partially fixed the issue.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ivan Babrou <ivan@cloudflare.com>
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2a1d47f..1bcc14c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -367,8 +367,8 @@ static bool deref_stack_regs(struct unwind_state *state, unsigned long addr,
 	if (!stack_access_ok(state, addr, sizeof(struct pt_regs)))
 		return false;
 
-	*ip = regs->ip;
-	*sp = regs->sp;
+	*ip = READ_ONCE_NOCHECK(regs->ip);
+	*sp = READ_ONCE_NOCHECK(regs->sp);
 	return true;
 }
 
@@ -380,8 +380,8 @@ static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr
 	if (!stack_access_ok(state, addr, IRET_FRAME_SIZE))
 		return false;
 
-	*ip = regs->ip;
-	*sp = regs->sp;
+	*ip = READ_ONCE_NOCHECK(regs->ip);
+	*sp = READ_ONCE_NOCHECK(regs->sp);
 	return true;
 }
 
@@ -402,12 +402,12 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
 		return false;
 
 	if (state->full_regs) {
-		*val = ((unsigned long *)state->regs)[reg];
+		*val = READ_ONCE_NOCHECK(((unsigned long *)state->regs)[reg]);
 		return true;
 	}
 
 	if (state->prev_regs) {
-		*val = ((unsigned long *)state->prev_regs)[reg];
+		*val = READ_ONCE_NOCHECK(((unsigned long *)state->prev_regs)[reg]);
 		return true;
 	}
 
