Return-Path: <linux-tip-commits+bounces-6577-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DDB56020
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DF4AC0980
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E102EBDEA;
	Sat, 13 Sep 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xmvfb1Gm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYo1PNQN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DD2EBB8B;
	Sat, 13 Sep 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758535; cv=none; b=cu8YTv32eeyDzhpbbdq1fP1JxEqLaWxEz/kWai6A6BzKUJxituedhHdl5nTVM1zkju4zx5iBqgp9UZkEV/EX8ak7RQh2b8q32L/oIFhaSpmPdJpWX6OWWwDpColqWmVaLvvVOvkDVssjgRl3RZuHZf+hnsV8UA73CP/IjJ/5Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758535; c=relaxed/simple;
	bh=yIWykONBBcu8OtdBxiJQNDEUsUT2SE12jqXygvfbK/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cn3fb2nXW5xGyEQp+UTkHscp/z+iqHj7QcWmMRghpcQaaWdjQcKTIGJZw3+0ll6YD4fLiId+RVbve2J2zgpFNMGfds288e4pAK1qSasSEQwsuxgb4jlh966zPZz/8HF4u+YzJWYnJGax1NvkA7dCqho2ahd5JejEl3AW6Doq9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xmvfb1Gm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYo1PNQN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nltjzOD7mJYMiAjYObbJUNjszW/aQTrSdbtUzu0ODcs=;
	b=Xmvfb1GmH66DpzM/i9hXoOFVDD28bn6oEaXfxqLpOJOjB8snkvuQWMnnHF4+xXoVr2yrni
	JA3u7xfPHkx4Uv4IK7NmwVyPkgJTO4oWd1Y8kWvjaMirRWW/vdfV4I4MiWiUvHCzi/4R2J
	tHA6Y2ei4c0xEJRewhAWT+i9baFx4q2BYwfAzvnNSFt+LgFPvhXwxduL6MxDjadDafBsMz
	+aM8niBMKGnRvRblkivF78VF+xF1lw/hHWty7ca4cxBbpI1A0cjjgD1hTPzcvhOaGMtMCa
	eeW56ZfXYNbu9NwFyB+0MLJwzMlJfccOSquzRprc59tt199rncTp9QSo9R2oVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nltjzOD7mJYMiAjYObbJUNjszW/aQTrSdbtUzu0ODcs=;
	b=YYo1PNQNxbcbYvDEJhlRDz+P2e6NcPpg9uJ3/Xqyxz2723k9OPp5HWknP2vD0ChEosCEi/
	+gF3ZE/0GvrlSHDw==
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
Message-ID: <175775852994.709179.1112080420115135433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9c0200e40fac9abd06575e4d10a3c4e186cb0d80
Gitweb:        https://git.kernel.org/tip/9c0200e40fac9abd06575e4d10a3c4e186c=
b0d80
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:58 +02:00

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

