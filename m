Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4958628843F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgJIH7e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB38C0613E0;
        Fri,  9 Oct 2020 00:58:55 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vQiXLdKOfH4AiaambxhSae6lJy9fTAuSRVZhygBvYPc=;
        b=G2nxPnrovK+QsJIFEq1WsuIb3xPP269bt5EmydNPCH1x6MooxZXdkaZSigQbkd0v0zflTn
        gMQ3Ii+CqL2DJ6CuBuL3ey4xeRAxkrw3mPf4HHNPeN1YDvkxL+tIAiIKPPDR40/hCcQnzw
        bZNlTM2++vR/f04OYVV5daqdM8znIH2IKNIxuVwCCdEftiHy8q9HzFXS7gVb4/LACXaPmp
        RPQRYW15pr9fP4J239Goo2MHRMFSFntFCARRvOv20aDfvZhnd/WBbih1IOfKmWmhyzxzCZ
        I+mFL43GAJwSAPX2kP8o8gfntfvo7TB4ayK4uV8En5U0KfqW1SQSMyRKIqvyBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vQiXLdKOfH4AiaambxhSae6lJy9fTAuSRVZhygBvYPc=;
        b=PFqGip4Hd62Exk5Kb3fDP+0j28wwJrPgrcg/EnX/PaE6KrA3okh3sdA5XL17+07q601iZf
        q5VnLA3NozYR80Dg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Support compounded read-write instrumentation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033272.7002.4146607715325630004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     14e2ac8de0f91f12122a49f09897b0cd05256460
Gitweb:        https://git.kernel.org/tip/14e2ac8de0f91f12122a49f09897b0cd05256460
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:01 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:32 -07:00

kcsan: Support compounded read-write instrumentation

Add support for compounded read-write instrumentation if supported by
the compiler. Adds the necessary instrumentation functions, and a new
type which is used to generate a more descriptive report.

Furthermore, such compounded memory access instrumentation is excluded
from the "assume aligned writes up to word size are atomic" rule,
because we cannot assume that the compiler emits code that is atomic for
compound ops.

LLVM/Clang added support for the feature in:
https://github.com/llvm/llvm-project/commit/785d41a261d136b64ab6c15c5d35f2adc5ad53e3

The new instrumentation is emitted for sets of memory accesses in the
same basic block to the same address with at least one read appearing
before a write. These typically result from compound operations such as
++, --, +=, -=, |=, &=, etc. but also equivalent forms such as "var =
var + 1". Where the compiler determines that it is equivalent to emit a
call to a single __tsan_read_write instead of separate __tsan_read and
__tsan_write, we can then benefit from improved performance and better
reporting for such access patterns.

The new reports now show that the ops are both reads and writes, for
example:

	read-write to 0xffffffff90548a38 of 8 bytes by task 143 on cpu 3:
	 test_kernel_rmw_array+0x45/0xa0
	 access_thread+0x71/0xb0
	 kthread+0x21e/0x240
	 ret_from_fork+0x22/0x30

	read-write to 0xffffffff90548a38 of 8 bytes by task 144 on cpu 2:
	 test_kernel_rmw_array+0x45/0xa0
	 access_thread+0x71/0xb0
	 kthread+0x21e/0x240
	 ret_from_fork+0x22/0x30

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 45 +++++++++++++++++++++++------------
 kernel/kcsan/core.c          | 23 ++++++++++++++----
 kernel/kcsan/report.c        |  4 +++-
 scripts/Makefile.kcsan       |  2 +-
 4 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index c5f6c1d..cf14840 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -7,19 +7,13 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
