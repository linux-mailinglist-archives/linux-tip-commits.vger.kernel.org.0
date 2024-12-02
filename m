Return-Path: <linux-tip-commits+bounces-2947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2489E003F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503AC280AAA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE020C463;
	Mon,  2 Dec 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z5WGHMbN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tL2ATSwj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7720B219;
	Mon,  2 Dec 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138131; cv=none; b=ueMnOLcliteRd4M674PBHSxbTDx4q0I0HHCjZzulKB3JlISqWj2lOHVSwz9bWu76KOkZyiMKLwqHDv2NRbMFKR8h3TOS8BYm0/3TSlHK1DxuLrLbnJov67uXVkFEIojKh4L0mGidao0jn03Ovyis8l6zIk3oUkvNj5X5e3ZtgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138131; c=relaxed/simple;
	bh=MIt9TOqpj5DjVrJ6BRqmwoAgMaspf+VahKFMjhnvrrQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qSb4qfjFZnAWW4E0wQWG0EjjaKPbEKj3N7QObvj9K/G71hu1aQvn+/HDH4RvfYTMHveKy9svC7AtwD85Dl4Xd9X9DnS4RBzcem0NEfmn4A5H6U5tyRlgZcUe+HjUSByAAXH9ZWR5goKYO165FWzoTq8Hsk6C+MJpISfE1fgXyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z5WGHMbN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tL2ATSwj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbcY+mf8rjqhklNBPdNT4oXBL1Olr8Fi69LCYAAEB7Q=;
	b=Z5WGHMbNpRNubR+tLR3ZsSnS8dcxQEaaPkt8HcL49mmuNaSsV5+I7+jXyRyr9viC/oKlBT
	krCFbYPPAK0m/Nt8eC1x0AelCzmphKwY6KjPx1Kc9ATC+tFuIB3cLk2Bp++EMN96b+N7ci
	EzCbqD7bmE0D0Y84mRF5Sxkd/kmafVlcBBglAiu/F+Nk+WgmvreIYPLn8z1Z/fr9fFn/F9
	TAMcD1ggJCfRTzFVo6CmUU195T9PYzdcRNFGgq8NzK1PwP/fuG9Q1Nl/aT0ALxjY5RgxLw
	G7zA+u2MV3xODLY3uivgPJeRRto5S5XUFbRhl02xcN5aMBdoRIoHUywXvr64bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbcY+mf8rjqhklNBPdNT4oXBL1Olr8Fi69LCYAAEB7Q=;
	b=tL2ATSwjFlqUvDwxWijZaLVlgNpUjomk0ZsVbfC8mVHVo8/zTIJSnczuJyMzZwEew/5P3N
	xBSIWWdvIuazlFAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.145275669@infradead.org>
References: <20241128094311.145275669@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812773.412.11234992239446433826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bf5febebd99fddfc6226a94e937d38a8d470b24e
Gitweb:        https://git.kernel.org/tip/bf5febebd99fddfc6226a94e937d38a8d470b24e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:41 +01:00

objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.145275669@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 13 +------
 include/linux/objtool_types.h        |  1 +-
 tools/include/linux/objtool_types.h  |  1 +-
 tools/objtool/check.c                | 52 +++++++++------------------
 4 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 96b410b..50340a1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -184,12 +184,7 @@
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
  * builds.
  */
-.macro ANNOTATE_RETPOLINE_SAFE
-.Lhere_\@:
-	.pushsection .discard.retpoline_safe
-	.long .Lhere_\@
-	.popsection
-.endm
+#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 
 /*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
@@ -350,11 +345,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_RETPOLINE_SAFE					\
-	"999:\n\t"						\
-	".pushsection .discard.retpoline_safe\n\t"		\
-	".long 999b\n\t"					\
-	".popsection\n\t"
+#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 4884f8c..1b34836 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 4884f8c..1b34836 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -58,5 +58,6 @@ struct unwind_hint {
  * Annotate types
  */
 #define ANNOTYPE_NOENDBR		1
+#define ANNOTYPE_RETPOLINE_SAFE		2
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a74ff26..c5b5230 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2373,12 +2373,12 @@ static int read_unwind_hints(struct objtool_file *file)
 	return 0;
 }
 
-static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+static int read_annotate(struct objtool_file *file, int (*func)(int type, struct instruction *insn))
 {
 	struct section *sec;
 	struct instruction *insn;
 	struct reloc *reloc;
-	int type;
+	int type, ret;
 
 	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
 	if (!sec)
@@ -2406,53 +2406,37 @@ static int read_annotate(struct objtool_file *file, void (*func)(int type, struc
 			return -1;
 		}
 
-		func(type, insn);
+		ret = func(type, insn);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
 }
 
-static void __annotate_noendbr(int type, struct instruction *insn)
+static int __annotate_noendbr(int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
-		return;
+		return 0;
 
 	insn->noendbr = 1;
+	return 0;
 }
 
-static int read_retpoline_hints(struct objtool_file *file)
+static int __annotate_retpoline_safe(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
-	if (!rsec)
+	if (type != ANNOTYPE_RETPOLINE_SAFE)
 		return 0;
 
-	for_each_reloc(rsec, reloc) {
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s", rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.retpoline_safe entry");
-			return -1;
-		}
-
-		if (insn->type != INSN_JUMP_DYNAMIC &&
-		    insn->type != INSN_CALL_DYNAMIC &&
-		    insn->type != INSN_RETURN &&
-		    insn->type != INSN_NOP) {
-			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
-			return -1;
-		}
-
-		insn->retpoline_safe = true;
+	if (insn->type != INSN_JUMP_DYNAMIC &&
+	    insn->type != INSN_CALL_DYNAMIC &&
+	    insn->type != INSN_RETURN &&
+	    insn->type != INSN_NOP) {
+		WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
+		return -1;
 	}
 
+	insn->retpoline_safe = true;
 	return 0;
 }
 
@@ -2742,7 +2726,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_retpoline_hints(file);
+	ret = read_annotate(file, __annotate_retpoline_safe);
 	if (ret)
 		return ret;
 

