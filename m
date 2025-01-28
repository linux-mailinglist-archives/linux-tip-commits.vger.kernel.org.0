Return-Path: <linux-tip-commits+bounces-3296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A0A21413
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Jan 2025 23:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055011882A14
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Jan 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F51D86C7;
	Tue, 28 Jan 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Db59PVj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIqerQIc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2B46BF;
	Tue, 28 Jan 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102973; cv=none; b=UEqLN/IW+kTwfMMAym3PbXWU4TcBiQgitd7iQgfIaS5YqinxT/tNJeffKL5//pvxTbgMQMyoJCClcDrLRstU8gUk16naiPXjlRQVE8BOJeDeKXV0/ViYqd8J4U95pIzLHUJaVc7S8O8/R5lIjN/xplRbfpIidXhZWf8EWq3LuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102973; c=relaxed/simple;
	bh=yd5YE3bcC4czv8PWxHTRHQ8XvV1JX8+CVosiUn4ri9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qMHzsmleyUQzAhiVYV3L5bqfUhC2/MU1vQFK/iTyo4IiwUPOBYIAayuTspXYO1gC8VDlnoyhSqstsDLmvFbUjrwyOOrczXqhEf04uwehwLQYdhW6FPNTusxIN/ilUBqCta1tQlzNpyEbzAncywQrBnwq8QEpPLrxr1Yox7lwLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Db59PVj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIqerQIc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Jan 2025 22:22:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738102969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mR+kVi9+qfuGse3IV27ZeOMISzc/YhCUyv5Ovby2JBU=;
	b=3Db59PVjNQLiY/YUSSpvrF9j+FPFp8+MYIZyxZTRtS1dvhVMOoW3YWHP6jPobhyRVkFDFp
	pRmTiEeJc1t11u/wYMmy1ZOflXiyuQCnauuoGBgwlt5Re4LjU9VEs9h0nEZ0Z5sA7wrm9e
	ZOIz9p4YNGFM3vpDIAU3rTNsn8Gc6GIM2WH73/bpj05cjb+KuqzUinOAELSQp3GIagd7Sx
	mfUVU7fk94PfNqY9iB8Pbmr8lPw/mBiw62n9YR/8XG+Q8XQICqfIo3m3aAtu+puBDAD8z0
	c4aSsYQ1UZxoAmzxE/fIlw+4uL3T6ia7YZwubRPEauFVf/cBKkXdFtejUH8DKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738102969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mR+kVi9+qfuGse3IV27ZeOMISzc/YhCUyv5Ovby2JBU=;
	b=nIqerQIcsTI+iKKKdxzkyufEE+RB6/vnyl9kd6hhjEodcLT4b8/TK8w+DW6SlPhhYkCyhm
	brxLAmalAdKJUKAw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Disable jump tables in SEV startup code
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250127114334.1045857-6-ardb+git@google.com>
References: <20250127114334.1045857-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173810296584.31546.2403049266146362118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1105ab42a84bc11c62597005f78ccad2434fbd66
Gitweb:        https://git.kernel.org/tip/1105ab42a84bc11c62597005f78ccad2434fbd66
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 27 Jan 2025 12:43:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2025 23:10:29 +01:00

x86/sev: Disable jump tables in SEV startup code

When retpolines and IBT are both disabled, the compiler is free to use
jump tables to optimize switch instructions. However, these are emitted
by Clang as absolute references into .rodata:

        jmp    *-0x7dfffe90(,%r9,8)
                        R_X86_64_32S    .rodata+0x170

Given that this code will execute before that address in .rodata has even
been mapped, it is guaranteed to crash a SEV-SNP guest in a way that is
difficult to diagnose.

So disable jump tables when building this code. It would be better if we
could attach this annotation to the __head macro but this appears to be
impossible.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250127114334.1045857-6-ardb+git@google.com
---
 arch/x86/coco/sev/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 08de375..dcb06dc 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -2,6 +2,10 @@
 
 obj-y += core.o
 
+# jump tables are emitted using absolute references in non-PIC code
+# so they cannot be used in the early SEV startup code
+CFLAGS_core.o += -fno-jump-tables
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_core.o = -pg
 endif

