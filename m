Return-Path: <linux-tip-commits+bounces-7723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BDCC006B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B523020C02
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381B3314AE;
	Mon, 15 Dec 2025 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdKndrNA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Fam4Kec"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21832E6BB;
	Mon, 15 Dec 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835231; cv=none; b=fx4HhQM9rhFT/aAN1WKpgdNQNeXIEmxHe1X+/Uv6DLW4l3caY9zhM4TgPKZ6e+pjdGfDrKXcsgmDVYmTfolqr/R597A3ww5bFFRaee9yJ4GiOqRjaQo1Wcu7D9+3IMoAJG/YZke2iH3jSLXyL1dbMcynH7TxVPR1pmmlQbIis8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835231; c=relaxed/simple;
	bh=mtFhBvzPUMFq6MGRU/iWXaeOgl8sw7EWFsw76IGRtLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nwZCPKZoctJlRpaRN1zHMAXCFJzWkr7sQ2LXqFyEj6Mc2xBpcvvSOi1SY/Arh8c4zyToB4InJ3jloBhmfXB1PSoRHOH/ZBnsxt45442QnLXk/iIv0XFnFCo3P9h8Lgv19D0wM4r0gIVJVNBKRSsx5jNcqbZdFwerNz/W4I9tWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KdKndrNA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Fam4Kec; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsAT3Cuge45C1TgB05JnifSoNyPo+6WN6ln+Cji/U7I=;
	b=KdKndrNAIHbGbOmOXOHiCWqZBBKzdk3uvN0oNLtlFJwTC7xh6Ol0Nn6iK9hWYzFGNtVfra
	Ll6yx5pu4gdWLXorY1ts4qTmzRlValZa5Dd6G4JX9oDHhUCVcOHxcml6wjeiKrIfz06usa
	4f1npvm1Xo2nlSiMGj5hsxfwpvofv28dK47cQYbiwWB8rByjRdIQ3Nxu+lgZzaTQd87uXo
	hKNDpyepDE/tEpalXlXPfk2WuY2QfAXDO/cUjXxM69ve2TBTyBhwKszHIIw2g2LgY1AQG/
	dMVEkwqUFxuEmmqMSS2FmgxwBexybmnQiKJbjuTTRUP9Y7SpJZhVdCMcYq6GcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsAT3Cuge45C1TgB05JnifSoNyPo+6WN6ln+Cji/U7I=;
	b=+Fam4Kecit6GtKhKXNKtNw02JiVwM00HMMz9XaawmZG3te4CTs+wIVKA8aJoXcxrvOiXKN
	QeqeFkT0JD3dXDAA==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aslint-sswi: Request IO memory resource
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251209142336.1061606-1-vladimir.kondratiev@mobileye.com>
References: <20251209142336.1061606-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522611.510.658566134479030454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8a7f030df89746842094334cdf55114d0fbb0234
Gitweb:        https://git.kernel.org/tip/8a7f030df89746842094334cdf55114d0fb=
b0234
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Tue, 09 Dec 2025 16:23:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:31 +01:00

irqchip/aslint-sswi: Request IO memory resource

Make an aclint_sswi instance visible in the resource list, i.e. /proc/iomem

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251209142336.1061606-1-vladimir.kondratiev@m=
obileye.com
---
 drivers/irqchip/irq-aclint-sswi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-s=
swi.c
index fee30f3..325501f 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -109,7 +109,7 @@ static int __init aclint_sswi_probe(struct fwnode_handle =
*fwnode)
 	if (!is_of_node(fwnode))
 		return -EINVAL;
=20
-	reg =3D of_iomap(to_of_node(fwnode), 0);
+	reg =3D of_io_request_and_map(to_of_node(fwnode), 0, NULL);
 	if (!reg)
 		return -ENOMEM;
=20

