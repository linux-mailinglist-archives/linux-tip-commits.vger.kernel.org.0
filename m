Return-Path: <linux-tip-commits+bounces-7907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3DD18307
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97D363011B0B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B43502BB;
	Tue, 13 Jan 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bW0kADwM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+1H7qQj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4C3A1B5;
	Tue, 13 Jan 2026 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301378; cv=none; b=BYiyjX9rdjo7ndj4a9tSjKrm8c1nLFXhlc6mwhR+F7VFw7NfOEE/Ed5IFQRhK37mHQWtdKXPwxeoDWWsYooMYm5kJz2ODAXgGoyuIlpDq3QQA8wfF9Ec5R28+e4h4s/eONdS91Co+jfOw++GrHtn1wG31UM3OhLbiFUdbsrjuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301378; c=relaxed/simple;
	bh=6EIo2vMOE1DgK2Yl7kLig1JzjA7e1ZAIWixQsXuwwOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SjbFniZioUIHKafeJV06CFOeYMkTl6DxfZxE/4cOjNDWt42MZEGevVS5j/6dgklatXT4Za9t+qQd/3etvy6TEMr4gEOM3rdUpv0/nq7lEbyA2eBHd2GHCnbkHAmSZAx1DhGFM3AeBhZ9a12CIgghzjh931G8UHvkByqb9HKIV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bW0kADwM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+1H7qQj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0QMZpfzl+sa8SMN1D4cARskOfXNtX7cfkkvZNnpQU8=;
	b=bW0kADwM1no7MKCum49aommiBlp1z2dGEN1/0/akl0RiZ5FmaK79oSdIg9KUjVXGQLNbKb
	3JLporOeoWFJVzhovAVPeayJ1uQFGfx7E9mt6ogSSeUaB26/Dk+3/WIWqIKy6Js1MkhyAN
	Ya4ztV2Cs2CVG1kMADAmbtIc/8XiZui6j9TmXOkljuU0nAu1s8kkF3++CHLLIau5d2djQC
	Qn+khycT5xq5r81LfqBS7ZwUFGoeI4iLvEZUulG9OFi0823dc2WUQ5PcyraG7/crcHU9P+
	iXjzUXf+pG2j8KJYrcSUHopBl/21ysHCoepYOMDXcjkurUJr/lRZN64/ZNDG/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0QMZpfzl+sa8SMN1D4cARskOfXNtX7cfkkvZNnpQU8=;
	b=O+1H7qQj3zboeZ42nQqu2pu8n3NsMRYe9XKo+zvShUjIGLd/wMG82GoNrbyC6l+KFi2s8U
	44e8t8hhvKnSZKAw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Inline various lock related methods
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251218-inline-lock-unlock-v2-1-fbadac8bd61b@google.com>
References: <20251218-inline-lock-unlock-v2-1-fbadac8bd61b@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830137307.510.12000181793930946169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ccf9e070116a81d29aae30db501d562c8efd1ed8
Gitweb:        https://git.kernel.org/tip/ccf9e070116a81d29aae30db501d562c8ef=
d1ed8
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Thu, 18 Dec 2025 12:10:23=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sat, 10 Jan 2026 10:53:46 +08:00

rust: sync: Inline various lock related methods

While debugging a different issue [1], the following relocation was
noticed in the rust_binder.ko file:

	R_AARCH64_CALL26	_RNvXNtNtNtCsdfZWD8DztAw_6kernel4sync4lock8spinlockNtB2_15S=
pinLockBackendNtB4_7Backend6unlock

This relocation (and a similar one for lock) occurred many times
throughout the module. That is not really useful because all this
function does is call spin_unlock(), so what we actually want here is
that a call to spin_unlock() dirctly is generated in favor of this
wrapper method.

Thus, mark these methods inline.

[boqun: Reword the commit message a bit]

