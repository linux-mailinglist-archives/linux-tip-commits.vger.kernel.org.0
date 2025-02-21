Return-Path: <linux-tip-commits+bounces-3573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DCA3F7FF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ECD171737
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F120F09A;
	Fri, 21 Feb 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CeydFfSA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="COtQHoUU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1720209F4C;
	Fri, 21 Feb 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150390; cv=none; b=HHGjI9QmXWoid2yszTzi9ouwIK/CkpdHR3SlyNJtGkoEI5iB5k+s3vUjghO+lSxrnkiF/3SbILyJh4uarARItexkrYJ7Wdia4dtXIxPPi1Y2sXsGyQ9BaxsRndkbDQTEPaLH7EyiSoQjCVwupOAxPZTO1AX9pRAQzyVClRBNyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150390; c=relaxed/simple;
	bh=5N30X5GegcN4tvKnns5lWRgQW6Spy99LaxMzHWGVVO8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=We93dubUtOCvsTVfaFLMmg5g0bo8/bFvBn2dwIfy4gI6pQBSG1rr7kGJn/+7CwH2abd6MWMmFqF3rb4l53vEHFX3Ha37iWmrglVhoYeG6NneDXluH+Ul1XHWtbTH78UtJyrA+Fj/YBwAQ+POnWakDf1JHNiV8XUSVZ0aP3jNQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CeydFfSA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=COtQHoUU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740150387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDUA85Dl4ouJ6yu+EaBZ7gRIsCnGssJRcJ6sW0Fu9ZY=;
	b=CeydFfSAAdQAuxx/mqoRtZFYjW6VWw/lUEDpOX9Z65eoeoaKYfJ2zzwGxOQEhjW5ZOnf7q
	6kxf2yJT1hbsEK6Qra2XMwDiCvig0m9YCUxZl20QqOByG/ercNW7HDdyrge+5v4CnJu89g
	3hyLOMd7ePvP0+vLJaTu4mKB4aX1cw6HKkRI0fRDYgira9rbujKcbO0z8KOnaWSzSJurnt
	JI8w9Urhg4gREgbkoDG56wuIWS9voNkJn8lFAqync72em3aLST1jlG5UQTFdslsfHn7MiY
	P3f8IVy4E58IRfdWyAN0uk1QQcEa+W8E5SrjNHoS+OIxUPpF3FbZ4SRThvJ9GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740150387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDUA85Dl4ouJ6yu+EaBZ7gRIsCnGssJRcJ6sW0Fu9ZY=;
	b=COtQHoUUYSc9JWFqFfY/6MqppDQ9Y0tWfFGOUZIP3R0mUmvD9rbHvugdPXuhhHVzHVHnhI
	6jnxFVf+gOVLP9Bg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/locking: Use asm_inline for
 {,try_}cmpxchg{64,128} emulations
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214150929.5780-2-ubizjak@gmail.com>
References: <20250214150929.5780-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015038309.10177.3818298325558179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2d352ec9fcb5d965318e7855b2406a7a14e9ae13
Gitweb:        https://git.kernel.org/tip/2d352ec9fcb5d965318e7855b2406a7a14e9ae13
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 14 Feb 2025 16:07:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:56:08 +01:00

x86/locking: Use asm_inline for {,try_}cmpxchg{64,128} emulations

According to:

  https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html

the usage of asm pseudo directives in the asm template can confuse
the compiler to wrongly estimate the size of the generated
code.

The ALTERNATIVE macro expands to several asm pseudo directives,
so its usage in {,try_}cmpxchg{64,128} causes instruction length estimate
to fail by an order of magnitude (the specially instrumented compiler
reports the estimated length of these asm templates to be more than 20
instructions long).

This incorrect estimate further causes unoptimal inlining
decisions, unoptimal instruction scheduling and unoptimal code block
alignments for functions that use these locking primitives.

Use asm_inline instead:

  https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

which is a feature that makes GCC pretend some inline assembler code
is tiny (while it would think it is huge), instead of just asm.

For code size estimation, the size of the asm is then taken as
the minimum size of one instruction, ignoring how many instructions
compiler thinks it is.

The effect of this patch on x86_64 target is minor, since 128-bit
functions are rarely used on this target. The code size of the resulting
defconfig object file stays the same:

      text       data     bss      dec         hex filename
  27456612    4638523  814148 32909283     1f627e3 vmlinux-old.o
  27456612    4638523  814148 32909283     1f627e3 vmlinux-new.o

but the patch has minor effect on code layout due to the different
scheduling decisions in functions containing changed macros.

There is no effect on the x64_32 target, the code size of the resulting
defconfig object file and the code layout stays the same:

      text       data     bss      dec         hex filename
  18883870    2679275 1707916 23271061     1631695 vmlinux-old.o
  18883870    2679275 1707916 23271061     1631695 vmlinux-new.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250214150929.5780-2-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg_32.h | 32 ++++++------
 arch/x86/include/asm/percpu.h     | 77 ++++++++++++++----------------
 2 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fd1282a..95b5f99 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -91,12 +91,14 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, 
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(ALTERNATIVE(_lock_loc				\
-				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
-		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
-		     : "memory");					\
+	asm_inline volatile(						\
+		ALTERNATIVE(_lock_loc					\
+			    "call cmpxchg8b_emu",			\
+			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
+		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
+		: "b" (n.low), "c" (n.high),				\
+		  [ptr] "S" (_ptr)					\
+		: "memory");						\
 									\
 	o.full;								\
 })
@@ -119,14 +121,16 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(ALTERNATIVE(_lock_loc				\
-				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     CC_SET(e)						\
-		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
-				     "+a" (o.low), "+d" (o.high))	\
-		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
-		     : "memory");					\
+	asm_inline volatile(						\
+		ALTERNATIVE(_lock_loc					\
+			    "call cmpxchg8b_emu",			\
+			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
+		CC_SET(e)						\
+		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				"+a" (o.low), "+d" (o.high))		\
+		: "b" (n.low), "c" (n.high),				\
+		  [ptr] "S" (_ptr)					\
+		: "memory");						\
 									\
 	if (unlikely(!ret))						\
 		*(_oldp) = o.full;					\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0ab991f..08f5f61 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -348,15 +348,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
+			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 									\
 	old__.var;							\
 })
@@ -378,17 +377,16 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
-			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  CC_SET(z)						\
-		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				  [var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
+			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		CC_SET(z)						\
+		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				[var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
 									\
@@ -419,15 +417,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
-			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
+			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 									\
 	old__.var;							\
 })
@@ -449,19 +446,19 @@ do {									\
 	old__.var = *_oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
-			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  CC_SET(z)						\
-		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				  [var] "+m" (__my_cpu_var(_var)),	\
-				  "+a" (old__.low),			\
-				  "+d" (old__.high))			\
-		  : "b" (new__.low),					\
-		    "c" (new__.high),					\
-		    "S" (&(_var))					\
-		  : "memory");						\
+	asm_inline qual (						\
+		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
+			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		CC_SET(z)						\
+		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				[var] "+m" (__my_cpu_var(_var)),	\
+				"+a" (old__.low), "+d" (old__.high))	\
+		: "b" (new__.low), "c" (new__.high),			\
+		  "S" (&(_var))						\
+		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
+									\
 	likely(success);						\
 })
 