-/*
- * ACCESS TYPE MODIFIERS
- *
- *   <none>: normal read access;
- *   WRITE : write access;
- *   ATOMIC: access is atomic;
- *   ASSERT: access is not a regular access, but an assertion;
- *   SCOPED: access is a scoped access;
- */
-#define KCSAN_ACCESS_WRITE  0x1
-#define KCSAN_ACCESS_ATOMIC 0x2
-#define KCSAN_ACCESS_ASSERT 0x4
-#define KCSAN_ACCESS_SCOPED 0x8
+/* Access types -- if KCSAN_ACCESS_WRITE is not set, the access is a read. */
+#define KCSAN_ACCESS_WRITE	(1 << 0) /* Access is a write. */
+#define KCSAN_ACCESS_COMPOUND	(1 << 1) /* Compounded read-write instrumentation. */
+#define KCSAN_ACCESS_ATOMIC	(1 << 2) /* Access is atomic. */
+/* The following are special, and never due to compiler instrumentation. */
+#define KCSAN_ACCESS_ASSERT	(1 << 3) /* Access is an assertion. */
+#define KCSAN_ACCESS_SCOPED	(1 << 4) /* Access is a scoped access. */
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
@@ -205,6 +199,15 @@ static inline void __kcsan_disable_current(void) { }
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
 /**
+ * __kcsan_check_read_write - check regular read-write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define __kcsan_check_read_write(ptr, size)                                    \
+	__kcsan_check_access(ptr, size, KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+
+/**
  * kcsan_check_read - check regular read access for races
  *
  * @ptr: address of access
@@ -221,18 +224,30 @@ static inline void __kcsan_disable_current(void) { }
 #define kcsan_check_write(ptr, size)                                           \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
+/**
+ * kcsan_check_read_write - check regular read-write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define kcsan_check_read_write(ptr, size)                                      \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+
 /*
  * Check for atomic accesses: if atomic accesses are not ignored, this simply
  * aliases to kcsan_check_access(), otherwise becomes a no-op.
  */
 #ifdef CONFIG_KCSAN_IGNORE_ATOMICS
-#define kcsan_check_atomic_read(...)	do { } while (0)
-#define kcsan_check_atomic_write(...)	do { } while (0)
+#define kcsan_check_atomic_read(...)		do { } while (0)
+#define kcsan_check_atomic_write(...)		do { } while (0)
+#define kcsan_check_atomic_read_write(...)	do { } while (0)
 #else
 #define kcsan_check_atomic_read(ptr, size)                                     \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
 #define kcsan_check_atomic_write(ptr, size)                                    \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
+#define kcsan_check_atomic_read_write(ptr, size)                               \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND)
 #endif
 
 /**
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 682d9fd..4c8b40b 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -223,7 +223,7 @@ is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx
 
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
 	    (type & KCSAN_ACCESS_WRITE) && size <= sizeof(long) &&
-	    IS_ALIGNED((unsigned long)ptr, size))
+	    !(type & KCSAN_ACCESS_COMPOUND) && IS_ALIGNED((unsigned long)ptr, size))
 		return true; /* Assume aligned writes up to word size are atomic. */
 
 	if (ctx->atomic_next > 0) {
@@ -793,7 +793,17 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	EXPORT_SYMBOL(__tsan_write##size);                                     \
 	void __tsan_unaligned_write##size(void *ptr)                           \
 		__alias(__tsan_write##size);                                   \
-	EXPORT_SYMBOL(__tsan_unaligned_write##size)
+	EXPORT_SYMBOL(__tsan_unaligned_write##size);                           \
+	void __tsan_read_write##size(void *ptr);                               \
+	void __tsan_read_write##size(void *ptr)                                \
+	{                                                                      \
+		check_access(ptr, size,                                        \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE);      \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_read_write##size);                                \
+	void __tsan_unaligned_read_write##size(void *ptr)                      \
+		__alias(__tsan_read_write##size);                              \
+	EXPORT_SYMBOL(__tsan_unaligned_read_write##size)
 
 DEFINE_TSAN_READ_WRITE(1);
 DEFINE_TSAN_READ_WRITE(2);
@@ -916,7 +926,8 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -944,7 +955,8 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -955,7 +967,8 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 9d07e17..3e83a69 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -228,6 +228,10 @@ static const char *get_access_type(int type)
 		return "write";
 	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked)";
+	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
+		return "read-write";
+	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "read-write (marked)";
 	case KCSAN_ACCESS_SCOPED:
 		return "read (scoped)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index c50f27b..c37f951 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -11,5 +11,5 @@ endif
 # of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
-	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
+	$(call cc-option,$(call cc-param,tsan-compound-read-before-write=1),$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1))) \
 	$(call cc-param,tsan-distinguish-volatile=1)
