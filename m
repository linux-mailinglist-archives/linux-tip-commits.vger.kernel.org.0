Return-Path: <linux-tip-commits+bounces-6602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCBB571F9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED29A18941DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3E2EC54B;
	Mon, 15 Sep 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jlBjDTZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egXrlKUT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BF2DF6EA;
	Mon, 15 Sep 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922538; cv=none; b=pNpNlPZ3G0HzKgtpIIeXI353d0Tsk7/cMUYztVC/iuod3r34UomFzP69b0am99KSpugiZrlgzLZ8pgO3ObmI/xWGN5ISf53a8YBEqW5p4Lf/eHhzmn7MOBGfFLmfWcGNv6/wVUrNMCm5HF2QTCeemA09gKezpC/ePXqo5+6bYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922538; c=relaxed/simple;
	bh=ZE5/F1zW/nAzehIsmfgrGt9F7IAjfKusaPVY5Y1kjfE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fJjHuduq6A6ofKtSRgEyiviujGbJE7gdAEGNEy0pM+35XE0s2YNbrD8pxP48xOxLTOPAVQqI/waznyTVOR9h69sG1wrJWZwe1dVfpYdc8n0L/cqSRF6qgSbJbtv4YQT3WH6pC0idE6WniPbGHcT/WDkn4P8oo1/TyfK9FUgpXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jlBjDTZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egXrlKUT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZcwu/5NeM/qYSK3vXH0FFps9gIsOCIgXt6Ld2/4Qfk=;
	b=jlBjDTZ3kaxQT51ER/9LMtWSjc/46ScyEOSz9paw4FlzwphpwquXSDJfWf/hlXzk5PYIQo
	BLnneAfF9jR+5FJgefscbqAYVCafvqxAyj6qr3Kv1n/veL9g3pzo29hIIASnT4INQrMFp5
	fIgmKuhLJFDkWAduHLLyQr15d+/NXv3W9cVBbSJTJBjGzDXJxAImXEB6xhKunggyVWus9o
	syLMrTSUqlNbB2w/crgXLB9EbU7yVsjYAZJyCjpgSXd52VLKoA6YmAuxNqnsBFA2wZXlPs
	NRA1LPCI0FjuiMOUbVWgZIDE72itr3UnTg/35EOGe7vnLT2r4vuH14W1juG86g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZcwu/5NeM/qYSK3vXH0FFps9gIsOCIgXt6Ld2/4Qfk=;
	b=egXrlKUTbmlu/PPtMRsGECf9g28Tc8uOdE4nsttt3NXBvuZm+iUy4dpxvQ0+v+VI52an/E
	kuTV92IduMCycWCw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: Add basic atomic operation mapping framework
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-3-boqun.feng@gmail.com>
References: <20250905044141.77868-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175792253327.709179.9580782011832496070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2387fb2a9b84950dfe2eaa0b170f429e04b38168
Gitweb:        https://git.kernel.org/tip/2387fb2a9b84950dfe2eaa0b170f429e04b=
38168
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:32 +02:00

rust: sync: Add basic atomic operation mapping framework

Preparation for generic atomic implementation. To unify the
implementation of a generic method over `i32` and `i64`, the C side
atomic methods need to be grouped so that in a generic method, they can
be referred as <type>::<method>, otherwise their parameters and return
value are different between `i32` and `i64`, which would require using
`transmute()` to unify the type into a `T`.

Introduce `AtomicImpl` to represent a basic type in Rust that has the
direct mapping to an atomic implementation from C. Use a sealed trait to
restrict `AtomicImpl` to only support `i32` and `i64` for now.

Further, different methods are put into different `*Ops` trait groups,
and this is for the future when smaller types like `i8`/`i16` are
supported but only with a limited set of API (e.g. only set(), load(),
xchg() and cmpxchg(), no add() or sub() etc).

While the atomic mod is introduced, documentation is also added for
memory models and data races.

Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
my responsibility on the Rust atomic mod.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-3-boqun.feng@gmail.com/
---
 MAINTAINERS                         |   4 +-
 rust/kernel/sync.rs                 |   1 +-
 rust/kernel/sync/atomic.rs          |  22 ++-
 rust/kernel/sync/atomic/internal.rs | 265 +++++++++++++++++++++++++++-
 4 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/internal.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55..538778b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3990,7 +3990,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -3999,6 +3999,8 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/kernel/sync/atomic.rs
