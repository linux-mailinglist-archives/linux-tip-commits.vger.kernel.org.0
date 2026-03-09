Return-Path: <linux-tip-commits+bounces-8391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH5lIzckr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:49:11 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C57240510
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA635303C52A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CAF41C2EB;
	Mon,  9 Mar 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtqJieN2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2L+3KBfG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA9413221;
	Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085708; cv=none; b=O+oisrOAxYL+bntrj++5sdg81uvPQE+RC9k0Fhl27t9bi/Cv+PjvGhFBku4mP60xsdx7in1RQFq+CvGFXPG9ZZXFk0x+D3dS6HHvU/eBa7FsFt2HLsgFhbofw5VcdMQ4vWjbJyNJ2DR1doAyRkdQVLqC/QdSLmj3J7vZY33TdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085708; c=relaxed/simple;
	bh=lavPYaffDnU8ISEG4V7FtjhMTp2VZrPqgsTy9PCb63U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LFJEwfAsrc/gjsmJVXQp9m+76WzdP6hSJZ01fBAQ1U/XpKi24//uPvl7LUrV87YjmGn1AIUw8C17IWeKyO7/NjgPkkpYYbsFmAJYp3OXRTO+n1ccr75+KRXhlDokUxnR7vWBbuBjcVcx9lxh3vA5zqf4YLBpYEw068FT6CJHA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtqJieN2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2L+3KBfG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihPdQsnQoH48KQ1PwEsdhc4L4+zx0q1L8XZMZ7N9hSY=;
	b=WtqJieN2DJJS/rSNe9iqQAlWUTeCIXHygrqPscDWHCJcsHiFDunJwzzSvx/EW6yBXsswgd
	NXVJMzR1KWcqiFj+NSEThwU41BP7l2E0BP5y2njutMdzoItOh+7kp/FY7a2I65lJq1AKO9
	DO7SY1rGCyvu16+YkmMzLc/q36P5sRd7vX4rX+/Jo5L0MM/QhBOJ0MHFwNx0oSSKkonYA2
	aM76TzpKXbexyGoxrV00OM42mtEaYTPQll3V+j71ChMcnqYmhLjl02a5OXjck56u/ATeqN
	C+RUn5WejBzHHCeXmpkfPTv+zjHsyynILFhGYDk5+4vIO9jMw6P0FEKfrl/njg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085704;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihPdQsnQoH48KQ1PwEsdhc4L4+zx0q1L8XZMZ7N9hSY=;
	b=2L+3KBfG04SyXyNGElWfVXN+jMmFF8YZcvjGuj6c1x1y97o69DuNKphk/xdbgZ9VmYVN2N
	WjlqW6l2R/vM8yAQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-11-boqun@kernel.org>
References: <20260303201701.12204-11-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570364.1647592.7902021372596822770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 28C57240510
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8391-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,google.com,garyguo.net,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e2f9c86f33abb89d3e52436018f58e5fb951cc04
Gitweb:        https://git.kernel.org/tip/e2f9c86f33abb89d3e52436018f58e5fb95=
1cc04
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:58 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:50 +01:00

rust: sync: atomic: Add atomic operation helpers over raw pointers

