Return-Path: <linux-tip-commits+bounces-6580-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B08B5601F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917AB16B045
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8F2EC573;
	Sat, 13 Sep 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0A24r+Y5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="579dEiuL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAB2EC0AF;
	Sat, 13 Sep 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758538; cv=none; b=HiusaaDgjwf0WPh25inztpq3IO0lv/CGCzqtmj8VIRi1kBZo3UcOeNBzwaRfJKi5OmaF0pdBVNtshzEw6NpFeDdbvSEVRIRLtuZXParyPWM32nKeRIvd/J8nBumPcdBEU+fURjD7sFbGUyy+9PVLFdCsYbldxNeX0EFn/hofcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758538; c=relaxed/simple;
	bh=WSMaLDdOYpZGLdZ0kY9ZokOIlILCPqgyg4NP7N7vGsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mVIwQJv4gFdInQ62KX0ZD5N0bSvrCrTE9kTIYsjiHeCvgwkTKBrkfKz+ChmQh091j2oSyGhcRqzgwwjW1+J+RO07wPeGDVm0ymMfqyJD6n6KCvMbLUW8hemtmFreR5jHR6J4AX9gmQW9ZVHvjM2FZg2jRPBfd5ru57VrR42BE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0A24r+Y5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=579dEiuL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNxIofOXDh0omJbsLSE6EGzhg9hfsujBWePxPo3Miwg=;
	b=0A24r+Y5lvuvKD2TNUdj5/skNLQmU+BTgR2AgkGsOC8LiUT913Uk6Qb21FhGubV5Wlr+vr
	oaQSr6Uy0nvAtAdNi9MRCOeHQJ9kYvnPqGim66J7rY8roJURkvUbU1A3ISqrpmvrYoJ/3K
	u33nQA2BvAe8K+CIh9+4d3NvdZo8lWP8KIdpP/PT4yblYWMvZY23DXJTkg9EI3FseBSFZJ
	A2dIwDT1WnBcjgchGIkDOeeIcSfCucDze5SWkEKDQlod6k80wbMO8x7mY2/1VFS8LVJJwL
	bCxfy/Dxq1czVcwLiy/vPOTQSm9MaRiSQPPrGBm6xT7POqClHHdm46BooVGNQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNxIofOXDh0omJbsLSE6EGzhg9hfsujBWePxPo3Miwg=;
	b=579dEiuLDmRxeiHJMPajow7FUj0k7vuyEJcCMfkJtgMUXnXZsyWz21/NS2v4WqOGVmkPf/
	/A0Gf22+KeiQqjDA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add Atomic<{usize,isize}>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-9-boqun.feng@gmail.com>
References: <20250905044141.77868-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853344.709179.11140241381449108544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c0231e3023da14fa5549fbb21fec1820520a6eeb
Gitweb:        https://git.kernel.org/tip/c0231e3023da14fa5549fbb21fec1820520=
a6eeb
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:58 +02:00

rust: sync: atomic: Add Atomic<{usize,isize}>

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AtomicType::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available. To do so,
an internal type `isize_atomic_repr` is defined, it's `i32` in 32bit
kernel and `i64` in 64bit kernel.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-9-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic/predefine.rs | 53 ++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index d087581..45a1798 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,6 +2,9 @@
=20
 //! Pre-defined atomic types
=20
+use crate::static_assert;
+use core::mem::{align_of, size_of};
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-t=
rip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -28,6 +31,35 @@ unsafe impl super::AtomicAdd<i64> for i64 {
     }
 }
=20
+// Defines an internal type that always maps to the integer type which has t=
he same size alignment
+// as `isize` and `usize`, and `isize` and `usize` are always bi-directional=
 transmutable to
+// `isize_atomic_repr`, which also always implements `AtomicImpl`.
+#[allow(non_camel_case_types)]
+#[cfg(not(CONFIG_64BIT))]
+type isize_atomic_repr =3D i32;
+#[allow(non_camel_case_types)]
+#[cfg(CONFIG_64BIT)]
+type isize_atomic_repr =3D i64;
+
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<isize>() =3D=3D size_of::<isize_atomic_repr>());
+static_assert!(align_of::<isize>() =3D=3D align_of::<isize_atomic_repr>());
+static_assert!(size_of::<usize>() =3D=3D size_of::<isize_atomic_repr>());
+static_assert!(align_of::<usize>() =3D=3D align_of::<isize_atomic_repr>());
+
+// SAFETY: `isize` has the same size and alignment with `isize_atomic_repr`,=
 and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for isize {
+    type Repr =3D isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `u=
size`.
+unsafe impl super::AtomicAdd<isize> for isize {
+    fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is rou=
nd-trip transmutable to
 // `i32`.
 unsafe impl super::AtomicType for u32 {
@@ -54,6 +86,19 @@ unsafe impl super::AtomicAdd<u64> for u64 {
     }
 }
=20
+// SAFETY: `usize` has the same size and alignment with `isize_atomic_repr`,=
 and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for usize {
+    type Repr =3D isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `u=
size`.
+unsafe impl super::AtomicAdd<usize> for usize {
+    fn rhs_into_delta(rhs: usize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 use crate::macros::kunit_tests;
=20
 #[kunit_tests(rust_atomics)]
@@ -73,7 +118,7 @@ mod tests {
=20
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x =3D Atomic::new(v);
=20
             assert_eq!(v, x.load(Relaxed));
@@ -82,7 +127,7 @@ mod tests {
=20
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x =3D Atomic::new(v);
=20
             let old =3D v;
@@ -95,7 +140,7 @@ mod tests {
=20
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x =3D Atomic::new(v);
=20
             let old =3D v;
@@ -110,7 +155,7 @@ mod tests {
=20
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x =3D Atomic::new(v);
=20
             assert_eq!(v, x.fetch_add(12, Full));

