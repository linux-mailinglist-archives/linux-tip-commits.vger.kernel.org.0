Return-Path: <linux-tip-commits+bounces-7941-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32AD183EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4983E30196B0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E63815F2;
	Tue, 13 Jan 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZN7C5F29";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMBNXC6u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5F38BDB7;
	Tue, 13 Jan 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301419; cv=none; b=clMkr0DT6XNpK6AJX1v/5oFhNrrPJsKVDTnBvEOdRTkeZIaCksleuOZmCP9K8rExvH22ulJVqHvhJyxCGOom8uuCHS9P76DEjeXkbNFL5xfLlyLfnrUbfF58DdpeuKbFoGPH1j7Detsw+SwaqohgW4xS4JpMFJvu9eOkAwxELyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301419; c=relaxed/simple;
	bh=aWUrCfUhtSIPkdrYr27WA0BcnqdHyCeO4Ij7EQ1aWrI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OJ6gAxqmJ27V9lJ/9bdQbcTiuMp4MKNGNWHLofF31DIrgEgrxzle8SJwxwuLcQM/inHFu8er4Ffxhb0nB+pTT65u6B18mExd+DMyJRzbqST9W2719V2rDgkaaCP0YY+ikliOv9QTGVgN4iAfOkiLdMfDB4YOmx/KOb0xNdrvAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZN7C5F29; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMBNXC6u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7WtSOcvZwiBPb2mV11WKiwybrIXCGL2TouTg+UekkM=;
	b=ZN7C5F29IXcbh56G5RVm+oGJBWIzVgYbyFvcp908FHd0uMrtE8P3j7P74m1vCs1bGvEHBH
	IrOrb/jsXm2uX3oj3y+xVPN+/yT/2BtHtYMLFq5EDEtkUjnWjuIIQoDr4kVxOlhASDeX6g
	lz2JrvBgVV0W12KLiyYXvPjNGG7Nsl7OhrmPISks3qNbRJP3JJsJMU55LCW8MNwUstE0pQ
	Yiu6nYMctrROy3UcglztKIUVATk70IhAp++MGbPkVL7zE99y2yQsTlQE0xY9MDx6mAIdOz
	t4gkfZlqFfzcdpp6I6NsGBG4sfSSBCa1WoOz+y61mSYFd4eqc9M/jVKpAFys2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7WtSOcvZwiBPb2mV11WKiwybrIXCGL2TouTg+UekkM=;
	b=sMBNXC6uHsxZHu3eOXlrc9DvXhcdOCtvmVd4w3mTIKl/VAGMg6sQcioZt1niApd0pYjvnZ
	U/qLfVmUU2kGEuDw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Refactor static_lock_class!() macro
Cc: Benno Lossin <lossin@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811-lock-class-key-cleanup-v3-1-b12967ee1ca2@google.com>
References: <20250811-lock-class-key-cleanup-v3-1-b12967ee1ca2@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830141294.510.3601508695543927072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     86f4a271dc1962e389ea512d07a77626dbd8c1d8
Gitweb:        https://git.kernel.org/tip/86f4a271dc1962e389ea512d07a77626dbd=
8c1d8
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 11 Aug 2025 12:14:41=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: sync: Refactor static_lock_class!() macro

By introducing a new_static() constructor, the macro does not need to go
through MaybeUninit::uninit().assume_init(), which is a pattern that is
best avoided when possible.

The safety comment not only requires that the value is leaked, but also
that it is stored in the right portion of memory. This is so that the
lockdep static_obj() check will succeed when using this constructor. One
could argue that lockdep detects this scenario, so that safety
requirement isn't needed. However, it simplifies matters to require that
static_obj() will succeed and it's not a burdensome requirement on the
caller.

Suggested-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20250811-lock-class-key-cleanup-v3-1-b12967ee1=
ca2@google.com
---
 rust/kernel/sync.rs | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 5df87e2..1dfbee8 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -45,6 +45,21 @@ pub struct LockClassKey {
 unsafe impl Sync for LockClassKey {}
=20
 impl LockClassKey {
+    /// Initializes a statically allocated lock class key.
+    ///
+    /// This is usually used indirectly through the [`static_lock_class!`] m=
acro.
+    ///
+    /// # Safety
+    ///
+    /// * Before using the returned value, it must be pinned in a static mem=
ory location.
+    /// * The destructor must never run on the returned `LockClassKey`.
+    #[doc(hidden)]
+    pub const unsafe fn new_static() -> Self {
+        LockClassKey {
+            inner: Opaque::uninit(),
+        }
+    }
+
     /// Initializes a dynamically allocated lock class key. In the common ca=
se of using a
     /// statically allocated lock class key, the static_lock_class! macro sh=
ould be used instead.
     ///
@@ -101,12 +116,9 @@ impl PinnedDrop for LockClassKey {
 macro_rules! static_lock_class {
     () =3D> {{
         static CLASS: $crate::sync::LockClassKey =3D
-            // Lockdep expects uninitialized memory when it's handed a stati=
cally allocated `struct
-            // lock_class_key`.
-            //
-            // SAFETY: `LockClassKey` transparently wraps `Opaque` which per=
mits uninitialized
-            // memory.
-            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
+            // SAFETY: The returned `LockClassKey` is stored in static memor=
y and we pin it. Drop
+            // never runs on a static global.
+            unsafe { $crate::sync::LockClassKey::new_static() };
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }

