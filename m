Return-Path: <linux-tip-commits+bounces-6592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AEB571E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719E63A91B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF732E9EB1;
	Mon, 15 Sep 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eq1z0AIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZltH/0L9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA52E2DFE;
	Mon, 15 Sep 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922527; cv=none; b=WyK2BMEGUv65h2Ytf2L5tl1cAYyORspRZJk1JzLCAVG4ByZSRAz/b1iw7zub4o4hO98gYJDVZH6oxjU8CddLG/J5RXUKZXgc88wgc3sR14hklLcJVvDGp1Bzr4hUZtdXdvWdFAjNzaNctDW7yAA1IPxPn8SOD9cctWR13ZeoyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922527; c=relaxed/simple;
	bh=T38xmd96/1Yyp8FYr6L0WpbBhdi7m9Oufiq+pA7AfMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l4bXKOos8hRUSXu4jSMXAHTQSk3SXNQC8ZCJKI3Rm6esvpa3kOHsF9XfqVe8UUI75E//1Ic9hPXMAd2xQWcslqYbLr0V1h+AW6NMqXVTvuXRfUKfodbrcm3rCgHTXaDcg7y9yximlLGk74mTDPbngXMAqPE/HQwQWh5uyLa4Qns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eq1z0AIm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZltH/0L9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPxq8gJBUkoccbSU8BbetLV9I87zbygUDiKuEXP+JGc=;
	b=Eq1z0AIm+xbc1jt4pdCPDI/0ZfZ/l/c0vlAB2yGEzDEReHBQVUfHrbSQ6tvV4YOokmHb3X
	DDeDzUtfbKCLS3NZ99mKatp2qKPKKYDXWcLxM4EquPelE9fy+Z8D5unFcaUaUVPogbgm68
	nFsKOiZSi4Eq+tKbrsErJhYSOZKM6pxPdUjI1H4Wq/cYggtoi7tuZPLwL7X5OuyOQkF0Rv
	7jIVKQ411Wmpv1fDxw4xaNWR9rfPXYcQNfJVi+lJbXm17VwqnGI9YUINX4YMKegHLC3pAB
	JDR1AlQIFTBY+x4d7rf8rbseKSvhGgSM2cClMwG0fBV3zcwoD4/lBTUOF+GLHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPxq8gJBUkoccbSU8BbetLV9I87zbygUDiKuEXP+JGc=;
	b=ZltH/0L9dnimXUmNedq75MSVgca+bZM69TDGIQoRSzmMXEoGlshZtbXU20Sqc7vEoFOYcU
	xOp0HLfWq4oVCQAA==
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
Message-ID: <175792252229.709179.10889580946359067942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     076acb647c1f448177d8b3b0e4f33de959713d7d
Gitweb:        https://git.kernel.org/tip/076acb647c1f448177d8b3b0e4f33de9597=
13d7d
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:35 +02:00

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

