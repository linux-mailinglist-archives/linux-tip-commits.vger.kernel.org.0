Return-Path: <linux-tip-commits+bounces-7802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F3DCF4908
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B049300D806
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991D346AEF;
	Mon,  5 Jan 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poxrJrbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQGSjAgy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8F3446C6;
	Mon,  5 Jan 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628472; cv=none; b=skQ8Ntfp6zWs8H6pP8oQHdrmdSe6YKKVuVbhyfOI6R0tiL/zVNz/Bmtpcizg3JL2TCBl4BsRTkYeBdXvv3t6b4Jw6va62kUPlbu+RaO6VPmkOLoZbCLzlS34cxYr5irAir6d6ZEAruV8uemeIAvVY6ZijsIdvJk/UD/JeW7y7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628472; c=relaxed/simple;
	bh=lv8rLgcsJZYcZcqdgd+1bf1sPnBcGWPeSqe9+XqNE1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EyrWktdOOCSDNQBUubk6Z3BJHDOXWysed7NIRHM/iaNu9E4jE6mgs7vhl23sk5eWyy5cYuajqerYZLZRRjuq33kcajHbyQbb3kIC0VGzp4FaD0cRgkW3ipJqDQsZsLoPCKXtOF9vbdF7NbRGULLJZ58NZv7ca6e8X/jXuXZwV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poxrJrbL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQGSjAgy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2Tl8hg6hl4XSjwl72wlR0dzL7ExsdiuaJ3KV/gwCSI=;
	b=poxrJrbLbYgj936rSD6zMUdrlaa8Og262L5XZLooNeEbcthOemnnZQHOPsfLCJWveTCpkk
	/HOVGtbXG+N2jMOPxQt0FjNpyi2MqxCX3hvmJv+s1UmKunZFAUEwZw9+HAZzBB1Qt/EzOU
	S4chTyMq3nLo78Ecgda46OpJfdYQI7SYAvnNEkJo+wP06WomMLZqIzqiBKyxzi3fN+TUcR
	9K4Itafbzs2InhLY+mzKxDoAOA1usiWC7EN91m4ojA+vuM+7Q+wP3yuCT1Fjb2cN9i5SUb
	KmAuDagirFxFhIOHNdmLFH76vYvCbadLF/PYE5kWHArgf5pIx7/CCJ7a8U2drw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2Tl8hg6hl4XSjwl72wlR0dzL7ExsdiuaJ3KV/gwCSI=;
	b=GQGSjAgycHJ3JN8T9a91TiSRlhb6/DgkPWEap5lYbs2qQq3SEG3Ye7UUVTE3Wc2e9nCH7d
	QaY2Gr1RkLoU2CDw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/ww_mutex: Support Clang's context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-21-elver@google.com>
References: <20251219154418.3592607-21-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846721.510.10844517504028035961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     47907461e4f6fcdce8cf91dd164369192deeb7c4
Gitweb:        https://git.kernel.org/tip/47907461e4f6fcdce8cf91dd164369192de=
eb7c4
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:32 +01:00

locking/ww_mutex: Support Clang's context analysis

Add support for Clang's context analysis for ww_mutex.

