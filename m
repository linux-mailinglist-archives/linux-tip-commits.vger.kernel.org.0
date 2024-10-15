Return-Path: <linux-tip-commits+bounces-2461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98099FB8C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B9286105
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E01F819A;
	Tue, 15 Oct 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5U4wkdD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYNfn96l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A351D63FA;
	Tue, 15 Oct 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032088; cv=none; b=Ta1zWxuPp+CQRS8IyrhhV9e10MWHHhsYdOg550/t1lPVb2lwhm6SJL2+WMsqR8r0ns4rMclzPInlAjI5gR9XICRgbVFVVDSKnHXN2BQqAdlfkiGG19mdi+3hyYgk1QQ3xxSV85mxOkPCQiZc7opPJUmEpkiyzwdg7r5g+2UDxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032088; c=relaxed/simple;
	bh=S0xEBgsnaGGxkJeKxhtgH2X5JVcuFE3RQOr+KcNRxwo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F8KBQobeu07c5s6NOQpAKvJoOlzVqGev0PSXI9vO8NzDsX/eKMjrjCB3P7FGTYbnZf0FfooHmW9ibNy/I2WjKR4k+0kj7alBwAdIuop2lzTEE/e0Tj0hapGk7nfIBQDtHz/dOew7kCFj0fNAh50ar8jm+4psf6pTm1RffjJ/rvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5U4wkdD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYNfn96l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONq20KQcFT5cq7bp1cnPup0P5NoE7K4x7BTMKhfMpcw=;
	b=c5U4wkdDZLmWerQm4jvsmZukh3YQ5VQDOliCnGd2RPO+oXj8KY4dkVHK9EWTQy7zuANGxH
	ZJ6rpSozR/GJLHIgJ5y+51W150sse0H/3Nq5ngrUJcrB/MoWXO5gbm2RjEhXYg4T6MQW+Z
	kwzZfV6eFkIP2wxvWSl1UOwmV+PkUJJOIiOhu/TxBoAUmnhrldl5VEoEwmhBXOR0hKddEI
	p2bT283AiEed0SQPKEsbMSJB9wPnh4y2ogUBixEHygHy2ddHgPS4c+cn2cY/WemOVbVSY5
	xtgKjCONbj+4hmecW8qlUJ29CkHsFrYyIA6KHIeCEFaYbHLtun7qsvoK6id8Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032084;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONq20KQcFT5cq7bp1cnPup0P5NoE7K4x7BTMKhfMpcw=;
	b=cYNfn96laJF69Bwpo0jHeouquAFk7Fga6h4dMal8DNbpRKZ9JC0SPry8GULFAtt/KcJx9G
	eqzpo9yciMNu+XDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] delay: Rework udelay and ndelay
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-6-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-6-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208422.1442.9805747352086183936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19e2d91d8cb1f333adf04731f2788ff6ca06cebd
Gitweb:        https://git.kernel.org/tip/19e2d91d8cb1f333adf04731f2788ff6ca06cebd
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

delay: Rework udelay and ndelay

udelay() as well as ndelay() are defines and no functions and are using
constants to be able to transform a sleep time into loops and to prevent
too long udelays/ndelays. There was a compiler error with non-const 8 bit
arguments which was fixed by commit a87e553fabe8 ("asm-generic: delay.h fix
udelay and ndelay for 8 bit args"). When using a function, the non-const 8
bit argument is type casted and the problem would be gone.

Transform udelay() and ndelay() into proper functions, remove the no longer
and confusing division, add defines for the magic values and add some
explanations as well.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-6-dc8b907cb62f@linutronix.de

---
 include/asm-generic/delay.h | 65 ++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index a8cee41..76cf237 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
 
+#include <linux/math.h>
+#include <vdso/time64.h>
+
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
@@ -12,13 +15,18 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
 /*
- * Implementation details:
- *
- * * The weird n/20000 thing suppresses a "comparison is always false due to
- *   limited range of data type" warning with non-const 8-bit arguments.
- * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
- * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
+ * The microseconds/nanosecond delay multiplicators are used to convert a
+ * constant microseconds/nanoseconds value to a value which can be used by the
+ * architectures specific implementation to transform it into loops.
+ */
+#define UDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))
+#define NDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, NSEC_PER_SEC))
+
+/*
+ * The maximum constant udelay/ndelay value picked out of thin air to prevent
+ * too long constant udelays/ndelays.
  */
+#define DELAY_CONST_MAX   20000
 
 /**
  * udelay - Inserting a delay based on microseconds with busy waiting
@@ -45,17 +53,17 @@ extern void __delay(unsigned long loops);
  * #. cache behaviour affecting the time it takes to execute the loop function.
  * #. CPU clock rate changes.
  */
-#define udelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				 __bad_udelay();			\
-			else						\
-				__const_udelay((n) * 0x10c7ul);		\
-		} else {						\
-			__udelay(n);					\
-		}							\
-	})
+static __always_inline void udelay(unsigned long usec)
+{
+	if (__builtin_constant_p(usec)) {
+		if (usec >= DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(usec * UDELAY_CONST_MULT);
+	} else {
+		__udelay(usec);
+	}
+}
 
 /**
  * ndelay - Inserting a delay based on nanoseconds with busy waiting
@@ -63,16 +71,17 @@ extern void __delay(unsigned long loops);
  *
  * See udelay() for basic information about ndelay() and it's variants.
  */
-#define ndelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				__bad_ndelay();				\
-			else						\
-				__const_udelay((n) * 5ul);		\
-		} else {						\
-			__ndelay(n);					\
-		}							\
-	})
+static __always_inline void ndelay(unsigned long nsec)
+{
+	if (__builtin_constant_p(nsec)) {
+		if (nsec >= DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(nsec * NDELAY_CONST_MULT);
+	} else {
+		__udelay(nsec);
+	}
+}
+#define ndelay(x) ndelay(x)
 
 #endif /* __ASM_GENERIC_DELAY_H */

