Return-Path: <linux-tip-commits+bounces-3804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFEA4CB48
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BED7A7A19
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720222D7AF;
	Mon,  3 Mar 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gWcpkIGY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hA6GGIAv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359120E313;
	Mon,  3 Mar 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027924; cv=none; b=D6WgAuDERO1eqv7cFw/z48fzC7paLI/rrwaL2jzwCM/BIUucpBGn6vbqSUq14zj7B+lY36cvx89C8IUHJ5v+37YkFwpD9woNsSe3IW8S/YoNUegIWctypwbcb8A/DsGP9/MqxHLV55O9w6sMbHoszTAtLc+RuvfoYoJmZ89yvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027924; c=relaxed/simple;
	bh=o/qmX6hSgRoymOE1dWMcvLTwjwRGpOCvn8rPyegWrZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J0LIstR07ZgijCfqS+yq174KvDpuc8v9KJ469PsVgPh1Jh2WpOVHLQ3zogx9C5UsyrX6WrFy0X2b9RvbbHS+Sk7GeIe4BAo/TKMoezzHsdgaaeFq6oh1ryqafmc1XmSbUQ+F/gsD+HWF/w2xs5e4Ufdwq5xQNLNz0iy1RTK6du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gWcpkIGY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hA6GGIAv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGeQYAabFLDEOsh+5xx1WnuyM7t4dWXnTfPHS1MGtgo=;
	b=gWcpkIGYiWQOQSuT1i3++lIzJZx9iq0yDSPSQxZXGey0AK2FB7VhcwMv1KjB+ycR0vN/0m
	PcMSEgN9rUGzdOSIFijwhqowwHC0RrB+5KqPnbVFlQd53coYjMEgvRKIv0WQt0qbHYlxkb
	Szf4zQVIQmf9mh6A2pnTqIVVZNSmr4/Jvly9BhpQjgfG/eY5VL13x5nxse9RLlNdm/yvqj
	rYPvtaSYuCmPdB5K0lJohkv7PO7x/+0B2QFANluVzmjyAEpy2Xy5A12+OySr5BlQ++0VCx
	12yMrnc3xIv24YpdDxLc5QysPFbOp8GXk0/LA3AnestT4TNXbtDdg2mBxYYASA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGeQYAabFLDEOsh+5xx1WnuyM7t4dWXnTfPHS1MGtgo=;
	b=hA6GGIAvYoxhoDMCJ8FGZzV7BMxFVRL2/MxVUcu+vRprAt7n+55hAI5dtrhWO9h4i2GS8M
	42lunAcBBk8Ma6DA==
From: "tip-bot2 for Mitchell Levy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: lockdep: Use Pin for all LockClassKey usages
Cc: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>,
 Mitchell Levy <levymitchell0@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207-rust-lockdep-v4-2-7a50a7e88656@gmail.com>
References: <20250207-rust-lockdep-v4-2-7a50a7e88656@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791234.14745.9352511071714022288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b5b307cf84ca3a73abe797df31e0efe897411a9
Gitweb:        https://git.kernel.org/tip/3b5b307cf84ca3a73abe797df31e0efe897411a9
Author:        Mitchell Levy <levymitchell0@gmail.com>
AuthorDate:    Fri, 07 Feb 2025 16:39:09 -08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 25 Feb 2025 08:53:08 -08:00

rust: lockdep: Use Pin for all LockClassKey usages

Reintroduce dynamically-allocated LockClassKeys such that they are
automatically (de)registered. Require that all usages of LockClassKeys
ensure that they are Pin'd.

Currently, only `'static` LockClassKeys are supported, so Pin is
redundant. However, it is intended that dynamically-allocated
LockClassKeys will eventually be supported, so using Pin from the outset
will make that change simpler.

