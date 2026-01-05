Return-Path: <linux-tip-commits+bounces-7800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9CCF48ED
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DDFE3009D5A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFB346AC2;
	Mon,  5 Jan 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2MJ/10S1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iL6hWm1r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B73469F8;
	Mon,  5 Jan 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628470; cv=none; b=r8NA/5F3xC7zAy2XGy3jLRPU6B/vVyysP3yF/CJmL59UQz3YKlu8SUltVSlWsFsg6mSmXgwFv8xuGAWQ7TNKbPH9wgrLVle6fwdkeO7MN7CSSg3+47w5Uwr6N5dCalrZd+yJGc0rowrvoLSU88THKh47HCxO2rsQyr/Vf2b78H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628470; c=relaxed/simple;
	bh=n2tJJn+XDb73o09CuTXi3RThRZnzb4J/EiSvLMfgnYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nU/5qPESj9aZRCjgYInU600CZ7CRzA5Sw3LxrMzmdQLuMgheTPqPoBnJkfSPqpuA/hVx1hMvFYl6RIKTXW7U7DvrpXkV4KfbF3i9E26XB24ZNrvXf3G2gyCaKl1fr64H3pP3fFE49EStWCILU09esuQGU6fAKpsG+B59xKG7D1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2MJ/10S1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iL6hWm1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwmWYTD2LFIleN2qFtUxk89SFiLtRNstRsVKKkjKuYQ=;
	b=2MJ/10S1/+ce5yS6ix2ofRhAxtx3cVFijD9YhdzWJQ+PVFt3gcnEBG8RxQgnz/5DtLe5St
	wC8GTFnKXU48phX8gEQRZ+FzO7Qav8XgjxCGgtB4ZAwRROsct8V18IWKVs+C/sDwGePCg8
	SjkwEuozyrO4G1LVc2PxhuDbq9Qc4LUG+UNFGfroSV37JZVzsAtCBn6yeIvRDmWVbVU2Et
	AOeHpijiTjxZGZfUBJZ19p/kzOWkUvenQEXfUutkVxPc9E/OPSgaofmP3mzu0Cd+AdU3d+
	VeH8H0F/YEETaL5N4H6ovFpQLicB2eesjfHGUz2rL947UOYl1PCzAhuqIuhJZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwmWYTD2LFIleN2qFtUxk89SFiLtRNstRsVKKkjKuYQ=;
	b=iL6hWm1r0Y/ssHtnM+9DcH7s5uAfsGFmJu7EyUNWggiEEf9mwJslyY6DpliK1os0iFvxrK
	O7PexmbLj1IvrNBA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Remove Sparse support
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-24-elver@google.com>
References: <20251219154418.3592607-24-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846423.510.9250031195168306802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5b63d0ae94ccfd64dcbdb693d88eb3650eb3c64c
Gitweb:        https://git.kernel.org/tip/5b63d0ae94ccfd64dcbdb693d88eb3650eb=
3c64c
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:33 +01:00

compiler-context-analysis: Remove Sparse support

Remove Sparse support as discussed at [1].

The kernel codebase is still scattered with numerous places that try to
appease Sparse's context tracking ("annotation for sparse", "fake out
sparse", "work around sparse", etc.). Eventually, as more subsystems
enable Clang's context analysis, these places will show up and need
adjustment or removal of the workarounds altogether.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250207083335.GW7145@noisy.programming.kic=
ks-ass.net/ [1]
Link: https://lore.kernel.org/all/Z6XTKTo_LMj9KmbY@elver.google.com/ [2]
Link: https://patch.msgid.link/20251219154418.3592607-24-elver@google.com
---
 Documentation/dev-tools/sparse.rst        | 19 +-----
 include/linux/compiler-context-analysis.h | 85 ++++++----------------
 include/linux/rcupdate.h                  | 15 +----
 3 files changed, 28 insertions(+), 91 deletions(-)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/spa=
