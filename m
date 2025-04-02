Return-Path: <linux-tip-commits+bounces-4626-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA64A796BB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51DC17232A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B601F2380;
	Wed,  2 Apr 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuhQPdwt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ru8FDGtz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD12E3385;
	Wed,  2 Apr 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626637; cv=none; b=VPej0E6X6LhCfxW6zt8y3W52SGTbloa9l0FZcmjYZ76KSbqaJzKDHqcsKQiADYLK36OKedbOvBmi+tjYknCOxueTDcnkJ5MOgcYxOk70JSN+01772cCfGy99Ktk1g0rdtoafGXIZlEV2pz+Ik83mO3TsrNLY6t1tHHuqz45KkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626637; c=relaxed/simple;
	bh=2Vs+AvsqCfbBmWJwcdzae8vKCJlU6FgLMule6cgdZCs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qObw4rW6WYugTiTYJyqa9pfIEEinodm7sytTjHq8lE3rr0WJdroigVGGU4jy4pvbcUksEO+bAjUYyk48RgErztUetbTX5rr6y0lLhMUsOCG5Y2K1E417RaQKl8/GVnc3VWCgoXh3HQ2a84T+zW4x6qvd7HySVZBphMBW+x32N4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuhQPdwt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ru8FDGtz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 20:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743626632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJvH7AchnM571saorF0m3aazfP+bmTtCjdqu3LZ6bBA=;
	b=kuhQPdwtMkPW/ZivwdDeIBkub1/z+25k6lIm7FnU2WzIHLVgZxn26ahEBVaXEX35e5lS8+
	9DfeYElqOTbhQCCrAtndfBwIBY5agmyB5JDJuYoZn21IvLXjmSggGuemrnUfABnUw2On5o
	PdZ/fiIKWP1KuaJUMITRYq1UVtqgpjttuNmDNxgNTFPgQVmapVwFDghGkW0BbCbh8hDDmy
	F5rUN6j20QVy3cQjmny4QvwFyVJPXnhaUri8yWRwTjgzlu63Ntb2c7oAzb1wuqBLmG/7YI
	NnvRHiw0bTNrsU46yICAhTtnVXwuYFle/5zCSJOiIZf4gacdhNe8KhmomRXTlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743626632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJvH7AchnM571saorF0m3aazfP+bmTtCjdqu3LZ6bBA=;
	b=ru8FDGtzgKNmae9L8lEIxnEhvv60FGOwKTpFywVC5z2QbjoiT63TmYjVsIX4dRTcctZpW5
	apgtTEHA/IfPqHAg==
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
Message-ID: <174362663153.14745.130124754457441192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8ad521aaf7438e4fae996f51d02b960cc97a15a3
Gitweb:        https://git.kernel.org/tip/8ad521aaf7438e4fae996f51d02b960cc97a15a3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 02 Apr 2025 20:08:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 22:36:57 +02:00

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
index 006b150..6522886 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -32,8 +32,8 @@ static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitorx %eax, %ecx, %edx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xfa;"
+	/* "monitorx %eax, %ecx, %edx" */
+	asm volatile(".byte 0x0f, 0x01, 0xfa"
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
@@ -74,8 +74,8 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
-	/* "mwaitx %eax, %ebx, %ecx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xfb;"
+	/* "mwaitx %eax, %ebx, %ecx" */
+	asm volatile(".byte 0x0f, 0x01, 0xfb"
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
@@ -133,13 +133,13 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
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