In order to synchronize with C or external memory, atomic operations
over raw pointers are need. Although there is already an
`Atomic::from_ptr()` to provide a `&Atomic<T>`, it's more convenient to
have helpers that directly perform atomic operations on raw pointers.
Hence a few are added, which are basically an `Atomic::from_ptr().op()`
wrapper.

Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` have a
conflict naming to 32bit C atomic xchg/cmpxchg, hence the helpers are
just named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
`atomic_store()`, their 32bit C counterparts are `atomic_read()` and
`atomic_set()`, so keep the `atomic_` prefix.

[boqun: Fix typo spotted by Alice and fix broken sentence spotted by
Gary]

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260120115207.55318-3-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-11-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs           | 104 ++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++-
 2 files changed, 150 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index f80cebc..1bb1fc2 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -703,3 +703,107 @@ impl AtomicFlag {
         }
     }
 }
+
+/// Atomic load over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and=
 can be used to work
+/// with C side on synchronizations:
+///
+/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when used for inter-t=
hread communication.
+/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent store from kernel (C or Rust), it has to be a=
tomic.
+#[doc(alias("READ_ONCE", "smp_load_acquire"))]
+#[inline(always)]
+pub unsafe fn atomic_load<T: AtomicType, Ordering: ordering::AcquireOrRelaxe=
d>(
+    ptr: *mut T,
+    o: Ordering,
+) -> T
+where
+    T::Repr: AtomicBasicOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and align=
ed to
+    // `align_of::<T>()`, and all concurrent stores from kernel are atomic, =
hence no data race per
+    // LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.load(o)
+}
+
+/// Atomic store over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and=
 can be used to work
+/// with C side on synchronizations:
+///
+/// - `atomic_store(.., Relaxed)` maps to `WRITE_ONCE()` when used for inter=
-thread communication.
+/// - `atomic_load(.., Release)` maps to `smp_store_release()`.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be =
atomic.
+#[doc(alias("WRITE_ONCE", "smp_store_release"))]
+#[inline(always)]
+pub unsafe fn atomic_store<T: AtomicType, Ordering: ordering::ReleaseOrRelax=
ed>(
+    ptr: *mut T,
+    v: T,
+    o: Ordering,
+) where
+    T::Repr: AtomicBasicOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and align=
ed to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic=
, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.store(v, o);
+}
+
+/// Atomic exchange over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().xchg(..)`, and=
 can be used to work
+/// with C side on synchronizations.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be =
atomic.
+#[inline(always)]
+pub unsafe fn xchg<T: AtomicType, Ordering: ordering::Ordering>(
+    ptr: *mut T,
+    new: T,
+    o: Ordering,
+) -> T
+where
+    T::Repr: AtomicExchangeOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and align=
ed to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic=
, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.xchg(new, o)
+}
+
+/// Atomic compare and exchange over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().cmpxchg(..)`, =
and can be used to work
+/// with C side on synchronizations.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be =
atomic.
+#[doc(alias("try_cmpxchg"))]
+#[inline(always)]
+pub unsafe fn cmpxchg<T: AtomicType, Ordering: ordering::Ordering>(
+    ptr: *mut T,
+    old: T,
+    new: T,
+    o: Ordering,
+) -> Result<T, T>
+where
+    T::Repr: AtomicExchangeOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and align=
ed to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic=
, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.cmpxchg(old, new, o)
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index ceb3cae..1d53834 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -178,6 +178,14 @@ mod tests {
=20
             assert_eq!(v, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
+            let x =3D Atomic::new(v);
+            let ptr =3D x.as_ptr();
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(v, unsafe { atomic_load(ptr, Relaxed) });
+        });
     }
=20
     #[test]
@@ -188,6 +196,17 @@ mod tests {
             x.store(v, Release);
             assert_eq!(v, x.load(Acquire));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
+            let x =3D Atomic::new(0);
+            let ptr =3D x.as_ptr();
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            unsafe { atomic_store(ptr, v, Release) };
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(v, unsafe { atomic_load(ptr, Acquire) });
+        });
     }
=20
     #[test]
@@ -201,6 +220,18 @@ mod tests {
             assert_eq!(old, x.xchg(new, Full));
             assert_eq!(new, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
+            let x =3D Atomic::new(v);
+            let ptr =3D x.as_ptr();
+
+            let old =3D v;
+            let new =3D v + 1;
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(old, unsafe { xchg(ptr, new, Full) });
+            assert_eq!(new, x.load(Relaxed));
+        });
     }
=20
     #[test]
@@ -216,6 +247,21 @@ mod tests {
             assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
             assert_eq!(new, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
+            let x =3D Atomic::new(v);
+            let ptr =3D x.as_ptr();
+
+            let old =3D v;
+            let new =3D v + 1;
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(Err(old), unsafe { cmpxchg(ptr, new, new, Full) });
+            assert_eq!(old, x.load(Relaxed));
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(Ok(old), unsafe { cmpxchg(ptr, old, new, Relaxed) });
+            assert_eq!(new, x.load(Relaxed));
+        });
     }
=20
     #[test]