+F:	rust/kernel/sync/atomic/
=20
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 00f9b55..7e962e5 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@ use pin_init;
=20
 mod arc;
 pub mod aref;
+pub mod atomic;
 pub mod completion;
 mod condvar;
 pub mod lock;
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
new file mode 100644
index 0000000..b9f2f47
--- /dev/null
+++ b/rust/kernel/sync/atomic.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic primitives.
+//!
+//! These primitives have the same semantics as their C counterparts: and th=
e precise definitions of
+//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consi=
stency) Model is the
+//! only model for Rust code in kernel, and Rust's own atomics should be avo=
ided.
+//!
+//! # Data races
+//!
+//! [`LKMM`] atomics have different rules regarding data races:
+//!
+//! - A normal write from C side is treated as an atomic write if
+//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=3Dy.
+//! - Mixed-size atomic accesses don't cause data races.
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+#[allow(dead_code, unreachable_pub)]
+mod internal;
+
+pub use internal::AtomicImpl;
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
new file mode 100644
index 0000000..6fdd8e5
--- /dev/null
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic internal implementations.
+//!
+//! Provides 1:1 mapping to the C atomic operations.
+
+use crate::bindings;
+use crate::macros::paste;
+use core::cell::UnsafeCell;
+
+mod private {
+    /// Sealed trait marker to disable customized impls on atomic implementa=
tion traits.
+    pub trait Sealed {}
+}
+
+// `i32` and `i64` are only supported atomic implementations.
+impl private::Sealed for i32 {}
+impl private::Sealed for i64 {}
+
+/// A marker trait for types that implement atomic operations with C side pr=
imitives.
+///
+/// This trait is sealed, and only types that have directly mapping to the C=
 side atomics should
