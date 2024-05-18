Return-Path: <linux-tip-commits+bounces-1270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395028C9040
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25E228266C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE32C184;
	Sat, 18 May 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pan0W+V4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NpyVQRPB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42022836A;
	Sat, 18 May 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025496; cv=none; b=NAMKNW9rgXfZ3mIED/P2BTot3nN6XRJjt/8gBAhWmZ/HO8KMdNE3SQODEzSktZuusFLb4/LgUEckZVHZAFfxH31KZCteuVW07wHNaFH4EhuVy3Se6nO+DbiC9a0XvczSKuavJXWzVThb058gi3HKHDbm47yRavgGrpP/yo4oGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025496; c=relaxed/simple;
	bh=AI+t6zpublXmQIQ+zjmZoiZaL0Ft+D6TidHrfg3aavY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r7c65eENcn1xi+QIruqLhzrOdh5AMBJJRLCNMzCtwmPXWHnGTxqhP0zs1XCQIbOxI6aiVn+fsEMgCvae4wNaIcb44oPVMwtHVT/x2J14A/HqG3EYq7o+lvja4Y3AV+gGGQOjvb6zl30kRhsTgnAgHRakaqLR+8chJ7yakScyVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pan0W+V4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NpyVQRPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 18 May 2024 09:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTzgtNx6gdO94XBxjhxacMMmTYb8fe/UfzxbjVapMD8=;
	b=Pan0W+V4fVbNQ6qLt9FvmYc4yTxmga2kaw3GD6wVbUesCxIFURCyZGKtqyfPXLUXcsK3+t
	A7lBtEzyMUNSDdYrw/ve2RWJoKKzvR+M+2oCDvZ1Et1Xq/x7B0Bz+XbKTy9+6Uq3EhCQYt
	IuQucI6QPWeGbtIwcKfH49777+Btihhvq5/7OJkjHqyrZCrbicID1nXHuZ88hVaPDCdy4F
	UNybuY7VkkSyAIH7fJFSHiaLwkOMocCEmsuYG7iwJDjQP99fuuGbPJ7rn11V5Nh+kESLS7
	Q/Z63trEeqatA5E7zwnReZZvX25b3rSwDVXVAFjpW0+ymrFrZQZegVPvUlq/fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTzgtNx6gdO94XBxjhxacMMmTYb8fe/UfzxbjVapMD8=;
	b=NpyVQRPBIIhiu2mZKOztjMxD7knodloZvDe1IsB/XjaikSAijMhBsb0L2CizqjMj43Lz3h
	v1QIijMOxzxr4LCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Unify percpu read-write accessors
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240430091833.196482-3-ubizjak@gmail.com>
References: <20240430091833.196482-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602549296.10875.10251646123842908935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     a50ea641296699af1947336c2e75f6234f53548a
Gitweb:        https://git.kernel.org/tip/a50ea641296699af1947336c2e75f6234f53548a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 30 Apr 2024 11:17:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:18:41 +02:00

x86/percpu: Unify percpu read-write accessors

Redefine percpu_from_op() and percpu_to_op() as __raw_cpu_read()
and __raw_cpu_write().  Unify __raw_cpu_{read,write}() macros
between configs w/ and w/o USE_X86_SEG_SUPPORT in order to
unify {raw,this}_cpu{read_write}_N() accessors between configs.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240430091833.196482-3-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 72 +++++++++++-----------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 08113a2..f360ac5 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -146,28 +146,28 @@
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
 
-#define __raw_cpu_read(qual, pcp)					\
+#define __raw_cpu_read(size, qual, pcp)					\
 ({									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
 })
 
-#define __raw_cpu_write(qual, pcp, val)					\
+#define __raw_cpu_write(size, qual, pcp, val)				\
 do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define percpu_from_op(size, qual, op, _var)				\
+#define __raw_cpu_read(size, qual, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
-#define percpu_to_op(size, qual, op, _var, _val)			\
+#define __raw_cpu_write(size, qual, _var, _val)				\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 	if (0) {		                                        \
@@ -175,7 +175,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
 	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -448,54 +448,32 @@ do {									\
  */
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-#define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(, pcp, val)
-#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(, pcp, val)
-#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(, pcp, val)
-
-#define this_cpu_read_1(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_read_2(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_read_4(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_write_1(pcp, val)	__raw_cpu_write(volatile, pcp, val)
-#define this_cpu_write_2(pcp, val)	__raw_cpu_write(volatile, pcp, val)
-#define this_cpu_write_4(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
+#define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
+#define raw_cpu_read_4(pcp)		__raw_cpu_read(4, , pcp)
+#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(1, , pcp, val)
+#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(2, , pcp, val)
+#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(4, , pcp, val)
+
+#define this_cpu_read_1(pcp)		__raw_cpu_read(1, volatile, pcp)
+#define this_cpu_read_2(pcp)		__raw_cpu_read(2, volatile, pcp)
+#define this_cpu_read_4(pcp)		__raw_cpu_read(4, volatile, pcp)
+#define this_cpu_write_1(pcp, val)	__raw_cpu_write(1, volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)	__raw_cpu_write(2, volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)	__raw_cpu_write(4, volatile, pcp, val)
 
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
 
-#define this_cpu_read_8(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
 #endif
 
-#define this_cpu_read_const(pcp)	__raw_cpu_read(, pcp)
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+#define this_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
-
-#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
-
-#ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		percpu_from_op(8, , "mov", pcp)
-#define raw_cpu_write_8(pcp, val)	percpu_to_op(8, , "mov", (pcp), val)
-
-#define this_cpu_read_8(pcp)		percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
-#endif
-
 /*
  * The generic per-cpu infrastrucutre is not suitable for
  * reading const-qualified variables.

