Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5B28842C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgJIH7R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbgJIH66 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76408C0613E2;
        Fri,  9 Oct 2020 00:58:56 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Cxbq4CjaBfgoU6k+HJJBge9MldMVqVir+AmG+wlB4gI=;
        b=nxhP0End8AQ+GbunTRIx89tx/hOuc82rci0qGIRrf2xvfYpnRgfSdVuh63f1HBTWhpD3S9
        8DfAvPj7OeF9LrkPTNR4IlIy/wn1I7eQVZV2J7UA+t7lhNYd4ZwYae8eUyQUEl+ZSc7J1L
        ++kuxQUEfLHivh36cd4Rg6RAZHRy4Gskdyh3fHPzJCtCUsd9byafU8BErHxahryA9ybTvw
        9TY5gY+FwG0WUax4/4scGpF1KF2WilVkWYA5/cATrwer7KmPJ2fBYJAFgH8Dpip9gzrAx8
        t+0b0G6MZ9JRqu+iiSibM6poWu9ud6vOvZ09Oq+Q6e9OEf17YvLZa5oufpwsbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Cxbq4CjaBfgoU6k+HJJBge9MldMVqVir+AmG+wlB4gI=;
        b=06lEDVin/RFti5ELPUeoe3uqR949O3T0TFFXpAmspYjv9OsbB+9dotCQuwvLHoteh6T06I
        IDFvzWGSRsSMElBw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Add support for atomic builtins
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033420.7002.10586896539346377009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f8ad5f2e93425812c393c91ceb5af3d95e79b10
Gitweb:        https://git.kernel.org/tip/0f8ad5f2e93425812c393c91ceb5af3d95e79b10
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 03 Jul 2020 15:40:29 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:05 -07:00

kcsan: Add support for atomic builtins

Some architectures (currently e.g. s390 partially) implement atomics
using the compiler's atomic builtins (__atomic_*, __sync_*). To support
enabling KCSAN on such architectures in future, or support experimental
use of these builtins, implement support for them.

We should also avoid breaking KCSAN kernels due to use (accidental or
otherwise) of atomic builtins in drivers, as has happened in the past:
https://lkml.kernel.org/r/5231d2c0-41d9-6721-e15f-a7eedf3ce69e@infradead.org

The instrumentation is subtly different from regular reads/writes: TSAN
instrumentation replaces the use of atomic builtins with a call into the
runtime, and the runtime's job is to also execute the desired atomic
operation. We rely on the __atomic_* compiler builtins, available with
all KCSAN-supported compilers, to implement each TSAN atomic
instrumentation function.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9147ff6..682d9fd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -879,3 +879,113 @@ void __tsan_init(void)
 {
 }
 EXPORT_SYMBOL(__tsan_init);
+
+/*
+ * Instrumentation for atomic builtins (__atomic_*, __sync_*).
+ *
+ * Normal kernel code _should not_ be using them directly, but some
+ * architectures may implement some or all atomics using the compilers'
+ * builtins.
+ *
+ * Note: If an architecture decides to fully implement atomics using the
+ * builtins, because they are implicitly instrumented by KCSAN (and KASAN,
+ * etc.), implementing the ARCH_ATOMIC interface (to get instrumentation via
+ * atomic-instrumented) is no longer necessary.
+ *
+ * TSAN instrumentation replaces atomic accesses with calls to any of the below
+ * functions, whose job is to also execute the operation itself.
+ */
+
+#define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
+	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
+	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		return __atomic_load_n(ptr, memorder);                                             \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
+	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
+	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		__atomic_store_n(ptr, v, memorder);                                                \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
+
+#define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
+	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
+	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		return __atomic_##op##suffix(ptr, v, memorder);                                    \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
+
+/*
+ * Note: CAS operations are always classified as write, even in case they
+ * fail. We cannot perform check_access() after a write, as it might lead to
+ * false positives, in cases such as:
+ *
+ *	T0: __atomic_compare_exchange_n(&p->flag, &old, 1, ...)
+ *
+ *	T1: if (__atomic_load_n(&p->flag, ...)) {
+ *		modify *p;
+ *		p->flag = 0;
+ *	    }
+ *
+ * The only downside is that, if there are 3 threads, with one CAS that
+ * succeeds, another CAS that fails, and an unmarked racing operation, we may
+ * point at the wrong CAS as the source of the race. However, if we assume that
+ * all CAS can succeed in some other execution, the data race is still valid.
+ */
+#define DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strength, weak)                                           \
+	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
+							      u##bits val, int mo, int fail_mo);   \
+	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
+							      u##bits val, int mo, int fail_mo)    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
+
+#define DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)                                                       \
+	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
+							   int mo, int fail_mo);                   \
+	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
+							   int mo, int fail_mo)                    \
+	{                                                                                          \
+		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
+		return exp;                                                                        \
+	}                                                                                          \
+	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_val)
+
+#define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
+	DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
+	DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits, );                                                  \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits, );                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits, );                                                \
+	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
+	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
+	DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
+
+DEFINE_TSAN_ATOMIC_OPS(8);
+DEFINE_TSAN_ATOMIC_OPS(16);
+DEFINE_TSAN_ATOMIC_OPS(32);
+DEFINE_TSAN_ATOMIC_OPS(64);
+
+void __tsan_atomic_thread_fence(int memorder);
+void __tsan_atomic_thread_fence(int memorder)
+{
+	__atomic_thread_fence(memorder);
+}
+EXPORT_SYMBOL(__tsan_atomic_thread_fence);
+
+void __tsan_atomic_signal_fence(int memorder);
+void __tsan_atomic_signal_fence(int memorder) { }
+EXPORT_SYMBOL(__tsan_atomic_signal_fence);
