Return-Path: <linux-tip-commits+bounces-3126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAB9FC162
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F34188494A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A8212FAA;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2KA03+AN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSdx0CRF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB120E327;
	Tue, 24 Dec 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066425; cv=none; b=Fb7Rymh7Rw0HNb2iMLg1ZEkhiMjwmtto1QG7pBF/D0MzPcNwhjm0eBXel2g9klUBODFTM670aiIf6oVdLwDuWsS7chsA/1P8HRghhn1S2KE4MJ3y5YPeB1RYavG3Igp7R6koGyX1ILKJiHef4XXd2NsKJ1UsbHhv8Vp6Tz7cnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066425; c=relaxed/simple;
	bh=CjzxPYylJGSlrNsiGO8Uv47Ji01goB7uThCUcT3kOD8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JpbAMfF+ruPeDxiS4kfmqCeXnFbO2pwPtctxb8ND1uoPq7O5MIwt1HNhBKhnJEOOFolGu8uiYgfVONs+sEPzUNH84ctZj9ECRYt46I45EpyIGPJZc9k1ytGWeAOWr+gViF+hwgPnL/qgxfPu7wVFBsU+7L1o+vDBEhTxZ122FGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2KA03+AN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSdx0CRF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UsleYWETZXQWTH+lq4d1DAB5+GpNF8fCgIDhssF25U=;
	b=2KA03+AN43o4FB2nZEBqWeVlnpC2Fsl6aLbeWzsKSeTfKyamNjAqwoq1bBFW7ShQt3DYKy
	EsDmjNjNy4ZupJZ0iT+WUUcSCAkxnR1QZCnCVNJ8w87C/zjMHEzHkNi+oMuibJr8LN2lwV
	kd6TGBatXRtEBSmdrM+v4peHyP1iBw31IuiBvp0e0ofXyVixxLL25HWwpGfHhKiUuORBR2
	HZAp/paX12M4E6lQZehBIh6kNMkejgG1vh/9KIgmyknIcPpHlUMYmn5IjSnMBHV/rwmQLi
	zpc/7C91tgud/Oqb9flwECFCBCwgGQs1ttdy6pi2cqFNTvFco8rDwa0jlp7CTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UsleYWETZXQWTH+lq4d1DAB5+GpNF8fCgIDhssF25U=;
	b=cSdx0CRFRUQrTIk11dLTo+E4VCGPnuE5o8WfuFZoHp8arqubK6uez2fhmjUrMoPrhBCxsH
	sKe6IU+bpBXxEBAw==
From: "tip-bot2 for Lyude Paul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add MutexGuard type alias
Cc: Lyude Paul <lyude@redhat.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241120222742.2490495-2-lyude@redhat.com>
References: <20241120222742.2490495-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642113.399.14882143596480911485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     37624dde4768ec25d2f9798aa75bf32e18c0eae2
Gitweb:        https://git.kernel.org/tip/37624dde4768ec25d2f9798aa75bf32e18c0eae2
Author:        Lyude Paul <lyude@redhat.com>
AuthorDate:    Wed, 20 Nov 2024 17:26:28 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

rust: sync: Add MutexGuard type alias

A simple helper alias for code that needs to deal with Guard types returned
from Mutexes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241120222742.2490495-2-lyude@redhat.com
---
 rust/kernel/sync.rs            | 2 +-
 rust/kernel/sync/lock/mutex.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 1eab7eb..2721b5c 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -16,7 +16,7 @@ pub mod poll;
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
-pub use lock::mutex::{new_mutex, Mutex};
+pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
 
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 0e946eb..10a70c0 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -86,6 +86,14 @@ pub use new_mutex;
 /// [`struct mutex`]: srctree/include/linux/mutex.h
 pub type Mutex<T> = super::Lock<T, MutexBackend>;
 
+/// A [`Guard`] acquired from locking a [`Mutex`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`Mutex`]. It will unlock
+/// the [`Mutex`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type MutexGuard<'a, T> = super::Guard<'a, T, MutexBackend>;
+
 /// A kernel `struct mutex` lock backend.
 pub struct MutexBackend;
 

