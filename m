Return-Path: <linux-tip-commits+bounces-4177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934CA5F1C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2262219C1503
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18326618D;
	Thu, 13 Mar 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vc/t03D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJt5pLFK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABE1E8325;
	Thu, 13 Mar 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863753; cv=none; b=ZxbEquzM2dVOxvaUIwj8pUl3kV2oNeRcAhBzUFEmj75EZ5ZSwg9IZzsB2xQzmYqy9zIZjw8jFy5OoXywgYnPHkPC3aKvLDPbQo/D7zotfXX7fKsMCiCTEUhhnk9RVJaXgfx+5Yo61YzGcfbhvY9mJ3348ia0ZdhpPbK4plIv5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863753; c=relaxed/simple;
	bh=/1X1OejHJ7+mHLpFxyP8mgS/XfgKwuughi5RsNew5Jo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MRrvPlqVvSz/RVqOFBJ93w3pau9SC9InNjd9eNVDJYKXlloO2gaX7DQqrBDheQdoIQ/H2n7Gnj2wPOPj9w2xIF3GrJQ9cK59QYNIEFfWmza5ONKf2i/G7Nvjby9Z5bujYup+X/FsKozVTuejL3OUN2OUmnP8J+ZZoz0bkjXGVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vc/t03D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJt5pLFK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:02:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741863746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yksDjSd2s2G6MkV6YGFRqtwNo2kniQFahpf1acUStls=;
	b=4vc/t03DXOc2RoZVFUf0QFQ2BjnwHtq4C1+NsVY2ASP5efHpp6Ps1TbQju1o7jFGUC21MP
	HDYUU8hcxHBSX/VP1p6z2XvtVciZWakIbW8Xnv9hgKIC5NJtG/RLouzsxzgzTPdAK7whu/
	9cIRNycKBNC9375k8f4nKZg8r9+eE50yc2dBGd1Uo3RB0ms9F2T92i8TS1ztl2k7Fj2G+z
	KcR4NNuShxXkAdpUnqKaVvdm6bbIh5z5aU6mjbsrtXcaSID9tThBlnaWUb8u6NdHk/IY0p
	5d1RH4TIoHVSfKW6yu+a85RBScTQUqw9qUAyvbpsTLE1OUqkDYqzbsE/TV4G0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741863746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yksDjSd2s2G6MkV6YGFRqtwNo2kniQFahpf1acUStls=;
	b=wJt5pLFKXbydnKUTwleLYZ2X4hOkVlXMUyPKv9deKy0jCs8dIcyP1BkAF7qIN1kiWGuuXN
	g+4BDgornnOTUlBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Use CLFLUSHOPT and CLWB mnemonics in
 <asm/special_insns.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313102715.333142-1-ubizjak@gmail.com>
References: <20250313102715.333142-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186374591.14745.4656117553319645080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     cc2e9e09d1a3c59cfb138a0fc6ad6f624f3d4ac8
Gitweb:        https://git.kernel.org/tip/cc2e9e09d1a3c59cfb138a0fc6ad6f624f3d4ac8
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 11:26:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 11:50:14 +01:00

x86/asm: Use CLFLUSHOPT and CLWB mnemonics in <asm/special_insns.h>

Current minimum required version of binutils is 2.25,
which supports CLFLUSHOPT and CLWB instruction mnemonics.

Replace the byte-wise specification of CLFLUSHOPT and
CLWB with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250313102715.333142-1-ubizjak@gmail.com
---
 arch/x86/include/asm/special_insns.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 03e7c2d..856d4ad 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -176,9 +176,8 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %0",
-		       ".byte 0x66; clflush %0",
-		       X86_FEATURE_CLFLUSHOPT,
+	alternative_io("ds clflush %0",
+		       "clflushopt %0", X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
 }
 
@@ -187,13 +186,10 @@ static inline void clwb(volatile void *__p)
 	volatile struct { char x[64]; } *p = __p;
 
 	asm volatile(ALTERNATIVE_2(
-		".byte 0x3e; clflush (%[pax])",
-		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
-		X86_FEATURE_CLFLUSHOPT,
-		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
-		X86_FEATURE_CLWB)
-		: [p] "+m" (*p)
-		: [pax] "a" (p));
+		"ds clflush %0",
+		"clflushopt %0", X86_FEATURE_CLFLUSHOPT,
+		"clwb %0", X86_FEATURE_CLWB)
+		: "+m" (*p));
 }
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK

