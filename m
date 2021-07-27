Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD783D779E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhG0N6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhG0N6t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2AC061757;
        Tue, 27 Jul 2021 06:58:48 -0700 (PDT)
Date:   Tue, 27 Jul 2021 13:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvYJCmvQrqIFS3XLw+LMCL7jJJxElD2y1tCaomzJbzI=;
        b=WK3LhDhzkORsFz4F4c+m/ye1zyPHfTibtqoRtIMMfZLep+XbCOpSeldY230Z/lcKMsz9bt
        qb7gQxUSdGu4Fy4mI/lgfPhC4d35dDuaoQGTXWAxKjtBSImYRIDySr0YjxfH13OBYNMIWu
        pQv/HdG5PXPsEIrbW3E9tWMuKzhw5CG6YXSfl+86uGDhT647Nwp0KZ+nL/FD0VEHu2Ilnc
        eRCu9XOsZroSxPJPORjg2ulIBvmNmzE0x/UUX/1Rr+8Z5guQM5q+WMBtKD4gKSUo1Tzf/U
        m5F2PJ8kIG3277laWWEwxcNvkeOU7Xa9cfOHJYRLKMVj+63ljp97DWnC85LAjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvYJCmvQrqIFS3XLw+LMCL7jJJxElD2y1tCaomzJbzI=;
        b=w781RGS3q/qZsfNXVvn/Z71i/5ONbd7cCBEqGFy3FlJhWtVMOZTBJ6XTD1SUsclndXRCwt
        KuZ3UhQwNMPtHSBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: centralize generated headers
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713105253.7615-4-mark.rutland@arm.com>
References: <20210713105253.7615-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162739432529.395.15134503148604779319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e3d18cee258b898017b298b5b93f8134dd62aee3
Gitweb:        https://git.kernel.org/tip/e3d18cee258b898017b298b5b93f8134dd62aee3
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 13 Jul 2021 11:52:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:45 +02:00

locking/atomic: centralize generated headers

The generated atomic headers are only intended to be included directly
by <linux/atomic.h>, but are spread across include/linux/ and
include/asm-generic/, where people mnay be encouraged to include them.

This patch centralizes them under include/linux/atomic/.

