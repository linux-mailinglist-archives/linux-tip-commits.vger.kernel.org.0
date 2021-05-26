Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA0391602
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhEZL1E (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhEZL0Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4CC061574;
        Wed, 26 May 2021 04:24:41 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LpjdLiVC0CuARdbb5ghMXcuiDy+6cVLGovl4Eeq+8E=;
        b=Qr+1vSxvl4ssYbFzuSyuZwtakP0EN9BhiOh26SPHXpDINYyHCHTK9XULuNPMVxHW8dpOrr
        J7XxbhwcCkU10JRnBF2gPx6SPGc7npteq3rP6dRZswQikZLgNjdwkLwd1/v2jxE64ugBRr
        WqyQnwj2x4bP/oH28vsHKQEKJQo5l+UD5Zr21xXN8BlrwigR3kG7tHVbtZ1hORENLA2KXA
        n7+NpCQzBvnOB066YgeJdlLbTJo6hWJjQ9RewzAL3iZz4fXZeJgH6ukJJ5n4ogBxKS6O4H
        jlZWTbYlFym9HtVrHecitAySxYQf15Bh15rdGA9I3p1zPXM/hYKEY8bb26iMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LpjdLiVC0CuARdbb5ghMXcuiDy+6cVLGovl4Eeq+8E=;
        b=frgklzFn72LLPS4AN3ZNe3Gil4eIWyvim5u2q0afLcjEt2wovZ6kpR02iNBOhtsrEi3c5H
        EPk+DGW1rvv5k+AA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic64: support ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-11-mark.rutland@arm.com>
References: <20210525140232.53872-11-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827904.29796.143476302377239990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1bdadf46eff6804ace5fa46b6856da4799f12b5c
Gitweb:        https://git.kernel.org/tip/1bdadf46eff6804ace5fa46b6856da4799f12b5c
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: atomic64: support ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/atomic64.h, and it's
impractical to convert the header and all these architectures in one go.
To make it possible to convert them one-by-one, let's make the
asm-generic implementation function as either atomic64_*() or
arch_atomic64_*() depending on whether ARCH_ATOMIC is selected. To do
this, the generic implementations are prefixed as generic_atomic64_*(),
and preprocessor definitions map atomic64_*()/arch_atomic64_*() onto
these as appropriate.

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
Link: https://lore.kernel.org/r/20210525140232.53872-11-mark.rutland@arm.com
---
 include/asm-generic/atomic64.h | 74 +++++++++++++++++++++++++++------
 lib/atomic64.c                 | 36 ++++++++--------
 2 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d..c8c7d9f 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -15,19 +15,17 @@ typedef struct {
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-extern s64 atomic64_read(const atomic64_t *v);
-extern void atomic64_set(atomic64_t *v, s64 i);
-
-#define atomic64_set_release(v, i)	atomic64_set((v), (i))
+extern s64 generic_atomic64_read(const atomic64_t *v);
+extern void generic_atomic64_set(atomic64_t *v, s64 i);
 
 #define ATOMIC64_OP(op)							\
-extern void	 atomic64_##op(s64 a, atomic64_t *v);
+extern void generic_atomic64_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OP_RETURN(op)						\
-extern s64 atomic64_##op##_return(s64 a, atomic64_t *v);
+extern s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v);
 
 #define ATOMIC64_FETCH_OP(op)						\
-extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
+extern s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
@@ -46,11 +44,61 @@ ATOMIC64_OPS(xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-extern s64 atomic64_dec_if_positive(atomic64_t *v);
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
-extern s64 atomic64_xchg(atomic64_t *v, s64 new);
-extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+extern s64 generic_atomic64_dec_if_positive(atomic64_t *v);
+extern s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
+extern s64 generic_atomic64_xchg(atomic64_t *v, s64 new);
+extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#define arch_atomic64_read		generic_atomic64_read
+#define arch_atomic64_set		generic_atomic64_set
+#define arch_atomic64_set_release	generic_atomic64_set
+
+#define arch_atomic64_add		generic_atomic64_add
+#define arch_atomic64_add_return	generic_atomic64_add_return
+#define arch_atomic64_fetch_add		generic_atomic64_fetch_add
+#define arch_atomic64_sub		generic_atomic64_sub
+#define arch_atomic64_sub_return	generic_atomic64_sub_return
+#define arch_atomic64_fetch_sub		generic_atomic64_fetch_sub
+
+#define arch_atomic64_and		generic_atomic64_and
+#define arch_atomic64_fetch_and		generic_atomic64_fetch_and
+#define arch_atomic64_or		generic_atomic64_or
+#define arch_atomic64_fetch_or		generic_atomic64_fetch_or
+#define arch_atomic64_xor		generic_atomic64_xor
+#define arch_atomic64_fetch_xor		generic_atomic64_fetch_xor
+
+#define arch_atomic64_dec_if_positive	generic_atomic64_dec_if_positive
+#define arch_atomic64_cmpxchg		generic_atomic64_cmpxchg
+#define arch_atomic64_xchg		generic_atomic64_xchg
+#define arch_atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#define atomic64_read			generic_atomic64_read
+#define atomic64_set			generic_atomic64_set
+#define atomic64_set_release		generic_atomic64_set
+
+#define atomic64_add			generic_atomic64_add
+#define atomic64_add_return		generic_atomic64_add_return
+#define atomic64_fetch_add		generic_atomic64_fetch_add
+#define atomic64_sub			generic_atomic64_sub
+#define atomic64_sub_return		generic_atomic64_sub_return
+#define atomic64_fetch_sub		generic_atomic64_fetch_sub
+
+#define atomic64_and			generic_atomic64_and
+#define atomic64_fetch_and		generic_atomic64_fetch_and
+#define atomic64_or			generic_atomic64_or
+#define atomic64_fetch_or		generic_atomic64_fetch_or
+#define atomic64_xor			generic_atomic64_xor
+#define atomic64_fetch_xor		generic_atomic64_fetch_xor
+
+#define atomic64_dec_if_positive	generic_atomic64_dec_if_positive
+#define atomic64_cmpxchg		generic_atomic64_cmpxchg
+#define atomic64_xchg			generic_atomic64_xchg
+#define atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
+
+#endif /* CONFIG_ARCH_ATOMIC */
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/lib/atomic64.c b/lib/atomic64.c
index e98c85a..3df6539 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -42,7 +42,7 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
 	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
 }
 
-s64 atomic64_read(const atomic64_t *v)
+s64 generic_atomic64_read(const atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -53,9 +53,9 @@ s64 atomic64_read(const atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_read);
+EXPORT_SYMBOL(generic_atomic64_read);
 
-void atomic64_set(atomic64_t *v, s64 i)
+void generic_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -64,10 +64,10 @@ void atomic64_set(atomic64_t *v, s64 i)
 	v->counter = i;
 	raw_spin_unlock_irqrestore(lock, flags);
 }
-EXPORT_SYMBOL(atomic64_set);
+EXPORT_SYMBOL(generic_atomic64_set);
 
 #define ATOMIC64_OP(op, c_op)						\
-void atomic64_##op(s64 a, atomic64_t *v)				\
+void generic_atomic64_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -76,10 +76,10 @@ void atomic64_##op(s64 a, atomic64_t *v)				\
 	v->counter c_op a;						\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 }									\
