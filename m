Return-Path: <linux-tip-commits+bounces-6591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC1B571E3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730C07A1419
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79E2E6116;
	Mon, 15 Sep 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTI724Q4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RPxyHa+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C542E041A;
	Mon, 15 Sep 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922526; cv=none; b=TMgueqKyxgbZtSzyZTqMd/EzViDDw841JHGrh5pda3MCsqbQqwdtlxH99jIc3lqcrJHETje+qy2ubVR2A4MYu2fAV+PjGgMqQJFIPgKIcMXOB9gbWFQ009hJfk5ESPvu4CSq5OmLA0jp9l5461MLJfMYdzm4/wb7z/nJmWpSBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922526; c=relaxed/simple;
	bh=51dccBwdPSRTz6q4sFa+49LotoasLRNuKtUJhiVLyV4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hGtkh37uPu3D5wI7UBqgjRFwaJWFA22dPqHyET87qIchuUI+bKtT65iRyge3reqUWziizwEKFAY1dSMN0fqtcDRdcRPpvhmhoWCoswL6zZ3oFwj3oSpNgAS2qbxKHD47zMoua7iz4zyKM11A70Wfm4NZeJPH+r7IjsfNkuOo3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTI724Q4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RPxyHa+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCpH3L097q/f039KafJoV/0YbTAqWA72yF21vqSoafU=;
	b=bTI724Q4I8nhYw4CVQSyIGCfY/aTDkyfhoF5q7jWhVibAIGTtivg1ms+Igf41HXyuE6Thw
	/cXy37vJmqvWvxQuUo/dWnTmL5ZZaqrIAWcQNlHNOQULT2IYjhgLoaWeUbinSVmq9n5fEz
	3f4uWrV5Nm+dtZLGWEyBATuWTaVpzfS84K8BVO7O4f66hzZn9AeVrjLtNQARoGRPph87w9
	YeEFYiSZguzrkjZXogqM68tXUrBVXHy2kutLEaYngrInfVKZ71spOW1vyAkjKPB+TLMtSI
	NjX4wlU82hh0I9H432t9gPObaIUUFndl/3mLua0K443beBLav7ZvRB/X1Q9gyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCpH3L097q/f039KafJoV/0YbTAqWA72yF21vqSoafU=;
	b=4RPxyHa+cC2gD0dVX9vzBWYBEgQOsknr1xkwMm7o6EzoBjBittKuxv3pYwMksQDiSo2n35
	IpnXU4F5sRzxYMDQ==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: block: convert `block::mq` to use `Refcount`
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>,
 Andreas Hindborg <a.hindborg@kernel.org>, David Gow <davidgow@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-14-boqun.feng@gmail.com>
References: <20250905044141.77868-14-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175792252125.709179.3290923038275803349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a307bf1db5448eccd72a1d7857f7661c6330d5ad
Gitweb:        https://git.kernel.org/tip/a307bf1db5448eccd72a1d7857f7661c633=
0d5ad
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:36 +02:00

rust: block: convert `block::mq` to use `Refcount`

