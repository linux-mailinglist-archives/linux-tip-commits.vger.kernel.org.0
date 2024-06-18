Return-Path: <linux-tip-commits+bounces-1437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2790C84D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CDA28C3E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1E200048;
	Tue, 18 Jun 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsSRPJWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMoyYiZS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637A1FF80B;
	Tue, 18 Jun 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703907; cv=none; b=GCaM8UFlyRT6tNqUtHGzFYU8cfUFL1Usqap183o66qYTErqrvBLRoPPHfPLpYIsT3/WpboROpRvf8B7IjL2h3tzCmFgQ7IKPEQ06Q1t5PROvlfdYyMEBM89IejCuBUSaM20KV3rGGhaCxQDzNSolffPg3YTIfJZ3A/uY8i57q/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703907; c=relaxed/simple;
	bh=d7rw4TmYXpsakPImU3NlORWc0OYvMJe6WsqW8Oy4Pr4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJ6l2P3Fhvac4yTjGEC962Sr8FUCgKQGxGtefc0aJ1dEtNs7a0ihZVoE9uEvBg9Vlj2Bu+9yAhrr3J3tNLm3wCiT7nFCFpTSPacB9CQ5iOFDMtTHCEQ+q9ZoPnx3bVcrDkd0YD+OqpfYoxdXgsY1n3dT1T2eFfXUX1cUlDZKJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsSRPJWF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMoyYiZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxL6vB6S/uqFxZOrS8WzquTWdXYUIh2fXSRLO+1P44s=;
	b=tsSRPJWF5Z6YgVpCTS6Imwi5DiATMqZYKuCrFHOQ3I8fRaYoRWBtYGH9aodlstg1VCazOn
	2fFR/L7FGAyovAS6kilk+NcfrsGwaEso2wilPdmr2b7RbMsQL+TXOcIQvApOMYfCKktfYG
	0cn3zVyhezGf9vCe9m9HJmj602GtaKhsDYGbYvSBQr0T68yCV651T6FlyBtnGpvCQPa9NF
	4TzfUWVdDAAfOuhDv0o7vOIy3zDcT0qFQloqjapc8lVZpiJlMsorOFQawGAiGGTCkgCzRa
	+SMDfTlVRqBRp5XTCy0uw1O2Y2O0s6uY/tS1+pAT5KWGYwdRhB5SooZBC61JHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxL6vB6S/uqFxZOrS8WzquTWdXYUIh2fXSRLO+1P44s=;
	b=VMoyYiZS/qmObAjEyFxRn3vOBBlKYMGVLx+jVGy/aTAi/sxGkgaK6II9Y1sfdpXKJ1QOdq
	lU9uDAhEr7vAGjDA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Provide guest VMPL level to userspace
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfff846da0d8d561f9fdaf297dcf8cd907545a25b=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cfff846da0d8d561f9fdaf297dcf8cd907545a25b=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389944.10875.6889049582338833468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     61564d346809aa84729e651b98032592a7d63d3e
Gitweb:        https://git.kernel.org/tip/61564d346809aa84729e651b98032592a7d63d3e
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:50 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

x86/sev: Provide guest VMPL level to userspace

Requesting an attestation report from userspace involves providing the VMPL
level for the report. Currently any value from 0-3 is valid because Linux
enforces running at VMPL0.

When an SVSM is present, though, Linux will not be running at VMPL0 and only
VMPL values starting at the VMPL level Linux is running at to 3 are valid. In
order to allow userspace to determine the minimum VMPL value that can be
supplied to an attestation report, create a sysfs entry that can be used to
retrieve the current VMPL level of the kernel.

  [ bp: Add CONFIG_SYSFS ifdeffery. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/fff846da0d8d561f9fdaf297dcf8cd907545a25b.1717600736.git.thomas.lendacky@amd.com
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 12 +++-
 arch/x86/kernel/sev.c                              | 46 +++++++++++++-
 2 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index e7e1609..8fd7ed9 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -605,6 +605,18 @@ Description:	Umwait control
 			  Note that a value of zero means there is no limit.
 			  Low order two bits must be zero.
 
+What:		/sys/devices/system/cpu/sev
+		/sys/devices/system/cpu/sev/vmpl
+Date:		May 2024
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Secure Encrypted Virtualization (SEV) information
+
+		This directory is only present when running as an SEV-SNP guest.
+
+		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
+		      the SEV-SNP guest is running.
+
+
 What:		/sys/devices/system/cpu/svm
 Date:		August 2019
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 84f3731..4dc7ae3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2504,3 +2504,49 @@ void __init snp_update_svsm_ca(void)
 	/* Update the CAA to a proper kernel address */
 	boot_svsm_caa = &boot_svsm_ca_page;
 }
+
+#ifdef CONFIG_SYSFS
+static ssize_t vmpl_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", snp_vmpl);
+}
+
+static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+
+static struct attribute *vmpl_attrs[] = {
+	&vmpl_attr.attr,
+	NULL
+};
+
+static struct attribute_group sev_attr_group = {
+	.attrs = vmpl_attrs,
+};
+
+static int __init sev_sysfs_init(void)
+{
+	struct kobject *sev_kobj;
+	struct device *dev_root;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (!dev_root)
+		return -ENODEV;
+
+	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
+	put_device(dev_root);
+
+	if (!sev_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
+	if (ret)
+		kobject_put(sev_kobj);
+
+	return ret;
+}
+arch_initcall(sev_sysfs_init);
+#endif // CONFIG_SYSFS

