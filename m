Return-Path: <linux-tip-commits+bounces-3887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF077A4D9C6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D0516D464
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4411FDA9D;
	Tue,  4 Mar 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WG6cHXVE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ka0+TJv1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C61FC107;
	Tue,  4 Mar 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082808; cv=none; b=jJ/lkhgzP/Qp0Jpakmh3UEyQq/0mnGoVxYFZa+0qQ8/3WWuUj0pwfFwcWU/BWgKeivYqK4bCZDTDtiUtiIhAp3oKsi7Wu7SF8DO6PB6YjD/E6dDWr+6r65MqItr1m04X7/RNDs5PRK8hFkMMuA4mSrznRgNyhvNSNSUdNA9Uuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082808; c=relaxed/simple;
	bh=V+0k3ap4pEsJ9phQ1LirPoFzCxQS4oVm+quEJL3uxuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HmkOMkPDIdtYXoD3iGhwv12djgWP8mNzUSG2DyPqwbQjzWPUINUufpvcJ+nPTJfpzr5GTyfugYxg5bF4X854Aw24VneAnb2ex2eAQrtD6uxDc4tNlDB19A5byKEK7fEa2RbCzT8k5IkRUtOZkRwHF8aOEjkQbPpOZVJuivBd7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WG6cHXVE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ka0+TJv1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPDkM61JudjWYNGH5Ruo2eS6qC/15jC7wlMHe+Qfte0=;
	b=WG6cHXVEfbbCOr1s/T6j9qeJRPXLPmbnvCub6vWr8kB2shKdfn/CPN9s0QhxthB/y+QoY2
	dZeDrowjPtLCe2l8WJHx+aIiszvejaelRvO9v6Rg+gR7+nkfqCU/8GWMRQqKlA8EeEex5b
	v5R8psjXIa0nw8/wFKPHsIUxxH8fdEr5AJBYcMkBboSBmZSy9HZqsWcw4GrlICf6yXJbQ4
	nlPMtwjTBu1FOzHT3ElWla3Nsy+k6i16Hb4hS4P4ndVkiFRM/cqy5Vox/o+uA6zdvrUELE
	KbK3NQSRab4AIxTilOCStIZr7mcx2oerpGmsqGHvHd4Hafg8QIGXXrYqcMfNCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPDkM61JudjWYNGH5Ruo2eS6qC/15jC7wlMHe+Qfte0=;
	b=Ka0+TJv14GrMR8PNc6CHGViIdDdhLbzpqI5heOqzGrvQLVBL8UgX/MZdnOqRFg1efbw5U6
	mqe3Ucl63yxvmsCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Change some static functions to bool
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-5-ubizjak@gmail.com>
References: <20250303155446.112769-5-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108280432.14745.17696566794303241130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     45f6469225e8da92ff1e5ec1027431053ba397c0
Gitweb:        https://git.kernel.org/tip/45f6469225e8da92ff1e5ec1027431053ba397c0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:53:52 +01:00

x86/irq/32: Change some static functions to bool

The return values of these functions is 0/1, but they use an int
type instead of bool:

  check_stack_overflow()
  execute_on_irq_stack()

Change the type of these function to bool and adjust their return
values and affected helper variables.

[ mingo: Rewrote the changelog ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-5-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 2428d66..566a93d 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -29,7 +29,7 @@
 int sysctl_panic_on_stackoverflow __read_mostly;
 
 /* Debugging check for stack overflow: is there less than 1KB free? */
-static int check_stack_overflow(void)
+static bool check_stack_overflow(void)
 {
 	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
@@ -45,7 +45,7 @@ static void print_stack_overflow(void)
 }
 
 #else
-static inline int check_stack_overflow(void) { return 0; }
+static inline bool check_stack_overflow(void) { return false; }
 static inline void print_stack_overflow(void) { }
 #endif
 
@@ -65,7 +65,7 @@ static inline void *current_stack(void)
 	return (void *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
-static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
+static inline bool execute_on_irq_stack(bool overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
 	u32 *isp, *prev_esp;
@@ -80,7 +80,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	 * current stack (which is the irq stack already after all)
 	 */
 	if (unlikely(curstk == irqstk))
-		return 0;
+		return false;
 
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
 
@@ -98,7 +98,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     : [thunk_target] "D" (desc->handle_irq)
 		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx");
-	return 1;
+	return true;
 }
 
 /*
@@ -147,7 +147,7 @@ void do_softirq_own_stack(void)
 
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	int overflow = check_stack_overflow();
+	bool overflow = check_stack_overflow();
 
 	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))

