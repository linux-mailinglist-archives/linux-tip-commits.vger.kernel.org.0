Return-Path: <linux-tip-commits+bounces-6153-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A53B0B130
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4B8189DDBE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D23289E2A;
	Sat, 19 Jul 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="woJFtZME";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FK1CcHVr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5A288517;
	Sat, 19 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946824; cv=none; b=ovTyWLnSj8V0rFSJf4HYfYtPdCYZD/gBacfr4OhgI4U7lsfOhFS4lEXTuWN2bH3N0IKLho7pj1QsarLKNKra/bcXAxIBzM6FQNZFAiLFN/wK67zw+TwGQJ8uBJb+mN7uKfa70qu7v05SrPvQaTh5MBMk2JhT1U85c1NmCZvRK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946824; c=relaxed/simple;
	bh=vLFz23aHRNuyLgsrxsAauI5jJnnZf0F+RNFDi1qjKfk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C0lfoIrYz7SrqvOhT64RyneRTosXJnO/pqx8DrpMjVeSJtBoQniTSQnTQjvqMB6JG9/17/2W2+42n5cs5AgeaLKmCRZk5gkZ6shYMIWcTCMepHmcdAZ0Im7jRaLl0qjPpYNthOtJatTL5/80qsH5XAKM0uWKvkrxf/KSNRU19eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=woJFtZME; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FK1CcHVr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946817;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0KDHmUVtwfxLypgOz1S5AVLzdTqKohAspwxIy6QdXk=;
	b=woJFtZMElI+pmDcAn6p+kN+zzvC3g6YhDQw8/571AlwBO6sMlj4I3UA5T07sPSF3o4FBR2
	M3A6BMOj3GUCXd2atEXmBeqEfe3veM/6xTq9dRg2sqHSuzIuQfj06xmYCGdRuK7Tc9gCPT
	jY66otdz7lKoer0gYavBSyqZbdIoMdCjRBiZR7y7SWd4+a0TfO+0XzLdawnXAP52CEGng0
	lYWRkZYnEWVQzvrDFE4YVRabuHXcXfch9EWgIujkhjLH0m2JWoCOvRMCE12qbJYPgxPMTY
	4QYC1ssCrPidDdUyffWul2Mx7sPM5aFHHFjNJeeOWNfPyEBJERlUsglePq0u6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946817;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0KDHmUVtwfxLypgOz1S5AVLzdTqKohAspwxIy6QdXk=;
	b=FK1CcHVr0vqoKKR+ksq++0kxL339Wh9yMmfMuU25dr1h/ZRNY7ZR1vgE1x6lC2abP7VMRl
	zL3Vw9g6aOF97cAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] leds: lp8860: Check return value of devm_mutex_init()
Cc: linux@weissschuh.net, Andrew Davis <afd@ti.com>,
 Lee Jones <lee@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
References:
 <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681634.1420.9588614577047608008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b07bb900af7f43f13f9ff398b4c6ca1dee217cd
Gitweb:        https://git.kernel.org/tip/3b07bb900af7f43f13f9ff398b4c6ca1dee=
217cd
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 17 Jun 2025 19:08:13 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 11 Jul 2025 15:11:19 -07:00

leds: lp8860: Check return value of devm_mutex_init()

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=3Dy the mutex will be
marked as unusable and trigger errors on usage.

Add the missed check.

Fixes: 87a59548af95 ("leds: lp8860: Use new mutex guards to cleanup function =
exits")
Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Acked-by: Andrew Davis <afd@ti.com>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-2-d9e4=
49f4d224@weissschuh.net
---
 drivers/leds/leds-lp8860.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 52b97c9..0962c00 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -307,7 +307,9 @@ static int lp8860_probe(struct i2c_client *client)
 	led->client =3D client;
 	led->led_dev.brightness_set_blocking =3D lp8860_brightness_set;
=20
-	devm_mutex_init(&client->dev, &led->lock);
+	ret =3D devm_mutex_init(&client->dev, &led->lock);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to initialize lock\n");
=20
 	led->regmap =3D devm_regmap_init_i2c(client, &lp8860_regmap_config);
 	if (IS_ERR(led->regmap)) {

