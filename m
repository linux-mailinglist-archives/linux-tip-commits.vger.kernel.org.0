Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05C288444
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgJIH7r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgJIH6y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:54 -0400
Date:   Fri, 09 Oct 2020 07:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3OeCffDjtyHcmZBq4A8jjrfHUX+diIOIvDmkbBwCz6A=;
        b=fiyq5+Ko+I0JWBMIF1GUOdpepkS7Xc7k6DT/kxkQCurjz8/DkJLv7jr9cQSJC47UUWCoA+
        YgbcfJzGzQDjUveSt1Fp/Q/7P69vRZNNWVGfdLGcJt+abCcbW9+il66W8WwSsdRiREz23d
        6qM2msYtv5V/P/WDU5ucXmxel6zI6urdiUc9MWsJ7iJACGQDDjQdGrm1Zvk7y7/NWzZO0v
        gwLk6Vmo0/Y3UWlBhf+Lj9O0ob4WjNb74rToRhi8k1Bmv8L3yZXrzyuAyaQJk4alDZxS1M
        lWG31MJYnu1EVHO3nsvqMytQGH1wb99dCtmXO9fvaoQMb2IYsZ9dH5ybMmW9aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3OeCffDjtyHcmZBq4A8jjrfHUX+diIOIvDmkbBwCz6A=;
        b=PB2sSPXazQPSpid5HLVqeRWrWHsysYPA5NF/ubJ5wswD/wa4w/9DGOWDu8RpB2u35SE7h5
        t+qY6xaEyRtYloBA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033121.7002.3263763439921146417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9d1335cc1e97cc3da0d14f640dd716e614083e8b
Gitweb:        https://git.kernel.org/tip/9d1335cc1e97cc3da0d14f640dd716e614083e8b
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:04 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:57 -07:00

kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks

Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
instrumentation.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 95a364e..99e5044 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -914,14 +914,19 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
+		}                                                                                  \
 		return __atomic_load_n(ptr, memorder);                                             \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
+		}                                                                                  \
 		__atomic_store_n(ptr, v, memorder);                                                \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
@@ -930,8 +935,11 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -959,8 +967,11 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -971,8 +982,11 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
+		}                                                                                  \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
