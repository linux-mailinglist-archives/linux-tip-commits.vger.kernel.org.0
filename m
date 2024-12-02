Return-Path: <linux-tip-commits+bounces-2949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72869E0132
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DED4B2F91C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E020CCE4;
	Mon,  2 Dec 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3An67asQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9u+QouX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A820C466;
	Mon,  2 Dec 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138134; cv=none; b=K14lka3hT+FG+qQET248M0vwa0HsjiwmnPc4uPEFjz95WHnyj+0HzZdOCaM4E4+omTqTX2FYj9I0PWnJbc0UIEOfdk5/jkFR0SK3v6i77wmwNyJ0s/pHAbR473oGaEM9cI+b5WIsjA98xii9BwN/vXRadp7PKKYedNS5ZR+t1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138134; c=relaxed/simple;
	bh=mhtSY1tEtuR80uEENsYKNyrBvkIErfBq88lHAd8u+jM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cN6bthWN/lKETa6+UwEwsqrBwUIN6Y2ikFvVYZ6sBRRL6W6ifYFHz2OL76H1cBoy2jC11eJoYHBIKVVCCDvg10A+TuH3gBfPAcYaRvRy9FKxM1xUSwIlxLHVhm8H/AhZLTzJEjS7sgd8kKFGSTT80Zr1oriA2aYCUvbc+d8tOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3An67asQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9u+QouX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a143BQDIDiNZGBcnUATd4Hufct/QKN9Q4u6lSsjuZY8=;
	b=3An67asQbkjIqwQmfrwiyDE2vfgoaLd6xpZU3GBWoPRW1vKRiL0ENX+qf/tM7poyxSKes7
	imUm5aGs8Qdxgd4zdTrVWJ6q1HCkaCAqyqum5+SE4zffQT9QNwAyz/Sg6gxYw0OXSVQar0
	ffx7HI6D8Kpd8iKomN6nd1tDDqGqbtZASisMI/zpcvYOHHbJoyzMjsTCNf47xMx2UPYJog
	v21ttwk8lTjUGEkxrg7p8FxfN7HvmaQsy9xZIdcyzS7I8/RfYqexx6ah0TO33QT+RUAgVo
	0d2VtafOnJ2P8ov7SESnFwQR1MR9r76D9FMROvW+zaBKn+xtDKEHORdQoximSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a143BQDIDiNZGBcnUATd4Hufct/QKN9Q4u6lSsjuZY8=;
	b=Y9u+QouXmmZ9fPwFmbtf228ybfeOVm1+Xy49JJZukBkHyUQ2lqLrRzqF3X9HqMGg+GKEQF
	/Uh1FsHOokCV5OCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Generic annotation infrastructure
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094310.932794537@infradead.org>
References: <20241128094310.932794537@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812953.412.13184515011509006903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2116b349e29a2e9ba17ea2e45b31234e4b350793
Gitweb:        https://git.kernel.org/tip/2116b349e29a2e9ba17ea2e45b31234e4b350793
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:38:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:41 +01:00

objtool: Generic annotation infrastructure

Avoid endless .discard.foo sections for each annotation, create a
single .discard.annotate_insn section that takes an annotation type along
with the instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094310.932794537@infradead.org
---
 include/linux/objtool.h | 18 ++++++++++++++++-
 tools/objtool/check.c   | 45 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b3b8d3d..d98531e 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -57,6 +57,13 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(type)						\
+	"911:\n\t"							\
+	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
+	".long 911b - .\n\t"						\
+	".long " __stringify(type) "\n\t"				\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -146,6 +153,14 @@
 	.popsection
 .endm
 
+.macro ANNOTATE type:req
+.Lhere_\@:
+	.pushsection .discard.annotate_insn,"M",@progbits,8
+	.long	.Lhere_\@ - .
+	.long	\type
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -155,6 +170,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ASM_ANNOTATE(type)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
@@ -167,6 +183,8 @@
 .endm
 .macro REACHABLE
 .endm
+.macro ANNOTATE type:req
+.endm
 #endif
 
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4ce176a..b0efc8e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2373,6 +2373,49 @@ static int read_unwind_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+	int type;
+
+	sec = find_section_by_name(file->elf, ".discard.annotate_insn");
+	if (!sec)
+		return 0;
+
+	if (!sec->rsec)
+		return 0;
+
+	if (sec->sh.sh_entsize != 8) {
+		static bool warned = false;
+		if (!warned) {
+			WARN("%s: dodgy linker, sh_entsize != 8", sec->name);
+			warned = true;
+		}
+		sec->sh.sh_entsize = 8;
+	}
+
+	for_each_reloc(sec->rsec, reloc) {
+		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
+
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
+		if (!insn) {
+			WARN("bad .discard.annotate_insn entry: %d of type %d", reloc_idx(reloc), type);
+			return -1;
+		}
+
+		func(type, insn);
+	}
+
+	return 0;
+}
+
+static void __annotate_nop(int type, struct instruction *insn)
+{
+}
+
 static int read_noendbr_hints(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -2670,6 +2713,8 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	read_annotate(file, __annotate_nop);
+
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */

