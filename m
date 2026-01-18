Return-Path: <linux-tip-commits+bounces-8062-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D2D39557
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBC89300181F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AF32E73E;
	Sun, 18 Jan 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4QnPuoz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIgUFryX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A932B990;
	Sun, 18 Jan 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743720; cv=none; b=LbIkvJk4DMBCtVgsrx98LKvXRgGHbkmBfM80/s9SVZM0+xIbQi1LTxVfaeGBt79LuQtJVauNLvi1NKZzvYl/EKj75D7gPdrDV5AOs8zxvtikWd/IEvnc6WO9O8AQrgMoa5iWnP9SYpvbBT1OHw/hFs0SXeainck4Lf71uCdcPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743720; c=relaxed/simple;
	bh=Hd69JuHQWrCJ9g1Q9Acw9y03GRAmImbjXxeLLBiPhTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LKNtCjjMwO9rpMQlO3OmyuD08WNTKCqKZozoQSLKMikxhgEy/xuOLNNMcf+kcp5cp+APkgvJT6uZnmY8u8CsYL4gEEAwYA++KbR2u4REkL7sUpf90JZh5D9+ZPV4VVRuYn6U30DmdvltTmSXggcM2MPAijnNu7VIakatOmLZxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B4QnPuoz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIgUFryX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMLGnX0C0yJ7MhwpT2ZCo4Pm9usw1De3b6hKtaGcw+k=;
	b=B4QnPuozxo+dKU+3adMPR41pBXA0Js4ZlNv4NkAZZYHUwFgLD8w3MjrMKu3NCC7WocHQ/Z
	LBffGf/TLAPmRPBpg1fNQI7vZhUyhw9w0eFERiktqgCTXUa3in0QEc94JF9l39WheG/nbS
	/EXubCk5KzQz8uVRSTVqyqHUHMZbnk477zQBRPC1wJB8Vo7r9iAL5Bv2lxPMU6ki6gkob0
	gNvRWT0zApSPgDrXxqkV7CXHDAkjGDbvK+dQsOnBygSuu5uF0ttxT74iZiG6RfpTIdsLJN
	uINkt1iiKPBU9nQ8QEP7PT/ztcRmABAhpCaUrzPeT8JF8QSggoe9+ju9JFa2tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMLGnX0C0yJ7MhwpT2ZCo4Pm9usw1De3b6hKtaGcw+k=;
	b=xIgUFryXlL/KOfjMf/A02UFcxzY2L67kwtSVB/fRM5NBDmHP1p20qh4ENONUqah2b7eLCi
	N7gVRFwVRrGDdqAA==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aslint-sswi: Fix error check of
 of_io_request_and_map() result
Cc: Chris Mason <clm@meta.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260118082843.2786630-1-vladimir.kondratiev@mobileye.com>
References: <20260118082843.2786630-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176874371094.510.10369088803664917180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a384f2ed886d4417d50fdad78aaf1ccf870d62e6
Gitweb:        https://git.kernel.org/tip/a384f2ed886d4417d50fdad78aaf1ccf870=
d62e6
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Sun, 18 Jan 2026 10:28:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:18 +01:00

irqchip/aslint-sswi: Fix error check of of_io_request_and_map() result

of_io_request_and_map() returns IOMEM_ERR_PTR() on failure which is
non-NULL.

Fixes: 8a7f030df897 ("irqchip/aslint-sswi: Request IO memory resource")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260118082843.2786630-1-vladimir.kondratiev@m=
obileye.com
Closes: https://lore.kernel.org/all/20260116124257.78357-1-clm@meta.com
---
 drivers/irqchip/irq-aclint-sswi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-s=
swi.c
index 325501f..ca06efd 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -110,8 +110,10 @@ static int __init aclint_sswi_probe(struct fwnode_handle=
 *fwnode)
 		return -EINVAL;
=20
 	reg =3D of_io_request_and_map(to_of_node(fwnode), 0, NULL);
-	if (!reg)
-		return -ENOMEM;
+	if (IS_ERR(reg)) {
+		pr_err("%pfwP: Failed to map MMIO region\n", fwnode);
+		return PTR_ERR(reg);
+	}
=20
 	/* Parse SSWI setting */
 	rc =3D aclint_sswi_parse_irq(fwnode, reg);

