Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B993915FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhEZL0v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhEZL0P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC8FC06138E;
        Wed, 26 May 2021 04:24:40 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zr708ljbfNsj8M1IftW6uj6j4L/Urw8dudnzs/Eh3tk=;
        b=Lb83x0xufzOuYAoZ09M4RfUjwfeeOsUr5olrIHnFOtaTpkl0P+QFKue6jp5+JN48K7E2WN
        Nspxo/qxujXjUvV9jAGdZxYIOz4vk7eaD+HnzIvI9skSeq1TPq55X2QdugZUH+3TZDN5pM
        0/R7BLHrV9uwPT16qzG2j7BZ1v+ztvle5kVaHjw/q90hQRr/+hrDAdTnnXszrNVKAwi6kc
        lsbW65z+LsQXOM3l7MnEkWaCwrMn7xtlKMN+N5eipwDxkLpZppvEL/2/PvHRz0Yvp3bDYR
        YlywTmYUVya7Wl9JS7pYgVhedQ6DBAADKLnr8+i+x22BHYJoNQY0HK6edhRikA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zr708ljbfNsj8M1IftW6uj6j4L/Urw8dudnzs/Eh3tk=;
        b=HiwYcKjKKG1zDBvRp1ZqxJo+ZASXEiy4Rq+AtXAvoKyayT5ZEoEKTzdDQpwgMDEw3lN9t+
        +y8UtYDSYAgNw0BQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: cmpxchg: support ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-13-mark.rutland@arm.com>
References: <20210525140232.53872-13-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827822.29796.2868576462985035147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     82b993e8249ae3cb29c1b6eb8f6548f5748508b7
Gitweb:        https://git.kernel.org/tip/82b993e8249ae3cb29c1b6eb8f6548f5748508b7
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: cmpxchg: support ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/cmpxchg.h or
asm-generic/cmpxhg-local.h, and it's impractical to convert the headers
and all these architectures in one go. To make it possible to convert
them one-by-one, let's make the asm-generic implementation function as
either cmpxchg*() or arch_cmpxchg*() depending on whether ARCH_ATOMIC is
selected. To do this, the generic implementations are prefixed as
generic_cmpxchg_*(), and preprocessor definitions map
cmpxchg_*()/arch_cmpxchg_*() onto these as appropriate.

Once all users are moved over to ARCH_ATOMIC the ifdeffery in the header
can be simplified and/or removed entirely.

For existing users (none of which select ARCH_ATOMIC), there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-13-mark.rutland@arm.com
---
 include/asm-generic/cmpxchg.h | 61 ++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index b9d54c7..98c9311 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -14,16 +14,14 @@
 #include <linux/types.h>
 #include <linux/irqflags.h>
 
-#ifndef xchg
-
 /*
  * This function doesn't exist, so you'll get a linker error if
  * something tries to do an invalidly-sized xchg().
  */
-extern void __xchg_called_with_bad_pointer(void);
+extern void __generic_xchg_called_with_bad_pointer(void);
 
 static inline
-unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
+unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
 {
 	unsigned long ret, flags;
 
@@ -75,35 +73,64 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #endif /* CONFIG_64BIT */
 
 	default:
-		__xchg_called_with_bad_pointer();
+		__generic_xchg_called_with_bad_pointer();
 		return x;
 	}
 }
 
-#define xchg(ptr, x) ({							\
-	((__typeof__(*(ptr)))						\
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+#define generic_xchg(ptr, x) ({							\
+	((__typeof__(*(ptr)))							\
+		__generic_xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
 })
 
-#endif /* xchg */
-
 /*
  * Atomic compare and exchange.
  */
 #include <asm-generic/cmpxchg-local.h>
 
-#ifndef cmpxchg_local
-#define cmpxchg_local(ptr, o, n) ({					       \
-	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))));		       \
+#define generic_cmpxchg_local(ptr, o, n) ({					\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),	\
+			(unsigned long)(n), sizeof(*(ptr))));			\
 })
+
+#define generic_cmpxchg64_local(ptr, o, n) \
+	__generic_cmpxchg64_local((ptr), (o), (n))
+
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#ifndef arch_xchg
+#define arch_xchg		generic_xchg
+#endif
+
+#ifndef arch_cmpxchg_local
+#define arch_cmpxchg_local	generic_cmpxchg_local
+#endif
+
+#ifndef arch_cmpxchg64_local
+#define arch_cmpxchg64_local	generic_cmpxchg64_local
+#endif
+
+#define arch_cmpxchg		arch_cmpxchg_local
+#define arch_cmpxchg64		arch_cmpxchg64_local
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#ifndef xchg
+#define xchg			generic_xchg
+#endif
+
+#ifndef cmpxchg_local
+#define cmpxchg_local		generic_cmpxchg_local
 #endif
 
 #ifndef cmpxchg64_local
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg64_local		generic_cmpxchg64_local
 #endif
 
-#define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg			cmpxchg_local
+#define cmpxchg64		cmpxchg64_local
+
+#endif /* CONFIG_ARCH_ATOMIC */
 
 #endif /* __ASM_GENERIC_CMPXCHG_H */
