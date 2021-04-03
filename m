Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146AD35339F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhDCLLK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhDCLLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:03 -0400
Date:   Sat, 03 Apr 2021 11:11:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw5SWcZaNEYt/atcDm0MKLyq8G8CX8OdatczcRboxQE=;
        b=CvHAuEmWYNAQdub2gdn1QRy7ne04D1HmrlVNLaJ1sA8pKc/nej1BSWVUyKnY7u/b7aW3If
        uwziSKhTYuuMAAb4QjhaTH7EmTP1SFT9/UOTuj65XoTNCtdVHzDxA52jiCiYkkKEOI9D/i
        jNIWHYG1gEe4FRG+Zv/vN3HKUkwQUjHk0DoGtuGk3Aj3fkATXlQjVhDe4P45kR7l+xyV0G
        DnyeisfzLa46zos1ytMFzzHa1bpdzOVXLVCalRC+1G0nSnafNH/vcK5e2wNe46TBnLa2sZ
        N5IE17fu6BH+TDu5rx9IicUG6+4cyHv6Dr6N7+6pOd+bo6Ws937syYdSHe8Q/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw5SWcZaNEYt/atcDm0MKLyq8G8CX8OdatczcRboxQE=;
        b=vfpV6uvW8qW0+53wZeTLsnccwxEOksbg6EpPyf0AWwK85WMPoPSoR/FFGyU97C+jZzf/9i
        ZELFUTrVTRTmn6AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternatives: Optimize optimize_nops()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.442992235@infradead.org>
References: <20210326151259.442992235@infradead.org>
MIME-Version: 1.0
Message-ID: <161744826012.29796.9456292190751496112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     23c1ad538f4f371bdb67d8a112314842d5db7e5a
Gitweb:        https://git.kernel.org/tip/23c1ad538f4f371bdb67d8a112314842d5db7e5a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:41:17 +02:00

x86/alternatives: Optimize optimize_nops()

Currently, optimize_nops() scans to see if the alternative starts with
NOPs. However, the emit pattern is:

  141:	\oldinstr
  142:	.skip (len-(142b-141b)), 0x90

That is, when 'oldinstr' is short, the tail is padded with NOPs. This case
never gets optimized.

Rewrite optimize_nops() to replace any trailing string of NOPs inside
the alternative to larger NOPs. Also run it irrespective of patching,
replacing NOPs in both the original and replaced code.

A direct consequence is that 'padlen' becomes superfluous, so remove it.

 [ bp:
   - Adjust commit message
   - remove a stale comment about needing to pad
   - add a comment in optimize_nops()
   - exit early if the NOP verif. loop catches a mismatch - function
     should not not add NOPs in that case
   - fix the "optimized NOPs" offsets output ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 80adf5a..84ec0ba 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -189,19 +189,35 @@ done:
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
@@ -247,19 +263,15 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
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
@@ -283,14 +295,15 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
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
