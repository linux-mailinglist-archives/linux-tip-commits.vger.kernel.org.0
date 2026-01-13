Return-Path: <linux-tip-commits+bounces-7918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE1D183A9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A1D83083690
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02AC38946A;
	Tue, 13 Jan 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhN6l3jQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCh1xwnE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61B374183;
	Tue, 13 Jan 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301395; cv=none; b=tKStvxZJJZ1v3iReLg9UcFcFmXcfUkb2n3loqRyDMRp4vn5dmJFTNMneZUVYS15Z8T62bddt9pR+q1qI7meZSfz6UFm5Xwq2yLxYlyYv0z7iPg0B3YtF2wP0/Fe+LPP1pqbj5hF03B0ImNwJSLbpokTWYQ9VogVdwBgzlqTQyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301395; c=relaxed/simple;
	bh=l3bfBMdX2qw07ricyk5ag06ICH0l5jWrhR31dlnsLiA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ojsKEbRJIktSAQY5Dyu5h3zpB3LrwPo/jv2/vJArrQ5aYRt2+14F0T1LV6Xvy5MLIbekjcIk6vSvb4qhMqxrcrzvkpIpTpE6q6oKmp0yEruvtWg0KDkjcrYBhLHhWUen+dExcQjLG/O1fcQjEYQQ3QD5MEWGOtr/kCkt0nhUoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhN6l3jQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCh1xwnE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRL3gQQMUuKtsWSRsVW9r2xjNuJPC1z0cD8do8R+ExM=;
	b=IhN6l3jQWfuBsPG2O0rozYeOVTqCpBlC5Y9ttZDE2sT6wHbnpiqF76rk4emIoTtlZ7UZX9
	0MWZ0MoC6/uAuxJthFGEAZnFifQK5AeE2jqCOMjVCaZmgozRVCKk8AtKOTGQXMXbHNmmOQ
	XabDw1zvPASVwMeBfMuYAScxkKJS4hB/B8jOSgmb8B6f8wQImAZcguNj/u9uBhCZwLcD/6
	QyrIly8wjh9HN64gVr26XjatLTrLUqa1vfl/vsRLVYari0xhv5wjJ8eWA4nRKUXyH0vlKA
	97L7ffMd3i8K1TNr56lf+2KUnO1XrIIXtrLorO7C0x2lXDKOjBPpMqwKHsjNVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRL3gQQMUuKtsWSRsVW9r2xjNuJPC1z0cD8do8R+ExM=;
	b=FCh1xwnEH+TdtoNK8yrxchUH/3M1ekdm003xCh/WkzWlx/CEQT/vPcEDX7IQ3/XwtLm1sO
	3Sz59Un5vjAKb5Ag==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust_binder: Switch to kernel::sync atomic primitives
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251230093718.1852322-4-fujita.tomonori@gmail.com>
References: <20251230093718.1852322-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138872.510.13745959762664867993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7f4c8b4dcde7174a3bd5d001790d8453c9aefa3c
Gitweb:        https://git.kernel.org/tip/7f4c8b4dcde7174a3bd5d001790d8453c9a=
efa3c
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 30 Dec 2025 18:37:18 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust_binder: Switch to kernel::sync atomic primitives

Convert uses of AtomicBool, AtomicUsize, and AtomicU32.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251230093718.1852322-4-fujita.tomonori@gmail=
.com
---
 drivers/android/binder/rust_binder_main.rs | 20 ++++++++----------
 drivers/android/binder/stats.rs            |  8 +++----
 drivers/android/binder/thread.rs           | 24 +++++++++------------
 drivers/android/binder/transaction.rs      | 16 +++++++-------
 4 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/bin=
