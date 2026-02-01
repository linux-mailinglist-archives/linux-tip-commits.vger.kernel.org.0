Return-Path: <linux-tip-commits+bounces-8171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COkfCAGLf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:18:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664AEC6B3C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A08305B09A
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8F27F749;
	Sun,  1 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AB3TKdvJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="++Gw9vNx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E3285CA8;
	Sun,  1 Feb 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966034; cv=none; b=AqbCXvLecPrrhEgyrOYss4X83Yhcb+2ESh7a+50jJ8lidEvtUyyEk5uymoN2g/KwrJ22andiJzJH12LXLO9NyKK+e5rMPHPbWC58sk1IZukwRvYKmWptFF049j/nmRXuDV3SSKRO9oKhSbz3kmc6m74mYrher1VgmyWpED3Gg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966034; c=relaxed/simple;
	bh=99yxzmrKUswCWtfyEavP/tt+56pEbmS5VH7bJYq4KYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R/a9aHB4VhEoEigNDCNQicTC7jw9ukyDuR3ZraLR2oD0WqQ90DEL+jcUjAxS+IJ+WbUeZuFFbmpWkdOEOftLU+Sejgxt+US+2EpUCfVxHWayDkn917BZCGK2bqbWOa4oJriouXOcd69b4Hza7JiDujJJm0E4sYqEW65jkvSWexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AB3TKdvJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=++Gw9vNx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVKPRF9bFw+Pd/ggVbAfcUUzkZ3jXAuMcuZA9IjqpGQ=;
	b=AB3TKdvJ7lI8w3P8knS+X+Awz5XGj26iy6E5FTnAPjUAwwwQiziP9YSX10zQgkkWoMJ9Dj
	U/fWJYWfmRjUVewkcIYkSgfxFFocjrz1RYT2hCJRAALiXBew54EJ2mq2jGShxxkbbt1htu
	jnrrkMkLYvmSAmu8Rlv3LFODXdzmEZS6vdYQTE1oVIuv6t/emCTYsKv3U75qtmz/2S/inz
	quv4NTIO9JGrdenDfofY97hSBHEKehCVGRE/TEaxPp08oNVpQIK0Ep/gerIgGo4LBU/Tyq
	BCw2JVHpvXCqQ3KuA6GwFcIKs2uArwU+kHptcL6jxYZFY67KflX6DZk7/0xTtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVKPRF9bFw+Pd/ggVbAfcUUzkZ3jXAuMcuZA9IjqpGQ=;
	b=++Gw9vNxgeUFdq09fi/d1aB6dwqGvschjjZCCsxvIgDQn7pyBhspERcTu6oyNsbymnFS7r
	q6d2uJOSFHMk3FBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] usb: typec: fusb302: Remove IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-12-bigeasy@linutronix.de>
References: <20260128095540.863589-12-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602278.2495410.5903700764719827290.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8171-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,msgid.link:url,linutronix.de:email,linutronix.de:dkim,intel.com:email]
X-Rspamd-Queue-Id: 664AEC6B3C
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     a7fb84ea70aae9a92a842932206e70ed1b3c7007
Gitweb:        https://git.kernel.org/tip/a7fb84ea70aae9a92a842932206e70ed1b3=
c7007
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:31 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:16 +01:00

usb: typec: fusb302: Remove IRQF_ONESHOT

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Fixes: 309b6341d5570 ("usb: typec: fusb302: Revert incorrect threaded irq fix=
")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260128095540.863589-12-bigeasy@linutronix.de
---
 drivers/usb/typec/tcpm/fusb302.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb30=
2.c
index 870a71f..19ff821 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1756,8 +1756,7 @@ static int fusb302_probe(struct i2c_client *client)
 	}
=20
 	ret =3D request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
-			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			  "fsc_interrupt_int_n", chip);
+			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=3D%d", ret);
 		goto tcpm_unregister_port;

