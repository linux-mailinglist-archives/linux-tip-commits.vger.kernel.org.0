Return-Path: <linux-tip-commits+bounces-3964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18AA4ED3A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE4316BA13
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA32263899;
	Tue,  4 Mar 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DayXXhFe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaM5sGpk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728ED2045A8;
	Tue,  4 Mar 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116225; cv=none; b=dwrWydErQQmAQT/j/husgcY5TEkRtTQOSpTjLoNclvFdQrm5ukC3TyoUZh2Mg73hnpGctHMaULa+qdXr+KeHHRbMie1ZB8S/lsMqJp12kj7pTwY6HUIou/YtqRSWoMmxajRgH5FmJlAc9PAuSyQYOpbxYd2hKOaQfIqGB+2ov0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116225; c=relaxed/simple;
	bh=C9hYFQ6ahekNQekedkTeagAWzNhJsDKO60fzBEvradU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dIRHZnR3K0grS6ZiPqDuh7eVtz35oze1IuOCtxSKGrgjsToO1Nx7y8kTezl0JLQgOMV//NH38yu++5j/i9FiQOBi1VJ84r0qZhmOcV5yzq4dIDUmInfHYeuI+FAxWOWjsPTVFe2RANd8OehXe0JMJFB0Zq6ycJAITAiz7h1ZjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DayXXhFe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UaM5sGpk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:23:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEUSYBfqNpR5w7A4w9n5LK7w8E41zYIeC9UXMLNCw4A=;
	b=DayXXhFeorDYyokXjOKOhIM7hG1ayKO3MXb0H4QniiS+hjV0yWUbpzQmjOjXuvO6T7Sik4
	jCHP+ZVWVOwDTsfhN7qYFhNs6KKG8cIoPVHOiGJLvLzXyU8ruDw4JvYKUdJqRxO0LONACb
	+dhLe5Zg/gAc6qhecBFdt2WAhZQvfNiz1Eqq2NFI4k7nqODBuNqhR9plDz/r1NMHTHXqve
	EiWCX8+FtleMOtASS3wy/zVpJ3/LYZwpfeFQ491OYz633P7zkWlnF2ziTYNr7np971UPxQ
	7U2syfsZyddyrIZEZGMSPHPUhnTpDxjhM+L/KYmBjyXW4Pepdw3V8cbPlkm0IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEUSYBfqNpR5w7A4w9n5LK7w8E41zYIeC9UXMLNCw4A=;
	b=UaM5sGpkRtF9MfTHTLD4xyvmoBmA8kkH03ePvwv0DJeRGgwUh/bPbP3K9YngPWaM+F/BYA
	wQtyh1bBdjK9t3Cg==
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
Message-ID: <174111621940.14745.13783054342564296917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     784af8f453fddec902639f42e2456f7fb5199450
Gitweb:        https://git.kernel.org/tip/784af8f453fddec902639f42e2456f7fb5199450
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:12:40 +01:00

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

