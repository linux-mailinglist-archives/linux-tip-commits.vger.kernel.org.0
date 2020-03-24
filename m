Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABE1908AA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCXJLU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:11:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgCXJLT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaX-0007Yx-05; Tue, 24 Mar 2020 10:11:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16FA01C04CD;
        Tue, 24 Mar 2020 10:11:01 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:11:00 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] asm-generic, atomic-instrumented: Use generic
 instrumented.h
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504106076.28353.9742147000469942537.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     ed8af2e4d2a71bd58f5776b7e5a477d136e32be4
Gitweb:        https://git.kernel.org/tip/ed8af2e4d2a71bd58f5776b7e5a477d136e32be4
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 21 Jan 2020 17:05:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:41:42 +01:00

asm-generic, atomic-instrumented: Use generic instrumented.h

This switches atomic-instrumented.h to use the generic instrumentation
wrappers provided by instrumented.h.

No functional change intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 395 ++++++++++-----------
 scripts/atomic/gen-atomic-instrumented.sh |  19 +-
 2 files changed, 194 insertions(+), 220 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 63869de..379986e 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -19,25 +19,12 @@
 
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
-#include <linux/kasan-checks.h>
-#include <linux/kcsan-checks.h>
-
-static __always_inline void __atomic_check_read(const volatile void *v, size_t size)
-{
-	kasan_check_read(v, size);
-	kcsan_check_atomic_read(v, size);
-}
-
-static __always_inline void __atomic_check_write(const volatile void *v, size_t size)
-{
-	kasan_check_write(v, size);
-	kcsan_check_atomic_write(v, size);
-}
+#include <linux/instrumented.h>
 
 static __always_inline int
 atomic_read(const atomic_t *v)
 {
-	__atomic_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
 #define atomic_read atomic_read
@@ -46,7 +33,7 @@ atomic_read(const atomic_t *v)
 static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
-	__atomic_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read_acquire(v);
 }
 #define atomic_read_acquire atomic_read_acquire
@@ -55,7 +42,7 @@ atomic_read_acquire(const atomic_t *v)
 static __always_inline void
 atomic_set(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
 #define atomic_set atomic_set
@@ -64,7 +51,7 @@ atomic_set(atomic_t *v, int i)
 static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set_release(v, i);
 }
 #define atomic_set_release atomic_set_release
@@ -73,7 +60,7 @@ atomic_set_release(atomic_t *v, int i)
 static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
