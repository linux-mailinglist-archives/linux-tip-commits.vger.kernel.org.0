Return-Path: <linux-tip-commits+bounces-4316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F22A67C60
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923497A6F15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22F2144D8;
	Tue, 18 Mar 2025 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNNQl77S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGDdWTkz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F405213E81;
	Tue, 18 Mar 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324081; cv=none; b=DtWD7ym3mnwD/kWGfpdmeDZ40Wo2E6e35FCxM+7IP6LM1JSEc4kjB0cRAXyTl3JotfFZPm0EUJBKrVsqBkdkAIZOwvCX9qtlQp7/Tw17tIBwFEF47zYBrxQNcSH5LvBBZ8cj8ygKGQwkYZuV9RZ3AQHFaUSZEqyhxP+DGmgOgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324081; c=relaxed/simple;
	bh=6upam8jR+tXsU9YBuSittZUeNhA1nAZGXdZ7/dC2sy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V4EZCKqMPp+ldGg8r2453q10ZVbl+EWVJedCbuXMKzL1Jtw6FOU0arypzMXJr44lX4j/DfxeXVzRFAcF6QnlfkdsuURukakAknz8qU416bXAbYHty8H+M7kMk39KVxx7WnDFBbxY1khdtb5MnYgAMjL37UHsTISxYVse8QVftHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNNQl77S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGDdWTkz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqOUG9LGURxe8JbEqYO0k08dUAuBZiIcOEKIs7/TpEg=;
	b=mNNQl77SbD6KMgfMilo2MgBXcnqtXwfOraI/VO1FFju2/jdzlLOjySktpbjNiou++vtu0A
	aj7Lo2bdrSwpGY5E1ro+GPFocSRfiGc7E7cvZ7hNWr/uVylOPMPlKxjVLwWVrByQe7YeNr
	9NUmTc/UDLdQ/TKt7MuB6RCaE37/j+pzhizwrr87vzPAqUgocR2MOarAAR8wRw4G9prQsO
	8EECeu5FhT0/ALhgIVHPB4Rl11JH1BFYF8UvwkthcEeHbWlzry8H+moodHAG/X7XNpCTaB
	b3iquzrFqYTwjACeiBncGd11z7cLYxtM4pE3DXNNA9csMgi6QdDRKtqpMyOZow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqOUG9LGURxe8JbEqYO0k08dUAuBZiIcOEKIs7/TpEg=;
	b=qGDdWTkzJctVgVEdKX3XH1BOATZy4UFEkZIOAYW6Z8HKGmT/PrIdDZxXmY11ZnMPTC4LeT
	QweuTeSGT+K0KUAQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Fix the MOVSL alignment preference for
 extended Families
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-3-sohil.mehta@intel.com>
References: <20250219184133.816753-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407525.14745.17170068204585207370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d3c20b8ceadbe561033f51cb220859e3f1bcb44f
Gitweb:        https://git.kernel.org/tip/d3c20b8ceadbe561033f51cb220859e3f1bcb44f
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:44 +01:00

x86/cpu/intel: Fix the MOVSL alignment preference for extended Families

The alignment preference for 32-bit MOVSL based bulk memory move has
been 8-byte for a long time. However this preference is only set for
Family 6 and 15 processors.

Use the same preference for upcoming Family numbers 18 and 19. Also, use
a simpler VFM based check instead of switching based on Family numbers.
Refresh the comment to reflect the new check.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250219184133.816753-3-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/intel.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291c828..99b4c40 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -440,23 +440,16 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
-
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	/*
-	 * Set up the preferred alignment for movsl bulk memory moves
+	 * MOVSL bulk memory moves can be slow when source and dest are not
+	 * both 8-byte aligned. PII/PIII only like MOVSL with 8-byte alignment.
+	 *
+	 * Set the preferred alignment for Pentium Pro and newer processors, as
+	 * it has only been tested on these.
 	 */
-	switch (c->x86) {
-	case 4:		/* 486: untested */
-		break;
-	case 5:		/* Old Pentia: untested */
-		break;
-	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO)
 		movsl_mask.mask = 7;
-		break;
-	case 15:	/* P4 is OK down to 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	}
 #endif
 
 	intel_smp_check(c);

