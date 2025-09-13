Return-Path: <linux-tip-commits+bounces-6583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC804B5602A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D01B2092F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0F2EDD43;
	Sat, 13 Sep 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33BxbPVF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="72pvMUgU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81E2ECE8A;
	Sat, 13 Sep 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758543; cv=none; b=UQr3W7R1GnPJun+0MsMz0myD+G8VtZxj27gLcDXttrZT8608nhfmpuoJ3nPJeQpdXiADnRwBIl0EhyrkqIgwc7yalLYm8GjKFye4JLtg+bPySGe2RZBbyk+QDq81QNZHGt5iiGYjB//v9xKstifiriXck9lga/ioD9gPgSEkfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758543; c=relaxed/simple;
	bh=Y+6zx9eKccITlBfW2RbFBJz2A878KvqC7JTsorpsWI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m+v3kKC5X/ejeLgTrP2SBNMFhvAUJ9rioUdyhlzXsxudXCFEmvQI70vTM0yrpot7IaJM7tg/xChCBCcL9X5M3gSxenAWUv+k5rqbApXChwbUlS1u8zr4SdtAtSPeLBYe7KmmRT25HG1EBYcp5KYStPoWVh+b0nRbq9Zt0r/kJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33BxbPVF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=72pvMUgU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wakzdS3YaxYuv2JdWXszXNL7hFiI7fwIV+XcLxWgYXc=;
	b=33BxbPVF2tOHA5ldThg1+qQticiDIuSKD0sXs1p5Ip66jVKa2e9SfyD+To55COgji6s7c4
	I12bXtnp8VLLAuPMA9mVy7DHKzbuqHPv4EtaUS2Na33kooACTdD4tX89doS7l658vxZohb
	R936MCiI/ov5BbknOyR1miQS1wSOQaJVFXMc0yZ/FkQUx8tCdi9KXzEaWuasuUGH0Bubbv
	gKBO6pOuLkmO/T5wmkHk5n/DwGKNC5YsFH9CLGxbnRMcnnenhZZvgDHT/G4ldNL6Pen/TE
	pu+IQSOzEdx3bBUTBYpl9FgzaCkCS3+OQptBAvcxLIjnG3IuDs5U6TrZOHbckw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wakzdS3YaxYuv2JdWXszXNL7hFiI7fwIV+XcLxWgYXc=;
	b=72pvMUgUT9gAq1jqiedywVsD8Ms0F1ZQ3qq2iWGa3u/hmq+IZyvMPf+zDTC0YTDjiTc5zN
	KzIfFpBwcVtoUQDQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add atomic {cmp,}xchg operations
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-6-boqun.feng@gmail.com>
References: <20250905044141.77868-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853698.709179.14072036445280545000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e7e5ca105dd6156ef494f5ca71f4a0fc37813f05
Gitweb:        https://git.kernel.org/tip/e7e5ca105dd6156ef494f5ca71f4a0fc378=
13f05
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:57 +02:00

rust: sync: atomic: Add atomic {cmp,}xchg operations

xchg() and cmpxchg() are basic operations on atomic. Provide these based
on C APIs.

Note that cmpxchg() use the similar function signature as
compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
the operation succeeds and `Err(old)` means the operation fails.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-6-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs | 168 +++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index ea5782b..4c32d12 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -25,7 +25,7 @@ pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
=20
 use crate::build_error;
-use internal::{AtomicBasicOps, AtomicRepr};
+use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
 use ordering::OrderingType;
=20
 /// A memory location which can be safely modified from multiple execution c=
ontexts.
@@ -293,3 +293,169 @@ where
         }
     }
 }
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicExchangeOps,
+{
+    /// Atomic exchange.
+    ///
+    /// Atomically updates `*self` to `v` and returns the old value of `*sel=
f`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.xchg(52, Acquire));
+    /// assert_eq!(52, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
+    #[inline(always)]
+    pub fn xchg<Ordering: ordering::Ordering>(&self, v: T, _: Ordering) -> T=
 {
+        let v =3D into_repr(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_xchg*()` because=
 `v` is transmutable to
+        // `T`.
+        let ret =3D {
+            match Ordering::TYPE {
+                OrderingType::Full =3D> T::Repr::atomic_xchg(&self.0, v),
+                OrderingType::Acquire =3D> T::Repr::atomic_xchg_acquire(&sel=
f.0, v),
+                OrderingType::Release =3D> T::Repr::atomic_xchg_release(&sel=
f.0, v),
+                OrderingType::Relaxed =3D> T::Repr::atomic_xchg_relaxed(&sel=
f.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `*self`, which is a valid `T` pe=
r type invariants.
+        unsafe { from_repr(ret) }
+    }
+
+    /// Atomic compare and exchange.
+    ///
+    /// If `*self` =3D=3D `old`, atomically updates `*self` to `new`. Otherw=
ise, `*self` is not
+    /// modified.
+    ///
+    /// Compare: The comparison is done via the byte level comparison betwee=
n `*self` and `old`.
+    ///
+    /// Ordering: When succeeds, provides the corresponding ordering as the =
`Ordering` type
+    /// parameter indicates, and a failed one doesn't provide any ordering, =
the load part of a
+    /// failed cmpxchg is a [`Relaxed`] load.
+    ///
+    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed t=
o be equal to `old`,
+    /// otherwise returns `Err(value)`, and `value` is the current value of =
`*self`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42);
+    ///
+    /// // Checks whether cmpxchg succeeded.
+    /// let success =3D x.cmpxchg(52, 64, Relaxed).is_ok();
+    /// # assert!(!success);
+    ///
+    /// // Checks whether cmpxchg failed.
+    /// let failure =3D x.cmpxchg(52, 64, Relaxed).is_err();
+    /// # assert!(failure);
+    ///
+    /// // Uses the old value if failed, probably re-try cmpxchg.
+    /// match x.cmpxchg(52, 64, Relaxed) {
+    ///     Ok(_) =3D> { },
+    ///     Err(old) =3D> {
+    ///         // do something with `old`.
+    ///         # assert_eq!(old, 42);
+    ///     }
+    /// }
+    ///
+    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
+    /// let latest =3D x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
+    /// # assert_eq!(42, latest);
+    /// assert_eq!(64, x.load(Relaxed));
+    /// ```
+    ///
+    /// [`Relaxed`]: ordering::Relaxed
+    #[doc(alias(
+        "atomic_cmpxchg",
+        "atomic64_cmpxchg",
+        "atomic_try_cmpxchg",
+        "atomic64_try_cmpxchg",
+        "compare_exchange"
+    ))]
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: ordering::Ordering>(
+        &self,
+        mut old: T,
+        new: T,
+        o: Ordering,
+    ) -> Result<T, T> {
+        // Note on code generation:
+        //
+        // try_cmpxchg() is used to implement cmpxchg(), and if the helper f=
unctions are inlined,
+        // the compiler is able to figure out that branch is not needed if t=
he users don't care
+        // about whether the operation succeeds or not. One exception is on =
x86, due to commit
+        // 44fe84459faf ("locking/atomic: Fix atomic_try_cmpxchg() semantics=
"), the
+        // atomic_try_cmpxchg() on x86 has a branch even if the caller doesn=
't care about the
+        // success of cmpxchg and only wants to use the old value. For examp=
le, for code like:
+        //
+        //     let latest =3D x.cmpxchg(42, 64, Full).unwrap_or_else(|old| o=
ld);
+        //
+        // It will still generate code:
+        //
+        //     movl    $0x40, %ecx
+        //     movl    $0x34, %eax
+        //     lock
+        //     cmpxchgl        %ecx, 0x4(%rsp)
+        //     jne     1f
+        //     2:
+        //     ...
+        //     1:  movl    %eax, %ecx
+        //     jmp 2b
+        //
+        // This might be "fixed" by introducing a try_cmpxchg_exclusive() th=
at knows the "*old"
+        // location in the C function is always safe to write.
+        if self.try_cmpxchg(&mut old, new, o) {
+            Ok(old)
+        } else {
+            Err(old)
+        }
+    }
+
+    /// Atomic compare and exchange and returns whether the operation succee=
ds.
+    ///
+    /// If `*self` =3D=3D `old`, atomically updates `*self` to `new`. Otherw=
ise, `*self` is not
+    /// modified, `*old` is updated to the current value of `*self`.
+    ///
+    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg()`].
+    ///
+    /// Returns `true` means the cmpxchg succeeds otherwise returns `false`.
+    #[inline(always)]
+    fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T,=
 _: Ordering) -> bool {
+        let mut tmp =3D into_repr(*old);
+        let new =3D into_repr(new);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_try_cmpxchg*()` =
because `new` is
+        // transmutable to `T`.
+        let ret =3D {
+            match Ordering::TYPE {
+                OrderingType::Full =3D> T::Repr::atomic_try_cmpxchg(&self.0,=
 &mut tmp, new),
+                OrderingType::Acquire =3D> {
+                    T::Repr::atomic_try_cmpxchg_acquire(&self.0, &mut tmp, n=
ew)
+                }
+                OrderingType::Release =3D> {
+                    T::Repr::atomic_try_cmpxchg_release(&self.0, &mut tmp, n=
ew)
+                }
+                OrderingType::Relaxed =3D> {
+                    T::Repr::atomic_try_cmpxchg_relaxed(&self.0, &mut tmp, n=
ew)
+                }
+            }
+        };
+
+        // SAFETY: `tmp` comes from reading `*self`, which is a valid `T` pe=
r type invariants.
+        *old =3D unsafe { from_repr(tmp) };
+
+        ret
+    }
+}

