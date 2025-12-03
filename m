Return-Path: <linux-tip-commits+bounces-7576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED41CA0143
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 17:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B87EB301E187
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95734AAFC;
	Wed,  3 Dec 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCXJbGDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtKkfUkj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA42349B12;
	Wed,  3 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780042; cv=none; b=KWy+XRfEEBnjATpL4PcL3dWDKBD0GiyT47co0bfh4w0gP+6mE2kURtAMIWyaoh4q6cBw+9cRMXvG7cRWNLjCkp7IaqBmHiT5qIOgd61hbHgzOP3MJ1RiK8PuQm7kHAajjabSaCwPVH+k0Om8SPhehzqwk3O6BWbEcTUsT6jPj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780042; c=relaxed/simple;
	bh=ZcHtdgtZwyJziKE+EQ64gkumhA8V0NUfzyCJhMSWIm0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HTnka7sd5VgmRPcMPAta4To9c1Lcd+3jjXFI2xQ8udRyzaXRBkO7KVBdlm7FhAtRC3/P7/Hh4EB/BYo7I8Ev5S1JP8fYgOFDMawTASQhDjc7kJd3RCepAVoHgUA5vkOcfzrwUw20bXE5IUQlTDChIAizVqv89lPu2F/TOYgoj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCXJbGDh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtKkfUkj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 16:40:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764780035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd6pmcFACjL/h4SSA/RfgOUnPrboTBq9tK8HiRBHcSM=;
	b=vCXJbGDhBN2cX/miHoqjYaBOzJR9LJOlYNaeaxdtIgkkvQDCkfNqzKHMOEMM+pYsjU6TXQ
	YjT3dSxtziEH8qOzvaAnzXI90dmBpAp8UD16cE7aofQE4BAzJXKkqbxzQuDTBBUqRktMX7
	rzOp9ejLuIExXEa4/GK0GrCsI/uZ70/VWzB9+4mQqajiV26yf1ce2t14FyLX3G0900Yjtp
	UJeTF2kKCmB/ilqK1NhG+tMnxVKVMRt8stC7VDsTzYTmTt76KASYQVedvlj2S7GyKuP4ex
	FyffU0TAXUHgTvgJBAxouYjdsgfel5c4dC/C+yuNEDUXBuPAptHmadmYWih6kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764780035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd6pmcFACjL/h4SSA/RfgOUnPrboTBq9tK8HiRBHcSM=;
	b=wtKkfUkjYLQAuLB0f3hAjj7SyYh7AUtgZK9bBAfWoKwIuzGz+kAfUL5Tkp+WKk5xuFrh1m
	uKH4N+M8Lv3AvpCg==
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
Message-ID: <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     50765fb2746db2ac1d0b4dc9033b077734807689
Gitweb:        https://git.kernel.org/tip/50765fb2746db2ac1d0b4dc9033b0777348=
07689
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 09:59:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 16:53:19 +01:00

objtool: Consolidate annotation macros

Consolidate __ASM_ANNOTATE into a single macro which is used by both C
and asm.  This also makes the code generation a bit more palatable by
putting it all on a single line.

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