Other than the header guards and hashes, there is no change to any of
the generated headers as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210713105253.7615-4-mark.rutland@arm.com
---
 include/asm-generic/atomic-instrumented.h   | 1337 +----------
 include/asm-generic/atomic-long.h           | 1014 +--------
 include/linux/atomic-arch-fallback.h        | 2361 +------------------
 include/linux/atomic.h                      |    7 +-
 include/linux/atomic/atomic-arch-fallback.h | 2361 ++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 1337 ++++++++++-
 include/linux/atomic/atomic-long.h          | 1014 ++++++++-
 scripts/atomic/check-atomics.sh             |    6 +-
 scripts/atomic/gen-atomic-instrumented.sh   |    6 +-
 scripts/atomic/gen-atomic-long.sh           |    6 +-
 scripts/atomic/gen-atomics.sh               |    6 +-
 11 files changed, 4727 insertions(+), 4728 deletions(-)
 delete mode 100644 include/asm-generic/atomic-instrumented.h
 delete mode 100644 include/asm-generic/atomic-long.h
 delete mode 100644 include/linux/atomic-arch-fallback.h
 create mode 100644 include/linux/atomic/atomic-arch-fallback.h
 create mode 100644 include/linux/atomic/atomic-instrumented.h
 create mode 100644 include/linux/atomic/atomic-long.h

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
deleted file mode 100644
index bc45af5..0000000
--- a/include/asm-generic/atomic-instrumented.h
+++ /dev/null
@@ -1,1337 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-instrumented.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-/*
- * This file provides wrappers with KASAN instrumentation for atomic operations.
- * To use this functionality an arch's atomic.h file needs to define all
- * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
- * this file at the end. This file provides atomic_read() that forwards to
- * arch_atomic_read() for actual atomic operation.
- * Note: if an arch atomic operation is implemented by means of other atomic
- * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
- * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
- * double instrumentation.
- */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-
-#include <linux/build_bug.h>
-#include <linux/compiler.h>
-#include <linux/instrumented.h>
-
-static __always_inline int
-atomic_read(const atomic_t *v)
-{
-	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_read(v);
-}
-
-static __always_inline int
-atomic_read_acquire(const atomic_t *v)
-{
-	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic_read_acquire(v);
-}
-
-static __always_inline void
-atomic_set(atomic_t *v, int i)
-{
-	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_set(v, i);
-}
-
-static __always_inline void
-atomic_set_release(atomic_t *v, int i)
-{
-	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic_set_release(v, i);
-}
-
-static __always_inline void
-atomic_add(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_add(i, v);
-}
-
-static __always_inline int
-atomic_add_return(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return(i, v);
-}
-
-static __always_inline int
-atomic_add_return_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_acquire(i, v);
-}
-
-static __always_inline int
-atomic_add_return_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_release(i, v);
-}
-
-static __always_inline int
-atomic_add_return_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_return_relaxed(i, v);
-}
-
-static __always_inline int
-atomic_fetch_add(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add(i, v);
-}
-
-static __always_inline int
-atomic_fetch_add_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_add_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_add_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_sub(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_sub(i, v);
-}
-
-static __always_inline int
-atomic_sub_return(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return(i, v);
-}
-
-static __always_inline int
-atomic_sub_return_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_acquire(i, v);
-}
-
-static __always_inline int
-atomic_sub_return_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_release(i, v);
-}
-
-static __always_inline int
-atomic_sub_return_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_return_relaxed(i, v);
-}
-
-static __always_inline int
-atomic_fetch_sub(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub(i, v);
-}
-
-static __always_inline int
-atomic_fetch_sub_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_sub_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_sub_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_inc(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_inc(v);
-}
-
-static __always_inline int
-atomic_inc_return(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return(v);
-}
-
-static __always_inline int
-atomic_inc_return_acquire(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_acquire(v);
-}
-
-static __always_inline int
-atomic_inc_return_release(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_release(v);
-}
-
-static __always_inline int
-atomic_inc_return_relaxed(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_return_relaxed(v);
-}
-
-static __always_inline int
-atomic_fetch_inc(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc(v);
-}
-
-static __always_inline int
-atomic_fetch_inc_acquire(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_acquire(v);
-}
-
-static __always_inline int
-atomic_fetch_inc_release(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_release(v);
-}
-
-static __always_inline int
-atomic_fetch_inc_relaxed(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic_dec(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_dec(v);
-}
-
-static __always_inline int
-atomic_dec_return(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return(v);
-}
-
-static __always_inline int
-atomic_dec_return_acquire(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_acquire(v);
-}
-
-static __always_inline int
-atomic_dec_return_release(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_release(v);
-}
-
-static __always_inline int
-atomic_dec_return_relaxed(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_return_relaxed(v);
-}
-
-static __always_inline int
-atomic_fetch_dec(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec(v);
-}
-
-static __always_inline int
-atomic_fetch_dec_acquire(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_acquire(v);
-}
-
-static __always_inline int
-atomic_fetch_dec_release(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_release(v);
-}
-
-static __always_inline int
-atomic_fetch_dec_relaxed(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic_and(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_and(i, v);
-}
-
-static __always_inline int
-atomic_fetch_and(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and(i, v);
-}
-
-static __always_inline int
-atomic_fetch_and_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_and_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_and_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_andnot(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_andnot(i, v);
-}
-
-static __always_inline int
-atomic_fetch_andnot(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot(i, v);
-}
-
-static __always_inline int
-atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_andnot_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_or(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_or(i, v);
-}
-
-static __always_inline int
-atomic_fetch_or(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or(i, v);
-}
-
-static __always_inline int
-atomic_fetch_or_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_or_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_or_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_xor(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic_xor(i, v);
-}
-
-static __always_inline int
-atomic_fetch_xor(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor(i, v);
-}
-
-static __always_inline int
-atomic_fetch_xor_acquire(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_acquire(i, v);
-}
-
-static __always_inline int
-atomic_fetch_xor_release(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_release(i, v);
-}
-
-static __always_inline int
-atomic_fetch_xor_relaxed(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline int
-atomic_xchg(atomic_t *v, int i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg(v, i);
-}
-
-static __always_inline int
-atomic_xchg_acquire(atomic_t *v, int i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_acquire(v, i);
-}
-
-static __always_inline int
-atomic_xchg_release(atomic_t *v, int i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_release(v, i);
-}
-
-static __always_inline int
-atomic_xchg_relaxed(atomic_t *v, int i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_xchg_relaxed(v, i);
-}
-
-static __always_inline int
-atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg(v, old, new);
-}
-
-static __always_inline int
-atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline int
-atomic_cmpxchg_release(atomic_t *v, int old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_release(v, old, new);
-}
-
-static __always_inline int
-atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg(v, old, new);
-}
-
-static __always_inline bool
-atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline bool
-atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_release(v, old, new);
-}
-
-static __always_inline bool
-atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_sub_and_test(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic_dec_and_test(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic_inc_and_test(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic_add_negative(int i, atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_negative(i, v);
-}
-
-static __always_inline int
-atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_add_unless(atomic_t *v, int a, int u)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_inc_not_zero(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic_inc_unless_negative(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic_dec_unless_positive(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_unless_positive(v);
-}
-
-static __always_inline int
-atomic_dec_if_positive(atomic_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic_dec_if_positive(v);
-}
-
-static __always_inline s64
-atomic64_read(const atomic64_t *v)
-{
-	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic64_read(v);
-}
-
-static __always_inline s64
-atomic64_read_acquire(const atomic64_t *v)
-{
-	instrument_atomic_read(v, sizeof(*v));
-	return arch_atomic64_read_acquire(v);
-}
-
-static __always_inline void
-atomic64_set(atomic64_t *v, s64 i)
-{
-	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic64_set(v, i);
-}
-
-static __always_inline void
-atomic64_set_release(atomic64_t *v, s64 i)
-{
-	instrument_atomic_write(v, sizeof(*v));
-	arch_atomic64_set_release(v, i);
-}
-
-static __always_inline void
-atomic64_add(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_add(i, v);
-}
-
-static __always_inline s64
-atomic64_add_return(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return(i, v);
-}
-
-static __always_inline s64
-atomic64_add_return_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_add_return_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_release(i, v);
-}
-
-static __always_inline s64
-atomic64_add_return_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_add(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_add_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic64_sub(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_sub(i, v);
-}
-
-static __always_inline s64
-atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return(i, v);
-}
-
-static __always_inline s64
-atomic64_sub_return_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_sub_return_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_release(i, v);
-}
-
-static __always_inline s64
-atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_sub_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic64_inc(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_inc(v);
-}
-
-static __always_inline s64
-atomic64_inc_return(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return(v);
-}
-
-static __always_inline s64
-atomic64_inc_return_acquire(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_acquire(v);
-}
-
-static __always_inline s64
-atomic64_inc_return_release(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_release(v);
-}
-
-static __always_inline s64
-atomic64_inc_return_relaxed(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline s64
-atomic64_fetch_inc(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc(v);
-}
-
-static __always_inline s64
-atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline s64
-atomic64_fetch_inc_release(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_release(v);
-}
-
-static __always_inline s64
-atomic64_fetch_inc_relaxed(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic64_dec(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_dec(v);
-}
-
-static __always_inline s64
-atomic64_dec_return(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return(v);
-}
-
-static __always_inline s64
-atomic64_dec_return_acquire(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_acquire(v);
-}
-
-static __always_inline s64
-atomic64_dec_return_release(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_release(v);
-}
-
-static __always_inline s64
-atomic64_dec_return_relaxed(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline s64
-atomic64_fetch_dec(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec(v);
-}
-
-static __always_inline s64
-atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline s64
-atomic64_fetch_dec_release(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_release(v);
-}
-
-static __always_inline s64
-atomic64_fetch_dec_relaxed(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic64_and(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_and(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_and_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic64_andnot(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_andnot(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic64_or(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_or(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_or_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic64_xor(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	arch_atomic64_xor(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_xor_release(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline s64
-atomic64_xchg(atomic64_t *v, s64 i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg(v, i);
-}
-
-static __always_inline s64
-atomic64_xchg_acquire(atomic64_t *v, s64 i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline s64
-atomic64_xchg_release(atomic64_t *v, s64 i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_release(v, i);
-}
-
-static __always_inline s64
-atomic64_xchg_relaxed(atomic64_t *v, s64 i)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline s64
-atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline s64
-atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline s64
-atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline s64
-atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg(v, old, new);
-}
-
-static __always_inline bool
-atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline bool
-atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_release(v, old, new);
-}
-
-static __always_inline bool
-atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
-	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic64_sub_and_test(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic64_dec_and_test(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic64_inc_and_test(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic64_add_negative(s64 i, atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_negative(i, v);
-}
-
-static __always_inline s64
-atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic64_inc_not_zero(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic64_inc_unless_negative(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic64_dec_unless_positive(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_unless_positive(v);
-}
-
-static __always_inline s64
-atomic64_dec_if_positive(atomic64_t *v)
-{
-	instrument_atomic_read_write(v, sizeof(*v));
-	return arch_atomic64_dec_if_positive(v);
-}
-
-#define xchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg(__ai_ptr, __VA_ARGS__); \
-})
-
-#define xchg_acquire(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
-})
-
-#define xchg_release(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
-})
-
-#define xchg_relaxed(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg_acquire(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg_release(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg_relaxed(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg64(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg64_acquire(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg64_release(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg64_relaxed(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
-})
-
-#define try_cmpxchg(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-
-#define try_cmpxchg_acquire(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-
-#define try_cmpxchg_release(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-
-#define try_cmpxchg_relaxed(ptr, oldp, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	typeof(oldp) __ai_oldp = (oldp); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
-	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
-})
-
-#define cmpxchg_local(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg64_local(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
-})
-
-#define sync_cmpxchg(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
-	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
-})
-
-#define cmpxchg_double(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
-	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
-})
-
-
-#define cmpxchg_double_local(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
-	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
-})
-
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
deleted file mode 100644
index 073cf40..0000000
--- a/include/asm-generic/atomic-long.h
+++ /dev/null
@@ -1,1014 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-long.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
-
-#include <linux/compiler.h>
-#include <asm/types.h>
-
-#ifdef CONFIG_64BIT
-typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
-#else
-typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
-#endif
-
-#ifdef CONFIG_64BIT
-
-static __always_inline long
-atomic_long_read(const atomic_long_t *v)
-{
-	return atomic64_read(v);
-}
-
-static __always_inline long
-atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return atomic64_read_acquire(v);
-}
-
-static __always_inline void
-atomic_long_set(atomic_long_t *v, long i)
-{
-	atomic64_set(v, i);
-}
-
-static __always_inline void
-atomic_long_set_release(atomic_long_t *v, long i)
-{
-	atomic64_set_release(v, i);
-}
-
-static __always_inline void
-atomic_long_add(long i, atomic_long_t *v)
-{
-	atomic64_add(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return atomic64_add_return(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_sub(long i, atomic_long_t *v)
-{
-	atomic64_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_inc(atomic_long_t *v)
-{
-	atomic64_inc(v);
-}
-
-static __always_inline long
-atomic_long_inc_return(atomic_long_t *v)
-{
-	return atomic64_inc_return(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return atomic64_inc_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return atomic64_inc_return_release(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return atomic64_fetch_inc(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_dec(atomic_long_t *v)
-{
-	atomic64_dec(v);
-}
-
-static __always_inline long
-atomic_long_dec_return(atomic_long_t *v)
-{
-	return atomic64_dec_return(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return atomic64_dec_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return atomic64_dec_return_release(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return atomic64_fetch_dec(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_and(long i, atomic_long_t *v)
-{
-	atomic64_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_andnot(long i, atomic_long_t *v)
-{
-	atomic64_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_or(long i, atomic_long_t *v)
-{
-	atomic64_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_xor(long i, atomic_long_t *v)
-{
-	atomic64_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return atomic64_xchg(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_release(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_release(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return atomic64_add_negative(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return atomic64_dec_unless_positive(v);
-}
-
-static __always_inline long
-atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return atomic64_dec_if_positive(v);
-}
-
-#else /* CONFIG_64BIT */
-
-static __always_inline long
-atomic_long_read(const atomic_long_t *v)
-{
-	return atomic_read(v);
-}
-
-static __always_inline long
-atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return atomic_read_acquire(v);
-}
-
-static __always_inline void
-atomic_long_set(atomic_long_t *v, long i)
-{
-	atomic_set(v, i);
-}
-
-static __always_inline void
-atomic_long_set_release(atomic_long_t *v, long i)
-{
-	atomic_set_release(v, i);
-}
-
-static __always_inline void
-atomic_long_add(long i, atomic_long_t *v)
-{
-	atomic_add(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return atomic_add_return(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic_add_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return atomic_add_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_sub(long i, atomic_long_t *v)
-{
-	atomic_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return atomic_sub_return(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_inc(atomic_long_t *v)
-{
-	atomic_inc(v);
-}
-
-static __always_inline long
-atomic_long_inc_return(atomic_long_t *v)
-{
-	return atomic_inc_return(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return atomic_inc_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return atomic_inc_return_release(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return atomic_inc_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return atomic_fetch_inc(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return atomic_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return atomic_fetch_inc_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return atomic_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_dec(atomic_long_t *v)
-{
-	atomic_dec(v);
-}
-
-static __always_inline long
-atomic_long_dec_return(atomic_long_t *v)
-{
-	return atomic_dec_return(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return atomic_dec_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return atomic_dec_return_release(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return atomic_dec_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return atomic_fetch_dec(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return atomic_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return atomic_fetch_dec_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return atomic_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_and(long i, atomic_long_t *v)
-{
-	atomic_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_andnot(long i, atomic_long_t *v)
-{
-	atomic_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_or(long i, atomic_long_t *v)
-{
-	atomic_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_xor(long i, atomic_long_t *v)
-{
-	atomic_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return atomic_xchg(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return atomic_xchg_acquire(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return atomic_xchg_release(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return atomic_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_acquire(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_release(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_relaxed(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return atomic_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return atomic_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return atomic_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return atomic_add_negative(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return atomic_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return atomic_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return atomic_dec_unless_positive(v);
-}
-
-static __always_inline long
-atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return atomic_dec_if_positive(v);
-}
-
-#endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// a624200981f552b2c6be4f32fe44da8289f30d87
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
deleted file mode 100644
index a3dba31..0000000
--- a/include/linux/atomic-arch-fallback.h
+++ /dev/null
@@ -1,2361 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-fallback.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _LINUX_ATOMIC_FALLBACK_H
-#define _LINUX_ATOMIC_FALLBACK_H
-
-#include <linux/compiler.h>
-
-#ifndef arch_xchg_relaxed
-#define arch_xchg_acquire arch_xchg
-#define arch_xchg_release arch_xchg
-#define arch_xchg_relaxed arch_xchg
-#else /* arch_xchg_relaxed */
-
-#ifndef arch_xchg_acquire
-#define arch_xchg_acquire(...) \
-	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_xchg_release
-#define arch_xchg_release(...) \
-	__atomic_op_release(arch_xchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_xchg
-#define arch_xchg(...) \
-	__atomic_op_fence(arch_xchg, __VA_ARGS__)
-#endif
-
-#endif /* arch_xchg_relaxed */
-
-#ifndef arch_cmpxchg_relaxed
-#define arch_cmpxchg_acquire arch_cmpxchg
-#define arch_cmpxchg_release arch_cmpxchg
-#define arch_cmpxchg_relaxed arch_cmpxchg
-#else /* arch_cmpxchg_relaxed */
-
-#ifndef arch_cmpxchg_acquire
-#define arch_cmpxchg_acquire(...) \
-	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_cmpxchg_release
-#define arch_cmpxchg_release(...) \
-	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_cmpxchg
-#define arch_cmpxchg(...) \
-	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* arch_cmpxchg_relaxed */
-
-#ifndef arch_cmpxchg64_relaxed
-#define arch_cmpxchg64_acquire arch_cmpxchg64
-#define arch_cmpxchg64_release arch_cmpxchg64
-#define arch_cmpxchg64_relaxed arch_cmpxchg64
-#else /* arch_cmpxchg64_relaxed */
-
-#ifndef arch_cmpxchg64_acquire
-#define arch_cmpxchg64_acquire(...) \
-	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef arch_cmpxchg64_release
-#define arch_cmpxchg64_release(...) \
-	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
-#endif
-
-#ifndef arch_cmpxchg64
-#define arch_cmpxchg64(...) \
-	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
-#endif
-
-#endif /* arch_cmpxchg64_relaxed */
-
-#ifndef arch_try_cmpxchg_relaxed
-#ifdef arch_try_cmpxchg
-#define arch_try_cmpxchg_acquire arch_try_cmpxchg
-#define arch_try_cmpxchg_release arch_try_cmpxchg
-#define arch_try_cmpxchg_relaxed arch_try_cmpxchg
-#endif /* arch_try_cmpxchg */
-
-#ifndef arch_try_cmpxchg
-#define arch_try_cmpxchg(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* arch_try_cmpxchg */
-
-#ifndef arch_try_cmpxchg_acquire
-#define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* arch_try_cmpxchg_acquire */
-
-#ifndef arch_try_cmpxchg_release
-#define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* arch_try_cmpxchg_release */
-
-#ifndef arch_try_cmpxchg_relaxed
-#define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
-({ \
-	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
-	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
-	if (unlikely(___r != ___o)) \
-		*___op = ___r; \
-	likely(___r == ___o); \
-})
-#endif /* arch_try_cmpxchg_relaxed */
-
-#else /* arch_try_cmpxchg_relaxed */
-
-#ifndef arch_try_cmpxchg_acquire
-#define arch_try_cmpxchg_acquire(...) \
-	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_try_cmpxchg_release
-#define arch_try_cmpxchg_release(...) \
-	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
-#endif
-
-#ifndef arch_try_cmpxchg
-#define arch_try_cmpxchg(...) \
-	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
-#endif
-
-#endif /* arch_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic_read_acquire
-static __always_inline int
-arch_atomic_read_acquire(const atomic_t *v)
-{
-	return smp_load_acquire(&(v)->counter);
-}
-#define arch_atomic_read_acquire arch_atomic_read_acquire
-#endif
-
-#ifndef arch_atomic_set_release
-static __always_inline void
-arch_atomic_set_release(atomic_t *v, int i)
-{
-	smp_store_release(&(v)->counter, i);
-}
-#define arch_atomic_set_release arch_atomic_set_release
-#endif
-
-#ifndef arch_atomic_add_return_relaxed
-#define arch_atomic_add_return_acquire arch_atomic_add_return
-#define arch_atomic_add_return_release arch_atomic_add_return
-#define arch_atomic_add_return_relaxed arch_atomic_add_return
-#else /* arch_atomic_add_return_relaxed */
-
-#ifndef arch_atomic_add_return_acquire
-static __always_inline int
-arch_atomic_add_return_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_add_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
-#endif
-
-#ifndef arch_atomic_add_return_release
-static __always_inline int
-arch_atomic_add_return_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_add_return_relaxed(i, v);
-}
-#define arch_atomic_add_return_release arch_atomic_add_return_release
-#endif
-
-#ifndef arch_atomic_add_return
-static __always_inline int
-arch_atomic_add_return(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_add_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_add_return arch_atomic_add_return
-#endif
-
-#endif /* arch_atomic_add_return_relaxed */
-
-#ifndef arch_atomic_fetch_add_relaxed
-#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
-#define arch_atomic_fetch_add_release arch_atomic_fetch_add
-#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
-#else /* arch_atomic_fetch_add_relaxed */
-
-#ifndef arch_atomic_fetch_add_acquire
-static __always_inline int
-arch_atomic_fetch_add_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_add_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
-#endif
-
-#ifndef arch_atomic_fetch_add_release
-static __always_inline int
-arch_atomic_fetch_add_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_add_relaxed(i, v);
-}
-#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
-#endif
-
-#ifndef arch_atomic_fetch_add
-static __always_inline int
-arch_atomic_fetch_add(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_add_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_add arch_atomic_fetch_add
-#endif
-
-#endif /* arch_atomic_fetch_add_relaxed */
-
-#ifndef arch_atomic_sub_return_relaxed
-#define arch_atomic_sub_return_acquire arch_atomic_sub_return
-#define arch_atomic_sub_return_release arch_atomic_sub_return
-#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
-#else /* arch_atomic_sub_return_relaxed */
-
-#ifndef arch_atomic_sub_return_acquire
-static __always_inline int
-arch_atomic_sub_return_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_sub_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
-#endif
-
-#ifndef arch_atomic_sub_return_release
-static __always_inline int
-arch_atomic_sub_return_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_sub_return_relaxed(i, v);
-}
-#define arch_atomic_sub_return_release arch_atomic_sub_return_release
-#endif
-
-#ifndef arch_atomic_sub_return
-static __always_inline int
-arch_atomic_sub_return(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_sub_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_sub_return arch_atomic_sub_return
-#endif
-
-#endif /* arch_atomic_sub_return_relaxed */
-
-#ifndef arch_atomic_fetch_sub_relaxed
-#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
-#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
-#else /* arch_atomic_fetch_sub_relaxed */
-
-#ifndef arch_atomic_fetch_sub_acquire
-static __always_inline int
-arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_sub_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
-#endif
-
-#ifndef arch_atomic_fetch_sub_release
-static __always_inline int
-arch_atomic_fetch_sub_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_sub_relaxed(i, v);
-}
-#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
-#endif
-
-#ifndef arch_atomic_fetch_sub
-static __always_inline int
-arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
-#endif
-
-#endif /* arch_atomic_fetch_sub_relaxed */
-
-#ifndef arch_atomic_inc
-static __always_inline void
-arch_atomic_inc(atomic_t *v)
-{
-	arch_atomic_add(1, v);
-}
-#define arch_atomic_inc arch_atomic_inc
-#endif
-
-#ifndef arch_atomic_inc_return_relaxed
-#ifdef arch_atomic_inc_return
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return
-#define arch_atomic_inc_return_release arch_atomic_inc_return
-#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
-#endif /* arch_atomic_inc_return */
-
-#ifndef arch_atomic_inc_return
-static __always_inline int
-arch_atomic_inc_return(atomic_t *v)
-{
-	return arch_atomic_add_return(1, v);
-}
-#define arch_atomic_inc_return arch_atomic_inc_return
-#endif
-
-#ifndef arch_atomic_inc_return_acquire
-static __always_inline int
-arch_atomic_inc_return_acquire(atomic_t *v)
-{
-	return arch_atomic_add_return_acquire(1, v);
-}
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
-#endif
-
-#ifndef arch_atomic_inc_return_release
-static __always_inline int
-arch_atomic_inc_return_release(atomic_t *v)
-{
-	return arch_atomic_add_return_release(1, v);
-}
-#define arch_atomic_inc_return_release arch_atomic_inc_return_release
-#endif
-
-#ifndef arch_atomic_inc_return_relaxed
-static __always_inline int
-arch_atomic_inc_return_relaxed(atomic_t *v)
-{
-	return arch_atomic_add_return_relaxed(1, v);
-}
-#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
-#endif
-
-#else /* arch_atomic_inc_return_relaxed */
-
-#ifndef arch_atomic_inc_return_acquire
-static __always_inline int
-arch_atomic_inc_return_acquire(atomic_t *v)
-{
-	int ret = arch_atomic_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
-#endif
-
-#ifndef arch_atomic_inc_return_release
-static __always_inline int
-arch_atomic_inc_return_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_inc_return_relaxed(v);
-}
-#define arch_atomic_inc_return_release arch_atomic_inc_return_release
-#endif
-
-#ifndef arch_atomic_inc_return
-static __always_inline int
-arch_atomic_inc_return(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_inc_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_inc_return arch_atomic_inc_return
-#endif
-
-#endif /* arch_atomic_inc_return_relaxed */
-
-#ifndef arch_atomic_fetch_inc_relaxed
-#ifdef arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
-#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
-#endif /* arch_atomic_fetch_inc */
-
-#ifndef arch_atomic_fetch_inc
-static __always_inline int
-arch_atomic_fetch_inc(atomic_t *v)
-{
-	return arch_atomic_fetch_add(1, v);
-}
-#define arch_atomic_fetch_inc arch_atomic_fetch_inc
-#endif
-
-#ifndef arch_atomic_fetch_inc_acquire
-static __always_inline int
-arch_atomic_fetch_inc_acquire(atomic_t *v)
-{
-	return arch_atomic_fetch_add_acquire(1, v);
-}
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
-#endif
-
-#ifndef arch_atomic_fetch_inc_release
-static __always_inline int
-arch_atomic_fetch_inc_release(atomic_t *v)
-{
-	return arch_atomic_fetch_add_release(1, v);
-}
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
-#endif
-
-#ifndef arch_atomic_fetch_inc_relaxed
-static __always_inline int
-arch_atomic_fetch_inc_relaxed(atomic_t *v)
-{
-	return arch_atomic_fetch_add_relaxed(1, v);
-}
-#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
-#endif
-
-#else /* arch_atomic_fetch_inc_relaxed */
-
-#ifndef arch_atomic_fetch_inc_acquire
-static __always_inline int
-arch_atomic_fetch_inc_acquire(atomic_t *v)
-{
-	int ret = arch_atomic_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
-#endif
-
-#ifndef arch_atomic_fetch_inc_release
-static __always_inline int
-arch_atomic_fetch_inc_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_inc_relaxed(v);
-}
-#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
-#endif
-
-#ifndef arch_atomic_fetch_inc
-static __always_inline int
-arch_atomic_fetch_inc(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_inc_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_inc arch_atomic_fetch_inc
-#endif
-
-#endif /* arch_atomic_fetch_inc_relaxed */
-
-#ifndef arch_atomic_dec
-static __always_inline void
-arch_atomic_dec(atomic_t *v)
-{
-	arch_atomic_sub(1, v);
-}
-#define arch_atomic_dec arch_atomic_dec
-#endif
-
-#ifndef arch_atomic_dec_return_relaxed
-#ifdef arch_atomic_dec_return
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return
-#define arch_atomic_dec_return_release arch_atomic_dec_return
-#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
-#endif /* arch_atomic_dec_return */
-
-#ifndef arch_atomic_dec_return
-static __always_inline int
-arch_atomic_dec_return(atomic_t *v)
-{
-	return arch_atomic_sub_return(1, v);
-}
-#define arch_atomic_dec_return arch_atomic_dec_return
-#endif
-
-#ifndef arch_atomic_dec_return_acquire
-static __always_inline int
-arch_atomic_dec_return_acquire(atomic_t *v)
-{
-	return arch_atomic_sub_return_acquire(1, v);
-}
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
-#endif
-
-#ifndef arch_atomic_dec_return_release
-static __always_inline int
-arch_atomic_dec_return_release(atomic_t *v)
-{
-	return arch_atomic_sub_return_release(1, v);
-}
-#define arch_atomic_dec_return_release arch_atomic_dec_return_release
-#endif
-
-#ifndef arch_atomic_dec_return_relaxed
-static __always_inline int
-arch_atomic_dec_return_relaxed(atomic_t *v)
-{
-	return arch_atomic_sub_return_relaxed(1, v);
-}
-#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
-#endif
-
-#else /* arch_atomic_dec_return_relaxed */
-
-#ifndef arch_atomic_dec_return_acquire
-static __always_inline int
-arch_atomic_dec_return_acquire(atomic_t *v)
-{
-	int ret = arch_atomic_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
-#endif
-
-#ifndef arch_atomic_dec_return_release
-static __always_inline int
-arch_atomic_dec_return_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_dec_return_relaxed(v);
-}
-#define arch_atomic_dec_return_release arch_atomic_dec_return_release
-#endif
-
-#ifndef arch_atomic_dec_return
-static __always_inline int
-arch_atomic_dec_return(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_dec_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_dec_return arch_atomic_dec_return
-#endif
-
-#endif /* arch_atomic_dec_return_relaxed */
-
-#ifndef arch_atomic_fetch_dec_relaxed
-#ifdef arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
-#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
-#endif /* arch_atomic_fetch_dec */
-
-#ifndef arch_atomic_fetch_dec
-static __always_inline int
-arch_atomic_fetch_dec(atomic_t *v)
-{
-	return arch_atomic_fetch_sub(1, v);
-}
-#define arch_atomic_fetch_dec arch_atomic_fetch_dec
-#endif
-
-#ifndef arch_atomic_fetch_dec_acquire
-static __always_inline int
-arch_atomic_fetch_dec_acquire(atomic_t *v)
-{
-	return arch_atomic_fetch_sub_acquire(1, v);
-}
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic_fetch_dec_release
-static __always_inline int
-arch_atomic_fetch_dec_release(atomic_t *v)
-{
-	return arch_atomic_fetch_sub_release(1, v);
-}
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
-#endif
-
-#ifndef arch_atomic_fetch_dec_relaxed
-static __always_inline int
-arch_atomic_fetch_dec_relaxed(atomic_t *v)
-{
-	return arch_atomic_fetch_sub_relaxed(1, v);
-}
-#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
-#endif
-
-#else /* arch_atomic_fetch_dec_relaxed */
-
-#ifndef arch_atomic_fetch_dec_acquire
-static __always_inline int
-arch_atomic_fetch_dec_acquire(atomic_t *v)
-{
-	int ret = arch_atomic_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic_fetch_dec_release
-static __always_inline int
-arch_atomic_fetch_dec_release(atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_dec_relaxed(v);
-}
-#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
-#endif
-
-#ifndef arch_atomic_fetch_dec
-static __always_inline int
-arch_atomic_fetch_dec(atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_dec_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_dec arch_atomic_fetch_dec
-#endif
-
-#endif /* arch_atomic_fetch_dec_relaxed */
-
-#ifndef arch_atomic_fetch_and_relaxed
-#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
-#define arch_atomic_fetch_and_release arch_atomic_fetch_and
-#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
-#else /* arch_atomic_fetch_and_relaxed */
-
-#ifndef arch_atomic_fetch_and_acquire
-static __always_inline int
-arch_atomic_fetch_and_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_and_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
-#endif
-
-#ifndef arch_atomic_fetch_and_release
-static __always_inline int
-arch_atomic_fetch_and_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_and_relaxed(i, v);
-}
-#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
-#endif
-
-#ifndef arch_atomic_fetch_and
-static __always_inline int
-arch_atomic_fetch_and(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_and_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_and arch_atomic_fetch_and
-#endif
-
-#endif /* arch_atomic_fetch_and_relaxed */
-
-#ifndef arch_atomic_andnot
-static __always_inline void
-arch_atomic_andnot(int i, atomic_t *v)
-{
-	arch_atomic_and(~i, v);
-}
-#define arch_atomic_andnot arch_atomic_andnot
-#endif
-
-#ifndef arch_atomic_fetch_andnot_relaxed
-#ifdef arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
-#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
-#endif /* arch_atomic_fetch_andnot */
-
-#ifndef arch_atomic_fetch_andnot
-static __always_inline int
-arch_atomic_fetch_andnot(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and(~i, v);
-}
-#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
-#endif
-
-#ifndef arch_atomic_fetch_andnot_acquire
-static __always_inline int
-arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_acquire(~i, v);
-}
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
-#endif
-
-#ifndef arch_atomic_fetch_andnot_release
-static __always_inline int
-arch_atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_release(~i, v);
-}
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic_fetch_andnot_relaxed
-static __always_inline int
-arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
-{
-	return arch_atomic_fetch_and_relaxed(~i, v);
-}
-#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
-#endif
-
-#else /* arch_atomic_fetch_andnot_relaxed */
-
-#ifndef arch_atomic_fetch_andnot_acquire
-static __always_inline int
-arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
-#endif
-
-#ifndef arch_atomic_fetch_andnot_release
-static __always_inline int
-arch_atomic_fetch_andnot_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_andnot_relaxed(i, v);
-}
-#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic_fetch_andnot
-static __always_inline int
-arch_atomic_fetch_andnot(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_andnot_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
-#endif
-
-#endif /* arch_atomic_fetch_andnot_relaxed */
-
-#ifndef arch_atomic_fetch_or_relaxed
-#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
-#define arch_atomic_fetch_or_release arch_atomic_fetch_or
-#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
-#else /* arch_atomic_fetch_or_relaxed */
-
-#ifndef arch_atomic_fetch_or_acquire
-static __always_inline int
-arch_atomic_fetch_or_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_or_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
-#endif
-
-#ifndef arch_atomic_fetch_or_release
-static __always_inline int
-arch_atomic_fetch_or_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_or_relaxed(i, v);
-}
-#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
-#endif
-
-#ifndef arch_atomic_fetch_or
-static __always_inline int
-arch_atomic_fetch_or(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_or_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_or arch_atomic_fetch_or
-#endif
-
-#endif /* arch_atomic_fetch_or_relaxed */
-
-#ifndef arch_atomic_fetch_xor_relaxed
-#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
-#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
-#else /* arch_atomic_fetch_xor_relaxed */
-
-#ifndef arch_atomic_fetch_xor_acquire
-static __always_inline int
-arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
-{
-	int ret = arch_atomic_fetch_xor_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
-#endif
-
-#ifndef arch_atomic_fetch_xor_release
-static __always_inline int
-arch_atomic_fetch_xor_release(int i, atomic_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic_fetch_xor_relaxed(i, v);
-}
-#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
-#endif
-
-#ifndef arch_atomic_fetch_xor
-static __always_inline int
-arch_atomic_fetch_xor(int i, atomic_t *v)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_fetch_xor_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_fetch_xor arch_atomic_fetch_xor
-#endif
-
-#endif /* arch_atomic_fetch_xor_relaxed */
-
-#ifndef arch_atomic_xchg_relaxed
-#define arch_atomic_xchg_acquire arch_atomic_xchg
-#define arch_atomic_xchg_release arch_atomic_xchg
-#define arch_atomic_xchg_relaxed arch_atomic_xchg
-#else /* arch_atomic_xchg_relaxed */
-
-#ifndef arch_atomic_xchg_acquire
-static __always_inline int
-arch_atomic_xchg_acquire(atomic_t *v, int i)
-{
-	int ret = arch_atomic_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
-#endif
-
-#ifndef arch_atomic_xchg_release
-static __always_inline int
-arch_atomic_xchg_release(atomic_t *v, int i)
-{
-	__atomic_release_fence();
-	return arch_atomic_xchg_relaxed(v, i);
-}
-#define arch_atomic_xchg_release arch_atomic_xchg_release
-#endif
-
-#ifndef arch_atomic_xchg
-static __always_inline int
-arch_atomic_xchg(atomic_t *v, int i)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_xchg_relaxed(v, i);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_xchg arch_atomic_xchg
-#endif
-
-#endif /* arch_atomic_xchg_relaxed */
-
-#ifndef arch_atomic_cmpxchg_relaxed
-#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
-#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
-#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
-#else /* arch_atomic_cmpxchg_relaxed */
-
-#ifndef arch_atomic_cmpxchg_acquire
-static __always_inline int
-arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
-{
-	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic_cmpxchg_release
-static __always_inline int
-arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
-{
-	__atomic_release_fence();
-	return arch_atomic_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
-#endif
-
-#ifndef arch_atomic_cmpxchg
-static __always_inline int
-arch_atomic_cmpxchg(atomic_t *v, int old, int new)
-{
-	int ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_cmpxchg arch_atomic_cmpxchg
-#endif
-
-#endif /* arch_atomic_cmpxchg_relaxed */
-
-#ifndef arch_atomic_try_cmpxchg_relaxed
-#ifdef arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
-#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
-#endif /* arch_atomic_try_cmpxchg */
-
-#ifndef arch_atomic_try_cmpxchg
-static __always_inline bool
-arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = arch_atomic_cmpxchg(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
-#endif
-
-#ifndef arch_atomic_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = arch_atomic_cmpxchg_acquire(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic_try_cmpxchg_release
-static __always_inline bool
-arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = arch_atomic_cmpxchg_release(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic_try_cmpxchg_relaxed
-static __always_inline bool
-arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
-{
-	int r, o = *old;
-	r = arch_atomic_cmpxchg_relaxed(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
-#endif
-
-#else /* arch_atomic_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
-{
-	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic_try_cmpxchg_release
-static __always_inline bool
-arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
-{
-	__atomic_release_fence();
-	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic_try_cmpxchg
-static __always_inline bool
-arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
-#endif
-
-#endif /* arch_atomic_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic_sub_and_test
-/**
- * arch_atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-arch_atomic_sub_and_test(int i, atomic_t *v)
-{
-	return arch_atomic_sub_return(i, v) == 0;
-}
-#define arch_atomic_sub_and_test arch_atomic_sub_and_test
-#endif
-
-#ifndef arch_atomic_dec_and_test
-/**
- * arch_atomic_dec_and_test - decrement and test
- * @v: pointer of type atomic_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static __always_inline bool
-arch_atomic_dec_and_test(atomic_t *v)
-{
-	return arch_atomic_dec_return(v) == 0;
-}
-#define arch_atomic_dec_and_test arch_atomic_dec_and_test
-#endif
-
-#ifndef arch_atomic_inc_and_test
-/**
- * arch_atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-arch_atomic_inc_and_test(atomic_t *v)
-{
-	return arch_atomic_inc_return(v) == 0;
-}
-#define arch_atomic_inc_and_test arch_atomic_inc_and_test
-#endif
-
-#ifndef arch_atomic_add_negative
-/**
- * arch_atomic_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static __always_inline bool
-arch_atomic_add_negative(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(i, v) < 0;
-}
-#define arch_atomic_add_negative arch_atomic_add_negative
-#endif
-
-#ifndef arch_atomic_fetch_add_unless
-/**
- * arch_atomic_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
-static __always_inline int
-arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
-{
-	int c = arch_atomic_read(v);
-
-	do {
-		if (unlikely(c == u))
-			break;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
-
-	return c;
-}
-#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
-#endif
-
-#ifndef arch_atomic_add_unless
-/**
- * arch_atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
-static __always_inline bool
-arch_atomic_add_unless(atomic_t *v, int a, int u)
-{
-	return arch_atomic_fetch_add_unless(v, a, u) != u;
-}
-#define arch_atomic_add_unless arch_atomic_add_unless
-#endif
-
-#ifndef arch_atomic_inc_not_zero
-/**
- * arch_atomic_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
-static __always_inline bool
-arch_atomic_inc_not_zero(atomic_t *v)
-{
-	return arch_atomic_add_unless(v, 1, 0);
-}
-#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
-#endif
-
-#ifndef arch_atomic_inc_unless_negative
-static __always_inline bool
-arch_atomic_inc_unless_negative(atomic_t *v)
-{
-	int c = arch_atomic_read(v);
-
-	do {
-		if (unlikely(c < 0))
-			return false;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
-
-	return true;
-}
-#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
-#endif
-
-#ifndef arch_atomic_dec_unless_positive
-static __always_inline bool
-arch_atomic_dec_unless_positive(atomic_t *v)
-{
-	int c = arch_atomic_read(v);
-
-	do {
-		if (unlikely(c > 0))
-			return false;
-	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
-
-	return true;
-}
-#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
-#endif
-
-#ifndef arch_atomic_dec_if_positive
-static __always_inline int
-arch_atomic_dec_if_positive(atomic_t *v)
-{
-	int dec, c = arch_atomic_read(v);
-
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
-
-	return dec;
-}
-#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
-#endif
-
-#ifdef CONFIG_GENERIC_ATOMIC64
-#include <asm-generic/atomic64.h>
-#endif
-
-#ifndef arch_atomic64_read_acquire
-static __always_inline s64
-arch_atomic64_read_acquire(const atomic64_t *v)
-{
-	return smp_load_acquire(&(v)->counter);
-}
-#define arch_atomic64_read_acquire arch_atomic64_read_acquire
-#endif
-
-#ifndef arch_atomic64_set_release
-static __always_inline void
-arch_atomic64_set_release(atomic64_t *v, s64 i)
-{
-	smp_store_release(&(v)->counter, i);
-}
-#define arch_atomic64_set_release arch_atomic64_set_release
-#endif
-
-#ifndef arch_atomic64_add_return_relaxed
-#define arch_atomic64_add_return_acquire arch_atomic64_add_return
-#define arch_atomic64_add_return_release arch_atomic64_add_return
-#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
-#else /* arch_atomic64_add_return_relaxed */
-
-#ifndef arch_atomic64_add_return_acquire
-static __always_inline s64
-arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_add_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
-#endif
-
-#ifndef arch_atomic64_add_return_release
-static __always_inline s64
-arch_atomic64_add_return_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_add_return_relaxed(i, v);
-}
-#define arch_atomic64_add_return_release arch_atomic64_add_return_release
-#endif
-
-#ifndef arch_atomic64_add_return
-static __always_inline s64
-arch_atomic64_add_return(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_add_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_add_return arch_atomic64_add_return
-#endif
-
-#endif /* arch_atomic64_add_return_relaxed */
-
-#ifndef arch_atomic64_fetch_add_relaxed
-#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
-#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
-#else /* arch_atomic64_fetch_add_relaxed */
-
-#ifndef arch_atomic64_fetch_add_acquire
-static __always_inline s64
-arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_add_release
-static __always_inline s64
-arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_add_relaxed(i, v);
-}
-#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
-#endif
-
-#ifndef arch_atomic64_fetch_add
-static __always_inline s64
-arch_atomic64_fetch_add(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_add_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_add arch_atomic64_fetch_add
-#endif
-
-#endif /* arch_atomic64_fetch_add_relaxed */
-
-#ifndef arch_atomic64_sub_return_relaxed
-#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
-#define arch_atomic64_sub_return_release arch_atomic64_sub_return
-#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
-#else /* arch_atomic64_sub_return_relaxed */
-
-#ifndef arch_atomic64_sub_return_acquire
-static __always_inline s64
-arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
-#endif
-
-#ifndef arch_atomic64_sub_return_release
-static __always_inline s64
-arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_sub_return_relaxed(i, v);
-}
-#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
-#endif
-
-#ifndef arch_atomic64_sub_return
-static __always_inline s64
-arch_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_sub_return_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_sub_return arch_atomic64_sub_return
-#endif
-
-#endif /* arch_atomic64_sub_return_relaxed */
-
-#ifndef arch_atomic64_fetch_sub_relaxed
-#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
-#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
-#else /* arch_atomic64_fetch_sub_relaxed */
-
-#ifndef arch_atomic64_fetch_sub_acquire
-static __always_inline s64
-arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_sub_release
-static __always_inline s64
-arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_sub_relaxed(i, v);
-}
-#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
-#endif
-
-#ifndef arch_atomic64_fetch_sub
-static __always_inline s64
-arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_sub_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
-#endif
-
-#endif /* arch_atomic64_fetch_sub_relaxed */
-
-#ifndef arch_atomic64_inc
-static __always_inline void
-arch_atomic64_inc(atomic64_t *v)
-{
-	arch_atomic64_add(1, v);
-}
-#define arch_atomic64_inc arch_atomic64_inc
-#endif
-
-#ifndef arch_atomic64_inc_return_relaxed
-#ifdef arch_atomic64_inc_return
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return
-#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
-#endif /* arch_atomic64_inc_return */
-
-#ifndef arch_atomic64_inc_return
-static __always_inline s64
-arch_atomic64_inc_return(atomic64_t *v)
-{
-	return arch_atomic64_add_return(1, v);
-}
-#define arch_atomic64_inc_return arch_atomic64_inc_return
-#endif
-
-#ifndef arch_atomic64_inc_return_acquire
-static __always_inline s64
-arch_atomic64_inc_return_acquire(atomic64_t *v)
-{
-	return arch_atomic64_add_return_acquire(1, v);
-}
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
-#endif
-
-#ifndef arch_atomic64_inc_return_release
-static __always_inline s64
-arch_atomic64_inc_return_release(atomic64_t *v)
-{
-	return arch_atomic64_add_return_release(1, v);
-}
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
-#endif
-
-#ifndef arch_atomic64_inc_return_relaxed
-static __always_inline s64
-arch_atomic64_inc_return_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_add_return_relaxed(1, v);
-}
-#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
-#endif
-
-#else /* arch_atomic64_inc_return_relaxed */
-
-#ifndef arch_atomic64_inc_return_acquire
-static __always_inline s64
-arch_atomic64_inc_return_acquire(atomic64_t *v)
-{
-	s64 ret = arch_atomic64_inc_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
-#endif
-
-#ifndef arch_atomic64_inc_return_release
-static __always_inline s64
-arch_atomic64_inc_return_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_inc_return_relaxed(v);
-}
-#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
-#endif
-
-#ifndef arch_atomic64_inc_return
-static __always_inline s64
-arch_atomic64_inc_return(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_inc_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_inc_return arch_atomic64_inc_return
-#endif
-
-#endif /* arch_atomic64_inc_return_relaxed */
-
-#ifndef arch_atomic64_fetch_inc_relaxed
-#ifdef arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
-#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
-#endif /* arch_atomic64_fetch_inc */
-
-#ifndef arch_atomic64_fetch_inc
-static __always_inline s64
-arch_atomic64_fetch_inc(atomic64_t *v)
-{
-	return arch_atomic64_fetch_add(1, v);
-}
-#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
-#endif
-
-#ifndef arch_atomic64_fetch_inc_acquire
-static __always_inline s64
-arch_atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_acquire(1, v);
-}
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_inc_release
-static __always_inline s64
-arch_atomic64_fetch_inc_release(atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_release(1, v);
-}
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
-#endif
-
-#ifndef arch_atomic64_fetch_inc_relaxed
-static __always_inline s64
-arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_fetch_add_relaxed(1, v);
-}
-#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
-#endif
-
-#else /* arch_atomic64_fetch_inc_relaxed */
-
-#ifndef arch_atomic64_fetch_inc_acquire
-static __always_inline s64
-arch_atomic64_fetch_inc_acquire(atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_inc_release
-static __always_inline s64
-arch_atomic64_fetch_inc_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_inc_relaxed(v);
-}
-#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
-#endif
-
-#ifndef arch_atomic64_fetch_inc
-static __always_inline s64
-arch_atomic64_fetch_inc(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_inc_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
-#endif
-
-#endif /* arch_atomic64_fetch_inc_relaxed */
-
-#ifndef arch_atomic64_dec
-static __always_inline void
-arch_atomic64_dec(atomic64_t *v)
-{
-	arch_atomic64_sub(1, v);
-}
-#define arch_atomic64_dec arch_atomic64_dec
-#endif
-
-#ifndef arch_atomic64_dec_return_relaxed
-#ifdef arch_atomic64_dec_return
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return
-#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
-#endif /* arch_atomic64_dec_return */
-
-#ifndef arch_atomic64_dec_return
-static __always_inline s64
-arch_atomic64_dec_return(atomic64_t *v)
-{
-	return arch_atomic64_sub_return(1, v);
-}
-#define arch_atomic64_dec_return arch_atomic64_dec_return
-#endif
-
-#ifndef arch_atomic64_dec_return_acquire
-static __always_inline s64
-arch_atomic64_dec_return_acquire(atomic64_t *v)
-{
-	return arch_atomic64_sub_return_acquire(1, v);
-}
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
-#endif
-
-#ifndef arch_atomic64_dec_return_release
-static __always_inline s64
-arch_atomic64_dec_return_release(atomic64_t *v)
-{
-	return arch_atomic64_sub_return_release(1, v);
-}
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
-#endif
-
-#ifndef arch_atomic64_dec_return_relaxed
-static __always_inline s64
-arch_atomic64_dec_return_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_sub_return_relaxed(1, v);
-}
-#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
-#endif
-
-#else /* arch_atomic64_dec_return_relaxed */
-
-#ifndef arch_atomic64_dec_return_acquire
-static __always_inline s64
-arch_atomic64_dec_return_acquire(atomic64_t *v)
-{
-	s64 ret = arch_atomic64_dec_return_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
-#endif
-
-#ifndef arch_atomic64_dec_return_release
-static __always_inline s64
-arch_atomic64_dec_return_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_dec_return_relaxed(v);
-}
-#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
-#endif
-
-#ifndef arch_atomic64_dec_return
-static __always_inline s64
-arch_atomic64_dec_return(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_dec_return_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_dec_return arch_atomic64_dec_return
-#endif
-
-#endif /* arch_atomic64_dec_return_relaxed */
-
-#ifndef arch_atomic64_fetch_dec_relaxed
-#ifdef arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
-#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
-#endif /* arch_atomic64_fetch_dec */
-
-#ifndef arch_atomic64_fetch_dec
-static __always_inline s64
-arch_atomic64_fetch_dec(atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub(1, v);
-}
-#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
-#endif
-
-#ifndef arch_atomic64_fetch_dec_acquire
-static __always_inline s64
-arch_atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_acquire(1, v);
-}
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_dec_release
-static __always_inline s64
-arch_atomic64_fetch_dec_release(atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_release(1, v);
-}
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
-#endif
-
-#ifndef arch_atomic64_fetch_dec_relaxed
-static __always_inline s64
-arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
-{
-	return arch_atomic64_fetch_sub_relaxed(1, v);
-}
-#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
-#endif
-
-#else /* arch_atomic64_fetch_dec_relaxed */
-
-#ifndef arch_atomic64_fetch_dec_acquire
-static __always_inline s64
-arch_atomic64_fetch_dec_acquire(atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_dec_release
-static __always_inline s64
-arch_atomic64_fetch_dec_release(atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_dec_relaxed(v);
-}
-#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
-#endif
-
-#ifndef arch_atomic64_fetch_dec
-static __always_inline s64
-arch_atomic64_fetch_dec(atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_dec_relaxed(v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
-#endif
-
-#endif /* arch_atomic64_fetch_dec_relaxed */
-
-#ifndef arch_atomic64_fetch_and_relaxed
-#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
-#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
-#else /* arch_atomic64_fetch_and_relaxed */
-
-#ifndef arch_atomic64_fetch_and_acquire
-static __always_inline s64
-arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_and_release
-static __always_inline s64
-arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_and_relaxed(i, v);
-}
-#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
-#endif
-
-#ifndef arch_atomic64_fetch_and
-static __always_inline s64
-arch_atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_and_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_and arch_atomic64_fetch_and
-#endif
-
-#endif /* arch_atomic64_fetch_and_relaxed */
-
-#ifndef arch_atomic64_andnot
-static __always_inline void
-arch_atomic64_andnot(s64 i, atomic64_t *v)
-{
-	arch_atomic64_and(~i, v);
-}
-#define arch_atomic64_andnot arch_atomic64_andnot
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_relaxed
-#ifdef arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
-#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
-#endif /* arch_atomic64_fetch_andnot */
-
-#ifndef arch_atomic64_fetch_andnot
-static __always_inline s64
-arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and(~i, v);
-}
-#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_acquire
-static __always_inline s64
-arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_acquire(~i, v);
-}
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_release
-static __always_inline s64
-arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_release(~i, v);
-}
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_relaxed
-static __always_inline s64
-arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_fetch_and_relaxed(~i, v);
-}
-#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
-#endif
-
-#else /* arch_atomic64_fetch_andnot_relaxed */
-
-#ifndef arch_atomic64_fetch_andnot_acquire
-static __always_inline s64
-arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_andnot_release
-static __always_inline s64
-arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_andnot_relaxed(i, v);
-}
-#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
-#endif
-
-#ifndef arch_atomic64_fetch_andnot
-static __always_inline s64
-arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
-#endif
-
-#endif /* arch_atomic64_fetch_andnot_relaxed */
-
-#ifndef arch_atomic64_fetch_or_relaxed
-#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
-#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
-#else /* arch_atomic64_fetch_or_relaxed */
-
-#ifndef arch_atomic64_fetch_or_acquire
-static __always_inline s64
-arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_or_release
-static __always_inline s64
-arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_or_relaxed(i, v);
-}
-#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
-#endif
-
-#ifndef arch_atomic64_fetch_or
-static __always_inline s64
-arch_atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_or_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_or arch_atomic64_fetch_or
-#endif
-
-#endif /* arch_atomic64_fetch_or_relaxed */
-
-#ifndef arch_atomic64_fetch_xor_relaxed
-#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
-#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
-#else /* arch_atomic64_fetch_xor_relaxed */
-
-#ifndef arch_atomic64_fetch_xor_acquire
-static __always_inline s64
-arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
-{
-	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
-#endif
-
-#ifndef arch_atomic64_fetch_xor_release
-static __always_inline s64
-arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
-{
-	__atomic_release_fence();
-	return arch_atomic64_fetch_xor_relaxed(i, v);
-}
-#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
-#endif
-
-#ifndef arch_atomic64_fetch_xor
-static __always_inline s64
-arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_fetch_xor_relaxed(i, v);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
-#endif
-
-#endif /* arch_atomic64_fetch_xor_relaxed */
-
-#ifndef arch_atomic64_xchg_relaxed
-#define arch_atomic64_xchg_acquire arch_atomic64_xchg
-#define arch_atomic64_xchg_release arch_atomic64_xchg
-#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
-#else /* arch_atomic64_xchg_relaxed */
-
-#ifndef arch_atomic64_xchg_acquire
-static __always_inline s64
-arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
-{
-	s64 ret = arch_atomic64_xchg_relaxed(v, i);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
-#endif
-
-#ifndef arch_atomic64_xchg_release
-static __always_inline s64
-arch_atomic64_xchg_release(atomic64_t *v, s64 i)
-{
-	__atomic_release_fence();
-	return arch_atomic64_xchg_relaxed(v, i);
-}
-#define arch_atomic64_xchg_release arch_atomic64_xchg_release
-#endif
-
-#ifndef arch_atomic64_xchg
-static __always_inline s64
-arch_atomic64_xchg(atomic64_t *v, s64 i)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_xchg_relaxed(v, i);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_xchg arch_atomic64_xchg
-#endif
-
-#endif /* arch_atomic64_xchg_relaxed */
-
-#ifndef arch_atomic64_cmpxchg_relaxed
-#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
-#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
-#else /* arch_atomic64_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_cmpxchg_acquire
-static __always_inline s64
-arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
-{
-	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic64_cmpxchg_release
-static __always_inline s64
-arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
-{
-	__atomic_release_fence();
-	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
-#endif
-
-#ifndef arch_atomic64_cmpxchg
-static __always_inline s64
-arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
-{
-	s64 ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
-#endif
-
-#endif /* arch_atomic64_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_try_cmpxchg_relaxed
-#ifdef arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
-#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
-#endif /* arch_atomic64_try_cmpxchg */
-
-#ifndef arch_atomic64_try_cmpxchg
-static __always_inline bool
-arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_acquire(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg_release
-static __always_inline bool
-arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_release(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg_relaxed
-static __always_inline bool
-arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
-{
-	s64 r, o = *old;
-	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
-	if (unlikely(r != o))
-		*old = r;
-	return likely(r == o);
-}
-#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
-#endif
-
-#else /* arch_atomic64_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_try_cmpxchg_acquire
-static __always_inline bool
-arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_acquire_fence();
-	return ret;
-}
-#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg_release
-static __always_inline bool
-arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
-{
-	__atomic_release_fence();
-	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-}
-#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
-#endif
-
-#ifndef arch_atomic64_try_cmpxchg
-static __always_inline bool
-arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
-{
-	bool ret;
-	__atomic_pre_full_fence();
-	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-	__atomic_post_full_fence();
-	return ret;
-}
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
-#endif
-
-#endif /* arch_atomic64_try_cmpxchg_relaxed */
-
-#ifndef arch_atomic64_sub_and_test
-/**
- * arch_atomic64_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
- * @v: pointer of type atomic64_t
- *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_sub_return(i, v) == 0;
-}
-#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
-#endif
-
-#ifndef arch_atomic64_dec_and_test
-/**
- * arch_atomic64_dec_and_test - decrement and test
- * @v: pointer of type atomic64_t
- *
- * Atomically decrements @v by 1 and
- * returns true if the result is 0, or false for all other
- * cases.
- */
-static __always_inline bool
-arch_atomic64_dec_and_test(atomic64_t *v)
-{
-	return arch_atomic64_dec_return(v) == 0;
-}
-#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
-#endif
-
-#ifndef arch_atomic64_inc_and_test
-/**
- * arch_atomic64_inc_and_test - increment and test
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-static __always_inline bool
-arch_atomic64_inc_and_test(atomic64_t *v)
-{
-	return arch_atomic64_inc_return(v) == 0;
-}
-#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
-#endif
-
-#ifndef arch_atomic64_add_negative
-/**
- * arch_atomic64_add_negative - add and test if negative
- * @i: integer value to add
- * @v: pointer of type atomic64_t
- *
- * Atomically adds @i to @v and returns true
- * if the result is negative, or false when
- * result is greater than or equal to zero.
- */
-static __always_inline bool
-arch_atomic64_add_negative(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(i, v) < 0;
-}
-#define arch_atomic64_add_negative arch_atomic64_add_negative
-#endif
-
-#ifndef arch_atomic64_fetch_add_unless
-/**
- * arch_atomic64_fetch_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns original value of @v
- */
-static __always_inline s64
-arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	s64 c = arch_atomic64_read(v);
-
-	do {
-		if (unlikely(c == u))
-			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
-
-	return c;
-}
-#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
-#endif
-
-#ifndef arch_atomic64_add_unless
-/**
- * arch_atomic64_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic64_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, if @v was not already @u.
- * Returns true if the addition was done.
- */
-static __always_inline bool
-arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
-{
-	return arch_atomic64_fetch_add_unless(v, a, u) != u;
-}
-#define arch_atomic64_add_unless arch_atomic64_add_unless
-#endif
-
-#ifndef arch_atomic64_inc_not_zero
-/**
- * arch_atomic64_inc_not_zero - increment unless the number is zero
- * @v: pointer of type atomic64_t
- *
- * Atomically increments @v by 1, if @v is non-zero.
- * Returns true if the increment was done.
- */
-static __always_inline bool
-arch_atomic64_inc_not_zero(atomic64_t *v)
-{
-	return arch_atomic64_add_unless(v, 1, 0);
-}
-#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
-#endif
-
-#ifndef arch_atomic64_inc_unless_negative
-static __always_inline bool
-arch_atomic64_inc_unless_negative(atomic64_t *v)
-{
-	s64 c = arch_atomic64_read(v);
-
-	do {
-		if (unlikely(c < 0))
-			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
-
-	return true;
-}
-#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
-#endif
-
-#ifndef arch_atomic64_dec_unless_positive
-static __always_inline bool
-arch_atomic64_dec_unless_positive(atomic64_t *v)
-{
-	s64 c = arch_atomic64_read(v);
-
-	do {
-		if (unlikely(c > 0))
-			return false;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
-
-	return true;
-}
-#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
-#endif
-
-#ifndef arch_atomic64_dec_if_positive
-static __always_inline s64
-arch_atomic64_dec_if_positive(atomic64_t *v)
-{
-	s64 dec, c = arch_atomic64_read(v);
-
-	do {
-		dec = c - 1;
-		if (unlikely(dec < 0))
-			break;
-	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
-
-	return dec;
-}
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
-#endif
-
-#endif /* _LINUX_ATOMIC_FALLBACK_H */
-// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index ed1d3ff..1896a58 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,9 +77,8 @@
 	__ret;								\
 })
 
-#include <linux/atomic-arch-fallback.h>
-#include <asm-generic/atomic-instrumented.h>
-
-#include <asm-generic/atomic-long.h>
+#include <linux/atomic/atomic-arch-fallback.h>
+#include <linux/atomic/atomic-instrumented.h>
+#include <linux/atomic/atomic-long.h>
 
 #endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
new file mode 100644
index 0000000..a3dba31
--- /dev/null
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -0,0 +1,2361 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-fallback.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_FALLBACK_H
+#define _LINUX_ATOMIC_FALLBACK_H
+
+#include <linux/compiler.h>
+
+#ifndef arch_xchg_relaxed
+#define arch_xchg_acquire arch_xchg
+#define arch_xchg_release arch_xchg
+#define arch_xchg_relaxed arch_xchg
+#else /* arch_xchg_relaxed */
+
+#ifndef arch_xchg_acquire
+#define arch_xchg_acquire(...) \
+	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg_release
+#define arch_xchg_release(...) \
+	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg
+#define arch_xchg(...) \
+	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_xchg_relaxed */
+
+#ifndef arch_cmpxchg_relaxed
+#define arch_cmpxchg_acquire arch_cmpxchg
+#define arch_cmpxchg_release arch_cmpxchg
+#define arch_cmpxchg_relaxed arch_cmpxchg
+#else /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg_acquire
+#define arch_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg_release
+#define arch_cmpxchg_release(...) \
+	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg
+#define arch_cmpxchg(...) \
+	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg64_relaxed
+#define arch_cmpxchg64_acquire arch_cmpxchg64
+#define arch_cmpxchg64_release arch_cmpxchg64
+#define arch_cmpxchg64_relaxed arch_cmpxchg64
+#else /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_cmpxchg64_acquire
+#define arch_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64_release
+#define arch_cmpxchg64_release(...) \
+	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64
+#define arch_cmpxchg64(...) \
+	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_try_cmpxchg_relaxed
+#ifdef arch_try_cmpxchg
+#define arch_try_cmpxchg_acquire arch_try_cmpxchg
+#define arch_try_cmpxchg_release arch_try_cmpxchg
+#define arch_try_cmpxchg_relaxed arch_try_cmpxchg
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_acquire((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_acquire */
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_release((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_release */
+
+#ifndef arch_try_cmpxchg_relaxed
+#define arch_try_cmpxchg_relaxed(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = arch_cmpxchg_relaxed((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif /* arch_try_cmpxchg_relaxed */
+
+#else /* arch_try_cmpxchg_relaxed */
+
+#ifndef arch_try_cmpxchg_acquire
+#define arch_try_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg_release
+#define arch_try_cmpxchg_release(...) \
+	__atomic_op_release(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_try_cmpxchg
+#define arch_try_cmpxchg(...) \
+	__atomic_op_fence(arch_try_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_read_acquire
+static __always_inline int
+arch_atomic_read_acquire(const atomic_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic_read_acquire arch_atomic_read_acquire
+#endif
+
+#ifndef arch_atomic_set_release
+static __always_inline void
+arch_atomic_set_release(atomic_t *v, int i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic_set_release arch_atomic_set_release
+#endif
+
+#ifndef arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire arch_atomic_add_return
+#define arch_atomic_add_return_release arch_atomic_add_return
+#define arch_atomic_add_return_relaxed arch_atomic_add_return
+#else /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_add_return_acquire
+static __always_inline int
+arch_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
+#endif
+
+#ifndef arch_atomic_add_return_release
+static __always_inline int
+arch_atomic_add_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_add_return_relaxed(i, v);
+}
+#define arch_atomic_add_return_release arch_atomic_add_return_release
+#endif
+
+#ifndef arch_atomic_add_return
+static __always_inline int
+arch_atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_add_return arch_atomic_add_return
+#endif
+
+#endif /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
+#else /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_fetch_add_acquire
+static __always_inline int
+arch_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic_fetch_add_release
+static __always_inline int
+arch_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
+#endif
+
+#ifndef arch_atomic_fetch_add
+static __always_inline int
+arch_atomic_fetch_add(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add arch_atomic_fetch_add
+#endif
+
+#endif /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return
+#define arch_atomic_sub_return_release arch_atomic_sub_return
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
+#else /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_sub_return_acquire
+static __always_inline int
+arch_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#endif
+
+#ifndef arch_atomic_sub_return_release
+static __always_inline int
+arch_atomic_sub_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+#define arch_atomic_sub_return_release arch_atomic_sub_return_release
+#endif
+
+#ifndef arch_atomic_sub_return
+static __always_inline int
+arch_atomic_sub_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_sub_return arch_atomic_sub_return
+#endif
+
+#endif /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+#else /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_fetch_sub_acquire
+static __always_inline int
+arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic_fetch_sub_release
+static __always_inline int
+arch_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#endif
+
+#ifndef arch_atomic_fetch_sub
+static __always_inline int
+arch_atomic_fetch_sub(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#endif
+
+#endif /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_inc
+static __always_inline void
+arch_atomic_inc(atomic_t *v)
+{
+	arch_atomic_add(1, v);
+}
+#define arch_atomic_inc arch_atomic_inc
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+#ifdef arch_atomic_inc_return
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return
+#define arch_atomic_inc_return_release arch_atomic_inc_return
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
+#endif /* arch_atomic_inc_return */
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_add_return(1, v);
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	return arch_atomic_add_return_acquire(1, v);
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	return arch_atomic_add_return_release(1, v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+static __always_inline int
+arch_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_add_return_relaxed(1, v);
+}
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#endif
+
+#else /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_inc_return_relaxed(v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#endif /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_fetch_inc_relaxed
+#ifdef arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
+#endif /* arch_atomic_fetch_inc */
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	return arch_atomic_fetch_add(1, v);
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_add_acquire(1, v);
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	return arch_atomic_fetch_add_release(1, v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc_relaxed
+static __always_inline int
+arch_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(1, v);
+}
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#endif /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_dec
+static __always_inline void
+arch_atomic_dec(atomic_t *v)
+{
+	arch_atomic_sub(1, v);
+}
+#define arch_atomic_dec arch_atomic_dec
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+#ifdef arch_atomic_dec_return
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return
+#define arch_atomic_dec_return_release arch_atomic_dec_return
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
+#endif /* arch_atomic_dec_return */
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_sub_return(1, v);
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	return arch_atomic_sub_return_acquire(1, v);
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	return arch_atomic_sub_return_release(1, v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+static __always_inline int
+arch_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_sub_return_relaxed(1, v);
+}
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+#endif
+
+#else /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_dec_return_relaxed(v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#endif /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_fetch_dec_relaxed
+#ifdef arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
+#endif /* arch_atomic_fetch_dec */
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	return arch_atomic_fetch_sub(1, v);
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(1, v);
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_release(1, v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec_relaxed
+static __always_inline int
+arch_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#endif /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
+#else /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_fetch_and_acquire
+static __always_inline int
+arch_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic_fetch_and_release
+static __always_inline int
+arch_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
+#endif
+
+#ifndef arch_atomic_fetch_and
+static __always_inline int
+arch_atomic_fetch_and(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and arch_atomic_fetch_and
+#endif
+
+#endif /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_andnot
+static __always_inline void
+arch_atomic_andnot(int i, atomic_t *v)
+{
+	arch_atomic_and(~i, v);
+}
+#define arch_atomic_andnot arch_atomic_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+#ifdef arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
+#endif /* arch_atomic_fetch_andnot */
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(~i, v);
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_acquire(~i, v);
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_release(~i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+static __always_inline int
+arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#endif /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or
+#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
+#else /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_or_acquire
+static __always_inline int
+arch_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_or_release
+static __always_inline int
+arch_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
+#endif
+
+#ifndef arch_atomic_fetch_or
+static __always_inline int
+arch_atomic_fetch_or(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or arch_atomic_fetch_or
+#endif
+
+#endif /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+#else /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_fetch_xor_acquire
+static __always_inline int
+arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic_fetch_xor_release
+static __always_inline int
+arch_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#endif
+
+#ifndef arch_atomic_fetch_xor
+static __always_inline int
+arch_atomic_fetch_xor(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
+#endif
+
+#endif /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire arch_atomic_xchg
+#define arch_atomic_xchg_release arch_atomic_xchg
+#define arch_atomic_xchg_relaxed arch_atomic_xchg
+#else /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_xchg_acquire
+static __always_inline int
+arch_atomic_xchg_acquire(atomic_t *v, int i)
+{
+	int ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
+#endif
+
+#ifndef arch_atomic_xchg_release
+static __always_inline int
+arch_atomic_xchg_release(atomic_t *v, int i)
+{
+	__atomic_release_fence();
+	return arch_atomic_xchg_relaxed(v, i);
+}
+#define arch_atomic_xchg_release arch_atomic_xchg_release
+#endif
+
+#ifndef arch_atomic_xchg
+static __always_inline int
+arch_atomic_xchg(atomic_t *v, int i)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_xchg arch_atomic_xchg
+#endif
+
+#endif /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#else /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_acquire
+static __always_inline int
+arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_cmpxchg_release
+static __always_inline int
+arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_cmpxchg
+static __always_inline int
+arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
+#endif
+
+#endif /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+#ifdef arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
+#endif /* arch_atomic_try_cmpxchg */
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#endif /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_sub_and_test
+/**
+ * arch_atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v) == 0;
+}
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
+#endif
+
+#ifndef arch_atomic_dec_and_test
+/**
+ * arch_atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_return(v) == 0;
+}
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
+#endif
+
+#ifndef arch_atomic_inc_and_test
+/**
+ * arch_atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_return(v) == 0;
+}
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
+#endif
+
+#ifndef arch_atomic_add_negative
+/**
+ * arch_atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v) < 0;
+}
+#define arch_atomic_add_negative arch_atomic_add_negative
+#endif
+
+#ifndef arch_atomic_fetch_add_unless
+/**
+ * arch_atomic_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+#endif
+
+#ifndef arch_atomic_add_unless
+/**
+ * arch_atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic_add_unless arch_atomic_add_unless
+#endif
+
+#ifndef arch_atomic_inc_not_zero
+/**
+ * arch_atomic_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic_inc_not_zero(atomic_t *v)
+{
+	return arch_atomic_add_unless(v, 1, 0);
+}
+#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
+#endif
+
+#ifndef arch_atomic_inc_unless_negative
+static __always_inline bool
+arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+#endif
+
+#ifndef arch_atomic_dec_unless_positive
+static __always_inline bool
+arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+#endif
+
+#ifndef arch_atomic_dec_if_positive
+static __always_inline int
+arch_atomic_dec_if_positive(atomic_t *v)
+{
+	int dec, c = arch_atomic_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
+#endif
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
+#ifndef arch_atomic64_read_acquire
+static __always_inline s64
+arch_atomic64_read_acquire(const atomic64_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic64_read_acquire arch_atomic64_read_acquire
+#endif
+
+#ifndef arch_atomic64_set_release
+static __always_inline void
+arch_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic64_set_release arch_atomic64_set_release
+#endif
+
+#ifndef arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return
+#define arch_atomic64_add_return_release arch_atomic64_add_return
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
+#else /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_add_return_acquire
+static __always_inline s64
+arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#endif
+
+#ifndef arch_atomic64_add_return_release
+static __always_inline s64
+arch_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+#define arch_atomic64_add_return_release arch_atomic64_add_return_release
+#endif
+
+#ifndef arch_atomic64_add_return
+static __always_inline s64
+arch_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_add_return arch_atomic64_add_return
+#endif
+
+#endif /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+#else /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_fetch_add_acquire
+static __always_inline s64
+arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_add_release
+static __always_inline s64
+arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#endif
+
+#ifndef arch_atomic64_fetch_add
+static __always_inline s64
+arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+#endif
+
+#endif /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
+#else /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_sub_return_acquire
+static __always_inline s64
+arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#endif
+
+#ifndef arch_atomic64_sub_return_release
+static __always_inline s64
+arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
+#endif
+
+#ifndef arch_atomic64_sub_return
+static __always_inline s64
+arch_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return arch_atomic64_sub_return
+#endif
+
+#endif /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+#else /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_acquire
+static __always_inline s64
+arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_sub_release
+static __always_inline s64
+arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#endif
+
+#ifndef arch_atomic64_fetch_sub
+static __always_inline s64
+arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#endif
+
+#endif /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_inc
+static __always_inline void
+arch_atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_add(1, v);
+}
+#define arch_atomic64_inc arch_atomic64_inc
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+#ifdef arch_atomic64_inc_return
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
+#endif /* arch_atomic64_inc_return */
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_add_return(1, v);
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_add_return_acquire(1, v);
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	return arch_atomic64_add_return_release(1, v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+static __always_inline s64
+arch_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_add_return_relaxed(1, v);
+}
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#endif
+
+#else /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_inc_return_relaxed(v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#endif /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+#ifdef arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
+#endif /* arch_atomic64_fetch_inc */
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(1, v);
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(1, v);
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_release(1, v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+static __always_inline s64
+arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(1, v);
+}
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#endif /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_dec
+static __always_inline void
+arch_atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_sub(1, v);
+}
+#define arch_atomic64_dec arch_atomic64_dec
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+#ifdef arch_atomic64_dec_return
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
+#endif /* arch_atomic64_dec_return */
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_sub_return(1, v);
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_acquire(1, v);
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_release(1, v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+static __always_inline s64
+arch_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(1, v);
+}
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#endif
+
+#else /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_dec_return_relaxed(v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#endif /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+#ifdef arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
+#endif /* arch_atomic64_fetch_dec */
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(1, v);
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(1, v);
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_release(1, v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+static __always_inline s64
+arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#endif /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+#else /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_fetch_and_acquire
+static __always_inline s64
+arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_and_release
+static __always_inline s64
+arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#endif
+
+#ifndef arch_atomic64_fetch_and
+static __always_inline s64
+arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+#endif
+
+#endif /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_andnot
+static __always_inline void
+arch_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(~i, v);
+}
+#define arch_atomic64_andnot arch_atomic64_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+#ifdef arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
+#endif /* arch_atomic64_fetch_andnot */
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(~i, v);
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(~i, v);
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_release(~i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+static __always_inline s64
+arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#endif /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+#else /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_or_release
+static __always_inline s64
+arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_or
+static __always_inline s64
+arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+#endif
+
+#endif /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+#else /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_acquire
+static __always_inline s64
+arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_xor_release
+static __always_inline s64
+arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#endif
+
+#ifndef arch_atomic64_fetch_xor
+static __always_inline s64
+arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
+#endif
+
+#endif /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_xchg_relaxed
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg
+#define arch_atomic64_xchg_release arch_atomic64_xchg
+#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
+#else /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_xchg_acquire
+static __always_inline s64
+arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#endif
+
+#ifndef arch_atomic64_xchg_release
+static __always_inline s64
+arch_atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	__atomic_release_fence();
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+#define arch_atomic64_xchg_release arch_atomic64_xchg_release
+#endif
+
+#ifndef arch_atomic64_xchg
+static __always_inline s64
+arch_atomic64_xchg(atomic64_t *v, s64 i)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_xchg arch_atomic64_xchg
+#endif
+
+#endif /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#else /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_acquire
+static __always_inline s64
+arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_cmpxchg_release
+static __always_inline s64
+arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_cmpxchg
+static __always_inline s64
+arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+#endif
+
+#endif /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+#ifdef arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
+#endif /* arch_atomic64_try_cmpxchg */
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#endif /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_sub_and_test
+/**
+ * arch_atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v) == 0;
+}
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
+#endif
+
+#ifndef arch_atomic64_dec_and_test
+/**
+ * arch_atomic64_dec_and_test - decrement and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v) == 0;
+}
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
+#endif
+
+#ifndef arch_atomic64_inc_and_test
+/**
+ * arch_atomic64_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v) == 0;
+}
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
+#endif
+
+#ifndef arch_atomic64_add_negative
+/**
+ * arch_atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v) < 0;
+}
+#define arch_atomic64_add_negative arch_atomic64_add_negative
+#endif
+
+#ifndef arch_atomic64_fetch_add_unless
+/**
+ * arch_atomic64_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline s64
+arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+#endif
+
+#ifndef arch_atomic64_add_unless
+/**
+ * arch_atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic64_add_unless arch_atomic64_add_unless
+#endif
+
+#ifndef arch_atomic64_inc_not_zero
+/**
+ * arch_atomic64_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_add_unless(v, 1, 0);
+}
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
+#endif
+
+#ifndef arch_atomic64_inc_unless_negative
+static __always_inline bool
+arch_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+#endif
+
+#ifndef arch_atomic64_dec_unless_positive
+static __always_inline bool
+arch_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+#endif
+
+#ifndef arch_atomic64_dec_if_positive
+static __always_inline s64
+arch_atomic64_dec_if_positive(atomic64_t *v)
+{
+	s64 dec, c = arch_atomic64_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+#endif
+
+#endif /* _LINUX_ATOMIC_FALLBACK_H */
+// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
new file mode 100644
index 0000000..f6fe36c
--- /dev/null
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -0,0 +1,1337 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-instrumented.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides wrappers with KASAN instrumentation for atomic operations.
+ * To use this functionality an arch's atomic.h file needs to define all
+ * atomic operations with arch_ prefix (e.g. arch_atomic_read()) and include
+ * this file at the end. This file provides atomic_read() that forwards to
+ * arch_atomic_read() for actual atomic operation.
+ * Note: if an arch atomic operation is implemented by means of other atomic
+ * operations (e.g. atomic_read()/atomic_cmpxchg() loop), then it needs to use
+ * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
+ * double instrumentation.
+ */
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
+
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/instrumented.h>
+
+static __always_inline int
+atomic_read(const atomic_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic_read(v);
+}
+
+static __always_inline int
+atomic_read_acquire(const atomic_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic_read_acquire(v);
+}
+
+static __always_inline void
+atomic_set(atomic_t *v, int i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic_set(v, i);
+}
+
+static __always_inline void
+atomic_set_release(atomic_t *v, int i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic_set_release(v, i);
+}
+
+static __always_inline void
+atomic_add(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_add(i, v);
+}
+
+static __always_inline int
+atomic_add_return(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_return(i, v);
+}
+
+static __always_inline int
+atomic_add_return_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_return_acquire(i, v);
+}
+
+static __always_inline int
+atomic_add_return_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_return_release(i, v);
+}
+
+static __always_inline int
+atomic_add_return_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_return_relaxed(i, v);
+}
+
+static __always_inline int
+atomic_fetch_add(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_add(i, v);
+}
+
+static __always_inline int
+atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_add_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_add_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_add_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_sub(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_sub(i, v);
+}
+
+static __always_inline int
+atomic_sub_return(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_sub_return(i, v);
+}
+
+static __always_inline int
+atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_sub_return_acquire(i, v);
+}
+
+static __always_inline int
+atomic_sub_return_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_sub_return_release(i, v);
+}
+
+static __always_inline int
+atomic_sub_return_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+
+static __always_inline int
+atomic_fetch_sub(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_sub(i, v);
+}
+
+static __always_inline int
+atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_sub_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_sub_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_inc(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_inc(v);
+}
+
+static __always_inline int
+atomic_inc_return(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_return(v);
+}
+
+static __always_inline int
+atomic_inc_return_acquire(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_return_acquire(v);
+}
+
+static __always_inline int
+atomic_inc_return_release(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_return_release(v);
+}
+
+static __always_inline int
+atomic_inc_return_relaxed(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_return_relaxed(v);
+}
+
+static __always_inline int
+atomic_fetch_inc(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_inc(v);
+}
+
+static __always_inline int
+atomic_fetch_inc_acquire(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_inc_acquire(v);
+}
+
+static __always_inline int
+atomic_fetch_inc_release(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_inc_release(v);
+}
+
+static __always_inline int
+atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+atomic_dec(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_dec(v);
+}
+
+static __always_inline int
+atomic_dec_return(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_return(v);
+}
+
+static __always_inline int
+atomic_dec_return_acquire(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_return_acquire(v);
+}
+
+static __always_inline int
+atomic_dec_return_release(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_return_release(v);
+}
+
+static __always_inline int
+atomic_dec_return_relaxed(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_return_relaxed(v);
+}
+
+static __always_inline int
+atomic_fetch_dec(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_dec(v);
+}
+
+static __always_inline int
+atomic_fetch_dec_acquire(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_dec_acquire(v);
+}
+
+static __always_inline int
+atomic_fetch_dec_release(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_dec_release(v);
+}
+
+static __always_inline int
+atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+atomic_and(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_and(i, v);
+}
+
+static __always_inline int
+atomic_fetch_and(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_and(i, v);
+}
+
+static __always_inline int
+atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_and_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_and_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_and_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_andnot(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_andnot(i, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot(i, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_or(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_or(i, v);
+}
+
+static __always_inline int
+atomic_fetch_or(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_or(i, v);
+}
+
+static __always_inline int
+atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_or_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_or_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_or_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_xor(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_xor(i, v);
+}
+
+static __always_inline int
+atomic_fetch_xor(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_xor(i, v);
+}
+
+static __always_inline int
+atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_xor_acquire(i, v);
+}
+
+static __always_inline int
+atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_xor_release(i, v);
+}
+
+static __always_inline int
+atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline int
+atomic_xchg(atomic_t *v, int i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_xchg(v, i);
+}
+
+static __always_inline int
+atomic_xchg_acquire(atomic_t *v, int i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_xchg_acquire(v, i);
+}
+
+static __always_inline int
+atomic_xchg_release(atomic_t *v, int i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_xchg_release(v, i);
+}
+
+static __always_inline int
+atomic_xchg_relaxed(atomic_t *v, int i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_xchg_relaxed(v, i);
+}
+
+static __always_inline int
+atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_cmpxchg(v, old, new);
+}
+
+static __always_inline int
+atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline int
+atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_cmpxchg_release(v, old, new);
+}
+
+static __always_inline int
+atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_sub_and_test(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_sub_and_test(i, v);
+}
+
+static __always_inline bool
+atomic_dec_and_test(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_and_test(v);
+}
+
+static __always_inline bool
+atomic_inc_and_test(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_and_test(v);
+}
+
+static __always_inline bool
+atomic_add_negative(int i, atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_negative(i, v);
+}
+
+static __always_inline int
+atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_add_unless(atomic_t *v, int a, int u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_inc_not_zero(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_not_zero(v);
+}
+
+static __always_inline bool
+atomic_inc_unless_negative(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_inc_unless_negative(v);
+}
+
+static __always_inline bool
+atomic_dec_unless_positive(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_unless_positive(v);
+}
+
+static __always_inline int
+atomic_dec_if_positive(atomic_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_dec_if_positive(v);
+}
+
+static __always_inline s64
+atomic64_read(const atomic64_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic64_read(v);
+}
+
+static __always_inline s64
+atomic64_read_acquire(const atomic64_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic64_read_acquire(v);
+}
+
+static __always_inline void
+atomic64_set(atomic64_t *v, s64 i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic64_set(v, i);
+}
+
+static __always_inline void
+atomic64_set_release(atomic64_t *v, s64 i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic64_set_release(v, i);
+}
+
+static __always_inline void
+atomic64_add(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_add(i, v);
+}
+
+static __always_inline s64
+atomic64_add_return(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_return(i, v);
+}
+
+static __always_inline s64
+atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_return_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_return_release(i, v);
+}
+
+static __always_inline s64
+atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+atomic64_sub(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_sub(i, v);
+}
+
+static __always_inline s64
+atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_sub_return(i, v);
+}
+
+static __always_inline s64
+atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_sub_return_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_sub_return_release(i, v);
+}
+
+static __always_inline s64
+atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_sub(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_sub_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_sub_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+atomic64_inc(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_inc(v);
+}
+
+static __always_inline s64
+atomic64_inc_return(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_return(v);
+}
+
+static __always_inline s64
+atomic64_inc_return_acquire(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_return_acquire(v);
+}
+
+static __always_inline s64
+atomic64_inc_return_release(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_return_release(v);
+}
+
+static __always_inline s64
+atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_return_relaxed(v);
+}
+
+static __always_inline s64
+atomic64_fetch_inc(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_inc(v);
+}
+
+static __always_inline s64
+atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_inc_acquire(v);
+}
+
+static __always_inline s64
+atomic64_fetch_inc_release(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_inc_release(v);
+}
+
+static __always_inline s64
+atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+atomic64_dec(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_dec(v);
+}
+
+static __always_inline s64
+atomic64_dec_return(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_return(v);
+}
+
+static __always_inline s64
+atomic64_dec_return_acquire(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_return_acquire(v);
+}
+
+static __always_inline s64
+atomic64_dec_return_release(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_return_release(v);
+}
+
+static __always_inline s64
+atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_return_relaxed(v);
+}
+
+static __always_inline s64
+atomic64_fetch_dec(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_dec(v);
+}
+
+static __always_inline s64
+atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_dec_acquire(v);
+}
+
+static __always_inline s64
+atomic64_fetch_dec_release(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_dec_release(v);
+}
+
+static __always_inline s64
+atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+atomic64_and(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_and(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_and(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_and_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_and_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+atomic64_andnot(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_andnot(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+atomic64_or(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_or(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_or(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_or_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_or_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+atomic64_xor(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic64_xor(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_xor(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_xor_acquire(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_xor_release(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline s64
+atomic64_xchg(atomic64_t *v, s64 i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_xchg(v, i);
+}
+
+static __always_inline s64
+atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_xchg_acquire(v, i);
+}
+
+static __always_inline s64
+atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_xchg_release(v, i);
+}
+
+static __always_inline s64
+atomic64_xchg_relaxed(atomic64_t *v, s64 i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+
+static __always_inline s64
+atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_cmpxchg(v, old, new);
+}
+
+static __always_inline s64
+atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline s64
+atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_cmpxchg_release(v, old, new);
+}
+
+static __always_inline s64
+atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic64_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic64_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_sub_and_test(i, v);
+}
+
+static __always_inline bool
+atomic64_dec_and_test(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_and_test(v);
+}
+
+static __always_inline bool
+atomic64_inc_and_test(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_and_test(v);
+}
+
+static __always_inline bool
+atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_negative(i, v);
+}
+
+static __always_inline s64
+atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic64_inc_not_zero(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_not_zero(v);
+}
+
+static __always_inline bool
+atomic64_inc_unless_negative(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_inc_unless_negative(v);
+}
+
+static __always_inline bool
+atomic64_dec_unless_positive(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_unless_positive(v);
+}
+
+static __always_inline s64
+atomic64_dec_if_positive(atomic64_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic64_dec_if_positive(v);
+}
+
+#define xchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg(__ai_ptr, __VA_ARGS__); \
+})
+
+#define xchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
+})
+
+#define xchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
+})
+
+#define xchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64_acquire(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64_release(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64_relaxed(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
+})
+
+#define try_cmpxchg(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg_acquire(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg_release(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define try_cmpxchg_relaxed(ptr, oldp, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	typeof(oldp) __ai_oldp = (oldp); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
+	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
+})
+
+#define cmpxchg_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg64_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
+})
+
+#define sync_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+
+#define cmpxchg_double(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
+})
+
+
+#define cmpxchg_double_local(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
+	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
+})
+
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
+// 5edd72f105b6f54b7e9492d794abee88e6912d29
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
new file mode 100644
index 0000000..e40e480
--- /dev/null
+++ b/include/linux/atomic/atomic-long.h
@@ -0,0 +1,1014 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-long.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
+
+#include <linux/compiler.h>
+#include <asm/types.h>
+
+#ifdef CONFIG_64BIT
+typedef atomic64_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#else
+typedef atomic_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#endif
+
+#ifdef CONFIG_64BIT
+
+static __always_inline long
+atomic_long_read(const atomic_long_t *v)
+{
+	return atomic64_read(v);
+}
+
+static __always_inline long
+atomic_long_read_acquire(const atomic_long_t *v)
+{
+	return atomic64_read_acquire(v);
+}
+
+static __always_inline void
+atomic_long_set(atomic_long_t *v, long i)
+{
+	atomic64_set(v, i);
+}
+
+static __always_inline void
+atomic_long_set_release(atomic_long_t *v, long i)
+{
+	atomic64_set_release(v, i);
+}
+
+static __always_inline void
+atomic_long_add(long i, atomic_long_t *v)
+{
+	atomic64_add(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return(long i, atomic_long_t *v)
+{
+	return atomic64_add_return(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_add_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	return atomic64_add_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_add(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_add_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_sub(long i, atomic_long_t *v)
+{
+	atomic64_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	return atomic64_sub_return(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	return atomic64_sub_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_inc(atomic_long_t *v)
+{
+	atomic64_inc(v);
+}
+
+static __always_inline long
+atomic_long_inc_return(atomic_long_t *v)
+{
+	return atomic64_inc_return(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	return atomic64_inc_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_release(atomic_long_t *v)
+{
+	return atomic64_inc_return_release(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	return atomic64_inc_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc(atomic_long_t *v)
+{
+	return atomic64_fetch_inc(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	return atomic64_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	return atomic64_fetch_inc_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	return atomic64_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_dec(atomic_long_t *v)
+{
+	atomic64_dec(v);
+}
+
+static __always_inline long
+atomic_long_dec_return(atomic_long_t *v)
+{
+	return atomic64_dec_return(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	return atomic64_dec_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_release(atomic_long_t *v)
+{
+	return atomic64_dec_return_release(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	return atomic64_dec_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec(atomic_long_t *v)
+{
+	return atomic64_fetch_dec(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	return atomic64_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	return atomic64_fetch_dec_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	return atomic64_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_and(long i, atomic_long_t *v)
+{
+	atomic64_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_and_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_andnot(long i, atomic_long_t *v)
+{
+	atomic64_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_or(long i, atomic_long_t *v)
+{
+	atomic64_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_or_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_xor(long i, atomic_long_t *v)
+{
+	atomic64_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	return atomic64_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_xchg(atomic_long_t *v, long i)
+{
+	return atomic64_xchg(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	return atomic64_xchg_acquire(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	return atomic64_xchg_release(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	return atomic64_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	return atomic64_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	return atomic64_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	return atomic64_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	return atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	return atomic64_try_cmpxchg(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	return atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	return atomic64_try_cmpxchg_release(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	return atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	return atomic64_sub_and_test(i, v);
+}
+
+static __always_inline bool
+atomic_long_dec_and_test(atomic_long_t *v)
+{
+	return atomic64_dec_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_inc_and_test(atomic_long_t *v)
+{
+	return atomic64_inc_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	return atomic64_add_negative(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	return atomic64_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	return atomic64_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	return atomic64_inc_not_zero(v);
+}
+
+static __always_inline bool
+atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	return atomic64_inc_unless_negative(v);
+}
+
+static __always_inline bool
+atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	return atomic64_dec_unless_positive(v);
+}
+
+static __always_inline long
+atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	return atomic64_dec_if_positive(v);
+}
+
+#else /* CONFIG_64BIT */
+
+static __always_inline long
+atomic_long_read(const atomic_long_t *v)
+{
+	return atomic_read(v);
+}
+
+static __always_inline long
+atomic_long_read_acquire(const atomic_long_t *v)
+{
+	return atomic_read_acquire(v);
+}
+
+static __always_inline void
+atomic_long_set(atomic_long_t *v, long i)
+{
+	atomic_set(v, i);
+}
+
+static __always_inline void
+atomic_long_set_release(atomic_long_t *v, long i)
+{
+	atomic_set_release(v, i);
+}
+
+static __always_inline void
+atomic_long_add(long i, atomic_long_t *v)
+{
+	atomic_add(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return(long i, atomic_long_t *v)
+{
+	return atomic_add_return(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	return atomic_add_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	return atomic_add_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	return atomic_fetch_add(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_add_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_sub(long i, atomic_long_t *v)
+{
+	atomic_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	return atomic_sub_return(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	return atomic_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	return atomic_sub_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	return atomic_fetch_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_inc(atomic_long_t *v)
+{
+	atomic_inc(v);
+}
+
+static __always_inline long
+atomic_long_inc_return(atomic_long_t *v)
+{
+	return atomic_inc_return(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	return atomic_inc_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_release(atomic_long_t *v)
+{
+	return atomic_inc_return_release(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	return atomic_inc_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc(atomic_long_t *v)
+{
+	return atomic_fetch_inc(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	return atomic_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	return atomic_fetch_inc_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	return atomic_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_dec(atomic_long_t *v)
+{
+	atomic_dec(v);
+}
+
+static __always_inline long
+atomic_long_dec_return(atomic_long_t *v)
+{
+	return atomic_dec_return(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	return atomic_dec_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_release(atomic_long_t *v)
+{
+	return atomic_dec_return_release(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	return atomic_dec_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec(atomic_long_t *v)
+{
+	return atomic_fetch_dec(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	return atomic_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	return atomic_fetch_dec_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	return atomic_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_and(long i, atomic_long_t *v)
+{
+	atomic_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	return atomic_fetch_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_and_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_andnot(long i, atomic_long_t *v)
+{
+	atomic_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	return atomic_fetch_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_or(long i, atomic_long_t *v)
+{
+	atomic_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	return atomic_fetch_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_or_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_xor(long i, atomic_long_t *v)
+{
+	atomic_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	return atomic_fetch_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	return atomic_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	return atomic_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	return atomic_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_xchg(atomic_long_t *v, long i)
+{
+	return atomic_xchg(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	return atomic_xchg_acquire(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	return atomic_xchg_release(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	return atomic_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	return atomic_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	return atomic_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	return atomic_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	return atomic_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	return atomic_try_cmpxchg(v, (int *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	return atomic_try_cmpxchg_acquire(v, (int *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	return atomic_try_cmpxchg_release(v, (int *)old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	return atomic_try_cmpxchg_relaxed(v, (int *)old, new);
+}
+
+static __always_inline bool
+atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	return atomic_sub_and_test(i, v);
+}
+
+static __always_inline bool
+atomic_long_dec_and_test(atomic_long_t *v)
+{
+	return atomic_dec_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_inc_and_test(atomic_long_t *v)
+{
+	return atomic_inc_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	return atomic_add_negative(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	return atomic_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	return atomic_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	return atomic_inc_not_zero(v);
+}
+
+static __always_inline bool
+atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	return atomic_inc_unless_negative(v);
+}
+
+static __always_inline bool
+atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	return atomic_dec_unless_positive(v);
+}
+
+static __always_inline long
+atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	return atomic_dec_if_positive(v);
+}
+
+#endif /* CONFIG_64BIT */
+#endif /* _LINUX_ATOMIC_LONG_H */
+// c5552b5d78a0c7584dfd03cba985e78a1a86bbed
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 9c7fbd4..0e7bab3 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -14,9 +14,9 @@ if [ $? -ne 0 ]; then
 fi
 
 cat <<EOF |
-asm-generic/atomic-instrumented.h
-asm-generic/atomic-long.h
-linux/atomic-arch-fallback.h
+linux/atomic/atomic-instrumented.h
+linux/atomic/atomic-long.h
+linux/atomic/atomic-arch-fallback.h
 EOF
 while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index b0c45ae..6fc1ab7 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -121,8 +121,8 @@ cat << EOF
  * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
  * double instrumentation.
  */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
@@ -158,5 +158,5 @@ gen_xchg "cmpxchg_double_local" "2 * "
 
 cat <<EOF
 
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
 EOF
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index e318d3f..db69572 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -61,8 +61,8 @@ cat << EOF
 // Generated by $0
 // DO NOT MODIFY THIS FILE DIRECTLY
 
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
 #include <asm/types.h>
@@ -98,5 +98,5 @@ done
 
 cat <<EOF
 #endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
+#endif /* _LINUX_ATOMIC_LONG_H */
 EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 56b119f..5b98a83 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -8,9 +8,9 @@ ATOMICTBL=${ATOMICDIR}/atomics.tbl
 LINUXDIR=${ATOMICDIR}/../..
 
 cat <<EOF |
-gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
-gen-atomic-long.sh              asm-generic/atomic-long.h
-gen-atomic-fallback.sh          linux/atomic-arch-fallback.h
+gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
+gen-atomic-long.sh              linux/atomic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
