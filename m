Return-Path: <linux-tip-commits+bounces-5111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B61AA9ADBA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF62D5A4B55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAF27A926;
	Thu, 24 Apr 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqOX2bLW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLES6g2y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164127B4F1;
	Thu, 24 Apr 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498399; cv=none; b=SoK0v//hYYPqdONzmVquUFLb5Q7UQK1iObSpyrXTh8ZT4CF/Bf2wU7APNSYepsXX8DlyoFFWsL66/ZE7aFqeFwmoxLjZLiwkyeIJyJIyK99Rwu595dgZqTUc4ftYPfXD59j65WHbgw0gVyvfDKyNhHkaEtlTz5X2iLo7Jw53mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498399; c=relaxed/simple;
	bh=GL49SwagciBhjZAgGvJsSCEwYTAcOPyR2cVZwCzteR4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZ0uNy0p0HL78OpR1eGrecJN+leqXLUwtBSnhLElxfTkIb7KvbBs6+cjpTMQcSNQs6GLMZm3z0jEUJ50wrYnvCJdSpg65+5AV+oEU2zzh7IzsUDeS16BTbM5dPZjCVBhmhkUoqUrtbZt6Or2ldshLRDsW3patzL7ggMAjbjoygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqOX2bLW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLES6g2y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 12:39:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745498395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4K2QztoPtPnIxSPMSBlWDGSgEtOt16Y2wtVdjYyRAk=;
	b=VqOX2bLW8057P6wf1BREb1CndzVE/O2xfzitVrfUoHn3zh0ONqLHQqOaDg2CxtG3dd9cGQ
	guA8CnMxEn3isHjkmW3ZIGhjBJBogB/DC0Rg+xwAFiEh7q01ao9q6OnGYkSUGFb2dgmYG5
	M3VykSLgjTP4UqAQBzD1cDjonJzJ5VroYpN8IcLR5jS5+gGH7PDEdDXeU2EoV9mcdtQ1tG
	xqXPrKb1hCvNl6sIPMCqfnRohMAOZP3IUlOPoXkcqFo2xo3/gapybzZG+CbvHY2BCOasS4
	ZrsFw3UjmQmmYJZ9ur1mUV6PYWke2FmaDe6UHJUBKBm7F9X24SEsuPP2SJZUvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745498395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4K2QztoPtPnIxSPMSBlWDGSgEtOt16Y2wtVdjYyRAk=;
	b=xLES6g2yF0e9hvEkdFLxtoGWoK4XfA7KBON/Ox6lC+scssGv2BtskYE7Y7jZ93enVHcTEO
	g71PkBa54DR7fPBA==
From: "tip-bot2 for Suzuki K Poulose" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v2m: Prevent use after free of
 gicv2m_get_fwnode()
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 linux-stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174549839417.31282.16646755501789289739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     be5413232123b7700df856cbfd20cfa528b4f132
Gitweb:        https://git.kernel.org/tip/be5413232123b7700df856cbfd20cfa528b4f132
Author:        Suzuki K Poulose <suzuki.poulose@arm.com>
AuthorDate:    Tue, 22 Apr 2025 17:16:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 14:28:52 +02:00

irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()

With ACPI in place, gicv2m_get_fwnode() is registered with the pci
subsystem as pci_msi_get_fwnode_cb(), which may get invoked at runtime
during a PCI host bridge probe. But, the call back is wrongly marked as
__init, causing it to be freed, while being registered with the PCI
subsystem and could trigger:

 Unable to handle kernel paging request at virtual address ffff8000816c0400
  gicv2m_get_fwnode+0x0/0x58 (P)
  pci_set_bus_msi_domain+0x74/0x88
  pci_register_host_bridge+0x194/0x548

This is easily reproducible on a Juno board with ACPI boot.

Retain the function for later use. 

Fixes: 0644b3daca28 ("irqchip/gic-v2m: acpi: Introducing GICv2m ACPI support")
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: linux-stable@vger.kernel.org
Link: https://lkml.kernel.org/all/20250422161616.1584405-1-suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/68053cf43bb54_7205294cc@dwillia2-xfh.jf.intel.com.notmuch
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c698948..dc98c39 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
 
-static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
 

