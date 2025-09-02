Return-Path: <linux-tip-commits+bounces-6418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5BB40123
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519551B285B8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653412D5410;
	Tue,  2 Sep 2025 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBSGimte";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/bqLeAN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69902D6E4C;
	Tue,  2 Sep 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817230; cv=none; b=XEDpu3/ggF2eexmI5AFO/97qthWHf9W4p+WzW0FgGF/gXKpf9wbZ2hVYREpPVtRCEg2oV91iQmw3QBFppX410IXIGssYSt0fB1MrwRF/cHciN1c4GkXoWk/u83Zfylt58WQ7DA83QNuL9X2+ObBsQ7Ol5z1lPM6sUuL6RawL6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817230; c=relaxed/simple;
	bh=5D+BEpotTbaYSdgyO333sqCd9RMOU+Soju7QcoQCavI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKdezJ2SSzOfJUM0R64y+N+Dc/Le87hX5I7+ha8jHhFkqKuLR74uhJ/awStpr/X2YuAMwp6BZYqlvEQawXxOJr8d4ZanIY9R6myw+EBkYizmojDtkrh3fmDR7ubPzTy++bvAhYXX2QW6QoT95xHY15w61HYAa30QkLZaKyOWQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBSGimte; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/bqLeAN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 12:47:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756817226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUKvXwPqSFWwxbJOuWTk6p7Nzfpt+4r72zHDEVXHZvY=;
	b=hBSGimteUaXT1rFk7eVo+QWxpLvvddHGySb+AAlPT9WcYspjib2wsCm1/Q1+2HpI26D6fD
	R5JnBdg6Ad7IMqH89o0mCXnWKKaBjE3d7qXnZ+OgJBMwUprD+TA/Fq6svf8CNbmdrmWHh/
	Kr8jI2tjBUrsXFgv0/W1Bl1ZOXR5t02bdGGvL0eC2xLBs/uxWA96Xr/LD/AoMWiBlKkg1k
	ESqbHBfQYvmxw1GVWKKSeKxiFUNQU+1TZxeUl8cUI1dkViIuLqhbDw8hgSqcoe4Nax+a2G
	zPSAXkAN8Uw4Bia7BAIsTXf3RhXH79HmCXTgrD5V+xjTXP+jS1pESjBfZSXh/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756817226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUKvXwPqSFWwxbJOuWTk6p7Nzfpt+4r72zHDEVXHZvY=;
	b=Q/bqLeANYWRJtDBQVDKf+3iLv1Ex04oAF4CcUHXWLRnxvIV6RtSQ6vmLm0zaUGkZJGXN+b
	dF0xBQ1PWRlccaCA==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>,
 Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jon Hunter <jonathanh@nvidia.com>, Chen Wang <unicorn_wang@outlook.com>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>
References: <20250827230943.17829-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175681722544.1920.17009750793019581928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     727e914bbfbbda9e6efa5cb1abe4e96a949d576f
Gitweb:        https://git.kernel.org/tip/727e914bbfbbda9e6efa5cb1abe4e96a949=
d576f
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 28 Aug 2025 07:09:42 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 02 Sep 2025 14:42:09 +02:00

PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent=
()

For MSI controllers which only support MSI_FLAG_PCI_MSI_MASK_PARENT, the
newly added callback irq_startup() and irq_shutdown() for
pci_msi[x]_template will not unmask or mask the interrupt when startup()
resp.  shutdown() is invoked. This prevents the interrupt from being
enabled resp. disabled.

Invoke irq_[un]mask_parent() in cond_[startup|shutdown]_parent(), when the
interrupt has the MSI_FLAG_PCI_MSI_MASK_PARENT flag set.

Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Wei Fang <wei.fang@nxp.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox/SG2042
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250827230943.17829-1-inochiama@gmail.com
Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
---
 drivers/pci/msi/irqdomain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e0a800f..b11b7f6 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
=20
 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		irq_chip_shutdown_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
 }
=20
 static unsigned int cond_startup_parent(struct irq_data *data)
@@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *=
data)
=20
 	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
 		return irq_chip_startup_parent(data);
+	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+
 	return 0;
 }
=20

