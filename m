Return-Path: <linux-tip-commits+bounces-1370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6709041EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359DE1F261F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340551016;
	Tue, 11 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1oxPbEkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoNNTMx7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA25F870;
	Tue, 11 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124841; cv=none; b=t/Y4uIAFg/hhPVfd93DhPZJXX3imNUMriS1pRl5YfDHOATozIqZiOQmRafV1kbpD9KsACeonV9UaQ9r24uZQdlXhPGcJJY3amfpwMHoaTb15AE512irIz/JYvKId970cCi2qmwbR/KMNo2j+Km0PlSH0CRIESVpfXGWXPAgOxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124841; c=relaxed/simple;
	bh=jwIQR1DsU02huks9/aVKbhDwo5RFGf5+8/kqprO2kt4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jrRf+7TxnclWvfpfA8REV8zB3M2SAgdfrev4T9K97qVNqLl0sH/5h7CyhQ7aYyV+7JnHX9+xbZbmIXzc/AgO//7iZKar4GhMk+fogQNp85UlaV2wi+VYTIK2lIgzak/OCjcwBI6eFpyAhuo6XUxkntPSh9a6J9B9McCLCmDx0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1oxPbEkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoNNTMx7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3FIPocLkXF5f7KbGC7RnGZS8G5klhHGy6AyfvCGWCs=;
	b=1oxPbEkT8EPVW37hi2h099+yjX3KPeveZETQsJtw3AG7VtKlHrGcJB37VmQKvQEzKKu1d2
	YOdRrt9PUYOFBUrBMWRHDPOS+ABCE++SLSnUTlZoZMi3OKxTfIu6F3PkY78w+uOrCxg+Jr
	8HaiWxKoqI1RwnNBIFRln29dHZq98GD+AYBUyLYWKFChaJPwJKUlCOOpuT/MCK/P/K49Or
	yDBqgACvwyoi+GkNliwvj104xXfxNBrj2VCkn3iEa0uP31hnhMJHfPv745yutB5DOXIm6w
	SdyTTPROL3JfjYXQhBBzK5iaBHYxrIPgqiaX/FWeeOzn67ShQipCemwInkoEUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3FIPocLkXF5f7KbGC7RnGZS8G5klhHGy6AyfvCGWCs=;
	b=SoNNTMx7PWVQsOgqhaJPAYhvZj85wGvQuFouzk2prrzSvoWPy2KeFNxan9hmI6kfwkYz1d
	roA+txMw8VrcKsAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative_input()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-6-bp@kernel.org>
References: <20240607111701.8366-6-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482917.10875.6160530676593967009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     bb91576965e79d17e8e23fccdef91c4bf09d1a74
Gitweb:        https://git.kernel.org/tip/bb91576965e79d17e8e23fccdef91c4bf09d1a74
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:52 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:09:27 +02:00

x86/alternative: Convert alternative_input()

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-6-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 21ead5d..428d6ef 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -330,7 +330,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
@@ -356,10 +356,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
-#define n_alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
-		: : "i" (0), ## input)
-
 #define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile (N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)

