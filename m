Return-Path: <linux-tip-commits+bounces-4336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F389BA68A9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC7D4249F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D5255E51;
	Wed, 19 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxwsHMym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0k9qNsqt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA225486C;
	Wed, 19 Mar 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382218; cv=none; b=Bjgjf7OxmrQwPcgmt7OUcwrKWK+qvtFzB73zzC0aGK2scxjD3xB4W+VxkiOks7nhb83DGRWEAOYRobCeaEIY9BgEOIqDVrAcprik+pCDuX1i7lmvOFT6PcEKxnbBapGtTbpGYjZbq8eJXE81Zd530FH/+IsFC9EjgMjXlY5JB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382218; c=relaxed/simple;
	bh=frhnKgyXX0lt9hU1oPOza0xV+Ey6P5hV8wr2dhNQH0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N5zQWgUtqg87PbcH9rq+Qw7qT52aFOuoIBRPOUao5zbQPgv4LDJM0kt9gZVIRRbFa3LWcAyvlUp6KeG9LsFORzLGByvIXihnq7DqcgGwsYxAwHvSqv+cbfVXjLlY9QHfje8p+fiy3XAbu9pKKIDdObxDdC1P8uRUm9+I6hvunmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxwsHMym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0k9qNsqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIQrW9JMzYoqAi67GhamZ7ctSU1A92Fr86SwjUUZ2g=;
	b=RxwsHMymAvhAfnZYCz8ZAPr5yxhdATuoYZU9u5e7RREyIRdN1Awyunr5L/nX0taC5qzR6D
	tbmIgL1eBlY+8Ab94Aa0EG5cipBZxPpY1/ItnId1DBCMRRk/LLIkcOqeuRpaT82k6oqyyu
	P3XSpER+idwna2Le+UKkIAD11GHcDLVtJQHJUP85rfgcPOil8q+pH44KxnmWydBkWIUwEC
	tAV6cNrX5C9Bm6eTnqAFTprhutaraX8jOv6LVUKulh+U2xT/upg+XvL44nbtkp87a/SPEb
	2lbKJVbObBGwaczbjuKreAxxZJtPrOWWZeOx6bL0sW/qkNXlRRYtYLjAMhnsyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRIQrW9JMzYoqAi67GhamZ7ctSU1A92Fr86SwjUUZ2g=;
	b=0k9qNsqtg9lLr4S1sVGHw9xXsJldxj4JavPCKzrfZPx3czSquwVvQnZ7uvFF3XMsljTu3X
	O3ochbJ5ecRaAbCQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312123905.149298-2-ubizjak@gmail.com>
References: <20250312123905.149298-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221362.14745.9141293901413354657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     194a613088a8c9dae300dfb08433287cee803e8d
Gitweb:        https://git.kernel.org/tip/194a613088a8c9dae300dfb08433287cee803e8d
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()

Use ASM_CALL_CONSTRAINT to prevent inline asm() that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function. This unconstrained scheduling might
cause objtool to print a "call without frame pointer save/setup"
warning. Current versions of compilers don't seem to trigger this
condition, but without this constraint there's nothing to prevent
the compiler from scheduling the insn in front of frame creation.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312123905.149298-2-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index a11bb84..f233eb0 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -17,7 +17,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
@@ -45,7 +45,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res)
+			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;

