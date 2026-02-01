Return-Path: <linux-tip-commits+bounces-8164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF45HTeKf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:35 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB32C6ABE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6233029E5D
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257127F759;
	Sun,  1 Feb 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLzSxQ8s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYL48h27"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD1280324;
	Sun,  1 Feb 2026 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966022; cv=none; b=X7O/zZ9OINwj42VQ0vE5STbMqisIuwBrvd+Tb0Nh0q0tJEIuAkpiENoKIqDn0uZheKe2ZkTPEFDnIdmZmjfWrcqiShyd5/ro4EWiJ/UDgr2NTVNuXIRcHc+S1yCatZxAdwD7MW01AvlE/PE9h359IVym2jXm6LwDcpohjOxOYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966022; c=relaxed/simple;
	bh=mx5F4JfCrV0tGex99DGoSee/Floq5jXii2Mzx6tKZ7g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IsMcUL6IRfsrgEFMITu4q2d/w0WZ0/90UjYxLRI0e2uH6g0QuyNTkGEXsRTCYUeMkv+xpcFl/DpG5afa45GY+wHAjqd+KWVH9zf8vh+MRMRlMrdiePtzvZen89rrWawkIhCFo4fKFEMpz5HbQfMuGi9hwN3Xaryo6I42h1Dq09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLzSxQ8s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYL48h27; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kSadKGRkQ5uaAmKU/TEZbSZ07+V8PsFBfWpy5FSHzo=;
	b=eLzSxQ8sl0kuwnZNjeNBOLMgvaSPKiTUawzYZUq3ybHkP1kZINYKngem2hjqS4S/8mCWsF
	MAsUuJUtCZs9mLDLofKK69on8sbSfEdPD6RXjbi0ak3vGiot529Ioti+HZ7JC1uqbLI/i4
	Ww9haqR3tRQ1VM7v3EJIt2iJIAHcXdyHIXX/N6dNvsFYvkQb4fIL73IdbexxLr+WT8XbqD
	ajcwN6TBIzxKuYO9Q2YWWg7eco5olIYAlt9N8MeIvD6MybxDDivbKDHearVvNQs0VnwSMN
	QEf2rUg3G5hlKK8NHDDScONBmMMcLQzqylayxsVI6eG3E8xzJFSLpECUew2HwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kSadKGRkQ5uaAmKU/TEZbSZ07+V8PsFBfWpy5FSHzo=;
	b=IYL48h27eYjDB7uXc7yb8nYw9mbcY+Mx/ZXIKapvEH54FmebXvboYdGMm1qFSDP4SL1dYK
	uFqMDYPTNk55lnBA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-18-bigeasy@linutronix.de>
References: <20260128095540.863589-18-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601710.2495410.5764668844468817473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8164-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,intel.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,intel.com:email,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: CAB32C6ABE
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     c04731b5f1502e619dec24a8005fbbcbb8cd0e50
Gitweb:        https://git.kernel.org/tip/c04731b5f1502e619dec24a8005fbbcbb8c=
d0e50
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:37 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:17 +01:00

iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably not allowing forced-threading for
handlers such as iio_trigger_generic_data_rdy_poll().

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Link: https://patch.msgid.link/20260128095540.863589-18-bigeasy@linutronix.de
---
 drivers/iio/accel/adxl355_core.c       |  5 ++---
 drivers/iio/accel/adxl372.c            |  9 ++++-----
 drivers/iio/accel/mxc4005.c            | 11 ++++-------
 drivers/iio/accel/stk8ba50.c           | 11 ++++-------
 drivers/iio/adc/ad4170-4.c             |  2 +-
 drivers/iio/adc/ad7768-1.c             |  5 ++---
 drivers/iio/adc/ad7779.c               |  2 +-
 drivers/iio/adc/mcp3911.c              |  2 +-
 drivers/iio/adc/ti-ads131e08.c         |  2 +-
 drivers/iio/chemical/ens160_core.c     |  9 +++------
 drivers/iio/gyro/adxrs290.c            |  2 +-
 drivers/iio/health/afe4403.c           |  9 ++++-----
 drivers/iio/health/afe4404.c           |  9 ++++-----
 drivers/iio/magnetometer/bmc150_magn.c |  9 +++------
 drivers/iio/pressure/dlhl60d.c         |  7 +++----
 drivers/iio/temperature/tmp006.c       | 10 ++++------
 16 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_cor=
