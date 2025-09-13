Return-Path: <linux-tip-commits+bounces-6584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1BB5602F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B1F1B252BE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9F2EDD73;
	Sat, 13 Sep 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cl/jZFPj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpAXfVWe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF52ED14C;
	Sat, 13 Sep 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758544; cv=none; b=dWDIsQWdJZ4byLtDm1aS80ZMaiWmbBkpzXb8ygcYlb6W1I59JFLvIvpLX7nWLP3j4LNJUh9HljRvSkkhngr1NhYk4dKyTNQvKK4qgKTBzpwDpqBoNXsQcgj0r+hmER5hgLlxXcurqisssPNhkKl+IdAB55lXeUf72l1gsOfJd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758544; c=relaxed/simple;
	bh=kdRNfHTuWVirH6kTYE7dFgKFBJ9NHEERmuyRlf0UKaM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q9TaNb79EyugiR7o+D5N4FUTHEzCF5J1+uU97fB5MrZpu21OZit5xh3zZvJI8wFM8E3D+M4Sm4ZWJI8ablLxu22YfaIhhCuwyq0DgjcUyBRveFX2XvQHHOWyz3wCf/E1TJbiKmOx9iM6Xvjl3syIGiwmBOEJ7NS+HLSfm1FFZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cl/jZFPj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpAXfVWe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqi2GkG7aWkQhuyvphkPP4QtY0hq+eEoPOoSWLZw3jM=;
	b=cl/jZFPjNKDWSHH2sCkqu59CHMeWnl7XwupaHc2r7+a5fj9Lm7+I9wBNOwVb4m1sDfxLHu
	ngAIRBCbTDapzzykyaYfCXTU05Hpm8MJUKslMtQNdTQxa1h+9EPtXM8Pr4JjyEEeMv62YI
	dsOxnNEsY4ljjPzv5B1Yc+fvzhVWTLckmVpvhiDNGR+H+QkUUwrXcxH72j53pAXP/cheGq
	wI1DhvqyjD3HXp4x1y1fDXQJGI/nDeHSa+Du6+xJpsY9wS/uBjki6+hbajxBXiRMYN3fYL
	quMe0yZVNgLIVBMdNx9QWSRUjogMZKor4k6WHkdYtJhnqxwSnJtYKznyR88Edw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqi2GkG7aWkQhuyvphkPP4QtY0hq+eEoPOoSWLZw3jM=;
	b=HpAXfVWeSOU8FHzb9XCdsJhSynbYAI99Pw2ZMGmoBTsYshyYOIdxueaftF5ehRh9GpDbR8
	jfvYbgrG57QZc4Dw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add generic atomics
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-5-boqun.feng@gmail.com>
References: <20250905044141.77868-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853811.709179.6167711108082458152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0b8c5b7a6459ba697bcafdcb865560cea7235cef
Gitweb:        https://git.kernel.org/tip/0b8c5b7a6459ba697bcafdcb865560cea72=
35cef
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:56 +02:00

rust: sync: atomic: Add generic atomics

To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
added, currently `T` needs to be Send + Copy because these are the
straightforward usages and all basic types support this.

Implement `AtomicType` for `i32` and `i64`, and so far only basic
operations load() and store() are introduced.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-5-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs           | 271 ++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs |  15 +-
 2 files changed, 286 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/predefine.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 2302e6d..ea5782b 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -19,6 +19,277 @@
 #[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
+mod predefine;
=20
 pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+use crate::build_error;
