Return-Path: <linux-tip-commits+bounces-6730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09FBA18DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417E617CED5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAA323402;
	Thu, 25 Sep 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="myPw713b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zh3Yazga"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15049322778;
	Thu, 25 Sep 2025 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835980; cv=none; b=eilEDE/eGfW0NjqOPxFMzDaqczY+gK1Lt9MwfJ+EZIWC+lfgICbQ12LQ/OCsAm8jzJVfo04KkMuZMQ95zISKQH3mCFUk5UNeiJ1KujLmDvasBXgvAM/e+h0dkq06ydc9s1QEnJCIPhnSn4yS5+4qlfOegUKmV9cLyc2XSo0CgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835980; c=relaxed/simple;
	bh=OFbhqvfUqTDsum75N2JVSYl5uaI9H2M3NeipDV6reaA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QeHmY+apMnBC1HfjK3BI6VIs/xINiPdniLeXXspYxf1DpmiaN15F7C+eqgktMltsXhuIekcx/JObgv0e0zAnDav8mKqLl0vQdRleS4hYO+jn4MjDV65HKvmL5fJC731u3iegvLdZgTT2JAJIOry1EeajtQg7B1BKRXPlnx1zk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=myPw713b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zh3Yazga; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A5RdaahY3Z9IkDeuJpla13vbIINMrQyKJ9D0olwyf4k=;
	b=myPw713b73nNSRrJtWIyQw1aJTwSA0G+OupNzku2S7hiibccvrFxIhkC7ojFmHwwN+AzcN
	TjLWj/gESkPDrU5nmI9ZkTvsc7SEeSC77INQbIzXwPKyZckCtrW3b+1m0myG3j+oAzPbIj
	LWPs7IIjxGMkZcrcwb2Ec+rljQqkPGZvjeiigdNhtN7/aGGjHYYH+O+2HhW0md2BPhOQb/
	vn8G6xAb0mGGaAD92LBNzXvrbUoEEKVAWbI89s7FylVAB+/gstSmm3N0MfLO1fjvmeEI1Y
	5XsSMT6qqgj1+S2VE/Pv/nSDs9PtrEOPgy74RrBWpEttNDVyn7C+nlXuSLlfxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A5RdaahY3Z9IkDeuJpla13vbIINMrQyKJ9D0olwyf4k=;
	b=Zh3YazgaUmR57Q+lqa8okyn13Mr/v6f4Lt6trhRG0U4f/l2A0m7pT1sSw8/K89bC1jLpe+
	YXWA+2bC+lp0iRBA==
From: "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Don't
 print superfluous errors
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597271.709179.4528129218102547795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     764d0654114b5ce52aafabdb2bf9ccee0e998651
Gitweb:        https://git.kernel.org/tip/764d0654114b5ce52aafabdb2bf9ccee0e9=
98651
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Wed, 13 Aug 2025 21:06:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:41:39 +02:00

clocksource/drivers/timer-tegra186: Don't print superfluous errors

The watchdog core will handle error messages already.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Link: https://lore.kernel.org/r/20250813190657.3628-2-wsa+renesas@sang-engine=
ering.com
---
 drivers/clocksource/timer-tegra186.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 1ec7b38..3555588 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -333,16 +333,12 @@ static struct tegra186_wdt *tegra186_wdt_create(struct =
tegra186_timer *tegra,
 	wdt->base.parent =3D tegra->dev;
=20
 	err =3D watchdog_init_timeout(&wdt->base, 5, tegra->dev);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
=20
 	err =3D devm_watchdog_register_device(tegra->dev, &wdt->base);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
=20
 	return wdt;
 }

