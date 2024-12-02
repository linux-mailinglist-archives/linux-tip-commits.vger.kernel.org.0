Return-Path: <linux-tip-commits+bounces-2936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE599E0038
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09ABB2DE21
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881F1FECA6;
	Mon,  2 Dec 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFONxzHm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRP8TQrL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41541FC7EE;
	Mon,  2 Dec 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138123; cv=none; b=diDcn7uaOSW78L+VAkekLZ7CIblf/HS/ay7MSVqYEcwTl95l2g7sagfw+k9LNd+dId7GoncnvMm2Gz1GUkGBMnJqQ4wbawkbl3TCUzus0b8BASqN2dHFC2dTeH1t8GFuqo+G/6jo7dN7MA6BZn4ZICCYcuAQqp4tuav6mSY4E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138123; c=relaxed/simple;
	bh=u7xE4jxg3Gg29UqA28qTszTRIsh2qmuuDiRXSnjTVvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+Y+KKA/bZtYTTHM7K3r6/DJUX0aKW4/pDHDqwg+fcY+9lSzIC71moMCrI69mChe1vm/4h0z5/ruNxkTPqK139mA5y4aCY0nZ+m2t5dDz/uutBZ1W7VluuDreeivhcR05F04cAqDE9rAIwIjQmW8xe+E0ViMRvQwtvFTI6OsUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFONxzHm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRP8TQrL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MXVEuNgw8cJdf8QY7c9jDDs7jmCbmcerhZR6TgCfW4=;
	b=PFONxzHmXjkI3I4iZU2OUf3D1pCjNlyE2r4DNYnKPaTKPs9f8w7ycmFBBmR0E5h19bxiOB
	Vo849hitfTIx+Uc11+SG/6jw8SdjYfytNgI8fS24GFZSeYvcMzOOkoTS13euu4hFF2g1XN
	wSmu/vnACWkE4avNmg4uqLoEdvpWzWBY1w7Y4og/szTkCwD+zcmwfB1GmKPV/imbPm2nOe
	HEj75bfpLR0sor2kwuTMN4JYfH4cAl5jJ7wQw06O+4homOuln2WXQ7iyPKawO+q5q5s2TL
	DLV9vDH3OcZHzzqygV2ZfLLEd3/By9bRLfRzD+nkGcGnwe4faaiL065powRHMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MXVEuNgw8cJdf8QY7c9jDDs7jmCbmcerhZR6TgCfW4=;
	b=gRP8TQrL+sjr47kPtzbXfGjW3YCT7qJW3t/PMP3Ssk9tFMRRTJGY3Jr7YCYkDkm3bZZbte
	VVvc4tTaKOUTSuBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Convert {.UN}REACHABLE to ANNOTATE
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.353431347@infradead.org>
References: <20241128094312.353431347@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313811977.412.7127659829662506278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e7a174fb43d24adca066e82d1cb9fdee092d48d1
Gitweb:        https://git.kernel.org/tip/e7a174fb43d24adca066e82d1cb9fdee092d48d1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:44 +01:00

objtool: Convert {.UN}REACHABLE to ANNOTATE

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.353431347@infradead.org
---
 arch/loongarch/include/asm/bug.h    |  2 +-
 arch/x86/entry/entry_64.S           |  4 +-
 arch/x86/include/asm/bug.h          |  2 +-
 arch/x86/include/asm/irq_stack.h    |  2 +-
 include/linux/objtool.h             | 18 ++----
 include/linux/objtool_types.h       |  1 +-
 tools/include/linux/objtool_types.h |  1 +-
 tools/objtool/check.c               | 82 +++++++---------------------
 8 files changed, 36 insertions(+), 76 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 561ac1b..e25404a 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -45,7 +45,7 @@
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE);\
 	instrumentation_end();					\
 } while (0)
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1b5be07..9248660 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -311,7 +311,7 @@ SYM_CODE_END(xen_error_entry)
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
-	REACHABLE
+	ANNOTATE_REACHABLE
 
 	jmp	error_return
 .endm
@@ -532,7 +532,7 @@ SYM_CODE_START(\asmsym)
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
-	REACHABLE
+	ANNOTATE_REACHABLE
 
 	jmp	paranoid_exit
 
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 806649c..dd8fb17 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -92,7 +92,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
+	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index b71ad17..5455747 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -101,7 +101,7 @@
 
 #define ASM_CALL_ARG0							\
 	"call %c[__func]				\n"		\
