Return-Path: <linux-tip-commits+bounces-5979-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04086AF6D14
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B6B523C6E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC322D1F7C;
	Thu,  3 Jul 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2o6eHK2Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6PsQeVWW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB62D12F7;
	Thu,  3 Jul 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531773; cv=none; b=NPOPDf6DZhkbIXtW6JjgMxpNSGUqS6P83EydCKBORV7cY4I6uMuUCE2hmf+DjpbHpsRgNVNDGEXBoKrM8+Ii5v3T13TqNRYNVFgQFAZv1djQTasoXNRiIf2UT6coImyFs3vzHLd5i6HYBQdxXdJeisEB4Da1VTBLZ9FiKK99ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531773; c=relaxed/simple;
	bh=2zC0TRYa7W99gT+jcbgjgFGM0EDdBMHMsvgiDBSXXnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IaqiYX9DeWq37kVNleitIp05+RXrd0FHlDEKFSCdmq3T6rLWlJQ4VQiM7T5iHhs6i9uYiKpLvBNvuVCVCj6V/2uP+WyU/KV8+jMrAk5iBUZmy59lAVZyG8OrXLitMrVbsNDigZYkc0d0zBC/wvziwlDl00QEnjUBrjs3AbU80sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2o6eHK2Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6PsQeVWW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 08:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751531770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XjLvA/DwogFv7KaaZwTTf/aNFcTkUVlWi/KtHkUVPw=;
	b=2o6eHK2Qii782QsKV05Sum/eY7SA0xi2E/1UbBnwlUY/R5fS16TgILGkZ6u4V0MU+sn8hD
	OcBmsnSKFNS5PhERuLH/K1vW0qXjvixtn4z895YXRsuV1Fzh5DDSqzZNqKF1pwe0qcr5Nk
	RvSXmWIoiH1Wod5/7mrWT1ZaP0TfSA+gy0vmUR+2ngnPYVme7jQvXlyWQO9d0Dbr73z8h6
	RXMGAiWakGSk6Uz1+6POGslyHtkdOou2IRhb0z+/UbmhIdc8soGTxkV/iazQWZYRJg4GNI
	O/gmQ/rRU9+xW/2czdWEb5zMmJo/+HA98k3rWE/z4oCvxXhWRQQvzCatTZUBfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751531770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XjLvA/DwogFv7KaaZwTTf/aNFcTkUVlWi/KtHkUVPw=;
	b=6PsQeVWWPPpkl9mq6GbVOron4hsNqZmTeUUiKV9EGQStk6Fxzz4YImPOH9xp0RwCSoaarC
	nfMTkWaIpY+Y5/Bg==
From: "tip-bot2 for Panagiotis Foliadis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rust: task: Mark Task methods inline
Cc: Benno Lossin <benno.lossin@proton.me>,
 Christian Schrefl <chrisi.schrefl@gmail.com>,
 Charalampos Mitrodimas <charmitro@posteo.net>,
 Alice Ryhl <aliceryhl@google.com>, Panagiotis Foliadis <pfoliadis@posteo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250315-inline-c-wrappers-v3-1-048e43fcef7d@posteo.net>
References: <20250315-inline-c-wrappers-v3-1-048e43fcef7d@posteo.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175153176934.406.13550300797392656325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0a41f5af19391ce55cae1f0d7a562e8694bf1fd5
Gitweb:        https://git.kernel.org/tip/0a41f5af19391ce55cae1f0d7a562e8694bf1fd5
Author:        Panagiotis Foliadis <pfoliadis@posteo.net>
AuthorDate:    Sat, 15 Mar 2025 12:23:01 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 24 Jun 2025 10:23:48 -07:00

rust: task: Mark Task methods inline

When building the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
toolchain provided by kernel.org, the following symbols are generated:

$ nm vmlinux | grep ' _R'.*Task | rustfilt
... T <kernel::task::Task>::get_pid_ns
... T <kernel::task::Task>::tgid_nr_ns
... T <kernel::task::Task>::current_pid_ns
... T <kernel::task::Task>::signal_pending
... T <kernel::task::Task>::uid
... T <kernel::task::Task>::euid
... T <kernel::task::Task>::current
... T <kernel::task::Task>::wake_up
... T <kernel::task::Task as kernel::types::AlwaysRefCounted>::dec_ref
... T <kernel::task::Task as kernel::types::AlwaysRefCounted>::inc_ref

These Rust symbols are trivial wrappers around the C functions. It
doesn't make sense to go through a trivial wrapper for these functions,
so mark them inline.

[boqun: Capitalize the title, reword a bit to avoid listing all the C
functions as the code already shows them and remove the addresses of the
symbols in the commit log as they are different from build to build.]

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250315-inline-c-wrappers-v3-1-048e43fcef7d@posteo.net
---
 rust/kernel/task.rs |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 927413d..8343683 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -173,6 +173,7 @@ impl Task {
     /// Callers must ensure that the returned object is only used to access a [`CurrentTask`]
     /// within the task context that was active when this function was called. For more details,
     /// see the invariants section for [`CurrentTask`].
+    #[inline]
     pub unsafe fn current() -> impl Deref<Target = CurrentTask> {
         struct TaskRef {
             task: *const CurrentTask,
@@ -222,24 +223,28 @@ impl Task {
     }
 
     /// Returns the UID of the given task.
+    #[inline]
     pub fn uid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_uid` on a valid task.
         Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
     }
 
     /// Returns the effective UID of the given task.
+    #[inline]
     pub fn euid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_euid` on a valid task.
         Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
     }
 
     /// Determines whether the given task has pending signals.
+    #[inline]
     pub fn signal_pending(&self) -> bool {
         // SAFETY: It's always safe to call `signal_pending` on a valid task.
         unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
     }
 
     /// Returns task's pid namespace with elevated reference count
+    #[inline]
     pub fn get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         let ptr = unsafe { bindings::task_get_pid_ns(self.as_ptr()) };
@@ -255,6 +260,7 @@ impl Task {
 
     /// Returns the given task's pid in the provided pid namespace.
     #[doc(alias = "task_tgid_nr_ns")]
+    #[inline]
     pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
         let pidns = match pidns {
             Some(pidns) => pidns.as_ptr(),
@@ -268,6 +274,7 @@ impl Task {
     }
 
     /// Wakes up the task.
+    #[inline]
     pub fn wake_up(&self) {
         // SAFETY: It's always safe to call `wake_up_process` on a valid task, even if the task
         // running.
@@ -341,11 +348,13 @@ impl CurrentTask {
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_task_struct(self.as_ptr()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         // SAFETY: The safety requirements guarantee that the refcount is nonzero.
         unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }

