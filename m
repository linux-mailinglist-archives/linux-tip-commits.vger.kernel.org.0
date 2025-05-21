Return-Path: <linux-tip-commits+bounces-5736-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EFABFD72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D31162281
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 19:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8122ACFB;
	Wed, 21 May 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkGRAZ2s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5z2XYqX5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409150276;
	Wed, 21 May 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856284; cv=none; b=NpW7Cjolj++y7R/dtG7bB5dbItvIgP5UFfGxnnLaglGFLebHYw/Usstv06KfZTbudSSQAsFeVNY3Ozs5DbIkLfbzwZLCQ+dFrBmcht0wLhRC1Ii/6KTiqnmnmBtdvSSJbZBRBc0xcrswFMqCPnI8RTBS4XcHVogsSqLD+5c1zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856284; c=relaxed/simple;
	bh=EL4DME9cegy9dOwoK6nLFmfWpGPwKqPQDTCILYP3fdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FsZ1InJBjXdSAfUMHqt2YK0hvJMLGv6IIDeemBH5d6u4xaSBzdRDuhANKPzhOMkdoM/HuQ+gx8HFoO27ZwI/B8QagFxBJ7g/wjY5LYGSnzj3ZIAfAis7EPJNkspZ1aWntkslfrKi7AqZ/YhcS1u5DL2cDqHlGQcJp1sWiRWvf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkGRAZ2s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5z2XYqX5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 19:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747856281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vA1sl5ygboXyeOCUpcIPaZApKSyrq46gaZuyIT3ZS4=;
	b=mkGRAZ2s9BRM7Z8OeEignP82ZQ5j7uzQYWPzGvbtt4v6+7g045bbFTsNjyqCuUS1ZBWD/j
	ak7p80HRog3Zw6wBAf0qYfJxCG7vBKhPpd7gj6BKgMWOf2l0rY4h+3+zrIxknF+BZA55I8
	FODPWcJVLyrsw2yFOphLxczz1/wRnXHacTIIwpenyB/7xUmk1CAsW6VZrq2Hvgjb5IPEMl
	d5FKFgnknL4h7WZH7y/5pSUY6O/dYW+6hxisyx6LUYYnM5Wb05HnFDrrMMFUF92XUphw5j
	BMPyekM8TkS8d9wNeV/Mar/rN4LkXel/OrV6VVmXqcQIR6n2hC3Qr5z58yz0tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747856281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vA1sl5ygboXyeOCUpcIPaZApKSyrq46gaZuyIT3ZS4=;
	b=5z2XYqX5+v21o9aXwuMAbprkv/j2y68bH0CtCr5QIaTLrK61n8zEozgApUjIZ0YYs9DnyU
	YVD8wZXUo/+KDLCw==
From: "tip-bot2 for Hans Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use bool for MSI enable state tracking
Cc: Hans Zhang <hans.zhang@cixtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250516165223.125083-2-18255117159@163.com>
References: <20250516165223.125083-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174785627988.406.2996126912434384302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     4e7bca76e3fed58437dcd7f747d1c8d98507379e
Gitweb:        https://git.kernel.org/tip/4e7bca76e3fed58437dcd7f747d1c8d98507379e
Author:        Hans Zhang <hans.zhang@cixtech.com>
AuthorDate:    Sat, 17 May 2025 00:52:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 May 2025 21:28:53 +02:00

PCI/MSI: Use bool for MSI enable state tracking

Convert pci_msi_enable and pci_msi_enabled() to use bool type for clarity.
No functional changes, only code cleanup.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250516165223.125083-2-18255117159@163.com

---
 drivers/pci/msi/api.c | 2 +-
 drivers/pci/msi/msi.c | 4 ++--
 drivers/pci/msi/msi.h | 2 +-
 include/linux/pci.h   | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index e686400..818d55f 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -399,7 +399,7 @@ EXPORT_SYMBOL_GPL(pci_restore_msi_state);
  * Return: true if MSI has not been globally disabled through ACPI FADT,
  * PCI bridge quirks, or the "pci=nomsi" kernel command-line option.
  */
-int pci_msi_enabled(void)
+bool pci_msi_enabled(void)
 {
 	return pci_msi_enable;
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 593bae2..80ac764 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -15,7 +15,7 @@
 #include "../pci.h"
 #include "msi.h"
 
-int pci_msi_enable = 1;
+bool pci_msi_enable = true;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -970,5 +970,5 @@ EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
 void pci_no_msi(void)
 {
-	pci_msi_enable = 0;
+	pci_msi_enable = false;
 }
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index ee53cf0..fc70b60 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -87,7 +87,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc);
 
 /* Subsystem variables */
-extern int pci_msi_enable;
+extern bool pci_msi_enable;
 
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd..f5e908a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1669,7 +1669,7 @@ void pci_disable_msi(struct pci_dev *dev);
 int pci_msix_vec_count(struct pci_dev *dev);
 void pci_disable_msix(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
-int pci_msi_enabled(void);
+bool pci_msi_enabled(void);
 int pci_enable_msi(struct pci_dev *dev);
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 			  int minvec, int maxvec);
@@ -1702,7 +1702,7 @@ static inline void pci_disable_msi(struct pci_dev *dev) { }
 static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_disable_msix(struct pci_dev *dev) { }
 static inline void pci_restore_msi_state(struct pci_dev *dev) { }
-static inline int pci_msi_enabled(void) { return 0; }
+static inline bool pci_msi_enabled(void) { return false; }
 static inline int pci_enable_msi(struct pci_dev *dev)
 { return -ENOSYS; }
 static inline int pci_enable_msix_range(struct pci_dev *dev,

