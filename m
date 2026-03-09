Return-Path: <linux-tip-commits+bounces-8394-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBU7Ml4lr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8394-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:06 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F478240672
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D885307C8A9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CB413235;
	Mon,  9 Mar 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBmHtC0L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DoRX03zR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3E413255;
	Mon,  9 Mar 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085711; cv=none; b=kDtLLLgMKnUlM7XKKjRo0AI3u3+mEFUVZUW+/Iy+n6HboiYOpqnQvGSiwMdhMoNxDDAmHp3OclysbL7dsr+TthB9SM3emQW2lZG7CALfQ7QznFhT9WFEtAzO1Ry2KO+HlkO5lRL0nOzscUflDMQOaocK1djFCDyAB/ILvSvzMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085711; c=relaxed/simple;
	bh=GJ6QMg0UhHJxucbf0UOnX4Z25cQ5PdB9y//zcFN4VnE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X2VJgi1jhPAV/Phjlx8xBTAMvy3nHvSdQOpcv0RK3ZJPdydm7VnP05Hy9h7eILNCVMw/EXGI8yI/CTVU9/fx8LCUZesjGXdK9DHQ8gKvqTNMHnO1XuKgzCVGmHXNE4Vf+ka6IOY0fU49qgXOtfkwjam1E1UKuwi0rCs9ZEFo8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBmHtC0L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DoRX03zR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j4z+b8fX+OvpuLBMim0TchexIdGuAhl5nZB1htbGJk=;
	b=GBmHtC0LjB4fO16+BtU/ltDbCeJEL4qCpIqKvtAAAsYM9TpTNp2sc73F5K0t0CmHX3zi6j
	QDXR4E4N4agLUT/fO8rpb/1CBblxZlbgIqVV5G4jsIIW/hqFiwy+QCsYv9xJcn2ZQyZxT2
	cKrXoJT7zM00Hz2jDHKenkKZd8VRvlSmD9bGP80j/vOLxewPUHoB/9tiWwgMBcL7DRmOiL
	sBmLkjMDWUTV/cOG5clY92xGQJZ+5l3YjH2/+gtwci6xV2wIp/yRQ83cmQUf2aR2cRBdkg
	RdgLUe8x9XmPrAmULqbtI7KV39MEKvcyeu5p2rr0N6a4EADmxYq5vO/zHaPwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j4z+b8fX+OvpuLBMim0TchexIdGuAhl5nZB1htbGJk=;
	b=DoRX03zRrhXoNbwuZpdy/G3zgFjqnhp1uynoASgOMc1/e89RovbEBqEQ93PYAwUXpwMl0v
	XMe6/QYFTZhLboCA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add Atomic<*{mut,const} T> support
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-8-boqun@kernel.org>
References: <20260303201701.12204-8-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570691.1647592.9574946503874597412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F478240672
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8394-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,garyguo.net,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,garyguo.net:email,linutronix.de:dkim,vger.kernel.org:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ac8f06ade38a49f7725cc219fc6e90d1d4708d2b
Gitweb:        https://git.kernel.org/tip/ac8f06ade38a49f7725cc219fc6e90d1d47=
08d2b
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:55 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:49 +01:00

rust: sync: atomic: Add Atomic<*{mut,const} T> support

Atomic pointer support is an important piece of synchronization
algorithm, e.g. RCU, hence provide the support for that.

Note that instead of relying on atomic_long or the implementation of
`Atomic<usize>`, a new set of helpers (atomic_ptr_*) is introduced for
atomic pointer specifically, this is because ptr2int casting would
lose the provenance of a pointer and even though in theory there are a
few tricks the provenance can be restored, it'll still be a simpler
implementation if C could provide atomic pointers directly. The side
effects of this approach are: we don't have the arithmetic and logical
operations for pointers yet and the current implementation only works
on ARCH_SUPPORTS_ATOMIC_RMW architectures, but these are implementation
issues and can be added later.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://patch.msgid.link/20260120140503.62804-3-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-8-boqun@kernel.org
---
 rust/helpers/atomic_ext.c            |  3 ++-
 rust/kernel/sync/atomic.rs           | 12 ++++++-
 rust/kernel/sync/atomic/internal.rs  | 24 ++++++++------
 rust/kernel/sync/atomic/predefine.rs | 46 +++++++++++++++++++++++++++-
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 240218e..c267d51 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -36,6 +36,7 @@ __rust_helper void rust_helper_atomic_##tname##_set_release=
(type *ptr, type val)
=20
 GEN_READ_SET_HELPERS(i8, s8)
 GEN_READ_SET_HELPERS(i16, s16)
