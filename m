Return-Path: <linux-tip-commits+bounces-4061-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EEA5768B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B59189C5AB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F31C36;
	Sat,  8 Mar 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuBPgL8H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mRE8Gq+1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90545D528;
	Sat,  8 Mar 2025 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392487; cv=none; b=ovOgC/c/roXuLRjmq2mgOTYTyBxOaVwQVTV9VYi5gQugN870PfoQzRDQkH/6uli1Cqwc3/sxqF4mpbQmnS81pCtoOeZfTLBVg21S/5jU4d7xSQW13dqWzB3TymYHFhFCWaLoJOoYqXs94Mq14RzbtelDgmpTfTkJqdVyg/QjEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392487; c=relaxed/simple;
	bh=x2KUhE9WHpwYmqvScVCasbSRnXY1p1+c0F56uhayVEI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JRNg3lg21sUjBQkbq6szVPib9iPh/VxQSGM5DpTtDBJLRyKdNtH1gWPkh9oIE6zf6A9WpCbXhIGCZzTO46Omp/sZjT/+k5HvkwODISYc+28Xr9R3zAz4QDYUP1+ZT+WAeZVpcSwWFOxPbFSoTRlIDMpOv1e268m1VG83YPOhctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuBPgL8H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mRE8Gq+1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jn0Y6xbm7c5laJPlXLSAvYo8DUSjHy2XzOv7VCduQo=;
	b=ZuBPgL8H3pBLtkuxW3hLkoiE05lib34ErPxKv3+vCIlfu3mC1gAyDi+2PPiOB85cY1zD1S
	FoMvJuVQ3bFbPbEfQx1jQBLeKLxZjsgcx1pB4bL5Vmq9U3HagPpd5PQiNFhhs9DwxFJpZ3
	uABciN0eGSHWqedwOsGR0GbNtnWLNEwZN16IyfKIMlICn9188JoIM+Toz45OU/rRm5vlKp
	qU6E+v1aWVVG4nGICUqywAdxeQ20dtCP35CZ/vuEeudVzUVUmgH9HYhR56uHK8G1X4X6vW
	juHDzCITku4QQeaNtxKpoEyhLuSUvh0OtmMonkk+uKFYuqJRzehPv0ucdnsrnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392483;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jn0Y6xbm7c5laJPlXLSAvYo8DUSjHy2XzOv7VCduQo=;
	b=mRE8Gq+1ctOdpI727b6Lo1AN4ViB5kYpdjWmQs2BPGHcktgzWptva+bOimKE5VCsqOZ6Yh
	l86t/U10dMF+PmDQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: lock: Add an example for Guard:: Lock_ref()
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-9-boqun.feng@gmail.com>
References: <20250307232717.1759087-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139248296.14745.13317521669976622612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c2849afafd08a1c3ad881129de48ebe1642f7675
Gitweb:        https://git.kernel.org/tip/c2849afafd08a1c3ad881129de48ebe1642f7675
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:58 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:04 +01:00

rust: sync: lock: Add an example for Guard:: Lock_ref()

To provide examples on usage of `Guard::lock_ref()` along with the unit
test, an "assert a lock is held by a guard" example is added.

(Also apply feedback from Benno.)

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250223072114.3715-1-boqun.feng@gmail.com
Link: https://lore.kernel.org/r/20250307232717.1759087-9-boqun.feng@gmail.com
---
 rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 8e7e6d5..f53e87d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
 impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// Returns the lock that this guard originates from.
+    ///
+    /// # Examples
+    ///
+    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
+    /// lock is held.
+    ///
+    /// ```
+    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
+    ///
+    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
+    ///     // Address-equal means the same lock.
+    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
+    /// }
+    ///
+    /// // Creates a new lock on the stack.
+    /// stack_pin_init!{
+    ///     let l = new_spinlock!(42)
+    /// }
+    ///
+    /// let g = l.lock();
+    ///
+    /// // `g` originates from `l`.
+    /// assert_held(&g, &l);
+    /// ```
     pub fn lock_ref(&self) -> &'a Lock<T, B> {
         self.lock
     }

