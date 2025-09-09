Return-Path: <linux-tip-commits+bounces-6506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36765B4A628
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A79540CCD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A22773D3;
	Tue,  9 Sep 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVDPgr2g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLDjOZKn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE018275AE6;
	Tue,  9 Sep 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408207; cv=none; b=fRwORtFLR+ru2hqun+wHwizaFX2F4sRvmfPikXAem2uCJfkvFKG3uA+wQXVjSusB41q0FV1l1lNVGwJ97GtaPumrHYcaKIzexJUm7HbB9CQiGEdjo+iGoD+vLhihfz1bcE6BrUO8qoJrO1EYK9OhXiUOxtGf3+N4Er0QCtWWWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408207; c=relaxed/simple;
	bh=ZRQvHJ4qBghxeI1g1m4fTJPA6/hkUpITaaYeiAVMjLc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tZVhErHL1Myz5UpdWcm5s0xZEHdrr3RVghQgg0BOlWMA4ZbxZX+JjTMugVUdEaO2n133Xb2sP2lFwKkFVuaGEMsBDk8Llg2cqRyciMYfERWD7V6ewKhhL7Dv1KSyrlM/GtmqvQIVv/mj1ztxBatmbJMbCMzkZSGDfuKlEkBVRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVDPgr2g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLDjOZKn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt53XhQIDV+neqGZg3O4ETcNGXQolJ70FK48uTWb/w=;
	b=hVDPgr2gIMYLgjL5sqLGiVgL41kpWVuJsOVblyrV8kc5zV1tvQJgQhHCRLQ3f5LC5EPB3h
	9VmUUlXHowQnaM8WWA2YyfqNVsRmusBM6vFLcJtzEr9UBw+vX1KjqrZsHq6QWgXU765A4G
	AhDPiLzoxyubyp06B98vLERytkRiv2W02AhEXZzU0wzXkauDAqnPhTaECxPlvyc6YG14UP
	YSyRROYcX5hdhcVYDA654JPjmQBB4spMDyu7vWQkcNpbaNmmFopwbxazn6njNnXLjax+vH
	ukl80V5bFxDAg+mf0Y8GKbch7pWyeNbPgBBK2TshGOwWNrwHUjHtUdrkntraOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt53XhQIDV+neqGZg3O4ETcNGXQolJ70FK48uTWb/w=;
	b=yLDjOZKn3eDzMhFUOyquh6e4ZIRP1bWRw95So88gyX8E8L+9kr5wQ4ZUFNXsU8fzY0qO+l
	oV7vaSg+3vx4UdBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] media: pwm-ir-tx: Avoid direct access to hrtimer clockbase
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Sean Young <sean@mess.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-6-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-6-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820188.1920.3145976836403421541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     12bbd35144939dbe9324b55fb1f50a0be2f0d6de
Gitweb:        https://git.kernel.org/tip/12bbd35144939dbe9324b55fb1f50a0be2f=
0d6de
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:19 +02:00

media: pwm-ir-tx: Avoid direct access to hrtimer clockbase

The field timer->base->get_time is a private implementation detail and
should not be accessed outside of the hrtimer core.

Switch to an equivalent higher-level helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sean Young <sean@mess.org>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-6-b962=
cd9d9385@linutronix.de

---
 drivers/media/rc/pwm-ir-tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 84533fd..047472d 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -117,7 +117,6 @@ static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned =
int *txbuf,
 static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
 {
 	struct pwm_ir *pwm_ir =3D container_of(timer, struct pwm_ir, timer);
-	ktime_t now;
=20
 	/*
 	 * If we happen to hit an odd latency spike, loop through the
@@ -139,9 +138,7 @@ static enum hrtimer_restart pwm_ir_timer(struct hrtimer *=
timer)
 		hrtimer_add_expires_ns(timer, ns);
=20
 		pwm_ir->txbuf_index++;
-
-		now =3D timer->base->get_time();
-	} while (hrtimer_get_expires_tv64(timer) < now);
+	} while (hrtimer_expires_remaining(timer) > 0);
=20
 	return HRTIMER_RESTART;
 }

