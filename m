Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77F3915F3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhEZL0f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhEZL0M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9634C06138A;
        Wed, 26 May 2021 04:24:38 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HCL42G7AWbFT3lLxfFHn3qD9pXzrWOVcixdm/i4jlo=;
        b=Gr7KE9OWnSjPbhTRaWIslJr4YqG9uow7JYM/Z1ohGhQE9Z7v3VRNJ8TkN2+DeqQ9H/NPnO
        XyIDyZXh+P3bvt1ytVBtXWx+so5R7DyWySa+i/RGrhVZtG4HUbm6tTT25WTErgBRypU5NT
        LqwPv3tiK26FIGaBHgpQOy3jPk5skLR9xCt8ZakQXO37kBVX1LT/vLXuWVBcJhL3mtQ2Zz
        kN1mrYvobkWJeFXNyUnsxCHYuOWnW6S1sf2ObG9A0BUsTjCXUlpJuGg/W63fUXnXnf4wkt
        5jR1FLZ4bTh5odNCmoBXD9+xdfWHCcwHU6kF+k5Hs1CEfzd4YqN6sR0ZZ77yuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HCL42G7AWbFT3lLxfFHn3qD9pXzrWOVcixdm/i4jlo=;
        b=cob4iUzUupdBg0I8VIUMjPVcpImv0M+eKTur/Dy4/8d1sJ1Vs85uXXyvXJoWvA8gk2gMeR
        QblUuhZx6fW7XCAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: csky: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-17-mark.rutland@arm.com>
References: <20210525140232.53872-17-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827656.29796.15300505070585751024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a5fb82d7e2695e667badeac202fb7d113a8ae9a9
Gitweb:        https://git.kernel.org/tip/a5fb82d7e2695e667badeac202fb7d113a8ae9a9
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: csky: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates csky to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-17-mark.rutland@arm.com
---
 arch/csky/Kconfig               | 1 +
 arch/csky/include/asm/cmpxchg.h | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8de5b98..3521f14 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,6 +2,7 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index dabc8e4..d1bef11 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -31,7 +31,7 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define xchg_relaxed(ptr, x) \
+#define arch_xchg_relaxed(ptr, x) \
 		(__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
 
 #define __cmpxchg_relaxed(ptr, old, new, size)			\
@@ -61,14 +61,14 @@ extern void __bad_xchg(void);
 	__ret;							\
 })
 
-#define cmpxchg_relaxed(ptr, o, n) \
+#define arch_cmpxchg_relaxed(ptr, o, n) \
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
-#define cmpxchg(ptr, o, n) 					\
+#define arch_cmpxchg(ptr, o, n) 				\
 ({								\
 	__typeof__(*(ptr)) __ret;				\
 	__smp_release_fence();					\
-	__ret = cmpxchg_relaxed(ptr, o, n);			\
+	__ret = arch_cmpxchg_relaxed(ptr, o, n);		\
 	__smp_acquire_fence();					\
 	__ret;							\
 })
