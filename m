Return-Path: <linux-tip-commits+bounces-3888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B862BA4D9C7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E580B16D367
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53B1FDE08;
	Tue,  4 Mar 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTeu6lYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFCjilYo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FD1FCFC2;
	Tue,  4 Mar 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082809; cv=none; b=ck1yhVDJ5EH2wIwjk2xX8CUQ/R+k4Yr4IexaAKF+c2SzPXGsN/HWYAjOrQ42zbWUKgC/nRxGewflHUgf8v/uLkQhSTbc3osLCAgX0c7XXrgQHyn5YRUBB7Z0gcg3YMVFaIPEGcDh/wMQQEeXYDMYZFPm8SU0g8WqGP9MUfFq2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082809; c=relaxed/simple;
	bh=IiQMg4hTclyu7Il6tLvYTxatDXpvAszq++PcXke2X1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T0gfAIM7bVmV/M60XKvtU5QSPqBfbwfD5U19lcrBOD57UzUEAQe9VgfMhTTEkDhekJfGfmlD5dhNf2C8uulGZIwK8tlD+iWa1ytsJWofWaH8/M4XFM8+k3Hz4mr4gHEaD0LLVRM082LtE22o0aOlV5aJJi9oiv/esNGIfCnUA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTeu6lYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFCjilYo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yz5Snnrqa456MZ0xJCHG/oaHIJvH7DGSfRGRjcdZGPQ=;
	b=JTeu6lYjBprPAbVlomS7DjevvHCZyKzPHK9eliqQJDReIOD+sEadLtKyQAbjvlydwIfr0w
	bEmqRaiu6Ck3Z9oU+9VN5QJG3VCYz8/z73eo3nDPnsJ/hP/Gy9RXIvZTRXpMseGJBjZrLH
	JmQd9Ul/qMgOKkPOR1qlU0WdFP3hhW9kvY8a4Ds+sCwFo4hM38XLPns8mt/O9akEyNqKt8
	FuZIcFc9NSsw8AbvuONMu3l/JAtLcslCF+8yJ8tO2HAxDMu9VZSpiUEhCx9kh6CmN9cony
	H7UegPeK6V2mqvnl/qtZZHaRFUPkYU51KD/773V1iAF/5aoYi6drp9roJ0EQ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yz5Snnrqa456MZ0xJCHG/oaHIJvH7DGSfRGRjcdZGPQ=;
	b=JFCjilYooNHqlMS0M6yVrNIcGN0l0wm9prerrA4zjIGAGhKu1s2Hc0wbrEJYxsXPHf/am+
	fS+eObuUAAlIA9Bw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Use current_stack_pointer to avoid asm()
 in check_stack_overflow()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-4-ubizjak@gmail.com>
References: <20250303155446.112769-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108280537.14745.9739438761136727531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     70e8a96f5408e409dc71b08a366d6d705e9d9fb8
Gitweb:        https://git.kernel.org/tip/70e8a96f5408e409dc71b08a366d6d705e9d9fb8
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:53:51 +01:00

x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()

Make code more readable by using the 'current_stack_pointer' global variable.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-4-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index f351fa1..2428d66 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -31,10 +31,7 @@ int sysctl_panic_on_stackoverflow __read_mostly;
 /* Debugging check for stack overflow: is there less than 1KB free? */
 static int check_stack_overflow(void)
 {
-	long sp;
-
-	__asm__ __volatile__("andl %%esp,%0" :
-			     "=r" (sp) : "0" (THREAD_SIZE - 1));
+	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
 	return sp < (sizeof(struct thread_info) + STACK_WARN);
 }