The programming model for ww_mutex is subtly more complex than other
locking primitives when using ww_acquire_ctx. Encoding the respective
pre-conditions for ww_mutex lock/unlock based on ww_acquire_ctx state
using Clang's context analysis makes incorrect use of the API harder.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-21-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst |  3 +-
 include/linux/ww_mutex.h                     | 22 ++++--
 lib/test_context-analysis.c                  | 69 +++++++++++++++++++-
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index a48b75f..8dd6c0d 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -80,7 +80,8 @@ Supported Kernel Primitives
=20
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`.
+`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`,
+`ww_mutex`.
=20
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 45ff6f7..58e959e 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -44,7 +44,7 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
=20
-struct ww_mutex {
+context_lock_struct(ww_mutex) {
 	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
 #ifdef DEBUG_WW_MUTEXES
@@ -52,7 +52,7 @@ struct ww_mutex {
 #endif
 };
=20
-struct ww_acquire_ctx {
+context_lock_struct(ww_acquire_ctx) {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned int acquired;
@@ -107,6 +107,7 @@ struct ww_acquire_ctx {
  */
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
+	__assumes_ctx_lock(lock)
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx =3D NULL;
@@ -141,6 +142,7 @@ static inline void ww_mutex_init(struct ww_mutex *lock,
  */
 static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 				   struct ww_class *ww_class)
+	__acquires(ctx) __no_context_analysis
 {
 	ctx->task =3D current;
 	ctx->stamp =3D atomic_long_inc_return_relaxed(&ww_class->stamp);
@@ -179,6 +181,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx =
*ctx,
  * data structures.
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
+	__releases(ctx) __acquires_shared(ctx) __no_context_analysis
 {
 #ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
@@ -196,6 +199,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx =
*ctx)
  * mutexes have been released with ww_mutex_unlock.
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
+	__releases_shared(ctx) __no_context_analysis
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
@@ -245,7 +249,8 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx =
*ctx)
  *
  * A mutex acquired with this function must be released with ww_mutex_unlock.
  */
-extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww=
_acquire_ctx *ctx);
+extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww=
_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx);
=20
 /**
  * ww_mutex_lock_interruptible - acquire the w/w mutex, interruptible
@@ -278,7 +283,8 @@ extern int /* __must_check */ ww_mutex_lock(struct ww_mut=
ex *lock, struct ww_acq
  * A mutex acquired with this function must be released with ww_mutex_unlock.
  */
 extern int __must_check ww_mutex_lock_interruptible(struct ww_mutex *lock,
-						    struct ww_acquire_ctx *ctx);
+						    struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx);
=20
 /**
  * ww_mutex_lock_slow - slowpath acquiring of the w/w mutex
@@ -305,6 +311,7 @@ extern int __must_check ww_mutex_lock_interruptible(struc=
t ww_mutex *lock,
  */
 static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+	__acquires(lock) __must_hold(ctx) __no_context_analysis
 {
 	int ret;
 #ifdef DEBUG_WW_MUTEXES
@@ -342,6 +349,7 @@ ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acqui=
re_ctx *ctx)
 static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx)
 {
 #ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
@@ -349,10 +357,11 @@ ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 	return ww_mutex_lock_interruptible(lock, ctx);
 }
=20
-extern void ww_mutex_unlock(struct ww_mutex *lock);
+extern void ww_mutex_unlock(struct ww_mutex *lock) __releases(lock);
=20
 extern int __must_check ww_mutex_trylock(struct ww_mutex *lock,
-					 struct ww_acquire_ctx *ctx);
+					 struct ww_acquire_ctx *ctx)
+	__cond_acquires(true, lock) __must_hold(ctx);
=20
 /***
  * ww_mutex_destroy - mark a w/w mutex unusable
@@ -363,6 +372,7 @@ extern int __must_check ww_mutex_trylock(struct ww_mutex =
*lock,
  * this function is called.
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
+	__must_not_hold(lock)
 {
 #ifndef CONFIG_PREEMPT_RT
 	mutex_destroy(&lock->base);
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 003e64c..2dc4044 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -14,6 +14,7 @@
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
+#include <linux/ww_mutex.h>
=20
 /*
  * Test that helper macros work as expected.
@@ -531,3 +532,71 @@ static void __used test_local_trylock(void)
 		local_unlock(&test_local_trylock_data.lock);
 	}
 }
+
+static DEFINE_WD_CLASS(ww_class);
+
+struct test_ww_mutex_data {
+	struct ww_mutex mtx;
+	int counter __guarded_by(&mtx);
+};
+
+static void __used test_ww_mutex_init(struct test_ww_mutex_data *d)
+{
+	ww_mutex_init(&d->mtx, &ww_class);
+	d->counter =3D 0;
+}
+
+static void __used test_ww_mutex_lock_noctx(struct test_ww_mutex_data *d)
+{
+	if (!ww_mutex_lock(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (!ww_mutex_lock_interruptible(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (ww_mutex_trylock(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	ww_mutex_lock_slow(&d->mtx, NULL);
+	d->counter++;
+	ww_mutex_unlock(&d->mtx);
+
+	ww_mutex_destroy(&d->mtx);
+}
+
+static void __used test_ww_mutex_lock_ctx(struct test_ww_mutex_data *d)
+{
+	struct ww_acquire_ctx ctx;
+
+	ww_acquire_init(&ctx, &ww_class);
+
+	if (!ww_mutex_lock(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (!ww_mutex_lock_interruptible(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (ww_mutex_trylock(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	ww_mutex_lock_slow(&d->mtx, &ctx);
+	d->counter++;
+	ww_mutex_unlock(&d->mtx);
+
+	ww_acquire_done(&ctx);
+	ww_acquire_fini(&ctx);
+
+	ww_mutex_destroy(&d->mtx);
+}

