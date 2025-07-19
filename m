Return-Path: <linux-tip-commits+bounces-6150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD197B0B128
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6719A189D91A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55BC28936F;
	Sat, 19 Jul 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1ul8jEK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BoHw6puf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399A288504;
	Sat, 19 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946823; cv=none; b=azL71rIpyrZQNLOJNI9wx5jYYnWtFH0dx6AgjkSrbCZQ9xDSwhUHyQNXmC0XgiA9WIjVv8pZNHhCaclMF3lk5RYphNX/g8OwOwC8zt7Z+68m5URyrypgivNvruuYhBDXyWhvlMimcrpjVzVCalHduzoHJPYwfy/7Jhx9fsidTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946823; c=relaxed/simple;
	bh=vI+HQYdrg8KXz3/oqVlGv4UFnKQ/8mZ+gYcjLKWYqCo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=REtHNyau2z5qFGmgkQ/h56d7M495ymIQo2n4MEHkBIYLyVacQsdjKZP2js/YWK2w4VyOxvTu63QUUTMt0OdmLHVwaLVx46ms/mAPLLdOn3fLCucjvTaPAcrtsbLqV+gG4IGT3iCK3sJyHgw7aqiH/l/P8B6ifH6Qbs3/Ubal9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1ul8jEK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BoHw6puf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VQMkD110SKIQ9B58l47XHifA25JLOkJYqqQMPt0eC4=;
	b=l1ul8jEKuY8WX/32m1wJkHkFjSO/gd9m+wCz7OA7cZeoDYPmoeVzKLwNpYMDAFfPEUbc7x
	UKtWVUFPnZ4m4cdECFRMUxpDAqC66G4POFtGxfPi0fO5ZE/dQkT0+tSguDkE+AlEBh2da2
	mxRL/MBSr7K31rJARpMVH4QfEvFeja76Py/t6CvKT9zxsYX39QZUWVs/egWxBA4AIvHn2T
	PU6ukSI33TkjrFAGhbRACQOw7byfbWuJW5WGSC7kuM4c8gYYewui+snUmvxQn30zre0o32
	Ybj2bBgy203ScfoD5UfsAsrjTrTgtpS2SWRYcOllJFKZdOY+ezd3nGQAX2JbWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VQMkD110SKIQ9B58l47XHifA25JLOkJYqqQMPt0eC4=;
	b=BoHw6puf1IpinO/JmBsou9gznxKfGDDtMGUyv37TQwl3Obyj6fZDm44VKbvfTqM9zvlTB5
	i36ChtdNsWeFEgCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] spi: spi-nxp-fspi: Check return value of
 devm_mutex_init()
Cc: linux@weissschuh.net, Mark Brown <broonie@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250617-must_check-devm_mutex_init-v7-1-d9e449f4d224@weissschuh.net>
References:
 <20250617-must_check-devm_mutex_init-v7-1-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681741.1420.3193151064662689491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d24a54e032021cf381af3c3cf119cc5cf6b3c1be
Gitweb:        https://git.kernel.org/tip/d24a54e032021cf381af3c3cf119cc5cf6b=
3c1be
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 17 Jun 2025 19:08:12 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 11 Jul 2025 15:02:07 -07:00

spi: spi-nxp-fspi: Check return value of devm_mutex_init()

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=3Dy the mutex will
be marked as unusable and trigger errors on usage.

Add the missed check.

Fixes: 48900813abd2 ("spi: spi-nxp-fspi: remove the goto in probe")
Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-1-d9e4=
49f4d224@weissschuh.net
---
 drivers/spi/spi-nxp-fspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e63c77e..f3d5765 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1273,7 +1273,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
=20
-	devm_mutex_init(dev, &f->lock);
+	ret =3D devm_mutex_init(dev, &f->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
=20
 	ctlr->bus_num =3D -1;
 	ctlr->num_chipselect =3D NXP_FSPI_MAX_CHIPSELECT;

