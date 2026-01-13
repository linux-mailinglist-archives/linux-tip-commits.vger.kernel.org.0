Return-Path: <linux-tip-commits+bounces-7935-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4A8D183D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D085300F661
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1D3904CF;
	Tue, 13 Jan 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yD/aEZQF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VB5Phf3K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810A38B99C;
	Tue, 13 Jan 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301409; cv=none; b=lhVf2Argd/YYpxKrI7huK9moe6RY/Z9+XD3DDq3OgP4sQLyciXPqGz6GsqDkmGym+FQXSedWJdfkHYW1loH3AQnHx0ySTBCwH0AE99p+7yHSyOBadlGzcO1BDgRm4et5UsGYW/fAm1xr7aK43yZPFot/LAZw+hUvBEe+j2j9XPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301409; c=relaxed/simple;
	bh=xj+HUKNFEc0jNrALrvx/sEOdoS+dwBaFm5CTIHM9C/o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZNjbl0r9ajdJvMvTdqlJcXnvRvoLYqBPEkkB7yYlE6D1SqOSyfu1fF9HBGQfiY+MapPKB02R+LKm5TJ1HMnwK1CkkvCi8NFpYIpsV5le2z3/AQ5LCWRlhWQOX77BpEWG+LKfHiEKOndlXONRsMTG7qZIwlGm662CTLyZozqz8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yD/aEZQF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VB5Phf3K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZolMmr3y9c98NbeGtrIR7AI/XmEht7sTGEHc2hyt40=;
	b=yD/aEZQFEgXT10HFuwc6Yu/lEZAMb9QPFqAal9e/XUvNdEQFzZv1N4dL3M9Mi5l4bzEIFn
	iwZlzamVaHq/iWjzavhPrPr3d1b7rk06Q0KUMkjDi2aTnKHKEgjFC4hD3oFSefpRNRYZH+
	sTAxxnDAt3AHJSxGGKoeB8Kul72giTdIsLACefldr8oPvNoo05JS5XtT/x/gPc7Mm8v77P
	zoqUAIuV4PovUk6+yzENWnFf67IP2uPUd0S/sljqKKebsZuFHuvrzgopNOIelN6x5MiGo3
	t6XYYI0gVfS7GBZpGOAvvYNlYlUnmLSwEVkKkjcei96VtoN+rzKHoJMGbFaAgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZolMmr3y9c98NbeGtrIR7AI/XmEht7sTGEHc2hyt40=;
	b=VB5Phf3KRJn6O9kIJs9E/hNEOg0sZQJn2OQyJsSDPI46vMrl69k8F11L/jPXgjRaqPYWIj
	PQzMMt+a9HtuBnAQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: helpers: Add i8/i16 atomic xchg_acquire helpers
Cc: Alice Ryhl <aliceryhl@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223062140.938325-3-fujita.tomonori@gmail.com>
References: <20251223062140.938325-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140541.510.495861634863839444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ab717dd98bee964add2161d94193d756fdef614c
Gitweb:        https://git.kernel.org/tip/ab717dd98bee964add2161d94193d756fde=
f614c
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 23 Dec 2025 15:21:38 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: helpers: Add i8/i16 atomic xchg_acquire helpers

Add i8/i16 atomic xchg_acquire helpers that call xchg_acquire() macro
implementing atomic xchg_acquire using architecture-specific
instructions.

[boqun: Use xchg_acquire() instead of raw_xchg_acquire()]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251223062140.938325-3-fujita.tomonori@gmail.=
com
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 3136255..177bb36 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -60,3 +60,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg(s16 *ptr, s1=
6 new)
 {
 	return xchg(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_acquire(s8 *ptr, s8 new)
+{
+	return xchg_acquire(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_acquire(s16 *ptr, s16 new)
+{
+	return xchg_acquire(ptr, new);
+}

