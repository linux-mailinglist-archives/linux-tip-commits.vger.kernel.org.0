Return-Path: <linux-tip-commits+bounces-1708-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7179351A7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC60B22810
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28317145355;
	Thu, 18 Jul 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1mSkEO3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJbUgG0m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0858AD0;
	Thu, 18 Jul 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327941; cv=none; b=M+sVACzmN6/8jnXceAxkcopEupAluF5xnuYsrevgd9c+T0+Cu2x5/ZktFh3EMhNn86L5LdD/ci0GyBL+cp0Gy+Rz3+t0srWKWlC07Mi7CObmUIB+hleennYFgfW7pBi+fatyeYXWYrSpdIE3XO5j7bYvUTxyUImVxXc2GJHXYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327941; c=relaxed/simple;
	bh=lBuRP3MpDj7GfMRKmcbymyzbol94PhzpOttSm/R16BE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MM34jv+XE8kiVAikbGVQFWsHPAcNvsUlXoe1UhdtQnPh9lrvnQRfTsIfC/eu+ZHXYBWMEujcaa9YAIKNvvKCk07f5w6Xwxn2oWDCK9vX6Eh+ZO5WyhNXTo0HnUp1IYemCs21yixCDsF8nqlfHmri0n9ScCQMmwVeLD5raOp3kcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1mSkEO3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJbUgG0m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MqsjHjIG8UD8MefbDglixV5nOKmKxslTAMdMazVIrE=;
	b=I1mSkEO3rVjUDONeqsR1Fx9ofAGOiHvxxiAuSWTMj0JY2vxfFhysPdDF0Z3hS7aeSw83tW
	bgG0KYA1klup/fa1gaHl1QjPf9XwsDF5wf725w1t+F27bFdAciFRC1gdu2AMmKLn5rfJr3
	8mzpEE6SDmReEZ+wXw3l9YyCXYD49nwdLYQAJBVAn+BWB+JNCWvAo878sj1oXyZh3EY597
	JipSaGLlmmDQUXbXSFAZRg/zgy2JycW8DM8V9imVsLDd15oIa8ry5Rt+Exa2OnWTK5aA8P
	lxt2uv+EqVATwq28jtKakxOPJAIzsQZrPf+h60qe3XtlY7fTnRcRj/5lYymYHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MqsjHjIG8UD8MefbDglixV5nOKmKxslTAMdMazVIrE=;
	b=wJbUgG0mkhQ5T9QeYYjIMPgj+xMHFwCuoH2kclvxdRT3xHnGFVSegbLmYw9zmtWvckVJ3t
	IuqZzM/+bJWp4nAw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3-its: Correctly honor the RID remapping
Cc: Johan Hovold <johan@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Johan Hovold <johan+linaro@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240717195937.2240400-1-maz@kernel.org>
References: <20240717195937.2240400-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793752.2215.6199495516523204124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     99d7fbf8f813eb77dd4ec148c4596455910b2fa1
Gitweb:        https://git.kernel.org/tip/99d7fbf8f813eb77dd4ec148c4596455910b2fa1
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 17 Jul 2024 20:59:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:34:46 +02:00

irqchip/gic-v3-its: Correctly honor the RID remapping

Since 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]"), the primary domain a PCI device allocates its interrupts
from is the one that is directly attached to the device itself.

By virtue of being a PCI device, it has no OF node.

This domain is (through more layer than it is worth describing)
passed to its_pci_msi_prepare(), which tries to compute the
full RID that is presented to the ITS by the device. This is ultimately
done by calling pci_msi_domain_get_msi_rid(), passing both the
domain and the PCI device as arguments.

The baked-in assumption is that either the domain that is passed
to pci_msi_domain_get_msi_rid() describes an interrupt controller
with either an OF node or an entry in an ACPI IORT table.
In this case, it is *neither*. This domain is does not represent
anything firmware-based, but just an allocation unit for the device.

As a result, it fails to provide the full RID (which requires inspecting
the msi-map/msi-mask properties in the DT), and stick to the BDF, which
isn't very useful.

Tragedy follows with a litany of devices that randomly die as they fail to
see any MSI (because the RID is wrong) or fail to get an allocation
(because they try to steal LPIs from their neighbour's pool).

This will happen on any system where a single ITS is shared by multiple
root ports and end-points with overlapping BDF numbers, and has the
topology described in the device-tree.  Simpler DT topologies will luckily
work, and so will ACPI-based systems.

Solve it by pointing pci_msi_domain_get_msi_rid() at the *parent* domain,
which is the ITS, resulting in a correct mapping and a restored happiness
in my personal zoo.

Fixes: 6adb35ff43a16 ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240717195937.2240400-1-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 780e1bc..2f3fc59 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -65,7 +65,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	}
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
 
 	/*
 	 * @domain->msi_domain_info->hwsize contains the size of the

