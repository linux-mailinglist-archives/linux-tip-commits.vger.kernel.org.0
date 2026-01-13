Return-Path: <linux-tip-commits+bounces-7931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B50D18385
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B8953028552
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77372369233;
	Tue, 13 Jan 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCtVMKKs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLujsRja"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700138F24D;
	Tue, 13 Jan 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301406; cv=none; b=sARBTBCpapotBwh6M96NqS4KE0M4fKy5OleU5pY3kTUZ5r3R0uDvOmS9qbMuDrk4PY+THZRbnTl5tg8PdyuZBFmNpfyE12GvkLqAYvdWQyAQLRnUl0t0QQfBQrb7PyokAucpIvNkNjGZ2dlPudIkNqA6pgskN9LDUfozlndiNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301406; c=relaxed/simple;
	bh=QlCUMepsiqB0CoLYXKZxiNkA0de61nF9/G6od6c64io=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZnFOBi9OAwxmf8dlaWi7MaRTlo5VIbHHrj2FsSoHZ8i1Ej4aIDnH5HxKGMNsXwuQi9DEKxERmLQ6Q+Lh+4FFvupbWa3LrAGhOJTmmc/PBhEib0f546B3/jlrqAcav6tXoNHX8PEbI78DFyRUwCOuh6SyhhuxyI5dcbBrEBypNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCtVMKKs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLujsRja; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O48JlxhSDzhoJmou/vdXoPRUUOGaua2zDywDiSQBCeo=;
	b=gCtVMKKs8vLybENrA2FPlOGmawyAc+Qz9jCcrPIJ/f/yBBTzzDJhL13T2yGWRfkrv6dE4e
	HZXyHQkS+MvvEf+OH/+gfQSMePhEi2VLQx0eydsQ1Wssa97P3TED5HREJX+U4m8rl5th1e
	ubdXRcX3y+ql501LrNjZ5wmP40aIVJ7RzcdcfY5TSr3o3Ksnj2RYkjup4kIFPkDaM45SB8
	mnuhkc2/CgfZl5jbtYEgZKCyYA6TGnCjk8ICC3E8YUJLgRsMQcld0jtIC3IBE6a99Dx0py
	K73AloMZkLHS4K3D19nANdxluV0hZQT7bnZaKxvMsVhrCj4hn6Sf9Av+2XFo4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O48JlxhSDzhoJmou/vdXoPRUUOGaua2zDywDiSQBCeo=;
	b=FLujsRja06yn2OgfJogncfDwo4Ba22nRRgoZXhwoEwdh+apuAIpapVYFIuaCfmFKzWBKXh
	ailR9NM3g5AEItBg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: helpers: Add i8/i16 atomic try_cmpxchg helpers
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251227115951.1424458-2-fujita.tomonori@gmail.com>
References: <20251227115951.1424458-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140226.510.11729740524432949531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     164e4b5600b32b4ddeac58bb5b37bc1490a1dce4
Gitweb:        https://git.kernel.org/tip/164e4b5600b32b4ddeac58bb5b37bc1490a=
1dce4
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Sat, 27 Dec 2025 20:59:48 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: helpers: Add i8/i16 atomic try_cmpxchg helpers

Add i8/i16 atomic try_cmpxchg helpers that call try_cmpxchg() macro
implementing atomic try_cmpxchg using architecture-specific
instructions.

[boqun: Add comments explaining CONFIG_ARCH_SUPPORTS_ATOMIC_RMW and use
try_cmpxchg() instead of raw_try_cmpxchg()]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251227115951.1424458-2-fujita.tomonori@gmail=
.com
---
 rust/helpers/atomic_ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 76e392c..5ee127f 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -90,3 +90,20 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 =
*ptr, s16 new)
 {
 	return xchg_relaxed(ptr, new);
 }
+
+/*
+ * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
+ * architecture provding try_cmpxchg() support for i8 and i16.
+ *
+ * The architectures that currently support Rust (x86_64, armv7,
+ * arm64, riscv, and loongarch) satisfy these requirements.
+ */
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 ne=
w)
+{
+	return try_cmpxchg(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s1=
6 new)
+{
+	return try_cmpxchg(ptr, old, new);
+}