+use internal::{AtomicBasicOps, AtomicRepr};
+use ordering::OrderingType;
+
+/// A memory location which can be safely modified from multiple execution c=
ontexts.
+///
+/// This has the same size, alignment and bit validity as the underlying typ=
e `T`. And it disables
+/// niche optimization for the same reason as [`UnsafeCell`].
+///
+/// The atomic operations are implemented in a way that is fully compatible =
with the [Linux Kernel
+/// Memory (Consistency) Model][LKMM], hence they should be modeled as the c=
orresponding
+/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`=
] and
+/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomi=
c operations]
+/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE=
_ONCE()`,
+/// `smp_load_acquire()` and `smp_store_release()`).
+///
+/// # Invariants
+///
+/// `self.0` is a valid `T`.
+///
+/// [`UnsafeCell`]: core::cell::UnsafeCell
+/// [LKMM]: srctree/tools/memory-model/
+/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
+#[repr(transparent)]
+pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
+
+// SAFETY: `Atomic<T>` is safe to share among execution contexts because all=
 accesses are atomic.
+unsafe impl<T: AtomicType> Sync for Atomic<T> {}
+
+/// Types that support basic atomic operations.
+///
+/// # Round-trip transmutability
+///
+/// `T` is round-trip transmutable to `U` if and only if both of these prope=
rties hold:
+///
+/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
+/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` an=
d then to `T` again
+///   yields a value that is in all aspects equivalent to the original value.
+///
+/// # Safety
+///
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+///
+/// Note that this is more relaxed than requiring the bi-directional transmu=
tability (i.e.
+/// [`transmute()`] is always sound between `U` and `T`) because of the supp=
ort for atomic
+/// variables over unit-only enums, see [Examples].
+///
+/// # Limitations
+///
+/// Because C primitives are used to implement the atomic operations, and a =
C function requires a
+/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence a=
t the Rust <-> C
+/// surface, only types with all the bits initialized can be passed. As a re=
sult, types like `(u8,
+/// u16)` (padding bytes are uninitialized) are currently not supported.
+///
+/// # Examples
+///
+/// A unit-only enum that implements [`AtomicType`]:
+///
+/// ```
+/// use kernel::sync::atomic::{AtomicType, Atomic, Relaxed};
+///
+/// #[derive(Clone, Copy, PartialEq, Eq)]
+/// #[repr(i32)]
+/// enum State {
+///     Uninit =3D 0,
+///     Working =3D 1,
+///     Done =3D 2,
+/// };
+///
+/// // SAFETY: `State` and `i32` has the same size and alignment, and it's r=
ound-trip
+/// // transmutable to `i32`.
+/// unsafe impl AtomicType for State {
+///     type Repr =3D i32;
+/// }
+///
+/// let s =3D Atomic::new(State::Uninit);
+///
+/// assert_eq!(State::Uninit, s.load(Relaxed));
+/// ```
+/// [`transmute()`]: core::mem::transmute
+/// [round-trip transmutable]: AtomicType#round-trip-transmutability
+/// [Examples]: AtomicType#examples
+pub unsafe trait AtomicType: Sized + Send + Copy {
+    /// The backing atomic implementation type.
+    type Repr: AtomicImpl;
+}
+
+#[inline(always)]
+const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
+    // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip=
 transmutable to
+    // `T::Repr`, therefore the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&v) }
+}
+
+/// # Safety
+///
+/// `r` must be a valid bit pattern of `T`.
+#[inline(always)]
+const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
+    // SAFETY: Per the safety requirement of the function, the transmute ope=
ration is sound.
+    unsafe { core::mem::transmute_copy(&r) }
+}
+
+impl<T: AtomicType> Atomic<T> {
+    /// Creates a new atomic `T`.
+    pub const fn new(v: T) -> Self {
+        // INVARIANT: Per the safety requirement of `AtomicType`, `into_repr=
(v)` is a valid `T`.
+        Self(AtomicRepr::new(into_repr(v)))
+    }
+
+    /// Creates a reference to an atomic `T` from a pointer of `T`.
+    ///
+    /// This usually is used when communicating with C side or manipulating =
a C struct, see
+    /// examples below.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` is aligned to `align_of::<T>()`.
+    /// - `ptr` is valid for reads and writes for `'a`.
+    /// - For the duration of `'a`, other accesses to `*ptr` must not cause =
data races (defined
+    ///   by [`LKMM`]) against atomic operations on the returned reference. =
Note that if all other
+    ///   accesses are atomic, then this safety requirement is trivially ful=
filled.
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    ///
+    /// # Examples
+    ///
+    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`A=
tomic::store()`] can
+    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()`=
 or
+    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
+    ///
+    /// ```
+    /// # use kernel::types::Opaque;
+    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
+    ///
+    /// // Assume there is a C struct `foo`.
+    /// mod cbindings {
+    ///     #[repr(C)]
+    ///     pub(crate) struct foo {
+    ///         pub(crate) a: i32,
+    ///         pub(crate) b: i32
+    ///     }
+    /// }
+    ///
+    /// let tmp =3D Opaque::new(cbindings::foo { a: 1, b: 2 });
+    ///
+    /// // struct foo *foo_ptr =3D ..;
+    /// let foo_ptr =3D tmp.get();
+    ///
+    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
+    /// let foo_a_ptr =3D unsafe { &raw mut (*foo_ptr).a };
+    ///
+    /// // a =3D READ_ONCE(foo_ptr->a);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses on =
it is atomic, so no
+    /// // data race.
+    /// let a =3D unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
+    /// # assert_eq!(a, 1);
+    ///
+    /// // smp_store_release(&foo_ptr->a, 2);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other accesses o=
n it is atomic, so
+    /// // no data race.
+    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
+    /// ```
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
+    where
+        T: Sync,
+    {
+        // CAST: `T` and `Atomic<T>` have the same size, alignment and bit v=
alidity.
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer=
 and the object will
+        // live long enough. It's safe to return a `&Atomic<T>` because func=
tion safety requirement
+        // guarantees other accesses won't cause data races.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns a pointer to the underlying atomic `T`.
+    ///
+    /// Note that use of the return pointer must not cause data races define=
d by [`LKMM`].
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is valid and properly aligned (i.e. aligned to =
[`align_of::<T>()`]).
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    /// [`align_of::<T>()`]: core::mem::align_of
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: Per the function guarantee of `AtomicRepr::as_ptr()`, =
the `self.0.as_ptr()`
+        // must be a valid and properly aligned pointer for `T::Repr`, and p=
er the safety guarantee
+        // of `AtomicType`, it's a valid and properly aligned pointer of `T`.
+        self.0.as_ptr().cast()
+    }
+
+    /// Returns a mutable reference to the underlying atomic `T`.
+    ///
+    /// This is safe because the mutable reference of the atomic `T` guarant=
ees exclusive access.
+    pub fn get_mut(&mut self) -> &mut T {
+        // CAST: `T` and `T::Repr` has the same size and alignment per the s=
afety requirement of
+        // `AtomicType`, and per the type invariants `self.0` is a valid `T`=
, therefore the casting
+        // result is a valid pointer of `T`.
+        // SAFETY: The pointer is valid per the CAST comment above, and the =
mutable reference
+        // guarantees exclusive access.
+        unsafe { &mut *self.0.as_ptr().cast() }
+    }
+}
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    /// Loads the value from the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// let x =3D Atomic::new(42i64);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_read", "atomic64_read"))]
+    #[inline(always)]
+    pub fn load<Ordering: ordering::AcquireOrRelaxed>(&self, _: Ordering) ->=
 T {
+        let v =3D {
+            match Ordering::TYPE {
+                OrderingType::Relaxed =3D> T::Repr::atomic_read(&self.0),
+                OrderingType::Acquire =3D> T::Repr::atomic_read_acquire(&sel=
f.0),
+                _ =3D> build_error!("Wrong ordering"),
+            }
+        };
+
+        // SAFETY: `v` comes from reading `self.0`, which is a valid `T` per=
 the type invariants.
+        unsafe { from_repr(v) }
+    }
+
+    /// Stores a value to the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.store(43, Relaxed);
+    ///
+    /// assert_eq!(43, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_set", "atomic64_set"))]
+    #[inline(always)]
+    pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Order=
ing) {
+        let v =3D into_repr(v);
+
+        // INVARIANT: `v` is a valid `T`, and is stored to `self.0` by `atom=
ic_set*()`.
+        match Ordering::TYPE {
+            OrderingType::Relaxed =3D> T::Repr::atomic_set(&self.0, v),
+            OrderingType::Release =3D> T::Repr::atomic_set_release(&self.0, =
v),
+            _ =3D> build_error!("Wrong ordering"),
+        }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
new file mode 100644
index 0000000..33356de
--- /dev/null
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Pre-defined atomic types
+
+// SAFETY: `i32` has the same size and alignment with itself, and is round-t=
rip transmutable to
+// itself.
+unsafe impl super::AtomicType for i32 {
+    type Repr =3D i32;
+}
+
+// SAFETY: `i64` has the same size and alignment with itself, and is round-t=
rip transmutable to
+// itself.
+unsafe impl super::AtomicType for i64 {
+    type Repr =3D i64;
+}

