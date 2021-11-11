Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67E44D673
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhKKMSY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:18:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKMSX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:18:23 -0500
Date:   Thu, 11 Nov 2021 12:15:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636632933;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfjJtKrHq7LeVOEuNmGXKQ+uIhLteyltsMXwiJq+rFE=;
        b=gemDb6/9++7oIPuaV2W2vrt3H0ZMJYh4zzKxMvok7aemk+Nm79l7SoZLHFUfiNmUCNaUl0
        2Gl30uBPjvkxC5dNg86sak/wJkAmbeARKdCAZnsD3FE+rwyKB1IYi0+024RSk1UZOn7wLU
        dufQhewsWme5tyTtKnp/i+sNBqqKh8rxoCHwbWbZ7VqbJ2hu94BZY8Tzf+dtQbmO7xLPjQ
        qZgr6NWvZY2sslEMPLhUhnXOfq2tgH7q/zrAfZe6aoNxQwosaRImcJqP2tozTzDPIKGvfr
        +a7QCAK2kKDP3qQ98N27J5xbi/bMIK2KEFKr8l2z5Vdi3SaRiTqKiDm+rXCDIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636632933;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfjJtKrHq7LeVOEuNmGXKQ+uIhLteyltsMXwiJq+rFE=;
        b=8qwlFRGx5O1MupE9KLPyeYJ3EuDRUqbMfygt459zKsOT5IeA/ZG+i+rzePUWk3SdnSZ5US
        tc0woqD29YoyrtDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call,x86: Robustify trampoline patching
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211030074758.GT174703@worktop.programming.kicks-ass.net>
References: <20211030074758.GT174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163663293212.414.10737140849753868860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     2105a92748e83e2e3ee6be539da959706bbb3898
Gitweb:        https://git.kernel.org/tip/2105a92748e83e2e3ee6be539da959706bbb3898
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 30 Oct 2021 09:47:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:31 +01:00

static_call,x86: Robustify trampoline patching

Add a few signature bytes after the static call trampoline and verify
those bytes match before patching the trampoline. This avoids patching
random other JMPs (such as CFI jump-table entries) instead.

These bytes decode as:

   d:   53                      push   %rbx
   e:   43 54                   rex.XB push %r12

And happen to spell "SCT".

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211030074758.GT174703@worktop.programming.kicks-ass.net
---
 arch/x86/include/asm/static_call.h |  1 +
 arch/x86/kernel/static_call.c      | 14 ++++++++++----
 tools/objtool/check.c              |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index cbb67b6..39ebe05 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -27,6 +27,7 @@
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
 	    insns "						\n"	\
+	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
 	    ".popsection					\n")
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ea028e7..9c407a3 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -56,10 +56,15 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void 
 	text_poke_bp(insn, code, size, emulate);
 }
 
-static void __static_call_validate(void *insn, bool tail)
+static void __static_call_validate(void *insn, bool tail, bool tramp)
 {
 	u8 opcode = *(u8 *)insn;
 
+	if (tramp && memcmp(insn+5, "SCT", 3)) {
+		pr_err("trampoline signature fail");
+		BUG();
+	}
+
 	if (tail) {
 		if (opcode == JMP32_INSN_OPCODE ||
 		    opcode == RET_INSN_OPCODE)
@@ -74,7 +79,8 @@ static void __static_call_validate(void *insn, bool tail)
 	/*
 	 * If we ever trigger this, our text is corrupt, we'll probably not live long.
 	 */
-	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+	pr_err("unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+	BUG();
 }
 
 static inline enum insn_type __sc_insn(bool null, bool tail)
@@ -97,12 +103,12 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 	mutex_lock(&text_mutex);
 
 	if (tramp) {
-		__static_call_validate(tramp, true);
+		__static_call_validate(tramp, true, true);
 		__static_call_transform(tramp, __sc_insn(!func, true), func);
 	}
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
-		__static_call_validate(site, tail);
+		__static_call_validate(site, tail, false);
 		__static_call_transform(site, __sc_insn(!func, tail), func);
 	}
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index add3990..2173582 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,6 +3310,9 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	if (!insn->func)
 		return false;
 
+	if (insn->func->static_call_tramp)
+		return true;
+
 	/*
 	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
 	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
