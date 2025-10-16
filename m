Return-Path: <linux-tip-commits+bounces-6852-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA546BE2831
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618364FCC72
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875531CA50;
	Thu, 16 Oct 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwTTFele";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6uMAEa1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013231AF2F;
	Thu, 16 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608312; cv=none; b=Pf20Sbpld8TxJIIXBdV3dEJeLiXDnUFJ4rsJcUBl8OPZO2AiJwwECQnS5SW12r0Z6hcHsy6aERWvipJVlH9vG0JatqQyIgyG289buSQ16spWAOCqykemWPX/SAM8I0+rjMiXjL+x3T5NX1GoYg90Jvf2gc++UlasD6qQr6cl2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608312; c=relaxed/simple;
	bh=2Z3vnoyzKk2VkJQfxMtjZuNVLbgfewxQVxiybBnByB4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tyc5GXIT8rD4vnSeNPS4rDrWCiipKGdBeJkG/l02KsuGi9eA33AT+09mh8pL+F3JEVPtMPnw5888F9JZdOMkEwRaRXzHorMUARCoTjJNIksIzn38f14v6IZhzN1qrHtkWI4XNEtnydu9dUtaM6hujYdXBZK4Jg3GZzGc1ogDSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwTTFele; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6uMAEa1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzoA7pWFRqZo3+kLHHjz+ssKp/RiGsMuHHshYhRJKvE=;
	b=JwTTFelexQEY6dD2SMD95G4CbrncDUhfkUr1q0ctphyY/8ykQWlSVIhaDjNNSwh4IWaiFY
	98D1eArV2lQOHaPowjNU2wR1d3IRzwzZf+sEMyg02y70YjptsNbmrMFCSps3wfemf0uiQV
	nKk66UkARWvZMlJ/PvyAsQwudG0EFPxPPdN11iCkP5TR6Ng0WFJckD4N5SCw2PggQNjL7w
	fNVRJ62eaxeuy/f5j92E0EXcIUP1edLXmVH2OupzaO0/I1o8qbEL2gWB8WLnVwMn90lv8K
	Duko7RE1aYLxJDRpsF/0iEpHP/XnIfmt8XghjLgEEMWFlSPEH+uPRoaU3jTQOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzoA7pWFRqZo3+kLHHjz+ssKp/RiGsMuHHshYhRJKvE=;
	b=Q6uMAEa1RH/Ft7ZT1bj8d7jqZfTUYLkNqFqybsy6FrUS+n8gGbiP4x+iCYgYp2nOiU5tT0
	sV7toGruPagny9CQ==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/ts4800: Drop unused module alias
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013095428.12369-4-johan@kernel.org>
References: <20251013095428.12369-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060828632.709179.17615276236314705985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     be4130bcbff173d74bd0b431a711e971b7533c28
Gitweb:        https://git.kernel.org/tip/be4130bcbff173d74bd0b431a711e971b75=
33c28
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:34:24 +02:00

irqchip/ts4800: Drop unused module alias

The driver has never supported anything but OF probing so drop the
unused platform alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-ts4800.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 1e236d5..2e4013c 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -165,4 +165,3 @@ module_platform_driver(ts4800_ic_driver);
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
 MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:ts4800_irqc");