@@ -82,7 +69,7 @@ atomic_add(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
@@ -92,7 +79,7 @@ atomic_add_return(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
@@ -102,7 +89,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
@@ -112,7 +99,7 @@ atomic_add_return_release(int i, atomic_t *v)
 static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
@@ -122,7 +109,7 @@ atomic_add_return_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
@@ -132,7 +119,7 @@ atomic_fetch_add(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
@@ -142,7 +129,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
@@ -152,7 +139,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
@@ -161,7 +148,7 @@ atomic_fetch_add_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
@@ -170,7 +157,7 @@ atomic_sub(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
@@ -180,7 +167,7 @@ atomic_sub_return(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
@@ -190,7 +177,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
@@ -200,7 +187,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
@@ -210,7 +197,7 @@ atomic_sub_return_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
@@ -220,7 +207,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
@@ -230,7 +217,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
@@ -240,7 +227,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
@@ -250,7 +237,7 @@ atomic_fetch_sub_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_inc(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
@@ -260,7 +247,7 @@ atomic_inc(atomic_t *v)
 static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
@@ -270,7 +257,7 @@ atomic_inc_return(atomic_t *v)
 static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
@@ -280,7 +267,7 @@ atomic_inc_return_acquire(atomic_t *v)
 static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
@@ -290,7 +277,7 @@ atomic_inc_return_release(atomic_t *v)
 static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
@@ -300,7 +287,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
@@ -310,7 +297,7 @@ atomic_fetch_inc(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
@@ -320,7 +307,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
@@ -330,7 +317,7 @@ atomic_fetch_inc_release(atomic_t *v)
 static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
@@ -340,7 +327,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 static __always_inline void
 atomic_dec(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
@@ -350,7 +337,7 @@ atomic_dec(atomic_t *v)
 static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
@@ -360,7 +347,7 @@ atomic_dec_return(atomic_t *v)
 static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
@@ -370,7 +357,7 @@ atomic_dec_return_acquire(atomic_t *v)
 static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
@@ -380,7 +367,7 @@ atomic_dec_return_release(atomic_t *v)
 static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
@@ -390,7 +377,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
@@ -400,7 +387,7 @@ atomic_fetch_dec(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
@@ -410,7 +397,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
@@ -420,7 +407,7 @@ atomic_fetch_dec_release(atomic_t *v)
 static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
@@ -429,7 +416,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
@@ -438,7 +425,7 @@ atomic_and(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
@@ -448,7 +435,7 @@ atomic_fetch_and(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
@@ -458,7 +445,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
@@ -468,7 +455,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
@@ -478,7 +465,7 @@ atomic_fetch_and_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
@@ -488,7 +475,7 @@ atomic_andnot(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
@@ -498,7 +485,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
@@ -508,7 +495,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
@@ -518,7 +505,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
@@ -527,7 +514,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
@@ -536,7 +523,7 @@ atomic_or(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
@@ -546,7 +533,7 @@ atomic_fetch_or(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
@@ -556,7 +543,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
@@ -566,7 +553,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
@@ -575,7 +562,7 @@ atomic_fetch_or_relaxed(int i, atomic_t *v)
 static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
@@ -584,7 +571,7 @@ atomic_xor(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
@@ -594,7 +581,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
@@ -604,7 +591,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
@@ -614,7 +601,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
@@ -624,7 +611,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
 static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
@@ -634,7 +621,7 @@ atomic_xchg(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
@@ -644,7 +631,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
@@ -654,7 +641,7 @@ atomic_xchg_release(atomic_t *v, int i)
 static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
@@ -664,7 +651,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
 static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
@@ -674,7 +661,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
@@ -684,7 +671,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
@@ -694,7 +681,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
@@ -704,8 +691,8 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #define atomic_try_cmpxchg atomic_try_cmpxchg
@@ -715,8 +702,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
@@ -726,8 +713,8 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 #define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
@@ -737,8 +724,8 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
@@ -748,7 +735,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
@@ -758,7 +745,7 @@ atomic_sub_and_test(int i, atomic_t *v)
 static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
@@ -768,7 +755,7 @@ atomic_dec_and_test(atomic_t *v)
 static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
@@ -778,7 +765,7 @@ atomic_inc_and_test(atomic_t *v)
 static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
@@ -788,7 +775,7 @@ atomic_add_negative(int i, atomic_t *v)
 static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
@@ -798,7 +785,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
 static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
@@ -808,7 +795,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
 static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
@@ -818,7 +805,7 @@ atomic_inc_not_zero(atomic_t *v)
 static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
@@ -828,7 +815,7 @@ atomic_inc_unless_negative(atomic_t *v)
 static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
@@ -838,7 +825,7 @@ atomic_dec_unless_positive(atomic_t *v)
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
@@ -847,7 +834,7 @@ atomic_dec_if_positive(atomic_t *v)
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
-	__atomic_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
 #define atomic64_read atomic64_read
@@ -856,7 +843,7 @@ atomic64_read(const atomic64_t *v)
 static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
-	__atomic_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read_acquire(v);
 }
 #define atomic64_read_acquire atomic64_read_acquire
@@ -865,7 +852,7 @@ atomic64_read_acquire(const atomic64_t *v)
 static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
 #define atomic64_set atomic64_set
@@ -874,7 +861,7 @@ atomic64_set(atomic64_t *v, s64 i)
 static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set_release(v, i);
 }
 #define atomic64_set_release atomic64_set_release
@@ -883,7 +870,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
@@ -892,7 +879,7 @@ atomic64_add(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
@@ -902,7 +889,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
@@ -912,7 +899,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
@@ -922,7 +909,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
@@ -932,7 +919,7 @@ atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
@@ -942,7 +929,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
@@ -952,7 +939,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
@@ -962,7 +949,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
@@ -971,7 +958,7 @@ atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
@@ -980,7 +967,7 @@ atomic64_sub(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
@@ -990,7 +977,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
@@ -1000,7 +987,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
@@ -1010,7 +997,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
@@ -1020,7 +1007,7 @@ atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
@@ -1030,7 +1017,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
@@ -1040,7 +1027,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
@@ -1050,7 +1037,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
@@ -1060,7 +1047,7 @@ atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
@@ -1070,7 +1057,7 @@ atomic64_inc(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
@@ -1080,7 +1067,7 @@ atomic64_inc_return(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
@@ -1090,7 +1077,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
@@ -1100,7 +1087,7 @@ atomic64_inc_return_release(atomic64_t *v)
 static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
@@ -1110,7 +1097,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
@@ -1120,7 +1107,7 @@ atomic64_fetch_inc(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
@@ -1130,7 +1117,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
@@ -1140,7 +1127,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
@@ -1150,7 +1137,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
@@ -1160,7 +1147,7 @@ atomic64_dec(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
@@ -1170,7 +1157,7 @@ atomic64_dec_return(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
@@ -1180,7 +1167,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
@@ -1190,7 +1177,7 @@ atomic64_dec_return_release(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
@@ -1200,7 +1187,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
@@ -1210,7 +1197,7 @@ atomic64_fetch_dec(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
@@ -1220,7 +1207,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
@@ -1230,7 +1217,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
@@ -1239,7 +1226,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
@@ -1248,7 +1235,7 @@ atomic64_and(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
@@ -1258,7 +1245,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
@@ -1268,7 +1255,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
@@ -1278,7 +1265,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
@@ -1288,7 +1275,7 @@ atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
@@ -1298,7 +1285,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
@@ -1308,7 +1295,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
@@ -1318,7 +1305,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
@@ -1328,7 +1315,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
@@ -1337,7 +1324,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
@@ -1346,7 +1333,7 @@ atomic64_or(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
@@ -1356,7 +1343,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
@@ -1366,7 +1353,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
@@ -1376,7 +1363,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
@@ -1385,7 +1372,7 @@ atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
@@ -1394,7 +1381,7 @@ atomic64_xor(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
@@ -1404,7 +1391,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
@@ -1414,7 +1401,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
@@ -1424,7 +1411,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
@@ -1434,7 +1421,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
@@ -1444,7 +1431,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
@@ -1454,7 +1441,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
@@ -1464,7 +1451,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
@@ -1474,7 +1461,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
@@ -1484,7 +1471,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
@@ -1494,7 +1481,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
@@ -1504,7 +1491,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
@@ -1514,8 +1501,8 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
@@ -1525,8 +1512,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
@@ -1536,8 +1523,8 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 #define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
@@ -1547,8 +1534,8 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
-	__atomic_check_write(v, sizeof(*v));
-	__atomic_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
@@ -1558,7 +1545,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
@@ -1568,7 +1555,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
 static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
@@ -1578,7 +1565,7 @@ atomic64_dec_and_test(atomic64_t *v)
 static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
@@ -1588,7 +1575,7 @@ atomic64_inc_and_test(atomic64_t *v)
 static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
@@ -1598,7 +1585,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
 static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
@@ -1608,7 +1595,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
@@ -1618,7 +1605,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
@@ -1628,7 +1615,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
@@ -1638,7 +1625,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
@@ -1648,7 +1635,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
-	__atomic_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1658,7 +1645,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1667,7 +1654,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1676,7 +1663,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1685,7 +1672,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1694,7 +1681,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1703,7 +1690,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1712,7 +1699,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1721,7 +1708,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1730,7 +1717,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1739,7 +1726,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1748,7 +1735,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1757,7 +1744,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1765,28 +1752,28 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg64_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define sync_cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg_double(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1794,9 +1781,9 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_double_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	__atomic_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 7b7e2af0e75c8ecb6f02298a7075f503f30d244c
+// 89bf97f3a7509b740845e51ddf31055b48a81f40
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index fb42225..6afadf7 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -20,7 +20,7 @@ gen_param_check()
 	# We don't write to constant parameters
 	[ ${type#c} != ${type} ] && rw="read"
 
-	printf "\t__atomic_check_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
 }
 
 #gen_param_check(arg...)
@@ -107,7 +107,7 @@ cat <<EOF
 #define ${xchg}(ptr, ...)						\\
 ({									\\
 	typeof(ptr) __ai_ptr = (ptr);					\\
-	__atomic_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
 	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
 })
 EOF
@@ -148,20 +148,7 @@ cat << EOF
 
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
-#include <linux/kasan-checks.h>
-#include <linux/kcsan-checks.h>
-
-static __always_inline void __atomic_check_read(const volatile void *v, size_t size)
-{
-	kasan_check_read(v, size);
-	kcsan_check_atomic_read(v, size);
-}
-
-static __always_inline void __atomic_check_write(const volatile void *v, size_t size)
-{
-	kasan_check_write(v, size);
-	kcsan_check_atomic_write(v, size);
-}
+#include <linux/instrumented.h>
 
 EOF
 