Currently there's a custom reference counting in `block::mq`, which uses
`AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
architectures. We cannot just change it to use 32-bit atomics, because
doing so will make it vulnerable to refcount overflow. So switch it to
use the kernel refcount `kernel::sync::Refcount` instead.

There is an operation needed by `block::mq`, atomically decreasing
refcount from 2 to 0, which is not available through refcount.h, so
I exposed `Refcount::as_atomic` which allows accessing the refcount
directly.

[boqun: Adopt the LKMM atomic API]
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-5-gary@kernel.org
---
 rust/kernel/block/mq/operations.rs |  7 +--
 rust/kernel/block/mq/request.rs    | 73 ++++++++---------------------
 rust/kernel/sync/refcount.rs       | 15 ++++++-
 3 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operat=
ions.rs
index c2b98f5..c0f95a9 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,9 +10,10 @@ use crate::{
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
+    sync::Refcount,
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Order=
ing};
+use core::marker::PhantomData;
=20
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
         let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
=20
         // One refcount for the ARef, one for being in flight
-        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+        request.wrapper_ref().refcount().set(2);
=20
         // SAFETY:
         //  - We own a refcount that we took above. We pass that to `ARef`.
@@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
=20
             // SAFETY: The refcount field is allocated but not initialized, =
so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(At=
omicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Re=
fcount::new(0)) };
=20
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394..f62a376 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,13 +8,10 @@ use crate::{
     bindings,
     block::mq::Operations,
     error::Result,
+    sync::{atomic::Relaxed, Refcount},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{
-    marker::PhantomData,
-    ptr::NonNull,
-    sync::atomic::{AtomicU64, Ordering},
-};
+use core::{marker::PhantomData, ptr::NonNull};
=20
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO requ=
est.
 ///
@@ -37,6 +34,9 @@ use core::{
 /// We need to track 3 and 4 to ensure that it is safe to end the request an=
d hand
 /// back ownership to the block layer.
 ///
+/// Note that the driver can still obtain new `ARef` even if there is no `AR=
ef`s in existence by
+/// using `tag_to_rq`, hence the need to distinguish B and C.
+///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of t=
he C
 /// [`struct request`].
@@ -98,13 +98,16 @@ impl<T: Operations> Request<T> {
     ///
     /// [`struct request`]: srctree/include/linux/blk-mq.h
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<=
Self>> {
-        // We can race with `TagSet::tag_to_rq`
-        if let Err(_old) =3D this.wrapper_ref().refcount().compare_exchange(
-            2,
-            0,
-            Ordering::Relaxed,
-            Ordering::Relaxed,
-        ) {
+        // To hand back the ownership, we need the current refcount to be 2.
+        // Since we can race with `TagSet::tag_to_rq`, this needs to atomica=
lly reduce
+        // refcount to 0. `Refcount` does not provide a way to do this, so u=
se the underlying
+        // atomics directly.
+        if let Err(_old) =3D this
+            .wrapper_ref()
+            .refcount()
+            .as_atomic()
+            .cmpxchg(2, 0, Relaxed)
+        {
             return Err(this);
         }
=20
@@ -173,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no [`AR=
ef`] references to it.
     /// - 2+: There are [`ARef`] references to the request.
-    refcount: AtomicU64,
+    refcount: Refcount,
 }
=20
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &Refcount {
         &self.refcount
     }
=20
@@ -189,7 +192,7 @@ impl RequestDataWrapper {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Se=
lf`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { &raw mut (*this).refcount }
@@ -205,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
=20
-/// Store the result of `op(target.load())` in target, returning new value of
-/// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> =
u64 {
-    let old =3D target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x=
| Some(op(x)));
-
-    // SAFETY: Because the operation passed to `fetch_update` above always
-    // return `Some`, `old` will always be `Ok`.
-    let old =3D unsafe { old.unwrap_unchecked() };
-
-    op(old)
-}
-
-/// Store the result of `op(target.load)` in `target` if `target.load() !=3D
-/// pred`, returning [`true`] if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pre=
d: u64) -> bool {
-    target
-        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
-            if x =3D=3D pred {
-                None
-            } else {
-                Some(op(x))
-            }
-        })
-        .is_ok()
-}
-
 // SAFETY: All instances of `Request<T>` are reference counted. This
 // implementation of `AlwaysRefCounted` ensure that increments to the ref co=
unt
 // keeps the object alive in memory at least until a matching reference count
 // decrement is executed.
 unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
     fn inc_ref(&self) {
-        let refcount =3D &self.wrapper_ref().refcount();
-
-        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let updated =3D atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
-
-        #[cfg(CONFIG_DEBUG_MISC)]
-        if !updated {
-            panic!("Request refcount zero on clone")
-        }
+        self.wrapper_ref().refcount().inc();
     }
=20
     unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
@@ -257,10 +226,10 @@ unsafe impl<T: Operations> AlwaysRefCounted for Request=
<T> {
         let refcount =3D unsafe { &*RequestDataWrapper::refcount_ptr(wrapper=
_ptr) };
=20
         #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let new_refcount =3D atomic_relaxed_op_return(refcount, |x| x - 1);
+        let is_zero =3D refcount.dec_and_test();
=20
         #[cfg(CONFIG_DEBUG_MISC)]
-        if new_refcount =3D=3D 0 {
+        if is_zero {
             panic!("Request reached refcount zero in Rust abstractions");
         }
     }
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index cc1a80a..19236a5 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -5,6 +5,7 @@
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
=20
 use crate::build_assert;
+use crate::sync::atomic::Atomic;
 use crate::types::Opaque;
=20
 /// Atomic reference counter.
@@ -34,6 +35,20 @@ impl Refcount {
         self.0.get()
     }
=20
+    /// Get the underlying atomic counter that backs the refcount.
+    ///
+    /// NOTE: Usage of this function is discouraged as it can circumvent the=
 protections offered by
+    /// `refcount.h`. If there is no way to achieve the result using APIs in=
 `refcount.h`, then
+    /// this function can be used. Otherwise consider adding a binding for t=
he required API.
+    #[inline]
+    pub fn as_atomic(&self) -> &Atomic<i32> {
+        let ptr =3D self.0.get().cast();
+        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, whic=
h is an atomic 32-bit
+        // integer that is layout-wise compatible with `Atomic<i32>`. All va=
lues are valid for
+        // `refcount_t`, despite some of the values being considered saturat=
ed and "bad".
+        unsafe { &*ptr }
+    }
+
     /// Set a refcount's value.
     #[inline]
     pub fn set(&self, value: i32) {