+GEN_READ_SET_HELPERS(ptr, const void *)
=20
 /*
  * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
@@ -59,6 +60,7 @@ rust_helper_atomic_##tname##_xchg##suffix(type *ptr, type n=
ew)			\
=20
 GEN_XCHG_HELPERS(i8, s8)
 GEN_XCHG_HELPERS(i16, s16)
+GEN_XCHG_HELPERS(ptr, const void *)
=20
 /*
  * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
@@ -82,3 +84,4 @@ rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *ptr,=
 type *old, type new)
=20
 GEN_TRY_CMPXCHG_HELPERS(i8, s8)
 GEN_TRY_CMPXCHG_HELPERS(i16, s16)
+GEN_TRY_CMPXCHG_HELPERS(ptr, const void *)
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index e262b0c..f4c3ab1 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -51,6 +51,10 @@ use ordering::OrderingType;
 #[repr(transparent)]
 pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
=20
+// SAFETY: `Atomic<T>` is safe to transfer between execution contexts becaus=
e of the safety
+// requirement of `AtomicType`.
+unsafe impl<T: AtomicType> Send for Atomic<T> {}
+
 // SAFETY: `Atomic<T>` is safe to share among execution contexts because all=
 accesses are atomic.
 unsafe impl<T: AtomicType> Sync for Atomic<T> {}
=20
@@ -68,6 +72,11 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 ///
 /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
 /// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+/// - [`Self`] must be safe to transfer between execution contexts, if it's =
[`Send`], this is
+///   automatically satisfied. The exception is pointer types that are even =
though marked as
+///   `!Send` (e.g. raw pointers and [`NonNull<T>`]) but requiring `unsafe` =
to do anything
+///   meaningful on them. This is because transferring pointer values betwee=
n execution contexts is
+///   safe as long as the actual `unsafe` dereferencing is justified.
 ///
 /// Note that this is more relaxed than requiring the bi-directional transmu=
tability (i.e.
 /// [`transmute()`] is always sound between `U` and `T`) because of the supp=
ort for atomic
@@ -108,7 +117,8 @@ unsafe impl<T: AtomicType> Sync for Atomic<T> {}
 /// [`transmute()`]: core::mem::transmute
 /// [round-trip transmutable]: AtomicType#round-trip-transmutability
 /// [Examples]: AtomicType#examples
-pub unsafe trait AtomicType: Sized + Send + Copy {
+/// [`NonNull<T>`]: core::ptr::NonNull
+pub unsafe trait AtomicType: Sized + Copy {
     /// The backing atomic implementation type.
     type Repr: AtomicImpl;
 }
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index ef516bc..e301db4 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -7,6 +7,7 @@
 use crate::bindings;
 use crate::macros::paste;
 use core::cell::UnsafeCell;
+use ffi::c_void;
=20
 mod private {
     /// Sealed trait marker to disable customized impls on atomic implementa=
tion traits.
@@ -14,10 +15,11 @@ mod private {
 }
=20
 // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t=
` and `atomic64_t`),
-// while the Rust side also layers provides atomic support for `i8` and `i16`
-// on top of lower-level C primitives.
+// while the Rust side also provides atomic support for `i8`, `i16` and `*co=
nst c_void` on top of
+// lower-level C primitives.
 impl private::Sealed for i8 {}
 impl private::Sealed for i16 {}
+impl private::Sealed for *const c_void {}
 impl private::Sealed for i32 {}
 impl private::Sealed for i64 {}
=20
@@ -26,10 +28,10 @@ impl private::Sealed for i64 {}
 /// This trait is sealed, and only types that map directly to the C side ato=
mics
 /// or can be implemented with lower-level C primitives are allowed to imple=
ment this:
 ///
-/// - `i8` and `i16` are implemented with lower-level C primitives.
+/// - `i8`, `i16` and `*const c_void` are implemented with lower-level C pri=
mitives.
 /// - `i32` map to `atomic_t`
 /// - `i64` map to `atomic64_t`
-pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
+pub trait AtomicImpl: Sized + Copy + private::Sealed {
     /// The type of the delta in arithmetic or logical operations.
     ///
     /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually =
it's the same type of
@@ -37,9 +39,9 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed=
 {
     type Delta;
 }
=20
-// The current helpers of load/store of atomic `i8` and `i16` use `{WRITE,RE=
AD}_ONCE()` hence the
-// atomicity is only guaranteed against read-modify-write operations if the =
architecture supports
-// native atomic RmW.
+// The current helpers of load/store of atomic `i8`, `i16` and pointers use =
`{WRITE,READ}_ONCE()`
+// hence the atomicity is only guaranteed against read-modify-write operatio=
ns if the architecture
+// supports native atomic RmW.
 //
 // In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn architecture pla=
ns to support Rust, the
 // load/store helpers that guarantee atomicity against RmW operations (usual=
ly via a lock) need to
@@ -58,6 +60,10 @@ impl AtomicImpl for i16 {
     type Delta =3D Self;
 }
=20
+impl AtomicImpl for *const c_void {
+    type Delta =3D isize;
+}
+
 // `atomic_t` implements atomic operations on `i32`.
 impl AtomicImpl for i32 {
     type Delta =3D Self;
@@ -269,7 +275,7 @@ macro_rules! declare_and_impl_atomic_methods {
 }
=20
 declare_and_impl_atomic_methods!(
-    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> atom=
ic64 ]
+    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, *const c_void =3D> atomic_ptr,=
 i32 =3D> atomic, i64 =3D> atomic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
@@ -287,7 +293,7 @@ declare_and_impl_atomic_methods!(
 );
=20
 declare_and_impl_atomic_methods!(
-    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> atom=
ic64 ]
+    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, *const c_void =3D> atomic_ptr,=
 i32 =3D> atomic, i64 =3D> atomic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 67a0406..6f2c605 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -4,6 +4,7 @@
=20
 use crate::static_assert;
 use core::mem::{align_of, size_of};
+use ffi::c_void;
=20
 // Ensure size and alignment requirements are checked.
 static_assert!(size_of::<bool>() =3D=3D size_of::<i8>());
@@ -28,6 +29,26 @@ unsafe impl super::AtomicType for i16 {
     type Repr =3D i16;
 }
=20
+// SAFETY:
+//
+// - `*mut T` has the same size and alignment with `*const c_void`, and is r=
ound-trip
+//   transmutable to `*const c_void`.
+// - `*mut T` is safe to transfer between execution contexts. See the safety=
 requirement of
+//   [`AtomicType`].
+unsafe impl<T: Sized> super::AtomicType for *mut T {
+    type Repr =3D *const c_void;
+}
+
+// SAFETY:
+//
+// - `*const T` has the same size and alignment with `*const c_void`, and is=
 round-trip
+//   transmutable to `*const c_void`.
+// - `*const T` is safe to transfer between execution contexts. See the safe=
ty requirement of
+//   [`AtomicType`].
+unsafe impl<T: Sized> super::AtomicType for *const T {
+    type Repr =3D *const c_void;
+}
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-t=
rip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -226,4 +247,29 @@ mod tests {
         assert_eq!(false, x.load(Relaxed));
         assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
     }
+
+    #[test]
+    fn atomic_ptr_tests() {
+        let mut v =3D 42;
+        let mut u =3D 43;
+        let x =3D Atomic::new(&raw mut v);
+
+        assert_eq!(x.load(Acquire), &raw mut v);
+        assert_eq!(x.cmpxchg(&raw mut u, &raw mut u, Relaxed), Err(&raw mut =
v));
+        assert_eq!(x.cmpxchg(&raw mut v, &raw mut u, Relaxed), Ok(&raw mut v=
));
+        assert_eq!(x.load(Relaxed), &raw mut u);
+
+        let x =3D Atomic::new(&raw const v);
+
+        assert_eq!(x.load(Acquire), &raw const v);
+        assert_eq!(
+            x.cmpxchg(&raw const u, &raw const u, Relaxed),
+            Err(&raw const v)
+        );
+        assert_eq!(
+            x.cmpxchg(&raw const v, &raw const u, Relaxed),
+            Ok(&raw const v)
+        );
+        assert_eq!(x.load(Relaxed), &raw const u);
+    }
 }

