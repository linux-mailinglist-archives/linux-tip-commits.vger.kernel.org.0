Return-Path: <linux-tip-commits+bounces-8184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pg/FamwgWn+IgMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 09:24:09 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B4D62E5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 09:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F18300D696
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3083939A7;
	Tue,  3 Feb 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBB66ABU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrym1IZB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683E392C59;
	Tue,  3 Feb 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107045; cv=none; b=DGWBAegvCHyqD0jJ3AEjfcA2U0jI7x2ABiXLj8IfQvyRHXazU0kTy84Dz3N3H7ipCRbTzEsNGm5RD1U0jEUeocSazvb0Q8EwcJLezve/JcKfKAJnDtfOWgHjbcm9caxtvKUk2AvTHkYaqqpwtq2BaJ7QWeSq02AUKWtvEpTpi/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107045; c=relaxed/simple;
	bh=Smb8RzYoKklneILaQ8iYpmMDxHqcz5rmnVo7EGb3K3k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RWfy2kcvw02DbrfFiq+Eton7HbIs3b9J+MJIhmyVOzZorFwxk0k1i+bx5RlNu5wEY3pSn3ReFlcsKz1KbIEiwvR4FWHeZzDLAJDpuYFol+ajl330kHB6YkAyXhAFd9z5A4MbJGP/tlFhUjJhLSYXnjzjce4msEImb+u3jqrVFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBB66ABU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrym1IZB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 08:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770107034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXaN9Edc+qi4M+H2xo17xUUXO7hk4VFdE8SNcPSLesU=;
	b=EBB66ABU4nIxUO4LH0VVg3NGqYMT6F9LeJTT1/RNgfaIG9AjJy5uHVnLwEZS5uiIZt8tLJ
	XwMYx1a+Bcmmp4dLPIphDWmT0Q+uz+n4FX21oN/S1Eo5KTWUmKk7ockHqfQoJ2pNLxZwyp
	JBYbAtIqHD9Mq1Oc03GDYHEaiiiyc31D0A5as82/Kr9cz0oKMPRgY+Aqe794VzTLzEFXLN
	19tZ98fH2C+TOjjusKLrTObWl8/SkRo7GmL661R0HYSjgEAJuq4vmqbN/Yk7k34AdBHJkT
	hCrI8Q6axdqurxqK1PRKQAkQrExkhXLcGLcONTrPkfCYxCg8T9TYSxHisyrhCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770107034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXaN9Edc+qi4M+H2xo17xUUXO7hk4VFdE8SNcPSLesU=;
	b=nrym1IZBtdaET2kxucyypz+UL6GyLE1KCNkEgWWSqCUG5fdCOUYNrls2od4ne8EAMjpwiX
	Y3SCM55iX+uR7CDw==
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
Message-ID: <177010703292.2495410.2623239000157056277.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8184-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: C44B4D62E5
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     ef92b98f5f6758a049898b53aa30476010db04fa
Gitweb:        https://git.kernel.org/tip/ef92b98f5f6758a049898b53aa30476010d=
b04fa
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:40 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 03 Feb 2026 09:20:55 +01:00

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

