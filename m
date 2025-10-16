Return-Path: <linux-tip-commits+bounces-6953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312ABE5289
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83623A8C0E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8275253F1A;
	Thu, 16 Oct 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEsUq9H6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNqz8PxS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA976246BB7;
	Thu, 16 Oct 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641293; cv=none; b=MWLxdkWt/y2rIuvFik5uCoVXZltiecJy7IaMxC3Gj1IBPfSpAY282WOjCVYRm4hxgj5UBuffM/gl11IAyheSU+Fnmy/uHMsjllg9WXHUAfI7e6mBdtMWZF2QJJqMS3vRPILCa9F3vvI63Blnss95heBlVKqHKuNAkm8scS7l9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641293; c=relaxed/simple;
	bh=ahXqJdgr4kZ9kbHKA6+EIopHH8PSVyD8q4k3erqmH1g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qjQln0+TY1PaM2K4qzC4MwZkk+0Pl59KrsPMIyM+QR38Eekg9QuIdElvVI++gBos7N4558WuYBTP2XBlg4cr8mCqBcMQQCh0btNKyn4YXgY8jJGrjeB0/bmpoRuhRNl5CyiLOWLmJ52ovDajwm3nz7fiOLPsFMjqWJyTS+Z1afY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEsUq9H6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNqz8PxS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nYZiT8YBAzY+Ibw9FBC7lU8wTgkUYboMVZaEu5SqEM=;
	b=nEsUq9H6RzL/IeewiRBDgiOK/h0aI+5Ska4luHG0oUtoXr03+UvT2KaVVbaFtnaN3tsD2h
	pZQWLTURm/B8tDDm+Re3naK24tV1WLtDGGpfoE/6fRtGke3Up89gqhyQEUu0vP30s1Zsc9
	HkgQ7IdEVbOIa0PIp9r7RQrwNs9ugN5Rqq576KpnYd6B6kPooTqum+pRGChNUknaYrkbQP
	nY24BkarONDWxIIoLPFLCNvBTc2oWwNedQbPGBCzjGkkeq4sxQEbyLV22ZPUcrDosDDJZQ
	6QIj3TRJL44EtSLw0/pTZx2xj43JN1pWphunis3bhWQIn0IYqi9S3kU6WMgCtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nYZiT8YBAzY+Ibw9FBC7lU8wTgkUYboMVZaEu5SqEM=;
	b=fNqz8PxSkhDYyoIgTmb8O8tP2AtiVB09YZvBQ0C17JD/S0Sqxjg8lQcCXNyWqD/kKqiCHi
	uSMNgT90zeYGytBQ==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/mvebu-pic: Drop unused module alias
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013095428.12369-3-johan@kernel.org>
References: <20251013095428.12369-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064128649.709179.9435156948004288662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b03127a4e778435bd90794e654834f94860c80e9
Gitweb:        https://git.kernel.org/tip/b03127a4e778435bd90794e654834f94860=
c80e9
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:28 +02:00

irqchip/mvebu-pic: Drop unused module alias

The driver has never supported anything but OF probing so drop the
unused platform alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/irqchip/irq-mvebu-pic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index cd8b734..10b8512 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -195,5 +195,3 @@ MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell Armada 7K/8K PIC driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:mvebu_pic");
-

