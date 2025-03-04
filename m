Return-Path: <linux-tip-commits+bounces-3910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD27A4DAC6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926B2188682C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449351FDA7B;
	Tue,  4 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3LWQNA0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Tc5zTzW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C621FCCEA;
	Tue,  4 Mar 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084586; cv=none; b=I579FwKxLrEc9cFgRtLlRvBIW2Gvfgy6DMt3ooq0riEUIEW+Lar10YCCdn/jIR5EbngRkgTnoD7jxX9aU0tn+4hv1JX14Jq4NN5lpdcazMveGW7tPHKIthCzKzYwXIa+Z5y8QnMeoEeBnkQ8uBRasdiX5ErAbIUzpv/dK5UQq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084586; c=relaxed/simple;
	bh=mxbdDeewCT6pQKs+EIFqwnBcSl984oxCPHdsLY7bFZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yw39V1v0pSSk4EwkJBcZYhaunxuTck1z8pSEhv+1RXPPhIIQW+vNN2IqhcTWmGYazGBBlRtI8Zvqr9aJ9peGxfaQxn/PVDVMlBn/Guu97TtFij3rgZCae40DoTnyLOHDjpQTujxNSOKYCXJlvIxWn1krV3axpc2tDKTKSp7VaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3LWQNA0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Tc5zTzW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EIDNCoCt1pu4jEY1GwWKdSzRixAh5VsQb7UZMsaskg=;
	b=C3LWQNA0Ppz+6WtlHsn4+KlobGLmU7mvoyFgB+U8PmgSzCSAVr+tnLKGN4E08yY2WBhIdm
	9H6pru1aV+gFK45itusyQ7XjZ6tXx6dQ83ZrrHm8Hhe/vkc0CVEy8fx2sV2RRSigvzAOJu
	++1Y02+4g/f/zSbYrG/6R8iiKPP4atUoEDzLTuduKWYyTc053i+ZSpTGGX/5DF0rrnwZO5
	7qeiRADRuXK/Oi+ZWJ6WhujUcY9nVfUVy82tJNJq+KRsm4sGGL3lLaGGskNkcyLmFZrkIr
	4gAcH4AsiyxjWvDGkGaTydDkJtFnBfYc1IluTC9YDvlYhRT0wyO1DhvQ42+r+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EIDNCoCt1pu4jEY1GwWKdSzRixAh5VsQb7UZMsaskg=;
	b=+Tc5zTzWDRGWvFPVg00KJ9oGe/l25NznrbH2ZxCXlvuvPRQGB8en/NZereO1SjsyZmap7B
	RtiEV2pgRvNZdiCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Add ASM_CALL_CONSTRAINT to inline asm
 using CALL_NOSPEC
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-3-ubizjak@gmail.com>
References: <20250303155446.112769-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458252.14745.11313160664473980337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4d93ca6d7e92584c559d8687ac9eef15251bb97b
Gitweb:        https://git.kernel.org/tip/4d93ca6d7e92584c559d8687ac9eef15251bb97b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/irq/32: Add ASM_CALL_CONSTRAINT to inline asm using CALL_NOSPEC

This constraint should be used for any inline asm which has a CALL
instruction, otherwise the compiler may schedule the asm before the
frame pointer gets set up by the containing function, causing objtool
to print a "call without frame pointer save/setup" warning.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-3-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index eab4580..f351fa1 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -59,6 +59,7 @@ static void call_on_stack(void *func, void *stack)
 		     "movl %[sp], %%esp"
 		     : [sp] "+b" (stack)
 		     : [thunk_target] "D" (func)
+		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
@@ -98,6 +99,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     "movl %[sp], %%esp"
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
+		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx");
 	return 1;
 }

