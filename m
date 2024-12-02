Return-Path: <linux-tip-commits+bounces-2944-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3C9E003D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B28281BCB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276020C029;
	Mon,  2 Dec 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2G0vjTkO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ID3p7TBP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8E20B81D;
	Mon,  2 Dec 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138131; cv=none; b=dtGO3e7WhTlbyY/SXBdRZssvs62I9Mzxcu+R6DzEGPOUhH2fWkeKC/wpxoqcS5Xy4ucDkkaNl4p3WkEstZI2FGEJp5SgEJLjpx4EO16X5sdqPqXEgKloC/x58PNs9qOVdNR6L5t62IyUiTTK1HwDb2H0OJmM7mdqqmL1hglOyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138131; c=relaxed/simple;
	bh=IImsI5C4cPfP0rfjzdvZFalNH03cufmmAnxf7kEKksw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EZZFpm09UZINwDIBgsCjCHjTPapi5vdmF8ZlotTKfLO2UY8rHox44yGheQ4Z6nS9FQR+ZfcCM1nSOppfvCSLwUbJ40dX2OExaplI1hPzMsdlcCjvyLjKWZxPkqjXz/W8p+QgSh4QGgUDOCa9+6tsQG50BoywiPrvSiMxX2iZWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2G0vjTkO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ID3p7TBP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqiB/Z56MwPR/QJ7sMrTZU15lbRJpaoINskHUg6F9vQ=;
	b=2G0vjTkOZ0k7ScbTQ2fC+7BkE1qsvwjv4h8H7jT+A73+5s+4oY4qy2pNXDX6/6BRJY3aSz
	ikjcuPyP7YXLAiZ9caklScfiyaik3XldopwBLEDplddt6nr3W3/sABF96le82p7VKUPLyk
	hBLP/499qIh90L9SyhEa8yyg+WJDWRcd45/bdjcwV1Hbn7g6zDg3zKL+lSHXqYhfVl7N+h
	Tn+x2Q17uYWAsxk36qDjvYVQcknW5WycA5l0SXM0dWTXTV3Xp1qXyKuqskwKloKj70swxD
	L1YsSYheigsnGHzT3LE3EFmmnODv5JpTRaABm7igsIQ0Rj6FHSyr1F1M4uIn7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqiB/Z56MwPR/QJ7sMrTZU15lbRJpaoINskHUg6F9vQ=;
	b=ID3p7TBPy1Xn5JFeCQDSjlO2IIQQljMj9nUUDRfY+ol7lDKy9gPJ+jit7za8suNHubin0Z
	HdJhFDuX0GcY+0CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Convert VALIDATE_UNRET_BEGIN to ANNOTATE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094311.358508242@infradead.org>
References: <20241128094311.358508242@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812649.412.3552623443866434798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     18aa6118a1689b4d73c5ebbd917ae3f20c9c0db1
Gitweb:        https://git.kernel.org/tip/18aa6118a1689b4d73c5ebbd917ae3f20c9c0db1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:42 +01:00

objtool: Convert VALIDATE_UNRET_BEGIN to ANNOTATE

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094311.358508242@infradead.org
---
 include/linux/objtool.h             |  9 +++------
 include/linux/objtool_types.h       |  1 +-
 tools/include/linux/objtool_types.h |  1 +-
 tools/objtool/check.c               | 28 +++++-----------------------
 4 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 89c67cd..5f0bf80 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -130,15 +130,12 @@
  * NOTE: The macro must be used at the beginning of a global symbol, otherwise
  * it will be ignored.
  */
-.macro VALIDATE_UNRET_BEGIN
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
 	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
-.Lhere_\@:
-	.pushsection .discard.validate_unret
-	.long	.Lhere_\@ - .
-	.popsection
+#define VALIDATE_UNRET_BEGIN	ANNOTATE type=ANNOTYPE_UNRET_BEGIN
+#else
+#define VALIDATE_UNRET_BEGIN
 #endif
-.endm
 
 .macro REACHABLE
 .Lhere_\@:
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index d4d68dd..16236a5 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index d4d68dd..16236a5 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -61,5 +61,6 @@ struct unwind_hint {
 #define ANNOTYPE_RETPOLINE_SAFE		2
 #define ANNOTYPE_INSTR_BEGIN		3
 #define ANNOTYPE_INSTR_END		4
+#define ANNOTYPE_UNRET_BEGIN		5
 
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8e39c7f..2a70374 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2458,33 +2458,15 @@ static int __annotate_instr(int type, struct instruction *insn)
 	return 0;
 }
 
-static int read_validate_unret_hints(struct objtool_file *file)
+static int __annotate_unret(int type, struct instruction *insn)
 {
-	struct section *rsec;
-	struct instruction *insn;
-	struct reloc *reloc;
-
-	rsec = find_section_by_name(file->elf, ".rela.discard.validate_unret");
-	if (!rsec)
+	if (type != ANNOTYPE_UNRET_BEGIN)
 		return 0;
 
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
-		insn->unret = 1;
-	}
-
+	insn->unret = 1;
 	return 0;
-}
 
+}
 
 static int read_intra_function_calls(struct objtool_file *file)
 {
@@ -2705,7 +2687,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_validate_unret_hints(file);
+	ret = read_annotate(file, __annotate_unret);
 	if (ret)
 		return ret;
 

