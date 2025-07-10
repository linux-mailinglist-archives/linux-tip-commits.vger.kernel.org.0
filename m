Return-Path: <linux-tip-commits+bounces-6070-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C1B00E29
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 23:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEE647839
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF130292B33;
	Thu, 10 Jul 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDqVw1uR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/4dXce0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E6292B3A;
	Thu, 10 Jul 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184022; cv=none; b=PoqZExaJq4rhZCWBAn+5JmNFHbvN6xQMWhfIoUQWflRSyTrUQk5B+Xc70qDWToMmCy88541G49paZx7f04trjVYa9DgcVbpXWu1al0UdHjfNtwkd2Gbjj+dDEMZuTiAeZojJNCrycKL/sv/VxwIBPBlwDu4hTfbVUkzEMnqVCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184022; c=relaxed/simple;
	bh=nii83oEenuV5hCFIOdUmhieNFroqGqMTvzTflMSrpy4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nWMbiEpGDvKt2lzoMDmGwhuMn0/fVAXCgrSR0CBYN+e7x+kvpqFLZZk9//CD+eT88YGtDrO7PH1j+wLrNyphzeQyZddw1OASnY4U0a7294z6g1xHeXcWX2Ak7UYy06VKNofR9LviYh88wKstyHPgLDJa2c2/Opmyo8HcZMYfjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDqVw1uR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/4dXce0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 21:46:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752184018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqn0AG1tmLyXf3znwjM+EaFm7a1IWTMJ9I4Aydck6Y8=;
	b=FDqVw1uR8ARyGP+iTvel34i+z+VaYTP9PDNb5PZAnZd1F3rwa9clw5m6TePVSVH4qUkTHv
	FHxJD+UnPK7ok+BKMcnRhZRHvW7bNyc/3Zvhhf3PVdWmBdWOhFegdkyhOBMLQ4BA9DFJkd
	qL84VyThBFiNMHgkwFInT7YCGz50dVtYByc27LpAlofxFL9W85G4/s35SB3dXP+Pi9UivD
	X034L8SnWKoWVY49IbLD20/8DdAIu+Fl8n1An33A2W7N1jvtEwF8/ntC0lvAFU2eG9O3eD
	1IMYID942rpcjxW66YAvyM6b7iLd+7nAmBHAb7PpiE54+75ge41Jlphee8eq9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752184018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hqn0AG1tmLyXf3znwjM+EaFm7a1IWTMJ9I4Aydck6Y8=;
	b=a/4dXce0WUYwGp193IXvD/D+/PmuV0nxJe9i+/aLHjBHKxA7J0MnGGft/eITVUS20XukH5
	OLLU6MbGPHmPa+Bg==
From: "tip-bot2 for Himanshu Madhani" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Prevent recursive locking in
 pci_msix_write_tph_tag()
Cc: Jorge Lopez <jorge.jo.lopez@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
References: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175218401725.406.6167258058407425293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     68ea85df15d111d82fc474cbe104174791169355
Gitweb:        https://git.kernel.org/tip/68ea85df15d111d82fc474cbe104174791169355
Author:        Himanshu Madhani <himanshu.madhani@oracle.com>
AuthorDate:    Tue, 08 Jul 2025 22:25:30 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Jul 2025 23:41:08 +02:00

PCI/MSI: Prevent recursive locking in pci_msix_write_tph_tag()

pci_msix_write_tph_tag() takes the per device MSI descriptor mutex and then
invokes msi_domain_get_virq(), which takes the same mutex again. That
obviously results in a system hang which is exposed by a softlockup or
lockdep warning.

Move the lock guard after the invocation of msi_domain_get_virq() to fix
this.

[ tglx: Massage changelog by adding a proper explanation and removing the
  	not really useful stacktrace ]

Fixes: d5124a9957b2 ("PCI/MSI: Provide a sane mechanism for TPH")
Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Link: https://lore.kernel.org/all/20250708222530.1041477-1-himanshu.madhani@oracle.com
---
 drivers/pci/msi/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a..d686488 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -934,10 +934,12 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!pdev->msix_enabled)
 		return -ENXIO;
 
-	guard(msi_descs_lock)(&pdev->dev);
 	virq = msi_get_virq(&pdev->dev, index);
 	if (!virq)
 		return -ENXIO;
+
+	guard(msi_descs_lock)(&pdev->dev);
+
 	/*
 	 * This is a horrible hack, but short of implementing a PCI
 	 * specific interrupt chip callback and a huge pile of

