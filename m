Return-Path: <linux-tip-commits+bounces-1492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1861913C5D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1512824E2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059E1822C8;
	Sun, 23 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdGaSzg1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YB3jox3y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AC181B89;
	Sun, 23 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156632; cv=none; b=Y1gC7euUFUcNBi6jq2LGqwA/1sfk8i5wIpCI7GZ/8WPLYE2IBw3vn2Z+Tm4dRTsUId340x8G/OaA+ZpxBl1jQdorpYLpU/rzAkp9ReOeBElj/FamDcijk1ZoMCZFlN0z7EHKVP1xg8yBrkKcaDZUaLiuiRu4Rbd+wUbYzm5jL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156632; c=relaxed/simple;
	bh=JgMsd1HGuhY4WxA8BX+yfusUhUzbPhKiWlRFIIXrG7E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Jlx6OCXdsO4Hrs+lsjA2Tbi4h4opaQZB9Zth8uibaIBqywvNxFlvPL3RWGYZLdm/qc72eDW6GrUvl3NgeQAGCf8ZD5fPKBd6OGxTOTcOdXvorEQpBUBQrLI+7Do7biA6EBynmWNRZxFoyCUT9YxPMvvbukB6q+oIH/Dqye+X7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdGaSzg1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YB3jox3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YEGhRd/ayWVYFRwZ1qOLNgLjO0vYc+bgoFJ6za5yHyI=;
	b=mdGaSzg1CYG3iNxuUPmtQ2zIMXnr5PI6skjesnfoXw9H/KZE6xgU+r+5ncu3rQHh9pPsJX
	zVDy89mVsuV6jJVWTwgI0dS6PuNi1Mr5EF19aKBEo9xq59zfbOwrLHV7/jriXR6yaJj660
	Ic+kyYbnn3YgrgMCEczXJi8l0f7XVWDAAq3YljMLpVVrleu4YCPlHbuvZ5NmqN9aOriSlD
	AFO3m81gqNeYIeGR2BXud2skV702+VpdSvtDcWsQq1bOqtscN9f0FJrfp6DtBM0jJ6cuzL
	FLaLUqF08clwNHY3Gvgu0Tz+vghj8rVPdHUqY4sjrnlJKhLv+AvevGcnbT0wnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YEGhRd/ayWVYFRwZ1qOLNgLjO0vYc+bgoFJ6za5yHyI=;
	b=YB3jox3yoO2ajUmTdhfujJ+dyZu9Et4Qpcb67d79XaWoRSVPbuoJRVcgxMA+URmIhQEWPU
	w3L/LQOSi7gTcgDg==
From: tip-bot2 for Pali =?utf-8?q?Roh=C3=A1r?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1
Cc: pali@kernel.org, kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662908.10875.4693371440122407544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3cef738208e5c3cb7084e208caf9bbf684f24feb
Gitweb:        https://git.kernel.org/tip/3cef738208e5c3cb7084e208caf9bbf684f=
24feb
Author:        Pali Roh=C3=A1r <pali@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:38:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

IRQs 0 (IPI) and 1 (MSI) are handled internally by this driver,
generic_handle_domain_irq() is never called for these IRQs.

Disallow mapping these IRQs.

[ Marek: changed commit message ]

Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 676df71..526077d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -560,6 +560,10 @@ static struct irq_chip armada_370_xp_irq_chip =3D {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <=3D 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +

