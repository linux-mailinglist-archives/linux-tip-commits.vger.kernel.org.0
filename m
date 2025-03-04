Return-Path: <linux-tip-commits+bounces-3961-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86971A4ED5B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1285A3B159E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68B25F793;
	Tue,  4 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMu3z33Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zrmp7yCR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728931D7E35;
	Tue,  4 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116223; cv=none; b=edqX2UiQkYClQmLC63f+NJiPANRlk2JRFs22i3RUgOMoRbrlUPtz8mgpZto/vmArPWu6Awv5/aMStLDse6HW0fABdWA5haliNgpeGy2fiF0aVo8/ibOUZjb3cqFTha512okhMtIckGrUJkQ2cOsP/M2H/U1G0ElMfU362fhZdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116223; c=relaxed/simple;
	bh=Qc9JzSMbn49LGYdBvw7KfV/Ijtn39brE3Yk+MwIFwg0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VdCrhtZ22WrFoYPYlnFO/lwmTxZUHPtiNbQ0210w09XyTQiWbtyFqoRYLfd5utu8wMFkI30sLXTWKnmCB4zjXqYD/Cpim1t1cotwl2TwUcIc7u4pLO9QXA2U0Bao0BB45Z2NXnEe3ZS6MIcF4MApR5JOjpQn8ApQYhzJi/4dIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMu3z33Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zrmp7yCR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9/0RsZRGCYPOTezOepFDYV4wK92WXWg0XRMyKKspuM=;
	b=vMu3z33QkmturI/U79KEyqhuCqQDCi/5tD1WDUiJqd0V1DDim6Bc4B95WWjHj3uo3LDOiP
	RpcbNLpI3KxSjYVAExMYluoJNVdfgLT9ThCPZ3mo3Kk9jz4vhEfux4QoBTeiRUnrxMX4kl
	yjC+VKGEmp3ABnduDIX1xn+Xo3cR6+CYzt31+EJrPw6IX9q68IXChQJ/Zfeiu39jzt4ome
	OOKJQXCZ8ljMHmSLGB+Cr+JDMYGv4+fKg/hF8Vn8jo9VktPwf3sDT4v9zc1V6mASbAD/gS
	D7lKprQNJPF5PTMB3bmVBAvbAbrSYv4yxPPZP/hGrCuvLESd1bQ/X6zjRyOa4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9/0RsZRGCYPOTezOepFDYV4wK92WXWg0XRMyKKspuM=;
	b=Zrmp7yCRnjk4f6ijkdtPPBHvr4amveXvFoOKAD0Hl7+wHQBINb3XxdaWoBIkw99WpO3Iqt
	+YEybpYY2h1OzBDg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Add missing clobber to inline asm
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-2-ubizjak@gmail.com>
References: <20250303155446.112769-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111622010.14745.16426184103690187039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     76f71137811a6dfa52b3e22a86a772e5753021d3
Gitweb:        https://git.kernel.org/tip/76f71137811a6dfa52b3e22a86a772e5753021d3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:12:40 +01:00

x86/irq/32: Add missing clobber to inline asm

i386 ABI declares %edx as a call-clobbered register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-2-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index c4719c4..eab4580 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -98,7 +98,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     "movl %[sp], %%esp"
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
-		     : "memory", "cc", "ecx");
+		     : "memory", "cc", "edx", "ecx");
 	return 1;
 }
 

