Return-Path: <linux-tip-commits+bounces-1986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763B94AE14
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC271F23B72
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350814373F;
	Wed,  7 Aug 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3u8azpK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NA08ODMF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60313D61A;
	Wed,  7 Aug 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047935; cv=none; b=j5XGuuX0vCAvh51mk7OJVU3WTaw8fgq67FkXvOwkuWe+gRuDYONCjOB2eu3Zedb2SKzzD7ZWqNDOcSAwNcBkKIQG/wTKTKJDx3hK5qWw78EHijll9/SfXzJa54urT7UPjSLvYPPA8NR6qLTKPXeT/ZWDBKHqc3Ho2NJzKZ52Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047935; c=relaxed/simple;
	bh=cPTBiDLx4soAfss3vIxWw+sgGJ85iCHrurhzRjUpeDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T8nGVk1+JAZMWw511VnYVQl0WuglMqukK+Npo+vefzTfsBPraSzXTyK8hZ0t1jngxPfN6cE7SgHYY9nzXJ6GPyk4nZe406Ehs/7CSVdm98UZrihoNTezDTPUkydkE2S5NbMob+b92M0lLnWbMKfXCUKYBzL68w2uTFn9Dom0f/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3u8azpK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NA08ODMF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dsvlx9uAQMmlS5uuZi0xCoW431PNXB74bKcalN05jg=;
	b=U3u8azpKIOBSqHyPX8+lidRCV8dCpprvUWJmzatn6dOcrf3LxUfL0uYcj7FlHc8eD8QvVu
	JiR3DoBcnfz9hBPoGDvYK4xpT4MUmDQIOXvQHTlsdB96LFhXF/FOBNt+cNNMXsh8W5Xaac
	1L6PYDT+tTtX++O3b7xvag7BMPjWoK7Pj04zb6IpKP5bLJc1+07TPwEnJMCuOagrNXii1n
	TvoPRpk9PffLU2pBOJhmNY0jfWDwH21SC1kbdRSx64NXeJEg4mYbhONMMqs96mF1bXoE/s
	KbL0tz+MEuwbieE2Y86UQCBw4ZW92cy4qr+2K2Cc/efZBfokHOgWHLKmfF2ppw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dsvlx9uAQMmlS5uuZi0xCoW431PNXB74bKcalN05jg=;
	b=NA08ODMFsQQWt89JGTU7oxL05RjjCa03vfJqgWVLHOChvh9b0GGUqNNo2Z+IQsqDYCNXf6
	yZYcvWaXVslf9jDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Handle allocation failures gracefully
Cc: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZqfJmUF8sXIyuSHN@gmail.com>
References: <ZqfJmUF8sXIyuSHN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304793037.2215.7279123758973261566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     830802a0fea8fb39d3dc9fb7d6b5581e1343eb1f
Gitweb:        https://git.kernel.org/tip/830802a0fea8fb39d3dc9fb7d6b5581e1343eb1f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:27 +02:00

x86/ioapic: Handle allocation failures gracefully

Breno observed panics when using failslab under certain conditions during
runtime:

   can not alloc irq_pin_list (-1,0,20)
   Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed

   panic+0x4e9/0x590
   mp_irqdomain_alloc+0x9ab/0xa80
   irq_domain_alloc_irqs_locked+0x25d/0x8d0
   __irq_domain_alloc_irqs+0x80/0x110
   mp_map_pin_to_irq+0x645/0x890
   acpi_register_gsi_ioapic+0xe6/0x150
   hpet_open+0x313/0x480

That's a pointless panic which is a leftover of the historic IO/APIC code
which panic'ed during early boot when the interrupt allocation failed.

The only place which might justify panic is the PIT/HPET timer_check() code
which tries to figure out whether the timer interrupt is delivered through
the IO/APIC. But that code does not require to handle interrupt allocation
failures. If the interrupt cannot be allocated then timer delivery fails
and it either panics due to that or falls back to legacy mode.

Cure this by removing the panic wrapper around __add_pin_to_irq_node() and
making mp_irqdomain_alloc() aware of the failure condition and handle it as
any other failure in this function gracefully.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Breno Leitao <leitao@debian.org>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/all/ZqfJmUF8sXIyuSHN@gmail.com
Link: https://lore.kernel.org/all/20240802155440.275200843@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 46 +++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 477b740..d1ec1dc 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -352,27 +352,26 @@ static void ioapic_mask_entry(int apic, int pin)
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static int __add_pin_to_irq_node(struct mp_chip_data *data,
-				 int node, int apic, int pin)
+static bool add_pin_to_irq_node(struct mp_chip_data *data, int node, int apic, int pin)
 {
 	struct irq_pin_list *entry;
 
-	/* don't allow duplicates */
-	for_each_irq_pin(entry, data->irq_2_pin)
+	/* Don't allow duplicates */
+	for_each_irq_pin(entry, data->irq_2_pin) {
 		if (entry->apic == apic && entry->pin == pin)
-			return 0;
+			return true;
+	}
 
 	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
 	if (!entry) {
-		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
-		       node, apic, pin);
-		return -ENOMEM;
+		pr_err("Cannot allocate irq_pin_list (%d,%d,%d)\n", node, apic, pin);
+		return false;
 	}
+
 	entry->apic = apic;
 	entry->pin = pin;
 	list_add_tail(&entry->list, &data->irq_2_pin);
-
-	return 0;
+	return true;
 }
 
 static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
@@ -387,13 +386,6 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 		}
 }
 
-static void add_pin_to_irq_node(struct mp_chip_data *data,
-				int node, int apic, int pin)
-{
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
-}
-
 /*
  * Reroute an IRQ to a different pin.
  */
@@ -1002,8 +994,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -3017,10 +3008,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOMEM;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
-	if (ret < 0) {
-		kfree(data);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_data;
 
 	INIT_LIST_HEAD(&data->irq_2_pin);
 	irq_data->hwirq = info->ioapic.pin;
@@ -3029,7 +3018,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin)) {
+		ret = -ENOMEM;
+		goto free_irqs;
+	}
 
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
@@ -3044,6 +3036,12 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
 		    data->is_level, data->active_low);
 	return 0;
+
+free_irqs:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+free_data:
+	kfree(data);
+	return ret;
 }
 
 void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,