Closes: https://github.com/Rust-for-Linux/linux/issues/1102
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250207-rust-lockdep-v4-2-7a50a7e88656@gmail.com
---
 rust/helpers/helpers.c          |  1 +-
 rust/helpers/sync.c             | 13 +++++++-
 rust/kernel/sync.rs             | 57 ++++++++++++++++++++++++++++++--
 rust/kernel/sync/condvar.rs     |  5 +--
 rust/kernel/sync/lock.rs        |  4 +-
 rust/kernel/sync/lock/global.rs |  5 +--
 rust/kernel/sync/poll.rs        |  2 +-
 rust/kernel/workqueue.rs        |  2 +-
 8 files changed, 77 insertions(+), 12 deletions(-)
 create mode 100644 rust/helpers/sync.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e..4c1a10a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,6 +30,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "sync.c"
 #include "task.c"
 #include "uaccess.c"
 #include "vmalloc.c"
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
new file mode 100644
index 0000000..ff7e68b
--- /dev/null
+++ b/rust/helpers/sync.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/lockdep.h>
+
+void rust_helper_lockdep_register_key(struct lock_class_key *k)
+{
+	lockdep_register_key(k);
+}
+
+void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
+{
+	lockdep_unregister_key(k);
+}
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 16eab91..4104bc2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,6 +5,8 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
+use crate::pin_init;
+use crate::prelude::*;
 use crate::types::Opaque;
 
 mod arc;
@@ -23,15 +25,64 @@ pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
-pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+#[pin_data(PinnedDrop)]
+pub struct LockClassKey {
+    #[pin]
+    inner: Opaque<bindings::lock_class_key>,
+}
 
 // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
 // provides its own synchronization.
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
+    /// Initializes a dynamically allocated lock class key. In the common case of using a
+    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
+    ///
+    /// # Example
+    /// ```
+    /// # use kernel::{c_str, stack_pin_init};
+    /// # use kernel::alloc::KBox;
+    /// # use kernel::types::ForeignOwnable;
+    /// # use kernel::sync::{LockClassKey, SpinLock};
+    ///
+    /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
+    /// let key_ptr = key.into_foreign();
+    ///
+    /// {
+    ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
+    ///         0,
+    ///         c_str!("my_spinlock"),
+    ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
+    ///         // `from_foreign()` has not yet been called.
+    ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
+    ///     ));
+    /// }
+    ///
+    /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
+    /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
+    /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_dynamic() -> impl PinInit<Self> {
+        pin_init!(Self {
+            // SAFETY: lockdep_register_key expects an uninitialized block of memory
+            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_register_key(slot) })
+        })
+    }
+
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for LockClassKey {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
+        // hasn't changed. Thus, it's safe to pass to unregister.
+        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
 
@@ -44,7 +95,7 @@ macro_rules! static_lock_class {
             // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
             // lock_class_key
             unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
-        &CLASS
+        $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 5c1e546..fbf68ad 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -17,8 +17,7 @@ use crate::{
     time::Jiffies,
     types::Opaque,
 };
-use core::marker::PhantomPinned;
-use core::ptr;
+use core::{marker::PhantomPinned, pin::Pin, ptr};
 use macros::pin_data;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
@@ -103,7 +102,7 @@ unsafe impl Sync for CondVar {}
 
 impl CondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f53e87d..360a10a 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -12,7 +12,7 @@ use crate::{
     str::CStr,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
@@ -129,7 +129,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 480ee72..d65f94b 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -13,6 +13,7 @@ use crate::{
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
+    pin::Pin,
 };
 
 /// Trait implemented for marker types for global locks.
@@ -26,7 +27,7 @@ pub trait GlobalLockBackend {
     /// The backend used for this global lock.
     type Backend: Backend + 'static;
     /// The class for this global lock.
-    fn get_lock_class() -> &'static LockClassKey;
+    fn get_lock_class() -> Pin<&'static LockClassKey>;
 }
 
 /// Type used for global locks.
@@ -270,7 +271,7 @@ macro_rules! global_lock {
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
 
-            fn get_lock_class() -> &'static $crate::sync::LockClassKey {
+            fn get_lock_class() -> Pin<&'static $crate::sync::LockClassKey> {
                 $crate::static_lock_class!()
             }
         }
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d5f1715..c4934f8 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -89,7 +89,7 @@ pub struct PollCondVar {
 
 impl PollCondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             inner <- CondVar::new(name, key),
         })
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d..6b6f3ad 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -369,7 +369,7 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
 impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
     where
         T: WorkItem<ID>,
     {

