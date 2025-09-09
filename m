Return-Path: <linux-tip-commits+bounces-6536-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720AB4AAC4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5971724A5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C4321451;
	Tue,  9 Sep 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7et9lcV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRPwW8Zy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A023203A3;
	Tue,  9 Sep 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413871; cv=none; b=uUrYgbcdPS/39uV9xm2zAbC0x6xBO0J1QAznpYXEvpqjXRvha0uu2F7bzVzAEtaV33lHj4nKztu+rfcRjE4tg9JP3mBmdj6zOd/wzzRO0X5mNyb1yi+4wbpUPTxjpiTaBmaUr4nLY1eiMSmOsY58suktzQr5ut+uWe2JYIG+fuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413871; c=relaxed/simple;
	bh=Km9n1G41laaH0AUlLYpSw2V4ggqE3VEZ6Jsu32GErM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=utNSxvPKoQnEeDrcLhUjJbrWxeq1HGVVFl7vDOomECibw/SwXlNvwNmM6UQ+GrBPHIe/cWoPL+3cKVs8dJfHK/z2Rgp9ryovEZ7BUidNVS/QffRmiI96Rn5eu5Z7KXaJYkQf90ka8sPDlXRnp1FiQPJbO2r+p7PBIeuXvGCwRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7et9lcV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRPwW8Zy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DTbuiVIYYMfcCLdSLJPJByOIArOzRp5NxaXGOodjYY=;
	b=b7et9lcVWNSFTEoBF0montwNLxiuEPNrz4OKEFEetBU3Ap3PWLtVeRkqdUlik5JUeAmJCs
	yk7bxFIu3HxKf9oWL4izIatiPVJwP4a5yKCORUNxY35iba/GKjZPY27fvOJN1M/ZqU4Hpl
	24doEcgH40zCOrgXVUSemOjVqZOdRYi2bc0+e+UPBVcAybbY3DGMj0hnE/kFkTziwXQScX
	OlHFGgvCyzgPSE8WMOn1Gd8HaRXpFhuXSH81/TjvjDuYe7QUo79ACIdU11QlV3lOwzECVE
	BDZPrK6BgPONwniPiamNjIbpx/0MQxnDMz7rr13Y+eVGZVgQ1uo+0nPXu2mCgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DTbuiVIYYMfcCLdSLJPJByOIArOzRp5NxaXGOodjYY=;
	b=yRPwW8ZyD+inely52nHZqqDOdZSBx97MRqSY4NbsfEeAOmtH5fZxT3zNOB5M5ABpQVUFYC
	yyGbmnKbLrkCOxDQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-timers: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-1-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-1-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386763.1920.7524095939905626765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     24fb08dcc40f52cf5f95d2cdaa0c26e33a2f4285
Gitweb:        https://git.kernel.org/tip/24fb08dcc40f52cf5f95d2cdaa0c26e33a2=
f4285
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:17 +02:00

posix-timers: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helpers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-1-3ae8=
22e5bfbd@linutronix.de

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

