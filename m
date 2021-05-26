Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A753915FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhEZL0w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhEZL0Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC8C061342;
        Wed, 26 May 2021 04:24:40 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAehNavPfqpGxWOrjrWMXeQvOAAx2V1T0/rcwvcfPTE=;
        b=lY5VjfEPcjTHT5UYFquXVaBiaPZOjHxWeDTrEOVYnZZcBH2x38ZjDL0Izo8fpkSKpZTirp
        f9nCED2SN/WfTot/ix42zLJcBZ7i9brM5gmB40cecRYKekNe/GFIoZtatpTVuISmv4cm5o
        MqBu98qf2n8vkbycqwAwY4M2dFa6t9jmxfoJtFq8wq9aLeu1f9UhBpO2UvSHn7FaU+i25U
        tAg43nPg2MH9fYm2BEbDeXch/Yt2+sKSm+SmjTo+jZl2TnJrML1kPx5H8+ieomyKmiuDZv
        srFx6J0/UrF3Shnpj3c5UvNnkACrLo6I3vl2yDgxe5KqBGIPNeccOyYol6+o8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAehNavPfqpGxWOrjrWMXeQvOAAx2V1T0/rcwvcfPTE=;
        b=15nZsUu7rRRFv6hH2kMcuxTEnhluI9IAoaDqJgBW9/NLEa3fuPloHxvJjW5hu23XZGn39b
        LWwAJ911rpBkP4AA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: cmpxchg: make `generic` a prefix
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-12-mark.rutland@arm.com>
References: <20210525140232.53872-12-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827863.29796.15038205386704992672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6988631bdfddcedc1d27f83723ea36a442f00ea1
Gitweb:        https://git.kernel.org/tip/6988631bdfddcedc1d27f83723ea36a442f00ea1
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: cmpxchg: make `generic` a prefix

The asm-generic implementations of cmpxchg_local() and cmpxchg64_local()
use a `_generic` suffix to distinguish themselves from arch code or
wrappers used elsewhere.

Subsequent patches will add ARCH_ATOMIC support to these
implementations, and will distinguish more functions with a `generic`
portion. To align with how ARCH_ATOMIC uses an `arch_` prefix, it would
be helpful to use a `generic_` prefix rather than a `_generic` suffix.

In preparation for this, this patch renames the existing functions to
make `generic` a prefix rather than a suffix. There should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-12-mark.rutland@arm.com
---
 arch/arm/include/asm/cmpxchg.h      | 6 +++---
 arch/m68k/include/asm/cmpxchg.h     | 2 +-
 arch/mips/include/asm/cmpxchg.h     | 2 +-
 arch/parisc/include/asm/cmpxchg.h   | 4 ++--
 arch/powerpc/include/asm/cmpxchg.h  | 2 +-
 arch/sparc/include/asm/cmpxchg_32.h | 4 ++--
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 arch/xtensa/include/asm/cmpxchg.h   | 6 +++---
 include/asm-generic/cmpxchg-local.h | 4 ++--
 include/asm-generic/cmpxchg.h       | 4 ++--
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 8b701f8..06bd8ce 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -135,13 +135,13 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
  * them available.
  */
 #define cmpxchg_local(ptr, o, n) ({					\
-	(__typeof(*ptr))__cmpxchg_local_generic((ptr),			\
+	(__typeof(*ptr))__generic_cmpxchg_local((ptr),			\
 					        (unsigned long)(o),	\
 					        (unsigned long)(n),	\
 					        sizeof(*(ptr)));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #include <asm-generic/cmpxchg.h>
 
@@ -224,7 +224,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #ifdef CONFIG_CPU_V6	/* min ARCH == ARMv6 */
 	case 1:
 	case 2:
-		ret = __cmpxchg_local_generic(ptr, old, new, size);
+		ret = __generic_cmpxchg_local(ptr, old, new, size);
 		break;
 #endif
 	default:
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index a4aa820..7629c9c 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -80,7 +80,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 
 #include <asm-generic/cmpxchg-local.h>
 
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 extern unsigned long __invalid_cmpxchg_size(volatile void *,
 					    unsigned long, unsigned long, int);
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index ed8f3f3..c7e0455 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -222,7 +222,7 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #else
 
 # include <asm-generic/cmpxchg-local.h>
-# define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+# define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 # ifdef CONFIG_SMP
 
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 84ee232..c201565 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -98,7 +98,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 #endif
 	case 4:	return __cmpxchg_u32(ptr, old, new_);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new_, size);
+		return __generic_cmpxchg_local(ptr, old, new_, size);
 	}
 }
 
@@ -116,7 +116,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	cmpxchg_local((ptr), (o), (n));					\
 })
 #else
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #define cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index cf091c4..69f52fd 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -524,7 +524,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 })
 #else
 #include <asm-generic/cmpxchg-local.h>
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index a53d744..86e3da1 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -73,8 +73,8 @@ u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
  * them available.
  */
 #define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 316faa0..8915b57 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -189,7 +189,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	case 4:
 	case 8:	return __cmpxchg(ptr, old, new, size);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new, size);
+		return __generic_cmpxchg_local(ptr, old, new, size);
 	}
 
 	return old;
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index a175f8a..9c4d6e5 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -97,7 +97,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	default:
-		return __cmpxchg_local_generic(ptr, old, new, size);
+		return __generic_cmpxchg_local(ptr, old, new, size);
 	}
 
 	return old;
@@ -108,9 +108,9 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * them available.
  */
 #define cmpxchg_local(ptr, o, n)				  	       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #define cmpxchg64(ptr, o, n)    cmpxchg64_local((ptr), (o), (n))
 
 /*
diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index f17f14f..380cdc8 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -12,7 +12,7 @@ extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
  * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
  * long parameter, supporting various types of architectures.
  */
-static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
+static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
 		unsigned long old, unsigned long new, int size)
 {
 	unsigned long flags, prev;
@@ -51,7 +51,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
 /*
  * Generic version of __cmpxchg64_local. Takes an u64 parameter.
  */
-static inline u64 __cmpxchg64_local_generic(volatile void *ptr,
+static inline u64 __generic_cmpxchg64_local(volatile void *ptr,
 		u64 old, u64 new)
 {
 	u64 prev;
diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 9a24510..b9d54c7 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -94,13 +94,13 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 
 #ifndef cmpxchg_local
 #define cmpxchg_local(ptr, o, n) ({					       \
-	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))));		       \
 })
 #endif
 
 #ifndef cmpxchg64_local
-#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
