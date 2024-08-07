Return-Path: <linux-tip-commits+bounces-1973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6294ADFD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A531F23C33
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A56137776;
	Wed,  7 Aug 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OH0u6B5r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYCVxdYy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57B12FF7B;
	Wed,  7 Aug 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047928; cv=none; b=cmqyVcN4nZrkUWRI/7nMEPMJ6a4DiBPMP49qDWNrlXAFWVFNysBu1ipoUMnzwxxTcp+9JLI81SAbR526bPTw+RSDZPjkyIGsiAUWnk/rHkdfhkP2Mgvrxx/WKoLPf7nYdgj2+/GYCzexJvFP7quBuYb7LwhQbYmzn77RgUKu61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047928; c=relaxed/simple;
	bh=v4cBiUeL7jpR7aOwMkagL/MCS8cDBd/7OwC/5j9ds18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HWw1MEzQARmJTOHjbokMMrObZbE8x10nemwIxITbqxFw0DhAPCF8gW/PIad3XYzkC1yJYf7ERplF4qThU/TVv8CAIRQN7qeYuN/r0rYHAaVkyRB/+NVptCStTk19M4pIUWXp+1R3jW3aWFlsOgvC44M1aekptARg7rOQ6gqsdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OH0u6B5r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYCVxdYy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frZgdP1TEODgUH3NvaDW3LT0A2Ca01XVzgTuaJ0celw=;
	b=OH0u6B5rfw7CmbVzqCp3RDgxIIukd7jpM2O5yUEnxXxYyeV+y5X+y7BPqM31UGbZ5NunNj
	K9S0YgF7eOPB5yS5hOw5W5wI6Zx64avqpYu8tSKhpyHjzROjS8Vyf6ZBwU4Olj4LmIbKXB
	GNb7/OoLnrzlW0CgU0Lmjj6wUOdv7M0bFD9F/mCq22YyEL3pXt8SQbdaFkZhsy3hmFJ8yn
	ntsSw0il26PXY1D40yVes4fHba0eyU6kDIq3uOoEYUFCASxLrouMwCwqyqif8zKRIpS8uL
	va9W3ogtrP+xsXw/g0LPxs2mH5W7iD5C59eZ6HHQaZ43lBFDMzs+KcDiOiaTCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frZgdP1TEODgUH3NvaDW3LT0A2Ca01XVzgTuaJ0celw=;
	b=cYCVxdYyhIIpCZGzyAW+CJgx/2Z0J7Cp9fAcM0eJUKVI/ORi2ZTihxAEhU7d+amIBDrGJN
	MkbM9A3VFGf4yhAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Cleanup remaining coding style issues
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155441.158662179@linutronix.de>
References: <20240802155441.158662179@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792485.2215.5477605738763845337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     62e303e346d7f829ff4f52c73176451c7f85f4bc
Gitweb:        https://git.kernel.org/tip/62e303e346d7f829ff4f52c73176451c7f85f4bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:29 +02:00

x86/ioapic: Cleanup remaining coding style issues

Add missing new lines and reorder variable definitions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155441.158662179@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 051779f..1029ea4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -264,12 +264,14 @@ static __attribute_const__ struct io_apic __iomem *io_apic_base(int idx)
 static inline void io_apic_eoi(unsigned int apic, unsigned int vector)
 {
 	struct io_apic __iomem *io_apic = io_apic_base(apic);
+
 	writel(vector, &io_apic->eoi);
 }
 
 unsigned int native_io_apic_read(unsigned int apic, unsigned int reg)
 {
 	struct io_apic __iomem *io_apic = io_apic_base(apic);
+
 	writel(reg, &io_apic->index);
 	return readl(&io_apic->data);
 }
@@ -880,9 +882,9 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 				 struct irq_alloc_info *info)
 {
+	int type = ioapics[ioapic].irqdomain_cfg.type;
 	bool legacy = false;
 	int irq = -1;
-	int type = ioapics[ioapic].irqdomain_cfg.type;
 
 	switch (type) {
 	case IOAPIC_DOMAIN_LEGACY:
@@ -951,11 +953,11 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain, int irq, int ioa
 static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			     unsigned int flags, struct irq_alloc_info *info)
 {
-	int irq;
-	bool legacy = false;
+	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
 	struct irq_alloc_info tmp;
 	struct mp_chip_data *data;
-	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
+	bool legacy = false;
+	int irq;
 
 	if (!domain)
 		return -ENOSYS;
@@ -1269,8 +1271,7 @@ static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
 
 void __init enable_IO_APIC(void)
 {
-	int i8259_apic, i8259_pin;
-	int apic, pin;
+	int i8259_apic, i8259_pin, apic, pin;
 
 	if (ioapic_is_disabled)
 		nr_ioapics = 0;
@@ -1943,9 +1944,9 @@ static void lapic_register_intr(int irq)
  */
 static inline void __init unlock_ExtINT_logic(void)
 {
-	int apic, pin, i;
-	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	struct IO_APIC_route_entry entry0, entry1;
+	int apic, pin, i;
 	u32 apic_id;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
@@ -2211,11 +2212,11 @@ out:
 
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_domain *parent;
+	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
 	int hwirqs = mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip = &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg = &ip->irqdomain_cfg;
-	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
+	struct irq_domain *parent;
 	struct fwnode_handle *fn;
 	struct irq_fwspec fwspec;
 
@@ -2491,8 +2492,8 @@ static struct resource *ioapic_resources;
 
 static struct resource * __init ioapic_setup_resources(void)
 {
-	unsigned long n;
 	struct resource *res;
+	unsigned long n;
 	char *mem;
 	int i;
 

