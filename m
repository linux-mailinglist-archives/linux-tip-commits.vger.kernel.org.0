Return-Path: <linux-tip-commits+bounces-5626-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552AABA429
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DB47ADAC9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB028A73C;
	Fri, 16 May 2025 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZppXZAEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrYcTfZQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06128A3E0;
	Fri, 16 May 2025 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424272; cv=none; b=tiwOvXFdkp/PxGngR9vnVnDElnKsNFz3LRJO6f8CDpyrq/kB8vnQSlMRP0GWXSv5xducJ7xH4mf0TvZ8qZi5xldaKhjkrMEVWrBpNdAfPzS5UPNQfgKD6KgcTsumzgo8SMzPABOckUyaYyS4t8Ia/2a8VvLybia5+VC9wxytLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424272; c=relaxed/simple;
	bh=5j+YgcJ635cjQnnyrS/rjE8uaj3Cvm2ZMCXoCFadFZA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UyhY9W3wXAxcYx+zr9Jfgb5SnhDxAdN4ojVdpcA0bSMVy3u0dfLHK7Q4HfkIW5bvrZYOobdW/bsJ90/uMqyOGuplMoS6Z9d1WWsswhO0grd9h6SOLnbnLUaF8n1GJk9kBYEzmWOJqZE8lK6U6MHen/tk9iaVZxvSwehPsy8NkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZppXZAEb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrYcTfZQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy6dYY/iYFAvMYX/jc25e5HEIdHgUq0ohl9C1OfG6tg=;
	b=ZppXZAEbDCbCHVfbxq5w6O3CWutLlc8Y2U/rHpxLCwSwYrkzX2RO6nDMcaUAKi3KfxVO3S
	X646BfdqZp7CN4R93NpZ5zP2sIzqmg+VguuhNtvamfCcLhE9EE4TXeA2/Wt0l8pK13rLCB
	hVL68NadEK9C/LSW7sDZPWOFNg1j4BkRp3qJsYUcgj4N4rAk7HENruTzrHwMRCwzGqB3Cy
	N6UrtspS9Es4NY9iHPlm8+d8VN6QVsDPF7k0NDTxjKc1MakJA+v5ZJyn3H1cOXYsKwuURs
	qmGDVkNbg3cm5uRt86LIY3rGhSjhB6LDufJu70V0vY7es5pUd9Vqr0CQ7RN+CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy6dYY/iYFAvMYX/jc25e5HEIdHgUq0ohl9C1OfG6tg=;
	b=YrYcTfZQUEMc/vnE0m+1HNcZog33tEgBKrg/JYezIJX5RTgvmapcxZvX4L+qFwS1FCXOGG
	aSCMkEXm1I01LTDg==
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
Message-ID: <174742426887.406.446096216638829187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     f09831892c801b3875a247dc631fcbc2e704ca1f
Gitweb:        https://git.kernel.org/tip/f09831892c801b3875a247dc631fcbc2e704ca1f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

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

