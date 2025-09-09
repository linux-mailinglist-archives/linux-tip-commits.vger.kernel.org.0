Return-Path: <linux-tip-commits+bounces-6507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE1B4A629
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9854138E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A12277C9E;
	Tue,  9 Sep 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZBmNhJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixoDY1kn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CF276045;
	Tue,  9 Sep 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408207; cv=none; b=eWhg98a/E/vpIHKhbSgvae/jvV6hwZs768LpbYlFBJkp4eaTiV3YNj0jBSXKhVI8g7LM26iRduEojj7iEUU+WkC5ECn7j6Pto7P+JJXJWVxKCk6Awcx2cq+bWxJjUBqYS48i1GY6HNfxBlNN6P+kzWVNlvi+g2EB3ARmgur2S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408207; c=relaxed/simple;
	bh=YGoIxWv9jM5SYMzkl+p4icmBjrg7EVDKQUJm5FRq55A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=epULQjvwuZKroreFQhyd5VcQWz2TtAGS3hzJQtr802z20ft/ZD6Nl8QYtqbNiQs44nkJonxtF1Zrjl527WjRWOI86KH0NA/xxDiz8il6t9DYQIw+cS9937/tTDX1UONFhIRkRwgrMfsgCqAxffxgw4QYYpvUUYiDCebjmMoNlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZBmNhJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixoDY1kn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20qaWzlfTqCflhfrEuud3SN0O6Pt2O2qXJn295X71Bs=;
	b=LZBmNhJ71z8WQGOQgt7nJhLtmR6BhnwK4oVHANiNfrAsKa51VEe/f5QwIBRxYQl+FPfiM8
	5uez0zwDcBVhsY+EajlZlyGEERdbCmYb1QslnToU7+ETDlaPBAygv7hwtAyecvJM6ylelx
	zTd+mb0NjKc2vhK8iOm6TQ/tPzRjedJUftWIN3oqtI+94pW31yIekACXbwHQVGHt9qsjyC
	vbO92ZnmDceafTvyJXxTnchqt8BYLge5OhyUTtytA1myZXGKjjkwB3K+4kP6gRJKfqQKQm
	IX7Nx6l2SpsqWoM8WZiqZw8ln/lyds3PmoAKFsnPZyWM+OJHoGw0EjsBL+Z2lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20qaWzlfTqCflhfrEuud3SN0O6Pt2O2qXJn295X71Bs=;
	b=ixoDY1kn7P7IeyLSzKKleshJQjH2/T4iRo4CR5BAi8ARJgWlZuEwM88AsjtFpl3OowiY2W
	MPxEPEwAOwBX4KDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] ALSA: hrtimer: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Takashi Iwai <tiwai@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-5-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-5-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820344.1920.4647803411235287301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e9209f4056e045cbeee6493ad070c10a86f16ece
Gitweb:        https://git.kernel.org/tip/e9209f4056e045cbeee6493ad070c10a86f=
16ece
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:19 +02:00

ALSA: hrtimer: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-5-b962=
cd9d9385@linutronix.de

---
 sound/core/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index c364bd1..2d5f4d4 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -44,7 +44,7 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrt=
imer *hrt)
 	}
=20
 	/* calculate the drift */
-	delta =3D ktime_sub(hrt->base->get_time(), hrtimer_get_expires(hrt));
+	delta =3D ktime_sub(hrtimer_cb_get_time(hrt), hrtimer_get_expires(hrt));
 	if (delta > 0)
 		ticks +=3D ktime_divns(delta, ticks * resolution);
=20

