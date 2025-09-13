Return-Path: <linux-tip-commits+bounces-6585-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB07DB56029
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611FE7B8F67
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B72EE27A;
	Sat, 13 Sep 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRPpLk7w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qs6hHTMP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1E2ECD2C;
	Sat, 13 Sep 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758545; cv=none; b=kXKxab8scp1JQxDQ0F9cPYqY9XieaqZBy+lgzEH3j81alSy/KcXpESVzpyNTMcQEf7Jesw5qAsFFRmLjh/R1hMpHeDScWpj1OdDYBhLu6pfj7P285tvuJWgU21u19S+dzQ46UGeLqkskv9/kprI8gYjDPZAaJrq1FjBvuASBIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758545; c=relaxed/simple;
	bh=XlcwlKCqvMfPOMcpafTsV6iJ8wKEwmWaYaWQCsgqYbg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pPn6ZR/EYGy5oNkjc4FZaJBAuXViD09DRM5Di7H1lFtPJommHENmsyRReuKnBM88+NZv2eV9/+YHQTXbs8evFXrePjm8EOSMD70Y5uIBvhRdD0+6Y+gJeNOJPystuyY0NVPhpCJmBYmSo16gYnHu5F5EAL5lcK7EmtJlmnBuXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRPpLk7w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qs6hHTMP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyQsY/ErPDd46iQ6VFAbhZQLAUNTmsKcUeqMH8H1ZTE=;
	b=jRPpLk7wwWhKyTkQz8obpQ9hZrmVMGxUTNIQOZnshSQKipn2OECmmznuKwAmDR35Ed2QK+
	hW0lOjEwGQpo6qqyvNlUKEnEKaMsazopj1EPwHSdmnX2af+k4LEIgEijMvVwtHncSlZktd
	b8np70+PtlCLT+VbCnBtfUEznWJHFfKjhV67QItjD5JlEY23jof2wZZnDA9CYMbbvagvD2
	5TbCpgr8MjW/ODGwCuwHGH5LWfG9Kxc6p6k7M9yTvuUKPNXr3Dxto/vw17ernk4wKPCFur
	V27lMclyxGvKL1s7rl0ftlN1bUrN5xvE+TrtefqCqorfE7XqZ9m/QVN5WupdvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyQsY/ErPDd46iQ6VFAbhZQLAUNTmsKcUeqMH8H1ZTE=;
	b=qs6hHTMPocaN5U0p3NLWiVpKFw6LukNEi8KrRUhw83qsVpDI/fP4o5lKXtVft1Hh3kSGWJ
	SqOXwlHMCQfy7rDg==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add ordering annotation types
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-4-boqun.feng@gmail.com>
References: <20250905044141.77868-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775853943.709179.13099431230232978381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8dedebb3377b5b28e6834627c55c30d9daf7a9b8
Gitweb:        https://git.kernel.org/tip/8dedebb3377b5b28e6834627c55c30d9daf=
7a9b8
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:56 +02:00

rust: sync: atomic: Add ordering annotation types

Preparation for atomic primitives. Instead of a suffix like _acquire, a
method parameter along with the corresponding generic parameter will be
used to specify the ordering of an atomic operations. For example,
atomic load() can be defined as:

	impl<T: ...> Atomic<T> {
	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
	}

and acquire users would do:

	let r =3D x.load(Acquire);

relaxed users:

	let r =3D x.load(Relaxed);

doing the following:

	let r =3D x.load(Release);

will cause a compiler error.

Compared to suffixes, it's easier to tell what ordering variants an
operation has, and it also make it easier to unify the implementation of
all ordering variants in one method via generic. The `TYPE` associate
const is for generic function to pick up the particular implementation
specified by an ordering annotation.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-4-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs          |   2 +-
 rust/kernel/sync/atomic/ordering.rs | 104 +++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/ordering.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index b9f2f47..2302e6d 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -18,5 +18,7 @@
=20
 #[allow(dead_code, unreachable_pub)]
 mod internal;
+pub mod ordering;
=20
 pub use internal::AtomicImpl;
+pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/or=
dering.rs
new file mode 100644
index 0000000..3f103aa
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory orderings.
+//!
+//! The semantics of these orderings follows the [`LKMM`] definitions and ru=
les.
+//!
+//! - [`Acquire`] provides ordering between the load part of the annotated o=
peration and all the
+//!   following memory accesses, and if there is a store part, the store par=
t has the [`Relaxed`]
+//!   ordering.
+//! - [`Release`] provides ordering between all the preceding memory accesse=
s and the store part of
+//!   the annotated operation, and if there is a load part, the load part ha=
s the [`Relaxed`]
+//!   ordering.
+//! - [`Full`] means "fully-ordered", that is:
+//!   - It provides ordering between all the preceding memory accesses and t=
he annotated operation.
+//!   - It provides ordering between the annotated operation and all the fol=
lowing memory accesses.
+//!   - It provides ordering between all the preceding memory accesses and a=
ll the following memory
+//!     accesses.
+//!   - All the orderings are the same strength as a full memory barrier (i.=
e. `smp_mb()`).
+//! - [`Relaxed`] provides no ordering except the dependency orderings. Depe=
ndency orderings are
+//!   described in "DEPENDENCY RELATIONS" in [`LKMM`]'s [`explanation`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
+
+/// The annotation type for relaxed memory ordering, for the description of =
relaxed memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Relaxed;
+
+/// The annotation type for acquire memory ordering, for the description of =
acquire memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Acquire;
+
+/// The annotation type for release memory ordering, for the description of =
release memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Release;
+
+/// The annotation type for fully-ordered memory ordering, for the descripti=
on fully-ordered memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Full;
+
+/// Describes the exact memory ordering.
+#[doc(hidden)]
+pub enum OrderingType {
+    /// Relaxed ordering.
+    Relaxed,
+    /// Acquire ordering.
+    Acquire,
+    /// Release ordering.
+    Release,
+    /// Fully-ordered.
+    Full,
+}
+
+mod internal {
+    /// Sealed trait, can be only implemented inside atomic mod.
+    pub trait Sealed {}
+
+    impl Sealed for super::Relaxed {}
+    impl Sealed for super::Acquire {}
+    impl Sealed for super::Release {}
+    impl Sealed for super::Full {}
+}
+
+/// The trait bound for annotating operations that support any ordering.
+pub trait Ordering: internal::Sealed {
+    /// Describes the exact memory ordering.
+    const TYPE: OrderingType;
+}
+
+impl Ordering for Relaxed {
+    const TYPE: OrderingType =3D OrderingType::Relaxed;
+}
+
+impl Ordering for Acquire {
+    const TYPE: OrderingType =3D OrderingType::Acquire;
+}
+
+impl Ordering for Release {
+    const TYPE: OrderingType =3D OrderingType::Release;
+}
+
+impl Ordering for Full {
+    const TYPE: OrderingType =3D OrderingType::Full;
+}
+
+/// The trait bound for operations that only support acquire or relaxed orde=
ring.
+pub trait AcquireOrRelaxed: Ordering {}
+
+impl AcquireOrRelaxed for Acquire {}
+impl AcquireOrRelaxed for Relaxed {}
+
+/// The trait bound for operations that only support release or relaxed orde=
ring.
+pub trait ReleaseOrRelaxed: Ordering {}
+
+impl ReleaseOrRelaxed for Release {}
+impl ReleaseOrRelaxed for Relaxed {}

