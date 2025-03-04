Return-Path: <linux-tip-commits+bounces-3891-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF366A4D9CE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162A71890269
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5B1FECCE;
	Tue,  4 Mar 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4u8P6D/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUJEa60N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC01FE44B;
	Tue,  4 Mar 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082811; cv=none; b=arK7KphhZ9DZCy35fV8gN/86Fnhz3vC1sIq5PwEnSD0qOiTrabQHzOoR0iXldtOo+Dv/qx2hu5RlBn+MmGZ+nxRJ26tqTgS6Q/y8eXkekrnCDmAvcdJzh6bWhS57QLF7b3LxRIvFDkvSTziW6XJDGpS2UjyL/m1Qf2eMuQUBnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082811; c=relaxed/simple;
	bh=ZPnIUNSQyBGymCDL1a/nRAjBA9oW/GGoEvocHN0kTzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QTpw1YvbkFuyi4Qf/0iinbtXIiDpaUx9SdPj+I8kC3DJznMhZ64KLpDicYE+63S54z+lb8RiPGgGB/jVVTmuR3YCxhheEwHFGVk+CcwpQ8MPpcgGnLcg9NtRkoQ/dLYJ6JeegG8dm/CrNT49I4CDd5MftUkokJs1pCOsnXe8CjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4u8P6D/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUJEa60N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082808;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nujhobGJYDUd7sArz8Xx4lMxkwXLpOKNvO/slycDEk=;
	b=r4u8P6D/GBJDxHvNvuP72ERaxsFs0/fZ0dY3p3VabuGynfq0EHh1OcTgmJs5Xp8BkB6Kaw
	GTgMq63+Hdl90GjFzTc559tp7/QsBGVa8e0gL/1EnIp05CtZAATW186+TkWGWUCxQx8QqX
	tpfwBPoY3R3HUxOSIIpvZONG1H1ehp7O8yXKdTjZgXJTonX2QnxvS6Y1Jqx/a3SGDwhQs+
	dPIlOJdIFynNDz5XJ8RzQ4Saga1A7Nc7ED0TTAqX4ZLLuo1YL4vW5MP7CSpmYXvpPuCPQc
	yd8wJw44FI4e48nDTNZ91piVCyl8RFoUWqtzBdIJQC8Gf0/CX9tUbCY9+yynxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082808;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nujhobGJYDUd7sArz8Xx4lMxkwXLpOKNvO/slycDEk=;
	b=mUJEa60N0ZCNQWWxPEjJVrD9lALSSgc4a25S8Th9zOeOlnMO2l4iYPjvBH7mhJjdT8LLz3
	9vWXvNuU0sauaaCA==
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
Message-ID: <174108280769.14745.14710165706578115346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3fc50ac7607a18a60207901ad1604dae9b52701b
Gitweb:        https://git.kernel.org/tip/3fc50ac7607a18a60207901ad1604dae9b52701b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:53:51 +01:00

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

