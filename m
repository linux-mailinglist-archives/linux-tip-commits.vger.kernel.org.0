Return-Path: <linux-tip-commits+bounces-1450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C223190D492
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243781F21AC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80F16CD2E;
	Tue, 18 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ciypiR8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CG3tX42Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FF16B398;
	Tue, 18 Jun 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719312; cv=none; b=W8p3vHNNPBlAqMsBYIQD3+lezhCzlFoSpVbWC+WVHySHEIs3r1eGoA6bKwuz046EBubuNJSk4tI0cTLbHn0hvZfMQu2/7hISLFp8X7L5Zy3lK8xn10Npm4Hj5PIAVMQMZyyaaMEyDrWNlKELIoa+8I4UKyoepWd8kxWl1nawhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719312; c=relaxed/simple;
	bh=yjUvC4f7rdokSm6EHijVQnjRI1pz/hAM6zOPrb8TIi4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ImYnOqHbtEmTlreijssspSM+FeLIjHLiaY9FxrrTe59MIc0Uyt3C32MA1WkLwYUtSEsn+jcp3FEZyQfI1MPvz59fCu6wYw5fwy8IMpyZ17LbBypGofuLOuby4x0kds/inipLjH422U2qmQ8803AuxQxJ2x5AzY0REFIobuX9wSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ciypiR8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CG3tX42Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uDBaAnpPAMfYumvktEspcHf5+jpIq3rXt2PlE5fghY=;
	b=ciypiR8+9dZZiJUys+MIya/kBHeIMlE9QUzuXSLQ40DiiI2a4gRF58j4guq2B5HOWTVgI7
	ya/WbICpHT5Uq31dDPqOAYU+rmFeLlMQ6fEuvT2EHtbi45cDxyVRH/Aa7yuaPN47F3+qvo
	5gFsblqvkIyEJVlD/TPUz8a5IzgOUWzujHx3eBP5FxUSkyL3Yp4YQUawhVMWYBk0IkfJJx
	xL8vKduJ807mgRFIGIMvS3wDD+M+UiLhE4yT8IlWkhGhr/cI/2YqQtk3+baviu6BgYe+5L
	4P20V+spPKrzImjTiTB11tirbhtvR6ab8E7ieBg3qgRn9r+6f4wZE/PuBtQreQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719299;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uDBaAnpPAMfYumvktEspcHf5+jpIq3rXt2PlE5fghY=;
	b=CG3tX42YNBpRHigXWP8JPKehufnjGix7/1ZbdBbZf1dTAZK+WLAYFaVGWyyGreEEXD6hKm
	BVT93Sdz6VikMbCw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/acpi: Do not attempt to bring up secondary CPUs in
 the kexec case
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kai Huang <kai.huang@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-16-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-16-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871929938.10875.11100335956704738461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     db0936830a2fcc35e2b283275acf61b6d3ae1e11
Gitweb:        https://git.kernel.org/tip/db0936830a2fcc35e2b283275acf61b6d3ae1e11
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:59:00 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:17 +02:00

x86/acpi: Do not attempt to bring up secondary CPUs in the kexec case

ACPI MADT doesn't allow to offline a CPU after it was onlined. This limits
kexec: the second kernel won't be able to use more than one CPU.

To prevent a kexec kernel from onlining secondary CPUs, invalidate the mailbox
address in the ACPI MADT wakeup structure which prevents a kexec kernel to use
it.

This is safe as the booting kernel has the mailbox address cached already and
acpi_wakeup_cpu() uses the cached value to bring up the secondary CPUs.

Note: This is a Linux specific convention and not covered by the ACPI
specification.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-16-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/acpi/madt_wakeup.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 004801b..30820f9 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -14,6 +14,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_afte
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
 	 *
@@ -64,6 +69,28 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
+static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
+{
+	cpu_hotplug_disable_offlining();
+
+	/*
+	 * ACPI MADT doesn't allow to offline a CPU after it was onlined. This
+	 * limits kexec: the second kernel won't be able to use more than one CPU.
+	 *
+	 * To prevent a kexec kernel from onlining secondary CPUs invalidate the
+	 * mailbox address in the ACPI MADT wakeup structure which prevents a
+	 * kexec kernel to use it.
+	 *
+	 * This is safe as the booting kernel has the mailbox address cached
+	 * already and acpi_wakeup_cpu() uses the cached value to bring up the
+	 * secondary CPUs.
+	 *
+	 * Note: This is a Linux specific convention and not covered by the
+	 *       ACPI specification.
+	 */
+	mp_wake->mailbox_address = 0;
+}
+
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end)
 {
@@ -77,7 +104,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
-	cpu_hotplug_disable_offlining();
+	acpi_mp_disable_offlining(mp_wake);
 
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 