Link: https://lore.kernel.org/p/20251111-binder-fix-list-remove-v1-0-8ed14a0d=
a63d@google.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251218-inline-lock-unlock-v2-1-fbadac8bd61b@=
google.com
---
 rust/kernel/sync/lock.rs          | 7 +++++++
 rust/kernel/sync/lock/global.rs   | 2 ++
 rust/kernel/sync/lock/mutex.rs    | 5 +++++
 rust/kernel/sync/lock/spinlock.rs | 5 +++++
 4 files changed, 19 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 46a57d1..10b6b5e 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -156,6 +156,7 @@ impl<B: Backend> Lock<(), B> {
     /// the whole lifetime of `'a`.
     ///
     /// [`State`]: Backend::State
+    #[inline]
     pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
         // SAFETY:
         // - By the safety contract `ptr` must point to a valid initialised =
instance of `B::State`
@@ -169,6 +170,7 @@ impl<B: Backend> Lock<(), B> {
=20
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected =
by it.
+    #[inline]
     pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existenc=
e of the object proves
         // that `init` was called.
@@ -182,6 +184,7 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Returns a guard that can be used to access the data protected by the=
 lock if successful.
     // `Option<T>` is not `#[must_use]` even if `T` is, thus the attribute i=
s needed here.
     #[must_use =3D "if unused, the lock will be immediately unlocked"]
+    #[inline]
     pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existenc=
e of the object proves
         // that `init` was called.
@@ -275,6 +278,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
     type Target =3D T;
=20
+    #[inline]
     fn deref(&self) -> &Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the prot=
ected data.
         unsafe { &*self.lock.data.get() }
@@ -285,6 +289,7 @@ impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard=
<'_, T, B>
 where
     T: Unpin,
 {
+    #[inline]
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the prot=
ected data.
         unsafe { &mut *self.lock.data.get() }
@@ -292,6 +297,7 @@ where
 }
=20
 impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
@@ -304,6 +310,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # Safety
     ///
     /// The caller must ensure that it owns the lock.
+    #[inline]
     pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         // SAFETY: The caller can only hold the lock if `Backend::init` has =
already been called.
         unsafe { B::assert_is_held(lock.state.get()) };
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index eab4810..aecbdc3 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -77,6 +77,7 @@ impl<B: GlobalLockBackend> GlobalLock<B> {
     }
=20
     /// Lock this global lock.
+    #[inline]
     pub fn lock(&'static self) -> GlobalGuard<B> {
         GlobalGuard {
             inner: self.inner.lock(),
@@ -84,6 +85,7 @@ impl<B: GlobalLockBackend> GlobalLock<B> {
     }
=20
     /// Try to lock this global lock.
+    #[inline]
     pub fn try_lock(&'static self) -> Option<GlobalGuard<B>> {
         Some(GlobalGuard {
             inner: self.inner.try_lock()?,
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 581cee7..cda0203 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -102,6 +102,7 @@ unsafe impl super::Backend for MutexBackend {
     type State =3D bindings::mutex;
     type GuardState =3D ();
=20
+    #[inline]
     unsafe fn init(
         ptr: *mut Self::State,
         name: *const crate::ffi::c_char,
@@ -112,18 +113,21 @@ unsafe impl super::Backend for MutexBackend {
         unsafe { bindings::__mutex_init(ptr, name, key) }
     }
=20
+    #[inline]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr=
` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::mutex_lock(ptr) };
     }
=20
+    #[inline]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState)=
 {
         // SAFETY: The safety requirements of this function ensure that `ptr=
` is valid and that the
         // caller is the owner of the mutex.
         unsafe { bindings::mutex_unlock(ptr) };
     }
=20
+    #[inline]
     unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initializ=
ed before use.
         let result =3D unsafe { bindings::mutex_trylock(ptr) };
@@ -135,6 +139,7 @@ unsafe impl super::Backend for MutexBackend {
         }
     }
=20
+    #[inline]
     unsafe fn assert_is_held(ptr: *mut Self::State) {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initializ=
ed before use.
         unsafe { bindings::mutex_assert_is_held(ptr) }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlo=
ck.rs
index d7be38c..ef76fa0 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -101,6 +101,7 @@ unsafe impl super::Backend for SpinLockBackend {
     type State =3D bindings::spinlock_t;
     type GuardState =3D ();
=20
+    #[inline]
     unsafe fn init(
         ptr: *mut Self::State,
         name: *const crate::ffi::c_char,
@@ -111,18 +112,21 @@ unsafe impl super::Backend for SpinLockBackend {
         unsafe { bindings::__spin_lock_init(ptr, name, key) }
     }
=20
+    #[inline]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr=
` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::spin_lock(ptr) }
     }
=20
+    #[inline]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState)=
 {
         // SAFETY: The safety requirements of this function ensure that `ptr=
` is valid and that the
         // caller is the owner of the spinlock.
         unsafe { bindings::spin_unlock(ptr) }
     }
=20
+    #[inline]
     unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initializ=
ed before use.
         let result =3D unsafe { bindings::spin_trylock(ptr) };
@@ -134,6 +138,7 @@ unsafe impl super::Backend for SpinLockBackend {
         }
     }
=20
+    #[inline]
     unsafe fn assert_is_held(ptr: *mut Self::State) {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initializ=
ed before use.
         unsafe { bindings::spin_assert_is_held(ptr) }

