Return-Path: <linux-tip-commits+bounces-6511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A3B4A632
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A2A3A7834
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2B280332;
	Tue,  9 Sep 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfxJBbGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpRluhCV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2827AC44;
	Tue,  9 Sep 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408213; cv=none; b=A3kccQN0YIfYmPD5O3kwh9PG1nT67H5uW1iWiVpNEmn6eFtotioixLWVd8W98r3o/H25MMKN67wFRiz+OTJ4fFhbqO7OY5xPiRj5KU3M/7r90kxGBV67Xk2PCnMjZcP3/mPQ6S0PWAQt+zbsuLO31BRvgh/F7TZZrCuC62Xb2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408213; c=relaxed/simple;
	bh=VF0x3byHdztncKi/hziqkHIKGEbYyCwZS2M1XBmD+7E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HddLf4n5qN1nCyy/JmRpWoPoAZjdMVH3YTAt2jwMvrpztVadDNdsE+x4QZaK8c0X9qlK4molrLpk5LmaEC2yv0AhMS3SQRANleXZPFkebBnwQhn050cDB9ZfYwjJyX9jyW2aRbNa8U8CNnr+DLmIUyzgJGgGEhtdL3eHim8S6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfxJBbGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpRluhCV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKDuC/XcvALpDVJkl4tWMB9YA0wXOwoP0W50CwkeDNA=;
	b=WfxJBbGQwRYG4T/P0ZEGJxyQSnnGEwxqQc3hpN+9kg+dalnIzLSqhaDROPJ4iF0zr/3MwQ
	d4q8Ks/TeztkAA2L1mjJGjNn3uRGvz5gbPeW4CKtcT9bA+zqa0J17vX33hwtiWjvfxqAAX
	wfSYcgjKfYCJunpDkvUEo87eODb8TAQH1mIhuyj/l7OeHoKmCX/B3g18Z96jYCig5MDZtT
	5L8Le+F0Lpv8jpEo/b28TaZKXQ/mWj+YMHxAAQwSAfz92BJwJweWq0Z3WLmsSAAes6YRWW
	6am2h68Hitiv21hmOGv6Rw4A5iV8I6Ngz4PqdbQEoyobSyU0qqWaqFtASZ+ZGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKDuC/XcvALpDVJkl4tWMB9YA0wXOwoP0W50CwkeDNA=;
	b=gpRluhCVwBkMs6TYMJnkQ5Q54Ugad/wEvAIBd0N4erZJ4m98CjkKQo5yA98u0FFIOrMrfw
	UQXZEnvMXkfFWsAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-1-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-1-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820879.1920.9931788106585264553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d298fea67fde4e5cdf3a563fdb31dd0af3da73a7
Gitweb:        https://git.kernel.org/tip/d298fea67fde4e5cdf3a563fdb31dd0af3d=
a73a7
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:18 +02:00

posix-timers: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helpers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-1-b962=
cd9d9385@linutronix.de

---
 kernel/time/posix-timers.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8b58217..2741f37 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,8 +299,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer =3D &timr->it.real.timer;
=20
-	timr->it_overrun +=3D hrtimer_forward(timer, timer->base->get_time(),
-					    timr->it_interval);
+	timr->it_overrun +=3D hrtimer_forward_now(timer, timr->it_interval);
 	hrtimer_restart(timer);
 }
=20
@@ -825,7 +824,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, kti=
me_t expires,
 	hrtimer_setup(&timr->it.real.timer, posix_timer_fn, timr->it_clock, mode);
=20
 	if (!absolute)
-		expires =3D ktime_add_safe(expires, timer->base->get_time());
+		expires =3D ktime_add_safe(expires, hrtimer_cb_get_time(timer));
 	hrtimer_set_expires(timer, expires);
=20
 	if (!sigev_none)

