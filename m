Return-Path: <linux-tip-commits+bounces-4634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D733A7A1D9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5641896A94
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A624BD1A;
	Thu,  3 Apr 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcQjTFBV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHlecIag"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C9746E;
	Thu,  3 Apr 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679682; cv=none; b=ACTFp6l8SPx7KjMfJQwo7DvF0g463mgV4tzhucZ4LdQxu9JdwEyzM9gj9Sqd5oOespo+1r0mThgAOoij9ZKE+3ytiosbP5BCpPWezEe0LVvyH4LzmUvGbJ9HJQhXaLJEbl09BM3Mjqx2wgxElgyaw8xG9Z3Qul7CJFTH+JCVfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679682; c=relaxed/simple;
	bh=lJ0dKaplxjD5Q53RzYO5RBlz8rk3koJ2tUjQ8RdStt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LFc6CUDsjTe3OMGJNpBczq04VQSt/I4nKlyVrTnoPkjbTVvIZAwgDLpbeLIwyXhlAbBgRIWT3v0dI766ireonJuGYMRYzVmReCT6i5/QAR+ScaoC5stdjphyHr8mpz8DmDCYicrFxow4Uqr2XWfAPecOTEgy2aX3TDUmyKEv4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcQjTFBV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHlecIag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 11:27:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743679679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbfhp4hasnZEVgpYXbVu42QINcVsMLbc5OZvQDdHDsI=;
	b=kcQjTFBVpEY7YxiUC/whftFvMOuvZK61OkHtBtbVjtkOgIu9GW1JjUYFE0bawn3Mwmlqi3
	TujScTeFeLtY6QUc+92naZcrV3Tm9cKWhwLYTdVpzfYFGMaOiGLjta1AnZDTKgQVus/oHD
	DPeymgJPq7xIpnN2eZNFKwJWDZZpv7ZR0UyHzHPFyXYEoLhUkmFIZdmTf4y7qIUNoQKwNz
	rsQr60SLn0waeZxxw91hmGq6wOK4VkUNcKUmgALyEFqt9WngzmuS7qb2aAwaD4NcT5obyY
	wgBs1w1qNcMdETEh3G2yrilEnScSx17PrrO7gkxw5Pu3AjK+DdGQ7OtNVqj+YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743679679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbfhp4hasnZEVgpYXbVu42QINcVsMLbc5OZvQDdHDsI=;
	b=bHlecIagMCwUJPxL0pJtRE4VXR5u8FMfqREcaE9r1+wuPeJB17VqhZt3CzZCiYMCV1qnfJ
	JYkL3NQG/+q1buBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Remove .s output beautifying delimiters from
 simpler asm() templates
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402180827.3762-3-ubizjak@gmail.com>
References: <20250402180827.3762-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174367967838.14745.10060419709387905574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     19c3dcd953bc8961ab486cf05f5dd45455393c42
Gitweb:        https://git.kernel.org/tip/19c3dcd953bc8961ab486cf05f5dd45455393c42
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 13:19:18 +02:00

x86/idle: Remove .s output beautifying delimiters from simpler asm() templates

Delimiters in asm() templates such as ';', '\t' or '\n' are not
required syntactically, they were used historically in the Linux
kernel to prettify the compiler's .s output for people who were
looking at compiler generated .s output.

Most x86 developers these days are primarily looking at:

  1) objdump --disassemble-all .o

  2) perf top's live kernel function annotation and disassembler
     feature that uses /dev/mem.

... because:

 - this kind of assembler output is standardized regardless of
   compiler used,

 - it's generally less messy looking,

 - it gives ground-truth instead of being some intermediate layer
   in the toolchain that might or might not be the real deal,

 - and on a live kernel it also sees through the kernel's various
   layers of runtime patching code obfuscation facilities, also
   known as: alternative-instructions, tracepoints and jump labels.

There are some cases where the .s output is the most useful
tool, such as alternatives() code generation, but other than
that these delimiters used in simple asm() statements mostly
add noise to the source code side, which isn't desirable for
assembly code that is fragile enough already.

Remove the delimiters for <asm/mwait.h>, which also happens to
make the GCC inliner's asm() instruction length heuristics
more accurate...

[ mingo: Wrote a new changelog to give historic context and
         to give people a chance to object. :-) ]

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
Link: https://lore.kernel.org/r/20250402180827.3762-3-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 3377869..0e020a6 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -34,8 +34,8 @@ static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitorx %eax, %ecx, %edx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xfa;"
+	/* "monitorx %eax, %ecx, %edx" */
+	asm volatile(".byte 0x0f, 0x01, 0xfa"
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
@@ -78,8 +78,8 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
-	/* "mwaitx %eax, %ebx, %ecx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xfb;"
+	/* "mwaitx %eax, %ebx, %ecx" */
+	asm volatile(".byte 0x0f, 0x01, 0xfb"
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
@@ -138,13 +138,13 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
  */
 static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 {
-	/* "tpause %ecx, %edx, %eax;" */
+	/* "tpause %ecx, %edx, %eax" */
 	#ifdef CONFIG_AS_TPAUSE
-	asm volatile("tpause %%ecx\n"
+	asm volatile("tpause %%ecx"
 		     :
 		     : "c"(ecx), "d"(edx), "a"(eax));
 	#else
-	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
+	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1"
 		     :
 		     : "c"(ecx), "d"(edx), "a"(eax));
 	#endif

