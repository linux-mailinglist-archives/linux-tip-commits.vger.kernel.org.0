Return-Path: <linux-tip-commits+bounces-2942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C49E004B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84197B29848
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC17820C009;
	Mon,  2 Dec 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uCPnHGn4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b89Bl1cU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7120B21F;
	Mon,  2 Dec 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138129; cv=none; b=L3HDdwYO4JMiPzahC3ALtGfXb1mk7jYtD2NFsmseA9lrUL/6CivdY8/XS4es532edKlotpLz3nx2EIpuPHXkYM3yUp6lmSu7wSixUtHcW3BYzjVPv8oJRfUMCpA2AZupLkoCosx9Z4GaxkoXe8urnGG84N8SIQ12xkZSiwMRgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138129; c=relaxed/simple;
	bh=b+Nzu77nYAu45wU2pArFMLiCmJkQ9gGktSQDQfOBIHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d5Wp33PypKAGLtTCWjKtc7VU7YirRkpzCOpth143gCCRzjsSgVGhBxWEIRBUA/QGU0z8QZOKKRQun6/mUsWqlPmwy1qbol00v4zBfAohst7v6FxDqDUP3DG0mBDRSQdQhXRUxoZainMt/ZtlWztnjjqRblMc6cnpjbKjPwylddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uCPnHGn4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b89Bl1cU; arc=none smtp.client-ip=193.142.43.55
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
	bh=NIG+pH0wsVhwzI44+ni+1+6WnaPX/MO+S6LWfuUYK08=;
	b=uCPnHGn4N7Ft9a43UXgk6cJeYN81DxlJe3HxXapBy+gxUUIyelHE3ZfV7lyeIas+FG/WTc
	pgr2lCUTXozCRI1H4m6fQqLYyAuFPdscPSTZjGAS9U9Urj/tsythLlCipUCENmEXogUG0t
	j6DU0DQf8evhPH/OmLVJ+VtODdpXLLB0fvw79wmzkggMXs+cGiE9d8eIew5aYkNS5sy/oS
	OR2MG3duDhswvVPWg2TieHEq3d/MW+PrN7RXZaIbbeeU53d1nllQwg7jvBAKqWVeqo5X0S
	dsSUPrKNb/uVsxIET4K944qzE4Ut7+jGcRLf3pWTyJpi9dynOGwqjBl+nLTe0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIG+pH0wsVhwzI44+ni+1+6WnaPX/MO+S6LWfuUYK08=;
	b=b89Bl1cUf7vOHKX+shcviUHSDntkmND0RnZC9kpHb66ytznOPvkVMXIz0LCB1B5xU11z0z
	e7s/xWVHgyUtT5Ag==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Convert ANNOTATE_INTRA_FUNCTION_CALL to ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.584892071@infradead.org>
References: <20241128094311.584892071@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812518.412.4730394053129788393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     112765ca1cb9353e71b4f5af4e6e6c4a69c28d99
Gitweb:        https://git.kernel.org/tip/112765ca1cb9353e71b4f5af4e6e6c4a69c28d99
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:42 +01:00

objtool: Convert ANNOTATE_INTRA_FUNCTION_CALL to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.584892071@infradead.org
---
 include/linux/objtool.h             | 16 +----
 include/linux/objtool_types.h       |  1 +-
 tools/include/linux/objtool_types.h |  1 +-
 tools/objtool/check.c               | 96 +++++++++++-----------------
 4 files changed, 47 insertions(+), 67 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 5f0bf80..42287c1 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -68,16 +68,6 @@
 #else /* __ASSEMBLY__ */
 
 /*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warning.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL				\
-	999:							\
-	.pushsection .discard.intra_function_calls;		\
-	.long 999b;						\
-	.popsection;
-
-/*
  * In asm, there are two kinds of code: normal C-type callable functions and
  * the rest.  The normal callable functions can be called by other code, and
  * don't do anything unusual with the stack.  Such normal callable functions
@@ -154,6 +144,12 @@
 
 #define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL ANNOTATE type=ANNOTYPE_INTRA_FUNCTION_CALL
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index eab15db..23d6fb6 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -63,5 +63,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
+#define ANNOTYPE_INTRA_FUNCTION_CALL	7
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index eab15db..23d6fb6 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -63,5 +63,6 @@ struct unwind_hint {
 #define ANNOTYPE_INSTR_END		4
 #define ANNOTYPE_UNRET_BEGIN		5
 #define ANNOTYPE_IGNORE_ALTS		6
+#define ANNOTYPE_INTRA_FUNCTION_CALL	7
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ba2cb9b..2222fe7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2339,7 +2339,8 @@ static int read_unwind_hints(struct objtool_file *file)
 	return 0;
 }
 
-static int read_annotate(struct objtool_file *file, int (*func)(int type, struct instruction *insn))
+static int read_annotate(struct objtool_file *file,
+			 int (*func)(struct objtool_file *file, int type, struct instruction *insn))
 {
 	struct section *sec;
 	struct instruction *insn;
@@ -2372,7 +2373,7 @@ static int read_annotate(struct objtool_file *file, int (*func)(int type, struct
 			return -1;
 		}
 
-		ret = func(type, insn);
+		ret = func(file, type, insn);
 		if (ret < 0)
 			return ret;
 	}
@@ -2380,7 +2381,7 @@ static int read_annotate(struct objtool_file *file, int (*func)(int type, struct
 	return 0;
 }
 
-static int __annotate_ignore_alts(int type, struct instruction *insn)
+static int __annotate_ignore_alts(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_IGNORE_ALTS)
 		return 0;
@@ -2389,7 +2390,7 @@ static int __annotate_ignore_alts(int type, struct instruction *insn)
 	return 0;
 }
 
-static int __annotate_noendbr(int type, struct instruction *insn)
+static int __annotate_noendbr(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_NOENDBR)
 		return 0;
@@ -2398,7 +2399,37 @@ static int __annotate_noendbr(int type, struct instruction *insn)
 	return 0;
 }
 
-static int __annotate_retpoline_safe(int type, struct instruction *insn)
+static int __annotate_ifc(struct objtool_file *file, int type, struct instruction *insn)
+{
+	unsigned long dest_off;
+
+	if (type != ANNOTYPE_INTRA_FUNCTION_CALL)
+		return 0;
+
+	if (insn->type != INSN_CALL) {
+		WARN_INSN(insn, "intra_function_call not a direct call");
+		return -1;
+	}
+
+	/*
+	 * Treat intra-function CALLs as JMPs, but with a stack_op.
+	 * See add_call_destinations(), which strips stack_ops from
+	 * normal CALLs.
+	 */
+	insn->type = INSN_JUMP_UNCONDITIONAL;
+
+	dest_off = arch_jump_destination(insn);
+	insn->jump_dest = find_insn(file, insn->sec, dest_off);
+	if (!insn->jump_dest) {
+		WARN_INSN(insn, "can't find call dest at %s+0x%lx",
+			  insn->sec->name, dest_off);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __annotate_retpoline_safe(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_RETPOLINE_SAFE)
 		return 0;
@@ -2415,7 +2446,7 @@ static int __annotate_retpoline_safe(int type, struct instruction *insn)
 	return 0;
 }
 
-static int __annotate_instr(int type, struct instruction *insn)
+static int __annotate_instr(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
 	case ANNOTYPE_INSTR_BEGIN:
@@ -2433,7 +2464,7 @@ static int __annotate_instr(int type, struct instruction *insn)
 	return 0;
 }
 
-static int __annotate_unret(int type, struct instruction *insn)
+static int __annotate_unret(struct objtool_file *file, int type, struct instruction *insn)
 {
 	if (type != ANNOTYPE_UNRET_BEGIN)
 		return 0;
@@ -2443,55 +2474,6 @@ static int __annotate_unret(int type, struct instruction *insn)
 
 }
 
-static int read_intra_function_calls(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *rsec;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		unsigned long dest_off;
-
-		if (reloc->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in %s",
-			     rsec->name);
-			return -1;
-		}
-
-		insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.intra_function_call entry");
-			return -1;
-		}
-
-		if (insn->type != INSN_CALL) {
-			WARN_INSN(insn, "intra_function_call not a direct call");
-			return -1;
-		}
-
-		/*
-		 * Treat intra-function CALLs as JMPs, but with a stack_op.
-		 * See add_call_destinations(), which strips stack_ops from
-		 * normal CALLs.
-		 */
-		insn->type = INSN_JUMP_UNCONDITIONAL;
-
-		dest_off = arch_jump_destination(insn);
-		insn->jump_dest = find_insn(file, insn->sec, dest_off);
-		if (!insn->jump_dest) {
-			WARN_INSN(insn, "can't find call dest at %s+0x%lx",
-				  insn->sec->name, dest_off);
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * Return true if name matches an instrumentation function, where calls to that
  * function from noinstr code can safely be removed, but compilers won't do so.
@@ -2630,7 +2612,7 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_call_destination(); it changes INSN_CALL to
 	 * INSN_JUMP.
 	 */
-	ret = read_intra_function_calls(file);
+	ret = read_annotate(file, __annotate_ifc);
 	if (ret)
 		return ret;
 

