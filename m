Return-Path: <linux-tip-commits+bounces-6149-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3CB0B129
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9664617AD67
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4919289352;
	Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pS2TW3wj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="36Et6zrO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1F2882DE;
	Sat, 19 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946823; cv=none; b=usuBQeRVa5baVK90VdmWOLBaMcbkndU6amtGvgmwnFzcq7pNGsV06iQXGDSsrK2/L+/FsnCC9AKsBr6yAuEtUj1iySDISxy4PhUiZsl1w61/C6s58/MLmztGS9y/pprMP+Ss1QSXYnaPRVeAWj6Bfs0g4szTeAmocNMPtnK3t9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946823; c=relaxed/simple;
	bh=MjxkVVGi5GSJll0BhSPXm2yTHZQJDaDVPPqAhNfBc28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LxrXCIMb/XaUkfsKIrXWfF/t/Kq7BCKH8ieS2wLFKyppL3SdNiRkL2oUbZrYk52BJryfaPaqHdXFK3C2J5epAx05FqgZelbN1cLmLfuelrPevqCbndrM5rOhMGvo1rKBp/EnUza5M/WGl0A1kDq40xULbwln8WzjzkUZB2CUhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pS2TW3wj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=36Et6zrO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DF/yhjnaLGRF2nb60JahErrPvLJ8RaFkIMwDiMJuZzM=;
	b=pS2TW3wjKWlcJ8vHYUgCBSxyTyXVQDAKF2K6WYmnGoG0P9IStkbIUgpOKeWebk9Zh1azc4
	QwwvDHohrL0PWZsaTbjKfYAyVj+m9K7ZlzvCUHxLHBGnPdbWcyGDVsxVZgmQZF65LAJK5/
	tsTo08BHMODNfTKSxzFURqSnL8okmDSXHFGbra3q38ATHMRIcytRBESyS/dOqp7Uy1rld/
	xqQPkSgUbvOJFx9MQl3UThT9e596jhxuBNyDaJJjYYvOnILDztgNRxtcV9q3Op/MNS1ng8
	p/HmkM3HzlczdrMucnN+jk4wIvIxADs4XCtV4lLPK6R7dx+ZIXxhRX2DUvtJeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DF/yhjnaLGRF2nb60JahErrPvLJ8RaFkIMwDiMJuZzM=;
	b=36Et6zrOHwAA6qvON276iGOP0oCfZmoyYgDM8WpPaI7zoInL2hhIVsPz7YR5i+aNWbc4Tb
	+AU2AwbCb6Q+NbAA==
From: "tip-bot2 for Jason Devers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add #[must_use] to Lock::try_lock()
Cc: Alice Ryhl <aliceryhl@google.com>, Jason Devers <dev.json2@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212154753.139563-1-dev.json2@gmail.com>
References: <20241212154753.139563-1-dev.json2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681414.1420.16229564078269746655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     99214efedea521f1b79fa2a28ff142e933fc3eba
Gitweb:        https://git.kernel.org/tip/99214efedea521f1b79fa2a28ff142e933f=
c3eba
Author:        Jason Devers <dev.json2@gmail.com>
AuthorDate:    Thu, 12 Dec 2024 10:47:53 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 11 Jul 2025 15:11:54 -07:00

rust: sync: Add #[must_use] to Lock::try_lock()

The `Lock::try_lock()` function returns an `Option<Guard<...>>`, but it
currently does not issue a warning if the return value is unused.
To avoid potential bugs, the `#[must_use]` annotation is added to ensure
proper usage.

Note that `T` is `#[must_use]` but `Option<T>` is not.
For more context, see: https://github.com/rust-lang/rust/issues/71368.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1133
Signed-off-by: Jason Devers <dev.json2@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241212154753.139563-1-dev.json2@gmail.com
---
 rust/kernel/sync/lock.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5b..27202be 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -175,6 +175,8 @@ impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Tries to acquire the lock.
     ///
     /// Returns a guard that can be used to access the data protected by the=
 lock if successful.
+    // `Option<T>` is not `#[must_use]` even if `T` is, thus the attribute i=
s needed here.
+    #[must_use =3D "if unused, the lock will be immediately unlocked"]
     pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existenc=
e of the object proves
         // that `init` was called.

