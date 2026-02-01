Return-Path: <linux-tip-commits+bounces-8162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGiEB8WJf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:41 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77CC6A48
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A195A30010DF
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD742773FC;
	Sun,  1 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plQAXf1x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EJica55g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB623957D;
	Sun,  1 Feb 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966018; cv=none; b=lPE528nEwCTXIi5dQ73puNoSye68A9/3p9vTvhF9Cc4IoOuFD4q9lXut3lL02t5+f+bf0dnaox1N4PNFzepy2dlEbWa5EOt6koJUSTKYoXvlHgpR3UkiRmGIbSw27jO2IWk0FI9rZU97zfvM9UN4BGg162FaT4rgJvFb5cT2cjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966018; c=relaxed/simple;
	bh=9FH1wreKnnbSjTapY7T3OZqtW9vCc7gc6bA0tLGJaFE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dnZeopkM+zasWdm1WxlcO8KehTRNUUjJ2wtqLLPLZBs6Bfa71W2pV/DRTj+Rgp7p4ZHXwrVAPtYP5873nqMQwnjQZyMwGygrPFUo26lLOguP+1nENHVQxrdVV1zJ7hNPWzYo/XsPltJ2aVeXvyKmIUDTDpZEgX+oJLFyRCdys7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plQAXf1x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EJica55g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV5E4gKbsekdT8Ln/jCw0BKIbljbcXojnxASqAubSk4=;
	b=plQAXf1xyqDN2+H6RF9+yV/JEcvEmBoZTpRBNjjnp0DWwP7r49iaLnKvHERWn9Z84MnDBt
	C14dYJTH8KYDJMxL9wROT+ar9EYRQBGAJCL8tKD5PS27cNU3UfDJoFURsE2RF/VaZh3maH
	D9Mu1Ziqdzs8z5Srff/A31sUHTnvMVo/cKUoIthu+9a3E2dhwmI/9Rsvf67j1xszfKJOli
	91/YJA++sKSl4Qw/l2bU/zpFnTwwPXEZ31PIzl2QB2sll52ekBWKi41+FdM05Tvx9SJRtg
	ZH7QOAwSj/LKru29G6bDUhk5vgtyPrMxiHxd+/OOanvk/bIg+2Pi6s4FhVTIgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV5E4gKbsekdT8Ln/jCw0BKIbljbcXojnxASqAubSk4=;
	b=EJica55gTZCCmmhKFk5RU71mjtDJ9xtgv3sEOXmRUP2lOqGVi3fX7Nfugr5F3MTZQ3KXm9
	MEerU+cQxs/wKADw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] iio: adc: ad7766: Use iio_trigger_generic_data_rdy_poll()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-20-bigeasy@linutronix.de>
References: <20260128095540.863589-20-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601440.2495410.17586183594384302688.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8162-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AF77CC6A48
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     44c9ec4096cdfd18a84f30d011482914ff73c66b
Gitweb:        https://git.kernel.org/tip/44c9ec4096cdfd18a84f30d011482914ff7=
3c66b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:39 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:17 +01:00

iio: adc: ad7766: Use iio_trigger_generic_data_rdy_poll()

ad7766_irq() is identical to iio_trigger_generic_data_rdy_poll().

Use iio_trigger_generic_data_rdy_poll() instead of ad7766_irq().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20260128095540.863589-20-bigeasy@linutronix.de
---
 drivers/iio/adc/ad7766.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 1e6bfe8..9e4a664 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -184,12 +184,6 @@ static const struct iio_info ad7766_info =3D {
 	.read_raw =3D &ad7766_read_raw,
 };
=20
-static irqreturn_t ad7766_irq(int irq, void *private)
-{
-	iio_trigger_poll(private);
-	return IRQ_HANDLED;
-}
-
 static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
 {
 	struct ad7766 *ad7766 =3D iio_trigger_get_drvdata(trig);
@@ -260,7 +254,7 @@ static int ad7766_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
-		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
+		ret =3D devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_rdy=
_poll,
 				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);

