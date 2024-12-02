Return-Path: <linux-tip-commits+bounces-2937-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3E9E002E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31618280E1D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD20209F59;
	Mon,  2 Dec 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLOQkh9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mN25H0yS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EB1FDE12;
	Mon,  2 Dec 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138124; cv=none; b=Af2tRKoi/kH+uBOMe1Rc499KoIoOPz3Ni73QGJkQ4gejbhcCs0zJPgki9P1h5fz394MPm0iBY96Gj7vtytp7v7MOPV3P2eMuGNd4AEYNjbTWrjRN+Iya2cgittiUD6sEiHQ4W7uJQ+ExIwijjElVoOFfZvPYpMp0MnX1r2gkPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138124; c=relaxed/simple;
	bh=WYvscfolYwTYFlr4i0pSeWwAlRFo+lFLAyK+YWYPDGs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cfxechkr4HOJEOyDDYETCL+DJj/eK1b2Clrrbkxau/bkSga3L/qL67+TbF3XzWuLC3vKD70X33Tp4lpVWeehrNlqFxyfylyNGlW2cNLACboCP1LUQXYTNcWqh7eS78+zz9JpP0pxZwfExEHG5pzePzn/WjHWOjK9NtxXk3OOw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MLOQkh9Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mN25H0yS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqqTBxgZazFvgxzXajXNNRgEP277M2bWDFyB7C1D/rU=;
	b=MLOQkh9Yy1F22RvCG6AKbyWhsHDxQtlyzlfN8wyaT+yaZDc1uBm+pbT/t0NU9rRTIh3fgL
	fj8YdOm2wHbmbzlkymwWEuti4sJ4URbIfkfI95ziH1NnG2uQ0N0HKaWSlzXFm6NFYa7fxt
	Fy/RUP0/83vRmSbzkhZdXEqm36PITb5QvroiAsAINUiUckssfmKfW/29p7ZfNbpg1ByVhv
	jiWG4JWD7AjKAx6R+u38J8Baq3ZZAv6PqHpXdhYQhOD018Z09m/h3lR304+ElDxu9cz7vv
	aCb/ypecwq29cQL2WtH8grWf+0FGrlHJxdAV7IGVsZIrcV6FXvRDYQXrqjCejw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqqTBxgZazFvgxzXajXNNRgEP277M2bWDFyB7C1D/rU=;
	b=mN25H0ySLuap5E6nQRAJP2UszP2PdPnchBgTCpp2JrylgbyObjFo/Xk5X6Dl7alt91BeWk
	EfPVtqtwj6yjKRDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove annotate_{,un}reachable()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.235637588@infradead.org>
References: <20241128094312.235637588@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812047.412.11115240430409095319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     06e24745985c8dd0da18337503afcf2f2fdbdff1
Gitweb:        https://git.kernel.org/tip/06e24745985c8dd0da18337503afcf2f2fdbdff1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:44 +01:00

objtool: Remove annotate_{,un}reachable()

There are no users of annotate_reachable() left.

And the annotate_unreachable() usage in unreachable() is plain wrong;
it will hide dangerous fall-through code-gen.

Remove both.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.235637588@infradead.org
---
 include/linux/compiler.h | 27 +------------------------
 tools/objtool/check.c    | 43 +--------------------------------------
 2 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7be8089..3d9a0e4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -109,35 +109,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
-/*
- * These macros help objtool understand GCC code flow for unreachable code.
- * The __COUNTER__ based labels are a hack to make each instance of the macros
- * unique, to convince GCC not to merge duplicate inline asm statements.
- */
-#define __stringify_label(n) #n
-
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-			".pushsection .discard.reachable\n\t"		\
-			".long " __stringify_label(c) "b - .\n\t"	\
-			".popsection\n\t");				\
-})
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
-
-#define __annotate_unreachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
-})
-#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
-
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
-
 #else /* !CONFIG_OBJTOOL */
-#define annotate_reachable()
-#define annotate_unreachable()
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
@@ -147,7 +121,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * control elsewhere.
  */
 #define unreachable() do {		\
-	annotate_unreachable();		\
 	barrier_before_unreachable();	\
 	__builtin_unreachable();	\
 } while (0)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3bea8b2..798cff5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -638,47 +638,8 @@ static int add_dead_ends(struct objtool_file *file)
 	uint64_t offset;
 
 	/*
-	 * Check for manually annotated dead ends.
-	 */
-	rsec = find_section_by_name(file->elf, ".rela.discard.unreachable");
-	if (!rsec)
-		goto reachable;
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
-				WARN("can't find unreachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, offset);
-				return -1;
-			}
-		} else {
-			WARN("can't find unreachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, offset);
-			return -1;
-		}
-
-		insn->dead_end = true;
-	}
-
-reachable:
-	/*
-	 * These manually annotated reachable checks are needed for GCC 4.4,
-	 * where the Linux unreachable() macro isn't supported.  In that case
-	 * GCC doesn't know the "ud2" is fatal, so it generates code as if it's
-	 * not a dead end.
+	 * UD2 defaults to being a dead-end, allow them to be annotated for
+	 * non-fatal, eg WARN.
 	 */
 	rsec = find_section_by_name(file->elf, ".rela.discard.reachable");
 	if (!rsec)