-EXPORT_SYMBOL(atomic64_##op);
+EXPORT_SYMBOL(generic_atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
+s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -90,10 +90,10 @@ s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_##op##_return);
+EXPORT_SYMBOL(generic_atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
+s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -105,7 +105,7 @@ s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_fetch_##op);
+EXPORT_SYMBOL(generic_atomic64_fetch_##op);
 
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
@@ -130,7 +130,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-s64 atomic64_dec_if_positive(atomic64_t *v)
+s64 generic_atomic64_dec_if_positive(atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -143,9 +143,9 @@ s64 atomic64_dec_if_positive(atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_dec_if_positive);
+EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
 
-s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -158,9 +158,9 @@ s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_cmpxchg);
+EXPORT_SYMBOL(generic_atomic64_cmpxchg);
 
-s64 atomic64_xchg(atomic64_t *v, s64 new)
+s64 generic_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -172,9 +172,9 @@ s64 atomic64_xchg(atomic64_t *v, s64 new)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_xchg);
+EXPORT_SYMBOL(generic_atomic64_xchg);
 
-s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -188,4 +188,4 @@ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return val;
 }
-EXPORT_SYMBOL(atomic64_fetch_add_unless);
+EXPORT_SYMBOL(generic_atomic64_fetch_add_unless);
