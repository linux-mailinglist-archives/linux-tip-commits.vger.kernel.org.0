Return-Path: <linux-tip-commits+bounces-3908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFFA4DAC4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93CC18859D2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7C1FDE3A;
	Tue,  4 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ta7JD2Yp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTEqZD6j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C217BEB6;
	Tue,  4 Mar 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084585; cv=none; b=Hqh3MikSRrCgwFjf8tQ4uEADL2bb6ZWAbiq/0dqiEDaabnaKLO3JFKSHYLmMhEZlwzYvFEyqHzea4uS97f1bZyny/ItTuKc9dg29ahN5LM+zzoRYT+ES3PbJjVPqH/8TtCm/Kp11tJUA5QK4xWCWfuY7adFZcBSt8F/1iQBSAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084585; c=relaxed/simple;
	bh=atwoKtjkq39Lgnl8VEtxY1WBRWYaCILXQ7NGoX3pOHg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ms3uexXc+f/RN/u7xXHcdw+uFO+W/fRKsl33m0CRX9LyKSwrPKN9RHEx/or+9uXvULGCEU2i3B2saB7jhw5lRBzpDEm7vrIAE7z+1T2BMssqyragCn1kq1toHVk2GRghRVHMteG30fVybziIXcmsKzey4q/svHkP7UOhGDeoXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ta7JD2Yp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTEqZD6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cH3JP62yPqm7RPjKRzc6b5ZqKoctRZls6XQawQpr3K4=;
	b=ta7JD2YpJECvAk4KlrIBkqIF8TGKooohyJCDXnZDGMru5k2n82kVBhLVl3EbkabPkGNpyW
	wtwDFHoiD3UXEF+Glcuk0CcZoUot5YLRY/MqgjmDP8ealvngbaKIUT84J5e0AD4w4T1cIc
	WpgJMa4TM5rURMvcygLWAGAWU2+p7vV7/Wd6w6MYwfV44mXQDnHDoGQWd4VQ/5NbKlePlT
	vD1jpeZ/GmjRLRrNG8uIPq0WLEjN6USZwhZ/vlcPZdLXBeAglpF9qU6Tly5ETKeAadtSS8
	B4/IBCl6/lNZLf5p1hEn9C3qWXdU9GxEiH8vkWfCwHBOcJQ4yEcYWHruX8kUGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cH3JP62yPqm7RPjKRzc6b5ZqKoctRZls6XQawQpr3K4=;
	b=hTEqZD6jLCDv9L3XfIUU9SKcZd7IO5G2f0VZ7+D2LjZpuNkkDrGofPzDSk8hNRgXISNHta
	0Zb28OWHH1BctLAA==
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
Message-ID: <174108458127.14745.15826467197695209761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7b52de3a2811bf16f52b895478920113e1b39878
Gitweb:        https://git.kernel.org/tip/7b52de3a2811bf16f52b895478920113e1b39878
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

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

