Return-Path: <linux-tip-commits+bounces-1272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB78C9044
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0CB1F223FB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061138DE0;
	Sat, 18 May 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjeuPRk/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNSiUhAV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27E2837A;
	Sat, 18 May 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025497; cv=none; b=KAMODBMIFQM+SbkLjGc/WE+T7LSsVejNLyUuHpWvx+UA2erssztCXzjCbnlzS+NnjpMOHTyMwak6skSYkwqQRs/eZWP/O7QuLYr1q5b6SOQ1ZcyhBWVrjKb1jp5zN563MnnHhmxrN0m2cUtzMXTk4aSyxhY2F9VkjAS5hM0OP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025497; c=relaxed/simple;
	bh=8z05cY+mbdh4yYltdeYUT+ZofwhgIVGvfP5ZRDafZ70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hIZKCqTeb5TdvZsnioehB9UdIxJ/OtQ9zd4+m7G1S5BgZyOrAitrzhtPFrk1KjvNJ7lS3kGWuDDUkkpKUMSbO2z+RnoGk4/pImWt34ToiWzdT0MBSoLQnR5Y2MKrTvFXa+q/vwmdthRYImkizsn4mpuGD93hUoI0MQGTLfVwce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjeuPRk/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNSiUhAV; arc=none smtp.client-ip=193.142.43.55
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
	bh=gyVKrmsE63DweEgFk7nEy8vMGDAVV6PsNXGWAj0IS1M=;
	b=ZjeuPRk/k4IcJr08RIrFkVbNcRIJaujFuJ9Xr1qIOKJ+HSwp4Khr4oocVFffsP6xS59M9B
	+rwbzYGXU4YGJBHZQmtQuvq52H5BG7nmNn8HG5N+7hpq5ikzq5G2UcVMiAA9cl4NO9m3wk
	p8yQ0UdYa/KIOAXp/7NivyUhX1SUQsmXF8GGM78ZVsmsTzTpJLOBItqdyWbVJvoOg7RbVn
	rOHDRJP742Eb5XfEh+hS1oyplIlUd31H5GAvi74iFrZGaA3fkfgZL7bwt4FMC3p1jeTT74
	SSamZESYjeZBH2qObQpjKr4xtGMoh42fICTO8zFVfTGCCr8WfUsJXd/ZrnjX2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyVKrmsE63DweEgFk7nEy8vMGDAVV6PsNXGWAj0IS1M=;
	b=yNSiUhAV1l98JCaLp9YD3waBSaKjfqMEzT6CYGkjvpBv+h/AqLjGmqyDRrFv4+X2Dti8G7
	I4vie80WKL86F0AQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Introduce the pcpu_binary_op() macro
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240430091833.196482-1-ubizjak@gmail.com>
References: <20240430091833.196482-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602549323.10875.9152383980991692175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     455ca134a7b2121dd739d425d3be313fb52f0651
Gitweb:        https://git.kernel.org/tip/455ca134a7b2121dd739d425d3be313fb52f0651
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 30 Apr 2024 11:17:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:18:40 +02:00

x86/percpu: Introduce the pcpu_binary_op() macro

Introduce the pcpu_binary_op() macro, a copy of the percpu_to_op() macro.

Update percpu binary operators to use the new macro, since
percpu_to_op() will be re-purposed as a raw percpu write accessor
in a follow-up patch.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240430091833.196482-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 47 +++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3bedee1..cc40d8d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -163,6 +163,19 @@ do {									\
 	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
+#define percpu_binary_op(size, qual, op, _var, _val)			\
+do {									\
+	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+	if (0) {		                                        \
+		typeof(_var) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	    : [var] "+m" (__my_cpu_var(_var))				\
+	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
+} while (0)
+
 /*
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
@@ -182,7 +195,7 @@ do {									\
 	else if (pao_ID__ == -1)					\
 		percpu_unary_op(size, qual, "dec", var);		\
 	else								\
-		percpu_to_op(size, qual, "add", var, val);		\
+		percpu_binary_op(size, qual, "add", var, val);		\
 } while (0)
 
 #define percpu_from_op(size, qual, op, _var)				\
@@ -492,12 +505,12 @@ do {									\
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_binary_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_binary_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_binary_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_binary_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_binary_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_binary_op(4, , "or", (pcp), val)
 #define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
@@ -505,12 +518,12 @@ do {									\
 #define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_binary_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_binary_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_binary_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_binary_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_binary_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_binary_op(4, volatile, "or", (pcp), val)
 #define this_cpu_xchg_1(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	this_percpu_xchg_op(pcp, nval)
@@ -543,16 +556,16 @@ do {									\
 #define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_binary_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_binary_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 #define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_binary_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_binary_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)

