Return-Path: <linux-tip-commits+bounces-8161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOaFLdKJf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDFC6A57
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C2E30048D4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B274643;
	Sun,  1 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grd2xA6v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2oISkD1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62D1DF970;
	Sun,  1 Feb 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966018; cv=none; b=PfQm0SC4QFIBcJB+c8kRYdzfj3Ovz16HS38pVtKOO+q7IYXoMBP7+Hb5eg4FaGr7e3bbTMgk6LV+F9u6TXMYtlbrUOSeJdv3rr78X7OAgV42xt++w7teDSYfVDb39DuPi4z+RTqJUGxuulT+mjoWaB1cGnK4Ubcbp9AtLNU6uCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966018; c=relaxed/simple;
	bh=uuqq3dtoR1wWmRTr/IyNhlI/aPXEK4Tvl1+f6tSt4C4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q9CSKgVwz49eUNtQppFViqM2JhqS6pxweTdMekjLlm9i0NV49kczQYCFD82Rp7WFVgfjmb+ZFTf/7g+LIvZ1+AmnFRPbkEjjIGM9ToTVG8m3PpwJtEvxQJOizGwhg2fqqbh57xg6lxFYYiQq3nJx77bPBXb6pCujDrOqOlDgdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grd2xA6v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z2oISkD1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4Uzpg/I9TXU+/+QwjobrdtFcmU0/4UJSdoZRzbKzLM=;
	b=grd2xA6vaLLkVrM5M46Pa8v8XOS2WWoqvPxCx4vDc+g0jPKrbFH7Y9V1+ExZeA25MVD5IY
	uUkJ72culKl28HnBG58eCzMlXWZC66Hi0jL65OYXKSf3UzmspLxsEm4spg91ljsis9x+5f
	GtHWfQ192B0E/dNF26QJPAZBDZG0ggRrXZPNhP25XIorAQnyEarB+YTIfl3+nGE2uOLQMh
	EbTFoiUx+MAjZorNhTNDiLZdelaA0BoWVgiJ9lR21TgTPWjb6SZeT2N5PkTuMv8+nPCcVY
	JZzzudg2+mM/Cws4ydjvWowHJXVbSFmG9BdpL+Lbyllvgmc+EAVsIvhw6PqJUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966014;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4Uzpg/I9TXU+/+QwjobrdtFcmU0/4UJSdoZRzbKzLM=;
	b=Z2oISkD1HJCexUyzTILYXEIDMChHwBQZM/QA2c6ROCTkQLwbfBOIQWiri4kMU+jIznL4kx
	yqberBOstqzhsJBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] media: pci: mg4b: Use IRQF_NO_THREAD
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-21-bigeasy@linutronix.de>
References: <20260128095540.863589-21-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601337.2495410.6025400151560723419.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8161-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 10BDFC6A57
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     8b8a7a56a9a2eb7c8995df7073b1a19852edea97
Gitweb:        https://git.kernel.org/tip/8b8a7a56a9a2eb7c8995df7073b1a19852e=
dea97
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:40 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:18 +01:00

media: pci: mg4b: Use IRQF_NO_THREAD

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke other
interrupt handlers and this supposed to happen from hard interrupt context.

Use IRQF_NO_THREAD to forbid forced-threading.

Fixes: 0ab13674a9bd1 ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver=
")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-21-bigeasy@linutronix.de
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/m=
gb4_trigger.c
index 4f9a359..70cad32 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -115,7 +115,7 @@ static int probe_trigger(struct iio_dev *indio_dev, int i=
rq)
 	if (!st->trig)
 		return -ENOMEM;
=20
-	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, 0,
+	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, IRQF_NO_THREAD,
 			  "mgb4-trigger", st->trig);
 	if (ret)
 		goto error_free_trig;

