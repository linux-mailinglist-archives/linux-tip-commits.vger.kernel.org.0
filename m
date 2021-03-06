Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5932F970
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCFKos (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 05:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhCFKoP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 05:44:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B4C06175F;
        Sat,  6 Mar 2021 02:44:14 -0800 (PST)
Date:   Sat, 06 Mar 2021 10:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615027451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3TbMPyJ4q/rEX0v+j8qU/SMu9e5MJJ994TgIEawHMw=;
        b=ZZvGntQAuo7zpdixrttTx6iN+dAHVY0RAtxL7/JIGbDrnZFxas6adxhIi1zzprIfNm4Dvv
        UC9DzooIldwFLN/qnPJZW8WfFk1nnaN0bIlTnJBtUYvKUDNcopfBAEG5esGTXP5Xl8V1lx
        dtwMB3qxbIOSrAycg/ID8sBCypbGWZuGAJagRm/HeYXc40BiaHHMQygmMUulDYyhMqCC4M
        gVMWNW/macHgepj2WQodcg2vHXFlQ4ys0aq4bJ4uVL3ANlE/tTrrgjg52EA77+L8jgyOaA
        zu1eiwui6itWIbB867+l8h97H3nY+VZ6lRBoELQ7zKPENNhYelpbeZcFu4oTUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615027451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3TbMPyJ4q/rEX0v+j8qU/SMu9e5MJJ994TgIEawHMw=;
        b=dO7gnkib5wyv5Jn5A1oRyLHR3K5z/ecUTxy2cMVaznE0+ecnVNMrcYiDRTPs5WsKWUfsIQ
        w13mHnLjreIYdzBA==
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
Message-ID: <161502745059.398.8274137708006500653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8bd7b3980ca62904814d536b3a2453001992a0c3
Gitweb:        https://git.kernel.org/tip/8bd7b3980ca62904814d536b3a2453001992a0c3
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 05 Feb 2021 08:24:02 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 11:37:00 +01:00

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
 
