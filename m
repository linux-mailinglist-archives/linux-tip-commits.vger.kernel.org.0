Return-Path: <linux-tip-commits+bounces-3805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7AA4CB46
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEC1757D4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877922DFB6;
	Mon,  3 Mar 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="excSsnQ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKvmM9F/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786922CBE2;
	Mon,  3 Mar 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027924; cv=none; b=K6pE9vUDytk/5Diczzg9ngFoL3Faahk7NYbarOfOsagxdYWVkxr60TXObLRMJQSxpblyEDATezn54B+3K9fhyv3yklyvJRUPcjUPTXAgo8ezXq+5eV6ii5N6/9xiiPKdHTOzICY8itD8qw/efAJBMvwGeFDq1f0jaIHQy4iDyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027924; c=relaxed/simple;
	bh=gY7WZTJTiG6UXitWUea5Qd/X0yuqiUJhlMef1GGoi2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uz+dQVzqHBBlSx8IgIFFW1/6dhZwrlw1O6GdhP9hhdtcH3ixliFvvd/scDlDctUVuexBo65DUZ43dyEPdahZHC9QLGoYu9547wfs3oYZi68oVEOIs43FhcmuFTR25+S770MYVkkRej1v22WyssUnfKCpsG9BY6qyJBaBAcN/PPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=excSsnQ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKvmM9F/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMYfP0NinDFGLxNKnci0CDBcOvub1aIPinmA6BUjoFA=;
	b=excSsnQ2QRlK/gveFdNeq7oe693DP3xtfxUxTO2HAMpfpbM69LM5H4Js/F5zgyXRseYxQ6
	aQkW6yCk+Bz4zGIU6hSSn8imzfnGbk0XpEr5jObNesq4ec2U7GZolFcQmpAl7GZ8LRkkIs
	bVpAmNHHW43ldjBeuyHVY0WnsVKW1ulophhl8S6w/fBsq3W/EvYz4/stJtFHaOiQdmxfRz
	7nQfFNL5mlqwvbda2p7wpradb28bLMg1zhwpQg6BiKcraWnrkocSUSiDhvoZLpBAheWdFG
	oqxmspxAirCUKiu/7/dtmwzL0zZULRsaWtxFOTdAe/K79SamyQC9aQvjFdY5rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMYfP0NinDFGLxNKnci0CDBcOvub1aIPinmA6BUjoFA=;
	b=GKvmM9F/kQ8lqL+rnp6eawX4bR8ogDU9iW8pRzz8NQW+SiXc5QxQuLNllp31nJdBrRzBhW
	fY4gxSogQUEJjtDQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: lock: Add an example for Guard::lock_ref()
Cc: Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250223072114.3715-1-boqun.feng@gmail.com>
References: <20250223072114.3715-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791558.14745.12750435046437937643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     33530ab4613d7544ff43df2d690c54d8ff9288c6
Gitweb:        https://git.kernel.org/tip/33530ab4613d7544ff43df2d690c54d8ff9288c6
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sat, 22 Feb 2025 23:09:24 -08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 25 Feb 2025 08:52:48 -08:00

rust: sync: lock: Add an example for Guard::lock_ref()

To provide examples on usage of `Guard::lock_ref()` along with the unit
test, an "assert a lock is held by a guard" example is added.

[boqun: Apply feedback from Benno]

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250223072114.3715-1-boqun.feng@gmail.com
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

