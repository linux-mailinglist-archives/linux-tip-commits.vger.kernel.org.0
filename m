Return-Path: <linux-tip-commits+bounces-6193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35803B11C5E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418D218995B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E22DE71E;
	Fri, 25 Jul 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0N3vAIn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CufrQc3W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5054223716;
	Fri, 25 Jul 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439503; cv=none; b=tzvAW5E5P/zVBULBj71NqJcnelnprsfQpWQ8Kvg2O/yQj3sv++Zuxn0fyrhyRiaIWFo4IiV9RkUxsVtrB8+IOXMa517GRzlWiTZS6dZ7Ou8LorF7yVQwnFbGRQt3czX/k1ig84XIVaPvhHDgRoSdOIzzxPRUwe18B7xmcP2AX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439503; c=relaxed/simple;
	bh=eV1sM2co6RR2648T11zZaUEFARSS4aVf/k51nneFC3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ck5AF5MsSmALyuixCxTA1N74mXtCkD4CkyeGSeylbVR31IeDJ3TN1B8qgzc8qCQg2Jsu+pM974YgqPraN1vyRf5oi31DLE7qKLWxu6GeZbuFPKiafBFatA/Guj3ylqvnz7EwtdD6d6sZPm/g1OQSdJIRM9s9XmJYuQlFoj1MUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0N3vAIn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CufrQc3W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PCWBWmIYSyIMCk4LTPW+l8Maq/V5lfCkvt4iquwa6g=;
	b=n0N3vAInhzdgAfGDZb0E3HoEuT8idreS4VrC3sgt6fMCNZRPEy7e1JvgfWBx8UQzEHwNVA
	B7aReBfd8zGnp+YHbZp+X5J/wsYoJn0kdnjV6qTRiq8MskkTitrl8/n/qHGb2bQYcuJHC+
	oT31VTQHLKLHm2RmfH4NjG2Tn+lfbYyfqF8Zb8cte7otXXkMJyiW2QXhaak5xHA3fymMn4
	Tar1Odp+hDLK8eA/UrqXa9173+SNH6GYFL8MLg4WXn8dDu1xvaPsO7airgY+3Nyy8B0ufA
	s/TO235v31sMk343gziLNnLXr6bBku9yzenrsXs1YLPGnfke+CpQwzoX80N/vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PCWBWmIYSyIMCk4LTPW+l8Maq/V5lfCkvt4iquwa6g=;
	b=CufrQc3WsMmMhc9SZ0NlfZh2T8g3ehCscNDR+zLhIoVr0nHUk8IW23zL+0uLcYVcXXp3VX
	tu+0+vJ0ctETlrBw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Fix section
 mismatch from the module conversion
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250715121834.2059191-1-daniel.lezcano@linaro.org>
References: <20250715121834.2059191-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949083.1420.5203804303471909880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     85198c87e4842f1239b4ad93586cf629583f480d
Gitweb:        https://git.kernel.org/tip/85198c87e4842f1239b4ad93586cf629583=
f480d
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Jul 2025 14:18:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:07:30 +02:00

clocksource/drivers/exynos_mct: Fix section mismatch from the module conversi=
on

The function register_current_timer_delay() when compiling on ARM32
fails with a section mismatch. That is resulting from the module
conversion where the function exynos4_clocksource_init() is called
from mct_init_dt(). This one had its __init annotation removed to for
the module loading.

Fix this by adding the __init_or_module annotation for the functions:

 - mct_init_dt()
 - mct_init_spi()
 - mct_init_dt()

Compiled on ARM32 + MODULES=3Dno, ARM64 + MODULES=3Dyes, ARM64 +
MODULES=3Dno

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250715121834.2059191-1-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/exynos_mct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 5075ebe..80d263e 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -657,7 +657,7 @@ out_irq:
 	return err;
 }
=20
-static int mct_init_dt(struct device_node *np, unsigned int int_type)
+static __init_or_module int mct_init_dt(struct device_node *np, unsigned int=
 int_type)
 {
 	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] =3D {0};
@@ -705,12 +705,12 @@ static int mct_init_dt(struct device_node *np, unsigned=
 int int_type)
 	return exynos4_clockevent_init();
 }
=20
-static int mct_init_spi(struct device_node *np)
+static __init_or_module int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
=20
-static int mct_init_ppi(struct device_node *np)
+static __init_or_module int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }

