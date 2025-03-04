Return-Path: <linux-tip-commits+bounces-3912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18733A4DACB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15693A37E1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CD1FECB7;
	Tue,  4 Mar 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIpCSZKX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lyzwcYSC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F21FCF72;
	Tue,  4 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084587; cv=none; b=Am+kWroAqu4AM49DDFTYhdsnODRXfyAIDdwuT4IO8CGtUQEm8U1nRK2Bazp/3sVcvIhXbhnFeMx1cUHHl7kjeQquB5xyH/9jpv1RbE/qjf29GPn4hxIjlELD9JF9jN37iCnPfvMj8JJEWH+gMmZiokpFSpUsPnlPkyu3dFtLXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084587; c=relaxed/simple;
	bh=RYO8jId/MvVQaZWNR9dPAZmzSYHuxg9UO/AVxEQF6uQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p0OkBdJ50HUJwkFXJGEr2zD29WgPMLBGlttLZTGNoDjwiXvSxLZkuJKxXJ9GLmrBrdlG0Y24fftMUCzllgl9EdxmATuSIucVBspn51Pdkq9nzrHifXzNcJZrY4dkNEcyQ6D0HpEcSZmIbzxnU+cWCjqr5obq3/3iM1FOzjROV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIpCSZKX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lyzwcYSC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG5FYmd2QEVEx7Im4OGTxrTLul/JvIUu9ZGwsg058Zw=;
	b=rIpCSZKXIZH5oFKMhBmx92rH5PbSCzHq18Y8BulwX5Ctrm+1G9//54zXrj2uerPXHu2F2c
	E+wnD33kkS5CxGwbEMyOOC/t030HYX2B9crw6gMzkEdrw2h/36xLnv/Imeeu1qPp2QDQDH
	Mx3WsLypxWsLfpUdA5YM96oeTTgnlqlmdzEddMSMAdvUqUfG/hGApG3p+IUZnBGivQ9+nh
	Mj9RSeUznFT5gxSyeQFtWxaqqM2a3SpqvO21FuwVMORsrHtqyHUoXjoglRr2Zamk5CbbXf
	N1lUYR9ePnSziCWBIGEXX3WEIFvXov65WwTjoujBvmdQ3g+7oKojMfdMsldtAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG5FYmd2QEVEx7Im4OGTxrTLul/JvIUu9ZGwsg058Zw=;
	b=lyzwcYSCaIuVpntRcVJWJe1psvHmTw9Y1fCSi/Rx0XxtV5/f6S5rYs7OT5cVf97bE/dfL1
	by+4gQitA3+npPCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Use named operands in inline asm
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-1-ubizjak@gmail.com>
References: <20250303155446.112769-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458356.14745.3836700447171821326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     df682f7b763e8d983ef70c4908f8980a2ffc81cd
Gitweb:        https://git.kernel.org/tip/df682f7b763e8d983ef70c4908f8980a2ffc81cd
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/irq/32: Use named operands in inline asm

Also use inout "+" constraint modifier where appropriate.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-1-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index dc1049c..c4719c4 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -54,12 +54,11 @@ static inline void print_stack_overflow(void) { }
 
 static void call_on_stack(void *func, void *stack)
 {
-	asm volatile("xchgl	%%ebx,%%esp	\n"
+	asm volatile("xchgl %[sp], %%esp\n"
 		     CALL_NOSPEC
-		     "movl	%%ebx,%%esp	\n"
-		     : "=b" (stack)
-		     : "0" (stack),
-		       [thunk_target] "D"(func)
+		     "movl %[sp], %%esp"
+		     : [sp] "+b" (stack)
+		     : [thunk_target] "D" (func)
 		     : "memory", "cc", "edx", "ecx", "eax");
 }
 
@@ -71,7 +70,7 @@ static inline void *current_stack(void)
 static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
-	u32 *isp, *prev_esp, arg1;
+	u32 *isp, *prev_esp;
 
 	curstk = (struct irq_stack *) current_stack();
 	irqstk = __this_cpu_read(pcpu_hot.hardirq_stack_ptr);
@@ -94,12 +93,11 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	if (unlikely(overflow))
 		call_on_stack(print_stack_overflow, isp);
 
-	asm volatile("xchgl	%%ebx,%%esp	\n"
+	asm volatile("xchgl %[sp], %%esp\n"
 		     CALL_NOSPEC
-		     "movl	%%ebx,%%esp	\n"
-		     : "=a" (arg1), "=b" (isp)
-		     :  "0" (desc),   "1" (isp),
-			[thunk_target] "D" (desc->handle_irq)
+		     "movl %[sp], %%esp"
+		     : "+a" (desc), [sp] "+b" (isp)
+		     : [thunk_target] "D" (desc->handle_irq)
 		     : "memory", "cc", "ecx");
 	return 1;
 }