+/// impl this:
+///
+/// - `i32` maps to `atomic_t`.
+/// - `i64` maps to `atomic64_t`.
+pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
+    /// The type of the delta in arithmetic or logical operations.
+    ///
+    /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually =
it's the same type of
+    /// [`Self`], but it may be different for the atomic pointer type.
+    type Delta;
+}
+
+// `atomic_t` implements atomic operations on `i32`.
+impl AtomicImpl for i32 {
+    type Delta =3D Self;
+}
+
+// `atomic64_t` implements atomic operations on `i64`.
+impl AtomicImpl for i64 {
+    type Delta =3D Self;
+}
+
+/// Atomic representation.
+#[repr(transparent)]
+pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>);
+
+impl<T: AtomicImpl> AtomicRepr<T> {
+    /// Creates a new atomic representation `T`.
+    pub const fn new(v: T) -> Self {
+        Self(UnsafeCell::new(v))
+    }
+
+    /// Returns a pointer to the underlying `T`.
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is valid and properly aligned (i.e. aligned to =
[`align_of::<T>()`]).
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: `self.0` is an `UnsafeCell<T>`, therefore the pointer =
returned by `.get()`
+        // must be valid and properly aligned.
+        self.0.get()
+    }
+}
+
+// This macro generates the function signature with given argument list and =
return type.
+macro_rules! declare_atomic_method {
+    (
+        $(#[doc=3D$doc:expr])*
+        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
+    ) =3D> {
+        paste!(
+            $(#[doc =3D $doc])*
+            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
+        );
+    };
+    (
+        $(#[doc=3D$doc:expr])*
+        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $=
ret:ty)?
+    ) =3D> {
+        paste!(
+            declare_atomic_method!(
+                $(#[doc =3D $doc])*
+                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
+            );
+        );
+
+        declare_atomic_method!(
+            $(#[doc =3D $doc])*
+            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
+        );
+    };
+    (
+        $(#[doc=3D$doc:expr])*
+        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) =3D> {
+        declare_atomic_method!(
+            $(#[doc =3D $doc])*
+            $func($($arg_sig)*) $(-> $ret)?
+        );
+    }
+}
+
+// This macro generates the function implementation with given argument list=
 and return type, and it
+// will replace "call(...)" expression with "$ctype _ $func" to call the rea=
l C function.
+macro_rules! impl_atomic_method {
+    (
+        ($ctype:ident) $func:ident($($arg:ident: $arg_type:ty),*) $(-> $ret:=
ty)? {
+            $unsafe:tt { call($($c_arg:expr),*) }
+        }
+    ) =3D> {
+        paste!(
+            #[inline(always)]
+            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
+                // TODO: Ideally we want to use the SAFETY comments written =
at the macro invocation
+                // (e.g. in `declare_and_impl_atomic_methods!()`, however, s=
ince SAFETY comments
+                // are just comments, and they are not passed to macros as t=
okens, therefore we
+                // cannot use them here. One potential improvement is that i=
f we support using
+                // attributes as an alternative for SAFETY comments, then we=
 can use that for macro
+                // generating code.
+                //
+                // SAFETY: specified on macro invocation.
+                $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[$variant:ident $($rest:ident)*]($($arg_si=
g:tt)*) $(-> $ret:ty)? {
+            $unsafe:tt { call($($arg:tt)*) }
+        }
+    ) =3D> {
+        paste!(
+            impl_atomic_method!(
+                ($ctype) [< $func _ $variant >]($($arg_sig)*) $( -> $ret)? {
+                    $unsafe { call($($arg)*) }
+            }
+            );
+        );
+        impl_atomic_method!(
+            ($ctype) $func [$($rest)*]($($arg_sig)*) $( -> $ret)? {
+                $unsafe { call($($arg)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[]($($arg_sig:tt)*) $( -> $ret:ty)? {
+            $unsafe:tt { call($($arg:tt)*) }
+        }
+    ) =3D> {
+        impl_atomic_method!(
+            ($ctype) $func($($arg_sig)*) $(-> $ret)? {
+                $unsafe { call($($arg)*) }
+            }
+        );
+    }
+}
+
+// Delcares $ops trait with methods and implements the trait for `i32` and `=
i64`.
+macro_rules! declare_and_impl_atomic_methods {
+    ($(#[$attr:meta])* $pub:vis trait $ops:ident {
+        $(
+            $(#[doc=3D$doc:expr])*
+            fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret=
:ty)? {
+                $unsafe:tt { bindings::#call($($arg:tt)*) }
+            }
+        )*
+    }) =3D> {
+        $(#[$attr])*
+        $pub trait $ops: AtomicImpl {
+            $(
+                declare_atomic_method!(
+                    $(#[doc=3D$doc])*
+                    $func[$($variant)*]($($arg_sig)*) $(-> $ret)?
+                );
+            )*
+        }
+
+        impl $ops for i32 {
+            $(
+                impl_atomic_method!(
+                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        $unsafe { call($($arg)*) }
+                    }
+                );
+            )*
+        }
+
+        impl $ops for i64 {
+            $(
+                impl_atomic_method!(
+                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)?=
 {
+                        $unsafe { call($($arg)*) }
+                    }
+                );
+            )*
+        }
+    }
+}
+
+declare_and_impl_atomic_methods!(
+    /// Basic atomic operations
+    pub trait AtomicBasicOps {
+        /// Atomic read (load).
+        fn read[acquire](a: &AtomicRepr<Self>) -> Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast()) }
+        }
+
+        /// Atomic set (store).
+        fn set[release](a: &AtomicRepr<Self>, v: Self) {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), v) }
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Exchange and compare-and-exchange atomic operations
+    pub trait AtomicExchangeOps {
+        /// Atomic exchange.
+        ///
+        /// Atomically updates `*a` to `v` and returns the old value.
+        fn xchg[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self) ->=
 Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), v) }
+        }
+
+        /// Atomic compare and exchange.
+        ///
+        /// If `*a` =3D=3D `*old`, atomically updates `*a` to `new`. Otherwi=
se, `*a` is not
+        /// modified, `*old` is updated to the current value of `*a`.
+        ///
+        /// Return `true` if the update of `*a` occurred, `false` otherwise.
+        fn try_cmpxchg[acquire, release, relaxed](
+            a: &AtomicRepr<Self>, old: &mut Self, new: Self
+        ) -> bool {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned. `core::pt=
r::from_mut(old)`
+            // is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), core::ptr::from_mut(=
old), new) }
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Atomic arithmetic operations
+    pub trait AtomicArithmeticOps {
+        /// Atomic add (wrapping).
+        ///
+        /// Atomically updates `*a` to `(*a).wrapping_add(v)`.
+        fn add[](a: &AtomicRepr<Self>, v: Self::Delta) {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(v, a.as_ptr().cast()) }
+        }
+
+        /// Atomic fetch and add (wrapping).
+        ///
+        /// Atomically updates `*a` to `(*a).wrapping_add(v)`, and returns t=
he value of `*a`
+        /// before the update.
+        fn fetch_add[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Sel=
f::Delta) -> Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(v, a.as_ptr().cast()) }
+        }
+    }
+);