-	ASM_REACHABLE
+	ANNOTATE_REACHABLE
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index fd487d4..e3cb135 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -111,14 +111,6 @@
 #endif
 .endm
 
-
-.macro REACHABLE
-.Lhere_\@:
-	.pushsection .discard.reachable
-	.long	.Lhere_\@
-	.popsection
-.endm
-
 .macro ANNOTATE type:req
 .Lhere_\@:
 	.pushsection .discard.annotate_insn,"M",@progbits,8
@@ -138,14 +130,11 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
-#define ASM_REACHABLE
 #else
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro REACHABLE
-.endm
 .macro ANNOTATE type:req
 .endm
 #endif
@@ -187,6 +176,12 @@
  * it will be ignored.
  */
 #define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
+/*
+ * This should be used directly after an instruction that is considered
+ * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
+ * WARN using UD2.
+ */
+#define ANNOTATE_REACHABLE		ASM_ANNOTATE(ANNOTYPE_REACHABLE)
 
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
@@ -196,6 +191,7 @@
 #define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
 #endif
 
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 23d6fb6..df5d9fa 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
+#define ANNOTYPE_REACHABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 23d6fb6..df5d9fa 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -64,5 +64,6 @@ struct unwind_hint {
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
+#define ANNOTYPE_REACHABLE		8
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 798cff5..27d0c41 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -627,56 +627,6 @@ static struct instruction *find_last_insn(struct objtool_file *file,
 	return insn;
 }
 
-/*
- * Mark "ud2" instructions and manually annotated dead ends.
- */
-static int add_dead_ends(struct objtool_file *file)
-{
-	struct section *rsec;
-	struct reloc *reloc;
-	struct instruction *insn;
-	uint64_t offset;
-
-	/*
-	 * UD2 defaults to being a dead-end, allow them to be annotated for
-	 * non-fatal, eg WARN.
-	 */
-	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type == STT_SECTION) {
-			offset = reloc_addend(reloc);
-		} else if (reloc->sym->local_label) {
-			offset = reloc->sym->offset;
-		} else {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, offset);
-		if (insn)
-			insn = prev_insn_same_sec(file, insn);
-		else if (offset == reloc->sym->sec->sh.sh_size) {
-			insn = find_last_insn(file, reloc->sym->sec);
-			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, offset);
-				return -1;
-			}
-		} else {
-			WARN("can't find reachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, offset);
-			return -1;
-		}
-
-		insn->dead_end = false;
-	}
-
-	return 0;
-}
-
 static int create_static_call_sections(struct objtool_file *file)
 {
 	struct static_call_site *site;
@@ -2306,6 +2256,7 @@ static int read_annotate(struct objtool_file *file,
 	struct section *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
+	uint64_t offset;
 	int type, ret;
 
 	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
@@ -2327,8 +2278,19 @@ static int read_annotate(struct objtool_file *file,
 	for_each_reloc(sec->rsec, reloc) {
 		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
 
-		insn = find_insn(file, reloc->sym->sec,
-				 reloc->sym->offset + reloc_addend(reloc));
+		offset = reloc->sym->offset + reloc_addend(reloc);
+		insn = find_insn(file, reloc->sym->sec, offset);
+
+		/*
+		 * Reachable annotations are 'funneh' and act on the previous instruction :/
+		 */
+		if (type == ANNOTYPE_REACHABLE) {
+			if (insn)
+				insn = prev_insn_same_sec(file, insn);
+			else if (offset == reloc->sym->sec->sh.sh_size)
+				insn = find_last_insn(file, reloc->sym->sec);
+		}
+
 		if (!insn) {
 			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
 			return -1;
@@ -2420,6 +2382,10 @@ static int __annotate_late(struct objtool_file *file, int type, struct instructi
 		insn->unret = 1;
 		break;
 
+	case ANNOTYPE_REACHABLE:
+		insn->dead_end = false;
+		break;
+
 	default:
 		break;
 	}
@@ -2566,14 +2532,6 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	/*
-	 * Must be after add_call_destinations() such that it can override
-	 * dead_end_function() marks.
-	 */
-	ret = add_dead_ends(file);
-	if (ret)
-		return ret;
-
 	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
@@ -2582,6 +2540,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be after add_call_destinations() such that it can override
+	 * dead_end_function() marks.
+	 */
 	ret = read_annotate(file, __annotate_late);
 	if (ret)
 		return ret;

