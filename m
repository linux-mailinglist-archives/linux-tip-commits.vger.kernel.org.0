Return-Path: <linux-tip-commits+bounces-6576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13510B5601A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3193585DB1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314A2EBBAD;
	Sat, 13 Sep 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3dEb3E4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3uTrLT1Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986726AA93;
	Sat, 13 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758534; cv=none; b=jdfc9LOPovDI0nxEsVrGL3T4lNkGetqiCYzpbPYXCxdgfN0LMvr15h2lT1S6ZZ66LgMJrsYi3+fYc5mvyD9pi8443EMLOx6M9Df01bzo6E+DMjwyji5e+zXz1mCVOfht/HrQj9Kta2IsaFtpb/DHVLCvfOLPNPe0KAqRfgIMEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758534; c=relaxed/simple;
	bh=nxBWV55hjuYQeho7d40tGQObJl5f/4KCn3JaXcTRlFE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LeehkRyVviaSlNGNDZqz9DYxijkDQEqynd1uVkRijCVP/HY8yUdg6tdQrc0ujc/Qlt9+EF804BRiTO5AenEhPbVvqcLULhbIK6SLepF4a2J1ZffiGCodUM1sWKqmqY+w7eIhXowJcqL6Ao9H0mR3YzcouKLQVEu2SdDys/eGNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3dEb3E4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3uTrLT1Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxLWaYnu6/rQeM9t/BpPCRiepG6P7wlppK61N6aPvdw=;
	b=v3dEb3E4gCmlWojj9Js6UFBSVGdUM9IvY4U3HE/UskJ7c283grGtguinOB0xiff+WDzSuh
	ZOhJjlWWStEnSmRWbCUj5hG01cdhlVj6Ax4yzubZNvzw0vr9lCYx0OYRXNHjHzS4DUxAmr
	MNK7vjGrNCfQlqR/WM0MW5zK0ZGg4/EKW+f4vfOn6UASc5n1XiPRmc6p3J52A/p4yQN3LH
	7d+W+Z/lMPsGSeBj2PmKP+2PLS+GTJyZHSqKng+NXxn7Q7Tt/ObW+RuUvlozbDEC/YT9cT
	5kdz0lEyENtqPcjY7W/jDqvLyThd29yESCp/cV9oN6qgrw2iZpFfZqpTIFEK0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxLWaYnu6/rQeM9t/BpPCRiepG6P7wlppK61N6aPvdw=;
	b=3uTrLT1ZjDI/HY9QWlRBR4St7fBR4JxyalO46+yKJQTJ8j5B/dlACPg5J9kMYCoSMb8HX8
	tyhaTvySpPDTx+Cw==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: convert `Arc` to use `Refcount`
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-13-boqun.feng@gmail.com>
References: <20250905044141.77868-13-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775852886.709179.4414569165214069527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     647a2bc75aef2c72ff33c92bbd1a909a1896b990
Gitweb:        https://git.kernel.org/tip/647a2bc75aef2c72ff33c92bbd1a909a189=
6b990
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:59 +02:00

rust: convert `Arc` to use `Refcount`

With `Refcount` type created, `Arc` can use `Refcount` instead of
calling into FFI directly.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/r/20250723233312.3304339-4-gary@kernel.org
---
 rust/kernel/sync/arc.rs | 45 ++++++++++++----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4ee155b..9298993 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -8,7 +8,7 @@
 //! threads.
 //!
 //! It is different from the standard library's [`Arc`] in a few ways:
-//! 1. It is backed by the kernel's `refcount_t` type.
+//! 1. It is backed by the kernel's [`Refcount`] type.
 //! 2. It does not support weak references, which allows it to be half the s=
ize.
 //! 3. It saturates the reference count instead of aborting when it goes ove=
r a threshold.
 //! 4. It does not provide a `get_mut` method, so the ref counted object is =
pinned.
@@ -18,11 +18,11 @@
=20
 use crate::{
     alloc::{AllocError, Flags, KBox},
-    bindings,
     ffi::c_void,
     init::InPlaceInit,
+    sync::Refcount,
     try_init,
-    types::{ForeignOwnable, Opaque},
+    types::ForeignOwnable,
 };
 use core::{
     alloc::Layout,
@@ -145,7 +145,7 @@ pub struct Arc<T: ?Sized> {
 #[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
-    refcount: Opaque<bindings::refcount_t>,
+    refcount: Refcount,
     data: T,
 }
=20
@@ -157,7 +157,7 @@ impl<T: ?Sized> ArcInner<T> {
     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`=
], and the `Arc` must
     /// not yet have been destroyed.
     unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
-        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
+        let refcount_layout =3D Layout::new::<Refcount>();
         // SAFETY: The caller guarantees that the pointer is valid.
         let val_layout =3D Layout::for_value(unsafe { &*ptr });
         // SAFETY: We're computing the layout of a real struct that existed =
when compiling this
@@ -229,8 +229,7 @@ impl<T> Arc<T> {
     pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value =3D ArcInner {
-            // SAFETY: There are no safety requirements for this FFI call.
-            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            refcount: Refcount::new(1),
             data: contents,
         };
=20
@@ -348,18 +347,13 @@ impl<T: ?Sized> Arc<T> {
         // We will manually manage the refcount in this method, so we disabl=
e the destructor.
         let this =3D ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount =3D unsafe { this.ptr.as_ref() }.refcount.get();
+        let refcount =3D unsafe { &this.ptr.as_ref().refcount };
=20
         // If the refcount reaches a non-zero value, then we have destroyed =
this `Arc` and will
         // return without further touching the `Arc`. If the refcount reache=
s zero, then there are
         // no other arcs, and we can create a `UniqueArc`.
-        //
-        // SAFETY: We own a refcount, so the pointer is not dangling.
-        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcount) };
-        if is_zero {
-            // SAFETY: We have exclusive access to the arc, so we can perfor=
m unsynchronized
-            // accesses to the refcount.
-            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) =
};
+        if refcount.dec_and_test() {
+            refcount.set(1);
=20
             // INVARIANT: We own the only refcount to this arc, so we may cr=
eate a `UniqueArc`. We
             // must pin the `UniqueArc` because the values was previously in=
 an `Arc`, and they pin
@@ -456,14 +450,10 @@ impl<T: ?Sized> Borrow<T> for Arc<T> {
=20
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
-        // SAFETY: By the type invariant, there is necessarily a reference t=
o the object, so it is
-        // safe to dereference it.
-        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
-
-        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot =
overflow to zero.
+        // INVARIANT: `Refcount` saturates the refcount, so it cannot overfl=
ow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference t=
o the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(refcount) };
+        unsafe { self.ptr.as_ref() }.refcount.inc();
=20
         // SAFETY: We just incremented the refcount. This increment is now o=
wned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -472,16 +462,10 @@ impl<T: ?Sized> Clone for Arc<T> {
=20
 impl<T: ?Sized> Drop for Arc<T> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant, there is necessarily a reference t=
o the object. We cannot
-        // touch `refcount` after it's decremented to a non-zero value becau=
se another thread/CPU
-        // may concurrently decrement it to zero and free it. It is ok to ha=
ve a raw pointer to
-        // freed/invalid memory as long as it is never dereferenced.
-        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
-
         // INVARIANT: If the refcount reaches zero, there are no other insta=
nces of `Arc`, and
         // this instance is being dropped, so the broken invariant is not ob=
servable.
-        // SAFETY: Also by the type invariant, we are allowed to decrement t=
he refcount.
-        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refcount) };
+        // SAFETY: By the type invariant, there is necessarily a reference t=
o the object.
+        let is_zero =3D unsafe { self.ptr.as_ref() }.refcount.dec_and_test();
         if is_zero {
             // The count reached zero, we must free the memory.
             //
@@ -775,8 +759,7 @@ impl<T> UniqueArc<T> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let inner =3D KBox::try_init::<AllocError>(
             try_init!(ArcInner {
-                // SAFETY: There are no safety requirements for this FFI cal=
l.
-                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                refcount: Refcount::new(1),
                 data <- pin_init::uninit::<T, AllocError>(),
             }? AllocError),
             flags,

