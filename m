Return-Path: <linux-tip-commits+bounces-2945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294C9E003E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A8D1632FF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B220C02F;
	Mon,  2 Dec 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xboNNN7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wahl9h77"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22020C003;
	Mon,  2 Dec 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138131; cv=none; b=fEezeAd4STnKU7jDYO/rov0ibtLFOIb1on702lON3b2IfSrhaxrIPXt8VbSrR1pG8tNqUVgxkMCGr9Mw1XWGJgtR6wYWfsYKWg5mE2ksfN/A0uRbcdV9HSwaeGat4Zo+Nhw/NW4Djr3DDTpx6rs5F8whox+UxdYarMFQqF4xByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138131; c=relaxed/simple;
	bh=TH7fgtjHeJvR5AzlWMF51HLcof6KpACoyKVe8+WIa+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tqszN+PXsEYL1h+HxHQ+5PcpQ30I70oQapVdL5Kf/EF8ipQXr5u8CcfL6AQA1WSn0MIebe0gBbJVx+HaBvIisvKW8ZtDkgJwSSaDB6pEcQpM4hM4Zg1vjd1pihVdlC6Lz2kj6bShR4w3BQEBClycOUkm3YJZSw9Q8WAcDn6boD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xboNNN7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wahl9h77; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaxNZ7pjvOKItgEbUBuLyQwt/Iffxhsc6jpj+9oJwX4=;
	b=xboNNN7aTuUu43SoF7eCIy1RspByiNq7qxZU4nZnwnaTcqWrJvIlTLh604jD/0XLjK3oCI
	q4cGI9hBV4Qbb6/3U8GrKQTCnT9bOix9qdX50rFasfTK1i//JRe6yqLczKgqPudX37P47n
	T5SteE/ifC04mova9mX2uyYXHQQyNI6I3r/rgcIfEEDxos0CJeXxaJS3i88L6dXN+GBCL7
	ltDD+69WcPitlIn/nmiHdMP1PHeB5C8uUGmoFPnfgrDyiTSOwBibam5lGqs0ZKHgzQBz12
	LHMr+rPdIHSk9rfuwvSIOa+c5RUJHQAqX93v78U+gypzWXtXiw1HcjNwB+qx3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaxNZ7pjvOKItgEbUBuLyQwt/Iffxhsc6jpj+9oJwX4=;
	b=wahl9h77VYMpW75iT97NOOiTjSswKcY09br3c0JcnbIsf9FmAPAMkg0VgZt2xZ8a8ONS8r
	1dLm5HFjUayFaHAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Convert instrumentation_{begin,end}() to
 ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.245980207@infradead.org>
References: <20241128094311.245980207@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812711.412.9338346281747074451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     317f2a64618c528539d17fe6957a64106087fbd2
Gitweb:        https://git.kernel.org/tip/317f2a64618c528539d17fe6957a64106087fbd2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:41 +01:00

objtool: Convert instrumentation_{begin,end}() to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.245980207@infradead.org
---
 include/linux/instrumentation.h     | 11 ++----
 include/linux/objtool.h             | 12 +++++--
 include/linux/objtool_types.h       |  2 +-
 tools/include/linux/objtool_types.h |  2 +-
 tools/objtool/check.c               | 49 +++++-----------------------
 5 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index bc7babe..c8f866c 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,14 +4,14 @@
 
 #ifdef CONFIG_NOINSTR_VALIDATION
 
+#include <linux/objtool.h>
 #include <linux/stringify.h>
 
 /* Begin/end of an instrumentation safe region */
 #define __instrumentation_begin(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_BEGIN)\
+		     : : "i" (c));					\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -48,9 +48,8 @@
  */
 #define __instrumentation_end(c) ({					\
 	asm volatile(__stringify(c) ": nop\n\t"				\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t" : : "i" (c));			\
+		     __ASM_ANNOTATE(__ASM_BREF(c), ANNOTYPE_INSTR_END)	\
+		     : : "i" (c));					\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else /* !CONFIG_NOINSTR_VALIDATION */
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b5e9c0a..89c67cd 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -51,13 +51,18 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
-#define ASM_ANNOTATE(type)						\
-	"911:\n\t"							\
+#define __ASM_BREF(label)	label ## b
+
+#define __ASM_ANNOTATE(label, type)					\
 	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
-	".long 911b - .\n\t"						\
+	".long " __stringify(label) " - .\n\t"			\
 	".long " __stringify(type) "\n\t"				\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(type)						\
+	"911:\n\t"						\
+	__ASM_ANNOTATE(911b, type)
+
 #define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
 
 #else /* __ASSEMBLY__ */
@@ -161,6 +166,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define __ASM_ANNOTATE(label, type)
 #define ASM_ANNOTATE(type)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 1b34836..d4d68dd 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -59,5 +59,7 @@ struct unwind_hint {
  */
 #define ANNOTYPE_NOENDBR		1
 #define ANNOTYPE_RETPOLINE_SAFE		2
+#define ANNOTYPE_INSTR_BEGIN		3
+#define ANNOTYPE_INSTR_END		4
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 1b34836..d4d68dd 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -59,5 +59,7 @@ struct unwind_hint {
  */
 #define ANNOTYPE_NOENDBR		1
 #define ANNOTYPE_RETPOLINE_SAFE		2
+#define ANNOTYPE_INSTR_BEGIN		3
+#define ANNOTYPE_INSTR_END		4
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c5b5230..8e39c7f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2440,48 +2440,19 @@ static int __annotate_retpoline_safe(int type, struct instruction *insn)
 	return 0;
 }
 
-static int read_instr_hints(struct objtool_file *file)
+static int __annotate_instr(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.instr_end");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.instr_end entry");
-			return -1;
-		}
+	switch (type) {
+	case ANNOTYPE_INSTR_BEGIN:
+		insn->instr++;
+		break;
 
+	case ANNOTYPE_INSTR_END:
 		insn->instr--;
-	}
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.instr_begin");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.instr_begin entry");
-			return -1;
-		}
+		break;
 
-		insn->instr++;
+	default:
+		break;
 	}
 
 	return 0;
@@ -2730,7 +2701,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_instr_hints(file);
+	ret = read_annotate(file, __annotate_instr);
 	if (ret)
 		return ret;
 

