Return-Path: <linux-tip-commits+bounces-6151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97145B0B12A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F67FAA2DD5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DD289374;
	Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="psZlhkEi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="baA127/y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511E28851C;
	Sat, 19 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946823; cv=none; b=thpJZiKcv6/aSKabKtpC2x4UB7MpfwkPDsasHfM/ydtUhOX7fEEA0Om9eI/J/bGKBQ3duJqenVxBW3O8ypxXgV+G+geTtGvVI4/Ocz5qr9mrQZJlcs/n1tyVbRjovafN7zMWNLJNGS8o/+JSoZO2sXHRx/23WT6NWaUV0YPrstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946823; c=relaxed/simple;
	bh=uX7clJ3kaa/0YSvzCqAlE8bYsrQtjtKD2XEL/zIFE64=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t70eX7moXty0dGUVm+upLOI4o9DJcVT5MD5bz9HM4Sl8o0TKb1MxK+mV+0t69/yQlq9M7xAmMxF3qZQY4KqaP5m1FqD0r7YMlMne0CeiHMqjicKg1IRij628LJ7JWdIKyelzVceVwQ6cVxnVybetOkDozTQJM5+9K0D+8dwHKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=psZlhkEi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=baA127/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dONY1/dmMhzaGV8sY3sTaCKVhwe5SGWl86f3si7jgk=;
	b=psZlhkEi1yv+SZZVhj05nwXvgrPqX/9UH8fJCdsmo9nYed0tV+G4c0MD2upS9wPCLXdqca
	SZIOoTfcchbxrDLVgTe2ZusCIcoa6ORrDXA86uwPJkWxzjfmazYvrwSNKYPwnlySFFKLud
	xDo6hfEEWURxJ+LQnEpK7RWnjw7xZYFuzpxtvTTNb+j3QeSbUuFx3VYX2iVm7KfuhvmcuR
	mn15QjT98duJT4xrmEgCtvVvU78QaS8h0hZPkV7gKmRK0WoT9BYedzskQ3mBxMgvHwv+5S
	3SRzNCWIfKVOhH8GGP/i1mqDh+MYx+mVTH6CzifFTa6OFxm/5sjV54CBa9W2oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dONY1/dmMhzaGV8sY3sTaCKVhwe5SGWl86f3si7jgk=;
	b=baA127/y22xRQmNyMfogoxKY9j5OQN78YAWMbrtQvWtXLAnW9MH7Qz+o2Gy9U83e3Guav/
	L976077l+xNzAVAQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/mutex: Mark devm_mutex_init() as __must_check
Cc: Peter Zijlstra <peterz@infradead.org>, linux@weissschuh.net,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net>
References:
 <20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681519.1420.7884388812046996076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     daec29dcc8731b7596690ab9f647839e4584a86d
Gitweb:        https://git.kernel.org/tip/daec29dcc8731b7596690ab9f647839e458=
4a86d
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 17 Jun 2025 19:08:14 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 11 Jul 2025 15:11:54 -07:00

locking/mutex: Mark devm_mutex_init() as __must_check

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=3Dy the mutex will be
marked as unusable and trigger errors on usage.
Enforce all callers check the return value through the compiler.

As devm_mutex_init() itself is a macro, it can not be annotated
directly. Annotate __devm_mutex_init() instead.
Unfortunately __must_check/warn_unused_result don't propagate through
statement expression. So move the statement expression into the argument
list of the call to __devm_mutex_init() through a helper macro.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-3-d9e4=
49f4d224@weissschuh.net
---
 include/linux/mutex.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a039fa8..00afd34 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -126,11 +126,11 @@ do {							\
=20
 #ifdef CONFIG_DEBUG_MUTEXES
=20
-int __devm_mutex_init(struct device *dev, struct mutex *lock);
+int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock);
=20
 #else
=20
-static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
+static inline int __must_check __devm_mutex_init(struct device *dev, struct =
mutex *lock)
 {
 	/*
 	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
@@ -141,14 +141,17 @@ static inline int __devm_mutex_init(struct device *dev,=
 struct mutex *lock)
=20
 #endif
=20
-#define devm_mutex_init(dev, mutex)			\
+#define __mutex_init_ret(mutex)				\
 ({							\
 	typeof(mutex) mutex_ =3D (mutex);			\
 							\
 	mutex_init(mutex_);				\
-	__devm_mutex_init(dev, mutex_);			\
+	mutex_;						\
 })
=20
+#define devm_mutex_init(dev, mutex) \
+	__devm_mutex_init(dev, __mutex_init_ret(mutex))
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.

