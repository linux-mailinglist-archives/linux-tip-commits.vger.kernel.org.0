Return-Path: <linux-tip-commits+bounces-6582-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE733B5602D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C3CAC0DEB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226572ED842;
	Sat, 13 Sep 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NkZqax3+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcFYnTpz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86872ECD21;
	Sat, 13 Sep 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758542; cv=none; b=uOXiid2Pa+lvmleZMgEmD39kESXeH9CQrEOIEPNV2SQVBAoPisM2fSsYdw4t8WUt4CksiMwZFkWMuCFjkZdrkttyYRrhTG4d7lYkVrZX8z6nQtak2IM56hctQB+rtZcgsVYzpFg9UrrKcdxjpQi2TTYQsXrC5ETZY1wPjpZhFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758542; c=relaxed/simple;
	bh=88mdqUEh6o+n6/4uMqCns1Q4GTk9vEpe6+iqj8v6Fb8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HlA1dqBd6weUAkERupcOare3ISyw4U/ZUI/7JOkyoBxuRKtwC5ikbylPmZbqwjTMsyKOgMd2xDQbGwxKvThPAS3RGfF6jZYWB/a+GnUaaKapJxdodkalOFv6q005qvNbuxERPxd2v6iurx62Ymtq1RiWZk1/izrcNNWZIHUhdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NkZqax3+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcFYnTpz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbGy1dE6ESIcEgh4Tx1lQ7NgoI2GAeKRPo5f7jbMlms=;
	b=NkZqax3+YY+zFe7XKD5pnYe+mOleM7apBFYoicM4tZX/lSquXGydEHU7crJpr6N+A44RQd
	yGWZpjPnP7ZjgSQXYFxh6FEKSfScmpuIW9JyncF1w3C4ASYLVZBUpVYJzg+ZIBPqMvYXZv
	b13fvAR88fN8klgshryLaVPzfIc7o4f11V4i2RlyRhwNj27SJs6TL0gqQcxPy1KQq4hTp+
	QCn3+uLEYEJc8GBCOCBQdHRhlCFe+ZuYltJvSzk5YkSf4egwnWUiY84NuhIqySut0kHVcR
	qcHXPYDfnnyi0MK/955bikhtNaSprBPJ1YJxWc1dtH4JlJYitYmH2CgwEMVKIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbGy1dE6ESIcEgh4Tx1lQ7NgoI2GAeKRPo5f7jbMlms=;
	b=zcFYnTpzzD+weEUZpJ8nrSwdO35loBIaPo0t66S5MIEDZl3DGbt9H74wKSSSAgscU/dQs2
	SE1FSk/PZQlGDLDQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add the framework of
 arithmetic operations
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-7-boqun.feng@gmail.com>
References: <20250905044141.77868-7-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853579.709179.17514730867517325951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     08455f9b9fdc5f9b0dc8dcff5a48c0f92d13e3c9
Gitweb:        https://git.kernel.org/tip/08455f9b9fdc5f9b0dc8dcff5a48c0f92d1=
3e3c9
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:57 +02:00

rust: sync: atomic: Add the framework of arithmetic operations

One important set of atomic operations is the arithmetic operations,
i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
make senses for all the types that `AtomicType` to have arithmetic
operations, for example a `Foo(u32)` may not have a reasonable add() or
sub(), plus subword types (`u8` and `u16`) currently don't have
atomic arithmetic operations even on C side and might not have them in
the future in Rust (because they are usually suboptimal on a few
architecures). Therefore the plan is to add a few subtraits of
`AtomicType` describing which types have and can do atomic arithemtic
operations.

One trait `AtomicAdd` is added, and only add() and fetch_add() are
added. The rest will be added in the future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-7-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs           | 94 ++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs | 14 ++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4c32d12..016a6bc 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -16,7 +16,6 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-model/
=20
-#[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
 mod predefine;
@@ -25,7 +24,7 @@ pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
=20
 use crate::build_error;
-use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
+use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, Atomi=
cRepr};
 use ordering::OrderingType;
=20
 /// A memory location which can be safely modified from multiple execution c=
ontexts.
@@ -112,6 +111,19 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
     type Repr: AtomicImpl;
 }
=20
+/// Types that support atomic add operations.
+///
+/// # Safety
+///
+// TODO: Properly defines `wrapping_add` in the following comment.
+/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self:=
:rhs_into_delta()`] to
+/// any value of type `Self::Repr` obtained through transmuting a value of t=
ype `Self` to must
+/// yield a value with a bit pattern also valid for `Self`.
+pub unsafe trait AtomicAdd<Rhs =3D Self>: AtomicType {
+    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
+    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
+}
+
 #[inline(always)]
 const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
     // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip=
 transmutable to
@@ -459,3 +471,81 @@ where
         ret
     }
 }
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicArithmeticOps,
+{
+    /// Atomic add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.add(12, Relaxed);
+    ///
+    /// assert_eq!(54, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn add<Rhs>(&self, v: Rhs, _: ordering::Relaxed)
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v =3D T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_add()` due to sa=
fety requirement of
+        // `AtomicAdd`.
+        T::Repr::atomic_add(&self.0, v);
+    }
+
+    /// Atomic fetch and add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`, and returns=
 the value of `*self`
+    /// before the update.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
+    ///
+    /// let x =3D Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
+    /// ```
+    #[inline(always)]
+    pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Or=
dering) -> T
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v =3D T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_fetch_add*()` du=
e to safety requirement
+        // of `AtomicAdd`.
+        let ret =3D {
+            match Ordering::TYPE {
+                OrderingType::Full =3D> T::Repr::atomic_fetch_add(&self.0, v=
),
+                OrderingType::Acquire =3D> T::Repr::atomic_fetch_add_acquire=
(&self.0, v),
+                OrderingType::Release =3D> T::Repr::atomic_fetch_add_release=
(&self.0, v),
+                OrderingType::Relaxed =3D> T::Repr::atomic_fetch_add_relaxed=
(&self.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` p=
er type invariants.
+        unsafe { from_repr(ret) }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 33356de..a6e5883 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -8,8 +8,22 @@ unsafe impl super::AtomicType for i32 {
     type Repr =3D i32;
 }
=20
+// SAFETY: The wrapping add result of two `i32`s is a valid `i32`.
+unsafe impl super::AtomicAdd<i32> for i32 {
+    fn rhs_into_delta(rhs: i32) -> i32 {
+        rhs
+    }
+}
+
 // SAFETY: `i64` has the same size and alignment with itself, and is round-t=
rip transmutable to
 // itself.
 unsafe impl super::AtomicType for i64 {
     type Repr =3D i64;
 }
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `i64`.
+unsafe impl super::AtomicAdd<i64> for i64 {
+    fn rhs_into_delta(rhs: i64) -> i64 {
+        rhs
+    }
+}

