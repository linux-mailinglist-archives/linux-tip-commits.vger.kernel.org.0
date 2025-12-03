Return-Path: <linux-tip-commits+bounces-7606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF53CA1257
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5E2F30022DA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C583271E0;
	Wed,  3 Dec 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLgg/PaS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RePtJlh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B522579E;
	Wed,  3 Dec 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787733; cv=none; b=WjRQDB1IwcMZQ3SgnPzea53Fodr5kIEFe2VGPCzXp+HS/B+Op7B4YmYKaugOHYKuZxbSm0dyEJGJ0nCkjY3aEyX6Ow8zdkVgWAiNMNI4EiZplVphxoObkAbfU9v0aaZ1HEEnEJGz7AiYb2jkPhg8XAqxMjHVTkhPqpKJRRv0dWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787733; c=relaxed/simple;
	bh=s/E2K0o56Ig7ALkRetZ2zox89tzvA1HkKpEibVvlCTw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KaMVz0lW76rmT1KdgKMiSYr9+7UnxBPWdQQVUt9FxOK0YC5nKnC1RXI9cOF+jLd/pMimMAhPlqsot1PUamdC1BwMsLPACe/bUjUvCAa7YVkPYsynr+rX2hoeV5GzSVadGnAuKf3v2kzDJsysc36UhCrlqW/hMPVLqIvybKRfMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLgg/PaS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RePtJlh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:48:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764787730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE9yLr7T+4yK+U7evciLQzWAqdGGzB6We45ghQunT8k=;
	b=NLgg/PaS4YZG3o49HtbLM6mfIT/uZInsD9+Hue2SQQbS/71An+g3i00/PJOQLbmT5ZuhGY
	GINVDr3G+kJgkKXcvyzlrDmTPQ8lci17PlVSM0kuR4f9MHpfsoxuzFzseWIDgHYto0Q8zq
	QtP7NKsTmFQ25pqZXfbZRE+5d+E58Ad8VD2fT88XcqaBwOyJVlj58TW8uxvUPrYrruucmI
	E19EcyruZJnSz54wJiGb8Sb4tNmMoHZLAIv24MquRi7G/7habtG+KLF+dSJfSl1X3BPPJS
	DDQ2DpQb5Ouc9LhT6AcO88C6taW+jtU860q5oOqH0CgeBhLwpykTvsMQTeUKLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764787730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE9yLr7T+4yK+U7evciLQzWAqdGGzB6We45ghQunT8k=;
	b=8RePtJlh9+r0r3ighyAVM7vb+q0BwUbHbh7nfOOqj3Njvx/pPiZ5Eu7js59yNyJbyfRTO2
	sTO+wJOEZVNkS3AA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Consolidate annotation macros
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
References:
 <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478772907.498.13309398312151935507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     305c8dc477175eb29df18accc95c868acd2cdd4e
Gitweb:        https://git.kernel.org/tip/305c8dc477175eb29df18accc95c868acd2=
cdd4e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 09:59:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:40:44 +01:00

objtool: Consolidate annotation macros

Consolidate __ASM_ANNOTATE into a single macro which is used by both C
and asm.  This also makes the code generation a bit more palatable by
putting it all on a single line.

Turn this:

	911:
	       .pushsection .discard.annotate_insn,"M", @progbits, 8
	       .long 911b - .
	       .long 1
	       .popsection
	       jmp __x86_return_thunk

Into:

	911: .pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 911b - =
.; .long 1; .popsection
	jmp __x86_return_thunk

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.17646=
94625.git.jpoimboe@kernel.org
---
 include/linux/annotate.h | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 7c10d34..996126f 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -6,41 +6,35 @@
=20
 #ifdef CONFIG_OBJTOOL
=20
-#ifndef __ASSEMBLY__
-
 #define __ASM_ANNOTATE(section, label, type)				\
-	".pushsection " section ",\"M\", @progbits, 8\n\t"		\
-	".long " __stringify(label) " - .\n\t"				\
-	".long " __stringify(type) "\n\t"				\
-	".popsection\n\t"
+	.pushsection section, "M", @progbits, 8;			\
+	.long label - .;						\
+	.long type;							\
+	.popsection
+
+#ifndef __ASSEMBLY__
=20
 #define ASM_ANNOTATE_LABEL(label, type)					\
-	__ASM_ANNOTATE(".discard.annotate_insn", label, type)
+	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", label, type)) "\n\t"
=20
 #define ASM_ANNOTATE(type)						\
-	"911:\n\t"							\
-	ASM_ANNOTATE_LABEL(911b, type)
+	"911: "								\
+	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", 911b, type)) "\n\t"
=20
 #define ASM_ANNOTATE_DATA(type)						\
-	"912:\n\t"							\
-	__ASM_ANNOTATE(".discard.annotate_data", 912b, type)
+	"912: "								\
+	__stringify(__ASM_ANNOTATE(".discard.annotate_data", 912b, type)) "\n\t"
=20
 #else /* __ASSEMBLY__ */
=20
-.macro __ANNOTATE section, type
-.Lhere_\@:
-	.pushsection \section, "M", @progbits, 8
-	.long	.Lhere_\@ - .
-	.long	\type
-	.popsection
-.endm
-
 .macro ANNOTATE type
-	__ANNOTATE ".discard.annotate_insn", \type
+.Lhere_\@:
+	__ASM_ANNOTATE(".discard.annotate_insn", .Lhere_\@, \type)
 .endm
=20
 .macro ANNOTATE_DATA type
-	__ANNOTATE ".discard.annotate_data", \type
+.Lhere_\@:
+	__ASM_ANNOTATE(".discard.annotate_data", .Lhere_\@, \type)
 .endm
=20
 #endif /* __ASSEMBLY__ */

