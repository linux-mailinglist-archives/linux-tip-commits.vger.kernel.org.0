Return-Path: <linux-tip-commits+bounces-6532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7BB4AABB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6682E18998B8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812631C59F;
	Tue,  9 Sep 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etT3e8vL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wf4PDy3N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8231B82C;
	Tue,  9 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413867; cv=none; b=dH6+RE1t/4syQ9GTG4x0nH7p2XaZ0ArxHtV4H28n2we46VK1thOQKezFy8XVbK/8kUI9Shaj3iZpwXsfne/LrddMLz2UCRaFr5nX4oXTQo5Wi2vkEkS1nT18pMD/fRa5dckuRcUQNDZMBxETDLZH+D5Kod4kCDczc8+/a/O27k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413867; c=relaxed/simple;
	bh=fVy+dergz7Gtis/4PsXKGRnkMQp/fPD8wiGHy+1Z+Mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cjpIF5WjzNFSPbvwtzyeIbxrbUDBvDVKMk5cE9fEkQ8C6AiQKde/GIzZUdN2ADj8K0RKOx/Fx0MPrB8uGaO8IgqXounBuVlvpKE9ALPePTmHDFZcVZuGh+hvZ4B93TZ/rV9EQoqM0Ru9NV62VXbJadWyFOv8xTFfQ6la91zYYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etT3e8vL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wf4PDy3N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4CbOYSewiwnCeTL/hWfu0iQNrQXXdQh+nhAJwZmiD4=;
	b=etT3e8vLQxW3hwwAHODSSILk7hT+OBKE7sED2FbR41dC7xksBD/9uM7rxYUY9UrPZeUeKb
	3jn3IF3w9tblRs/ebLOHCjQntbd4Oxe/b5AJlArRCKzcm56dZ8nsxH5c3oQ+w9EtYtP/43
	Q6xIlX8pqVVU9nqkie1pMIRm7Uo/R++u73O54AhWX1cO5elavWKKSPjAkFHwbOCzjE1vF3
	VtnKmvPvjGxPuaDfR/Xs/C4bybep92hsTg3H3Pqx1H3j9SKI9PDoUpJ4wrFvCP41mGJzlg
	G0hf5EvtofAMwwsPRuccfF7AuBnq3NQdhV8gWC0dXraxAntkhTifA0PitmHMJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4CbOYSewiwnCeTL/hWfu0iQNrQXXdQh+nhAJwZmiD4=;
	b=wf4PDy3NQN2lf6qnDlA8J1ERwoDV+xUmj5F3RHriM6iQRasQYQI1vrpq91DQELiC0wHPvg
	nTEZykBiVz8CQ+BQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] ALSA: hrtimer: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Takashi Iwai <tiwai@suse.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-5-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-5-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386323.1920.4484306212992369093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     645e0644300b0dac3cf31527e93e51172455749a
Gitweb:        https://git.kernel.org/tip/645e0644300b0dac3cf31527e93e5117245=
5749a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

ALSA: hrtimer: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to the equivalent helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-5-3ae8=
22e5bfbd@linutronix.de

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

