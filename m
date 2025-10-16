Return-Path: <linux-tip-commits+bounces-6941-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAABE4546
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F311919A74DB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C33570C2;
	Thu, 16 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fG0YLS0o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2I43N/a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D6350D73;
	Thu, 16 Oct 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629602; cv=none; b=aXH0BLbP+0mdKGjMSYAGQkfrkcggnyQC54LdlXnPD1woNrQPAt0P5yik5ujpl6nvNtkqqm/jOOqCAV5OiDR7GImW1Zd84MWJHzC4lSXMx7Sc1GT4vBz2/eJISFjonD7tgaTkNUNjQZLeBPiQaRA9VpaQ3HjqjVnMvd1GpczZCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629602; c=relaxed/simple;
	bh=rj9zDZkY0gQ8veatHkjVnxZGv0I5XxUfZ8LF3q7U2Xw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mlbZqMaqPryeRhfRg2+DJsdOu6Gj5PueKJY87eTEkvX/2HNJnKHzKTnZbKfipQlVBIw0yo/Fn9cwA5L1h9XuMq30ihzkqi6yO4xi7klcx75ZKwZRVhxkf5KcOj5DdlCkRaegFkv6jfzXHXtzOhx8Fd8eDaYkgDVXjrPCQSAY+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fG0YLS0o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2I43N/a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oENVtk1SFqTzbJ88DRFaSYyeT1zF0xpeflqYTvT/jaU=;
	b=fG0YLS0oMBjhT6oN8qNxWKHu7PBapGpSb0z2Mtw41pnIDDsi1gj5VwtBV2jeAV1Fz65jHb
	eJBSR7XaMjsQcRxkP//vXBAMnqXLGQDsHnpHrH4j0wdh7kBbYbYqFngP317xd5l7mknw1W
	T0cn+onB2deDndfjIdzrzbZKDsi01j6tWQAe21TGC8rY7lykXm0Wxx47j4oqCkQsvye9/m
	wFJSsUvl6DTYX4RPM1OuyXh9gh0y3AeLvn3B3+ot40qQt6wUERjuslWb0CasbOayeJsbns
	sdZqvttQGOiP2lA8WLf35KHfmcarAAqiRuaDkEbjDJ98RBDt4cIOkMisu8y/Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oENVtk1SFqTzbJ88DRFaSYyeT1zF0xpeflqYTvT/jaU=;
	b=r2I43N/apmsb5xHZtgQgrdB8LfilO6m5DbzrP52MX2TFRk0C/MJIA9XmI7t2u4SNofOfPy
	/wDTZnl0NqRQbZCg==
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
Message-ID: <176062959780.709179.17098231346248366490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8330a8c2ae819ec454d9715f3d413cbb0699e7ae
Gitweb:        https://git.kernel.org/tip/8330a8c2ae819ec454d9715f3d413cbb069=
9e7ae
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:34 +02:00

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

