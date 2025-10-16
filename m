Return-Path: <linux-tip-commits+bounces-6951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143EBBE527D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59B65E1CF5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD024729A;
	Thu, 16 Oct 2025 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/IW1+NO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3t7+G60j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37723EA9F;
	Thu, 16 Oct 2025 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641290; cv=none; b=mkY4cDCNL9jLqeAZVXVsXX5bbthdmJrt6bnsx4g0g6m+wc6nN2wllUMfaAwv2kGfYR/EY7ee3ZdzYcaBLjLhZCJGnY0Bx73m2Mf7m0+7swQ5ObQFTF7wGENb/jmgPK6vvUsTVyXCunKcIQmvILoxxoz8o26lMt/Cebd2pD9sgIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641290; c=relaxed/simple;
	bh=qyvAK/90NaVQqHvO42QBzyzphYwggzJWKWBaiviZZyw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EE3lFQHZTQsEj2+U4co5M/jLA1ZvFFQlOTeEXjX6BKf26M7Xvb18y+z2EN0482lss3IOZCNIRyQXNsBQoFxOgAu+xzaMXI/oubsrFAOgBsgVzmBO/wTzPr0d31Xx9bzL7WH0XsSD2f9yRURt/JT02LPr/uH0iLAESAWDlivaRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/IW1+NO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3t7+G60j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR5EadgsmzlBKy6IaeDcJJQ6AGCaVLQ3Z8QKfLG5dFg=;
	b=K/IW1+NOWghqdOebF0wRZ6QnwcMNu/A3iX0SSrod104gLPoxifjpwYyGk579Dq+exFmW26
	h72pc/y/dxM1O20I9Bay+ZZsbk9CGAzEtlPVptGoZu83GjSZxUEModUwUNihXSCNWeQkVI
	2ebJtYp/L4PReM9PQz6YxwBRJ94IzaLCkSWCKR1b55al7Qg50HaS9o88s6xqkEmHQorGTB
	vqI1etYRVz8CjhxO1XPt9QwKDzbiD5WmMU9C7xoykN0fySJQSS+nTOuusfAa8kueYpDZhx
	S7gXMFcC5GCGs145RrvuKk3tbXOr7vamVtkTb6zvjosKLWdC3LYhxz2/jGaQ1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR5EadgsmzlBKy6IaeDcJJQ6AGCaVLQ3Z8QKfLG5dFg=;
	b=3t7+G60joolU+y9Y94avZ7VzofR7+CKzPXUlprg9vi3EweTD66VlpkINu7Qss9rByKqAjB
	VnhyLbC/TyP/L2Cw==
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
Message-ID: <176064128524.709179.9174028993993013969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     dcc31768ffc1571407cf9b52f96f0505b0573450
Gitweb:        https://git.kernel.org/tip/dcc31768ffc1571407cf9b52f96f0505b05=
73450
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:28 +02:00

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

