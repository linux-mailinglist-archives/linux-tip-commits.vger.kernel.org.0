Return-Path: <linux-tip-commits+bounces-2312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A785898D43A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690B62844BC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7B1D017F;
	Wed,  2 Oct 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeJKP3qA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gkRB9o8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3781CFEAB;
	Wed,  2 Oct 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874816; cv=none; b=Qt5wKTt/nnXWBTbCesJJHMpF21qvSINjjISfq5AJWMr2PSkGK+fgP27p45gF1K81y9dD5i0vxe+Yb7vul5ijEB3BmwRl5g7dbtywrBshitqp9qkKD1fwdBwyEjH7nlAWVBi8ogN+ABTUEOXNtMLvm6Zm5pnzPTGM24KJvdG1ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874816; c=relaxed/simple;
	bh=eQu3QaokPVieoTG3wbxL72lRG9xLfxPMesgGKSM50Xw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rO8yU8ai/E02ByHQSA3hkBFBtUvl5OOH4furImV2S0ENVLHL0aTIExXKbVEGlmVhzan+dvk9Jcfmb2SNUo5AwG8CU1RbWbEU9g1y9KWr+ORX9k22YuBWzpbyPkXern/HPMYDJbPTUvnQoC7IhYLtcv66cggnkUCfjQvfv8QdIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeJKP3qA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gkRB9o8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 13:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727874812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcojQkizUD9lLgP/g1aB0OMmtcc0IpXoIvKtqWaiBVs=;
	b=YeJKP3qACNEcLVcwGV9xo1KPgZY+XGbIxn/3oNvW6lnm2WlNdB0ZstaobKnlLcjmtPMN9k
	AXv4YcTw9N+11PPcb28LvGeWtV7DmnD6qsoY7M9gR+DqV0ZFNo+q+Ux80JzNNjLEL639Ar
	NDSc4cvTPBGBPFAeOAINbdy96enMppqhXoaEtMFbyQ+teMmB3DBohJVsT4EuQHELZXK/D1
	E/yID/lijbRr0snqajrAubuOI8LrUOJKfWX+Zt2kcCy0s6zYlt/U7rN93ewsess6n3NG0k
	Puz1yoCIxHVi/6ez/ex0B3UQSwuEl8eLtMgY1B5MNvVp893pdVcs6wXhYgarYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727874812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcojQkizUD9lLgP/g1aB0OMmtcc0IpXoIvKtqWaiBVs=;
	b=2gkRB9o8hfLPdV5dscENKFwymeTM7bLF6XmLz2K5iH4g7epHSbGuiTOvg1qu8OBzfLavKo
	huV1IduptX2eUJAg==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Remove obsolete config ARM_GIC_V3_ITS_PCI
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240926125502.363364-1-lukas.bulwahn@redhat.com>
References: <20240926125502.363364-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172787481077.390.6867959419187258610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5fd7e1ee09afd1546b92615123d718ad6c8c5baf
Gitweb:        https://git.kernel.org/tip/5fd7e1ee09afd1546b92615123d718ad6c8c5baf
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Thu, 26 Sep 2024 14:55:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:08:12 +02:00

irqchip: Remove obsolete config ARM_GIC_V3_ITS_PCI

Commit b5712bf89b4b ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]") moves the functionality of irq-gic-v3-its-pci-msi.c into
irq-gic-v3-its-msi-parent.c, and drops the former file.

With that, the config option ARM_GIC_V3_ITS_PCI is obsolete, but the
definition of that config was not removed in the commit above.

Remove this obsolete config ARM_GIC_V3_ITS_PCI.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240926125502.363364-1-lukas.bulwahn@redhat.com

---
 drivers/irqchip/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9c..d82bcab 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -45,13 +45,6 @@ config ARM_GIC_V3_ITS
 	select IRQ_MSI_LIB
 	default ARM_GIC_V3
 
-config ARM_GIC_V3_ITS_PCI
-	bool
-	depends on ARM_GIC_V3_ITS
-	depends on PCI
-	depends on PCI_MSI
-	default ARM_GIC_V3_ITS
-
 config ARM_GIC_V3_ITS_FSL_MC
 	bool
 	depends on ARM_GIC_V3_ITS

