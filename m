Return-Path: <linux-tip-commits+bounces-7940-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C686AD183E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44BA5305A95C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA0392838;
	Tue, 13 Jan 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjbzomnw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yH2DLITx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B638BDAD;
	Tue, 13 Jan 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301417; cv=none; b=YdAMG3DpaRlKm5Pg5PkN5nyaTwRZYkL59M5DIyToi9No4x87hPn3tFgsBmEsubVSm3IabAwA8FB+Mw1mhhA/DzHXFglqSWUSFyk6ALq+f1luGa3NvRWeDX1k8tKyLfSPzPVAanVDnfIHL62ogtPAQTYac2JnJSOkgXMI+v+EDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301417; c=relaxed/simple;
	bh=WmqCIdPv0J/PyD/hcvYP16zlaat47/rK2ynqkKqb2vg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HXhT7guT6kkjfeHizMhMg12IXdCcVhESl0l9ORdUvb8GQOxk/a9f0+BksMvJgFAcAjC1BRyFeHb70CqeVFv24pqnzfAglR1Q8F7rNEqw4EvcvjOprv5cm8V9RpqrjwHh7EvP8MXzWH4SU9ckRHkP/N+adc1lDJg8Tq2zwER42l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qjbzomnw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yH2DLITx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vknKFGWMo4S2erudEHV2jo3H2+YLNhbXSLxChWXtA4Q=;
	b=qjbzomnwBg9jiNphOMdtPit+50R2+W2CrPk1G7DAXVeY7Kyq6oAZXUHtg9yNC0CnY0vmGS
	hc4xRQJKgB1ELihPWGmbDyQLDfxa42EWavIV5Peki5jrIHYPeS8K0CYH2rffPd/S4NWna8
	u4n+j+g7Nm90k5OGwWTDgp1vAH8q8XmBtJTEvFygu5eiCeKlNFK2JkmoKUir7NR10odNOa
	w/BL97hL+90H6Rlqy7wJ09kMk68g7gmHRD3Q5Ja8TQelE9mxzMDJukKrWxoyd6FeufCISP
	cWxmWphzHAcV7uqxDSx1gTsez1DZ9abDJ+1kUT7sSC+Ciifu2ZrPCSvGXrO22w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vknKFGWMo4S2erudEHV2jo3H2+YLNhbXSLxChWXtA4Q=;
	b=yH2DLITxAxohr9S+APYiu5w4SMqVWg5YcSvUhHxj90LF+6i+8PqIVGXXo3TcUkxAAHYLJN
	3PsjYgBZzUh+/tBw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Clean up LockClassKey and its docs
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250811-lock-class-key-cleanup-v3-2-b12967ee1ca2@google.com>
References: <20250811-lock-class-key-cleanup-v3-2-b12967ee1ca2@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830141190.510.6922144104670568329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     106ab474e5a711ea08e0908a42cfa89d691e57ad
Gitweb:        https://git.kernel.org/tip/106ab474e5a711ea08e0908a42cfa89d691=
e57ad
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 11 Aug 2025 12:14:42=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: sync: Clean up LockClassKey and its docs

Several aspects of the code and documentation for this type is
incomplete. Also several things are hidden from the docs. Thus, clean it
up and make it easier to read the rendered html docs.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20250811-lock-class-key-cleanup-v3-2-b12967ee1=
ca2@google.com
---
 rust/kernel/sync.rs | 54 ++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 1dfbee8..b10e576 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -32,7 +32,9 @@ pub use locked_by::LockedBy;
 pub use refcount::Refcount;
 pub use set_once::SetOnce;
