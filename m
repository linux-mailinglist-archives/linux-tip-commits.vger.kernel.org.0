Return-Path: <linux-tip-commits+bounces-4283-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF332A64AFB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC643B658B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832E23BD12;
	Mon, 17 Mar 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pz8uK2y3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRpnKuAn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A642397AA;
	Mon, 17 Mar 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208398; cv=none; b=P1/pE2eWlU+gEhS3IIZwKrH/OFzFHlsNj0nGZsyKu2pSm2rjKY5gfNRPycTM3n0sJUDu5c9zTpW/YI93zB6kluz/Lr9wl6CTsJNF7pP9EK5/EvvDJ0GssIgBgPYCFbhl6gwDJvZGI31qwxAEiMWftnFOvFZ1Ft3/N8+dDaKLgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208398; c=relaxed/simple;
	bh=GOfpq2ZXcOOnDSZPl11WbAx5Yl28saFlR3G5ChKeuGo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ykeap1ASW1XqoAq00mxzdukzKN0Qrt0TCfTgLZv3tMFXGNoMVXM5wrQ5ezl9VREqk2RhszP3csW4WFdadAc3UXImJ2NioIkOuqDkRMv+SYfWEztHMwsmLe8Jj43j7190hrB3e0uCblCnBafLWg7KDug0tV6lWEUZfqprj1Pa4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pz8uK2y3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRpnKuAn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9reXYg6N4uoA6vVPFFiA4Owjzv1SqvIyW8Oct/i1Sg=;
	b=pz8uK2y3NcyZEO95nGYqPyi5NuCU3MKoCu84DDgU/o7FsJkxsHdwvAx5c3Mr8To5n/1Fn3
	UQXtvrt4zQJBokvrvv3WauOgoerGH3TRYTAJEZQkunOx4q/XFwngEXHNgS/VfaVBOdSm6H
	2ypt382uWKYEan2RpwSXNFIk550cagWiNh/nSWycaGgGbcvlkMJ77Zqjmtoqn27kWmLLFb
	CZHfxaxOWgxntuTTipyCchAD4TbLexy9HIcP8lxrjWq1k4QftITLnGjPZNcx79XVEyL6CT
	b6/kpE3fbnfGzywXQJiwiHa8hFbX52q5IazYevNRD2ne4CQlA4spCCCFZLDEkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9reXYg6N4uoA6vVPFFiA4Owjzv1SqvIyW8Oct/i1Sg=;
	b=NRpnKuAnm77AdbNFNZ8llHkWreJPXQKz20Qg/Lc9OBb5u6b+Q+NSEn5h0InLJPJs6SrmSC
	VLkwMdqkEe2gfpAA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] x86/traps: Make exc_double_fault() consistently noreturn
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
References:
 <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220839265.14745.12573515229084776293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8085fcd78c1a3dbdf2278732579009d41ce0bc4e
Gitweb:        https://git.kernel.org/tip/8085fcd78c1a3dbdf2278732579009d41ce0bc4e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:28:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:35:59 +01:00

x86/traps: Make exc_double_fault() consistently noreturn

The CONFIG_X86_ESPFIX64 version of exc_double_fault() can return to its
caller, but the !CONFIG_X86_ESPFIX64 version never does.  In the latter
case the compiler and/or objtool may consider it to be implicitly
noreturn.

However, due to the currently inflexible way objtool detects noreturns,
a function's noreturn status needs to be consistent across configs.

The current workaround for this issue is to suppress unreachable
warnings for exc_double_fault()'s callers.  Unfortunately that can
result in ORC coverage gaps and potentially worse issues like inert
static calls and silently disabled CPU mitigations.

Instead, prevent exc_double_fault() from ever being implicitly marked
noreturn by forcing a return behind a never-taken conditional.

Until a more integrated noreturn detection method exists, this is likely
the least objectionable workaround.

Fixes: 55eeab2a8a11 ("objtool: Ignore exc_double_fault() __noreturn warnings")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org
---
 arch/x86/kernel/traps.c | 18 +++++++++++++++++-
 tools/objtool/check.c   | 31 +------------------------------
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2dbadf3..5e3e036 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -380,6 +380,21 @@ __visible void __noreturn handle_stack_overflow(struct pt_regs *regs,
 #endif
 
 /*
+ * Prevent the compiler and/or objtool from marking the !CONFIG_X86_ESPFIX64
+ * version of exc_double_fault() as noreturn.  Otherwise the noreturn mismatch
+ * between configs triggers objtool warnings.
+ *
+ * This is a temporary hack until we have compiler or plugin support for
+ * annotating noreturns.
+ */
+#ifdef CONFIG_X86_ESPFIX64
+#define always_true() true
+#else
+bool always_true(void);
+bool __weak always_true(void) { return true; }
+#endif
+
+/*
  * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
  *
  * On x86_64, this is more or less a normal kernel entry.  Notwithstanding the
@@ -514,7 +529,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
 	die("double fault", regs, error_code);
-	panic("Machine halted.");
+	if (always_true())
+		panic("Machine halted.");
 	instrumentation_end();
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7dbf22c..12bf6c1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4460,35 +4460,6 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
-static bool ignore_noreturn_call(struct instruction *insn)
-{
-	struct symbol *call_dest = insn_call_dest(insn);
-
-	/*
-	 * FIXME: hack, we need a real noreturn solution
-	 *
-	 * Problem is, exc_double_fault() may or may not return, depending on
-	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
-	 * to the kernel config.
-	 *
-	 * Other potential ways to fix it:
-	 *
-	 *   - have compiler communicate __noreturn functions somehow
-	 *   - remove CONFIG_X86_ESPFIX64
-	 *   - read the .config file
-	 *   - add a cmdline option
-	 *   - create a generic objtool annotation format (vs a bunch of custom
-	 *     formats) and annotate it
-	 */
-	if (!strcmp(call_dest->name, "exc_double_fault")) {
-		/* prevent further unreachable warnings for the caller */
-		insn->sym->warned = 1;
-		return true;
-	}
-
-	return false;
-}
-
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
@@ -4505,7 +4476,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		prev_insn = prev_insn_same_sec(file, insn);
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
-			if (call_dest && !ignore_noreturn_call(prev_insn)) {
+			if (call_dest) {
 				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
 					  call_dest->name);
 				warnings++;

