Return-Path: <linux-tip-commits+bounces-7351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC030C5E02D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C84A426CAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F02330B1A;
	Fri, 14 Nov 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GrnCDIMK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfsC46Wi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF6330314;
	Fri, 14 Nov 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134395; cv=none; b=lcS12mqWF041SNrcG3+/CD8Qqk062HEz3Kc5jnBHyE1Rsb1wgDdSq3kP5wP9kf5KQfl0gfUmSfCAdWFGmg3i/6q9BwkDndktgDS4+OhAsu0nDrc6T6Io40vVNuswUITzn/pSbDci4rx/UdS1E53+IYswdxzjrVFJrOZ4opVkbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134395; c=relaxed/simple;
	bh=/t7RzlvKWNWKABnS9GGBad8G6P8vH6ETyKgfq2dABHE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H5RCQH9/+tx1e0uQZUIZ8pk1TMW67jA5XqL4DTy4/h8Etk1GYIuCjdA3eg2jDSv0I+EH5/i6AfyEVJU1VB00SkMNRGMuQ25eYJ0386k8qmT1KddVlQn8VYTlCBqvo+XfWIakbN8iG3aNSE0pRjb7pLM3Ov/nEYPSg4uEvANU7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GrnCDIMK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfsC46Wi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd6NWK84mfIQgcm/hrRHOsl9n1n6LxJdFPu3IzuOE7c=;
	b=GrnCDIMKRj0mFAidGconQYYF9sQzqyb34tI/lGGY4fXlK1/yqRagpvxVBua5fPswrOc/T0
	04WlaVQrlEuoOdTuR7+eZc1BnzKLl5+T26pzCy/70fHoIpeCFkWbwG+dhOcXx48ncMxfQt
	Cg0KDwPr5bsJYRE86Scv1OMpzlzdQCfXBGfoCy/beEHjVntkULtF3a4MpQXnlr1TdmLMXF
	vmihT0aNF10Mzz8X3g0wG0jwJKjoI5HCqxMTtvLS8baJW5RTkCKsZs9uB1e+V5AlKBFyVk
	QP70qxRe09iNPU9bcUG3fsqmnSrPR+PlzMtcp6pg2xoY2s3XE5ZCJ+LvQownTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd6NWK84mfIQgcm/hrRHOsl9n1n6LxJdFPu3IzuOE7c=;
	b=dfsC46WiMSung5PInu0pBnr5xFgvtf3efM6VPoHdaNNwI7C47gjAwsWbSPKSBjmDkcAZQS
	lcBi9wQ3L7ux19CA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: debugfs: Replace the usage of Rust native atomics
Cc: Matthew Maurer <mmaurer@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Gow <davidgow@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022035324.70785-4-boqun.feng@gmail.com>
References: <20251022035324.70785-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313438978.498.4921655387787627318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f74cf399e02e24c544b0bd4b1fe8fa2c5ae30b18
Gitweb:        https://git.kernel.org/tip/f74cf399e02e24c544b0bd4b1fe8fa2c5ae=
30b18
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 21 Oct 2025 23:53:24 -04:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Wed, 12 Nov 2025 08:56:42 -08:00

rust: debugfs: Replace the usage of Rust native atomics

Rust native atomics are not allowed to use in kernel due to the mismatch
of memory model with Linux kernel memory model, hence remove the usage
of Rust native atomics in debufs.

Reviewed-by: Matthew Maurer <mmaurer@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Tested-by: David Gow <davidgow@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251022035324.70785-4-boqun.feng@gmail.com
---
 rust/kernel/debugfs/traits.rs       | 53 ++++++++--------------------
 samples/rust/rust_debugfs.rs        | 12 ++----
 samples/rust/rust_debugfs_scoped.rs |  6 +--
 3 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ba7ec5a..92054fe 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -4,14 +4,11 @@
 //! Traits for rendering or updating values exported to DebugFS.
=20
 use crate::prelude::*;
+use crate::sync::atomic::{Atomic, AtomicBasicOps, AtomicType, Relaxed};
 use crate::sync::Mutex;
 use crate::uaccess::UserSliceReader;
 use core::fmt::{self, Debug, Formatter};
 use core::str::FromStr;
-use core::sync::atomic::{
-    AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, Atomi=
cU32, AtomicU64,
-    AtomicU8, AtomicUsize, Ordering,
-};
=20
 /// A trait for types that can be written into a string.
 ///
@@ -66,37 +63,21 @@ impl<T: FromStr + Unpin> Reader for Mutex<T> {
     }
 }