e.c
index 5fc7f81..1c1d64d 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -768,9 +768,8 @@ static int adxl355_probe_trigger(struct iio_dev *indio_de=
v, int irq)
 	data->dready_trig->ops =3D &adxl355_trigger_ops;
 	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
=20
-	ret =3D devm_request_irq(data->dev, irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
+	ret =3D devm_request_irq(data->dev, irq, &iio_trigger_generic_data_rdy_poll,
+			       IRQF_NO_THREAD, "adxl355_irq", data->dready_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
 				     irq);
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 46d518a..2f6aa52 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1247,11 +1247,10 @@ int adxl372_probe(struct device *dev, struct regmap *=
regmap,
=20
 		indio_dev->trig =3D iio_trigger_get(st->dready_trig);
=20
-		ret =3D devm_request_threaded_irq(dev, st->irq,
-					iio_trigger_generic_data_rdy_poll,
-					NULL,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					indio_dev->name, st->dready_trig);
+		ret =3D devm_request_irq(dev, st->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       indio_dev->name, st->dready_trig);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index ac973d8..a2c3cf1 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -486,13 +486,10 @@ static int mxc4005_probe(struct i2c_client *client)
 		if (!data->dready_trig)
 			return -ENOMEM;
=20
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						"mxc4005_event",
-						data->dready_trig);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
+				       "mxc4005_event", data->dready_trig);
 		if (ret) {
 			dev_err(&client->dev,
 				"failed to init threaded irq\n");
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 384f1fb..a9ff2a2 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -428,13 +428,10 @@ static int stk8ba50_probe(struct i2c_client *client)
 	}
=20
 	if (client->irq > 0) {
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						stk8ba50_data_rdy_trig_poll,
-						NULL,
-						IRQF_TRIGGER_RISING |
-						IRQF_ONESHOT,
-						"stk8ba50_event",
-						indio_dev);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       stk8ba50_data_rdy_trig_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       "stk8ba50_event", indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index efaed92..82205bf 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -2973,7 +2973,7 @@ static int ad4170_probe(struct spi_device *spi)
=20
 	if (spi->irq) {
 		ret =3D devm_request_irq(dev, spi->irq, &ad4170_irq_handler,
-				       IRQF_ONESHOT, indio_dev->name, indio_dev);
+				       IRQF_NO_THREAD, indio_dev->name, indio_dev);
 		if (ret)
 			return ret;