rse.rst
index dc791c8..37b2017 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -53,25 +53,6 @@ sure that bitwise types don't get mixed up (little-endian =
vs big-endian
 vs cpu-endian vs whatever), and there the constant "0" really _is_
 special.
=20
-Using sparse for lock checking
-------------------------------
-
-The following macros are undefined for gcc and defined during a sparse
-run to use the "context" tracking feature of sparse, applied to
-locking.  These annotations tell sparse when a lock is held, with
-regard to the annotated function's entry and exit.
-
-__must_hold - The specified lock is held on function entry and exit.
-
-__acquires - The specified lock is held on function exit, but not entry.
-
-__releases - The specified lock is held on function entry, but not exit.
-
-If the function enters and exits without the lock held, acquiring and
-releasing the lock inside the function in a balanced way, no
-annotation is needed.  The three annotations above are for cases where
-sparse would otherwise report a context imbalance.
-
 Getting sparse
 --------------
=20
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index a6a3498..cb72882 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -262,57 +262,32 @@ static inline void _context_unsafe_alias(void **p) { }
 	extern const struct __ctx_lock_##ctx *name
=20
 /*
- * Common keywords for static context analysis. Both Clang's "capability
- * analysis" and Sparse's "context tracking" are currently supported.
- */
-#ifdef __CHECKER__
-
-/* Sparse context/lock checking support. */
-# define __must_hold(x)		__attribute__((context(x,1,1)))
-# define __must_not_hold(x)
-# define __acquires(x)		__attribute__((context(x,0,1)))
-# define __cond_acquires(ret, x) __attribute__((context(x,0,-1)))
-# define __releases(x)		__attribute__((context(x,1,0)))
-# define __acquire(x)		__context__(x,1)
-# define __release(x)		__context__(x,-1)
-# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
-/* For Sparse, there's no distinction between exclusive and shared locks. */
-# define __must_hold_shared	__must_hold
-# define __acquires_shared	__acquires
-# define __cond_acquires_shared __cond_acquires
-# define __releases_shared	__releases
-# define __acquire_shared	__acquire
-# define __release_shared	__release
-# define __cond_lock_shared	__cond_acquire
-
-#else /* !__CHECKER__ */
+ * Common keywords for static context analysis.
+ */
=20
 /**
  * __must_hold() - function attribute, caller must hold exclusive context lo=
ck
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * lock instance @x exclusively.
+ * lock instance(s) exclusively.
  */
-# define __must_hold(x)		__requires_ctx_lock(x)
+#define __must_hold(...)	__requires_ctx_lock(__VA_ARGS__)
=20
 /**
  * __must_not_hold() - function attribute, caller must not hold context lock
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must not hold the given cont=
ext
- * lock instance @x.
+ * lock instance(s).
  */
-# define __must_not_hold(x)	__excludes_ctx_lock(x)
+#define __must_not_hold(...)	__excludes_ctx_lock(__VA_ARGS__)
=20
 /**
  * __acquires() - function attribute, function acquires context lock exclusi=
vely
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function acquires the given context
- * lock instance @x exclusively, but does not release it.
+ * lock instance(s) exclusively, but does not release them.
  */
-# define __acquires(x)		__acquires_ctx_lock(x)
+#define __acquires(...)		__acquires_ctx_lock(__VA_ARGS__)
=20
 /*
  * Clang's analysis does not care precisely about the value, only that it is
@@ -339,17 +314,16 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
+#define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
=20
 /**
  * __releases() - function attribute, function releases a context lock exclu=
sively
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * lock instance @x exclusively. The associated context must be active on
+ * lock instance(s) exclusively. The associated context(s) must be active on
  * entry.
  */
-# define __releases(x)		__releases_ctx_lock(x)
+#define __releases(...)		__releases_ctx_lock(__VA_ARGS__)
=20
 /**
  * __acquire() - function to acquire context lock exclusively
@@ -357,7 +331,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that acquires the given context lock instance @x exclusive=
ly.
  */
