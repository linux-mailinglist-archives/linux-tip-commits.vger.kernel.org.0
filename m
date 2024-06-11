Return-Path: <linux-tip-commits+bounces-1372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FF9041F0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75C528CDEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815757FBD2;
	Tue, 11 Jun 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7OC+d+e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUEEfsow"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2476041;
	Tue, 11 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124843; cv=none; b=nMYOzzivwiWz/67ii5+95eikqFMeCyFx6wIlG/E3+eRiapTLmNY7IrmrfTYNVlQAnia/lqV37CoCbiZfkYhbmy+NMYr+oZje8zOU+vavFwQTNoQOk+9XQGSe8wwkk3NI0+tOG/+gLbbEY4LFWDU6BCLMuafRKcS6dftGDhjSVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124843; c=relaxed/simple;
	bh=e6W7G/Z1iWFvEW1+cq8jCbStgdHMA2QD85WibCXyEP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DaIT2q53xcIBqOZY/1AsS3fDHlYXwf0w+k29bci+wTVRS5iAUvZVmen7xnSlCH0bEHXDUMVmglY0+D3lDl5LBlKkbWIuguvMuIxVEt5hpJNZLhbIZQzVi3WGqdM8yzsoKipv61feDkMo2gJUwCKok+GNVwKaBCZJMHKsOXZhXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7OC+d+e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUEEfsow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYs5ZUQzZwcEFxf0Z8QpbekUpcquqMOUsfv88lNQXaU=;
	b=m7OC+d+eUL6i+bvgcKN7NQ5kgRxoH0SapbQspnvilXRteOU4Lxv+FMIoBgTvjOJLVJdi6i
	Lr0OCbnJ7QUmLcC95Lk4+2QcLNqucGE4MeRmtx62CBugdUfi/rmTC+GP9qizs2Y63ftgOf
	a7SzufH0lRF/PwIbXNprw5xUzRoEzqP2NYxLqLaR/S6jRW7HFIA8SU72C4NOWp3fJOB/qK
	pZoQIEFIDkzkV8aRCbQNRy4QSEvG2FCvFneKIrfYQoeGG8mjGzUDWWcCqx5niwTmrlcgSg
	dRujONIHgP3R2LjYmv+MSpdF8ryM4sYXQfix7FpKyAqgiIF1193tKB6sFzsa/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYs5ZUQzZwcEFxf0Z8QpbekUpcquqMOUsfv88lNQXaU=;
	b=bUEEfsowvw+u65une9OE2Byonj3BEuyBFhYndBCDrHcKqgorWi/bXKTFAwSjNAM+KndmV3
	J4ZWl9JjiaR5VkDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert alternative_call()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-8-bp@kernel.org>
References: <20240607111701.8366-8-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482870.10875.2126707944460634228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a880f9ef6bf7edc36753a9e40388d42ae8d7e099
Gitweb:        https://git.kernel.org/tip/a880f9ef6bf7edc36753a9e40388d42ae8d7e099
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:15:03 +02:00

x86/alternative: Convert alternative_call()

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-8-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6a74681..b659757 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -349,11 +349,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * suffix.
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
-
-#define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
+	asm_inline volatile(N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*

