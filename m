Return-Path: <linux-tip-commits+bounces-2683-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BF9B8558
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF931C217EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB011D0DE6;
	Thu, 31 Oct 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nb/06Fx+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nseyCrEl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DE1CCB36;
	Thu, 31 Oct 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410193; cv=none; b=SRMcM6Kyt90ysqJVK9jSOIhs2v6puz3fNtHvTzLOVLIIyXtJRUrQoFYtUEZHar92n81KamvQL3fol6s7N2ZKucioM+qXDkHHC5MkLFxocw+m3osPzFvaqIcjkstcnQA37ykjrymQf18AZKkrxfanYivFZheHJ3IbQYIUzbnV7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410193; c=relaxed/simple;
	bh=CKvOkRtDN2tN16kMX/aBBdoeTLJ2ZIf/wk2n6Zd9IMQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AieOhMyZ2pr4oQixysrDROkd5k8tQdUt9B0Qm6cumBvHfyR5dDiJ8X9TJglL4OquLb4zokaTSGKjy2Ex7QGEeE3QtRPkHzd4s/1hod03UB9fD1ZZXEAj3ubncGqvp5PTIg1MbFlXF8nxOyO49ec6P4HgjqdUbRvCunAfqIzLT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nb/06Fx+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nseyCrEl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 21:29:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730410184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OG1C66EXUm5qbP+2oty9Fb6+DXSFiaYF0K0TzI2DxNg=;
	b=Nb/06Fx+Xan/qQmf5UiAuFsqV61wzJa95VOD5hDUfztTX8q6ILNFY9rz8t3E8NDj3jAwWF
	QkMLf332+D6bwsiAJEjGxlhxBRKxmR5Vymuybl1RRD6mKY+9FJPjzfJmqsaCg6W6kwDiOy
	W8hVfUekC8g1AmF2X54evXkRiBwbnqAjuSScs12fxWIDvadJSAtM+jcXPmIpd/+FXz+q7f
	xF70SspVcChvHW+EX+eI78ue7pi2SnDBCF4U4ItTIEqYvhAVRQL97zBhVGHuuvj5CLDtAw
	MGUkxTnoHUuMzADAoAiJLsjP+DOwmMJst2VpPwA0h8SfdByasTkycA/jVI2/TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730410184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OG1C66EXUm5qbP+2oty9Fb6+DXSFiaYF0K0TzI2DxNg=;
	b=nseyCrEliMdjjFs8QKu4Kb/Gb98mbdn6ori5zHET28qSPyOVITXULUAfOBl2XEIIkRJcre
	ZZO8zwrIof3JR7Cg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Detect non-relocated text references
Cc: Ard Biesheuvel <ardb@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173041018401.3137.10243854881341518071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ed1cb76ebdeb88cf0603b9cb543f43f09ab704a1
Gitweb:        https://git.kernel.org/tip/ed1cb76ebdeb88cf0603b9cb543f43f09ab704a1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 03 Oct 2024 17:31:10 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 17 Oct 2024 15:13:06 -07:00

objtool: Detect non-relocated text references

When kernel IBT is enabled, objtool detects all text references in order
to determine which functions can be indirectly branched to.

In text, such references look like one of the following:

   mov    $0x0,%rax        R_X86_64_32S     .init.text+0x7e0a0
   lea    0x0(%rip),%rax   R_X86_64_PC32    autoremove_wake_function-0x4

Either way the function pointer is denoted by a relocation, so objtool
just reads that.

However there are some "lea xxx(%rip)" cases which don't use relocations
because they're referencing code in the same translation unit.  Objtool
doesn't have visibility to those.

The only currently known instances of that are a few hand-coded asm text
references which don't actually need ENDBR.  So it's not actually a
problem at the moment.

However if we enable -fpie, the compiler would start generating them and
there would definitely be bugs in the IBT sealing.

Detect non-relocated text references and handle them appropriately.

[ Note: I removed the manual static_call_tramp check -- that should
  already be handled by the noendbr check. ]

Reported-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S     |   1 +-
 arch/x86/kernel/head_64.S            |   1 +-
 tools/objtool/arch/x86/decode.c      |  15 ++-
 tools/objtool/check.c                | 112 ++++++++++++++------------
 tools/objtool/include/objtool/arch.h |   1 +-
 5 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 94ff83f..b200a19 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -87,6 +87,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 
 	.align 4
 .Lresume_point:
+	ANNOTATE_NOENDBR
 	/* We don't restore %rax, it must be 0 anyway */
 	movq	$saved_context, %rax
 	movq	saved_context_cr4(%rax), %rbx
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 16752b8..56163e2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -77,6 +77,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	lretq
 
 .Lon_kernel_cs:
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_END_OF_STACK
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ed6bff0..fe1362c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -456,10 +456,6 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		if (!rex_w)
 			break;
 
-		/* skip RIP relative displacement */
-		if (is_RIP())
-			break;
-
 		/* skip nontrivial SIB */
 		if (have_SIB()) {
 			modrm_rm = sib_base;
@@ -467,6 +463,12 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 				break;
 		}
 
