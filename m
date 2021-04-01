Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76A53518B7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhDARrU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhDARoX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA50C00F7E2;
        Thu,  1 Apr 2021 08:09:00 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8KV+/br7YBF8Sh8pJNpzzU9J2XbBvNi7D16cswcANo=;
        b=qZCghXpTk62C0BmI7/PBlSMNynOcuNkHHdNo4H1eTHYDBZXvVi9DgkKHZvRPrvX+HRQiR3
        tWu13xpDnNPYxSl24zpTZ5jQA2i9M1E17rpoGRSw6rMNGzuQfIyo8jjjlpJ5pHpSsycWBN
        rxSnGPsBFk4uqIF0bAb+bb+AR7Tv/63cPwr2i2AKa/oox+k4hXsP8Y5dwJeOCfwvy50kaK
        iGficpiGa74liB/dYAdiHw5C3L84iPxwTz2GhnQaAlGzl0ZtcFxAI4mQSOZZTYaU8qPc82
        hKs7yUHGpVquHhuA4XHEn0woBDBybN57YQLFfcinsqNsA9lBfQidvGDMPCrU1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8KV+/br7YBF8Sh8pJNpzzU9J2XbBvNi7D16cswcANo=;
        b=k8bRQdFV6uNRwPlHyamHZXkWEFUyeo3+uxbn3YR2a+vCOgaXwxv2x0rlJOAwwbp7O8EU29
        5MHoU31/ID8DppDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternatives: Optimize optimize_nops()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.442992235@infradead.org>
References: <20210326151259.442992235@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973897.29796.8946571512222425365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b4da5166b084f3fac01d68e0e67cbf3bf78a3e12
Gitweb:        https://git.kernel.org/tip/b4da5166b084f3fac01d68e0e67cbf3bf78a3e12
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:01 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 31 Mar 2021 20:30:04 +02:00

x86/alternatives: Optimize optimize_nops()

Currently, optimize_nops() scans to see if the alternative starts with
NOPs. However, the emit pattern is:

  141:	\oldinstr
  142:	.skip (len-(142b-141b)), 0x90

That is, when oldinstr is short, the tail is padded with NOPs. This case
never gets optimized.

Rewrite optimize_nops() to replace any trailing string of NOPs inside
the alternative to larger NOPs. Also run it irrespective of patching,
replacing NOPs in both the original and replaced code.

A direct consequence is that padlen becomes superfluous, so remove it.

 [ bp:
   - Adjust commit message
   - remove a stale comment about needing to pad
   - add a comment in optimize_nops()
   - exit early if the NOP verif. loop catches a mismatch - function
     should not not add NOPs in that case
   - fix the "optimized NOPs" offsets output ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210326151259.442992235@infradead.org
---
 arch/x86/include/asm/alternative.h            | 17 +-----
 arch/x86/kernel/alternative.c                 | 49 +++++++++++-------
 tools/objtool/arch/x86/include/arch/special.h |  2 +-
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 17b3609..a3c2315 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -65,7 +65,6 @@ struct alt_instr {
 	u16 cpuid;		/* cpuid bit set for replacement */
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen;	/* length of new instruction */
-	u8  padlen;		/* length of build-time padding */
 } __packed;
 
 /*
@@ -104,7 +103,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define alt_end_marker		"663"
 #define alt_slen		"662b-661b"
-#define alt_pad_len		alt_end_marker"b-662b"
 #define alt_total_slen		alt_end_marker"b-661b"
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
 
@@ -151,8 +149,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
 	" .word " __stringify(feature) "\n"		/* feature bit     */ \
 	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
-	" .byte " alt_pad_len "\n"			/* pad len */
+	" .byte " alt_rlen(num) "\n"			/* replacement len */
 
 #define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
@@ -224,9 +221,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Peculiarities:
  * No memory clobber here.
  * Argument numbers start with 1.
- * Best is to use constraints that are fixed size (like (%1) ... "r")
- * If you use variable sized constraints like "m" or "g" in the
- * replacement make sure to pad to the worst case length.
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, feature, input...)	\
@@ -315,13 +309,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * enough information for the alternatives patching code to patch an
  * instruction. See apply_alternatives().
  */
-.macro altinstruction_entry orig alt feature orig_len alt_len pad_len
+.macro altinstruction_entry orig alt feature orig_len alt_len
 	.long \orig - .
 	.long \alt - .
 	.word \feature
 	.byte \orig_len
 	.byte \alt_len
-	.byte \pad_len
 .endm
 
 /*
@@ -338,7 +331,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
+	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
@@ -375,8 +368,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 142:
 
 	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
 	.popsection
 
 	.pushsection .altinstr_replacement,"ax"
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f902f28..1298d58 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -345,19 +345,35 @@ done:
 static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
 {
 	unsigned long flags;
-	int i;
+	struct insn insn;
+	int nop, i = 0;
+
+	/*
+	 * Jump over the non-NOP insns, the remaining bytes must be single-byte
+	 * NOPs, optimize them.
+	 */
+	for (;;) {
+		if (insn_decode_kernel(&insn, &instr[i]))
+			return;
+
+		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
+			break;
+
+		if ((i += insn.length) >= a->instrlen)
+			return;
+	}
 
-	for (i = 0; i < a->padlen; i++) {
-		if (instr[i] != 0x90)
+	for (nop = i; i < a->instrlen; i++) {
+		if (WARN_ONCE(instr[i] != 0x90, "Not a NOP at 0x%px\n", &instr[i]))
 			return;
 	}
 
 	local_irq_save(flags);
-	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
+	add_nops(instr + nop, i - nop);
 	local_irq_restore(flags);
 
 	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
-		   instr, a->instrlen - a->padlen, a->padlen);
+		   instr, nop, a->instrlen);
 }
 
 /*
@@ -403,19 +419,15 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 * - feature not present but ALTINSTR_FLAG_INV is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV)) {
-			if (a->padlen > 1)
-				optimize_nops(a, instr);
-
-			continue;
-		}
+		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV))
+			goto next;
 
-		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
 			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
 			feature >> 5,
 			feature & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->padlen);
+			replacement, a->replacementlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
 		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
@@ -439,14 +451,15 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		if (a->replacementlen && is_jmp(replacement[0]))
 			recompute_jump(a, instr, replacement, insn_buff);
 
-		if (a->instrlen > a->replacementlen) {
-			add_nops(insn_buff + a->replacementlen,
-				 a->instrlen - a->replacementlen);
-			insn_buff_sz += a->instrlen - a->replacementlen;
-		}
+		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+			insn_buff[insn_buff_sz] = 0x90;
+
 		DUMP_BYTES(insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
+
+next:
+		optimize_nops(a, instr);
 	}
 }
 
diff --git a/tools/objtool/arch/x86/include/arch/special.h b/tools/objtool/arch/x86/include/arch/special.h
index d818b2b..14271cc 100644
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -10,7 +10,7 @@
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
 
-#define ALT_ENTRY_SIZE		13
+#define ALT_ENTRY_SIZE		12
 #define ALT_ORIG_OFFSET		0
 #define ALT_NEW_OFFSET		4
 #define ALT_FEATURE_OFFSET	8
