Return-Path: <linux-tip-commits+bounces-7926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD64D1838B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3CB53022389
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7D38E5F3;
	Tue, 13 Jan 2026 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3Emue9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpG0mgXs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112238E105;
	Tue, 13 Jan 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301403; cv=none; b=EeOnmVIhb6J7B9K8dzKLfkgFsYsffXvNA5TB8jOfVm2+Z9lismqGCVRg8P4Kd0AuZXdp0PirWF+T+8WkF5uyVvhyHHsHF/jz2P2FyP5trMXRsch2WWNm2UZ6D2CmK1Tv21WwHpUkMNw7ykudZWSWeboWYl+pozIuvVWbT+C0jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301403; c=relaxed/simple;
	bh=ooq2efFJdtjif044w0BZtKk+y6A22kuVqK0X5bTcuO0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jMG6P/yDIojXS3oYyb8OehFlzgCJ28tyKCqf1O658VejyOT+853Rlfy7yuFwmjLivA0lnhSbRQYs3wINP5usT+YaI3MaJ//Vrsx2lv5zcpCydP/utu1hJDJyrdnJ643umoD6AMqAA1c/ulY8JvDHJzNGSUA1cR/KlXkrLAsM9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X3Emue9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpG0mgXs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJryVh6CvOOKsKh0XvWdL9OHBULkVcDyPfaTbjtzoNA=;
	b=X3Emue9hjqK+v/YJZrM14iYw4lyj7Cv7gUrjOWEi7/lg0azVYtH071ICSTVD8ah5vD8ahf
	M2aKJx/c+XEFR86c1d8jH8skfDYbEWNVq22x+snsLMyAX9J/S8qYjwhmupd0i47iQlddKz
	XGLhUBV+lxTOUMJZ8JEKWVqByw4txdZabacezh1v/u7sM73R88+TgDdQDdIzT1/vYCeW1C
	NyJkGh7dAcEdBNa/Y0yjFQ4zD3BfdGdxJ19T8ptxGx+oCxxjr2lihcLzjgQIUtFeyC/J/x
	dB9kI6hoxQZk6JjYgVBa3jwGclOANgFpcOkHUYrYL5hjIodIZ9T8HfwQAzyiFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJryVh6CvOOKsKh0XvWdL9OHBULkVcDyPfaTbjtzoNA=;
	b=YpG0mgXsVluC80T6AylQbCP1i2liwFYV4JHu2tZXfXsrzJLN7k+OvQW5rOmQNnXwLnzPgv
	CzayjyRyVMd6zsBQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Add i8/i16 atomic
 try_cmpxchg_relaxed helpers
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251227115951.1424458-5-fujita.tomonori@gmail.com>
References: <20251227115951.1424458-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139916.510.6034582803335438352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8de731a6c75547602601a5d219b5cf259ce2b38b
Gitweb:        https://git.kernel.org/tip/8de731a6c75547602601a5d219b5cf259ce=
2b38b
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Sat, 27 Dec 2025 20:59:51 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: helpers: Add i8/i16 atomic try_cmpxchg_relaxed helpers

Add i8/i16 atomic try_cmpxchg_relaxed helpers that call
try_cmpxchg_relaxed() macro implementing atomic try_cmpxchg_relaxed
using architecture-specific instructions.

[boqun: Use try_cmpxchg_relaxed() instead of raw_try_cmpxchg_relaxed()]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251227115951.1424458-5-fujita.tomonori@gmail=
.com
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 962ea05..7d0c2bd 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -127,3 +127,13 @@ __rust_helper bool rust_helper_atomic_i16_try_cmpxchg_re=
lease(s16 *ptr, s16 *old
 {
 	return try_cmpxchg_release(ptr, old, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_relaxed(s8 *ptr, s8 *ol=
d, s8 new)
+{
+	return try_cmpxchg_relaxed(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_relaxed(s16 *ptr, s16 =
*old, s16 new)
+{
+	return try_cmpxchg_relaxed(ptr, old, new);
+}

