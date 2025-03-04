Return-Path: <linux-tip-commits+bounces-3889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F2FA4D9CA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103333A57DE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331651FE45C;
	Tue,  4 Mar 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ljUPmpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oooRa3IG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB91FDA8E;
	Tue,  4 Mar 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082810; cv=none; b=WeIsDxDTMtNf//bnhylOvs5MX/K29+Fg3gaKv35O7IMBz1iALnNzAQgC5r6qKGuC7E8l+26Q4gqiIOUmuu8KfYRqDzhswgNzIlzFwRW5Yo/lA/XaOcupzAc/foc9wocc2ts4PUgVYkDkX998jjojOQDg6fQ4FbDMxdii9RniQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082810; c=relaxed/simple;
	bh=yEK5gWa2zv99K5+RWn52JQDzlQXg2wa+/jrxQH2vPjQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cVcOHH9KuqrhoSGJRWJe5A623fJLnzNIrQL47znwycHMlV2ILDk2rTru6j/0OAko0pl/gfsRfBo1fJG45uIPCMzC/Q3Os+jtFQFeJOlBN5koaWHaqBYj9OMU8UB90y9oCEmlHY27r0vRIOSTUMGTbg0poPP+Nfzi/QBeTFRRt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ljUPmpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oooRa3IG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX5RKNqFlegG+DztlR/wOgQQRajiFO4AmhHYz5BbBBU=;
	b=1ljUPmpTAT6hGyfyI+jebiqPwW4QZuumBIwo3l6zcHj6q8r/JleEVVlQGnpg0D863tnrsO
	miZ0lr+E6ixeR4n4l4eWEmz9VJZa+CaT+VIl58HBNSSUcrTcmnvxA6JJzwEYvnp56TnGvw
	7RqBPROcdPUh8EU8kotXKCJ6UzMDTeoq3tfhh/dH+u28d20jVW6qeciA/i7dwMR4i16Yis
	BwZcNVRNXKxPGJRV9b4vg48QTQeJwM0m47OuJJKtwFrcsBJnay9+OtSo+LOVRS3OQVLxun
	wfoQwXuP3Tv6Vx+p5E2JBj1OGy3N1K9jqs2S/w8BN4Xjy16aEjWv8DuH0t7PKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX5RKNqFlegG+DztlR/wOgQQRajiFO4AmhHYz5BbBBU=;
	b=oooRa3IGjWH5voeWF30yUX7kl/+9DY1XdgIoBu0WHB/DiKOZQv/0Z5bUwl3rYEYTm3zQTP
	Qde3cHS1a0+dzPBQ==
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
Message-ID: <174108280609.14745.3802372767652601775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     94770fe8648b80ee7ec4484e43b2381a25b62746
Gitweb:        https://git.kernel.org/tip/94770fe8648b80ee7ec4484e43b2381a25b62746
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:53:51 +01:00

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

