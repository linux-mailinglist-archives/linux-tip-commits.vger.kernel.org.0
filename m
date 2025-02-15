Return-Path: <linux-tip-commits+bounces-3369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B901DA36D6F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398E818956DC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AA1A5BAF;
	Sat, 15 Feb 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4CooJmU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vlGJ2wLs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73A1A0BFE;
	Sat, 15 Feb 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617000; cv=none; b=PY7C7vfrqB9DEV8oq5EeC/0AW7QUpyMClNciheX0MtVdnTBUlc+dkJ2DrO0k1HnYht+89w0OE1JooA7UITuSdEBx0GD1wtGJA4LXEC2HIBYXDCVFuOC1WEy46UDkp3wkF91OOwdUzxhRDUEvwzC79K6iw5MOkuAZNNhV5ytNwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617000; c=relaxed/simple;
	bh=KKkuNpqYVQJ7sX54ZXOu9KhreNJ0yRAaiXl54k1lVwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nJ7rIqgVu4iW1TZevrLI3Ee3ds0eBLcKx2/YCt+zkS7R8+65kNLuV6RgngYtjjyPV9VoRnLjO4D2gVUsd4KXCQQ1Y4CXpo8X6PJ2hMqMsNmzKi0eVOJAxsbMZ7z04TPQb12Ct+AX3AsoId/RrDhFVbcuYXvGyMYzCa3k0oSMVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4CooJmU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vlGJ2wLs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgNfOQ9DlebyTJ/BGf1C6GOZCBT0lJeCGQ8xPpD6gb0=;
	b=p4CooJmUTzFInYHwiEoMQq2RZHgWxXtQolmnsovu6es9myubWtqp0bLxP6yQd2DxWrBdZt
	LmJlX2z2B44y/9XZzPaRM0um/vWNwlyfYxfICgG6Vo4yfhcKOfxBES2xLA5gtlx4nV0Tts
	ZiyoriCgLf0ICtgWwRLe1d4QKBCv939JXeNgVyMYy0l7i+QonOFipkwVIH2IkwbO2GUK9z
	Cya7v6M2WN3RhAl/jOxiRId7vH+F/UzL+1ZpLkAGATeHy8PYtt+XtayQ5k/Mwa07lshvNf
	oD5cCCs0jK1UhcbixBRTPcb+EdvCOyZPVlmsYJKda+aiwTfCCAXeiMLe2c6MbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616997;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgNfOQ9DlebyTJ/BGf1C6GOZCBT0lJeCGQ8xPpD6gb0=;
	b=vlGJ2wLswnAe18lofH6fsPNZFIrtBiO2DgZHGuVD/tfiBHj2TEoKWtQuPUGjvoU2HSMII7
	CzUjtMxtdY/9TFAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Clean up poison_endbr()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.815505775@infradead.org>
References: <20250207122546.815505775@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699688.10177.10294695308983261568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c4239a72a29d58a4377c2db8583c24f9e2b79d01
Gitweb:        https://git.kernel.org/tip/c4239a72a29d58a4377c2db8583c24f9e2b79d01
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:06 +01:00

x86/ibt: Clean up poison_endbr()

Basically, get rid of the .warn argument and explicitly don't call the
function when we know there isn't an endbr. This makes the calling
code clearer.

Note: perhaps don't add functions to .cfi_sites when the function
doesn't have endbr -- OTOH why would the compiler emit the prefix if
it has already determined there are no indirect callers and has
omitted the ENDBR instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.815505775@infradead.org
---
 arch/x86/kernel/alternative.c | 43 ++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fda11df..e285933 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -865,14 +865,12 @@ Efault:
 
 static void poison_cfi(void *addr);
 
-static void __init_or_module poison_endbr(void *addr, bool warn)
+static void __init_or_module poison_endbr(void *addr)
 {
 	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(addr)) {
-		WARN_ON_ONCE(warn);
+	if (WARN_ON_ONCE(!is_endbr(addr)))
 		return;
-	}
 
 	DPRINTK(ENDBR, "ENDBR at: %pS (%px)", addr, addr);
 
@@ -897,7 +895,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		poison_endbr(addr, true);
+		poison_endbr(addr);
 		if (IS_ENABLED(CONFIG_FINEIBT))
 			poison_cfi(addr - 16);
 	}
@@ -1200,6 +1198,14 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 		void *addr = (void *)s + *s;
 		u32 hash;
 
+		/*
+		 * When the function doesn't start with ENDBR the compiler will
+		 * have determined there are no indirect calls to it and we
+		 * don't need no CFI either.
+		 */
+		if (!is_endbr(addr + 16))
+			continue;
+
 		hash = decode_preamble_hash(addr);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
@@ -1220,7 +1226,10 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end)
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		poison_endbr(addr+16, false);
+		if (!is_endbr(addr + 16))
+			continue;
+
+		poison_endbr(addr + 16);
 	}
 }
 
@@ -1353,9 +1362,23 @@ static inline void poison_hash(void *addr)
 
 static void poison_cfi(void *addr)
 {
+	/*
+	 * Compilers manage to be inconsistent with ENDBR vs __cfi prefixes,
+	 * some (static) functions for which they can determine the address
+	 * is never taken do not get a __cfi prefix, but *DO* get an ENDBR.
+	 *
+	 * As such, these functions will get sealed, but we need to be careful
+	 * to not unconditionally scribble the previous function.
+	 */
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
 		/*
+		 * FineIBT prefix should start with an ENDBR.
+		 */
+		if (!is_endbr(addr))
+			break;
+
+		/*
 		 * __cfi_\func:
 		 *	osp nopl (%rax)
 		 *	subl	$0, %r10d
@@ -1363,12 +1386,18 @@ static void poison_cfi(void *addr)
 		 *	ud2
 		 * 1:	nop
 		 */
-		poison_endbr(addr, false);
+		poison_endbr(addr);
 		poison_hash(addr + fineibt_preamble_hash);
 		break;
 
 	case CFI_KCFI:
 		/*
+		 * kCFI prefix should start with a valid hash.
+		 */
+		if (!decode_preamble_hash(addr))
+			break;
+
+		/*
 		 * __cfi_\func:
 		 *	movl	$0, %eax
 		 *	.skip	11, 0x90

