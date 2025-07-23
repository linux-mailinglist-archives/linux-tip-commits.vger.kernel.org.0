Return-Path: <linux-tip-commits+bounces-6182-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7179B0EBC1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1450AAA096A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613E277CB1;
	Wed, 23 Jul 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWeI59rX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbKXdJaF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7E277803;
	Wed, 23 Jul 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255063; cv=none; b=UP77TmthvbZzknob8zQ0MPGtcrZmAe1mv/sx0tUSrglcJalr4+1J5IlSx0SdZ3da+hSWHN9fZEgUXDFbWBwuLdjFQyE5luIhrAhg6Rj2uoXlFqYWm/LXlU2jGpbVJOeG/KDheqb6G/wu4W4T0kxrQ/Tk+HQs0vVFUx9QaJUFOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255063; c=relaxed/simple;
	bh=3QvkingP9aQ5AYToVQs8tat1huD1lvJzvHns38K4Z+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oGqgttk1/pKyrWt37HV2E0RDeIoH/1q+ati89/5LI1hvjQ5lZir2dS8dmOwFG2g610W7F3Oup3Oje4QA7jmIET6Oi3OPl7K6a7bMF3dUt2/i+AVgicFM9y+iwDfnYxUCzeCQqoCjcQu36Rlcp0npXggxElejTX66a8j7UlS66/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWeI59rX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbKXdJaF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXyMIxmv9bZPMJKn8WEp25Hg7llqqFJ7O+nYny+kncE=;
	b=JWeI59rX9gNkJHxAz5sNKg94kgNjNnbzm8EtVFqgttdYG3x7qGsCyvp6n6IWs9Boiec7dR
	JVZZ0lJ3oEVUXggae0VCXy4kul2n/yIFkCxKxhE7r275ApL+t5MRGVRih+AyE+vCyiSpxr
	/Fg3u5yStnCKJUYJYwKZa9CSKwSAxN5Cf/TQTaZV0mEUdBLipCRzV3VCZ1hzUHzAVxUH5t
	+FTsKbpc2ZaYeHu4mf/Yo/09nB169eT744kKoHELV/QPTncgzRrVky6rwnR3uZWuK7G9U4
	eoV2AEJLneev05aYPD7TlBS25jbDnnLdQIOXrW07b1Y82N+H9DRoc3YV7WK1iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXyMIxmv9bZPMJKn8WEp25Hg7llqqFJ7O+nYny+kncE=;
	b=fbKXdJaFnWE2Ik4gShBNHBKqGPaowSqXae85pc0Xnar/WHlX6GV9qnPUW5GWU38gMnPhHf
	d7oFdWmwW72ALiCQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm: Add module owner
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-6-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-6-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505875.1420.15190236920943221427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     dba0cbb3373cb8cd4c58fe4a1a1e79c8c40df773
Gitweb:        https://git.kernel.org/tip/dba0cbb3373cb8cd4c58fe4a1a1e79c8c40=
df773
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:49 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

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

Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-6-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

