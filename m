Return-Path: <linux-tip-commits+bounces-4335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E2A68A9E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F01A424735
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE5255E23;
	Wed, 19 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugUh5OXd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kbn0JAjn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DF25525C;
	Wed, 19 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382218; cv=none; b=MLQ6ng6vgNJ8r6cTr0zIdTCiCpc9IqliNMFQ66x/syExXs8rSjJsESCusuikCQDPt4IgFcm0G1mUfAE5msCfaBH/TFN+fYrvgUxt+pQiBIgTxq7AKEct06Bj8LG7hkGtCYRfjiIrI1WK/UENg+z3rfX9Dy2XeNQNCSSSPYGuRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382218; c=relaxed/simple;
	bh=KVuDnEXV7iiKr0Veh5cZCCNbNMU9o/76XU2x5XGAypA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D/vL9J1JKMIEUv3x06sEx+g3Gd1+SLrAc3/r9Pk+a438O3K0Wk3Q/5q2kZMHhGYcE72GT+HJBWXEJQAounKw555Eykj+bxb1cso/KNh8O/Y0uXxGRtcMwINH4+AWVVaDuvydO524BBqnUPI3EzDQdK8oaSfscRTo7VbAU4gEBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugUh5OXd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kbn0JAjn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnxP729h7jbXgYpvNF05kj7gNQzK9btu8/HTkdbJ5XU=;
	b=ugUh5OXd+IckwyQnC9L3cDwntfs/+l/dlVg9uqvhqAZN37Wo89s/WTWu3D8/LuUHJjtgpm
	7qPKSqJfBBnQDlMcqs5J+Yz6hMfRPTz85Bv4YAf3S8yW7cRxTN0kt6w3cale/Ve/JME3mE
	A59/c6RmQOsKMHj5Bh8SqfHUH/AJ1du52Rd/+IsfBIazIualbQ4p43XaBMrxEs333NQ+yQ
	ClpRyooUFuCMd/0E/dxjg5E+6xsTCx09wsKKsnqbhdVArPCcTpOGCoWa8jfwgwhSHHMk/Z
	+zl9FNGS28xnOXfsrl1VMytQ+xAFQycYLCOZLS2yw4rwnLGTlGHG/9y03AWDLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnxP729h7jbXgYpvNF05kj7gNQzK9btu8/HTkdbJ5XU=;
	b=Kbn0JAjnNbW9kgMmJ7JRTcyu/Q5m2XHNyqtxUyA4UWL9vU/QSgfHU2TmUl/b+NUyW5kZaE
	VDDzzkgvy+v2r7Bg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/hweight: Use named operands in inline asm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312123905.149298-1-ubizjak@gmail.com>
References: <20250312123905.149298-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221444.14745.9889913915839699984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     72899899e4f9de0b545218e66bf14cfa2579f2f8
Gitweb:        https://git.kernel.org/tip/72899899e4f9de0b545218e66bf14cfa2579f2f8
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 13:38:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/hweight: Use named operands in inline asm()

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312123905.149298-1-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd..a11bb84 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,9 +16,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }
@@ -44,9 +44,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }

