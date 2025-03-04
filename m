Return-Path: <linux-tip-commits+bounces-3963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814DA4ED37
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D54116AB29
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2325FA14;
	Tue,  4 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wuCdzSfa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jxlMmXlU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278125C6FF;
	Tue,  4 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116224; cv=none; b=QWUE2GNLgDdxnw9h6XDMcseopt5q1P2SHfrJs96/42QK0H3KqCgHx9nKf1g6RDDhV6ti6SR0FH8dWheqJ8ImGedS1/UGK6SKbhniKxduDgZCKH7TpzIYR96zTHunj0uxJY2Orbp3ZyOsrLHCZuBMgmzY6VSYIRwrvLHrlchyhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116224; c=relaxed/simple;
	bh=4P3Tmn5qjIJGpGjyVRAMZneNBRRknbI10NwFZ7+sCbk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KhHiiQQiDrbzb7Mk+n01cxGXT/mtEiHPNHfYvyLVFCZcmlPDlgO2nx6T2qwtCIuaPwDdVbTkJqxf5N4ef99hHAkFYFNP18YTfUT6Q4oIlrfxe1Kdwdc4MMW5OAe7/p01hc8y8F7LZUdT02PLiK0Ij9SMPsBs1agQNnCOS7bZG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wuCdzSfa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jxlMmXlU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DlvDfgGwZ9DuZNLBpRjFkqsIdpmytFmhzqtuKTBNwg=;
	b=wuCdzSfaIiHv4xQ3jepmZ5+jiN/wYdyOvaZKWK6B0bovH38a3mEZDug3B2+VtTGG4P55SR
	cvYlJ3kKgkHVd90HFV8DLWhgxEPYHFCpaf1EZ0EeWMhhw+t5ii0dO74st1dt+fUDjRl9CM
	Ox2JUbSpyaek/ECWZL1jAuesKZrfHHcqIbFeuo+rvcbCEyaGRRCnuXZ7yRmaewgWCIW/tV
	wWdh1u1qBOAKEcqbhAlVPEz8Zb6q76TKvWgTUQz3S3KKr1HJgWsdl9HzYNeAPpNwLtZ3AQ
	9GAd3BZP0o+PPc2M1+q3GIbIgyhRwJvNrR/K1JdGlyZD8NJ1jEZ8oAUpQx+k5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DlvDfgGwZ9DuZNLBpRjFkqsIdpmytFmhzqtuKTBNwg=;
	b=jxlMmXlUBLMU1pnjsj5i+BqUD5+Abm002vkfQACQE6Cfkd3QHbvWsJI+kJOmD2uy7IGgnJ
	pTljgnMlvswM/YAw==
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
Message-ID: <174111622080.14745.8460888388605912001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     0ec914707c3ed052ed26eb88f9300109030a7fb2
Gitweb:        https://git.kernel.org/tip/0ec914707c3ed052ed26eb88f9300109030a7fb2
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:12:40 +01:00

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

