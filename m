Return-Path: <linux-tip-commits+bounces-6596-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99908B571EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D25189F0F6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247B2EAB89;
	Mon, 15 Sep 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQvpxwb4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy+7R2xZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC852EA482;
	Mon, 15 Sep 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922531; cv=none; b=c2H/vQ1x3zaXl4VJ2o+JtGHHwZnB6ClhLgj7l6Zo5/9SBwtv9c60H1y4yNaHm6SOLlRWXLEprzoZA2VzkaqBKZzMWIVfeda9YkzFHTBH6KgCo4EAZ1UWoAxdle2ixetaRi7+o1oQHnDk6K0YnUrNp7DTrXLrSSJhS5eYktyHzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922531; c=relaxed/simple;
	bh=mBeg18AYXmjQJFtEYXFXRVZlRnKGTReRu+wIjLPwKeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d2jMw+rY/BQLFulLQgQLjJaBiWqSqNOHh0PCCILTLgOR3py5d5vLHgIRAIMSsoF8qBLGLmlhVbUtW61Mhtijgkr8xAX2hfvdeYSFxo4JlbawCzJU3cctoMcgprqxAjt7iUSd/GnYTYZtEkB2RbjPPXBAl32LSfVOcnpuCFXLmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQvpxwb4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yy+7R2xZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycG0sH2TrOZjA3AIDiass36lOJ42sagK2aVY/8VxLnI=;
	b=YQvpxwb4XpafxDcaSgLHE9BlUeECiog9HFHl7816z7mLe2UCcSDAqIieBhriyFmVmrRjSM
	XxIy/9R0YBJ3uDmkzsGnkH/URugvolaAQVbhrDd2ULabRz5bBLMvqNxoSgh5dYNor5T56l
	GBKsKOABNnLiVTNCjlGMNPy06cV7Delw9sPKXdQ7Ti7OUGUP3fpfvEGSd/TnMEQl25r0fZ
	LBdc3+/ofnbXmdsYCTCF9aS7pDFI/t67c+BUJ2d0n5VzjEzyf1ETn2SMQFFpVRkCe57K0x
	NelnRdfkc10XqwQEO+UGSDRIU5BHFoR3vr3VCgcKs2JcLk8z5D6VlSnBR/wnog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycG0sH2TrOZjA3AIDiass36lOJ42sagK2aVY/8VxLnI=;
	b=Yy+7R2xZRudS3KT5ksYt1iQmRJoy9wpENQ+wheipJdyI8vxyubDFsyze9UxjWD9zlrj7yI
	AzPk/JOxQAp43pCw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add memory barriers
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Elle Rhumsaa <elle@weathered-steel.dev>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-10-boqun.feng@gmail.com>
References: <20250905044141.77868-10-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175792252554.709179.6048016421135313777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d9ea5a41cef80dc8103f4114b072b27364f2e06a
Gitweb:        https://git.kernel.org/tip/d9ea5a41cef80dc8103f4114b072b27364f=
2e06a
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 04 Sep 2025 21:41:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:34 +02:00

rust: sync: Add memory barriers

Memory barriers are building blocks for concurrent code, hence provide
a minimal set of them.

The compiler barrier, barrier(), is implemented in inline asm instead of
using core::sync::atomic::compiler_fence() because memory models are
different: kernel's atomics are implemented in inline asm therefore the
compiler barrier should be implemented in inline asm as well. Also it's
currently only public to the kernel crate until there's a reasonable
driver usage.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Link: https://lore.kernel.org/all/20250719030827.61357-10-boqun.feng@gmail.co=
m/
---
 rust/helpers/barrier.c      | 18 +++++++++++-
 rust/helpers/helpers.c      |  1 +-
 rust/kernel/sync.rs         |  1 +-
 rust/kernel/sync/barrier.rs | 61 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+)
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/barrier.rs

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
new file mode 100644
index 0000000..cdf28ce
--- /dev/null
+++ b/rust/helpers/barrier.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rust_helper_smp_mb(void)
+{
+	smp_mb();
+}
+
+void rust_helper_smp_wmb(void)
+{
+	smp_wmb();
+}
+
+void rust_helper_smp_rmb(void)
+{
+	smp_rmb();
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7053f92..85ad14b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
=20
 #include "atomic.c"
 #include "auxiliary.c"
+#include "barrier.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 7e962e5..bf8943c 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -12,6 +12,7 @@ use pin_init;
 mod arc;
 pub mod aref;
 pub mod atomic;
+pub mod barrier;
 pub mod completion;
 mod condvar;
 pub mod lock;
diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
new file mode 100644
index 0000000..8f2d435
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory barriers.
+//!
+//! These primitives have the same semantics as their C counterparts: and th=
e precise definitions
+//! of semantics can be found at [`LKMM`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+/// A compiler barrier.
+///
+/// A barrier that prevents compiler from reordering memory accesses across =
the barrier.
+#[inline(always)]
+pub(crate) fn barrier() {
+    // By default, Rust inline asms are treated as being able to access any =
memory or flags, hence
+    // it suffices as a compiler barrier.
+    //
+    // SAFETY: An empty asm block.
+    unsafe { core::arch::asm!("") };
+}
+
+/// A full memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory accesses=
 across the barrier.
+#[inline(always)]
+pub fn smp_mb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_mb()` is safe to call.
+        unsafe { bindings::smp_mb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A write-write memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory write ac=
cesses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_wmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_wmb()` is safe to call.
+        unsafe { bindings::smp_wmb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A read-read memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory read acc=
esses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_rmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_rmb()` is safe to call.
+        unsafe { bindings::smp_rmb() };
+    } else {
+        barrier();
+    }
+}

