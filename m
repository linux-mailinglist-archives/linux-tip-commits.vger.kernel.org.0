Return-Path: <linux-tip-commits+bounces-8165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ7jBECKf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991BC6AC6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02CB5302C928
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF67280309;
	Sun,  1 Feb 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ishYk3Bo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXRvyOuj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4827EC80;
	Sun,  1 Feb 2026 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966022; cv=none; b=jRnBjfl/g5pJinQMFELkpqR9uB5CDcMhCrfeev5bXMqP3CoJ1PssNuH6rS/q99J3YUJP7mpr4UIvdL029R+X3B6I+A/owDH+VAiUN8XHvX/HHuq4Ea9tL2a+c5/PoeimdWNnPNV6oiL69v1WldaF7uSKr4H3QT75EoSX8dZi7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966022; c=relaxed/simple;
	bh=MolcWaINKqdzdFoHulK3YQi1KVFoinaHQmZYFsL2xM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OfNBGm++Jrc933kuOgbN7Y6hQYrnra/vWzL3p0qQ2o1vtHM869Caup5HOimDCcTD6BSTz5EgPzfPsA57mlxo2D1Xc4Zo/VQsBMV6tFRsEU/uwjHvgYJsnHJmuOMhUzwZjIv3hJB1gNNIiJJYT8BAxXyJzEizcKKnF15ZdIEhL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ishYk3Bo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXRvyOuj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SQJgjW5qQKGWKoQKgk2jfgnqEhrbGB3wjhECzh25kE=;
	b=ishYk3BoTnd+ui6iSIMQUUAjh2JYjEQYvCopVQO+M1rtyqCODAjGuHrDYfYPfsTF4Y91sr
	z81evxDBtAj2YYlQpfL05l+0szoMv0+zmH/gkuOF7JQj2AUfQxRfuHmFS76dvUAndhJw71
	YuY0dX6G4psQRK5Uu6WB1knSXgE9bpo6Uh7uVWR2Td92r5/9uUDc+lWRw6QgyteFarHLVN
	9Kc7QVtUDdblVNSwFhXRfNI8QlIxWXzTnAWiW+xfY8qEKbWCqlQ9HzsSQXpDpHPZ1pMe/R
	UfvDXJykH3w56WpUyJPoYHWmkAoHkM0HK1vFlfUGInQygwOEi9hcVSnV+soqzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SQJgjW5qQKGWKoQKgk2jfgnqEhrbGB3wjhECzh25kE=;
	b=QXRvyOuje/mdMk3ZjwtFb4pDR108my28MVI5YACY6Eww2YsOkXkgxvBfAYofG6FqOAjEwc
	cl/LTVDIigUvnPCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iio: Use IRQF_NO_THREAD
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-17-bigeasy@linutronix.de>
References: <20260128095540.863589-17-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601825.2495410.13199624263948391923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8165-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6991BC6AC6
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     ff8fd3753999718f1305b16c438f50f10cbd375a
Gitweb:        https://git.kernel.org/tip/ff8fd3753999718f1305b16c438f50f10cb=
d375a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:36 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:17 +01:00

iio: Use IRQF_NO_THREAD

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke other
interrupt handlers and this os supposed to happen from within the hard
interrupt.

Use IRQF_NO_THREAD to forbid forced-threading.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20260128095540.863589-17-bigeasy@linutronix.de
---
 drivers/iio/accel/bma180.c        | 5 +++--
 drivers/iio/adc/ad7766.c          | 2 +-
 drivers/iio/gyro/itg3200_buffer.c | 8 +++-----
 drivers/iio/light/si1145.c        | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 8925f52..7bc6761 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -986,8 +986,9 @@ static int bma180_probe(struct i2c_client *client)
 		}
=20
 		ret =3D devm_request_irq(dev, client->irq,
-			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
-			"bma180_event", data->trig);
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       "bma180_event", data->trig);
 		if (ret) {
 			dev_err(dev, "unable to request IRQ\n");
 			goto err_trigger_free;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 4d57038..1e6bfe8 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -261,7 +261,7 @@ static int ad7766_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
 		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);
 		if (ret < 0)
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buf=
fer.c
index a624400..cf97adf 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -118,11 +118,9 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
=20
-	ret =3D request_irq(st->i2c->irq,
-			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
-			  "itg3200_data_rdy",
-			  st->trig);
+	ret =3D request_irq(st->i2c->irq, &iio_trigger_generic_data_rdy_poll,
+			  IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			  "itg3200_data_rdy", st->trig);
 	if (ret)
 		goto error_free_trig;
=20
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index f8eb251..ef0abc4 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1248,7 +1248,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_d=
ev)
=20
 	ret =3D devm_request_irq(&client->dev, client->irq,
 			  iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
 	if (ret < 0) {

