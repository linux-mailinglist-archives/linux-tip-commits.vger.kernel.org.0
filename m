Return-Path: <linux-tip-commits+bounces-6329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B81B32EEC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378CC7B12BD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E80253F05;
	Sun, 24 Aug 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlBigJ2g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMby5D7k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E72C2E0;
	Sun, 24 Aug 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756030274; cv=none; b=RF6ZCm7MvOx7/LjChWkB3d/hY35bY7IZzObB72Vtyn6UqVbyU66yCf4KvsMQ4ufIrBmmm3hyxkBRwJcjpDf539/z70/REQ0zZGSRhDcLmS1FrBDJP2sgM/n3l4clcf9fufIF0fsp11rEhwt0jyMqoU4qNilbHT9wCMN8aW6jlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756030274; c=relaxed/simple;
	bh=9zZDyOJsfuRjmC0JH6+YxVCjEnEP/oP+axJcMI0Wj10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NycDXWzl9xy7K0Dqve4+zaPsxpfpHzirY4gFv4r3C7QnUoaPkwHxwkCLVNMa2/G5ihq75cH55uIDvKDYJbYa/QdwbxkDQuWioHwlzah3olP1HtV8PSMVbQfLR0SyhFqHL+9JHYq55l0eQjuEwNyoTVm5Rcr//QBCsQKNpNlymbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlBigJ2g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMby5D7k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:11:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756030270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/JAXQBVGofOlgE7ad5x/b2Vn0nnuj4FpEIHnnEeStE=;
	b=NlBigJ2gReLiKPjRQWtd20ZkE7YMHvDYNpzWrfZFxmSKldia5xOr03aopdwGKzqwgOWyuw
	NsBvwkowoZf1maO2NDUQXCn3cRY5XJV2SXUn/UdU6EogBhhztSyXCioNs/Mdb+XsClNzh2
	Lgf94Z0DQo+iyvv3yIO28UX+ZXWp10YjIXPIw43MHx3lBn27t8IwBE36PMjsQyuBLJUHwS
	B4i5pp9b3CFT+zRkvjQ1gEmvBblarmLgASdRCMT/OOE2XywoJt9cIkS9niPY+iKKq/7mAI
	Lh6B30tKP384L+ILNMkgntRMVl2Nr8Z++50xgl2dnVdXrh1AEEd1Kgb4K89rCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756030270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/JAXQBVGofOlgE7ad5x/b2Vn0nnuj4FpEIHnnEeStE=;
	b=RMby5D7kiwK6lnQy59QgIFQI7YQHgvSTrnGWhHSSQPvMmihJ9xRvLCNp9LDSCsFITEoo+8
	WkXzb426jTkvZuAg==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check
 in probe()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <aKRGcgMeaXm2TMIC@stanley.mountain>
References: <aKRGcgMeaXm2TMIC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603026892.1420.17844045957403698368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c8bb0f00a4886b24d933ffaabcdc09bf9a370dca
Gitweb:        https://git.kernel.org/tip/c8bb0f00a4886b24d933ffaabcdc09bf9a3=
70dca
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Tue, 19 Aug 2025 12:40:02 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:00:47 +02:00

irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check in probe()

ioremap() never returns error pointers, it returns NULL on error.  Fix the
check to match.

Fixes: 3c3d7dbab2c7 ("irqchip/mvebu-gicp: Clear pending interrupts on init")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/aKRGcgMeaXm2TMIC@stanley.mountain

---
 drivers/irqchip/irq-mvebu-gicp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index 5483371..667bde3 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -238,7 +238,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	}
=20
 	base =3D ioremap(gicp->res->start, resource_size(gicp->res));
-	if (IS_ERR(base)) {
+	if (!base) {
 		dev_err(&pdev->dev, "ioremap() failed. Unable to clear pending interrupts.=
\n");
 	} else {
 		for (i =3D 0; i < 64; i++)

