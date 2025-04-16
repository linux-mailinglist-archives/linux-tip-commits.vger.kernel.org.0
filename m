Return-Path: <linux-tip-commits+bounces-5006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C8A8B333
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B551905DC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E32231CA5;
	Wed, 16 Apr 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JuHnTfi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLTJFvPW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BA22F169;
	Wed, 16 Apr 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791442; cv=none; b=Vxx5m8/FWD46RIUuONTgQZJxyVnZ2JLyhxqj0Xg3rRk1Vy2oIt0XvDeFnelude4Uf495GCbn6TRp6BFXDcB7WVZI87kiJDhIOPr/PSGNEkGFQ42Ibj4o7RjfttkTZUIMVRNiviG7w6APUC8PegChUkDMim4S07jVmXDx0mtZBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791442; c=relaxed/simple;
	bh=uaPxyOxWcYvFkU7XX+AbZvwSQFJH8KXE1E4w84ok640=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QjB7I2AmCZAzqJySiLOnFGU2+ik7MRavuhmCneb2AZ8LXG+A9xCNg4NT7lCB+OZstX041DkaLZYSTUt7H6qqD9PgUZnF3qqYromgHTNeZ9KQhMpsLobXKOG0Txd6dSyI+2B/GBdfAmgM0DFZdlkbtV4o2Nm9VulQJbKtdOSc50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JuHnTfi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLTJFvPW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BezF/t2pftMYfqOTW/Z01df5ijV5FRPaMGGi6Oz0CPE=;
	b=1JuHnTfi7VXyqN9S5ceRWi8jfu2h8poe5yQi9g6DoG7DDZ9XVrihQhbW1JZPuCGLmTi9l7
	XgBuslRM9v9gIrDwA5NOXJkFEmJvFftrKZDbs7uHiwFYePHB3GK/98+AcJG+oAKGr2luBe
	52t//nnqMNuH8Ym2oz8/C+s8c5P4Fi3pw7jm2nd+7GghD2mw/328MvPJlZLJOhTciV0K4R
	r3IfQvhknxFMztqbyLfZ/2VEFPZQIoUcGpEqrp/yg/eMW4YLtODqN5pcg9cV4wHlZvVQLz
	6IIMifyDEquwU9lR+Sk/qLYD8ujOi6AN/b+MFZ7YeL0G27dsdezYY8KzWgnbqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BezF/t2pftMYfqOTW/Z01df5ijV5FRPaMGGi6Oz0CPE=;
	b=fLTJFvPW8Ufi0RiqhVLwqjedyfJJ3b23tu+4AOwt7jcrhYdhcuzPi2XRdDrC6FlGzUcLhZ
	MgKA2gEM+e6gIuBw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Log XSAVE disablement consistently
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-7-chang.seok.bae@intel.com>
References: <20250416021720.12305-7-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479143889.31282.3812183885819853182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     39cd7fad39ce2ffbeb21939c805ee55f3ec808d4
Gitweb:        https://git.kernel.org/tip/39cd7fad39ce2ffbeb21939c805ee55f3ec808d4
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:15 +02:00

x86/fpu: Log XSAVE disablement consistently

Not all paths that lead to fpu__init_disable_system_xstate() currently
emit a message indicating that XSAVE has been disabled. Move the print
statement into the function to ensure the message in all cases.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250416021720.12305-7-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2ac1fc1..8b14c9d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -751,6 +751,8 @@ static int __init init_xstate_size(void)
  */
 static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 {
+	pr_info("x86/fpu: XSAVE disabled\n");
+
 	fpu_kernel_cfg.max_features = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
@@ -821,7 +823,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		 * This is a problematic CPU configuration where two
 		 * conflicting state components are both enumerated.
 		 */
-		pr_err("x86/fpu: Both APX/MPX present in the CPU's xstate features: 0x%llx, disabling XSAVE.\n",
+		pr_err("x86/fpu: Both APX/MPX present in the CPU's xstate features: 0x%llx.\n",
 		       fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
@@ -900,7 +902,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	init_fpstate.xfeatures		= fpu_kernel_cfg.default_features;
 
 	if (init_fpstate.size > sizeof(init_fpstate.regs)) {
-		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d), disabling XSAVE\n",
+		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d)\n",
 			sizeof(init_fpstate.regs), init_fpstate.size);
 		goto out_disable;
 	}
@@ -912,7 +914,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * xfeatures mask.
 	 */
 	if (xfeatures != fpu_kernel_cfg.max_features) {
-		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init, disabling XSAVE\n",
+		pr_err("x86/fpu: xfeatures modified from 0x%016llx to 0x%016llx during init\n",
 		       xfeatures, fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}

