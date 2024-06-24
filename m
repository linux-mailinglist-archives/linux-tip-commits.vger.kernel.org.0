Return-Path: <linux-tip-commits+bounces-1529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F939155B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D074D1F24A54
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AC19F48F;
	Mon, 24 Jun 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDM2Jspw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wesa3uEa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCE19F465;
	Mon, 24 Jun 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251264; cv=none; b=m+y6cGMKt43oO69ZFRdtrTsBAz3lgsjfWe6a8r5RdxcxQPLUNOKgkMg4zU30V5cK5kU8R47I9BFL3tnQb/XRVu34PwI9qk9evj4ePOZaySJ87HXbJBm2HnS8vZxsVli+9kPWi9zQxrJKDPesQl52XY4qVuG5uene4BMUZCw3WD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251264; c=relaxed/simple;
	bh=seDAKuzcLk1SH9DDQY09RR+dH1O5h8S5K9GfcpPYkKk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MgiDQtlnr0LjfHA49xHB/+nmeYLYuULlhJY2MJqlYU0ynjQAmZCXfXxUaluGUYHSM8T/V9Rnqqf/Xkb6AlrMWpIMtIotXa9ACcjeOfT4IsOlHxRT3XJkqTEwymH+kbIbOUT5cUVXAT2NMiC3skLmlE1kOylK9qHCO2ECFxOIHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wDM2Jspw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wesa3uEa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719251261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw+8GWsjGAoBn6IvCDcr1pSQrz569kRqaDGDPqNVBMU=;
	b=wDM2JspwQEHBOIKPmxTiDBc13SOyziKpjdvce+UDAaKRKJIlYaoFWsy0iZiqyBjRn7u+/U
	loY79JQzeCdbx8rVQyqb8XuxapYpa1sp+xOgbzm0qf6Q9zPnPruhuIEMHYXbk5Y/DGDHt6
	5CJCzymNss5VtLLMMBGui0lS7pfcVH4Wi7Byl+okaPU3f/fbVShtqMirSj1qTz9EHq8X5B
	hdswGcVXDNv4Z2lKnXYafm02EKBCkbK/XW0fl+G4i9qRxFkU3JGL1ir5TJTYNCtgUlC0mE
	mQMr6/BXTH8lTYRWl4+XL7FbMS3C0/TC1sYnpPITIwvDJLQGg+PxTxFI9bssZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719251261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw+8GWsjGAoBn6IvCDcr1pSQrz569kRqaDGDPqNVBMU=;
	b=wesa3uEa9fNb13VWt3LiYNIEDTNLIiocv6kImIDLERC5kaRpPNkdHfPIlga0rqpPv8wsBU
	FP1nZraCFtdnDVCA==
From: tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/of: Return consistent error type from
 x86_of_pci_irq_enable()
Cc: ilpo.jarvinen@linux.intel.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171925126074.10875.11836124024843551283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ec0b4c4d45cf7cf9a6c9626a494a89cb1ae7c645
Gitweb:        https://git.kernel.org/tip/ec0b4c4d45cf7cf9a6c9626a494a89cb1ae=
7c645
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Mon, 27 May 2024 15:55:35 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 19:11:31 +02:00

x86/of: Return consistent error type from x86_of_pci_irq_enable()

x86_of_pci_irq_enable() returns PCIBIOS_* code received from
pci_read_config_byte() directly and also -EINVAL which are not
compatible error types. x86_of_pci_irq_enable() is used as
(*pcibios_enable_irq) function which should not return PCIBIOS_* codes.

Convert the PCIBIOS_* return code from pci_read_config_byte() into
normal errno using pcibios_err_to_errno().

Fixes: 96e0a0797eba ("x86: dtb: Add support for PCI devices backed by dtb nod=
es")
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240527125538.13620-1-ilpo.jarvinen@linux.in=
tel.com
---
 arch/x86/kernel/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 8e3c53b..6428087 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -83,7 +83,7 @@ static int x86_of_pci_irq_enable(struct pci_dev *dev)
=20
 	ret =3D pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 	if (!pin)
 		return 0;
=20

