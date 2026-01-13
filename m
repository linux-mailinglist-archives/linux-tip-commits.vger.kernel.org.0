Return-Path: <linux-tip-commits+bounces-7920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB2D18358
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89E3F3020092
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77538E139;
	Tue, 13 Jan 2026 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2dHZzkp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUCBYQIk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1138E129;
	Tue, 13 Jan 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301398; cv=none; b=m9obqPTxVsAZUSly9S6NsDmPYrJt0mqqQdozEb0xtf8Ff0kIPSxpQykAfuT+8mSUid27cp/c+GGIMOgoBc3piUpwPqYNQETTaOgKgjUSIxA3s2Bhc8t3KlwlpRXLeCXHFXhy6DbBXDNZoLJkc35FujSuVwWajMaBFYARGiHx170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301398; c=relaxed/simple;
	bh=li6JAxKBckjlSWvZUWIL1KWmNwPZ4C0+b5zXip2QLCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uVwGQ/rEU+jKGo0JcuSRP/X3gXg5aEwCjZbfhunUXs2whwuZmy0iO0QHwebgl83wtA4JFD+7mnYnCD95c2Rz3FSwGOaz1NlW8EGmWkK+6tSLpzkTXy0nwDapQ8VVfwlDLxuI8vjSlpSZqVeNcW0pzPOw+pP7xX+nE5vdWoqraFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2dHZzkp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUCBYQIk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7eE1GrhUugSRHazRrCNofuz6YRxvzppF1dLilCYreY=;
	b=a2dHZzkpGhHQh+t7yfVK7DhwlUXx4IeeoXzyQYDtly+jPQw204jJ69AUFehZvtbV/ILfc9
	qYG7v/lXQpfGxb2nYsb320vCmxbedNhWm2YjVjGSRAiSbRgc86PY+Kad4t9oGezAMBQ5oJ
	pnp+ogK35CdHPSMMGo2nntdoVsZD7//tOF6icGivZP3yvlKCx2bcf7KOJzO4lhKocUxtx0
	O1Qys4vSb7D+MEEdTDe2WaaRSdXqLby19safam8SdirMX9ptNX+xwUqrLqS4cj1f27CvKP
	MbTVljMiEzWQ4YCRyxWplba7Plc0msA0I1swR/p7bdJnsULpid+so7M6frhj0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7eE1GrhUugSRHazRrCNofuz6YRxvzppF1dLilCYreY=;
	b=RUCBYQIkiQvcBfb2YifPrJBkFDF/j64f7SaUdJsGJmffWgr7fR+w/E+DUsWgvTNqY0DNt+
	iYBUuiDAQ9wSi3AQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: list: Switch to kernel::sync atomic primitives
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251230093718.1852322-3-fujita.tomonori@gmail.com>
References: <20251230093718.1852322-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138984.510.12031634682208427016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     323e4bfcbe2dc6c6cac6e007dded0ba4f89a6458
Gitweb:        https://git.kernel.org/tip/323e4bfcbe2dc6c6cac6e007dded0ba4f89=
a6458
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 30 Dec 2025 18:37:17 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: list: Switch to kernel::sync atomic primitives

Convert uses of `AtomicBool` to `Atomic<bool>`.

Note that the compare_exchange migration simplifies to
`try_cmpxchg()`, since `try_cmpxchg()` provides relaxed ordering on
failure, making the explicit failure ordering unnecessary.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251230093718.1852322-3-fujita.tomonori@gmail=
.com
---
 rust/kernel/list/arc.rs | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index d92bcf6..2282f33 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -6,11 +6,11 @@
=20
 use crate::alloc::{AllocError, Flags};
 use crate::prelude::*;
+use crate::sync::atomic::{ordering, Atomic};
 use crate::sync::{Arc, ArcBorrow, UniqueArc};
 use core::marker::PhantomPinned;
 use core::ops::Deref;
 use core::pin::Pin;
-use core::sync::atomic::{AtomicBool, Ordering};
=20
 /// Declares that this type has some way to ensure that there is exactly one=
 `ListArc` instance for
 /// this id.
@@ -469,7 +469,7 @@ where
 /// If the boolean is `false`, then there is no [`ListArc`] for this value.
 #[repr(transparent)]
 pub struct AtomicTracker<const ID: u64 =3D 0> {
-    inner: AtomicBool,
+    inner: Atomic<bool>,
     // This value needs to be pinned to justify the INVARIANT: comment in `A=
tomicTracker::new`.
     _pin: PhantomPinned,
 }
@@ -480,12 +480,12 @@ impl<const ID: u64> AtomicTracker<ID> {
         // INVARIANT: Pin-init initializers can't be used on an existing `Ar=
c`, so this value will
         // not be constructed in an `Arc` that already has a `ListArc`.
         Self {
-            inner: AtomicBool::new(false),
+            inner: Atomic::new(false),
             _pin: PhantomPinned,
         }
     }
=20
-    fn project_inner(self: Pin<&mut Self>) -> &mut AtomicBool {
+    fn project_inner(self: Pin<&mut Self>) -> &mut Atomic<bool> {
         // SAFETY: The `inner` field is not structurally pinned, so we may o=
btain a mutable
         // reference to it even if we only have a pinned reference to `self`.
         unsafe { &mut Pin::into_inner_unchecked(self).inner }
@@ -500,7 +500,7 @@ impl<const ID: u64> ListArcSafe<ID> for AtomicTracker<ID>=
 {
=20
     unsafe fn on_drop_list_arc(&self) {
         // INVARIANT: We just dropped a ListArc, so the boolean should be fa=
lse.
-        self.inner.store(false, Ordering::Release);
+        self.inner.store(false, ordering::Release);
     }
 }
=20
@@ -514,8 +514,6 @@ unsafe impl<const ID: u64> TryNewListArc<ID> for AtomicTr=
acker<ID> {
     fn try_new_list_arc(&self) -> bool {
         // INVARIANT: If this method returns true, then the boolean used to =
be false, and is no
         // longer false, so it is okay for the caller to create a new [`List=
Arc`].
-        self.inner
-            .compare_exchange(false, true, Ordering::Acquire, Ordering::Rela=
xed)
-            .is_ok()
+        self.inner.cmpxchg(false, true, ordering::Acquire).is_ok()
     }
 }

