Return-Path: <linux-tip-commits+bounces-7932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F8D18388
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C66C3028559
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781D38B7A2;
	Tue, 13 Jan 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgern0Q3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1YJNSQF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A538E5CA;
	Tue, 13 Jan 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301406; cv=none; b=EHohvx3EYrbcbe27lZS2Bs0dWGavnWk+PqVNl371J5awB9U3bvScmZI5+d7o7xtO0ilILIpw0ivZOHEy+djRqaSf0bEry8rggrvtANzekxm434/aAsI0dMku5ITV8XQLApKSoK2mhAAqK0OILpUS05P3KXuc6QbOrSR1QTiK4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301406; c=relaxed/simple;
	bh=Zg+R9HBengqpJfAPgLlrEMu+/IbhuQFXlDkMVTGQ77Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n0n+UzkeUBffxi5BFLFHHmgRm7GEDThf5bNYa1BBOEX8kQTtyHV39prpwidb/0z7Z4gzhQF8LOWDVq/v3siYrJXeshr8GDBqYoLbcLvlhTS5ClwaPfid95mLc3h5a0M5l1ESD8zasdPalvEFfUAmp50H26F1mMB0Xoh83kcFD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgern0Q3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1YJNSQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh0jMSD6fyZ9Ukbm0bRFC+9AazZe5Ef0N62i4EyfpUI=;
	b=vgern0Q37JMsZGuuhHbb3jHNGfTlgq5tzXn3jKnrdPofBfZzyS4H00Wm/uKTz13DhphjrB
	rEv/UK5NoxTRoMGskz27E0PH9QYkyprsvi+htHRFSGm4wfGFSpQLW4QfS5l2864f3us6Zy
	fUWWq631n6Ynp/aULvTZ6VrtqiTGhjCN7TzC+eX3U+sP9MxE9YTns+JdNrs2A087XTxxI/
	tDIic4S/EZ0sf2svLPobOLNAyXz+fvkh4SKwpmByyOVMIyp9X6P1BFD6pp4iA/rqf/8FKD
	VRNQ4Xeuf7o5z8VvUpSzkBhptTx5KpCByA3wlFXGRqoPyDtRRe9BpemlfjioYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh0jMSD6fyZ9Ukbm0bRFC+9AazZe5Ef0N62i4EyfpUI=;
	b=a1YJNSQFlrhgx05ZKJQBQQiqgXF8mN4yVi1ynkNbzgKS3+R7tTA4T98sUvmtUoAaC/8Y79
	DHgDHozwUAcoV6Dg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add i8/i16 load and store support
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251211113826.1299077-4-fujita.tomonori@gmail.com>
References: <20251211113826.1299077-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139597.510.352625958418465167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b33796d554f270e19141c0c1fa0a90705a511d2b
Gitweb:        https://git.kernel.org/tip/b33796d554f270e19141c0c1fa0a90705a5=
11d2b
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 11 Dec 2025 20:38:25 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Add i8/i16 load and store support

Add atomic operation support for i8 and i16 types using volatile
read/write and smp_load_acquire/smp_store_release helpers.

[boqun: Adjust [1] to avoid introduction of
impl_atomic_only_load_and_store_ops!() in the middle]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Link: https://lore.kernel.org/all/20251228120546.1602275-1-fujita.tomonori@gm=
ail.com/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251211113826.1299077-4-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/internal.rs  | 25 +++++++++++++++++++------
 rust/kernel/sync/atomic/predefine.rs | 14 +++++++++++++-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index 41b4ce2..1b2a793 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -13,17 +13,22 @@ mod private {
     pub trait Sealed {}
 }
=20
-// `i32` and `i64` are only supported atomic implementations.
+// The C side supports atomic primitives only for `i32` and `i64` (`atomic_t=
` and `atomic64_t`),
+// while the Rust side also layers provides atomic support for `i8` and `i16`
+// on top of lower-level C primitives.
+impl private::Sealed for i8 {}
+impl private::Sealed for i16 {}
 impl private::Sealed for i32 {}
 impl private::Sealed for i64 {}
=20
 /// A marker trait for types that implement atomic operations with C side pr=
imitives.
 ///
-/// This trait is sealed, and only types that have directly mapping to the C=
 side atomics should
-/// impl this:
+/// This trait is sealed, and only types that map directly to the C side ato=
mics
+/// or can be implemented with lower-level C primitives are allowed to imple=
ment this:
 ///
-/// - `i32` maps to `atomic_t`.
-/// - `i64` maps to `atomic64_t`.
+/// - `i8` and `i16` are implemented with lower-level C primitives.
+/// - `i32` map to `atomic_t`
+/// - `i64` map to `atomic64_t`
 pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
     /// The type of the delta in arithmetic or logical operations.
     ///
@@ -32,6 +37,14 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Seale=
d {
     type Delta;
 }
=20
+impl AtomicImpl for i8 {
+    type Delta =3D Self;
+}
+
+impl AtomicImpl for i16 {
+    type Delta =3D Self;
+}
+
 // `atomic_t` implements atomic operations on `i32`.
 impl AtomicImpl for i32 {
     type Delta =3D Self;
@@ -243,7 +256,7 @@ macro_rules! declare_and_impl_atomic_methods {
 }
=20
 declare_and_impl_atomic_methods!(
-    [ i32 =3D> atomic, i64 =3D> atomic64 ]
+    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> atom=
ic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 45a1798..09b357b 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -5,6 +5,18 @@
 use crate::static_assert;
 use core::mem::{align_of, size_of};
=20
+// SAFETY: `i8` has the same size and alignment with itself, and is round-tr=
ip transmutable to
+// itself.
+unsafe impl super::AtomicType for i8 {
+    type Repr =3D i8;
+}
+
+// SAFETY: `i16` has the same size and alignment with itself, and is round-t=
rip transmutable to
+// itself.
+unsafe impl super::AtomicType for i16 {
+    type Repr =3D i16;
+}
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-t=
rip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -118,7 +130,7 @@ mod tests {
=20
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
             let x =3D Atomic::new(v);
=20
             assert_eq!(v, x.load(Relaxed));

