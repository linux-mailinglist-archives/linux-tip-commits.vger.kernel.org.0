Return-Path: <linux-tip-commits+bounces-1501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CDB913D61
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0D71C20699
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB291184104;
	Sun, 23 Jun 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Gb31Q8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JkFBR9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514461836ED;
	Sun, 23 Jun 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165135; cv=none; b=pVv5bw0ExmEixTW4EgGvr3In3pDOKhlPAkeHmYaM3WDC2paBpXRNYO5smx+8MZpsKPHjg/af5fyucpGWdf/Y3ZXDyGThpvM+yYX47oMWKZcXmGrSRYqQA45R1YaD0B2oCFnOCUwt25e8T0SietHX/K63o/DeUY07Qmg9Ogq1K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165135; c=relaxed/simple;
	bh=e2mM4CErf7iHpLsDQVz4iGZYKBESr6rk1wC2YTXn+Dk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZYIgHsdeH1Xi2gwVNTs5ah0VHz7z2eD8ybCzINVtZBfRqf4Ch9Du75SWSSTNeFtSID9YqCLwakRtKlhf0czMojk/hQzB/AO7CuVTS6+7AmyycbNVvTg0sDNTD/fRjtH0buGiaTbdohanaaTwQJGoDysnZ1tvAqem+vvYB2txq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Gb31Q8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JkFBR9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:52:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cFZmYDZe6PI7DyztX7kdDuYgM2t9OLNEcKwrURwwgQ=;
	b=0Gb31Q8iCkqYi9ugfHkvH8Iitr1WxtN3vgCCDn8JDZIFB0z4102Eza6bVE5WMdkYzS8Pe8
	rk2PJDO4lxScznHL85ZqmvcjwHb9HUhHNswsxd4CyNcWkqFaFZk1WdsmtMqGIgIRv1gL+4
	A+ih21SO9A6k7gaAkXThPoWoO3/9pVxhxl5I9j0JzTVQZTMRR4qjriBtW+gaKxLAOHIRdv
	ObwzoJJiCYkCQxOl6HeCDwVubCFmBnV1QaGWuNyJgPCSM+73KxhjIqZpWz2W/veNJIYcZm
	joc6FbDyvX2QyNT+RrbwJbwmyy7Z+PI7PzPYLrHngmnc1TmRqNHBpoOCke6AxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cFZmYDZe6PI7DyztX7kdDuYgM2t9OLNEcKwrURwwgQ=;
	b=2JkFBR9GH0NljE1SNfIZE2PX00KoowWZjKhZDnax6D2wAmbxRgD3ahBAgZ8CFeuTo6kHFq
	1+6+MjO/IxvDpXAw==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Add CONFIG_STM32MP_EXTI
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-2-antonio.borneo@foss.st.com>
References: <20240620083115.204362-2-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916513237.10875.12228947048653235201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b20cf2dcbe8b77afb4fcbe7af9349dfca6b7f22a
Gitweb:        https://git.kernel.org/tip/b20cf2dcbe8b77afb4fcbe7af9349dfca6b7f22a
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:49:44 +02:00

irqchip/stm32-exti: Add CONFIG_STM32MP_EXTI

To guarantee bisect-ability during the split of stm32-exti in MCU and MPU
code, introduce CONFIG_STM32MP_EXTI.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-2-antonio.borneo@foss.st.com

---
 drivers/irqchip/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index aaf8453..bc5e191 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -404,6 +404,10 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
 
+config STM32MP_EXTI
+	bool
+	select STM32_EXTI
+
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN

