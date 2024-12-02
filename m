Return-Path: <linux-tip-commits+bounces-2948-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A59E0046
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D05281F99
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01320C494;
	Mon,  2 Dec 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdq7rSCG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPxsCFRN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2A20C01C;
	Mon,  2 Dec 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138133; cv=none; b=Aa8dTgd65aJUr/EFUyKEFVnFCyM5yBjknHafif/6DEeqzl8r7KZvchxd63RbaEgoNE00oQod7rhh4W2xqt19FuIz0RnpYjX+pzy3xWWGVtznuABvJnkmSSbMTbKLwr6uH22OmplZ/hhJXdgavEASvAGQ3SF7bviwPlam+hsZ5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138133; c=relaxed/simple;
	bh=JjJTb/K3FUYBJA4HjpYJdwb/SoDKSVa0tHF04CZVJtI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mLgdeIl9TZicFwThbD2FbGpG4o6RHaKci637yzCxECiH+xcLmOvYf84759zWdxL6Q28d0tKt3FYTdpHVvfu1sLHA6tmCPCY+YmPHFKKEx7S50IkZrzJbexnK82KbG9gxEV3B8WdXkqzu1/QPPoaSrv9HzDv/1JKtv+Am2im+esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdq7rSCG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPxsCFRN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dp7yLcgvHicRLKHlQTK8frZUclc2Ejnk1Q+pECFOcJM=;
	b=rdq7rSCGZAt68k2WLpY+aGmkVYdJPFqrrkj1fac4R+bxhZKwoLh03u32aYCQ2vEA+vC934
	sJ+rHYTZATfcLV4tpj2MmypRcKHclAxtyx3boidAQoalc9/W6Z7NukCv9xB/Bh3OAISw2f
	4eNq8iOd2ODZ92VTMQSKh8ZQtRfK5e9FoqOT7vepOy0D+qiOmAfE6AsplINrcDBYpQOt0p
	aW9WJV/kH/kqR8FcjgpQgxGbUApA0ZZlUL9i17MaZlowHcdiSkVBTTxyZUtmxpreV+lHxr
	8CO2mBzKdFNdM5ogk2FEM3HvvgaXneDZcQ1BGNLXjgTZnTFMkl/kQokvXiMyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dp7yLcgvHicRLKHlQTK8frZUclc2Ejnk1Q+pECFOcJM=;
	b=HPxsCFRNaEJ8sVjgP/l7bQ3RrmC6y+C77Q0+/IpFghtaUhYUcus/0BKnq0eU+cU2BTxa/X
	IUherv45T7DIvXBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Convert ANNOTATE_NOENDBR to ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.042140333@infradead.org>
References: <20241128094311.042140333@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812836.412.6151735662262429791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     22c3d58079688b697f36d670616e463cbb14d058
Gitweb:        https://git.kernel.org/tip/22c3d58079688b697f36d670616e463cbb14d058
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:41 +01:00

objtool: Convert ANNOTATE_NOENDBR to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.042140333@infradead.org
---
 include/linux/objtool.h             | 17 +++------------
 include/linux/objtool_types.h       |  5 ++++-
 tools/include/linux/objtool_types.h |  5 ++++-
 tools/objtool/check.c               | 32 ++++------------------------
 4 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index d98531e..b5e9c0a 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,12 +45,6 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
-#define ANNOTATE_NOENDBR					\
-	"986: \n\t"						\
-	".pushsection .discard.noendbr\n\t"			\
-	".long 986b\n\t"					\
-	".popsection\n\t"
-
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
@@ -64,6 +58,8 @@
 	".long " __stringify(type) "\n\t"				\
 	".popsection\n\t"
 
+#define ANNOTATE_NOENDBR	ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -122,13 +118,6 @@
 #endif
 .endm
 
-.macro ANNOTATE_NOENDBR
-.Lhere_\@:
-	.pushsection .discard.noendbr
-	.long	.Lhere_\@
-	.popsection
-.endm
-
 /*
  * Use objtool to validate the entry requirement that all code paths do
  * VALIDATE_UNRET_END before RET.
@@ -161,6 +150,8 @@
 	.popsection
 .endm
 
+#define ANNOTATE_NOENDBR	ANNOTATE type=ANNOTYPE_NOENDBR
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index 453a4f4..4884f8c 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index 453a4f4..4884f8c 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -54,4 +54,9 @@ struct unwind_hint {
 #define UNWIND_HINT_TYPE_SAVE		6
 #define UNWIND_HINT_TYPE_RESTORE	7
 
+/*
+ * Annotate types
+ */
+#define ANNOTYPE_NOENDBR		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b0efc8e..a74ff26 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2412,32 +2412,12 @@ static int read_annotate(struct objtool_file *file, void (*func)(int type, struc
 	return 0;
 }
 
-static void __annotate_nop(int type, struct instruction *insn)
+static void __annotate_noendbr(int type, struct instruction *insn)
 {
-}
-
-static int read_noendbr_hints(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct section *rsec;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.noendbr");
-	if (!rsec)
-		return 0;
-
-	for_each_reloc(rsec, reloc) {
-		insn = find_insn(file, reloc->sym->sec,
-				 reloc->sym->offset + reloc_addend(reloc));
-		if (!insn) {
-			WARN("bad .discard.noendbr entry");
-			return -1;
-		}
-
-		insn->noendbr = 1;
-	}
+	if (type != ANNOTYPE_NOENDBR)
+		return;
 
-	return 0;
+	insn->noendbr = 1;
 }
 
 static int read_retpoline_hints(struct objtool_file *file)
@@ -2713,12 +2693,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	read_annotate(file, __annotate_nop);
-
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */
-	ret = read_noendbr_hints(file);
+	ret = read_annotate(file, __annotate_noendbr);
 	if (ret)
 		return ret;
 

