Return-Path: <linux-tip-commits+bounces-3890-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA94A4D9CC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BD31890373
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C91FECA4;
	Tue,  4 Mar 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAXPM3Sr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOv6DglB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486291FDE1B;
	Tue,  4 Mar 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082810; cv=none; b=sYcKoDw1sjl2Yaq1VJNtL3F7EfW6ff1T40Yz4p04RI02LP5NDfqtpzrY9ntXCCiW86MooODiie5f5915p5VFH+TbI5r90gpIoLEUrdhi5Uw9NZsBSMNQ5Crc5Ohpum8f2gsDorvUTmuteVmiP2KLxC/u4Wd0pPdPxqtT+GoDrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082810; c=relaxed/simple;
	bh=JdMpSdQqu5FHCHLV71wR4S592p9tVHGv1fj2uxaW0eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ATO8AavCTgGv+p/5dNsZGtDf5QODglZ3bpPQ7jW1XvahaxTMqpyyqL6tOTROYpgJRiwjS+2zYD9XCOmOHESRwoIX4Qz0daiXhfU74vD99HthCdZWlUj4i6XOO5onl1GqQndI6TSUt8qkrNc5kbdzKQKEEL+9TwmNHycdju37zX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAXPM3Sr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EOv6DglB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741082807;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OXzKocP5FUGsaPVo1EXHtzU8MX1W1ZBvtqno3cSYY8=;
	b=sAXPM3SrG/RTFHcI61UYOpnubliEVAVkKSyf9BzPTWejVbmRgBmcSSixyzk8Pz/uDPCCPh
	xEAa36jz9XO4D5INtcE5luFcE6bxwkIRu5bB+ZmeoOYMv4Bzlfv7UQ5I8raNRrFszc9WJe
	G3YE6WTy+0t6FPBaRwpEdiXvCiDPx4AAn/oH+WU8q6A/iheLb37wDWm/Y1EC6wFvscMMPk
	WpSTMvNMmlUnznTWA7I18eCjLM0au9doRqf7M0iLcZK39Cw5QxuFAhDK8D7s82dO6Xz9xO
	TGcLbNgW9JfpJpZ4jllzkwvcMCcyyDWaycso9KXlsgvbyDbcQJoXsovQjl96Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741082807;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OXzKocP5FUGsaPVo1EXHtzU8MX1W1ZBvtqno3cSYY8=;
	b=EOv6DglB1tvu7ckQnZddfZLlxs+DWlX3xUTAOGEXvhrfLlvv0mDCQK7NLGSqBq2fzcBxP1
	4Q27HnI06XtURiDA==
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
Message-ID: <174108280693.14745.3038221666755652409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     553d9797b9a161ae98072250bbe7ba4cec03cb87
Gitweb:        https://git.kernel.org/tip/553d9797b9a161ae98072250bbe7ba4cec03cb87
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:53:51 +01:00

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
 

