Return-Path: <linux-tip-commits+bounces-2488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A37A9A135B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77F3B2408A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF615C145;
	Wed, 16 Oct 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdHYBAMD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYyyb4Vb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238221BB09;
	Wed, 16 Oct 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109071; cv=none; b=V/mO/kwf22ukRDhHSyeoUOwrIfebWDwIbPfydAMFvPxwvC2Sq0RULg1NslHJmBfSX0Ci6LiqVlWLGteW/7a+CBdNO5CrNI2w5Wga1DHCB3oGdZDRlcH8EiHnu0ZJc3KGrkeqHDiDjrRJyT9ErqxlTKJFkeJ2pxm6MB1Q8MWO1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109071; c=relaxed/simple;
	bh=zN4LofzE6D4OmaRrofzM3m2aZSr+/Dq7FI2CyyIHJrU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S8mdTqNHdZWr14t/hSG/JE88ky1Y0uYC5f/TeCJAHQJGIzM5m9I5MnQgnYght00EIxclcnaWC8UyWhQIYSSTuNabVs01gCMDNPqwqMglM18WyLdcAG9jOK0P1lDw8b2RVOnhVbINCRhLSsIT+39XnPUMM6D8mpFMkHq57OUnKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdHYBAMD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oYyyb4Vb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWeXvIaB8VSE1wPEtJwGtDFf3TeITbZ55tGu/LY4w+k=;
	b=MdHYBAMDsfHJDvcGnrW9sxAGmru+I7kxXegjAzkBibmGasQmlaTxTHyM5rCMYI2Mkv3AHT
	5qjdcKYF9b7g3AkMxy5JxAqgUrHNSwyriagImwyaATIxYVpFS1fP690PziunUc2uBI6dxN
	KWmQ3s+tJX2cLZzB1rCagJ/0R5FGzIDbz437JLm0C39MWnWJ5iVA4SHr167WRbDo8FrnVV
	n0VjfSEKndz19XMArbHj6hkx3YPu5yku7veisJpSCC8WF7kCiCc8kC97UHnRqn9/iu/0N5
	0CPOAjC005pHQGOcV+HaiF+21rNvSGxomH1JIbeB6vXXyfPKI4Eox0VJMVk0zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWeXvIaB8VSE1wPEtJwGtDFf3TeITbZ55tGu/LY4w+k=;
	b=oYyyb4VbZPG29bca0grlMKtVRaOGKZ462URgw8g1UiYssmijJKrH+HGr2zlKj1Lnpvn+eD
	N39wQXigPBQ+eBDw==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] powerpc/cell: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-5-bvanassche@acm.org>
References: <20241015190953.1266194-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906652.1442.13497502050034747567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     29f42eb1a3cbaa48c6fae1e36d97162e1f6ab1ae
Gitweb:        https://git.kernel.org/tip/29f42eb1a3cbaa48c6fae1e36d97162e1f6ab1ae
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:35 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

powerpc/cell: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Link: https://lore.kernel.org/all/20241015190953.1266194-5-bvanassche@acm.org

---
 arch/powerpc/platforms/cell/axon_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 28dc867..d243f7f 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
 
-		if (msi < nr_irqs && irq_get_chip_data(msi) == msic) {
+		if (msi < irq_get_nr_irqs() && irq_get_chip_data(msi) == msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
 		} else {

