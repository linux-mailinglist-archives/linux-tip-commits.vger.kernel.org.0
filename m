Return-Path: <linux-tip-commits+bounces-6581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E1B56021
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7617A249
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3A2ECD07;
	Sat, 13 Sep 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pO/HeoAO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QRfrX7E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0622EC0BC;
	Sat, 13 Sep 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758539; cv=none; b=bN8t6++AqFsLn89uRjGhE4wPlOFk6j6xOcDBNXX7uLsGBDT9Adq0b0PHckEmeVrl/0VNr3xnlZ3SyTzGGMeEQ5+ac5jm7nDmUYLa+y989S5FKnuqkHwP6rgF6f3PA1M3zff4Bo4p8PykBykU/SZloX19Zw7ZBxxRy4iatByUtS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758539; c=relaxed/simple;
	bh=EjrOdkm1g8oGr4OAGZCPTlixjODCFmOdow3/QyUBkGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LUAwwT0cS7GM4G06qmG4tVGLowGbg4VEaHUKniPHd+QpetcR/K0vdTWyEOu5LQgdKcjt5xczlGARg9xtnSVajn7brfvrclsEwLkVkdFeHk8laNmzq3wSg/8HZm8q/d6FUclu815Eib4wJ5XL7/irwkggyT02f8Hn6kKdzwC2GNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pO/HeoAO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QRfrX7E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6vdhMEhoAZJ693IxAYqH2tCK0gsxBWhl8ayFvGrdD8=;
	b=pO/HeoAOiRHgRsGUQ70aP/7s1foBt4qX6eANyu6Lsxotj6CVTco1WHrMd0ShOVFNZuWA2H
	hC6bgfmyiSm7RtdK3XiL2EB3Ff4+kmqbnR0niD82kOJ3jjuDVNTQMyrspRwc2QitKj29AV
	qqqmi+5C47iwfgKQ7ZmrVGoEZFSsZV8bdt8bR6X+mI2ccPHkd5iksja+fJjFga6N5hQhNV
	gengGLX4Nj6HsfAOWKdJYTmpjZq0fr9Pf4B/qnDm8hOnDSE+qEvDj1GRgRYbUn6a2JubfY
	UANFi27kM8dIWR1AFE9KlGHPQUFQr5NkpVr/oa0UOK6kdhZpPOd/Ve8oEG36MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6vdhMEhoAZJ693IxAYqH2tCK0gsxBWhl8ayFvGrdD8=;
	b=4QRfrX7EBcCsqvq3ctlmQ2QHJVpw+t8D9bKUX1MlOSo4sbRVtclTCdKSGim4vmzypt1qx0
	+vAYY0RGL1m9NECw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add Atomic<u{32,64}>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-8-boqun.feng@gmail.com>
References: <20250905044141.77868-8-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853464.709179.969909132510392234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d371d33d83f4bd560aaa3b18f7558ccb816c9983
Gitweb:        https://git.kernel.org/tip/d371d33d83f4bd560aaa3b18f7558ccb816=
c9983
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:57 +02:00

rust: sync: atomic: Add Atomic<u{32,64}>

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-8-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic/predefine.rs | 95 +++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index a6e5883..d087581 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -27,3 +27,98 @@ unsafe impl super::AtomicAdd<i64> for i64 {
         rhs
     }
 }
+
+// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is rou=
nd-trip transmutable to
+// `i32`.
+unsafe impl super::AtomicType for u32 {
+    type Repr =3D i32;
+}
+
+// SAFETY: The wrapping add result of two `i32`s is a valid `u32`.
+unsafe impl super::AtomicAdd<u32> for u32 {
+    fn rhs_into_delta(rhs: u32) -> i32 {
+        rhs as i32
+    }
+}
+
+// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is rou=
nd-trip transmutable to
+// `i64`.
+unsafe impl super::AtomicType for u64 {
+    type Repr =3D i64;
+}
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `u64`.
+unsafe impl super::AtomicAdd<u64> for u64 {
+    fn rhs_into_delta(rhs: u64) -> i64 {
+        rhs as i64
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::super::*;
+
+    // Call $fn($val) with each $type of $val.
+    macro_rules! for_each_type {
+        ($val:literal in [$($type:ty),*] $fn:expr) =3D> {
+            $({
+                let v: $type =3D $val;
+
+                $fn(v);
+            })*
+        }
+    }
+
+    #[test]
+    fn atomic_basic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x =3D Atomic::new(v);
+
+            assert_eq!(v, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_xchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x =3D Atomic::new(v);
+
+            let old =3D v;
+            let new =3D v + 1;
+
+            assert_eq!(old, x.xchg(new, Full));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_cmpxchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x =3D Atomic::new(v);
+
+            let old =3D v;
+            let new =3D v + 1;
+
+            assert_eq!(Err(old), x.cmpxchg(new, new, Full));
+            assert_eq!(old, x.load(Relaxed));
+            assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_arithmetic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x =3D Atomic::new(v);
+
+            assert_eq!(v, x.fetch_add(12, Full));
+            assert_eq!(v + 12, x.load(Relaxed));
+
+            x.add(13, Relaxed);
+
+            assert_eq!(v + 25, x.load(Relaxed));
+        });
+    }
+}