+		/* lea disp(%rip), %dst */
+		if (is_RIP()) {
+			insn->type = INSN_LEA_RIP;
+			break;
+		}
+
 		/* lea disp(%src), %dst */
 		ADD_OP(op) {
 			op->src.offset = ins.displacement.value;
@@ -737,7 +739,10 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		break;
 	}
 
-	insn->immediate = ins.immediate.nbytes ? ins.immediate.value : 0;
+	if (ins.immediate.nbytes)
+		insn->immediate = ins.immediate.value;
+	else if (ins.displacement.nbytes)
+		insn->immediate = ins.displacement.value;
 
 	return 0;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6604f5d..7fc96c3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4392,6 +4392,51 @@ static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
 	return insn->offset == sym->offset + sym->len;
 }
 
+static int __validate_ibt_insn(struct objtool_file *file, struct instruction *insn,
+			       struct instruction *dest)
+{
+	if (dest->type == INSN_ENDBR) {
+		mark_endbr_used(dest);
+		return 0;
+	}
+
+	if (insn_func(dest) && insn_func(insn) &&
+	    insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
+		/*
+		 * Anything from->to self is either _THIS_IP_ or
+		 * IRET-to-self.
+		 *
+		 * There is no sane way to annotate _THIS_IP_ since the
+		 * compiler treats the relocation as a constant and is
+		 * happy to fold in offsets, skewing any annotation we
+		 * do, leading to vast amounts of false-positives.
+		 *
+		 * There's also compiler generated _THIS_IP_ through
+		 * KCOV and such which we have no hope of annotating.
+		 *
+		 * As such, blanket accept self-references without
+		 * issue.
+		 */
+		return 0;
+	}
+
+	/*
+	 * Accept anything ANNOTATE_NOENDBR.
+	 */
+	if (dest->noendbr)
+		return 0;
+
+	/*
+	 * Accept if this is the instruction after a symbol
+	 * that is (no)endbr -- typical code-range usage.
+	 */
+	if (noendbr_range(file, dest))
+		return 0;
+
+	WARN_INSN(insn, "relocation to !ENDBR: %s", offstr(dest->sec, dest->offset));
+	return 1;
+}
+
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
@@ -4404,6 +4449,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 	 * direct/indirect branches:
 	 */
 	switch (insn->type) {
+
 	case INSN_CALL:
 	case INSN_CALL_DYNAMIC:
 	case INSN_JUMP_CONDITIONAL:
@@ -4413,6 +4459,23 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 	case INSN_RETURN:
 	case INSN_NOP:
 		return 0;
+
+	case INSN_LEA_RIP:
+		if (!insn_reloc(file, insn)) {
+			/* local function pointer reference without reloc */
+
+			off = arch_jump_destination(insn);
+
+			dest = find_insn(file, insn->sec, off);
+			if (!dest) {
+				WARN_INSN(insn, "corrupt function pointer reference");
+				return 1;
+			}
+
+			return __validate_ibt_insn(file, insn, dest);
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -4423,13 +4486,6 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 					      reloc_offset(reloc) + 1,
 					      (insn->offset + insn->len) - (reloc_offset(reloc) + 1))) {
 
-		/*
-		 * static_call_update() references the trampoline, which
-		 * doesn't have (or need) ENDBR.  Skip warning in that case.
-		 */
-		if (reloc->sym->static_call_tramp)
-			continue;
-
 		off = reloc->sym->offset;
 		if (reloc_type(reloc) == R_X86_64_PC32 ||
 		    reloc_type(reloc) == R_X86_64_PLT32)
@@ -4441,47 +4497,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 		if (!dest)
 			continue;
 
-		if (dest->type == INSN_ENDBR) {
-			mark_endbr_used(dest);
-			continue;
-		}
-
-		if (insn_func(dest) && insn_func(insn) &&
-		    insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
-			/*
-			 * Anything from->to self is either _THIS_IP_ or
-			 * IRET-to-self.
-			 *
-			 * There is no sane way to annotate _THIS_IP_ since the
-			 * compiler treats the relocation as a constant and is
-			 * happy to fold in offsets, skewing any annotation we
-			 * do, leading to vast amounts of false-positives.
-			 *
-			 * There's also compiler generated _THIS_IP_ through
-			 * KCOV and such which we have no hope of annotating.
-			 *
-			 * As such, blanket accept self-references without
-			 * issue.
-			 */
-			continue;
-		}
-
-		/*
-		 * Accept anything ANNOTATE_NOENDBR.
-		 */
-		if (dest->noendbr)
-			continue;
-
-		/*
-		 * Accept if this is the instruction after a symbol
-		 * that is (no)endbr -- typical code-range usage.
-		 */
-		if (noendbr_range(file, dest))
-			continue;
-
-		WARN_INSN(insn, "relocation to !ENDBR: %s", offstr(dest->sec, dest->offset));
-
-		warnings++;
+		warnings += __validate_ibt_insn(file, insn, dest);
 	}
 
 	return warnings;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 0b303eb..d63b46a 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -28,6 +28,7 @@ enum insn_type {
 	INSN_CLD,
 	INSN_TRAP,
 	INSN_ENDBR,
+	INSN_LEA_RIP,
 	INSN_OTHER,
 };
 

