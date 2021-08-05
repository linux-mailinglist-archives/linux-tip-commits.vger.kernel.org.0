Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A103E1186
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhHEJlJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:41:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41766 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhHEJlI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:41:08 -0400
Date:   Thu, 05 Aug 2021 09:40:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BhiYzFXXoOB2NzAmG/ntMAHRWWOA1ZOdwYH+Lm3qQ4=;
        b=qVwu6cN6ZSGJ9NndMSx+huAepAquKs4bQyQ7h2vnlbm4bY2m8aJE4QnDrPm0b10XMCondb
        nTF54o4iL2OgQM4kYT50Yu0Ix4hM12CTrQRpahzTERnJlhhG2a+oQaG4G50YZlVUJxK5J0
        a+rTYmtGIm0qRui1wBblc6ocG/khibazfPb94grGGMGk0QbCaPtdgRr9lbxs/PLCFs+aYg
        8Hcc02QnFYVo7vMeui5ksdnhbuUxquyjaF7tvKMeL+AXm2Ow3NZeM9d9kR9wV2Cv+yi5Cv
        zfUyuMbSjWLectnG5jM1RFQAuZSLIBBFYfccSuQPQTdurgXQMa+PJyFlZHDv6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BhiYzFXXoOB2NzAmG/ntMAHRWWOA1ZOdwYH+Lm3qQ4=;
        b=aOMnGCeyN+IvkIKRTrhgLZP4hLukkuelnCSRptyU6lYzrtQ0z460xo6zmKW1fMDkU7PDp8
        1ZM19q9bou7TRbDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: simplify non-atomic wrappers
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210721155813.17082-1-mark.rutland@arm.com>
References: <20210721155813.17082-1-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162815645243.395.654022295244268825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9248e52fec9536590852844b0634b5d20483c1ab
Gitweb:        https://git.kernel.org/tip/9248e52fec9536590852844b0634b5d20483c1ab
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 21 Jul 2021 16:58:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:47 +02:00

locking/atomic: simplify non-atomic wrappers

Since the non-atomic arch_*() bitops use plain accesses, they are
implicitly instrumnted by the compiler, and we work around this in the
instrumented wrappers to avoid double instrumentation.

It's simpler to avoid the wrappers entirely, and use the preprocessor to
alias the arch_*() bitops to their regular versions, removing the need
for checks in the instrumented wrappers.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210721155813.17082-1-mark.rutland@arm.com
---
 include/asm-generic/bitops/instrumented-non-atomic.h | 21 +++--------
 include/asm-generic/bitops/non-atomic.h              | 16 +++-----
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index e6c1540..37363d5 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -24,8 +24,7 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___set_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -40,8 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___clear_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -56,8 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___change_bit_uses_plain_access))
-		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -95,8 +92,7 @@ static inline void __instrument_read_write_bitop(long nr, volatile unsigned long
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_set_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -110,8 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_clear_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -125,8 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	if (!__is_defined(arch___test_and_change_bit_uses_plain_access))
-		__instrument_read_write_bitop(nr, addr);
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -137,8 +131,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	if (!__is_defined(arch_test_bit_uses_plain_access))
-		instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index c8149cd..365377f 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -21,7 +21,7 @@ arch___set_bit(int nr, volatile unsigned long *addr)
 
 	*p  |= mask;
 }
-#define arch___set_bit_uses_plain_access
+#define __set_bit arch___set_bit
 
 static __always_inline void
 arch___clear_bit(int nr, volatile unsigned long *addr)
@@ -31,7 +31,7 @@ arch___clear_bit(int nr, volatile unsigned long *addr)
 
 	*p &= ~mask;
 }
-#define arch___clear_bit_uses_plain_access
+#define __clear_bit arch___clear_bit
 
 /**
  * arch___change_bit - Toggle a bit in memory
@@ -50,7 +50,7 @@ void arch___change_bit(int nr, volatile unsigned long *addr)
 
 	*p ^= mask;
 }
-#define arch___change_bit_uses_plain_access
+#define __change_bit arch___change_bit
 
 /**
  * arch___test_and_set_bit - Set a bit and return its old value
@@ -71,7 +71,7 @@ arch___test_and_set_bit(int nr, volatile unsigned long *addr)
 	*p = old | mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_set_bit_uses_plain_access
+#define __test_and_set_bit arch___test_and_set_bit
 
 /**
  * arch___test_and_clear_bit - Clear a bit and return its old value
@@ -92,7 +92,7 @@ arch___test_and_clear_bit(int nr, volatile unsigned long *addr)
 	*p = old & ~mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_clear_bit_uses_plain_access
+#define __test_and_clear_bit arch___test_and_clear_bit
 
 /* WARNING: non atomic and it can be reordered! */
 static __always_inline int
@@ -105,7 +105,7 @@ arch___test_and_change_bit(int nr, volatile unsigned long *addr)
 	*p = old ^ mask;
 	return (old & mask) != 0;
 }
-#define arch___test_and_change_bit_uses_plain_access
+#define __test_and_change_bit arch___test_and_change_bit
 
 /**
  * arch_test_bit - Determine whether a bit is set
@@ -117,8 +117,6 @@ arch_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
-#define arch_test_bit_uses_plain_access
-
-#include <asm-generic/bitops/instrumented-non-atomic.h>
+#define test_bit arch_test_bit
 
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
