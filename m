Return-Path: <linux-tip-commits+bounces-6974-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B184BF5CC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12C40352837
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F532D451;
	Tue, 21 Oct 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kqq9sCJe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEmNU+E3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E92EC54B;
	Tue, 21 Oct 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042932; cv=none; b=K3zLlv76UYlW8m/MV4GdsgRRLsPr4C6nQyhM26IBlmJmYSVZjFgbxuGh/ivVKm0tfxR69QMg3pjFy2/LHKLq1lbJ5Yojvpzrk8pM4zQi/SHguTyezjmzvDN+pKwYRkj8F5zyfFE+xwwTJkJrWErCwhv6zLI7aadVT4JlpkdyhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042932; c=relaxed/simple;
	bh=y5TOr1T/lG92oQDxlqn4uXNahHbsgTTvhu3sqpquICc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hjfQu6mPHEJkvaY5SkfjS06Nmg0CSZ5CKjISMxhaUA9M347a+UBKL2+0cwMpxbEntf6ghAb6JAdxq6Yhl6CiHFWcnpIDEBAXObYbjuZDQOSjZ5miFv2PR/rig4hPXA8LycosRTRtOiViQjna7WRNGEe9Fct/H2zutQ8XNvX26NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kqq9sCJe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEmNU+E3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YW84Myi46TftMrfzZgMbDyk2q37ZrNSfAhTSi5wtDZw=;
	b=Kqq9sCJeYAQqmmrel2Fp5KQmeklgwk5G675gB8SGeup0thT4RnBXHGd4PV505qgRwaGYF3
	oJ371DZSpG9+cENOlLjcRXqvwHvom7mjqMcMyOUdlV2BbUFvkZTeaSO3E4nXc6o1ed4LR7
	FUbrWT2rs0/PxXCMZ9GHoAgy1WCGss9TIJubk2SbA13cI3B3vnOKytP+HCROj70rXFVIMO
	YnJjG63DjsogDd1HmUb1I5OuMM7zX47FkN1UzjyuqodV87StJQnU74TRlUbrMoivSQQuTf
	29Qer4733yNIRVWneigIpcxL9C9mMD98jyKlDPd1DLKsW+9JeeWxr7KK43/y1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YW84Myi46TftMrfzZgMbDyk2q37ZrNSfAhTSi5wtDZw=;
	b=sEmNU+E3Kjq8xFlDTPPmlM1yveMotRZ+aAes3oDsetYj/c/ZejBrZELq188oJYfDzf3i4b
	n/Ph/R6w8HuRQeCw==
From: "tip-bot2 for Daniel Almeida" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: lock: Add a Pin<&mut T> accessor
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
Message-ID: <176104292746.2601451.1165517538929905971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     66f1ea83d9f8346324fc50779944297d778cac95
Gitweb:        https://git.kernel.org/tip/66f1ea83d9f8346324fc50779944297d778=
cac95
Author:        Daniel Almeida <daniel.almeida@collabora.com>
AuthorDate:    Fri, 19 Sep 2025 11:12:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:56 +02:00

rust: lock: Add a Pin<&mut T> accessor

In order for callers to be able to access the inner T safely if T:
!Unpin, there needs to be a way to get a Pin<&mut T>. Add this accessor
and a corresponding example to tell users how it works.

This requires the pin projection functionality [1] for better ergonomic.

[boqun: Apply Daniel's fix to the code example, add the reference to pin
projection patch and remove out-of-date part in the commit log]

Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1181
Link: https://lore.kernel.org/rust-for-linux/20250912174148.373530-1-lossin@k=
ernel.org/ [1]
---
 rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 9242790..cb00fdb 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -245,6 +245,31 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
=20
         cb()
     }
+
+    /// Returns a pinned mutable reference to the protected data.
+    ///
+    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpin`]
+    /// types [`DerefMut`] should be used instead of this function.
+    ///
+    /// [`DerefMut`]: core::ops::DerefMut
+    /// [`Unpin`]: core::marker::Unpin
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::sync::{Mutex, MutexGuard};
+    /// # use core::{pin::Pin, marker::PhantomPinned};
+    /// struct Data(PhantomPinned);
+    ///
+    /// fn example(mutex: &Mutex<Data>) {
+    ///     let mut data: MutexGuard<'_, Data> =3D mutex.lock();
+    ///     let mut data: Pin<&mut Data> =3D data.as_mut();
+    /// }
+    /// ```
+    pub fn as_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: `self.lock.data` is structurally pinned.
+        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
+    }
 }
=20
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {

