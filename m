Return-Path: <linux-tip-commits+bounces-6975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF1BF5CC9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F493BDE19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4A32E136;
	Tue, 21 Oct 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhyqWo9M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xy4yTGw4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E32D433;
	Tue, 21 Oct 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042934; cv=none; b=U13Hvw+eeHqh3mvV2BCIw0sAHmExVdUFbvdvszyS0THG21bEpSvcI80u8k5EyYQQRANC5mkwoKRdYSxGH+cywMsU3rjN+ypOUH9N1LPlDiGz7AxLbtG3pn+BbsjgcJXEnL2kVsrxOsCL+w1FYxRabnMsXsIEcmUNuKxDZ0Tmt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042934; c=relaxed/simple;
	bh=t3ji9bh301gxX9EwwXuU415M2dcbSyaArmwo6aLVDYw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gv0kItyp4M9xJ7D5ZRdMCsa2+hStufigU9XR8dSNX6vO749zeQI/eaYxPFnwLgWtRKvpRyy4dbQxDnvHTl2rn6fVlMvOpltZy+BuIayLA3/0sJsUp0sOqUXHIo672M6a/Pj19SQjKS2gACNYpTRJRVxtuEsjEpOAzIDRb8GemxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhyqWo9M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xy4yTGw4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bh5Rn9MftIO5XGZ6RI7XJJYzh2nZBUj78IqcMqHsiL8=;
	b=NhyqWo9MRXLt0zHuNmWHeSskpUcBFUxTMYyupcWh1T+gEVfJNgp9Lj+G/ogsa0Vw+vYFwz
	EYLgBpvnzdDcROrFLNvw9OcfZc9ak2jxRhVT2whFVELgpIzX/plPrbK6Sp4WoU3P9rrW4s
	nkHOLb6Q//dsQWDONG5lquNJoT8aIQvGqlVZYOHRnd+yR8pR4rRXgQMh3fYiN7NqsPsMga
	aMbB6MvBLGm20OAASos8D8orG01Uy7QcUdiAg99JMghm1CuBK+w1/VgQO6AlFDsCf+4e61
	bqRuuVWedcbgO78T82ZdpNodltL4SIjVryz/07J+A/BowLXLebzlGfoRXLt45A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bh5Rn9MftIO5XGZ6RI7XJJYzh2nZBUj78IqcMqHsiL8=;
	b=xy4yTGw4raALpWS1FSrGIxUgGxTHWm28bifebTgPEI1njVg4yxfqlT91UxfZhQKS0/GIMw
	7C6G4fl4JrkTyrBg==
From: "tip-bot2 for Daniel Almeida" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: lock: Pin the inner data
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
Message-ID: <176104292876.2601451.485431159015446694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2497a7116ff9a051d0e78885a27a52213bc2841d
Gitweb:        https://git.kernel.org/tip/2497a7116ff9a051d0e78885a27a52213bc=
2841d
Author:        Daniel Almeida <daniel.almeida@collabora.com>
AuthorDate:    Fri, 19 Sep 2025 11:12:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:55 +02:00

rust: lock: Pin the inner data

In preparation to support Lock<T> where T is pinned, the first thing
that needs to be done is to structurally pin the 'data' member. This
switches the 't' parameter in Lock<T>::new() to take in an impl
PinInit<T> instead of a plain T. This in turn uses the blanket
implementation "impl PinInit<T> for T".

Subsequent patches will touch on Guard<T>.

Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1181
---
 rust/kernel/sync/lock.rs | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index b482f34..9242790 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -11,7 +11,7 @@ use crate::{
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
-use pin_init::{pin_data, pin_init, PinInit};
+use pin_init::{pin_data, pin_init, PinInit, Wrapper};
=20
 pub mod mutex;
 pub mod spinlock;
@@ -115,6 +115,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
=20
     /// The data protected by the lock.
+    #[pin]
     pub(crate) data: UnsafeCell<T>,
 }
=20
@@ -127,9 +128,13 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<=
T, B> {}
=20
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -=
> impl PinInit<Self> {
+    pub fn new(
+        t: impl PinInit<T>,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+    ) -> impl PinInit<Self> {
         pin_init!(Self {
-            data: UnsafeCell::new(t),
+            data <- UnsafeCell::pin_init(t),
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both =
`name` and `key` have
             // static lifetimes so they live indefinitely.