der/rust_binder_main.rs
index c79a9e7..47bfb11 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -18,6 +18,7 @@ use kernel::{
     prelude::*,
     seq_file::SeqFile,
     seq_print,
+    sync::atomic::{ordering::Relaxed, Atomic},
     sync::poll::PollTable,
     sync::Arc,
     task::Pid,
@@ -28,10 +29,7 @@ use kernel::{
=20
 use crate::{context::Context, page_range::Shrinker, process::Process, thread=
::Thread};
=20
-use core::{
-    ptr::NonNull,
-    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
-};
+use core::ptr::NonNull;
=20
 mod allocation;
 mod context;
@@ -90,9 +88,9 @@ module! {
 }
=20
 fn next_debug_id() -> usize {
-    static NEXT_DEBUG_ID: AtomicUsize =3D AtomicUsize::new(0);
+    static NEXT_DEBUG_ID: Atomic<usize> =3D Atomic::new(0);
=20
-    NEXT_DEBUG_ID.fetch_add(1, Ordering::Relaxed)
+    NEXT_DEBUG_ID.fetch_add(1, Relaxed)
 }
=20
 /// Provides a single place to write Binder return values via the
@@ -215,7 +213,7 @@ impl<T: ListArcSafe> DTRWrap<T> {
=20
 struct DeliverCode {
     code: u32,
-    skip: AtomicBool,
+    skip: Atomic<bool>,
 }
=20
 kernel::list::impl_list_arc_safe! {
@@ -226,7 +224,7 @@ impl DeliverCode {
     fn new(code: u32) -> Self {
         Self {
             code,
-            skip: AtomicBool::new(false),
+            skip: Atomic::new(false),
         }
     }
=20
@@ -235,7 +233,7 @@ impl DeliverCode {
     /// This is used instead of removing it from the work list, since `Linke=
dList::remove` is
     /// unsafe, whereas this method is not.
     fn skip(&self) {
-        self.skip.store(true, Ordering::Relaxed);
+        self.skip.store(true, Relaxed);
     }
 }
=20
@@ -245,7 +243,7 @@ impl DeliverToRead for DeliverCode {
         _thread: &Thread,
         writer: &mut BinderReturnWriter<'_>,
     ) -> Result<bool> {
-        if !self.skip.load(Ordering::Relaxed) {
+        if !self.skip.load(Relaxed) {
             writer.write_code(self.code)?;
         }
         Ok(true)
@@ -259,7 +257,7 @@ impl DeliverToRead for DeliverCode {
=20
     fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str) -> Resu=
lt<()> {
         seq_print!(m, "{}", prefix);
-        if self.skip.load(Ordering::Relaxed) {
+        if self.skip.load(Relaxed) {
             seq_print!(m, "(skipped) ");
         }
         if self.code =3D=3D defs::BR_TRANSACTION_COMPLETE {
diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index 0370026..ab75e95 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -5,7 +5,7 @@
 //! Keep track of statistics for binder_logs.
=20
 use crate::defs::*;
-use core::sync::atomic::{AtomicU32, Ordering::Relaxed};
+use kernel::sync::atomic::{ordering::Relaxed, Atomic};
 use kernel::{ioctl::_IOC_NR, seq_file::SeqFile, seq_print};
=20
 const BC_COUNT: usize =3D _IOC_NR(BC_REPLY_SG) as usize + 1;
@@ -14,14 +14,14 @@ const BR_COUNT: usize =3D _IOC_NR(BR_TRANSACTION_PENDING_=
FROZEN) as usize + 1;
 pub(crate) static GLOBAL_STATS: BinderStats =3D BinderStats::new();
=20
 pub(crate) struct BinderStats {
-    bc: [AtomicU32; BC_COUNT],
-    br: [AtomicU32; BR_COUNT],
+    bc: [Atomic<u32>; BC_COUNT],
+    br: [Atomic<u32>; BR_COUNT],
 }
=20
 impl BinderStats {
     pub(crate) const fn new() -> Self {
         #[expect(clippy::declare_interior_mutable_const)]
-        const ZERO: AtomicU32 =3D AtomicU32::new(0);
+        const ZERO: Atomic<u32> =3D Atomic::new(0);
=20
         Self {
             bc: [ZERO; BC_COUNT],
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread=
.rs
index 1a8e6fd..82264db 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -15,6 +15,7 @@ use kernel::{
     security,
     seq_file::SeqFile,
     seq_print,
+    sync::atomic::{ordering::Relaxed, Atomic},
     sync::poll::{PollCondVar, PollTable},
     sync::{Arc, SpinLock},
     task::Task,
@@ -34,10 +35,7 @@ use crate::{
     BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
 };
=20
-use core::{
-    mem::size_of,
-    sync::atomic::{AtomicU32, Ordering},
-};
+use core::mem::size_of;
=20
 /// Stores the layout of the scatter-gather entries. This is used during the=
 `translate_objects`
 /// call and is discarded when it returns.
@@ -273,8 +271,8 @@ const LOOPER_POLL: u32 =3D 0x40;
 impl InnerThread {
     fn new() -> Result<Self> {
         fn next_err_id() -> u32 {
-            static EE_ID: AtomicU32 =3D AtomicU32::new(0);
-            EE_ID.fetch_add(1, Ordering::Relaxed)
+            static EE_ID: Atomic<u32> =3D Atomic::new(0);
+            EE_ID.fetch_add(1, Relaxed)
         }
=20
         Ok(Self {
@@ -1537,7 +1535,7 @@ impl Thread {
=20
 #[pin_data]
 struct ThreadError {
-    error_code: AtomicU32,
+    error_code: Atomic<u32>,
     #[pin]
     links_track: AtomicTracker,
 }
@@ -1545,18 +1543,18 @@ struct ThreadError {
 impl ThreadError {
     fn try_new() -> Result<DArc<Self>> {
         DTRWrap::arc_pin_init(pin_init!(Self {
-            error_code: AtomicU32::new(BR_OK),
+            error_code: Atomic::new(BR_OK),
             links_track <- AtomicTracker::new(),
         }))
         .map(ListArc::into_arc)
     }
=20
     fn set_error_code(&self, code: u32) {
-        self.error_code.store(code, Ordering::Relaxed);
+        self.error_code.store(code, Relaxed);
     }
=20
     fn is_unused(&self) -> bool {
-        self.error_code.load(Ordering::Relaxed) =3D=3D BR_OK
+        self.error_code.load(Relaxed) =3D=3D BR_OK
     }
 }
=20
@@ -1566,8 +1564,8 @@ impl DeliverToRead for ThreadError {
         _thread: &Thread,
         writer: &mut BinderReturnWriter<'_>,
     ) -> Result<bool> {
-        let code =3D self.error_code.load(Ordering::Relaxed);
-        self.error_code.store(BR_OK, Ordering::Relaxed);
+        let code =3D self.error_code.load(Relaxed);
+        self.error_code.store(BR_OK, Relaxed);
         writer.write_code(code)?;
         Ok(true)
     }
@@ -1583,7 +1581,7 @@ impl DeliverToRead for ThreadError {
             m,
             "{}transaction error: {}\n",
             prefix,
-            self.error_code.load(Ordering::Relaxed)
+            self.error_code.load(Relaxed)
         );
         Ok(())
     }
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/t=
ransaction.rs
index 4bd3c0e..2273a8e 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -2,11 +2,11 @@
=20
 // Copyright (C) 2025 Google LLC.
=20
-use core::sync::atomic::{AtomicBool, Ordering};
 use kernel::{
     prelude::*,
     seq_file::SeqFile,
     seq_print,
+    sync::atomic::{ordering::Relaxed, Atomic},
     sync::{Arc, SpinLock},
     task::Kuid,
     time::{Instant, Monotonic},
@@ -33,7 +33,7 @@ pub(crate) struct Transaction {
     pub(crate) to: Arc<Process>,
     #[pin]
     allocation: SpinLock<Option<Allocation>>,
-    is_outstanding: AtomicBool,
+    is_outstanding: Atomic<bool>,
     code: u32,
     pub(crate) flags: u32,
     data_size: usize,
@@ -105,7 +105,7 @@ impl Transaction {
             offsets_size: trd.offsets_size as _,
             data_address,
             allocation <- kernel::new_spinlock!(Some(alloc.success()), "Tran=
saction::new"),
-            is_outstanding: AtomicBool::new(false),
+            is_outstanding: Atomic::new(false),
             txn_security_ctx_off,
             oneway_spam_detected,
             start_time: Instant::now(),
@@ -145,7 +145,7 @@ impl Transaction {
             offsets_size: trd.offsets_size as _,
             data_address: alloc.ptr,
             allocation <- kernel::new_spinlock!(Some(alloc.success()), "Tran=
saction::new"),
-            is_outstanding: AtomicBool::new(false),
+            is_outstanding: Atomic::new(false),
             txn_security_ctx_off: None,
             oneway_spam_detected,
             start_time: Instant::now(),
@@ -215,8 +215,8 @@ impl Transaction {
=20
     pub(crate) fn set_outstanding(&self, to_process: &mut ProcessInner) {
         // No race because this method is only called once.
-        if !self.is_outstanding.load(Ordering::Relaxed) {
-            self.is_outstanding.store(true, Ordering::Relaxed);
+        if !self.is_outstanding.load(Relaxed) {
+            self.is_outstanding.store(true, Relaxed);
             to_process.add_outstanding_txn();
         }
     }
@@ -227,8 +227,8 @@ impl Transaction {
         // destructor, which is guaranteed to not race with any other operat=
ions on the
         // transaction. It also cannot race with `set_outstanding`, since su=
bmission happens
         // before delivery.
-        if self.is_outstanding.load(Ordering::Relaxed) {
-            self.is_outstanding.store(false, Ordering::Relaxed);
+        if self.is_outstanding.load(Relaxed) {
+            self.is_outstanding.store(false, Relaxed);
             self.to.drop_outstanding_txn();
         }
     }

