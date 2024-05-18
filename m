Return-Path: <linux-tip-commits+bounces-1271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD18C9042
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C65AB21484
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7422E417;
	Sat, 18 May 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mm4L2Kv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZkDVF/p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D228379;
	Sat, 18 May 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025496; cv=none; b=QuzL0JdsVormOQz2ksxnavbIg8tf1H9GpkIIFHpIgsvi/CzcVhxjqiyjvQ7gRLV+e5CjEpwPMAywm2T2ovrzdR/zcnRuEDwmSN/SwYDHK7ZqZ6xJPN4L/8WJUhge32U2ZnCoJJOgP8m9gew8vA0j4aBBufG3mqbczyat4PWe2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025496; c=relaxed/simple;
	bh=lTgk8x/ZdAHBef1RyPQtkiq/ue++FDWbuXzpUz0Xpv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DAwhkJ3dd8rlVRACkrG624Zcze1KqbKgTUr0dZvTwa7LGyJHxzPSyiFBJCjk1rMypfmxzVO0VMUPp1vaI1wrn6xOJS6JG1j/lVAloqAES6jeyUu4TDGh6jOLwaU7uMFISat9BrCHvH81H0+bOXHlv9cIiuAN+Yr8rDM6gM/hDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mm4L2Kv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZkDVF/p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 18 May 2024 09:44:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruWW4Vdo7I7GyQ4TVGTvYAzJgR8TlyLzPbpxowdXV4c=;
	b=Mm4L2Kv/KmrWgxfA975tcWh7wOJRUF+jZijEsGxBulgh6luSKKDbbH21X3nml5lMHu/xqC
	kzYMyOwgVfD2xQHAL/ZopwVPXtATDlhfJrUJKUNTT8F/Q59TOmhA6SMYuggFpkdokrXGJi
	wZVQL27v60H+MlydKXH0PvYGkiEIwqibUiugVg5rJh4kra46jG0tn/8/g6Mfx5FuUqF8lR
	xKqz4S8Hyem3DHxn6bFyA7b3uGnFZbzHaNekDpe41Uw79MxN3c3wzddvBK1ydgGaWu1UTa
	cnFx2O0Cn6I/UGRuXxUPgyiUrJTo7bQtgsFFauUCk0JJqVQNXQDwqs+5/CERvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruWW4Vdo7I7GyQ4TVGTvYAzJgR8TlyLzPbpxowdXV4c=;
	b=SZkDVF/pkdiKgoEgJn41gITF22fT7VBSu8HHluOu8JkndD4HSQciGbeAIZVnsUba4R1EiM
	maKvxzoctEfUZeBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Move some percpu macros around for readability
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240430091833.196482-2-ubizjak@gmail.com>
References: <20240430091833.196482-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602549310.10875.1965265772052609968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     08d564ad699ef32ceaf99d238b3d9c1f4ce5c998
Gitweb:        https://git.kernel.org/tip/08d564ad699ef32ceaf99d238b3d9c1f4ce5c998
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 30 Apr 2024 11:17:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:18:41 +02:00

x86/percpu: Move some percpu macros around for readability

Move some percpu macros around to make a follow-up
patch more readable.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240430091833.196482-2-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 63 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cc40d8d..08113a2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -144,6 +144,29 @@
 #define __pcpu_reg_imm_4(x) "ri" (x)
 #define __pcpu_reg_imm_8(x) "re" (x)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+
+#define __raw_cpu_read(qual, pcp)					\
+({									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+})
+
+#define __raw_cpu_write(qual, pcp, val)					\
+do {									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
+} while (0)
+
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
+
+#define percpu_from_op(size, qual, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "m" (__my_cpu_var(_var)));				\
+	(typeof(_var))(unsigned long) pfo_val__;			\
+})
+
 #define percpu_to_op(size, qual, op, _var, _val)			\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
@@ -157,6 +180,17 @@ do {									\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
+#define percpu_stable_op(size, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "i" (&(_var)));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
+})
+
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
 	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
@@ -198,24 +232,6 @@ do {									\
 		percpu_binary_op(size, qual, "add", var, val);		\
 } while (0)
 
-#define percpu_from_op(size, qual, op, _var)				\
-({									\
-	__pcpu_type_##size pfo_val__;					\
-	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
-	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "m" (__my_cpu_var(_var)));				\
-	(typeof(_var))(unsigned long) pfo_val__;			\
-})
-
-#define percpu_stable_op(size, op, _var)				\
-({									\
-	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
-	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "i" (&(_var)));					\
-	(typeof(_var))(unsigned long) pfo_val__;			\
-})
-
 /*
  * Add return operation
  */
@@ -433,17 +449,6 @@ do {									\
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
-
-#define __raw_cpu_read(qual, pcp)					\
-({									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
-})
-
-#define __raw_cpu_write(qual, pcp, val)					\
-do {									\
-	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
-} while (0)
-
 #define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
 #define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
 #define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)

