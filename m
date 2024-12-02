Return-Path: <linux-tip-commits+bounces-2946-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0F9E0040
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1B1633AB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439220C031;
	Mon,  2 Dec 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aI3HkPl8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="53Qm+Keh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960E20B7F1;
	Mon,  2 Dec 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138131; cv=none; b=JjLD/iY7w3jNM0B/ePtg8xmsb3miWvLls8655C3BvIPUU8MEuQqZo+OMOzYmxOeuQ4I8RSDPPq3jTBfxkC7237veSNGnAn4JCP3VVcnmAHRe6XMzUcO70snRIuEE9VtWwzyt5lmTtQpQYQbf0n1jvy2e9gsrOVBL/ELzg2R7v6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138131; c=relaxed/simple;
	bh=QLimVQ6eeXFtV4KmSTAkh8CFmI5eN5S+09qQsiPQhA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IgiqVwOeNigFN+XjFlEmRXIB/0ogxQo3bWteOZjDRY/Cut+o2433vb1Kavl0iGLFiCwOnOXuZCxvT0DSouz41dDumP5EAKbzdmWRAuvFv5nWkVArP8kOYrTTI11Y4Uoe8WCA6AnSTuY5PlE5Rxq4dVrtBIb1bTlZI8h/47VWyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aI3HkPl8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=53Qm+Keh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxN/k/Q6ZuDTOBkUfABWEfaA69tD83pTe8uG8kZbB/w=;
	b=aI3HkPl8vkdUvGVcqSBsw/x4Oi30sCBFxMFWX4fWfMUWh38mRO4hJ5wClG0bQpG/l+8jfB
	vKOYLOuxBuqcpTWwOeJG73a763lsWw+XA6Ci4vSbZVM2R21xPt90siZcnmcvkSY5TiSfWW
	TfQxd+U516HLlXY4OvnbSYhH0R8TNxxR1rgQiWl4MbjeAEPiPlXTrzT2mxFzzmkPWCIG9S
	25s5hEp6iQrTyI7SPqPML9gujCU+WK8DIcgS03EDzCA4/T7UyG68Cfu5BZXZc7DWyzf2kg
	CaN0fQ5mYk7VWK3KYQvFk0lmwbMxPbItwZAkK98Hu0s0cLsOVB0407JcpVMEjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxN/k/Q6ZuDTOBkUfABWEfaA69tD83pTe8uG8kZbB/w=;
	b=53Qm+KehgomA7WgLThS21zdvAQQBvboZAbbjxDGMKjzpidWyCo08VDmlRsSSqxCY4C6yUn
	vLXcABceUJHDspBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Convert ANNOTATE_IGNORE_ALTERNATIVE to ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.465691316@infradead.org>
References: <20241128094311.465691316@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812581.412.1644099505417971972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f0cd57c35a75f152d3b31b9be3f7f413b96a6d3f
Gitweb:        https://git.kernel.org/tip/f0cd57c35a75f152d3b31b9be3f7f413b96a6d3f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:42 +01:00

objtool: Convert ANNOTATE_IGNORE_ALTERNATIVE to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.465691316@infradead.org
---
 arch/x86/include/asm/alternative.h  | 14 +--------
 include/linux/objtool_types.h       |  1 +-
 tools/include/linux/objtool_types.h |  1 +-
 tools/objtool/check.c               | 45 ++++++----------------------
 4 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index dc03a64..595695f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 #include <asm/asm.h>
 
 #define ALT_FLAGS_SHIFT		16
@@ -58,11 +59,7 @@
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-#define ANNOTATE_IGNORE_ALTERNATIVE				\
-	"999:\n\t"						\
-	".pushsection .discard.ignore_alts\n\t"			\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
 
 /*
  * The patching flags are part of the upper bits of the @ft_flags parameter when
@@ -314,12 +311,7 @@ void nop_func(void);
  * objtool annotation to ignore the alternatives and only consider the original
  * instruction(s).
  */
-.macro ANNOTATE_IGNORE_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.ignore_alts
-	.long .Lannotate_\@
-	.popsection
-.endm
+#define ANNOTATE_IGNORE_ALTERNATIVE ANNOTATE type=ANNOTYPE_IGNORE_ALTS
 
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 16236a5..eab15db 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 16236a5..eab15db 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -62,5 +62,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
+#define ANNOTYPE_IGNORE_ALTS		6
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2a70374..ba2cb9b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1310,40 +1310,6 @@ static void add_uaccess_safe(struct objtool_file *file)
 }
 
 /*
- * FIXME: For now, just ignore any alternatives which add retpolines.  This is
- * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
- * But it at least allows objtool to understand the control flow *around* the
- * retpoline.
- */
-static int add_ignore_alternatives(struct objtool_file *file)
-{
-	struct section *rsec;
-	struct reloc *reloc;
-	struct instruction *insn;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
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
-			WARN("bad .discard.ignore_alts entry");
-			return -1;
-		}
-
-		insn->ignore_alts = true;
-	}
-
-	return 0;
-}
-
-/*
  * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
  * will be added to the .retpoline_sites section.
  */
@@ -2414,6 +2380,15 @@ static int read_annotate(struct objtool_file *file, int (*func)(int type, struct
 	return 0;
 }
 
+static int __annotate_ignore_alts(int type, struct instruction *insn)
+{
+	if (type != ANNOTYPE_IGNORE_ALTS)
+		return 0;
+
+	insn->ignore_alts = true;
+	return 0;
+}
+
 static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
@@ -2626,7 +2601,7 @@ static int decode_sections(struct objtool_file *file)
 	add_ignores(file);
 	add_uaccess_safe(file);
 
-	ret = add_ignore_alternatives(file);
+	ret = read_annotate(file, __annotate_ignore_alts);
 	if (ret)
 		return ret;
 

