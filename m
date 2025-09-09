Return-Path: <linux-tip-commits+bounces-6509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A41B4A62F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996F0174A8E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98627B343;
	Tue,  9 Sep 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11xJ2dEe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLYXDWXY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FE279DA4;
	Tue,  9 Sep 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408210; cv=none; b=C+O0yUEGpt19ES5hLOL+m3Hxd0yxJUNvS+qXHSYwRl716Kx6TGsa7G0HB8Ap6HO1RkW56YEXPPF46VI7nTA/7KWxQvkrmPg76Z1LNKLdLGE8cZX14ry8AJLbi74MmnWD+1321D3jJTq6QjqNtI+CioUllHZvOMRU0M1c6lzu/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408210; c=relaxed/simple;
	bh=f0CF4LpCrVZ4021qdnCVWeI255uHzDxRY1A9lFE8dcM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cHLQom4kAqgsKlpX3n6h1VzpBM2UzNVl5IqZoLXoY0xGK/RhFaOZprgtq3PM+kp/MkN2xWy1XZ9876wTM67Ts7OdZqj32xAP1CUY6lNlbnlk3z2AiDkJAxIJKuIIGU5H3bPg7Y3uQ/ORmkAqBKDGkfYqWu6O58+CklVujrza8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11xJ2dEe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLYXDWXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEAGgsJ6/79XVFy9LFNkYcFnDCtjj4teRLj/ijNhFi0=;
	b=11xJ2dEeDyZZlPjsPciqufGrQLJmm4j1Ednkr1i2v0c+sW1SLl43UC8SEJWGkUyrd1H7TA
	YZu3noAhgqQ7KdnwjvNPKl0pvFGdNf1XHPTAsrMXnqRkgro8tgMkX30LXt1FJCUyRQn770
	7JEZxrw/AaETw2dKu9fmq/5JCarRmhFFDxyFQ/qfv5B28i0xVQLhVNhxngx7uTsgYZluPx
	Za8nmIsCFQkk3+lDmHmozFJeFODLkjJ+elBLKusu/D0fchMFRWpSSO1Ep7/W6WhjKgN5ar
	jArYlZNxgpnEzX9JoCYX5dsTCINrHb4uwpe2yCdu0yEDKFTkw03WonLy9dfo9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEAGgsJ6/79XVFy9LFNkYcFnDCtjj4teRLj/ijNhFi0=;
	b=YLYXDWXYUmNKW5XkM1oWpNw8M7sHw4EY99qBjmxZrxaygyvKxOK2u9KmKtxgNs9I2s8jAc
	YbqzNquQtbWGqxAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] sched/core: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-3-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-3-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820613.1920.18406871549314820799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9aacede5e1c8b626638356904f0247672dd68881
Gitweb:        https://git.kernel.org/tip/9aacede5e1c8b626638356904f0247672dd=
68881
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:18 +02:00

sched/core: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-3-b962=
cd9d9385@linutronix.de

---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629..4dc1283 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -917,7 +917,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 * doesn't make sense and can cause timer DoS.
 	 */
 	delta =3D max_t(s64, delay, 10000LL);
-	rq->hrtick_time =3D ktime_add_ns(timer->base->get_time(), delta);
+	rq->hrtick_time =3D ktime_add_ns(hrtimer_cb_get_time(timer), delta);
=20
 	if (rq =3D=3D this_rq())
 		__hrtick_restart(rq);