-# define __acquire(x)		__acquire_ctx_lock(x)
+#define __acquire(x)		__acquire_ctx_lock(x)
=20
 /**
  * __release() - function to release context lock exclusively
@@ -365,7 +339,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that releases the given context lock instance @x.
  */
-# define __release(x)		__release_ctx_lock(x)
+#define __release(x)		__release_ctx_lock(x)
=20
 /**
  * __cond_lock() - function that conditionally acquires a context lock
@@ -383,25 +357,23 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
  */
-# define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
+#define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
=20
 /**
  * __must_hold_shared() - function attribute, caller must hold shared contex=
t lock
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * lock instance @x with shared access.
+ * lock instance(s) with shared access.
  */
-# define __must_hold_shared(x)	__requires_shared_ctx_lock(x)
+#define __must_hold_shared(...)	__requires_shared_ctx_lock(__VA_ARGS__)
=20
 /**
  * __acquires_shared() - function attribute, function acquires context lock =
shared
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function acquires the given
- * context lock instance @x with shared access, but does not release it.
+ * context lock instance(s) with shared access, but does not release them.
  */
-# define __acquires_shared(x)	__acquires_shared_ctx_lock(x)
+#define __acquires_shared(...)	__acquires_shared_ctx_lock(__VA_ARGS__)
=20
 /**
  * __cond_acquires_shared() - function attribute, function conditionally
@@ -410,23 +382,22 @@ static inline void _context_unsafe_alias(void **p) { }
  * @x: context lock instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given context lock instance @x with shared access, but does not release i=
t. The
- * function return value @ret denotes when the context lock is acquired.
+ * given context lock instance @x with shared access, but does not release i=
t.
+ * The function return value @ret denotes when the context lock is acquired.
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _share=
d)
+#define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _shared)
=20
 /**
  * __releases_shared() - function attribute, function releases a
  *                       context lock shared
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * lock instance @x with shared access. The associated context must be active
- * on entry.
+ * lock instance(s) with shared access. The associated context(s) must be
+ * active on entry.
  */
-# define __releases_shared(x)	__releases_shared_ctx_lock(x)
+#define __releases_shared(...)	__releases_shared_ctx_lock(__VA_ARGS__)
=20
 /**
  * __acquire_shared() - function to acquire context lock shared
@@ -435,7 +406,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that acquires the given context lock instance @x with shar=
ed
  * access.
  */
-# define __acquire_shared(x)	__acquire_shared_ctx_lock(x)
+#define __acquire_shared(x)	__acquire_shared_ctx_lock(x)
=20
 /**
  * __release_shared() - function to release context lock shared
@@ -444,7 +415,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that releases the given context lock instance @x with shar=
ed
  * access.
  */
-# define __release_shared(x)	__release_shared_ctx_lock(x)
+#define __release_shared(x)	__release_shared_ctx_lock(x)
=20
 /**
  * __cond_lock_shared() - function that conditionally acquires a context loc=
k shared
@@ -457,9 +428,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * shared access, if the boolean expression @c is true. The result of @c is =
the
  * return value.
  */
-# define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
-
-#endif /* __CHECKER__ */
+#define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
=20
 /**
  * __acquire_ret() - helper to acquire context lock of return value
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 50e63ea..d828a46 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1219,20 +1219,7 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_call=
back_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
=20
-DEFINE_LOCK_GUARD_0(rcu,
-	do {
-		rcu_read_lock();
-		/*
-		 * sparse doesn't call the cleanup function,
-		 * so just release immediately and don't track
-		 * the context. We don't need to anyway, since
-		 * the whole point of the guard is to not need
-		 * the explicit unlock.
-		 */
-		__release(RCU);
-	} while (0),
-	rcu_read_unlock())
-
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RC=
U))
=20
 #endif /* __LINUX_RCUPDATE_H */

