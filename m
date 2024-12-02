Return-Path: <linux-tip-commits+bounces-2935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9F9E002D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4018163B92
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398271FE479;
	Mon,  2 Dec 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DSY1LScy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2AUjM2bY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB41FC114;
	Mon,  2 Dec 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138123; cv=none; b=SqES/7HdwtviC+5BwGH0dWJCiQKR3S3eG5j39nH0mVgC2V6ISZ4zcNkLpZPI0LWAXwSYqhUz0cbo7rS6ojAD4vb6ug4zpOeVcKiYClnFWgugslK8qX8awL02V/Z2QsExe6r1YssmJwS2Q+e8dQWEMcJv7OdwRJM6NL/G0K7OTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138123; c=relaxed/simple;
	bh=RIoQkJvb64k/kIEt7yS8jJzU5iy+/NePDIGKjvbwu3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G7s0ndenAzdggDusk5P9cori9eg8sJ8o3FSNySTbqMLcouMbO5xKPphuqgJXq/QgnI7FnIqxkZeKZs58Az16Si7gb+PMTKgjBcNMTwWK0HZf8PYDyu3KqKqc0IBPJwm6yHAZ08IDu9mSKIjI6Ujx+XFwqh93fdqTN9BwUi8Tv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DSY1LScy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2AUjM2bY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnC49WHYS6MzddRr/iTK+mO6XbMtgWbvLqGzlAykKIg=;
	b=DSY1LScy0VWZHIyAwkY/1lSIjt132Vyg3lysE+7E8zH9mZz7nVg3qyXYZXNpAC8Tm66gGE
	PsJfHqk6nlZpE/U3oUdOAMu9Y7guJJBZlsXTzvImoFGnXzz/T/ifvDSMyqCfQFcXW67qqA
	s8PQl7I8Y6JxZIiQ5+0QpBbHe8uR/Olsqda/BC8de9l5RaCF0B7eHpQHKsO060hSE3buXE
	HRLiFIzeNYEOpSxwYmB3LbwZ9f2vjshBn/oVT/1isjqG9+RAUtNP7X8QkcHD3HZ1nkY0jb
	mgw/jtCbtJKYOoH9cZ2KT/RfLTlA5b3wbVGXLr/YVfnIRFjsyf164nH5xvwQEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnC49WHYS6MzddRr/iTK+mO6XbMtgWbvLqGzlAykKIg=;
	b=2AUjM2bYk7b1UwvbI43PwDHXMUmFzEklpe5agSJT2J4dZgoEc7wYj6kPz7mL4yxw6rSrDQ
	e49Bh/anqf1FZKBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Fix ANNOTATE_REACHABLE to be a normal annotation
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.494176035@infradead.org>
References: <20241128094312.494176035@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313811905.412.6450073326132259902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     87116ae6da034242baf06e799f9f0e2a8ee6a796
Gitweb:        https://git.kernel.org/tip/87116ae6da034242baf06e799f9f0e2a8ee6a796
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:44 +01:00

objtool: Fix ANNOTATE_REACHABLE to be a normal annotation

Currently REACHABLE is weird for being on the instruction after the
instruction it modifies.

Since all REACHABLE annotations have an explicit instruction, flip
them around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.494176035@infradead.org
---
 arch/loongarch/include/asm/bug.h |  2 +-
 arch/x86/entry/entry_64.S        |  5 ++---
 arch/x86/include/asm/bug.h       |  2 +-
 arch/x86/include/asm/irq_stack.h |  4 ++--
 include/linux/objtool.h          |  4 ++--
 tools/objtool/check.c            | 23 -----------------------
 6 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index e25404a..f6f254f 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -45,7 +45,7 @@
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE);\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
 	instrumentation_end();					\
 } while (0)
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9248660..f52dbe0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -308,10 +308,9 @@ SYM_CODE_END(xen_error_entry)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
-	call	\cfunc
-
 	/* For some configurations \cfunc ends up being a noreturn. */
 	ANNOTATE_REACHABLE
+	call	\cfunc
 
 	jmp	error_return
 .endm
@@ -529,10 +528,10 @@ SYM_CODE_START(\asmsym)
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
 	ANNOTATE_REACHABLE
+	call	\cfunc
 
 	jmp	paranoid_exit
 
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index dd8fb17..e85ac0c 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -92,7 +92,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE);	\
+	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
 	instrumentation_end();					\
 } while (0)
 
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 5455747..562a547 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -100,8 +100,8 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %c[__func]				\n"		\
-	ANNOTATE_REACHABLE
+	"1: call %c[__func]				\n"		\
+	ANNOTATE_REACHABLE(1b)
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index e3cb135..c722a92 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -177,11 +177,11 @@
  */
 #define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
 /*
- * This should be used directly after an instruction that is considered
+ * This should be used to refer to an instruction that is considered
  * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
  * WARN using UD2.
  */
-#define ANNOTATE_REACHABLE		ASM_ANNOTATE(ANNOTYPE_REACHABLE)
+#define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
 
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27d0c41..26bdd3e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -614,19 +614,6 @@ static int init_pv_ops(struct objtool_file *file)
 	return 0;
 }
 
-static struct instruction *find_last_insn(struct objtool_file *file,
-					  struct section *sec)
-{
-	struct instruction *insn = NULL;
-	unsigned int offset;
-	unsigned int end = (sec->sh.sh_size > 10) ? sec->sh.sh_size - 10 : 0;
-
-	for (offset = sec->sh.sh_size - 1; offset >= end && !insn; offset--)
-		insn = find_insn(file, sec, offset);
-
-	return insn;
-}
-
 static int create_static_call_sections(struct objtool_file *file)
 {
 	struct static_call_site *site;
@@ -2281,16 +2268,6 @@ static int read_annotate(struct objtool_file *file,
 		offset = reloc->sym->offset + reloc_addend(reloc);
 		insn = find_insn(file, reloc->sym->sec, offset);
 
-		/*
-		 * Reachable annotations are 'funneh' and act on the previous instruction :/
-		 */
-		if (type == ANNOTYPE_REACHABLE) {
-			if (insn)
-				insn = prev_insn_same_sec(file, insn);
-			else if (offset == reloc->sym->sec->sh.sh_size)
-				insn = find_last_insn(file, reloc->sym->sec);
-		}
-
 		if (!insn) {
 			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
 			return -1;

