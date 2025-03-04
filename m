Return-Path: <linux-tip-commits+bounces-3966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B6A4ED84
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9963A909C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A02517AB;
	Tue,  4 Mar 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQbjdpaC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKq0ehIP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E861F582D;
	Tue,  4 Mar 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116837; cv=none; b=DJZMoPa8lRdvl1/FqCrKOQ+kONUCvMtvJbhhHSeG0hhNFGWqkAHaIgHvoQ5+V4GOSXOIHu9rZYyIZ85fRQ6jQCkpyV7Uxw2ii8tusV2oSfaOZAb947cPQIPMPkoHGXAbhkxjTNP8k0DmLpQf6eru5WlJS5aPUw8yRSq7mzixClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116837; c=relaxed/simple;
	bh=NxzZeaSnz4XroC+aC6YLPqJQv6I95PCZ3rweuqdaC3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VefV4GvgvXRgEhEEoWa+Pc2RlDhOEt1XyzdCKUeAYAYAgNE6iHF6RpXt517CnRE4cHf4CO5OlZOREu2v9ytdlP9E2VjGwT5C3MkSX3tMzi+Ny2cYKJC2xxim3rIveyxHmIwHL9AVArrwvSLkIGy35u4CtwyM/KfXPR1wMnxtv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQbjdpaC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKq0ehIP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gwR08YPY4IVNHSAAEZJ8XAL4yh6FFKSO/5pySI2ud4=;
	b=RQbjdpaCVRLgasnVJGPzNoECbrBzw7WA7JlQnGSNInak4eqYeuckTjcvpcy1kkiKibWSfC
	hE+z2RMZ9e5Zqb0PLcHPP/tRJUjSgqUPEgci0DAT3V6VIOnftnvAs4p8Pc0zM2lApI6QZP
	5qIMfCldCr8uAuPPdJ6Be77N8lZtk/qBRqDVP6ZvUhwS6jHzXl1drLq2ZRKanZbY868pbv
	1lZfkRVXYuGpoLRPxAaoAvDJjEMp3/yDs+ZzMA0GaquBnowBv0mLLAMVf5TVPi9Otu3mLk
	ScVVzqCPgSe7ZVOQBYL6IyXRZYLQXbvfqk1FPdJFziDpPKSwESZUeHTIo3dyoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gwR08YPY4IVNHSAAEZJ8XAL4yh6FFKSO/5pySI2ud4=;
	b=dKq0ehIPecrOBVbov81TQbfvCFXa7LJpLohN2Nw/e1mRlQjGLaZqgOeqHJDAFbZOsTUaXT
	Jv4DezvVsUA4BfCA==
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
Message-ID: <174111683310.14745.9970114453749843036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c8b584fe82d0f1e478a598f954943b095a4a8f5c
Gitweb:        https://git.kernel.org/tip/c8b584fe82d0f1e478a598f954943b095a4a8f5c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:28:58 +01:00

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
index 8c7babb..d301208 100644
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
 
@@ -64,7 +64,7 @@ static inline void *current_stack(void)
 	return (void *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
-static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
+static inline bool execute_on_irq_stack(bool overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
 	u32 *isp, *prev_esp;
@@ -79,7 +79,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	 * current stack (which is the irq stack already after all)
 	 */
 	if (unlikely(curstk == irqstk))
-		return 0;
+		return false;
 
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
 
@@ -96,7 +96,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
 		     : "memory", "cc", "edx", "ecx");
-	return 1;
+	return true;
 }
 
 /*
@@ -145,7 +145,7 @@ void do_softirq_own_stack(void)
 
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	int overflow = check_stack_overflow();
+	bool overflow = check_stack_overflow();
 
 	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))

