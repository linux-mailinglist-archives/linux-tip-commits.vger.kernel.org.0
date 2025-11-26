Return-Path: <linux-tip-commits+bounces-7548-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5FC8A658
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4A17357893
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065B308F11;
	Wed, 26 Nov 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rufflg1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+EzFOUh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BFA306B1B;
	Wed, 26 Nov 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168049; cv=none; b=fE6EXa73I4vWlZJ6vUr8Ru+cTxlvsl27iuWr4bbtrOZvjgHtC7/aErfzUDchSyNQok3SfQSqS7bjvHpwbc0qZ4k7uZ79PKL/KyY5Rb99JW2/NL8CxyZgs60CmU0mSL2fix6rGDpdAJyLpdC7X+C9zEXeF0ISwea3T1lmmiiHfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168049; c=relaxed/simple;
	bh=pcP0ils3bVKkI3x3WLlSQt64YIeX5KCmOXatwXZgtpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FNzet+JBcLqojkP0cGyFEvTjMTBIxjew7Jiu110vXXVlFiTnd+ho7sOGlWX4RWkD8AnKTdLls/F+KqUzesVvreWpQvnUlQFJozZWMdFUK0q3urOsc3yrApwXNoin7UC0cGnz86w0vXLK397nAut4ociqab1xfEO2iCVJ9DC2RD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rufflg1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+EzFOUh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168045;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO/yYh3itOSEL8xiHi9+3GvOwtG6sW87ySAf+U2Od1g=;
	b=Rufflg1CTTveO45FMCPiOwg7n5KCysFE6fwUrawe4gi48RvcL6WA3NyVkpAqi5lvT8ATjw
	P8/GXTMoxtJlhoEkz32YFnmS7sGekRwkDER3KWEok0u3+ePlil5Y8z5F7Tbw53+hCEadFd
	jh+7XZrzuObep/aI1uIjAR529VGcT962g4jKDsyGE4S1Rw1E0soe6JQDRtcdN+I/N3dyV6
	MFn7EUMGtCnU21h95aZSIkpQM+nF8NSWsKRCVpU79rs0OR0uSwkhTKRjyE7RFNnhYjjuWI
	Tnj6vn/aEvzAOj4bo3serAZPAAylXJxhZj8Gojp7N1XaIKv5rRB0lII7Ir3qHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168045;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yO/yYh3itOSEL8xiHi9+3GvOwtG6sW87ySAf+U2Od1g=;
	b=O+EzFOUhZHmDC7fRwBwAKY/HFpzcl7Bdj82nYXNWpuap3TR7JLQArb3SuER9f4iV+PokTW
	P3MVz9a74ivUKiCQ==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm: Fix double
 deregistration on probe failure
Cc: Johan Hovold <johan@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251017055039.7307-1-johan@kernel.org>
References: <20251017055039.7307-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804447.498.12699066995574579652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     6b38a8b31e2c5c2c3fd5f9848850788c190f216d
Gitweb:        https://git.kernel.org/tip/6b38a8b31e2c5c2c3fd5f9848850788c190=
f216d
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Fri, 17 Oct 2025 07:50:39 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:37 +01:00

clocksource/drivers/stm: Fix double deregistration on probe failure

The purpose of the devm_add_action_or_reset() helper is to call the
action function in case adding an action ever fails so drop the clock
source deregistration from the error path to avoid deregistering twice.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Mod=
ule for the s32gx platforms")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251017055039.7307-1-johan@kernel.org
---
 drivers/clocksource/timer-nxp-stm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index bbc4062..16d5216 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -208,10 +208,8 @@ static int __init nxp_stm_clocksource_init(struct device=
 *dev, struct stm_timer=20
 		return ret;
=20
 	ret =3D devm_add_action_or_reset(dev, devm_clocksource_unregister, stm_time=
r);
-	if (ret) {
-		clocksource_unregister(&stm_timer->cs);
+	if (ret)
 		return ret;
-	}
=20
 	stm_sched_clock =3D stm_timer;
=20

