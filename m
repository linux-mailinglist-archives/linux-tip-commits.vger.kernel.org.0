Return-Path: <linux-tip-commits+bounces-5367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB8AAD992
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C3B1C22A02
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E2B23816E;
	Wed,  7 May 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQfjbLri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9cicFMO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E623644F;
	Wed,  7 May 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604701; cv=none; b=OuiGU/wYfljkD42VJ7bYAJrD2biDoHdqZGGhaNpZM5JxJFe4/CxsUsnfKiwqyiMqYXQWTLVB31wnb7VEHqjH7VVV1y+cBN17cZxQr1hH6OXZtHnOYCJ0YBOwwukiSapobwbzTnf9jX7mYHzd9qLdxX7ZufdySHKA4HJN6Bu1xro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604701; c=relaxed/simple;
	bh=1Ri2BobHFP4I7MhNOz+c3vtIP6bb4D5GAVyiGhDQUOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QL3dftKeN9DCIHFFJZDmJfLTSNcNNjqAKMHKHzcOzQ8GyJc1FR242ZnVgayf549orno0bQWKYQuYoaXwiJs533EpJSr1QZHHCDIjwimrtjaxQTh/8DjTwuYfkfyvpfVZouYMrb6KZ3QnC20DI6ob3lPBSQh49ya9hv2ZWJrFnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQfjbLri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9cicFMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9jXwEjQS7d8OoAVmdYQcutQFhgmbfSXZ9HHxJ6UrdQ=;
	b=fQfjbLrirbPVwf+O9XF/OIvI23dhUWXjtMQGiXi/hka0k0QpPF9mO4Ukjx/iyB+BDuymEc
	ZHnKWB6LZmhbYNqpotQZKJe/WkPGS+QU4mKndYJ6aqkUkaPjg8qGbQo3kRMQHxFnYJzPo/
	EDIEqupw+tLFaRPY7uyVTuTlAFbqNYTzHmbRZPKbw268/ssRJb5r0lLXjpI5SPS4yKyhF5
	zmjrPSFTSyP1mGpqJkufpoc3mKaS6YzYlKMQmsPeIDRT1/jTUmg0Iqd4y6AI18pHnFWi3g
	QdCSf1ji4eixDA8C/zU8n4Tmyidcll2KhpRX4E6wEArKHaVMfwDUtegtow1htQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9jXwEjQS7d8OoAVmdYQcutQFhgmbfSXZ9HHxJ6UrdQ=;
	b=V9cicFMO7Gva/chxX60CZBUcIbU46/EKKiZm9zj/ALpTVp5eB0TxO2/dUOtXt8TXq5bzDn
	s4WLB1gW3TwdgXDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] powerpc: Switch to of_fwnode_handle()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-9-jirislaby@kernel.org>
References: <20250319092951.37667-9-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469718.406.16766179354098086159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     c8795085c70aacf7f5eb4308d2191df1cf721a7a
Gitweb:        https://git.kernel.org/tip/c8795085c70aacf7f5eb4308d2191df1cf721a7a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:21 +02:00

powerpc: Switch to of_fwnode_handle()

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-9-jirislaby@kernel.org

---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ae4b549..d8ccf2c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1897,7 +1897,7 @@ static int __init pnv_msi_allocate_domains(struct pci_controller *hose, unsigned
 		return -ENOMEM;
 	}
 
-	hose->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(hose->dn),
+	hose->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(hose->dn),
 						     &pnv_msi_domain_info,
 						     hose->dev_domain);
 	if (!hose->msi_domain) {
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index f9d8011..5b191f7 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -628,7 +628,7 @@ static int __pseries_msi_allocate_domains(struct pci_controller *phb,
 		return -ENOMEM;
 	}
 
-	phb->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(phb->dn),
+	phb->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(phb->dn),
 						    &pseries_msi_domain_info,
 						    phb->dev_domain);
 	if (!phb->msi_domain) {

