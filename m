Return-Path: <linux-tip-commits+bounces-6976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF18BF5CD8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BBA1895335
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808632E68E;
	Tue, 21 Oct 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7iBdWou";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xvz+ojos"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B732D7C8;
	Tue, 21 Oct 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042934; cv=none; b=au03tefWoswigIj8LHKGIrlcwmxaOyosQqcT4UoCZDW6xbjk2tG+j8THipl/NDwCs9VFiaBS504tT6uCaTWOZwa5nNb2AXMGYHDk1I/+zhlElJoM1svWP+qRcC2Fh7z0HaikoPFs1r/7MFZFxnlH3cgmq5LBIn5AkiPWwoatpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042934; c=relaxed/simple;
	bh=5XCEwYz6NxJvTmvQH5Jx5ugeq63lHPBUCNNfaMKQOQM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UxqkEDGm4iNhpf6t4VNFfG+tPloNxlo5X7A4ClAJn9rO7qHgfFmWtc+UhvXqGVcoxFQcbujyNcf5+8uMNXvGtKGnnsbmcU/NSOS9axNsu8l446H6vbb9KE/TSw2j/JVBAb8Kl1XXgkOKwzj/MlgxwUFnLAxKrbqkevu5JePe2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7iBdWou; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xvz+ojos; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DG7E58XxtHgj4OKu2OzFYeV0Bu4CJI3YSM9kLDHslHo=;
	b=q7iBdWouK7nEpoL/ULSYhS10IHjV+PnqJvK9DXq6slWrVffQBW+gPirCwmwp9BfU/KVYFR
	U3ySlUS8FcQ5KA6ZPHk57eZ00Wb8RMSjyL3il4OW3pIfShcdH5wFduibV0jKbAQ9vh9AoT
	vAE2l3vqkmtXuKyurFqqaYSmEVbfxK6KbGi0WALFD/XG6KPS2S6m7JdwdGl3RJxpRkGH7n
	eCS9Y6x+7GMK1PaJDyZsTpCszyKQMGM+BJYXs2GOgSMNH2ACxSH4n5f0Ukr/AOjncTJe0w
	uZ2ptypw1/N3zDOrPvjxWgXLRvh9b2H0FmrmaGz+jAB0Yej5LSpWUcRYfIuG6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DG7E58XxtHgj4OKu2OzFYeV0Bu4CJI3YSM9kLDHslHo=;
	b=Xvz+ojos0fMjWmOhihnTObWJRXyZk9PgG3dXi9rNymTK7hAMd4r83HzvGJw7+BhzFFKW0t
	VYgQcvBzVeGS7fAw==
From: "tip-bot2 for Daniel Almeida" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: lock: guard: Add T: Unpin bound to DerefMut
Cc: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292997.2601451.15640432795343343471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     da123f0ee40f0e5a3791bbaf58a1db1744c59f72
Gitweb:        https://git.kernel.org/tip/da123f0ee40f0e5a3791bbaf58a1db1744c=
59f72
Author:        Daniel Almeida <daniel.almeida@collabora.com>
AuthorDate:    Fri, 19 Sep 2025 11:12:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:55 +02:00

rust: lock: guard: Add T: Unpin bound to DerefMut

A core property of pinned types is not handing a mutable reference to
the inner data in safe code, as this trivially allows that data to be
moved.

Enforce this condition by adding a bound on lock::Guard's DerefMut
implementation, so that it's only implemented for pinning-agnostic
types.

Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1181
---
 rust/kernel/sync/lock.rs        | 5 ++++-
 rust/kernel/sync/lock/global.rs | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202be..b482f34 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -251,7 +251,10 @@ impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'=
_, T, B> {
     }
 }
=20
-impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
+impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B>
+where
+    T: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the prot=
ected data.
         unsafe { &mut *self.lock.data.get() }
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b..38b4480 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -106,7 +106,10 @@ impl<B: GlobalLockBackend> core::ops::Deref for GlobalGu=
ard<B> {
     }
 }
=20
-impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B> {
+impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B>
+where
+    B::Item: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.inner
     }

