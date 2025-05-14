Return-Path: <linux-tip-commits+bounces-5542-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A095EAB6E24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A74C1C0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286871A0BFD;
	Wed, 14 May 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YzsFgPY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y34otpBM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8D1940A2;
	Wed, 14 May 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232876; cv=none; b=NEBTuvbtBOS6iW+CQfYG7brZg2AFAH2fQP6FPr00vpM/qHezEhzsY3B0hsGYvLML/n0nPmyE0/1q4paIMQ+tydOriNpbyL7OYcTsQiEbICOlxoKTFxjjINrOz2Kw+esfIOJ+iaGTpnJqFxSHhweVHSEQIox5fbOYm7rcOS8pdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232876; c=relaxed/simple;
	bh=D1NNY72HS48AjdGCPYfTBbVvfFGs/MdRkl9rDPLOHzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OFYNWRp9AopuhXODtldlFjm6zmYOP5KP/9s4WVKOR6R6oWsYWxOdHkw+HDZVv4OpcE7ozslGf+CeQE0Hy/IC7j10lIKA0OXnXhsfvTPQZa9zCir2fW7iBHHnWAO9oZGGm8mTLoo0l0U0kV3l0yy3ey6gB8J8A3iog5Alta8RSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1YzsFgPY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y34otpBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 14:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747232866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LT8amerTR0frbMbnJYMcNjkbRhMCJDZrMUynxGTe3WQ=;
	b=1YzsFgPYBu0bvVM1S/Hd68pYvGvxzxOV0wvEt+/gdbqnY23CGL1YKenojC6YymOrM4HEYt
	krxP5NpJpvwZXcxk3k5pc94DS3jxYCAgyuLHuP74xFmD0lyXrXAWZHuuqHADHpwxqhfhfn
	BNk8rVK9BgZ9ds/c/ZIivGS8YpwqqzRpGg3X001f+Sf/QdrGKhEadGWJUgwz5lDvD3E8k5
	+nIXfa5F8rAfi73c/PVSM2rsli53pioP9/QzzCq9v/C3vPaJf8JUEhlJo/ivshRhedxVno
	xpjqk81E1xd9OCtNyc5C4cjFPduWqRFZyklqB8u7eTRtyfIXhxdfASdfa7PZLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747232866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LT8amerTR0frbMbnJYMcNjkbRhMCJDZrMUynxGTe3WQ=;
	b=Y34otpBMcwxoG7FQzyz1K+d0+TSBqtXeDSNAxjFzOBzbeILlQT3mdVcqNTYtOugRTfZcDK
	gYc6xVh3uHJiO/Ag==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Drop MSI_CHIP_FLAG_SET_ACK from
 unsuspecting MSI drivers
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-6-maz@kernel.org>
References: <20250513172819.2216709-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174723286550.406.7144630379886904318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     fb0ea6e4878a45b1ac81972027907fc424a792e6
Gitweb:        https://git.kernel.org/tip/fb0ea6e4878a45b1ac81972027907fc424a792e6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 16:24:27 +02:00

irqchip: Drop MSI_CHIP_FLAG_SET_ACK from unsuspecting MSI drivers

Commit 1c000dcaad2be ("irqchip/irq-msi-lib: Optionally set default
irq_eoi()/irq_ack()") added blanket MSI_CHIP_FLAG_SET_ACK flags,
irrespective of whether the underlying irqchip required it or not.

Drop it from a number of drivers that do not require it.

Fixes: 1c000dcaad2be ("irqchip/irq-msi-lib: Optionally set default irq_eoi()/irq_ack()")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-6-maz@kernel.org

---
 drivers/irqchip/irq-gic-v2m.c               | 2 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 drivers/irqchip/irq-gic-v3-mbi.c            | 2 +-
 drivers/irqchip/irq-mvebu-gicp.c            | 2 +-
 drivers/irqchip/irq-mvebu-odmi.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index dc98c39..cc6a6c1 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -252,7 +252,7 @@ static void __init gicv2m_teardown(void)
 static struct msi_parent_ops gicv2m_msi_parent_ops = {
 	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
 	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "GICv2m-",
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index bdb04c8..c5a7eb1 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -203,7 +203,7 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 34e9ca7..647b18e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -197,7 +197,7 @@ static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
 	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
 	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "MBI-",
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d67f93f..60b9762 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -161,7 +161,7 @@ static const struct irq_domain_ops gicp_domain_ops = {
 static const struct msi_parent_ops gicp_msi_parent_ops = {
 	.supported_flags	= GICP_MSI_FLAGS_SUPPORTED,
 	.required_flags		= GICP_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	= MATCH_PLATFORM_MSI,
 	.prefix			= "GICP-",
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 28f7e81..54f6f08 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -157,7 +157,7 @@ static const struct irq_domain_ops odmi_domain_ops = {
 static const struct msi_parent_ops odmi_msi_parent_ops = {
 	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	= MATCH_PLATFORM_MSI,
 	.prefix			= "ODMI-",