=20
-/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
+/// Represents a lockdep class.
+///
+/// Wraps the kernel's `struct lock_class_key`.
 #[repr(transparent)]
 #[pin_data(PinnedDrop)]
 pub struct LockClassKey {
@@ -40,6 +42,10 @@ pub struct LockClassKey {
     inner: Opaque<bindings::lock_class_key>,
 }
=20
+// SAFETY: Unregistering a lock class key from a different thread than where=
 it was registered is
+// allowed.
+unsafe impl Send for LockClassKey {}
+
 // SAFETY: `bindings::lock_class_key` is designed to be used concurrently fr=
om multiple threads and
 // provides its own synchronization.
 unsafe impl Sync for LockClassKey {}
@@ -47,28 +53,31 @@ unsafe impl Sync for LockClassKey {}
 impl LockClassKey {
     /// Initializes a statically allocated lock class key.
     ///
-    /// This is usually used indirectly through the [`static_lock_class!`] m=
acro.
+    /// This is usually used indirectly through the [`static_lock_class!`] m=
acro. See its
+    /// documentation for more information.
     ///
     /// # Safety
     ///
     /// * Before using the returned value, it must be pinned in a static mem=
ory location.
     /// * The destructor must never run on the returned `LockClassKey`.
-    #[doc(hidden)]
     pub const unsafe fn new_static() -> Self {
         LockClassKey {
             inner: Opaque::uninit(),
         }
     }
=20
-    /// Initializes a dynamically allocated lock class key. In the common ca=
se of using a
-    /// statically allocated lock class key, the static_lock_class! macro sh=
ould be used instead.
+    /// Initializes a dynamically allocated lock class key.
+    ///
+    /// In the common case of using a statically allocated lock class key, t=
he
+    /// [`static_lock_class!`] macro should be used instead.
     ///
     /// # Examples
+    ///
     /// ```
-    /// # use kernel::alloc::KBox;
-    /// # use kernel::types::ForeignOwnable;
-    /// # use kernel::sync::{LockClassKey, SpinLock};
-    /// # use pin_init::stack_pin_init;
+    /// use kernel::alloc::KBox;
+    /// use kernel::types::ForeignOwnable;
+    /// use kernel::sync::{LockClassKey, SpinLock};
+    /// use pin_init::stack_pin_init;
     ///
     /// let key =3D KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
     /// let key_ptr =3D key.into_foreign();
@@ -86,7 +95,6 @@ impl LockClassKey {
     /// // SAFETY: We dropped `num`, the only use of the key, so the result =
of the previous
     /// // `borrow` has also been dropped. Thus, it's safe to use from_forei=
gn.
     /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_fore=
ign(key_ptr)) };
-    ///
     /// # Ok::<(), Error>(())
     /// ```
     pub fn new_dynamic() -> impl PinInit<Self> {
@@ -96,7 +104,10 @@ impl LockClassKey {
         })
     }
=20
-    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
+    /// Returns a raw pointer to the inner C struct.
+    ///
+    /// It is up to the caller to use the raw pointer correctly.
+    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.inner.get()
     }
 }
@@ -104,14 +115,28 @@ impl LockClassKey {
 #[pinned_drop]
 impl PinnedDrop for LockClassKey {
     fn drop(self: Pin<&mut Self>) {
-        // SAFETY: self.as_ptr was registered with lockdep and self is pinne=
d, so the address
-        // hasn't changed. Thus, it's safe to pass to unregister.
+        // SAFETY: `self.as_ptr()` was registered with lockdep and `self` is=
 pinned, so the address
+        // hasn't changed. Thus, it's safe to pass it to unregister.
         unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
=20
 /// Defines a new static lock class and returns a pointer to it.
-#[doc(hidden)]
+///
+/// # Examples
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::sync::{static_lock_class, Arc, SpinLock};
+///
+/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
+///     Arc::pin_init(SpinLock::new(
+///         42,
+///         c_str!("new_locked_int"),
+///         static_lock_class!(),
+///     ), GFP_KERNEL)
+/// }
+/// ```
 #[macro_export]
 macro_rules! static_lock_class {
     () =3D> {{
@@ -122,6 +147,7 @@ macro_rules! static_lock_class {
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
+pub use static_lock_class;
=20
 /// Returns the given string, if one is provided, otherwise generates one ba=
sed on the source code
 /// location.

