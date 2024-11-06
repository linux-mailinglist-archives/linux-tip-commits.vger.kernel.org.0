Return-Path: <linux-tip-commits+bounces-2777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496159BFA2E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 00:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0115A1F2298F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 23:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95B20EA45;
	Wed,  6 Nov 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+EQEWG0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afE2eUG5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152F20E300;
	Wed,  6 Nov 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935959; cv=none; b=pf35yK7NvBRmzYwcAenn3rqg778dlrDfgPmpw0s6vai/+J3CLkDfLc7fG6YFFX8Qqt33qwZRJX41zMKEOCWdF85IdJWDTyaM/5umFnQXSlxzo9qwpFoqetl1ibcHZndqRuON+nm8lQUJYRyQt3eeExyC0C/vXUZr7bUhOQK4Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935959; c=relaxed/simple;
	bh=N0ydhhhTa63TcwdGPvBLgh+oFLOzdUS7RQWfM4V6oSs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jtdoKjZKYc8dQjKzrsthBZa9/WTB68QEEJnyBIxUGgcd/r1cXHP41Ab2Hm2aTmOoDcsMF0aMXgwv/E7fGtXSX+KB4dnUIw0RDj8Chritn11ISYHXqSJFNV7xoNuxTgoQtj/7GRaFK9niCSzIw0unf44xQGkiKTP6XWq/CnF5p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+EQEWG0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afE2eUG5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 23:32:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730935955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qYwLiUBXP7fJloTjL1/S71LfajgiT1co6mlZ/kPa60=;
	b=O+EQEWG0zCBuAYUMdRjLxuvvAiQF0g8ioSNGeBBRiVrLaLfyuC/+gIEDexZrcjBuf+Sw0F
	WnKD9PrdpjlK2d+z4V7QKt7XoesZ1zevsK27Jzk//t68zqs5sjvDNRCOxkKc2ky1nGnnF6
	bvDfsSMltXJbo424KwJbgWOvnCR/E+zQKd4LgHftNvwA+UkySofTFJ7EaAfSpJQ0I+e0kr
	8osRTxmw5Yq/87iA3GK+sR4VQNgwa0+LCUne5QmWOf/3viso0ZDKEDZRhJoLBpAbM33VLH
	AaGUmvNCPcjaFBOxvyLFSzUxrZND4Bk6Ti6i0ldzoXNNqjwmn49ygC6DBNZ2Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730935955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qYwLiUBXP7fJloTjL1/S71LfajgiT1co6mlZ/kPa60=;
	b=afE2eUG5Iy8nwjI0g8p9M75AyBTY1lp8IW3W29muHP+xiObkwo4om50XDQ1tLqwyEzQZik
	9MKbufoajlBaT1Cw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32mp-exti: Use of_property_present() for
 non-boolean properties
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Antonio Borneo <antonio.borneo@foss.st.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241104190836.278117-1-robh@kernel.org>
References: <20241104190836.278117-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173093595473.32228.9171432732512120363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     194c4f569eac889d9b0822bc001771683b6e9b8a
Gitweb:        https://git.kernel.org/tip/194c4f569eac889d9b0822bc001771683b6e9b8a
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 04 Nov 2024 13:08:35 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 00:23:59 +01:00

irqchip/stm32mp-exti: Use of_property_present() for non-boolean properties

The use of of_property_read_bool() for non-boolean properties is deprecated
in favor of of_property_present() when testing for property presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Link: https://lore.kernel.org/all/20241104190836.278117-1-robh@kernel.org
---
 drivers/irqchip/irq-stm32mp-exti.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 33e0cfd..cb83d6c 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -696,8 +696,7 @@ static int stm32mp_exti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc = true;
+	host_data->dt_has_irqs_desc = of_property_present(np, "interrupts-extended");
 
 	return 0;
 }