=20
-macro_rules! impl_reader_for_atomic {
-    ($(($atomic_type:ty, $int_type:ty)),*) =3D> {
-        $(
-            impl Reader for $atomic_type {
-                fn read_from_slice(&self, reader: &mut UserSliceReader) -> R=
esult {
-                    let mut buf =3D [0u8; 21]; // Enough for a 64-bit number.
-                    if reader.len() > buf.len() {
-                        return Err(EINVAL);
-                    }
-                    let n =3D reader.len();
-                    reader.read_slice(&mut buf[..n])?;
+impl<T: AtomicType + FromStr> Reader for Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
+        let mut buf =3D [0u8; 21]; // Enough for a 64-bit number.
+        if reader.len() > buf.len() {
+            return Err(EINVAL);
+        }
+        let n =3D reader.len();
+        reader.read_slice(&mut buf[..n])?;
=20
-                    let s =3D core::str::from_utf8(&buf[..n]).map_err(|_| EI=
NVAL)?;
-                    let val =3D s.trim().parse::<$int_type>().map_err(|_| EI=
NVAL)?;
-                    self.store(val, Ordering::Relaxed);
-                    Ok(())
-                }
-            }
-        )*
-    };
+        let s =3D core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
+        let val =3D s.trim().parse::<T>().map_err(|_| EINVAL)?;
+        self.store(val, Relaxed);
+        Ok(())
+    }
 }
-
-impl_reader_for_atomic!(
-    (AtomicI16, i16),
-    (AtomicI32, i32),
-    (AtomicI64, i64),
-    (AtomicI8, i8),
-    (AtomicIsize, isize),
-    (AtomicU16, u16),
-    (AtomicU32, u32),
-    (AtomicU64, u64),
-    (AtomicU8, u8),
-    (AtomicUsize, usize)
-);
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 82b61a1..711faa0 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -32,14 +32,12 @@
 //! ```
=20
 use core::str::FromStr;
-use core::sync::atomic::AtomicUsize;
-use core::sync::atomic::Ordering;
 use kernel::c_str;
 use kernel::debugfs::{Dir, File};
 use kernel::new_mutex;
 use kernel::prelude::*;
+use kernel::sync::atomic::{Atomic, Relaxed};
 use kernel::sync::Mutex;
-
 use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
=20
 kernel::module_platform_driver! {
@@ -59,7 +57,7 @@ struct RustDebugFs {
     #[pin]
     _compatible: File<CString>,
     #[pin]
-    counter: File<AtomicUsize>,
+    counter: File<Atomic<usize>>,
     #[pin]
     inner: File<Mutex<Inner>>,
 }
@@ -109,7 +107,7 @@ impl platform::Driver for RustDebugFs {
     ) -> Result<Pin<KBox<Self>>> {
         let result =3D KBox::try_pin_init(RustDebugFs::new(pdev), GFP_KERNEL=
)?;
         // We can still mutate fields through the files which are atomic or =
mutexed:
-        result.counter.store(91, Ordering::Relaxed);
+        result.counter.store(91, Relaxed);
         {
             let mut guard =3D result.inner.lock();
             guard.x =3D guard.y;
@@ -120,8 +118,8 @@ impl platform::Driver for RustDebugFs {
 }
=20
 impl RustDebugFs {
-    fn build_counter(dir: &Dir) -> impl PinInit<File<AtomicUsize>> + '_ {
-        dir.read_write_file(c_str!("counter"), AtomicUsize::new(0))
+    fn build_counter(dir: &Dir) -> impl PinInit<File<Atomic<usize>>> + '_ {
+        dir.read_write_file(c_str!("counter"), Atomic::<usize>::new(0))
     }
=20
     fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + '_ {
diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_=
scoped.rs
index b0c4e76..9f0ec5f 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -6,9 +6,9 @@
 //! `Scope::dir` to create a variety of files without the need to separately
 //! track them all.
=20
-use core::sync::atomic::AtomicUsize;
 use kernel::debugfs::{Dir, Scope};
 use kernel::prelude::*;
+use kernel::sync::atomic::Atomic;
 use kernel::sync::Mutex;
 use kernel::{c_str, new_mutex, str::CString};
=20
@@ -62,7 +62,7 @@ fn create_file_write(
     let file_name =3D CString::try_from_fmt(fmt!("{name_str}"))?;
     for sub in items {
         nums.push(
-            AtomicUsize::new(sub.parse().map_err(|_| EINVAL)?),
+            Atomic::<usize>::new(sub.parse().map_err(|_| EINVAL)?),
             GFP_KERNEL,
         )?;
     }
@@ -109,7 +109,7 @@ impl ModuleData {
=20
 struct DeviceData {
     name: CString,
-    nums: KVec<AtomicUsize>,
+    nums: KVec<Atomic<usize>>,
 }
=20
 fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleD=
ata>> + '_ {

