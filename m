Return-Path: <linux-tip-commits+bounces-3132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D39FC16B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3E1659E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277DB2135C4;
	Tue, 24 Dec 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYh2DuHc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mAAHPNoW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E3213224;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066428; cv=none; b=WtyIAZsOxAymlMotgybwFTyICJrgCcQTjRK54gHw91mjr9SXpL6G+sIivu6PtVVdNL6ujm0nZFP2ivRLcuOaV7wpgAqfjXN2ra4KHZPibT0oNmmc9uNLZ1NYLzg+NHcSnS+CjvQLuE5riascx+XGyg+tmqn8bKT4Rw7GOYNT0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066428; c=relaxed/simple;
	bh=d9Jb6QFdfIPqES73Ppx6OW0vGfS7P46se6GNzBogIYo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N03nkSoHhyO0CEQ9uaPhuxw6HHwU3nFAtnrEvah4MYJ8SiT2UWqrQbo/NhlwejEAWKphe4sQWVRV1tBXOQnt8iJ43Ulhj1xCgtaPic+RONoXTK1W5KoRNrk1EOknSql1QtN9V29yiQadg1FBDbEnQfFx5FwZBbBykMlrTkucaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYh2DuHc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mAAHPNoW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgVUsKABdHpEYmqgmaSKFIIAINXEmlW/h14jHOrfKQ4=;
	b=MYh2DuHcrqqD4uDC1pGMZsD/ZmSxuyE42cVDW7iUYbSOObPESLRyind+/CjczHVQnluMvn
	U72VQetBLhkXgyJ6kqWLd57Re0a3Wg6aW2SM0ZF9Im1mUbwR/19oAFS4d7E3Bsc9jxshCU
	sNYQlVKl3c4UPdtK4pASAbCRslySB1Wzk3pINcUyaj3X6hUonT634kee1bVyJUd73NatVc
	NFOoXsoDJe/jrWPfJxlg1R7E5cPWqBjTVj50j2vpdauaAcFOz+NmKJ9XK1jkpnU+dbk2Mx
	wN8gGXAErpvWz80gYkB8T3Y7QwF7el3trSgrHYOJeGu3MvxtzxlRQxqDaUKVIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066422;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgVUsKABdHpEYmqgmaSKFIIAINXEmlW/h14jHOrfKQ4=;
	b=mAAHPNoWkEh6DonF3meFfTplVdyVGbEAA2b/fzAYLtU1inp9lxZXAqWPKat0NcEPR06Gq6
	DDo9uUnKXpj1tmDw==
From: "tip-bot2 for Lyude Paul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add Lock::from_raw() for Lock<(), B>
Cc: Lyude Paul <lyude@redhat.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119231146.2298971-2-lyude@redhat.com>
References: <20241119231146.2298971-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642207.399.10415197352412807962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     15abc88057eeec052aefde897df277eca2340ac6
Gitweb:        https://git.kernel.org/tip/15abc88057eeec052aefde897df277eca2340ac6
Author:        Lyude Paul <lyude@redhat.com>
AuthorDate:    Tue, 19 Nov 2024 18:11:03 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

rust: sync: Add Lock::from_raw() for Lock<(), B>

The KMS bindings [1] have a few bindings that require manually acquiring
specific locks before calling certain functions. At the moment though,
the only way of acquiring these locks in bindings is to simply call the
C locking functions directly - since said locks are not initialized on
the Rust side of things.

However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a
ZST - `Lock<(), B>` becomes equivalent in data layout to its inner
`B::State` type. Since locks in C don't have data explicitly associated
with them anyway, we can take advantage of this to add a
`Lock::from_raw()` function that can translate a raw pointer to
`B::State` into its proper `Lock<(), B>` equivalent. This lets us simply
acquire a reference to the lock in question and work with it like it was
initialized on the Rust side of things, allowing us to use less unsafe
code to implement bindings with lock requirements.

[Boqun: Use "Link:" instead of a URL and format the commit log]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patchwork.freedesktop.org/series/131522/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241119231146.2298971-2-lyude@redhat.com
---
 rust/kernel/sync/lock.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 41dcdda..57dc2e9 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -96,6 +96,7 @@ pub unsafe trait Backend {
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
 /// [`Backend`] specified as the generic parameter `B`.
+#[repr(C)]
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
@@ -134,6 +135,28 @@ impl<T, B: Backend> Lock<T, B> {
     }
 }
 
+impl<B: Backend> Lock<(), B> {
+    /// Constructs a [`Lock`] from a raw pointer.
+    ///
+    /// This can be useful for interacting with a lock which was initialised outside of Rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ptr` points to a valid initialised instance of [`State`] during
+    /// the whole lifetime of `'a`.
+    ///
+    /// [`State`]: Backend::State
+    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
+        // SAFETY:
+        // - By the safety contract `ptr` must point to a valid initialised instance of `B::State`
+        // - Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
+        //   the struct
+        // - Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
+        //   `B::State`.
+        unsafe { &*ptr.cast() }
+    }
+}
+
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected by it.
     pub fn lock(&self) -> Guard<'_, T, B> {

