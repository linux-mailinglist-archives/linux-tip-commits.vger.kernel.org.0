Return-Path: <linux-tip-commits+bounces-7928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF237D183CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E1A3033BA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ACF38F242;
	Tue, 13 Jan 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k84myGw/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PMo0Yzof"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7338E13C;
	Tue, 13 Jan 2026 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301404; cv=none; b=mMaLHKtOdnMqRUJdvtoIub8fphw/d3R0AExshe3j0IbcCzgEvhAsUJcg5RCA4xpkkOm0o3nQ8dT0Ol7ZBepPumoAhzbuBZiYCIzBqYgB+k2B/iBAink4oUPkvxeUQJiQ0Nl9XQirxMxSKoXiYdjeUOnctpQP1z+MuJTB3Mu/rkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301404; c=relaxed/simple;
	bh=1G7dz2yQFb+jgtZz5u9ynGE194XEZPJeSy83hDDytpQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cWmIJ660RgHmkmhDwqCkfKhxNsWOHqFIbmJbcreu0AYIrXp6cnPHeNHyQ5doCIB6NfDZlLSsAZ0eU4h+XRTmRXbV604W3Ii7T/SpV1RNW0Y89R5I7N8h6R3a9thpOspKNEdM5oJp3pXIZ5Edn3ptYhaDVunFYiesiHsQsE9f/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k84myGw/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PMo0Yzof; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L0Rv7b1z0p68iHgdIsfz6EuH6JVku3PfGIlfwKl3t4=;
	b=k84myGw/SVXXdEjnJVr+mc64pN2Li5kqbMgGmJV2REfxfV2JG8T9AJ1QzcaKUaBQcc3Ax8
	ZaE6tOKU5OstJnxtMH4v7VoYIdHQwhTLrL5dpPo+xG2bMz/UBj2GVSBiOGt9bObOq7kUot
	OGLXQt5nTHYq8RuxVm0Ay5cx8WzmpOziOd8nqOiCM55t4G5iyvzRUSTFfF6xaEmId4Kxvt
	Odl478Vpj9BZ8RjpzunIsPjwP+eXii2oAVe6Y9928kgKILX4B3w+sCBTYJwffuL7LsjTi+
	eBMV02OkKUbYZqTN+PTGh3KEs4HZuqlk/g3mzT57x0vFsmxwVl5Z4dxKKjLHBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L0Rv7b1z0p68iHgdIsfz6EuH6JVku3PfGIlfwKl3t4=;
	b=PMo0YzofMwd4NOySw7LKu3jVVoTZiCNA6OkHV2JNqkaxPwa9ihz6R5eLujp8nFVZMVTTCW
	HRBUECl2k4aRxMAw==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add store_release/load_acquire tests
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251211113826.1299077-5-fujita.tomonori@gmail.com>
References: <20251211113826.1299077-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139454.510.708996413489343647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7b001c97d9bdaea50e1e1834040c58f7ef9f4e89
Gitweb:        https://git.kernel.org/tip/7b001c97d9bdaea50e1e1834040c58f7ef9=
f4e89
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 11 Dec 2025 20:38:26 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Add store_release/load_acquire tests

Add minimum store_release/load_acquire tests.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251211113826.1299077-5-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/predefine.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 09b357b..51e9df0 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -138,6 +138,16 @@ mod tests {
     }
=20
     #[test]
+    fn atomic_acquire_release_tests() {
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
+            let x =3D Atomic::new(0);
+
+            x.store(v, Release);
+            assert_eq!(v, x.load(Acquire));
+        });
+    }
+
+    #[test]
     fn atomic_xchg_tests() {
         for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x =3D Atomic::new(v);

