Return-Path: <linux-tip-commits+bounces-3125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AD9FC15E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE001884C93
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A4212F88;
	Tue, 24 Dec 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNMcaBhu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymymdloM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCF1D9587;
	Tue, 24 Dec 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066424; cv=none; b=ATQJofOaRcDD/eLTh50AuxLpOOsySv3nJDn08Syr0/qO6a2qufdjlUSYNv76hBOS744EuLNMzMFppveujd3YG0q67DfbqbZXRSYTOVxlAxHb3jMv8cV+U/zLyQuswSPgapXLwziAX7qsJcpW1qtIBKq4XQc0XRNga60VyKy05O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066424; c=relaxed/simple;
	bh=dTeCsaca7ltCN5fTSnckcMzdfgttKNaa20OZfEc0zI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IylEIxfw690Gn99VgcBeDk0/sKbCz/3ngEcw8/ZcQkl7pBs0Ej6pbSUi2jklVKDA2vWsFbUvGV5uKau68V90tWN2YMPbylAHJAYtR7hrb8uY7hCtMuwR+j0kCGpWBKaMxXdWNWL4rfBFpZbnYkB1HyLG7G1Vb+YWGUqBZ3wmRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNMcaBhu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymymdloM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9fdDE+MlXSkFr7a4pCxfzCHxr21tvgyTiQw5nigjE=;
	b=pNMcaBhukeSIDuWwymHz4wnseotoJEVWK1kEBHJQyQwYO2P2AxX01PbuiQdYLqVeFLF4iZ
	NZYzh02JhhHBq6N7dZkWFf3amzuITkhXyJ+yk6FRTKaDgaTTYfKKM2VrvMFtL8NDq/5kfJ
	iTHCFxyccXx75SxoBTNzCrimyN746rJBa7qG7GI6JO7+gsGlT5apZItwjK4jc0qhfsiDOt
	6N4n9ukT4B3U3AHwDUyohwlbSMnBNCWjn7YkmBNlqjX2UToKcsU5uuwCNLNBmVHYLZ9kxv
	/TlR9/U42nRs6oyY0iPCTXUxzXfHvLPVGj5csUem/OUt33aQuHlKLwu/WgWwGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FI9fdDE+MlXSkFr7a4pCxfzCHxr21tvgyTiQw5nigjE=;
	b=ymymdloMpP7K9pRqfmTSS0G9brbsO90Het+K1izNl7hldMPEyzN1Pk91uEI5ynbfn/pwe5
	CHOgWT5RH4FWlyCA==
From: "tip-bot2 for Lyude Paul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add SpinLockGuard type alias
Cc: Lyude Paul <lyude@redhat.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241120222742.2490495-3-lyude@redhat.com>
References: <20241120222742.2490495-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642065.399.3744670733965063119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     eb5ccb038284dc0e69822d71aafcbf7b57394aad
Gitweb:        https://git.kernel.org/tip/eb5ccb038284dc0e69822d71aafcbf7b57394aad
Author:        Lyude Paul <lyude@redhat.com>
AuthorDate:    Wed, 20 Nov 2024 17:26:29 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

rust: sync: Add SpinLockGuard type alias

A simple helper alias for code that needs to deal with Guard types returned
from SpinLocks.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241120222742.2490495-3-lyude@redhat.com
---
 rust/kernel/sync.rs               | 2 +-
 rust/kernel/sync/lock/spinlock.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 2721b5c..dffdaad 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -17,7 +17,7 @@ pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
-pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 9f4d128..081c022 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -87,6 +87,14 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
 /// A kernel `spinlock_t` lock backend.
 pub struct SpinLockBackend;
 
+/// A [`Guard`] acquired from locking a [`SpinLock`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLock`]. It will unlock
+/// the [`SpinLock`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type SpinLockGuard<'a, T> = super::Guard<'a, T, SpinLockBackend>;
+
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
 // default implementation that always calls the same locking method.
 unsafe impl super::Backend for SpinLockBackend {

