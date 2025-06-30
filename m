Return-Path: <linux-tip-commits+bounces-5944-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52795AEE1D3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4147A1A45
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F628C027;
	Mon, 30 Jun 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eBtbQX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/fOs+NUA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391726290;
	Mon, 30 Jun 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295831; cv=none; b=EWAZUBs0XkA4YL89ykBzphwu33lJnQgpHK5m47kYhMZUXFfXnKcIm5zbifdhSeL/oi0nbEXqP8vDRGgIG79bjGJIb4Hwbp5W3yVm13/doIRJQjiDR/wsJJPOoRdQKKQf+M3xs7m+9lWzKllUWSamoKuif95bZqZlxWsUeBBeg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295831; c=relaxed/simple;
	bh=XkHcS2HIGHdTVzvxKv7AhHFxeGBXmDVmlspzw6lsiMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aMSyaJ8nzSKzaEos5N+FDxgCl6pc2ojeeNSutTdd3tvTFpiSlG3pmxRWqHk7oJnx1Suo41vt5v6F17SgtrhuPb/E3tPiBqO/I1WrtiSV6T2+IzAU7ZtzdsFwxEQw1/v/bWIhJMnpxjiE3IVQBJeTls1B5XHRzDN8pWY7NxLAtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eBtbQX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/fOs+NUA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZkdo2GA6m/ViRvGmYOZl5tqGIVLnzBe+vlTs3iLtXs=;
	b=0eBtbQX6/f3CyySLejROoLYS8PL/wEtaKIOJ0YHuDCScDp6VR8cpSJJIU+iCgHDZ69Gkwo
	PVGOLGs5Vif/WIqmq8fMGXcaUGHE97zm8V8YAjxhI8gS1NpHpetxnVMNFcAn5u8C1o6mvQ
	GRhC9Wp2VrWe5gb05bIiIaaPWvzWrj9e3tciyGNsOD5BvnJYveuSJSscpfx0GUVPcSa03K
	noEU57WT1bXXL6oWlxNfH0NBOSzlOSajBx9tIqi3eCs15qBauoR5hXFwv2dJwTxKenqp6W
	YKi/ix7PupaGKQjcWcEH/HzYsYj1QUc/78/wxCkSDmg6MFrug/2T4qN+5CGxng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZkdo2GA6m/ViRvGmYOZl5tqGIVLnzBe+vlTs3iLtXs=;
	b=/fOs+NUAreUgjTkMuxEQdZfiGcrE8u9r5jvL3Qe2aDGVXu9lHoOcDBiqoktG9vENzLuj8p
	ir3HPCQJwbwTmKCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ
Cc: kernel test robot <lkp@intel.com>, Nam Cao <namcao@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cb0c44007f3b7e062228349a2395f8d850050db33=2E17512?=
 =?utf-8?q?77765=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cb0c44007f3b7e062228349a2395f8d850050db33=2E175127?=
 =?utf-8?q?7765=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129582703.406.8111219480420630156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     eb2c93e7028b4c9fe4761734d65ee40712d1c242
Gitweb:        https://git.kernel.org/tip/eb2c93e7028b4c9fe4761734d65ee40712d1c242
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 30 Jun 2025 12:26:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 30 Jun 2025 16:59:12 +02:00

irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ

irq-msi-lib directly uses struct msi_domain_info and more things which are
only available when CONFIG_GENERIC_MSI_IRQ=y.

However, there is no dependency specified and CONFIG_IRQ_MSI_LIB can be
enabled without CONFIG_GENERIC_MSI_IRQ, which causes the kernel build fail.

Make IRQ_MSI_LIB select GENEREIC_MSI_IRQ to prevent that.

Fixes: 72e257c6f058 ("irqchip: Provide irq-msi-lib")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/b0c44007f3b7e062228349a2395f8d850050db33.1751277765.git.namcao@linutronix.de
Closes: https://lore.kernel.org/oe-kbuild-all/202506282256.cHlEHrdc-lkp@intel.com/
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e4..c3928ef 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -74,6 +74,7 @@ config ARM_VIC_NR
 
 config IRQ_MSI_LIB
 	bool
+	select GENERIC_MSI_IRQ
 
 config ARMADA_370_XP_IRQ
 	bool