=20
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index d96802b..84ce23c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1394,9 +1394,8 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	ret =3D devm_request_irq(&spi->dev, spi->irq,
-			       &ad7768_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+	ret =3D devm_request_irq(&spi->dev, spi->irq, &ad7768_interrupt,
+			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 			       indio_dev->name, indio_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index aac5049..695cc79 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -840,7 +840,7 @@ static int ad7779_setup_without_backend(struct ad7779_sta=
te *st, struct iio_dev=20
 	iio_trigger_set_drvdata(st->trig, st);
=20
 	ret =3D devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_po=
ll,
-			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
+			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
 			       st->trig);
 	if (ret)
 		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index a6f2179..ddc3721 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -815,7 +815,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
 		ret =3D devm_request_irq(dev, spi->irq, &iio_trigger_generic_data_rdy_poll,
-				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c9a2002..a585621 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -827,7 +827,7 @@ static int ads131e08_probe(struct spi_device *spi)
 	if (spi->irq) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq,
 			ads131e08_interrupt,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			spi->dev.driver->name, indio_dev);
 		if (ret)
 			return dev_err_probe(&spi->dev, ret,
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160=
_core.c
index 86bde4a..bbc96c4 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -316,12 +316,9 @@ static int ens160_setup_trigger(struct iio_dev *indio_de=
v, int irq)
=20
 	indio_dev->trig =3D iio_trigger_get(trig);
=20
-	ret =3D devm_request_threaded_irq(dev, irq,
-					iio_trigger_generic_data_rdy_poll,
-					NULL,
-					IRQF_ONESHOT,
-					indio_dev->name,
-					indio_dev->trig);
+	ret =3D devm_request_irq(dev, irq, iio_trigger_generic_data_rdy_poll,
+			       IRQF_NO_THREAD, indio_dev->name,
+			       indio_dev->trig);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
=20
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 8fcb41f..3efe385 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -597,7 +597,7 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_d=
ev)
=20
 	ret =3D devm_request_irq(&st->spi->dev, st->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT, "adxrs290_irq", st->dready_trig);
+			       IRQF_NO_THREAD, "adxrs290_irq", st->dready_trig);
 	if (ret < 0)
 		return dev_err_probe(&st->spi->dev, ret,
 				     "request irq %d failed\n", st->spi->irq);
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 0e5a512..d358f4d 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -540,11 +540,10 @@ static int afe4403_probe(struct spi_device *spi)
 			return ret;
 		}
=20
-		ret =3D devm_request_threaded_irq(dev, afe->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL, IRQF_ONESHOT,
-						AFE4403_DRIVER_NAME,
-						afe->trig);
+		ret =3D devm_request_irq(dev, afe->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, AFE4403_DRIVER_NAME,
+				       afe->trig);
 		if (ret) {
 			dev_err(dev, "Unable to request IRQ\n");
 			return ret;
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 768d794..032da52 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -547,11 +547,10 @@ static int afe4404_probe(struct i2c_client *client)
 			return ret;
 		}
=20
-		ret =3D devm_request_threaded_irq(dev, afe->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL, IRQF_ONESHOT,
-						AFE4404_DRIVER_NAME,
-						afe->trig);
+		ret =3D devm_request_irq(dev, afe->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, AFE4404_DRIVER_NAME,
+				       afe->trig);
 		if (ret) {
 			dev_err(dev, "Unable to request IRQ\n");
 			return ret;
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetomete=
r/bmc150_magn.c
index 6a73f6e..a022e18 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -906,12 +906,9 @@ int bmc150_magn_probe(struct device *dev, struct regmap =
*regmap,
 			goto err_poweroff;
 		}
=20
-		ret =3D request_threaded_irq(irq,
-					   iio_trigger_generic_data_rdy_poll,
-					   NULL,
-					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					   "bmc150_magn_event",
-					   data->dready_trig);
+		ret =3D request_irq(irq, iio_trigger_generic_data_rdy_poll,
+				  IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				  "bmc150_magn_event", data->dready_trig);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", irq);
 			goto err_trigger_unregister;
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 8bad716..46feb27 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -306,10 +306,9 @@ static int dlh_probe(struct i2c_client *client)
 	indio_dev->num_channels =3D ARRAY_SIZE(dlh_channels);
=20
 	if (client->irq > 0) {
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-			dlh_interrupt, NULL,
-			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-			st->info->name, indio_dev);
+		ret =3D devm_request_irq(&client->dev, client->irq, dlh_interrupt,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       st->info->name, indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to allocate threaded irq");
 			return ret;
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp00=
6.c
index 10bd3f2..d8d8c89 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -356,12 +356,10 @@ static int tmp006_probe(struct i2c_client *client)
=20
 		indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
=20
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
-						IRQF_ONESHOT,
-						"tmp006_irq",
-						data->drdy_trig);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, "tmp006_irq",
+				       data->drdy_trig);
 		if (ret < 0)
 			return ret;
 	}

