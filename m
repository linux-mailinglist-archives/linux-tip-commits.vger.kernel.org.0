Return-Path: <linux-tip-commits+bounces-3806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F5A4CB47
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317D73AC3B4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E56422E405;
	Mon,  3 Mar 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cX6vmXHz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lnnz8LTv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CB22D4C8;
	Mon,  3 Mar 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027925; cv=none; b=UseKGjbmTF1PKxLMo/70NrOsrSbwmds9QvYExXCiZ6y4Z1qv54LeCsYvILTFyCCes5Vb9apJgrV7myDBLZF1MtxKEPKUty9YGT0b5m5KMfbdcn24xnBIb+shInUeR/5+V59vF8ESQaJYUoKK4HUS4PqdIjH8AtjYEe3cz7BqtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027925; c=relaxed/simple;
	bh=XKm1davLhTjrfgKJD7ZJVOfaLrQzZjIOvHnwYv5dVDo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VcZV9LdMiIsczUi359Gsz+kZZb60VfSeEVx9uGQo/7u9dxhfFRB084XskUy9oyMVZHka+0FF5NhgXv2AGkvXCgSAeas7iB351UFjaX378PIdMw2nWJLKuvFnFEPa6e/z9iqN+1z0KxTqmU3xEFpEGOQqJHUlQeg73ueYND4vXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cX6vmXHz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lnnz8LTv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h1GslIbyju+suPkhMvAD87el/WZtgWXerGF0Q3aAlU=;
	b=cX6vmXHz9fX8Kv6S/H3MfZgoQVBOZoXUgfOXimK7OBbGnzkblbeadhakPb32P818xTIstK
	qp6MHiInPIDd1iktfNQm9RlZJdMyYknd7PcPu3t5cue9nDkTnaGJQ50bn/Zl4h6XbMYR/j
	TGugdpp2MXQjr51HZIWDoEbZwAgsGwsOvev6CpQBlhy0GjJSxCzCiv2Qh62GCezCL6FLo8
	EOIxoAaPoMMDEJuVNL/T7gc77Jf/B+RSJNKFCD/aHK+Cv/VyBTMVoLvYY+/8xAhV1notTc
	50ms8ygUOtAByVdsLsiwwRAH3ropMbORHkNdr65rkw0MXH/Y1FWCrSMuyJFKog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h1GslIbyju+suPkhMvAD87el/WZtgWXerGF0Q3aAlU=;
	b=Lnnz8LTvL68X36RqumzS9ewl3Te0D72Hgwz9FpyIYjZIVBxM9iF8bFkF2LHUX58RAPNykJ
	Pr55To3Wk2ahiqAw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: condvar: Add wait_interruptible_freezable()
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-condvar-freeze-v2-1-804483096260@google.com>
References: <20250204-condvar-freeze-v2-1-804483096260@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791512.14745.11616490042606107721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     49d72f48a8d9bff481c6f4be838117d07bfa4e4c
Gitweb:        https://git.kernel.org/tip/49d72f48a8d9bff481c6f4be838117d07bfa4e4c
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Tue, 04 Feb 2025 13:43:25 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 25 Feb 2025 08:53:08 -08:00

rust: sync: condvar: Add wait_interruptible_freezable()

To support waiting for a `CondVar` as a freezable process, add a
wait_interruptible_freezable() function.

Binder needs this function in the appropriate places to freeze a process
where some of its threads are blocked on the Binder driver.

[Boqun: Capitalize the title, reword the commit log and rephrase the
function doc comment with the impersonal style to align with rest of the
file]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250204-condvar-freeze-v2-1-804483096260@google.com
---
 rust/kernel/sync/condvar.rs | 23 ++++++++++++++++++++++-
 rust/kernel/task.rs         |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 7df5650..5c1e546 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -11,7 +11,9 @@ use crate::{
     init::PinInit,
     pin_init,
     str::CStr,
-    task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE},
+    task::{
+        MAX_SCHEDULE_TIMEOUT, TASK_FREEZABLE, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE,
+    },
     time::Jiffies,
     types::Opaque,
 };
@@ -159,6 +161,25 @@ impl CondVar {
         crate::current!().signal_pending()
     }
 
+    /// Releases the lock and waits for a notification in interruptible and freezable mode.
+    ///
+    /// The process is allowed to be frozen during this sleep. No lock should be held when calling
+    /// this function, and there is a lockdep assertion for this. Freezing a task that holds a lock
+    /// can trivially deadlock vs another task that needs that lock to complete before it too can
+    /// hit freezable.
+    #[must_use = "wait_interruptible_freezable returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_interruptible_freezable<T: ?Sized, B: Backend>(
+        &self,
+        guard: &mut Guard<'_, T, B>,
+    ) -> bool {
+        self.wait_internal(
+            TASK_INTERRUPTIBLE | TASK_FREEZABLE,
+            guard,
+            MAX_SCHEDULE_TIMEOUT,
+        );
+        crate::current!().signal_pending()
+    }
+
     /// Releases the lock and waits for a notification in interruptible mode.
     ///
     /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a..ea43a3b 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -23,6 +23,8 @@ pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
 /// Bitmask for tasks that are sleeping in an uninterruptible state.
 pub const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
+/// Bitmask for tasks that are sleeping in a freezable state.
+pub const TASK_FREEZABLE: c_int = bindings::TASK_FREEZABLE as c_int;
 /// Convenience constant for waking up tasks regardless of whether they are in interruptible or
 /// uninterruptible sleep.
 pub const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;

