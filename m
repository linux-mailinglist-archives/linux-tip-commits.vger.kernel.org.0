Return-Path: <linux-tip-commits+bounces-2015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E7794C106
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C751F27FA6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C6192B73;
	Thu,  8 Aug 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4dHfDs4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+W2VayK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2171917E5;
	Thu,  8 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130510; cv=none; b=FiiF+Nj4C5GkgIkDP4SvBGGk+/j6xylfEmgX04y+DlXtSv0/J/vje5uhjwgJUouWnK+EGzsvfkJ/GSgDmPf3eKKDwX0AVVn2ZQTbiWS1Aeu9AfQ6yMcjpg1ODb/zxNgMcaMmRYk2rWWuPwUWvruqCnlV8/tL7iJWw2oHFYlmYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130510; c=relaxed/simple;
	bh=oEZhm0mdBdXTXSDqFf46yi6lSd4XDOpPP+McP5Vr+PY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Fpjk9SjZJmlzGBxbuTjABEPmCaE5zYZMtf0JHfV8EaWNsHME/MmtQiFKFvkcqmevHrxR8U0isLnMNbXA1bCXNoV89X0Ja/LXV5zZ4E52EWzNyoDqSYe0RNoGEJIhp52xFm3uZmBC5aMd3ED4bhuc69f7kLrjQaXSa4trGNsEEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4dHfDs4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+W2VayK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5aUMUPXfoDCEN9EwosuEjKNdOaIx8PIYNWmtQS+0+CI=;
	b=j4dHfDs4/WVLyKrNdPlSmHo+f6xWvRf66C78ra+OGx7Medh5vjy++GRk+x784jt+NI+ZgD
	XK62GEl0RS5VtGbhv04QKP3biLw7zFlOx46WZCvhnpaBTkZoZUMochrb5JRFx2bxIMhT54
	MMxoUa8VsBwpEaktlmmQMjeMeDZRiZk7TUc4T+jovVIpodgouhjQT4lvJsNWDZzk2KKVoi
	KyqSgHIt+HadQEErxD40PRya5KyuW6aKHyeTrtuVYE93wyN0loFdU3N2DdQFAOw/6GUr4i
	NN+7n7E7P4j0WpFW2SZ62CZSVamdeO4IFIYD5omx2bgt4FILZZ8JuXxXsk5lLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5aUMUPXfoDCEN9EwosuEjKNdOaIx8PIYNWmtQS+0+CI=;
	b=I+W2VayK7LnfEVqrLfpi5N/crMTyDI0qblUhaqD2j2+z8qNjr2OTQYPUGiOHX+i1cduEtD
	pkGNP5vgfkoxgRBg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Put __init attribute after
 return type in mpic_ipi_init()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050598.2215.9391748647018174195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a4d4d4a642da83d869d2851c8c3732c699cbc08e
Gitweb:        https://git.kernel.org/tip/a4d4d4a642da83d869d2851c8c3732c699c=
bc08e
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Put __init attribute after return type in mpic_ipi_ini=
t()

For consistency with the rest of the driver, put the __init attribute
after the return type of the mpic_ipi_init() function.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index f5a6937..07004ec 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -456,7 +456,7 @@ static void mpic_ipi_resume(void)
 	}
 }
=20
-static __init int mpic_ipi_init(struct device_node *node)
+static int __init mpic_ipi_init(struct device_node *node)
 {
 	int base_ipi;
=20

