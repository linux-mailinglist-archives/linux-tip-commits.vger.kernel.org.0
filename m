Return-Path: <linux-tip-commits+bounces-6853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F5BE285A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C492C48297D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02731A05E;
	Thu, 16 Oct 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="af4ryEp8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0Einn95"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2231A56C;
	Thu, 16 Oct 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608313; cv=none; b=ql6HerSv/g0OVLxlXXBI9VA40wUNlP4yJPS6U2GeZWIzpigbxKFY7lWwelIRYE5rZJNiLYEUqohMXv1XK9+T48nROcR8byNa0M9RIYRf2nyv+AbfupipJtNsaOxnWsxu4rxGZeUxuZ8Kiv3vpxNpWKxMy7rECIOsJwvkodEcwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608313; c=relaxed/simple;
	bh=ovvL4P3XQtjZhprqTZne/dyvFPa20qNFYImenLIAnWo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ADHaY8vS5FdDjxpuMeCkpY6rzeC06jgzO/2KTRGTQdXQug+OImdg1NPUlQYo6HVXw4p2Vgh70ig7TZuUnW5aHJSzB2FfXfeg4FDXCVKnjVKxukrrMt9tdCyfYbfu3ejR9baipNKy0YuEWH6b+dJ1oNjrzOUJrwl9hWIStS2qGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=af4ryEp8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0Einn95; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8JwWpXOk43MJlBXNZI5tJyTXTe7GlPCz9hXj3d/cOA=;
	b=af4ryEp8KfS3cLNunpJtaabDfIIS6WRfIehZcJy2EhnZr3SAK07fmu7KBxjtkPIv/T6ezU
	Z5Mr4lZtg4FLVAiuaeY1hlp0btMI2xWI/F2PHq6Kpd1qHckG5Q1LS375/l6pFd5051vC30
	YWS019/CgTT2gBosusKYW4q3jyWOscPfax4OcxWt7Up8ZeIBsipqp7tfCT3J1mIKENIs7B
	KdmxMc+EODQ/fNHo98oWYaFhzNGFYf2dTwQgcdGKe75h6bHgpbPCFabSH1Mzr7nEbUKxEn
	SvXOG/8J5CnC9/ElNSGIY/yWMuS2l8urbHEyJmbpjIC5Jp+IuvMhDU1FFJl2Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8JwWpXOk43MJlBXNZI5tJyTXTe7GlPCz9hXj3d/cOA=;
	b=L0Einn95iT/iJMdcatPv0jrCrs1zMLGWVV+zC10M2mxHH91ejROClVZEbkSIUy6DFszMlo
	Jbn2e6LCRp8vDuCg==
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
Message-ID: <176060828791.709179.1912655332079012036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     312e6313019df8738dbff9be03f87343d00bb519
Gitweb:        https://git.kernel.org/tip/312e6313019df8738dbff9be03f87343d00=
bb519
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:34:24 +02:00

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

