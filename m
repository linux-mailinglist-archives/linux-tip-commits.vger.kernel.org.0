Return-Path: <linux-tip-commits+bounces-4953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC2A878C6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9171D1701D7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E41ACECD;
	Mon, 14 Apr 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awCovut7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Fe+XRD4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434F1A3161;
	Mon, 14 Apr 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615955; cv=none; b=gQf8HxHHDywhZ0FooiAUWjHiSfF2cj3ilefYMiEOiwNFCyf8GjnB98k5d0uon6M1lMwbZZPpIE0sfOTDv7CpwvrIDlOO16mZrgCAv6JXzkYo97MCwbnOnp847HyH2YQpHYYNpnHcdD4JM+HSkUdbALaPRrAhfsSw1HTa4Q5GkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615955; c=relaxed/simple;
	bh=tzEEwXbnXf4EP5gSjBkWwooM0FmRX6MPMkNxlvK9ESc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nw4sg6mSBGTk6QKvoQZsFm4bYfGpfl7ZQwTo/xJyAOSUc38s1GS01S/iC49p/QNUqPXK6adVDOA2/Lmh3S0aDtnzVEkQsxfE/dWf8U/82Q6vShbvul0qr57XpCjb+mg4wyZJc3zP/fmSfOAsbrKs4s2PPH+v08l6OmUn1/Z4fM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awCovut7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Fe+XRD4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744615949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzd/sNzUwzcCF4WdVvwkKiCySoTwG7TykwSehPyV72Y=;
	b=awCovut7pz8p4U4WRsEQo+NBxyORTGjbodn1w7GCsN1QAQruJU2jDcROXvPcelb8eQWEA+
	VygFAfyhlu2BxHCAgSJFPSq2JxAv/bfYB+XGaB2TxCqfnLdDbQwIDjo/qzywC/CKvDasOY
	pHGKEMrZ1u1Zcfh/Wt/Mlde39pq7X+3NyNQ+SB63NEmmU5tLOHkvzMMOQ0nt4KaUC/efZ4
	Mmh1JWdAjeslVhskzQNjykJTTAh7wIqSy0JmGi8cl5C0c5Ng6vOLudE5otA1c0StCUvTMe
	HnAoZot2VQe1tpaDpKwPrTnNiZKt+d+Xn8Hq4P4CnNF1xRM/IBxnstgsH05pZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744615949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzd/sNzUwzcCF4WdVvwkKiCySoTwG7TykwSehPyV72Y=;
	b=5Fe+XRD45n3BHarLXKIX8l1pyBQ+3scC0i7aUJf68nCu9G4mZLtfbh7DL/e779b1hzfq2F
	zLQG8WNDSIUGkDAw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] genksyms: Handle typeof_unqual keyword and
 __seg_{fs,gs} qualifiers
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413220749.270704-1-ubizjak@gmail.com>
References: <20250413220749.270704-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461594538.31282.5752735096854392083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     1013f5636fd808569c1f4c40a58a4efc70713a28
Gitweb:        https://git.kernel.org/tip/1013f5636fd808569c1f4c40a58a4efc70713a28
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 14 Apr 2025 00:07:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:19:04 +02:00

genksyms: Handle typeof_unqual keyword and __seg_{fs,gs} qualifiers

Handle typeof_unqual, __typeof_unqual and __typeof_unqual__ keywords
using TYPEOF_KEYW token in the same way as typeof keyword.

Also ignore x86 __seg_fs and __seg_gs named address space qualifiers
using X86_SEG_KEYW token in the same way as const, volatile or
restrict qualifiers.

Fixes: ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c035@molgen.mpg.de/
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Link: https://lore.kernel.org/r/20250413220749.270704-1-ubizjak@gmail.com
---
 scripts/genksyms/keywords.c | 7 +++++++
 scripts/genksyms/parse.y    | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index b85e097..ee1499d 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -17,6 +17,8 @@ static struct resword {
 	{ "__signed__", SIGNED_KEYW },
 	{ "__typeof", TYPEOF_KEYW },
 	{ "__typeof__", TYPEOF_KEYW },
+	{ "__typeof_unqual", TYPEOF_KEYW },
+	{ "__typeof_unqual__", TYPEOF_KEYW },
 	{ "__volatile", VOLATILE_KEYW },
 	{ "__volatile__", VOLATILE_KEYW },
 	{ "__builtin_va_list", VA_LIST_KEYW },
@@ -40,6 +42,10 @@ static struct resword {
 	// KAO. },
 	// { "attribute", ATTRIBUTE_KEYW },
 
+	// X86 named address space qualifiers
+	{ "__seg_gs", X86_SEG_KEYW },
+	{ "__seg_fs", X86_SEG_KEYW },
+
 	{ "auto", AUTO_KEYW },
 	{ "char", CHAR_KEYW },
 	{ "const", CONST_KEYW },
@@ -57,6 +63,7 @@ static struct resword {
 	{ "struct", STRUCT_KEYW },
 	{ "typedef", TYPEDEF_KEYW },
 	{ "typeof", TYPEOF_KEYW },
+	{ "typeof_unqual", TYPEOF_KEYW },
 	{ "union", UNION_KEYW },
 	{ "unsigned", UNSIGNED_KEYW },
 	{ "void", VOID_KEYW },
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index ee600a8..efdcf07 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -91,6 +91,8 @@ static void record_compound(struct string_list **keyw,
 %token TYPEOF_KEYW
 %token VA_LIST_KEYW
 
+%token X86_SEG_KEYW
+
 %token EXPORT_SYMBOL_KEYW
 
 %token ASM_PHRASE
@@ -292,7 +294,8 @@ type_qualifier_seq:
 	;
 
 type_qualifier:
-	CONST_KEYW | VOLATILE_KEYW
+	X86_SEG_KEYW
+	| CONST_KEYW | VOLATILE_KEYW
 	| RESTRICT_KEYW
 		{ /* restrict has no effect in prototypes so ignore it */
 		  remove_node($1);

