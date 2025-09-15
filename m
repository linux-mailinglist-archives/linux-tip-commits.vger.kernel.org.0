Return-Path: <linux-tip-commits+bounces-6593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6779B571E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8BD173010
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313D2EA147;
	Mon, 15 Sep 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjS55T9c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5ZE/Xhe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178A2E62C0;
	Mon, 15 Sep 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922528; cv=none; b=bl2jmoyO3UM5m1BD5gUQDpPnjxTtq/eXnmRR/wJ7Genh20NwHpb6eLXGiqaikEw9OrVuxfoq2hOoNbPDrbH1xF99LPAJvOwg4a9tP0g+5hwfiBsHcnoMsR1dqxJBkI9g+D6PGcZGGSd83c+p6ZPtUi4U4HLMHPIv19UFjRZydJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922528; c=relaxed/simple;
	bh=PE2IuOjESfFpotEp0L0OEXppTC4zRGqOAX4giiJNQQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FMgnUc8RcR8v+L/PaQrowWnAfdUt/4KwtH+qLCB3IVF2OHtGwQikdmF2ZvR2HKhWX5dRrx+2wANVew2fuNZg2iS65b8UC8mj83z94sHWmNy+sdkygKqI2iFOxEEsJNLwmCmA+ICiNVEtfbCNyIZ5UV7WEY0ANwpvwV5GKMYdIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjS55T9c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5ZE/Xhe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG6BTM6jvvUylJi0dJDuOoICizOCFo6GiXgTDCZmyyc=;
	b=RjS55T9cRlg7TJyDCBZKT5sDeDxchXANlW9OZDanTYFHw73Vzd0VJKmme4dg2kxSi1HWmp
	0BEo47yEcHGmJEvbrdVZkIQLfxLvSWY/+MXRFP53qjd/oeVlzhhChjwfPtZpx6lc5IsvMB
	d1nalMqBo7cCeYYn/Uo/VFsBCHk1Ie22+1i99R/MDS0H9NVB8IdNzJBtlg22cHfFC1yFf2
	09K7klc6NxfcA7uqp5SrVKe6CWyHcwHq2LPU+MZ4GzeNiqU7g9Sq+uacPgeuxOpEPLC6+o
	sPOmc0Fbcc2+GzOnmVp4EW+7tMjHF+0nWOt2UUc7hOzSMGL92Bxxp3kcEvC/aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG6BTM6jvvUylJi0dJDuOoICizOCFo6GiXgTDCZmyyc=;
	b=t5ZE/XheWMWsLXX3iceGMrSI7r0rwWyOBDUK7W3naVHHVaKzJMt6EOSFDBoXF0ER19K1vh
	wW+0yd+DTNTwArBA==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: make `Arc::into_unique_or_drop` associated function
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Benno Lossin <lossin@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-12-boqun.feng@gmail.com>
References: <20250905044141.77868-12-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175792252340.709179.8168286407716631890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7487645f0b2d1a30590bafa7a977dc6661006d4f
Gitweb:        https://git.kernel.org/tip/7487645f0b2d1a30590bafa7a977dc66610=
06d4f
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:35 +02:00

rust: make `Arc::into_unique_or_drop` associated function

Make `Arc::into_unique_or_drop` to become a mere associated function
instead of a method (i.e. removing the `self` receiver).

It's a general convention for Rust smart pointers to avoid having
methods defined on them, because if the pointee type has a method of the
same name, then it is shadowed. This is normally for avoiding semver
breakage, which isn't an issue for kernel codebase, but it's still
generally a good practice to follow this rule, so that `ptr.foo()` would
always be calling a method on the pointee type.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/r/20250723233312.3304339-3-gary@kernel.org
---
 rust/kernel/sync/arc.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a6676..4ee155b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -321,7 +321,7 @@ impl<T: ?Sized> Arc<T> {
     /// use kernel::sync::{Arc, UniqueArc};
     ///
     /// let arc =3D Arc::new(42, GFP_KERNEL)?;
-    /// let unique_arc =3D arc.into_unique_or_drop();
+    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should succeed since refcount of `arc` is 1.
     /// assert!(unique_arc.is_some());
@@ -337,18 +337,18 @@ impl<T: ?Sized> Arc<T> {
     /// let arc =3D Arc::new(42, GFP_KERNEL)?;
     /// let another =3D arc.clone();
     ///
-    /// let unique_arc =3D arc.into_unique_or_drop();
+    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should fail since refcount of `arc` is >1.
     /// assert!(unique_arc.is_none());
     ///
     /// # Ok::<(), Error>(())
     /// ```
-    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disabl=
e the destructor.
-        let me =3D ManuallyDrop::new(self);
+        let this =3D ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount =3D unsafe { me.ptr.as_ref() }.refcount.get();
+        let refcount =3D unsafe { this.ptr.as_ref() }.refcount.get();
=20
         // If the refcount reaches a non-zero value, then we have destroyed =
this `Arc` and will
         // return without further touching the `Arc`. If the refcount reache=
s zero, then there are
@@ -365,7 +365,7 @@ impl<T: ?Sized> Arc<T> {
             // must pin the `UniqueArc` because the values was previously in=
 an `Arc`, and they pin
             // their values.
             Some(Pin::from(UniqueArc {
-                inner: ManuallyDrop::into_inner(me),
+                inner: ManuallyDrop::into_inner(this),
             }))
         } else {
             None

