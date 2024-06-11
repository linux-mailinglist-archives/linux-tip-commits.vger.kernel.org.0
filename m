Return-Path: <linux-tip-commits+bounces-1376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71929041F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF751F2625D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB250152189;
	Tue, 11 Jun 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTK7jyhl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLb7bLed"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1087BAE7;
	Tue, 11 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124845; cv=none; b=qHserMg/Oz7TOf9EzU+0unqeCprdyc/rb79UHm3OH21iTrBSlrvR5unC9jYgqDc5/15GKg0AbWUWH82d6gi13edZ1sNoOEvOQxTJ9vyIrw9/JP5yC0YROMYyWNc7bfg2m3OYRj+lT6F2HYBBrIdr63NiHDVhQ3qCNeLOHgMCaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124845; c=relaxed/simple;
	bh=7fN2fba7IGSFcV8M+ydxk97rXimlBsZQFYo0gyoZWTI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UDHvSnL3caPW0SY34xudUXGs1dAMSI8UuPBM0uzr/npnsIrlMUtiSQtqzsyR9oYIBqn0iQLVPblrTz48A1Harjr9kHQoD9UccAwTouE8gmbgAMwBPZUdag2/6WLVXlk5Bza656Mf8Ve2R/TbuuMvc6f2a9XtR7oVj9OIch/415g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTK7jyhl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLb7bLed; arc=none smtp.client-ip=193.142.43.55
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
	bh=/qpEuw737YTKRyPC8G1fYjdivw9lTnZNrt/iNSonHhs=;
	b=zTK7jyhld7XFrVnrd6nID25htyexj0p3GuFif7vbT1XB7R+2o0h+OuTbNvzdCLhAVA3Eac
	thRO1U5XYiG7DVMfwpueuL0M1ziGbyvOivFPpwySzMk1tIDJPUhGNoualX3Q0DFndv3WPe
	yWmUEkjVTyi7O4EW5Xr89oql799aZlu/rgaAFRYBhf5vWTIs7K73wJlr6MOx4pvXE6i2iU
	NnmFxZsrKHwLSycpsWcfjiJD13mNEteYViago6qdFGuRzPlnRCdib9mVxOrwfysgpJZcuQ
	RHkU8mVvPYyidX1GvCbVuThJUrUfnQv8eLwIMx3cr39ZtedaBV6l/a4YWYCLcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qpEuw737YTKRyPC8G1fYjdivw9lTnZNrt/iNSonHhs=;
	b=vLb7bLedM6a/GIFGEXZs64ro48CoDZPJESB9FtYtWNpDA9N+XscqkUbJQ1WYgxsarl0L16
	OeV0PxuZp/gvvNBQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-4-bp@kernel.org>
References: <20240607111701.8366-4-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482969.10875.12421223327319749027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     b94c1fe10be544070f53e4a1e5164087e446945c
Gitweb:        https://git.kernel.org/tip/b94c1fe10be544070f53e4a1e5164087e446945c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 17:14:26 +02:00

x86/alternative: Convert alternative()

Split conversion deliberately into minimal pieces to ease bisection
because debugging alternatives is a nightmare.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-4-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 7d9ebc5..c05bff2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -316,14 +316,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define n_alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
-
 #define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 

