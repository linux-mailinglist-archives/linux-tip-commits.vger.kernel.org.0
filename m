Return-Path: <linux-tip-commits+bounces-2761-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFF9BE4A2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751261C234C2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB51DE89D;
	Wed,  6 Nov 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6+Aw1r0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oBWVMyXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A081DE3DF;
	Wed,  6 Nov 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890068; cv=none; b=fNxM3BjUMt9+PW2aJKfo02Hab8UqiwA0lJoOSp90sNDps0eJ4tXH0QJT6Y5/JOT2SDR3VhdNACO0Ar+Ha1xXUu4BKBgjJZRIXlwe+/05hFfkCmJ9Exu+giB9wfQWitC1MwW+DganQ8P+x0n0qz4yO1v6pIJppIS89hRWTeHV4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890068; c=relaxed/simple;
	bh=ThwDMIKPA14kHDxs2HAMfZ6ROkeQs2vZncVyzkTg7Nk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AMgYy8dJ3ZT0S6iMunTWLPQ0UKE2fiDCgDbncE/akIf87Z4TMv8QimBpWP+ZSTlHRH59yATjyvKBLkbw8+bRfTGWjryQWdEZIkOfxngDfIoqXid7uUkwW07kAIdj7gJpEDSRwCUwlri0OqnuwdT7de9vxaayy+/tEm8wFNDgwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6+Aw1r0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oBWVMyXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwq9v4fv8IK2XK6Wdr0WNDaWRE03Bc+G1IOznVhiQBs=;
	b=U6+Aw1r0PUA7EAsZl8k1s00AVdlZHkNVDaRT8yrSKaUrKaZuz8N1czZjKH+bCQf8FnRd86
	84RhJVU3Gp5XxRmRHKpfOSN0q1aqlgKvdaeCaZHh1Y5+v/UXdq6uyYUKrJfM4NgpihzbPy
	xgomdj/aMGJmUkex6o6TpOkbIJaZTYCZ4wiyTxQ8OLMltQgomFjNxcehYG3EGBKi72BFDC
	ds+6HBPNQyZ/iocegIa3JA3PAJOkpAO0JmyOc74FrZABal+0nmD7f/4wcc4WIKha58gma1
	ZGYyR6n1uJW9x0tsw/4QfHOpEfGb6KXAD7tTGLHWz6ITZWWXMhhCj5a+RgkC0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwq9v4fv8IK2XK6Wdr0WNDaWRE03Bc+G1IOznVhiQBs=;
	b=oBWVMyXyeXKix20zsdFtdvafQ///wYtSAOF3bJyhVZmkSz/Y87UG4Alb6N2My6RBrlU8m7
	SLmqAtPmEmKS+wCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Use ALT_OUTPUT_SP() for
 __arch_{,try_}cmpxchg64_emu()
Cc: Uros Bizjak <ubizjak@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241103160954.3329-2-ubizjak@gmail.com>
References: <20241103160954.3329-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006497.32228.12901289269580776266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     25cf4fbb596d730476afcc0fb87a9d708db14078
Gitweb:        https://git.kernel.org/tip/25cf4fbb596d730476afcc0fb87a9d708db14078
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 03 Nov 2024 17:09:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:34 +01:00

locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()

x86_32 __arch_{,try_}cmpxchg64_emu()() macros use CALL instruction
inside asm statement. Use ALT_OUTPUT_SP() macro to add required
dependence on %esp register.

Fixes: 79e1dd05d1a2 ("x86: Provide an alternative() based cmpxchg64()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241103160954.3329-2-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 62cef21..fd1282a 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -94,7 +94,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
@@ -123,8 +123,8 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				     "+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\

