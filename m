Return-Path: <linux-tip-commits+bounces-4060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FEA57689
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BC63B202E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2DA48;
	Sat,  8 Mar 2025 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okX+B/7H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iw7N89QI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E151D27E;
	Sat,  8 Mar 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392486; cv=none; b=CpDhIQ061Sh5Y6gimqy9j5zh+eKLOz3uTBM97NqfBHasR3s0acNA1uj8CU7wgRueHWifyFraCDnaX7LzjMJYLcD414o9fsJuEOsl7gYFOkrXpJyOCr3ZNO3GIMAiBoy8FEp4Xyzr80zxACOWq37wUgMaMTl7DVhbiL6UdcibF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392486; c=relaxed/simple;
	bh=oSYKbzI5suZxZhHGVk0h4EMdSHCKCaFH5VDYaVg6g0c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9F24CjslynA+GKZ71r0Kk/3pxdkVOLkXfXhglY48IvvnLHVArThG+tpLNOTvEY6wtnOvN4qaGK+e5YhH/N8LcRHMnIpNQx6/9VJ6y72ajRvwfSf7Z5EBdrgYBkIn2Rzt1AU5UMGpiJ20P/DPtJ4+fPopMULTyx728SnP/Gj4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okX+B/7H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iw7N89QI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlQicSvtnm/u4B/pawVbclansH/rmycQCBS5/DEsJcA=;
	b=okX+B/7H6NTOCWUWf8ZRbKA/AZDipiFBNMl3yNIrdSx8uuF64uITmUUTJrLoScMedqXM/6
	ePaFK1/wlM8OM8nYqh9nkq1aePywPqkXNmI2SM8Ui17dohunDKJf34Rcps1zK8EI3WkmQf
	+fS7MSQ1SgbAOjBGQQEgPTjJAmjW7zijJSbX79XyKPuZ0rZxIbiLTiaG+vLh5xZkueMQms
	x3pIqQXbwUrbEo6qcxAN7Ntec6YbBsnOLTMs6q14s/d+dIfWewSBU8n6/XLTLKnkiv8duU
	T5jiKu3qm1iKPtSfDergSju7ArF+9/MDOu9+sNR9zTwCRgFGqjBy/2G/Nh9J7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlQicSvtnm/u4B/pawVbclansH/rmycQCBS5/DEsJcA=;
	b=iw7N89QIqQUlbTd2+Q0vNLTWfflBQI59B0sn7677MYT7UFRWgWA5uZ4qwe9iEk897D9/jH
	+1lBxO5yHiBgpBCw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: condvar: Add wait_interruptible_freezable()
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-10-boqun.feng@gmail.com>
References: <20250307232717.1759087-10-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139248213.14745.15211511671207814750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     70b9c8563c9c29102a785d4822f0d77d33fee808
Gitweb:        https://git.kernel.org/tip/70b9c8563c9c29102a785d4822f0d77d33fee808
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:04 +01:00

rust: sync: condvar: Add wait_interruptible_freezable()

To support waiting for a `CondVar` as a freezable process, add a
wait_interruptible_freezable() function.

Binder needs this function in the appropriate places to freeze a process
where some of its threads are blocked on the Binder driver.

[ Boqun: Cleaned up the changelog and documentation. ]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250307232717.1759087-10-boqun.feng@gmail.com
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

