Return-Path: <linux-tip-commits+bounces-28-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6DE812EB0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Dec 2023 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821641C20932
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Dec 2023 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685F3FE5B;
	Thu, 14 Dec 2023 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8XoGuKT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYJIozuA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369A19B;
	Thu, 14 Dec 2023 03:36:51 -0800 (PST)
Date: Thu, 14 Dec 2023 11:36:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702553809;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cCEWdIpWI/9C1380wQiFViEuDwRYGJP27yD3St+3zg=;
	b=L8XoGuKTdDhOLK62atrTwBTOUbxzBByw0PI7/89CkeDktPeFhT+QIKlnjLok65iKQ3qmeh
	g/c065eukd1erHiaKniGdgfuGrJzZiQfbOk01tCOXZIUnI/tvOH57pm3kb2x4YZiWfGitH
	RdABD1uLAFSaW1iRYnb9ANvPNDb+u5plWQ4TIQsH0Jtp9TmDC7J9S83l7raxwGNLsJS06X
	3/LW0k4K1qeWma7stRypnKC0J3QUOs4EsXL2yA5aoQaJGelHic7fI0qclkXkYBT50aqpr5
	C63prmSZwzTo4LPrwKtah1wgA/zl/8cVVDXiG+L6gaB6RI6nu1lG2xCBYYtj0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702553809;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cCEWdIpWI/9C1380wQiFViEuDwRYGJP27yD3St+3zg=;
	b=vYJIozuAVglgwJ2U3fUdNR35SXp24sOvJDh9oI7KXDqW5NKLQ309Kq/cZMjmhD3q2tEK7t
	5tKSDC+Xxe9gfrCA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/alternative: Add indirect call patching
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231210062138.2417-4-jgross@suse.com>
References: <20231210062138.2417-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170255380899.398.9070945669569999933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     da0fe6e68e104f79c1fef5c62a17bdd1634ea61c
Gitweb:        https://git.kernel.org/tip/da0fe6e68e104f79c1fef5c62a17bdd1634ea61c
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sun, 10 Dec 2023 07:21:36 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 10 Dec 2023 20:49:20 +01:00

x86/alternative: Add indirect call patching

In order to prepare replacing of paravirt patching with alternative
patching, add the capability to replace an indirect call with a direct
one.

This is done via a new flag ALT_FLAG_CALL as the target of the CALL
instruction needs to be evaluated using the value of the location
addressed by the indirect call.

For convenience, add a macro for a default CALL instruction. In case it
is being used without the new flag being set, it will result in a BUG()
when being executed. As in most cases, the feature used will be
X86_FEATURE_ALWAYS so add another macro ALT_CALL_ALWAYS usable for the
flags parameter of the ALTERNATIVE macros.

For a complete replacement, handle the special cases of calling a nop
function and an indirect call of NULL the same way as paravirt does.

  [ bp: Massage commit message, fixup the debug output and clarify flow
    more. ]

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231210062138.2417-4-jgross@suse.com
---
 arch/x86/include/asm/alternative.h |  9 +++++-
 arch/x86/kernel/alternative.c      | 58 +++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ce788ab..472334e 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -10,6 +10,9 @@
 
 #define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_FLAG_DIRECT_CALL	(1 << 1)
+#define ALT_DIRECT_CALL(feature) ((ALT_FLAG_DIRECT_CALL << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_CALL_ALWAYS		ALT_DIRECT_CALL(X86_FEATURE_ALWAYS)
 
 #ifndef __ASSEMBLY__
 
@@ -150,6 +153,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
+#define ALT_CALL_INSTR		"call BUG_func"
+
 #define b_replacement(num)	"664"#num
 #define e_replacement(num)	"665"#num
 
@@ -386,6 +391,10 @@ void nop_func(void);
 	.byte \alt_len
 .endm
 
+.macro ALT_CALL_INSTR
+	call BUG_func
+.endm
+
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ca25dd2..6573051 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,53 @@ noinstr void BUG_func(void)
 }
 EXPORT_SYMBOL_GPL(BUG_func);
 
+#define CALL_RIP_REL_OPCODE	0xff
+#define CALL_RIP_REL_MODRM	0x15
+
+/*
+ * Rewrite the "call BUG_func" replacement to point to the target of the
+ * indirect pv_ops call "call *disp(%ip)".
+ */
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+{
+	void *target, *bug = &BUG_func;
+	s32 disp;
+
+	if (a->replacementlen != 5 || insn_buff[0] != CALL_INSN_OPCODE) {
+		pr_err("ALT_FLAG_DIRECT_CALL set for a non-call replacement instruction\n");
+		BUG();
+	}
+
+	if (a->instrlen != 6 ||
+	    instr[0] != CALL_RIP_REL_OPCODE ||
+	    instr[1] != CALL_RIP_REL_MODRM) {
+		pr_err("ALT_FLAG_DIRECT_CALL set for unrecognized indirect call\n");
+		BUG();
+	}
+
+	/* Skip CALL_RIP_REL_OPCODE and CALL_RIP_REL_MODRM */
+	disp = *(s32 *)(instr + 2);
+#ifdef CONFIG_X86_64
+	/* ff 15 00 00 00 00   call   *0x0(%rip) */
+	/* target address is stored at "next instruction + disp". */
+	target = *(void **)(instr + a->instrlen + disp);
+#else
+	/* ff 15 00 00 00 00   call   *0x0 */
+	/* target address is stored at disp. */
+	target = *(void **)disp;
+#endif
+	if (!target)
+		target = bug;
+
+	/* (BUG_func - .) + (target - BUG_func) := target - . */
+	*(s32 *)(insn_buff + 1) += target - bug;
+
+	if (target == &nop_func)
+		return 0;
+
+	return 5;
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -452,16 +499,21 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
-			(a->flags & ALT_FLAG_NOT) ? "!" : "",
+		DPRINTK(ALT, "feat: %d32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen);
+			replacement, a->replacementlen, a->flags);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
+		if (a->flags & ALT_FLAG_DIRECT_CALL) {
+			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+			if (insn_buff_sz < 0)
+				continue;
+		}
+
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 

