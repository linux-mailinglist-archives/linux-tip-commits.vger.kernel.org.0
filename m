Return-Path: <linux-tip-commits+bounces-6597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B7B571EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE11189F1A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ABE2EAD0A;
	Mon, 15 Sep 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sa8OI+Ws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRSVs2E0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D242EA736;
	Mon, 15 Sep 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922532; cv=none; b=pVzY5LN/U6hZmuDkDIMbL+TOGy7ZsHJW5IgGySJdScrwkmkSkUBbD0/XqenRqNynZoOPgO11kpCV83OOlRFRPKkHnS+qsAUzDM1f6psuSX9rn98htZoAH0pZveJEnxwezRFgMi9kOiA8hqqBM95JEOZpKW02V9CVb2ICV6IYR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922532; c=relaxed/simple;
	bh=KiuBbIjUxiB2yO6ykHPV7lNQ2T69gD97HiToUTOktQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=herJoYLZ/uuVQBSQRznUUBd8LTtRd7h+el4CnHzrbO04vAwt5lUhyUAPtk8MYnwCZYd1c+P5oizllMpv2X7LQ+FI5lLksZKg6uk4/xQtyIh3+hsbeHNKakMFM00I4CqnhkwSqYqOcRgesWk5VbEurFm7n3v/UJtvBzCj5R/T+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sa8OI+Ws; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRSVs2E0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w67gOL3gWgCvzWxocYVxtYk04o2gYCkNMlKeLtgrSf8=;
	b=Sa8OI+WsWJOnXmuBtMJND2C78sS5QjIb8dqP6ZPjonuuZCZ1mqW4iBHFxR8hSnJ5AuoG95
	U11rwWG/qNCMyVjzCGSZYz02LdzryxXBJlVyW6rWCEFAr3aqr/Tv+9bydZCuBh17NIXXiV
	/pcEtNVhepEUdvStXjnGxXQ2e48W/oHd2ZqqBvj+nyRsHsZcdjB/wLmLlY9PzMM0iH3jve
	KCwfiPP7YKdfefzsNEkfPQEGNyn0/D+PgVs0JRCukIa9/oVieC5CXuBupSDXwEyR2tZUTh
	RJpzD4+upZFzMDVmFflTpzVaartJot9nn2ggP52NLHQYepzTmR8S/qUpqwUe2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w67gOL3gWgCvzWxocYVxtYk04o2gYCkNMlKeLtgrSf8=;
	b=MRSVs2E0HeslIqac5jNdtUMcquioV8himdEGVShrldrmadgoZpeOxJ3vCtkG8CKD9P38GK
	3gda6S2hmPEVVXBQ==
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
Message-ID: <175792252771.709179.8849066383457171347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d6df37ba918198c0a7f55734c20512431770c4b3
Gitweb:        https://git.kernel.org/tip/d6df37ba918198c0a7f55734c2051243177=
0c4b3
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:34 +02:00

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

