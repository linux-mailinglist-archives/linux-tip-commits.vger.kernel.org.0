Return-Path: <linux-tip-commits+bounces-4305-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69528A67353
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8241765F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A820CCD7;
	Tue, 18 Mar 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNB6HNIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpEWrXo7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48E20C015;
	Tue, 18 Mar 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299213; cv=none; b=UXt9XFMozhCVN84NJ4ecWkUHNTRI0BMSFBitD4ULD75DbzWgSA2XAeWkDycmQNqkB/RnMvFBK1LNxoCRg4NsCzSlP+VPfRFpWtJUn8kcGczenseYzo90lkynjhFcKad57B5ktBXRqIRjbIDLOjqZhO/O45Ygd3GCemhNlczqy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299213; c=relaxed/simple;
	bh=gXgV85dAQRHBj/fbYIMDmK37aYzMxKItN71z2dmk06g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tn4Ky/xGhzIHEVa6vCUpmZIrF8nTnuiBT+RcYsbb665mSHBtqd62woELBegso+eUZWHvPjpPzehOoabhepGDY4tSf3k0N2YLB22I4QyUrsBoX75Cbw7UgUjQxfgjbEutNXzj3zkp26TEX/E0jnksVE7w+4ZLlBbx01HytctE0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNB6HNIm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpEWrXo7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742299209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RINzIDrtPxABQoOHNXHcA7iIFjCwI5tSSdpYJeb/6Go=;
	b=uNB6HNIm7Ewfcgvd1UtgC9hHULgADUagSDWqgmwlBdJnuUW5YTXHRH5S3i5L8ugEwN0w0v
	jR0YThquRUlbljjsI5NwCGpHZgxgTuLfFiqS/ImGXWFd6DmeXoLZOJTJ3r/BZFZHZRPUIT
	CvPOr9z0Ad+2z9h5SgSWV8i4xrsxB5B43P/DELLAnKC9ZREQBZ368HCS2fQFL2ODK0jSls
	8hPhAKfG/m2FtgtUuj9GKIXKj3K6Il35PzVBKiGgQ15xL1LT/RFVQ+GFeyDRCIQImUB5eA
	XA7tpABpplMQdiSnfjzXhy7IICniSr5e0LMjHEgoeq67Nc791M1Yx4Ip12aL0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742299209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RINzIDrtPxABQoOHNXHcA7iIFjCwI5tSSdpYJeb/6Go=;
	b=CpEWrXo7Qibtn2TOgwhwENoEiubkpmfNTcDxgXgpr2thvsNc/2xvFYaPyC1oTLG6lMOWN0
	g6w34guuiCNniAAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Clean up <asm/cpuid/types.h>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-3-mingo@kernel.org>
References: <20250317221824.3738853-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174229920928.14745.4554052390199881261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     67a7ae050e7c2e9f9c5d1099909f7a1d45c3181e
Gitweb:        https://git.kernel.org/tip/67a7ae050e7c2e9f9c5d1099909f7a1d45c3181e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 09:35:57 +01:00

x86/cpuid: Clean up <asm/cpuid/types.h>

 - We have 0x0d, 0x9 and 0x1d as literals for the CPUID_LEAF definitions,
   pick a single, consistent style of 0xZZ literals.

 - Likewise, harmonize the style of the 'struct cpuid_regs' list of
   registers with that of 'enum cpuid_regs_idx'. Because while computers
   don't care about unnecessary visual noise, humans do.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-3-mingo@kernel.org
---
 arch/x86/include/asm/cpuid/types.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 724002a..8582e27 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,11 +5,14 @@
 #include <linux/types.h>
 
 /*
- * Types for raw CPUID access
+ * Types for raw CPUID access:
  */
 
 struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
 };
 
 enum cpuid_regs_idx {
@@ -19,8 +22,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_MWAIT	0x05
+#define CPUID_LEAF_DCA		0x09
 #define CPUID_LEAF_XSTATE	0x0d
 #define CPUID_LEAF_TSC		0x15
 #define CPUID_LEAF_FREQ		0x16

