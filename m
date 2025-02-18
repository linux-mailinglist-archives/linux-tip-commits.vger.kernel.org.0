Return-Path: <linux-tip-commits+bounces-3514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BEA39BDD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7577188C121
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956242475D3;
	Tue, 18 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JAFjcnvS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yh1BDozC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB542475C0;
	Tue, 18 Feb 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880716; cv=none; b=sEdqMm2A9RnVKea/U7cgiNYhcs8wM0MjKrFyQP5FYb6E7lrcSmISL0AhMzr+SwmByU4fzgPdtuF66joNCB80ASaW8i8XTjSxnmKY48O6xIeZ80NFnjP9Zr6+7887frJtlWRwsuxO1exG4OOrJLBQHqU+2edr6ep2HaJKruDMtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880716; c=relaxed/simple;
	bh=6r1OG4cv+l2tiAtJOLWK6AnaR/G2EY/dQamBQieHGWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jAO6M9JtMjCwshjqRLyTqVHx8qxa1msLtfZdmuPuuxhe3NNS0yOmqOBRrn0eHNqufPQm0WWEyFqkZl8DazNVtqSCX+Kb+ZzFtXPeldF5fVt51iaSiwjYj1QfSSon8jfaMtS8E8jD2fl2bzzxmcARlP7j/d329NR7GZGwYOsMjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JAFjcnvS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yh1BDozC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv/AJB3TM9sqQ71+9ZoEE2PznDeki+snkWj5vhXbRIg=;
	b=JAFjcnvSjzTVWDXZxYlOIKj0r/7DEEgYg1CjE/ywXHFASrfMQXWwbwhV3wHxWXRWI1V2pZ
	evChzWXQDAazeDqp9C64ArSOO0HSPupCowdxz7l4waMyS8i/6SXFxJRDuxlyoHzppu/iwr
	ETLHwaIcQLMUWEWJEJ1LhqWDbkGqbwTIUCAgrjC2CHcrnCN5C8a78NaHi66DXbkDO/htm2
	1QcJKAbsMIbTk6C9r6xyicAxX3gS9Mn1+1DP/votCaauUZJRs2/Wgt7vgGH954DxHuUopJ
	FO/z22bUbxLGkE0519YMfxRo6NLhh1DjBMcO+oCwfpRyIoQRAiqEAI16j4E5oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv/AJB3TM9sqQ71+9ZoEE2PznDeki+snkWj5vhXbRIg=;
	b=yh1BDozC0TGDjJedwfegC6Rl53FT+i0f7OdGj9tRoUkMfs0fsr016divXRHT3uDyf/HWmh
	RBfxjVWqDS9XGxAg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/pvh: Use fixed_percpu_data for early boot GSBASE
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-5-brgerst@gmail.com>
References: <20250123190747.745588-5-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071267.10177.6022560317987318542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     f58b63857ae38b4484185b799a2759274b930c92
Gitweb:        https://git.kernel.org/tip/f58b63857ae38b4484185b799a2759274b930c92
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:36 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:14:59 +01:00

x86/pvh: Use fixed_percpu_data for early boot GSBASE

Instead of having a private area for the stack canary, use
fixed_percpu_data for GSBASE like the native kernel.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-5-brgerst@gmail.com
---
 arch/x86/platform/pvh/head.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 4733a5f..723f181 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
 1:
 	UNWIND_HINT_END_OF_STACK
 
-	/* Set base address in stack canary descriptor. */
-	mov $MSR_GS_BASE,%ecx
-	leal canary(%rip), %eax
-	xor %edx, %edx
+	/*
+	 * Set up GSBASE.
+	 * Note that on SMP the boot CPU uses the init data section until
+	 * the per-CPU areas are set up.
+	 */
+	movl $MSR_GS_BASE,%ecx
+	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	movq %edx, %eax
+	shrq $32, %rdx
 	wrmsr
 
 	/* Call xen_prepare_pvh() via the kernel virtual mapping */
@@ -238,8 +243,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)

