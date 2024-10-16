Return-Path: <linux-tip-commits+bounces-2479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014379A1342
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AAC1F22B6D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A262194B6;
	Wed, 16 Oct 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atMWhmKE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NV9vs+Du"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFD218D72;
	Wed, 16 Oct 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109059; cv=none; b=onlbm80bve5yuTNCjsFfb13ZOxpqc420xCCSLFibMOux7XwEaAIGurJJM+X4TBmR/RPZpIK5uZxqxge154SpcsUV2pPKspAT2DXUMsi+knTlg/wpUX0/lCJkCPNBd0SDHT+C1bWAfHkkDk5borL0rTs6sUMmWYqPBGFBbmX1+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109059; c=relaxed/simple;
	bh=KwTkPtdnDxV0gQEeM6aBxrHpjjm9RYJvmVapgORiyKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H8aa03U7a265HEvLcOOGLmutbjyu76FxQY4QkGreQXA/h/rYKt6JN+c3LP6ZXsrw9DzV5Bd5vc0l06D+vEtbKxY6iZjIzUFS3B0C4H0sO4Vxv339L2Rc7lINNEa+ZMWEFta/ALE1wfxfRY/mYdFR29/NDxKJBRk7g8T8IPa5Ucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atMWhmKE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NV9vs+Du; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldkO620Vu36q5Xa3bwJlw8FYPrEv3B2KpPamEIIEc0Y=;
	b=atMWhmKEgVT0zOVuHgbcHWauzIjIofb+O/IfgYBnZh7ZXb0PXrw+jwKRPSNrO+S1O+DUJ4
	7eOm5FGA/tRfLqHlbVReHOxTvNhxubpfLjA+wJ0eoSJeox5DaD7YXV6DWlRoCfHKY5N9Qi
	jGU1bwu7iLZE1XH33H/Xcr4f3N9sn/xcWd4Nw4VQ1qKNKD+ZspR0npB/YQyUfli0BiBS+I
	Se7++Tulg15sNPfwot0NQSCFIcdsmg/6HgxDQ9dZcx5aCn59udxuifSOpKFjv9MYHDQp1T
	9GZRlgkznh4tEf/81QFT/yKOj4fE3fz4riuThV3YFqDUBeXUPoy6AO9qyqpLWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldkO620Vu36q5Xa3bwJlw8FYPrEv3B2KpPamEIIEc0Y=;
	b=NV9vs+Du67j1OWx78Fkp7HuWyS44xUaqRi9S6gDTOQh+PVcF7Oc1pIHcUS6dDzixpYCx60
	oOohCOk44gvuADDg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: 8250: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-14-bvanassche@acm.org>
References: <20241015190953.1266194-14-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905551.1442.17551363569123856233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4846c4c17e292537d4fedd9995432d3a0d78d355
Gitweb:        https://git.kernel.org/tip/4846c4c17e292537d4fedd9995432d3a0d78d355
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:44 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: 8250: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-14-bvanassche@acm.org

---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7..0b886c0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3176,7 +3176,7 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 static int
 serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq >= nr_irqs || ser->irq < 0 ||
+	if (ser->irq >= irq_get_nr_irqs() || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
 	    ser->type >= ARRAY_SIZE(uart_config) || ser->type == PORT_CIRRUS ||
 	    ser->type == PORT_STARTECH)

