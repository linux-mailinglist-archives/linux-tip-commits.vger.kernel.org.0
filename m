Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D722ACDB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jul 2020 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgGWKn4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Jul 2020 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgGWKnr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663BC0619E2;
        Thu, 23 Jul 2020 03:43:47 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTlsLoraggDU+Clrj3reZVhl+kWmRN8MTA85IEO5F5k=;
        b=xT2KU9Dfn5X51PojnXcXSTzSfdDw0J7M2JwBJ02v00hcwZEcDTtDQGU27MOYf+QF+TwJ9r
        Q+LejBmV3bzPSMAOV9z1avGGTYdPRdtq6OMkjYOk+x9UVXjzTjCAHA3DKmbSLd99wUtVkt
        8iAtT5bom1FIvav4vdRZqjeluKwbAYj9O4WHpQdTuzfTNM1gjy6JPZBeZek3Szloyf7qnc
        zpD8FqXeUCdU+2c1YqiM+kL/B8utZ43intdc6Us5XzPl3Riun8YLiJ0WTVwR1RuGdYUDsa
        bmIdy6U4ZsGa45AVFVE53Z5Y2odFPjNxZdRG0THQmHkyXnKrekUvkoja4EBe2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTlsLoraggDU+Clrj3reZVhl+kWmRN8MTA85IEO5F5k=;
        b=xR4ipwjTrPlRpL7YM6hh9Hs0VrqiKSZKA98BCq9kkPnvSTPRYMhtQBOuP+w5blaQj/apbT
        GbSB+PyYNDvOESDw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Clean up percpu_to_op()
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-3-ndesaulniers@google.com>
References: <20200720204925.3654302-3-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102420.4006.10195873563197532952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c175acc14719e69ecec4dafbb642a7f38c76c064
Gitweb:        https://git.kernel.org/tip/c175acc14719e69ecec4dafbb642a7f38c76c064
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:16 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:39 +02:00

x86/percpu: Clean up percpu_to_op()

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-3-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 90 +++++++++++++---------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 19838e4..fb280fb 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
 #define __pcpu_reg_imm_4(x) "ri" (x)
 #define __pcpu_reg_imm_8(x) "re" (x)
 
-#define percpu_to_op(qual, op, var, val)		\
-do {							\
-	typedef typeof(var) pto_T__;			\
-	if (0) {					\
-		pto_T__ pto_tmp__;			\
-		pto_tmp__ = (val);			\
-		(void)pto_tmp__;			\
-	}						\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "qi" ((pto_T__)(val)));		\
-		break;					\
-	case 2:						\
-		asm qual (op "w %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 4:						\
-		asm qual (op "l %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 8:						\
-		asm qual (op "q %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "re" ((pto_T__)(val)));		\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
+#define percpu_to_op(size, qual, op, _var, _val)			\
+do {									\
+	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+	if (0) {		                                        \
+		typeof(_var) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	    : [var] "+m" (_var)						\
+	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
 /*
@@ -425,18 +405,18 @@ do {									\
 #define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
 
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
 
 /*
  * raw_cpu_xchg() can use a load-store since it is not required to be
@@ -456,18 +436,18 @@ do {									\
 #define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
 #define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
 #define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
@@ -509,19 +489,19 @@ do {									\
  */
 #ifdef CONFIG_X86_64
 #define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
