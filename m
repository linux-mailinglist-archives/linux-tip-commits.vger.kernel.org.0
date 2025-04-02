Return-Path: <linux-tip-commits+bounces-4628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC66A796B9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EFB18959AC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB81F418F;
	Wed,  2 Apr 2025 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DuyJugml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r5tzVdwG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29761F2367;
	Wed,  2 Apr 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626640; cv=none; b=EBRsdPsZ6qr6nIFVnqgWpV1FLS9cHTjsG3f9NKaGMjI9HImqq6dfu8LnemhZxqwEfLK4j8PHYcZQmVLBBMPxi6LbnKPr9hbMoFywo7KThuD3QXcyThWy1zfMAkdgw/k5mR81RswGZk385GdVVff+65dUsyQiRUdYvkP68TlIchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626640; c=relaxed/simple;
	bh=2sL/aT/869Xsjx+XU53TX3YlVwH7DzgF3CXnW+7RmTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LtvmaZz4jsTZd7uTWb/3Q3fS1euYSR7mhvq22rK0XDCkS+1jOswH43SnQcaLEhMJbGXaM+YxB+91fbVT4ObLFhqCY1Bv4CZqvJxLsh/r7KEPlAD0VgE8Il5LswxFmNKU+TZXCvq3VIgsVPYIV+a49RwK7GGXzEwUH3w2N9fu7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DuyJugml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r5tzVdwG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 20:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743626634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4LtZz/lJiKCiPFPAD1OQFLl0j1o3bs5CnA4gppLkOQ=;
	b=DuyJugmlaG1lfbFqcuTnNeuIjnONUAoxXRlA0T18aRU6n/rVEGhaI8nLUSMiS56pjjVrMD
	AbX+ji383vni/UwTgSkcLqd5P+Sb7z7X4w1pHPST8ctS4IxI+gLWvjE9g7TviInq/tG3IH
	RSRcxDtTBFENle+h8Orex2vhc3vcjB/UvdAm6kZSa07rq0ILeoLoBkvJBbNwUbTmAn2nXv
	LZGsZHoDKL45l1cvxHLhRoVjaM4eSyjnx5rYPYPJmUS8vBz6bF+YlhxQZVqaXDPjMtrkEj
	fBck03nF+aFele2Qd09F4mbfC/aBrIGBfulQ0bCVPuO2peX/Z2qLH6fQt5RNgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743626634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4LtZz/lJiKCiPFPAD1OQFLl0j1o3bs5CnA4gppLkOQ=;
	b=r5tzVdwGThgpsRi7ryPZ65C2V0/284t7hIUfbwOLFMVBqfs4pCIWssWayyFBLU+dzWuSRE
	0cdyLnnh1ZSVcLDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Standardize argument types for MONITOR{,X}
 and MWAIT{,X} instruction wrappers on 'u32'
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402180827.3762-1-ubizjak@gmail.com>
References: <20250402180827.3762-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174362663333.14745.17539175188705861090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1ae899e413105aa81068d0282ab6e22974891d74
Gitweb:        https://git.kernel.org/tip/1ae899e413105aa81068d0282ab6e22974891d74
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 22:26:17 +02:00

x86/idle: Standardize argument types for MONITOR{,X} and MWAIT{,X} instruction wrappers on 'u32'

MONITOR and MONITORX expect 32-bit unsigned integer arguments in the %ecx
and %edx registers. MWAIT and MWAITX expect 32-bit usigned int
argument in %eax and %ecx registers.

Some of the helpers around these instructions in <asm/mwait.h> are using
too wide types (long), standardize on u32 instead that makes it clear that
this is a hardware ABI.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402180827.3762-1-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 54dc313..3377869 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -25,23 +25,21 @@
 #define TPAUSE_C01_STATE		1
 #define TPAUSE_C02_STATE		0
 
-static __always_inline void __monitor(const void *eax, unsigned long ecx,
-			     unsigned long edx)
+static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 {
 	/* "monitor %eax, %ecx, %edx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc8;"
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static __always_inline void __monitorx(const void *eax, unsigned long ecx,
-			      unsigned long edx)
+static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
 {
 	/* "monitorx %eax, %ecx, %edx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xfa;"
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
@@ -76,8 +74,7 @@ static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
  * EAX                     (logical) address to monitor
  * ECX                     #GP if not zero
  */
-static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
-				     unsigned long ecx)
+static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
@@ -95,7 +92,7 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
  * executing mwait, it would otherwise go unnoticed and the next tick
  * would not be reprogrammed accordingly before mwait ever wakes up.
  */
-static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __sti_mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */

