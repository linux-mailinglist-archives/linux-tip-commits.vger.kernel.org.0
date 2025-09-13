Return-Path: <linux-tip-commits+bounces-6578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8DB56023
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113811B2231D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F72EC560;
	Sat, 13 Sep 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WX6p9Lr/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFMLLVlh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049332EC082;
	Sat, 13 Sep 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758538; cv=none; b=K+AyzcSD6+Xq7XoBOGfvHTDlqsHVj1m4NwsJETFcEchLTDY9d7Mp6+wgUL6fmUcETgB6hOYVd/nCazVClxKwC9mlCSih6rwhroPE1TD8A5EB05Q15Gb8Sy8BlAooaoj/0WF+MAuZ+6ZwlSaWL2rzIdVhwTAjhKMk2u8uRYxEJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758538; c=relaxed/simple;
	bh=7enHDs5NldRsjNpE6QdPsUp8jEzVcpwoYYFS/xMuv/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pscuw996t+nuxTwghwYp4KL8gZyWy3j3QUYn8ggRvS9vyhtGzolYQtgBG17BybaU3nVCQjdh7hpFBJHfewjrMKFYAEgjzQzAalxt7f0hZZdvIJrMBsl1sW3Re4zaPnxdKimQ+eyH0MR51TVcprwuti854l49tpPkyjOywI9t8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WX6p9Lr/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFMLLVlh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flZT9UxevPGU2GLyE78Nr1Yp1/iC7CNvDl1iK2q9UjM=;
	b=WX6p9Lr/kAKcRYKQ4vZrNtx32igAFvBwh8GqDk3f+I00FBcOEMWhAdRXHjyrVng14T77lQ
	bK8uJQJpUNABTDq8bCucjdBg62OEwXNE2+rZpN+KCMlt1y0E1wQFUXlr5AfBm3iaq1Toxs
	nXk/Rs6oDqegg1I1S/pDs2DrRqukyumUFSVOtFYVfb9uE6TiyjJMiYOX/qxHH6Iu1u3yqj
	kdcG/XR7Xeq43IV+TNZgbHKt3xx9OlnfNsP5CUa3LIxeLb+ZjE1RJZf66cDBvZ/9+gjXgx
	BBMcO4jVwkCvBAsTD2zHDzRWUEU0K+lXjgp5BHuh/dly34UjNw56T9+gqMfj4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flZT9UxevPGU2GLyE78Nr1Yp1/iC7CNvDl1iK2q9UjM=;
	b=hFMLLVlhjyivID3qYNv0qJ1rd6i5XTvVoSlU44Rq/TuG+r3yI/eRVXVMgXNybUdewmgQU9
	KLncJK3Lslxl2iAw==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: implement `kernel::sync::Refcount`
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Fiona Behrens <me@kloenk.dev>,
 Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-11-boqun.feng@gmail.com>
References: <20250905044141.77868-11-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853112.709179.8528529651013236147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a14d23ff48481c999837bfaf8d4e8969f0bf8381
Gitweb:        https://git.kernel.org/tip/a14d23ff48481c999837bfaf8d4e8969f0b=
f8381
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:58 +02:00

rust: implement `kernel::sync::Refcount`

This is a wrapping layer of `include/linux/refcount.h`. Currently the
kernel refcount has already been used in `Arc`, however it calls into
FFI directly.

[boqun: Add the missing <> for the link in comment]
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/r/20250723233312.3304339-2-gary@kernel.org
---
 rust/helpers/refcount.c      | 10 ++++-
 rust/kernel/sync.rs          |  2 +-
 rust/kernel/sync/refcount.rs | 98 +++++++++++++++++++++++++++++++++++-
 3 files changed, 110 insertions(+)
 create mode 100644 rust/kernel/sync/refcount.rs

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2..d175898 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 	return (refcount_t)REFCOUNT_INIT(n);
 }
=20
+void rust_helper_refcount_set(refcount_t *r, int n)
+{
+	refcount_set(r, n);
+}
+
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
=20
+void rust_helper_refcount_dec(refcount_t *r)
+{
+	refcount_dec(r);
+}
+
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index bf8943c..cf5b638 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -19,6 +19,7 @@ pub mod lock;
 mod locked_by;
 pub mod poll;
 pub mod rcu;
+mod refcount;
=20
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
@@ -27,6 +28,7 @@ pub use lock::global::{global_lock, GlobalGuard, GlobalLock=
, GlobalLockBackend,=20
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
+pub use refcount::Refcount;
=20
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
new file mode 100644
index 0000000..cc1a80a
--- /dev/null
+++ b/rust/kernel/sync/refcount.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference counting.
+//!
+//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
+
+use crate::build_assert;
+use crate::types::Opaque;
+
+/// Atomic reference counter.
+///
+/// This type is conceptually an atomic integer, but provides saturation sem=
antics compared to
+/// normal atomic integers. Values in the negative range when viewed as a si=
gned integer are
+/// saturation (bad) values. For details about the saturation semantics, ple=
ase refer to top of
+/// [`include/linux/refcount.h`](srctree/include/linux/refcount.h).
+///
+/// Wraps the kernel's C `refcount_t`.
+#[repr(transparent)]
+pub struct Refcount(Opaque<bindings::refcount_t>);
+
+impl Refcount {
+    /// Construct a new [`Refcount`] from an initial value.
+    ///
+    /// The initial value should be non-saturated.
+    #[inline]
+    pub fn new(value: i32) -> Self {
+        build_assert!(value >=3D 0, "initial value saturated");
+        // SAFETY: There are no safety requirements for this FFI call.
+        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *mut bindings::refcount_t {
+        self.0.get()
+    }
+
+    /// Set a refcount's value.
+    #[inline]
+    pub fn set(&self, value: i32) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_set(self.as_ptr(), value) }
+    }
+
+    /// Increment a refcount.
+    ///
+    /// It will saturate if overflows and `WARN`. It will also `WARN` if the=
 refcount is 0, as this
+    /// represents a possible use-after-free condition.
+    ///
+    /// Provides no memory ordering, it is assumed that caller already has a=
 reference on the
+    /// object.
+    #[inline]
+    pub fn inc(&self) {
+        // SAFETY: self is valid.
+        unsafe { bindings::refcount_inc(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores a=
re done
+    /// before.
+    #[inline]
+    pub fn dec(&self) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount and test if it is 0.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores a=
re done
+    /// before, and provides an acquire ordering on success such that memory=
 deallocation
+    /// must come after.
+    ///
+    /// Returns true if the resulting refcount is 0, false otherwise.
+    ///
+    /// # Notes
+    ///
+    /// A common pattern of using `Refcount` is to free memory when the refe=
rence count reaches
+    /// zero. This means that the reference to `Refcount` could become inval=
id after calling this
+    /// function. This is fine as long as the reference to `Refcount` is no =
longer used when this
+    /// function returns `false`. It is not necessary to use raw pointers in=
 this scenario, see
+    /// <https://github.com/rust-lang/rust/issues/55005>.
+    #[inline]
+    #[must_use =3D "use `dec` instead if you do not need to test if it is 0"]
+    pub fn dec_and_test(&self) -> bool {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
+    }
+}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Send for Refcount {}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Sync for Refcount {}

