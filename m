Return-Path: <linux-tip-commits+bounces-3124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D809FC15D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E30188406D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BC212D75;
	Tue, 24 Dec 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqq2bEkx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06AHpprB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0251D90AC;
	Tue, 24 Dec 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066424; cv=none; b=eeWvZMWO05GLE416tsYFyeHsk7FI1YVgO2KIJBNYhAsIkmGZlWz3eFFOTTA5DpJJaphh1/ZMQs/7qh8ZwEKiWiH5Vl8mzwGSaw2V4pPdnaRT3yZfb00hLc3BLLVmePc393NmfypoJmANLCDfh59Oca22bOHlX+YSHZdVvUmruL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066424; c=relaxed/simple;
	bh=LDAjxEA5lwM7gpht/z4E0MVUW2CEKA+37eY7h9u7ouk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rgQDQXQ9Jz3zC+X0zrO2Lc+kX52expP+nu7+fiMwb+7aiQ0IdTzO4OqGlUQ4FtgXtS6XutcrPOEJ8GG21GnEU+eRLg9GzbO8WHV41iIlMbJVypggXXfq0Q3O3wSsSN4t4YsTGBZdFwyfiJYp7dxCSkd3GkQWJdhNPiaICFO6qG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqq2bEkx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06AHpprB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FJsj1ax/y62NdpHGYkHonMeLLl3Z6zXRcIZ3BN+qeE=;
	b=mqq2bEkxbWAdS8RPgDvmBtj3/DVItTNY7ekLbZCpdSbgNgez33ESeK0stKQ0c5CeL6IAEk
	zY7hVn6UUAQo0OSeUtR1Dt57SfhZ1Ws+YP1Nazgi8IRiu06GIvjvsOifWsvyjBajIXm3N3
	kaR9PHQ0Yog/Lqy/Hv7GVm/u3ZUnFjBu/pcRdS/dL6YC5IEfY5zFZVpIQjEo1wDAi+Hcxm
	MRsFauRc6DiM86Cf/6SD+fRjp/ZFw/i9WohI5EMhHqtjr7+clqNjKeUD4Ajj7uwTdY2jZf
	RPltp0/uvzBUSqP6sJzqyhFbxnfB7kWb/ku5xj41qwzRj/lsGiIgNrYrIC72mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FJsj1ax/y62NdpHGYkHonMeLLl3Z6zXRcIZ3BN+qeE=;
	b=06AHpprBExsdJWPIe5L+6HoF1nAGGu+IuftTtS10R82ZoihU6QmwWFxfJnB5gTPAo8TF5j
	BIWkCOExe045EICA==
From: "tip-bot2 for Lyude Paul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add lock::Backend::assert_is_held()
Cc: Lyude Paul <lyude@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241125204139.656801-1-lyude@redhat.com>
References: <20241125204139.656801-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642015.399.4541644660383039585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fbd7a5a0359bc770e898d918d84977ea61163aad
Gitweb:        https://git.kernel.org/tip/fbd7a5a0359bc770e898d918d84977ea61163aad
Author:        Lyude Paul <lyude@redhat.com>
AuthorDate:    Mon, 25 Nov 2024 15:40:58 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

rust: sync: Add lock::Backend::assert_is_held()

Since we've exposed Lock::from_raw() and Guard::new() publically, we
want to be able to make sure that we assert that a lock is actually held
when constructing a Guard for it to handle instances of unsafe
Guard::new() calls outside of our lock module.

Hence add a new method assert_is_held() to Backend, which uses lockdep
to check whether or not a lock has been acquired. When lockdep is
disabled, this has no overhead.

[Boqun: Resolve the conflicts with exposing Guard::new(), reword the
 commit log a bit and format "unsafe { <statement>; }" into "unsafe {
 <statement> }" for the consistency. ]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241125204139.656801-1-lyude@redhat.com
---
 rust/helpers/mutex.c              |  5 +++++
 rust/helpers/spinlock.c           |  5 +++++
 rust/kernel/sync/lock.rs          | 10 ++++++++++
 rust/kernel/sync/lock/mutex.rs    |  5 +++++
 rust/kernel/sync/lock/spinlock.rs |  5 +++++
 5 files changed, 30 insertions(+)

diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index 7e00680..0657555 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -12,3 +12,8 @@ void rust_helper___mutex_init(struct mutex *mutex, const char *name,
 {
 	__mutex_init(mutex, name, key);
 }
+
+void rust_helper_mutex_assert_is_held(struct mutex *mutex)
+{
+	lockdep_assert_held(mutex);
+}
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 5971fdf..42c4bf0 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -30,3 +30,8 @@ int rust_helper_spin_trylock(spinlock_t *lock)
 {
 	return spin_trylock(lock);
 }
+
+void rust_helper_spin_assert_is_held(spinlock_t *lock)
+{
+	lockdep_assert_held(lock);
+}
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 72dbf3f..eb80048 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -90,6 +90,13 @@ pub unsafe trait Backend {
         // SAFETY: The safety requirements ensure that the lock is initialised.
         *guard_state = unsafe { Self::lock(ptr) };
     }
+
+    /// Asserts that the lock is held using lockdep.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that [`Backend::init`] has been previously called.
+    unsafe fn assert_is_held(ptr: *mut Self::State);
 }
 
 /// A mutual exclusion primitive.
@@ -235,6 +242,9 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     ///
     /// The caller must ensure that it owns the lock.
     pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+        // SAFETY: The caller can only hold the lock if `Backend::init` has already been called.
+        unsafe { B::assert_is_held(lock.state.get()) };
+
         Self {
             lock,
             state,
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 10a70c0..70cadbc 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -134,4 +134,9 @@ unsafe impl super::Backend for MutexBackend {
             None
         }
     }
+
+    unsafe fn assert_is_held(ptr: *mut Self::State) {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        unsafe { bindings::mutex_assert_is_held(ptr) }
+    }
 }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 081c022..ab2f8d0 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -133,4 +133,9 @@ unsafe impl super::Backend for SpinLockBackend {
             None
         }
     }
+
+    unsafe fn assert_is_held(ptr: *mut Self::State) {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        unsafe { bindings::spin_assert_is_held(ptr) }
+    }
 }

