Return-Path: <linux-tip-commits+bounces-3614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D536A4425D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 15:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3322B3AC226
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1D26AAA7;
	Tue, 25 Feb 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERMyERd0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9AgIOMO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EB26A1AA;
	Tue, 25 Feb 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492964; cv=none; b=GFbt1rBrl70Js1UpSD4MGkvWVp/DL5oiU+X8y8Lt+DoljEXlqZj/R7HUadD9dPgv2SY5v4hVDq9L+PM5ozqBLy5fXkzf4EwhL7UfjYW0kzznKK1oOvMzxNzQi7ioLHB1KnkCk+uIKe+S3jcQ7KbPx93lZzkFNKQMEiLuhfqBTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492964; c=relaxed/simple;
	bh=8pAdhdEVaSl4+WzVZNBmko/WUYFPnVWN7eNCfLu71B8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GrxIu+d/S6b1sWon7jGUbz6rVCXhOGbC5ObZSBlTONJEitztMV1QPc7hvYNSDwyMThLvB0WQSyBOT0bnsAUPv3ILHCRYvc9CuASSFirKO9JDyRT6PcCb98t8jccnBwGTNU6QLHRAxRgydb371qRki4RpYOWXAzsqB09DkTomiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERMyERd0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9AgIOMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492961;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+YBpm3YN6ZyhIoR2BwIl1p+727obGBEohPgOdpryGM=;
	b=ERMyERd08uxK/1dNRMiV12Z99i9EXvJv1F7/4YRhISF1hv4PMIJEMW5T37QVxRJIiTOXK5
	av+l5ckwrqjEnFhdEsBV6iz99e6NHoUYhceNPfcdOMUo6XKkj79rgmvM2LN4lvUVJb0spi
	Pxv1Z40w/XOR9J1PiiYddOWKppdACZl9vGRVX8TtOQ4x8/L69A/3UT5AOx6ozVV3texEhc
	mrrMyKcWWwVV23yrdmAgTOq1b3COFk5Gzxy3yF0kAzVhkudAOczDPiDXc7uTiLoOknfHaQ
	Dg0t25zBDCV8ZRwwGgh4ObbUwf2pC0Lfssywjlypy02QrjU1neL5fRT5PQMQLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492961;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+YBpm3YN6ZyhIoR2BwIl1p+727obGBEohPgOdpryGM=;
	b=r9AgIOMORVp7/Ap/VGopvPQUDEJzlJZxR5Ow1uiv608IoYTMEr7uSw+Uqv0tviYHyJor/K
	dvUtmwFIfpi9IVCg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/percpu: Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224071648.15913-1-ubizjak@gmail.com>
References: <20250224071648.15913-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049295970.10177.923059003267464697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d40459cc157f8ed8d28434c761ca7010630351be
Gitweb:        https://git.kernel.org/tip/d40459cc157f8ed8d28434c761ca7010630351be
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 24 Feb 2025 08:16:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2025 20:41:59 +01:00

x86/percpu: Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N()

Unify __pcpu_op1_N() and __pcpu_op2_N() macros to __pcpu_op_N()
by applying the macro only to asm mnemonic, not to the mnemonic
plus its arguments.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250224071648.15913-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1a76eb8..c2a9dfc 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -106,15 +106,10 @@
 #define __pcpu_cast_4(val)	((u32)(((unsigned long) val) & 0xffffffff))
 #define __pcpu_cast_8(val)	((u64)(val))
 
-#define __pcpu_op1_1(op, dst)	op "b " dst
-#define __pcpu_op1_2(op, dst)	op "w " dst
-#define __pcpu_op1_4(op, dst)	op "l " dst
-#define __pcpu_op1_8(op, dst)	op "q " dst
-
-#define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
-#define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
-#define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
-#define __pcpu_op2_8(op, src, dst) op "q " src ", " dst
+#define __pcpu_op_1(op)		op "b "
+#define __pcpu_op_2(op)		op "w "
+#define __pcpu_op_4(op)		op "l "
+#define __pcpu_op_8(op)		op "q "
 
 #define __pcpu_reg_1(mod, x)	mod "q" (x)
 #define __pcpu_reg_2(mod, x)	mod "r" (x)
@@ -146,7 +141,8 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
+	asm qual (__pcpu_op_##size("mov")				\
+		  __percpu_arg([var]) ", %[val]"			\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 									\
@@ -162,7 +158,8 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
+	asm qual (__pcpu_op_##size("mov") "%[val], "			\
+		  __percpu_arg([var])					\
 	    : [var] "=m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -179,7 +176,8 @@ do {									\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
 									\
-	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
+	asm(__pcpu_op_##size("mov")					\
+	    __force_percpu_arg(a[var]) ", %[val]"			\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 									\
@@ -188,7 +186,7 @@ do {									\
 
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
-	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size(op) __percpu_arg([var])		\
 	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
@@ -201,7 +199,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	asm qual (__pcpu_op_##size(op) "%[val], " __percpu_arg([var])	\
 	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -237,8 +235,8 @@ do {									\
 ({									\
 	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
 									\
-	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
-				     __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("xadd") "%[tmp], "			\
+		  __percpu_arg([var])					\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
@@ -281,8 +279,8 @@ do {									\
 	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
 									\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
+		  __percpu_arg([var])					\
 		  : [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
@@ -298,8 +296,8 @@ do {									\
 	__pcpu_type_##size pco_old__ = *pco_oval__;			\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
 									\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
+	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
+		  __percpu_arg([var])					\
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\

