Return-Path: <linux-tip-commits+bounces-1706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8D933EB5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Jul 2024 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DBF1F2397A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Jul 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C0181337;
	Wed, 17 Jul 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bVLfh1M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5BmbYxM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B01802D2;
	Wed, 17 Jul 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227128; cv=none; b=Jg0YLU1lblzv+p6SWLKnLoDhh9P9Q1FvXmu9nKKywOb5siFRXeRfUgvBQIQS8NFeO+jSnjE1J5pvi7zFR724lTZyXn30W9Zcyl8uaZpn6x1MAb7eMawFSySU/bH7VQzYoquHs1zPdTHFoOMaiUCGjrUnaMx1lSAJeQ9fJSNbr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227128; c=relaxed/simple;
	bh=IYZNEZXY+8y0fxebQxamTuKynXKI41woQF6rtvnXO/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LxD1MyY3aKOhSbt9EU91nsZzuUDK+thQLE0pTjx+K7pe3GkWJJfCOgmdkiIyzJPQqVC61PenRCP/0JXdR5E3JfSAMTNr6mswiB7y6Qdc69xHhbKgrtxLRUcFbZ7+fHEW4SisS40iApAV2idUEJGSv+NIj59sCafzPh9/j3V3/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bVLfh1M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5BmbYxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Jul 2024 14:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721227124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqKzduM1S07qdTBmR1uBLOv43G76gBA2I7I3DQVs9UU=;
	b=0bVLfh1MqBwsooz8crO/B0WPntJdU71Qyse0eymBNDMY1M33sSDCeHIK5p6rmy3Ab9Y/kj
	BiSZHGAQXAgPfLe9bdqZIkYgTFYJX9K8rUBbaNBDzoK+QGhr+VWhxa6mrqwJ+alqpYJLzU
	r6yaoaD3bFnWK+58iNmIJFjQK8fIWfXC5lEWcrsriwa1MznkgV/GLUcpLnWPwOBxcDMXPJ
	eiP3xLbACu3livkzL6UC/F1k56sBSTOEe0I9dM9lCSN1gsIjuzY6WipHAYR3yPg0g+AFqk
	JV5GJLMt3gMik9Fp1SM2MB0Tt883p90h8EL14VqKjRA9HkoTzHQb2cS4tlkHyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721227124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqKzduM1S07qdTBmR1uBLOv43G76gBA2I7I3DQVs9UU=;
	b=n5BmbYxMS0LWJnHrDQPWzen/BbqmgyFZlRE/kkmhzmrGfxsGkUljWUirzp/kl1oYie0ooT
	aI5vjLufE4gfDkDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Redeclare x86_32
 arch_atomic64_{add,sub}() as void
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240605181424.3228-2-ubizjak@gmail.com>
References: <20240605181424.3228-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172122712354.2215.11754309852163574251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dce2a224763ce968445e14c43b49321936309c75
Gitweb:        https://git.kernel.org/tip/dce2a224763ce968445e14c43b49321936309c75
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Jun 2024 20:13:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Jul 2024 16:28:19 +02:00

locking/atomic/x86: Redeclare x86_32 arch_atomic64_{add,sub}() as void

Correct the return type of x86_32 arch_atomic64_add() and
arch_atomic64_sub() functions to 'void' and remove redundant return.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240605181424.3228-2-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic64_32.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 8db2ec4..1f650b4 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -163,20 +163,18 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
 
-static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
-static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
 			       ASM_NO_INPUT_CLOBBER("memory"));
-	return i;
 }
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)

