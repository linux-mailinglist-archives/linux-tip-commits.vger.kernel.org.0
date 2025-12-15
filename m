Return-Path: <linux-tip-commits+bounces-7705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EECBF852
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 20:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502333013EEB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210AC30F80D;
	Mon, 15 Dec 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xPK+2+Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7igLS+6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785293101DB;
	Mon, 15 Dec 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826526; cv=none; b=XKEMNzeQdve69gYpsogj009kIyfgW2WBlzQOrI64TawpHP0NKs6is9T6YOfqAq6VvoTS+bSfUWuqVlT2kX/ORscgtuy24g7oJDHrCaO0E9biD3LXbb+9XzzNsAYKpyYp4tq7wz5jG+phv0ucIqRhqTVe0xgpwGlgGbsRpk+Hf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826526; c=relaxed/simple;
	bh=grEw3/BxjKNY0P1mEs2e0q2eOVzgCSfFZi12+TJIE7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qem6S1a/QpOHjDgVHrVWHy5MfQ9ynX5/gIFajQI0ZMzscmUcIYsybbTFkJJHI7RLXq7pNKFA8uWpISGi9lBGuR1Ioah0OiJZ170EGMd3JpBEA0cuwgG9fWdWoQqTDbtwb28Dxf+DhFacwng/HwpDY/3l+7nQFo5LMhCUt7jamjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xPK+2+Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7igLS+6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 19:21:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765826521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI22m8MVz/xG4Z0FOuy3C1wygh9C/8pzJI3fZDjehMg=;
	b=4xPK+2+ZkLJcY2fbpG6pso9MHoSEgLMUjhCzadSnzZTgiM6MuKzN0SJ5lGhmQPEkWIjX2p
	S4NwCLoj/K77PXlj9EZzMbvdaTolX3yLOmCMCfx+NZFypljhBJJuP4+kmFyKcxWmnrWO2l
	yN8E1vRWe6G1wIWS+/Uw/Y/1Admt6OJJsEnN7aPXEVhNdM5Gsx0iJh3v9+DNa5kFu4HGao
	rV6VfkqSzQ5VmRpiwmQv1XM0hWWVK8mOD8gXIkfcjnets9ifKrTW5kpNYjPXUi0H4nGP9K
	PgMtG6rzaPre19KcBcQaXIKu9yO6ulPEDnb6stH1G0JRF1Ftby6/M+BrVP504Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765826521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI22m8MVz/xG4Z0FOuy3C1wygh9C/8pzJI3fZDjehMg=;
	b=e7igLS+6xzsEzkW6DNyKSgae0m75KWM/l/TFzscrDSKpQTYgLo6JAtm4wsacwqjUEstNQo
	1DZC17wYs71ZzQAQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Correct kernel-doc in <linux/msi.h>
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251214202341.2205675-1-rdunlap@infradead.org>
References: <20251214202341.2205675-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176582651962.510.15901769966431318868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0317e0aba5d41ae5e974026bf96899d9ae4bcbdb
Gitweb:        https://git.kernel.org/tip/0317e0aba5d41ae5e974026bf96899d9ae4=
bcbdb
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 14 Dec 2025 12:23:41 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 20:18:27 +01:00

genirq/msi: Correct kernel-doc in <linux/msi.h>

Eliminate all kernel-doc warnings in <linux/msi.h>:

  - add "struct" to struct kernel-doc headers
  - add missing struct member descriptions or correct typos in them

Fixes these warnings:
Warning: include/linux/msi.h:60 cannot understand function prototype:
 'struct msi_msg'
Warning: include/linux/msi.h:73 struct member 'arch_addr_lo' not described
 in 'msi_msg'
Warning: include/linux/msi.h:73 struct member 'arch_addr_hi' not described
 in 'msi_msg'
Warning: include/linux/msi.h:106 cannot understand function prototype:
 'struct pci_msi_desc'
Warning: include/linux/msi.h:124 struct member 'msi_attrib' not described
 in 'pci_msi_desc'
Warning: include/linux/msi.h:204 struct member 'sysfs_attrs' not described
 in 'msi_desc'
Warning: include/linux/msi.h:227 struct member 'domain' not described in
 'msi_dev_domain'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251214202341.2205675-1-rdunlap@infradead.org
---
 include/linux/msi.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8003e32..94cfc37 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -49,12 +49,12 @@ typedef struct arch_msi_msg_data {
 #endif
=20
 /**
- * msi_msg - Representation of a MSI message
+ * struct msi_msg - Representation of a MSI message
  * @address_lo:		Low 32 bits of msi message address
- * @arch_addrlo:	Architecture specific shadow of @address_lo
+ * @arch_addr_lo:	Architecture specific shadow of @address_lo
  * @address_hi:		High 32 bits of msi message address
  *			(only used when device supports it)
- * @arch_addrhi:	Architecture specific shadow of @address_hi
+ * @arch_addr_hi:	Architecture specific shadow of @address_hi
  * @data:		MSI message data (usually 16 bits)
  * @arch_data:		Architecture specific shadow of @data
  */
@@ -91,7 +91,7 @@ typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
 				    struct msi_msg *msg);
=20
 /**
- * pci_msi_desc - PCI/MSI specific MSI descriptor data
+ * struct pci_msi_desc - PCI/MSI specific MSI descriptor data
  *
  * @msi_mask:	[PCI MSI]   MSI cached mask bits
  * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
@@ -101,6 +101,7 @@ typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
  * @can_mask:	[PCI MSI/X] Masking supported?
  * @is_64:	[PCI MSI/X] Address size: 0=3D32bit 1=3D64bit
  * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
+ * @msi_attrib:	[PCI MSI/X] Compound struct of MSI/X attributes
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
  */
@@ -169,7 +170,7 @@ struct msi_desc_data {
  *                  Only used if iommu_msi_shift !=3D 0
  * @iommu_msi_shift: Indicates how many bits of the original address should =
be
  *                   preserved when using iommu_msi_iova.
- * @sysfs_attr:	Pointer to sysfs device attribute
+ * @sysfs_attrs:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
  *			address or data changes
@@ -220,7 +221,7 @@ enum msi_desc_filter {
 /**
  * struct msi_dev_domain - The internals of MSI domain info per device
  * @store:		Xarray for storing MSI descriptor pointers
- * @irqdomain:		Pointer to a per device interrupt domain
+ * @domain:		Pointer to a per device interrupt domain
  */
 struct msi_dev_domain {
 	struct xarray		store;

