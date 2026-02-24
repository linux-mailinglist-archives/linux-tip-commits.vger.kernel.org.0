Return-Path: <linux-tip-commits+bounces-8256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKIfEl3inWnpSQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 18:39:41 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD418AA23
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0459D30E506F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B583AA1B1;
	Tue, 24 Feb 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cF8m5hrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ysI4XAw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4453A9DAE;
	Tue, 24 Feb 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954618; cv=none; b=GZ3wdwUBg9R+DVXmJYCmBeCgdtWFzjxXV3/kXwdixlp4Qfq1SdSAKOssQTInLp9mqP3/I2KhQ3dXPh97NIBQGf4XMb9pkUpLbMIGwcVJi1rfCDKvbwEEtXQ0O5zJWWZdpNwHTJ+VEIhux6G4HA14b6n5mIEgIUvFPu28SAlECHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954618; c=relaxed/simple;
	bh=uOMTNFxDp1eAIvrwpGFZHPyekQFWzpPNUCunTIWmulc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hhtaBWXL9fbndep115IEAOE/Y471RAbgLDtr21WT1NSMlawcY5jONcknNqe37cf/G3skngN2ELAJzFtXJXtWToxk0vpjfyDo9ZZqhjxjCu+JZNcW2NHlYOPf4RAx+PpLzr0msk3OHG39KHTgZ9RE3baZR3x3c2j/bgFRVONPkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cF8m5hrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ysI4XAw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 17:36:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771954615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4IGsvNNyYFIDRhDOTqBoIvTAuiTOZC3fe6RU5TPhr0=;
	b=cF8m5hrUt/4441wHjHJ4ceOgxseczsOpyEAkJI9DV2ryvBI0X/2aMFQkf0nHBxr1zfSnEE
	ws5ZdMmhXckvaiy4hBaaX5mzeD/57/vnPb2N38DZVc8p3DmZYgY8SsztSDMpSvwlezYt1U
	bfGMxy49SIP7vHEWrO08M85xWGhDhobBIKHOzuvegmYpo3dwCGDZj24UzxeB28Jel7TUNQ
	P4BUaR85MC/iiFbKxmXNWye4CpNg3C1r0kpp7q4t/Yo88HmRxeZb0hggxI6/o3qkgjrYHh
	tJm4Dmiu8SIyc6mnxlEO8B2kQdNLKrA6w+edCyvrhCgurd2PiBHA8g9dKX4VKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771954615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4IGsvNNyYFIDRhDOTqBoIvTAuiTOZC3fe6RU5TPhr0=;
	b=6ysI4XAw3BDZnOqb613vptljAsvfdTflqC5C7z9l5iVW6qsvYfLaifwa9wMlIMcbpeCBPc
	xP5OlMh5YtconmDA==
From: "tip-bot2 for Ioana Ciornei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ls-extirq: Fix devm_of_iomap() error check
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Thomas Gleixner <tglx@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260224113610.1129022-3-ioana.ciornei@nxp.com>
References: <20260224113610.1129022-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177195461452.1647592.10777633819590019033.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8256-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,bootlin.com:email,linutronix.de:dkim,linaro.org:email,vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DFD418AA23
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     fe5669e363b129cde285bfb4d45abb72d1d77cfc
Gitweb:        https://git.kernel.org/tip/fe5669e363b129cde285bfb4d45abb72d1d=
77cfc
Author:        Ioana Ciornei <ioana.ciornei@nxp.com>
AuthorDate:    Tue, 24 Feb 2026 13:36:10 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 18:35:49 +01:00

irqchip/ls-extirq: Fix devm_of_iomap() error check

The devm_of_iomap() function returns an ERR_PTR() encoded error code on
failure. Replace the incorrect check against NULL with IS_ERR().

Fixes: 05cd654829dd ("irqchip/ls-extirq: Convert to a platform driver to make=
 it work again")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Link: https://patch.msgid.link/20260224113610.1129022-3-ioana.ciornei@nxp.com
Closes: https://lore.kernel.org/all/aYXvfbfT6w0TMsXS@stanley.mountain/
---
 drivers/irqchip/irq-ls-extirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 96f9c20..d724fe8 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -190,8 +190,10 @@ static int ls_extirq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENOMEM, "Failed to allocate memory\n");
=20
 	priv->intpcr =3D devm_of_iomap(dev, node, 0, NULL);
-	if (!priv->intpcr)
-		return dev_err_probe(dev, -ENOMEM, "Cannot ioremap OF node %pOF\n", node);
+	if (IS_ERR(priv->intpcr)) {
+		return dev_err_probe(dev, PTR_ERR(priv->intpcr),
+				     "Cannot ioremap OF node %pOF\n", node);
+	}
=20
 	ret =3D ls_extirq_parse_map(priv, node);
 	if (ret)

