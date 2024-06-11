Return-Path: <linux-tip-commits+bounces-1365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE19041E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A11B2502C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C84CDF9;
	Tue, 11 Jun 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuWv1ky4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7tBdnmv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C781EB21;
	Tue, 11 Jun 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124838; cv=none; b=G8E+8Nv83aT0J5/iG6GBX3DySLC12w4PdW5ZRzPs6DHV35DMtmpWE4EWtSM2L3Ju3PLYQEmvVOqPmIlC6X4xh5a/VqSgmo1iecvjkEqoFsNzDvjmdgi+kptaZcGo1P94RyyL1ZMgnstvdrH5DxSf1uLRoqeIG/CespkKh/MLnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124838; c=relaxed/simple;
	bh=iuXiQj1QfCWcO7aD9SX1p2T96F1was0Kl7DsckDZs4U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IRuD2ddFY2vkRhLSOq8GgpQxEpD2Bwt6wXr4Lz4Fmd2HikgB1IdOQkzGWVJvdTOa3ukR/RhcvJRUfUx4qozyl8w6GL8lNKaVQm5h+d9rsos88CiaY2SLoKTZHK9HDzxyipjZVs28/HXMCic4/qEO+1xYjW7rML2YFkU9yGnkKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CuWv1ky4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/7tBdnmv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeBIWYQIai2fKHzsNfAY+5tN1mp/+/hwb+YbFgo46Zk=;
	b=CuWv1ky4dFaJMEE/M5gJzQvJkmIMoPzj7c3hl/QXfiRscPHuc3yLsTwa7Yut/qG9vZnZyH
	iSOazFYPWNSgdKZkM3p+0DQNACCzgk0MrqnuEt3X3TMHk+LPzpuYE4/8XLKcLvA5N1VXWd
	+sSc6S7sCtJHpMcRcQi2CAolaTVhDQML1BBblzq9w7f8zr5OmQyyLvxB5z9eYto/qyIjo9
	Zq6XeEsoFtwwJnXxotNw2nQP9hL/Z0brN59e5GfTkLVjRBnTm+k3ZfeEimlUnoAk6gBeQs
	E4etjKjmG8c8TTx47bnIVnimdqEH1f3XPF4syYm1iei/L3eHcoFxTpMbZ09TNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeBIWYQIai2fKHzsNfAY+5tN1mp/+/hwb+YbFgo46Zk=;
	b=/7tBdnmvfBbs2KZ4q4Ir/RwbvEtwNIKuWoUaB1HSI+cwNuhg/wN5uNCw/BgpwXPzKi0z+c
	PJwyMSEI574oPfBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternative: Convert the asm ALTERNATIVE() macro
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-12-bp@kernel.org>
References: <20240607111701.8366-12-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482767.10875.17199202190196674547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a6c7a6a18b10a4ac0913e7abdbdce928a2601bdb
Gitweb:        https://git.kernel.org/tip/a6c7a6a18b10a4ac0913e7abdbdce928a2601bdb
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:16:58 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:25:00 +02:00

x86/alternative: Convert the asm ALTERNATIVE() macro

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-12-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fba12ad..31b9a47 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -422,24 +422,6 @@ void nop_func(void);
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, ft_flags
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
-.endm
-
 #define __N_ALTERNATIVE(oldinst, newinst, flag)				\
 740:									\
 	oldinst	;							\
@@ -455,12 +437,10 @@ void nop_func(void);
 744:									\
 	.popsection ;
 
-
-.macro N_ALTERNATIVE oldinstr, newinstr, ft_flags
+.macro ALTERNATIVE oldinstr, newinstr, ft_flags
 	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
-
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f

