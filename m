Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57032FA9D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCFMTO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhCFMSz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:18:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2FDC06175F;
        Sat,  6 Mar 2021 04:18:55 -0800 (PST)
Date:   Sat, 06 Mar 2021 12:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615033134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH5crIIXNi8BSmXlOs/KXO4UdNUZyFPuSh8TmINBP+s=;
        b=1WVsJrNEStA6Mktfgfo9wV1yI2LRkuEQrbpWmgoFfPXwneTwQyjUIhQwnfcfL3d+IQSVda
        X++yMKOmIqk2zkvS0Zhhs4WZkmExMBFGv8HFw56apxGKGq762n5SkjAOmHBexb+ppTf62d
        jPKeLuEzXD6zyjCalSiF8xjWmcotb+Hn+I/VKzD8A7Pwh4Mtl9+w2RciXS85aXetUIGaRb
        GaprVkgOjW1WJJc3tbWwyeoSxSBhh1v8G4yR2/VUgJSOSXmhd5FHBLfNqv9yiubOppFPWB
        8R7mgR8BXl0ouI/KUCvfmxElfCnIPFFTX7AE8dbUKKqAV9/3XHzVgvkgkK2YIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615033134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH5crIIXNi8BSmXlOs/KXO4UdNUZyFPuSh8TmINBP+s=;
        b=SOM3wWCfnrFPuxIcrLy7V346VU+lr4RYYuDrf1iYhGtvl0O1T8iZLFN/CL3F0ITpOZnF+D
        ppn7tm7Lp2Mms3Aw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Disable KASAN checking in the ORC
 unwinder, part 2
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, stable@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
References: <9583327904ebbbeda399eca9c56d6c7085ac20fe.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161503313362.398.11041605747530638852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e504e74cc3a2c092b05577ce3e8e013fae7d94e6
Gitweb:        https://git.kernel.org/tip/e504e74cc3a2c092b05577ce3e8e013fae7d94e6
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 05 Feb 2021 08:24:02 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 13:09:37 +01:00

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
Signed-off-by: Borislav Petkov <bp@suse.de>
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
 
