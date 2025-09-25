Return-Path: <linux-tip-commits+bounces-6770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D1BA1A0F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6387B964E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A832F769;
	Thu, 25 Sep 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGvh3Mk5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8fTBpKv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC232F774;
	Thu, 25 Sep 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836039; cv=none; b=gzE2wIUAe08sttvV8VLgvqKeKkTxcWFXbLfkf1BFHsiI364MPwvOfiLh0JDoYQQH8mjksbAGbOwvWcW5KZilr36GyJ4AH6Zh93gzhIc08Jb1re0cf/5l1Go9nu8sWhkI0SSP51C/uib4vrSCQSZXX6t9ymmmoQL+NS5O+PCtKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836039; c=relaxed/simple;
	bh=yJv6OtIkrr2hjnkd3zhP20PAnoDWWjWqKP7QN+MFxBE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TGFSd0EbeorDDUjUnzXxKDhWcHveBO1VE0Hk7kKkMYJ7tfQ/OoF/0SyrE8Wnv6vKcD18PmJF9fcSjXSIU9SJCtvl4zaDvvLKYP295PlEZy404yPdQf5YPPpu9kF5lSllYrE90PrDLSkOybM+knNne1fADjeuL6R6kQmfIuv5XU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OGvh3Mk5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8fTBpKv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9R642HzZC0yMKGKusEzskPP4VqQJ8KPG9BXWlEfqK98=;
	b=OGvh3Mk5XJyuDER+9EBtrdaZMcegAQ1fTMTWi233rOsVjiQ8DiREKuSoFkFEQeRMKU82sS
	U1eDpoJIAbRIRc30uR/3Ei5+MtR60xq9U9vTI4008Wh5DXH45PzF9AUaU3Xl49lvACqB52
	gWTUGzw16tYjm4Rb0BSINu1nbeCM1qoPKoSL8hoEVX0US+Pv7zcsSVca0jBjNPBczqpEqI
	lKY2lSZ4RqmjVBdUPtzpwp6yjIMQ2L14klj/+ZinsguIrhhYMo/ZhTvIbvUeAxzT1W2SvL
	pYasdK2ypolTGz/Xqwexjoo29EriOqZpcez8dR1DEbMeDj2Mj/tljhFKgoOo+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9R642HzZC0yMKGKusEzskPP4VqQJ8KPG9BXWlEfqK98=;
	b=F8fTBpKvBPKD3mBOeUu+4SuO451eg8z2D64s/8Cb/KGbTbCJCNtux79xepxGDugYlLf/mz
	iNMWLsUOPdbGRXBA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603499.709179.5195891997374995453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     edef59887b5c5a527ad4b287a51f8f9fc239d867
Gitweb:        https://git.kernel.org/tip/edef59887b5c5a527ad4b287a51f8f9fc23=
9d867
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:49 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:52:13 +02:00

clocksource/drivers/stm: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-6-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-nxp-stm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index d7ccf90..bbc4062 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -201,6 +201,7 @@ static int __init nxp_stm_clocksource_init(struct device =
*dev, struct stm_timer=20
 	stm_timer->cs.resume =3D nxp_stm_clocksource_resume;
 	stm_timer->cs.mask =3D CLOCKSOURCE_MASK(32);
 	stm_timer->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	stm_timer->cs.owner =3D THIS_MODULE;
=20
 	ret =3D clocksource_register_hz(&stm_timer->cs, stm_timer->rate);
 	if (ret)
@@ -314,6 +315,7 @@ static int __init nxp_stm_clockevent_per_cpu_init(struct =
device *dev, struct stm
 	stm_timer->ced.cpumask =3D cpumask_of(cpu);
 	stm_timer->ced.rating =3D 460;
 	stm_timer->ced.irq =3D irq;
+	stm_timer->ced.owner =3D THIS_MODULE;
=20
 	per_cpu(stm_timers, cpu) =3D stm_timer;
=20

