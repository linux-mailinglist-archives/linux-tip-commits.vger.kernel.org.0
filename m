Return-Path: <linux-tip-commits+bounces-1275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F38CA9DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 10:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0481F21A3B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9354675;
	Tue, 21 May 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqFt/s8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvFuB72T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB551C4F;
	Tue, 21 May 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279691; cv=none; b=hLKrYyKaCveLwswFdSUN2uCOXQUGqhe+nyOiYZIbLMKoj94a2X7LnZUTtSfpaOLfdXi82KyGR4/r0vMPLqhnWsoVsNH4XybP6AGMQxbCuqp4zeZ09cf6Cz/3rdu4JY0ePF8rNV1FYQvZhQmdlA5v4nI2IfcBzrWhKgrePOfRQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279691; c=relaxed/simple;
	bh=TPNf0DN9ZUALd+1/r4ahQlBuhwHVsSYRR+3/ur3Jz9U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hKJiNBkBc0vS3HGFNNSUjPnKavD/IFlPC0hfJkIFcY4aDwIZIpAmOlA7z6YpvsLu5R5nWN6VcP32GBZf2tkT0xEwAONMmcCcBoBhrdf6hhmlmYwMYmbXXE4eshwG7mYFpcy3tpwsGY0+qC/qTmLQ9kMvNCBlrLgnTMTmK5/VwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqFt/s8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvFuB72T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 08:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716279687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqGa1COheHGNBGh5TZ+qFIrrxvZKLlcTiRfbU4RvjQA=;
	b=RqFt/s8nvcHTGmCNNx6GOfa/r2DVlSgS2Q8c2sydrLswj5DucfLkUJMwfXuzVr7x1vs9e0
	H9ikQHuqsx8vlYCjw/AEQvaNKQwHjV0IKrT71RkKxRIZfPk1wFe9Z3qCaj62K53+fjHPWU
	UU7nEGQeA1xWIPODOeWUDOm5/kO2S72RKnVcTsSD+EW9dxyK5aCS0dEHYIMMul8zJYemca
	EpTLEImhPmRE6sy7nfyC1JZTqgC92mq4flmzvDCUT0NRIxy/NhYHz9mq34DNS23a+fSxte
	YAIU5bf/N4cP4JpZ6AV4R4m9d/2bW21lzwXKYoYccdOHyDqhSHe8/SMxa+osGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716279687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqGa1COheHGNBGh5TZ+qFIrrxvZKLlcTiRfbU4RvjQA=;
	b=jvFuB72TAfPUSshNPIPmTP4uQnoM3sYmUkKERYWt7Vo8GhTqkFFr3x6yDmcQgcXGL5O4Ul
	CZ/7DbhJGhD2K9Dw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Move some percpu accessors around to
 reduce ifdeffery
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240520080951.121049-2-ubizjak@gmail.com>
References: <20240520080951.121049-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171627968673.10875.680212759397687471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     47c9dbd2fb5f98453840e18ebced9138ec8b4cc5
Gitweb:        https://git.kernel.org/tip/47c9dbd2fb5f98453840e18ebced9138ec8b4cc5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 20 May 2024 10:09:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 20 May 2024 10:25:31 +02:00

x86/percpu: Move some percpu accessors around to reduce ifdeffery

Move some percpu accessors around, mainly to reduce ifdeffery
and improve readabilty by following dependencies between
accessors.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240520080951.121049-2-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 40 ++++++++++++++++------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 39762fc..0f0d897 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -445,17 +445,6 @@ do {									\
 #define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
 #endif
 
-/*
- * this_cpu_read() makes gcc load the percpu variable every time it is
- * accessed while this_cpu_read_stable() allows the value to be cached.
- * this_cpu_read_stable() is more efficient and can be used if its value
- * is guaranteed to be valid across cpus.  The current users include
- * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
- * actually per-thread variables implemented as per-CPU variables and
- * thus stable for the duration of the respective task.
- */
-#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
-
 #define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
 #define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
 #define raw_cpu_read_4(pcp)		__raw_cpu_read(4, , pcp)
@@ -470,16 +459,6 @@ do {									\
 #define this_cpu_write_2(pcp, val)	__raw_cpu_write(2, volatile, pcp, val)
 #define this_cpu_write_4(pcp, val)	__raw_cpu_write(4, volatile, pcp, val)
 
-#ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
-#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
-
-#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
-#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
-#endif
-
-#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
-
 #define this_cpu_read_stable_1(pcp)	__raw_cpu_read_stable(1, pcp)
 #define this_cpu_read_stable_2(pcp)	__raw_cpu_read_stable(2, pcp)
 #define this_cpu_read_stable_4(pcp)	__raw_cpu_read_stable(4, pcp)
@@ -535,6 +514,12 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
+
+#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
+
 #define this_cpu_read_stable_8(pcp)	__raw_cpu_read_stable(8, pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
@@ -561,6 +546,19 @@ do {									\
 #define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
 #endif
 
+#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
+
+/*
+ * this_cpu_read() makes gcc load the percpu variable every time it is
+ * accessed while this_cpu_read_stable() allows the value to be cached.
+ * this_cpu_read_stable() is more efficient and can be used if its value
+ * is guaranteed to be valid across cpus.  The current users include
+ * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * actually per-thread variables implemented as per-CPU variables and
+ * thus stable for the duration of the respective task.
+ */
+#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
+
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
 ({									\
 	unsigned long __percpu *addr__ =				\

