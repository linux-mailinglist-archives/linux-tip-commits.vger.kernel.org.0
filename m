Return-Path: <linux-tip-commits+bounces-8163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPguCNGJf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44099C6A50
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B7E13002B60
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DAC280309;
	Sun,  1 Feb 2026 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqIxcBQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjuNTh3y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC1274FDB;
	Sun,  1 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966020; cv=none; b=NVcvQIVUFR9hZesJBVz/pcaYrntUvSSet9B0EnLYLwZvtStW78TN1k0g2JexopwpLIm87u0T0WaJkaWOit4viwiGu79f+/zjKbY7hRlt/6vylMevx0u0r1hp5TdDN326Oceyf9AIKMI0NUK5febW4CwICv9upiLMDBvPm7bQxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966020; c=relaxed/simple;
	bh=9D8CncGYz4lj6H9K4y+cfppt6k5H1WdxbXF2L/rB1LE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r1aN4HvbgX4uRm7yfDQ9swXWVrp2zNiiw/hChH1ncBPLb1GvIJLgomNa5hLyIE+LN3WdzopNpqMF4zmxLMAaBiwgITLgyjqHpAYJ6tFX4LnynqIqxetDpiO8LU1jk4urB1HFfW40EePETm9UBE49PgzpwL9Q61dDBZn38E8pwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqIxcBQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjuNTh3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M55bh2XENFJ54xgnE9Hp0enEPVzn01c3uCg8PKH2t5g=;
	b=bqIxcBQdGZKh8hDJbZq2RLf40cfol4EXr8d9eBF2AEgixHITmb0Rp8SVib0LS6ZH4+27UT
	uxhsaXxCwUbPWi4c0Kj1WnAQ4+bXOBZPTDCAkZEvvKdJMLHnNulV8pUXGYAp99GeObM4IU
	befsmurNFFs/3DvOb43m2YsCAjjPxOBjsIAjwecIamkzoKQEyMGplSEWzG9PYGDatusyHu
	krOLa2tH4CV6tK+eu/1pGfjAvX2Fo8p8pkpCNBlkeMKR6/Mkyb6tli6lP1cZh48I9IlHpn
	Jkn60sFJJ19/AeCPH27agkL0CboJofiCZshZA9qjf9/hMr8Zan/pkdY43Jzxkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M55bh2XENFJ54xgnE9Hp0enEPVzn01c3uCg8PKH2t5g=;
	b=tjuNTh3y/1o5zMAqs9a6bCWA2fzDyW4FXR4e2mqJfMYxqzCXKh6XOMSpJCi8YTmtw4XY1t
	fT9vgWr+QmN6BbDw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iio: magnetometer: Remove IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-19-bigeasy@linutronix.de>
References: <20260128095540.863589-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601558.2495410.11210142983544784172.tip-bot2@tip-bot2>
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
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8163-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,intel.com:email,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 44099C6A50
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     25974af8028aa638f33ef46cb9ae6a9b4206aa49
Gitweb:        https://git.kernel.org/tip/25974af8028aa638f33ef46cb9ae6a9b420=
6aa49
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:38 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:17 +01:00

iio: magnetometer: Remove IRQF_ONESHOT

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

The force-threading functionality is required on PREEMPT_RT because the
handler is using locks with can sleep on PREEMPT_RT.

Remove IRQF_ONESHOT from irqflags.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20260128095540.863589-19-bigeasy@linutronix.de
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8=
975.c
index 3fd0171..d30315a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -581,7 +581,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 		irq =3D gpiod_to_irq(data->eoc_gpiod);
=20
 	rc =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
 	if (rc < 0) {
 		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);

