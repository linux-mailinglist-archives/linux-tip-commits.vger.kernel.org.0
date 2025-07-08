Return-Path: <linux-tip-commits+bounces-6019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67ECAFC7C1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA4B189C031
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C228268C42;
	Tue,  8 Jul 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJdqCYSO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pP4nFqtT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120C20E033;
	Tue,  8 Jul 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969038; cv=none; b=pegNLbYgOqzSjyw8WMiic1Jz3K5BLheHwVe76lLpY+YtJ6H/hfWZImLnIaljAwhltGbGXZofQvQb6Ky9ooiEA1IhGbJJ5iVp5vQVnOx49Y/QCBOvukgMga6uJAGcc4aN+42dZoHR8bcp/2Lt+fYIPsqGpy8Z7JE1sRUH+TYje1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969038; c=relaxed/simple;
	bh=ck5YmspppoUA7HprmQ5EUsZW+ADCpzZ9j8ae5qaXNV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jBWswbchYRAZevVEgM8XlHerc7zwbT1LTMUDxUPcrVUNDYq+deypERa/XgXwZHZWxZweOGn00N48Cgj3o6MtApmpMBaKoAPwImIxyV1Xj/xBaV72KeiQs/KIbKUC6hBC2l1qqwNnvlzdOzd1YL+Xbu+Q6qQdTh73bChGVvZja9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJdqCYSO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pP4nFqtT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg0mnJOnNh7VosJ6KC6CPLU24KN1LuGXeqPZruaBJGU=;
	b=LJdqCYSOyC86vgr4ghsO7TdESZ+Teb5TrFd87v+gubesjY+efCeZdrFZTPl+cU7yhf9LWF
	FKepdu5R0gM2HgZkGuXHUXR7p1slcwsBnX8dqZfnxNZJ53f0c0wFKCHEfH0kbtRYRJClPE
	I1SvQ2zPj4yuKMoii11OdpHh6U0p6yspoyS/b8SUE9PRXts/OOYwmWG2Nr2HgK7atcWKYT
	BkP4MUL9mriE04uxt1aEf0Qwt9U6ShUG3lR0y9umZK8MXZvQzEhQISa1AhNqqbNNEuVZ86
	PChv/Om2jGMl+A8MVT/pftq+nqpuuVRaImcSkXTy07TxQKQr6EsCKBMj9oTSqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg0mnJOnNh7VosJ6KC6CPLU24KN1LuGXeqPZruaBJGU=;
	b=pP4nFqtTB0faFNC13GV1pfutDZ9a80rgF0u+48eGcUvnbGYTsqmDbol2LB6rWck1WI7VF4
	sEJHQdq57cjkcGBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86/amd: hfi: Add debugfs support
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-13-superm1@kernel.org>
References: <20250609200518.3616080-13-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903324.406.266603680369384036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     13bc67a96ea5bc9dba0b91704d1f7212b65686f3
Gitweb:        https://git.kernel.org/tip/13bc67a96ea5bc9dba0b91704d1f7212b65=
686f3
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:17 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:34:59 +02:00

platform/x86/amd: hfi: Add debugfs support

Add a dump of the class and capabilities table to debugfs to assist
with debugging scheduler issues.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-13-superm1@kernel.org
---
 drivers/platform/x86/amd/hfi/hfi.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
index 805c03b..4f56149 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -13,6 +13,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -73,6 +74,8 @@ struct amd_hfi_data {
 	void __iomem		*pcc_comm_addr;
 	struct acpi_subtable_header	*pcct_entry;
 	struct amd_shmem_info	*shmem;
+
+	struct dentry *dbgfs_dir;
 };
=20
 /**
@@ -238,6 +241,13 @@ static int amd_hfi_alloc_class_data(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
+static void amd_hfi_remove(struct platform_device *pdev)
+{
+	struct amd_hfi_data *dev =3D platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(dev->dbgfs_dir);
+}
+
 static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int c=
pu)
 {
 	for (int i =3D 0; i < hfi_cpuinfo->nr_class; i++)
@@ -393,6 +403,26 @@ static int amd_hfi_metadata_parser(struct platform_devic=
e *pdev,
 	return ret;
 }
=20
+static int class_capabilities_show(struct seq_file *s, void *unused)
+{
+	u32 cpu, idx;
+
+	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
+	for_each_possible_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		seq_printf(s, "%d", cpu);
+		for (idx =3D 0; idx < hfi_cpuinfo->nr_class; idx++) {
+			seq_printf(s, "\t%u\t%u\t%u\n", idx,
+				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
+				   hfi_cpuinfo->amd_hfi_classes[idx].eff);
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(class_capabilities);
+
 static int amd_hfi_pm_resume(struct device *dev)
 {
 	int ret, cpu;
@@ -469,6 +499,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
=20
 	schedule_work(&sched_amd_hfi_itmt_work);
=20
+	amd_hfi_data->dbgfs_dir =3D debugfs_create_dir("amd_hfi", arch_debugfs_dir);
+	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pd=
ev,
+			    &class_capabilities_fops);
+
 	return 0;
 }
=20
@@ -480,6 +514,7 @@ static struct platform_driver amd_hfi_driver =3D {
 		.acpi_match_table =3D ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe =3D amd_hfi_probe,
+	.remove =3D amd_hfi_remove,
 };
=20
 static int __init amd_hfi_init(void)

