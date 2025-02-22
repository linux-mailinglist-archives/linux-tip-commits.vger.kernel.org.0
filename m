Return-Path: <linux-tip-commits+bounces-3596-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE6A407F1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71B870286E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0494206F3B;
	Sat, 22 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEYLFRm6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jl+wydXI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A209F25;
	Sat, 22 Feb 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224248; cv=none; b=UKC5gXFKB29Ez7G3twZPwKsVgEBN8mr2XIE1t8obzH9wbkS4ocjLPaYMfDW12OtvWv7GrZvy/jAtJdNgCo3tCI/dFA4OdoIEyWnBHIdBPv/y0uTAVLQEXxmSwIhTM+eBxj0wYNqNOHzNbIwog/Fhw3bhhREFPOD3ZssA8JD1FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224248; c=relaxed/simple;
	bh=M2l+hHNlor1I/N7AnDFo1mmE59Gq9iL69qc6edsLSoQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r+Rq8KzdtPZD/PQnHaLhdXZdu/3PjgnL1tbDpGmUXnbfagKACHwRwde4routWHHAZ6GYbO5LXm4d8+vWKzoDQ+ij3u8WpU5C5se8YZwSMIlAnjKRNfYPxn3FwwjV80W8nsjo2/OBUiKglE5r1iRPKV0EQ/4HxYMsz1LocH7acSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEYLFRm6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jl+wydXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 11:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740224244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzmVtN3YczAaOjqNhF+vJYzFdXJiArEG3TjrQqu4yPM=;
	b=MEYLFRm6AeBERg4lrfH8WsQmmEh2YZ9WbamJ6GI57nvONZvmJQW5KG6JtgWwmypvnw0xFr
	xQX+mpzr00SMwDZ4p69s2T0c+mlIaZl32JoBP5fn+HVW16C1gcvAZnzCrr/0BlcY7JzeA3
	UbXW9r46fvJydvrigw0n6p2oXHzIJ4kghw10/cClAzFhuIxKr6rHzMGK0ay4O54DID+aEP
	O2/F4NcUoyJWu3ySMh+TkoLz4eM5KAl30gANFEJMUWJBy6aghaH22NRYQJvhetQxwhf6QI
	Borwi1HcCWI9T+OKV9qbk3/l6lTgs7rhKGa+E86crx4ev3CFuSurOmuv3cbPPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740224244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzmVtN3YczAaOjqNhF+vJYzFdXJiArEG3TjrQqu4yPM=;
	b=Jl+wydXIpyAu3O2LHtIoj9rSRM5tZhWsRnzH3Tm39N6xoPENhdyB82BQIlHOdulZ9SwyY1
	+PPzLb6sg8SkEjBg==
From: "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kaslr: Reduce KASLR entropy on most x86 systems
Cc: Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250206234234.1912585-1-balbirs@nvidia.com>
References: <20250206234234.1912585-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022424056.10177.5690011025322849175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     7ffb791423c7c518269a9aad35039ef824a40adb
Gitweb:        https://git.kernel.org/tip/7ffb791423c7c518269a9aad35039ef824a40adb
Author:        Balbir Singh <balbirs@nvidia.com>
AuthorDate:    Fri, 07 Feb 2025 10:42:34 +11:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 12:25:57 +01:00

x86/kaslr: Reduce KASLR entropy on most x86 systems

When CONFIG_PCI_P2PDMA=y (which is basically enabled on all
large x86 distros), it maps the PFN's via a ZONE_DEVICE
mapping using devm_memremap_pages(). The mapped virtual
address range corresponds to the pci_resource_start()
of the BAR address and size corresponding to the BAR length.

When KASLR is enabled, the direct map range of the kernel is
reduced to the size of physical memory plus additional padding.
If the BAR address is beyond this limit, PCI peer to peer DMA
mappings fail.

Fix this by not shrinking the size of the direct map when
CONFIG_PCI_P2PDMA=y.

This reduces the total available entropy, but it's better than
the current work around of having to disable KASLR completely.

[ mingo: Clarified the changelog to point out the broad impact ... ]

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/Kconfig
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/
Link: https://lore.kernel.org/r/20250206234234.1912585-1-balbirs@nvidia.com
--
 arch/x86/mm/kaslr.c | 10 ++++++++--
 drivers/pci/Kconfig |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)
---
 arch/x86/mm/kaslr.c | 10 ++++++++--
 drivers/pci/Kconfig |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 11a9354..3c306de 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -113,8 +113,14 @@ void __init kernel_randomize_memory(void)
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
 		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
-	/* Adapt physical memory region size based on available memory */
-	if (memory_tb < kaslr_regions[0].size_tb)
+	/*
+	 * Adapt physical memory region size based on available memory,
+	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
+	 * device BAR space assuming the direct map space is large enough
+	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
+	 * to the physical BAR address.
+	 */
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379..5c3054a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -203,6 +203,12 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
+
 	  If unsure, say N.
 
 config PCI_LABEL

