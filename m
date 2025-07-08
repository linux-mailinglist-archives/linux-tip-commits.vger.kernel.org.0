Return-Path: <linux-tip-commits+bounces-6026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B1AFC7CD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B104837C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9A26C3A0;
	Tue,  8 Jul 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="San2q6Sm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNMsTBQJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557726B2D3;
	Tue,  8 Jul 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969043; cv=none; b=AGAnmKdKZ/nEO+rxzc3Wqdo3ZP0qy/5BC909FubuoQgaAvsnO7xQmPO6ZKIW9sGhU1lZOj64P6oYawrLn/eU9kpHyBbBVhxcjAY3VibD5xkNYJedIUV0Nb2xjwnFZ5wtsi+nKcLwruM7FqqFC+w+PRe4rgDI2cVg0dRst7Wf34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969043; c=relaxed/simple;
	bh=oPtrZDqhJLsj1eW8beiJ34GVnxLgM3NZuohZCbcOjHw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OeII3gd8hoHs40glomVbsUGUySb+hYSfI/jP9xRzJKrsBhtsmroMIl9UeHsbkGNZyp+piwyPEqzn4TSRFZe07UXb1Y6TbbVDqcLZgU6osS7BbWounkV7JCp58OqkH9ATMisqB1zgqxnMnp91DwR9JXnrNi0k7a0j59cfosWaNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=San2q6Sm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNMsTBQJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H40AVSvvEcHg5Rq3CT2bT9OK8RhNqrYyg3NOCXsh+XA=;
	b=San2q6SmKaiCEfnbS95xpE1l9kgOHckQRLp9OwDHYAPtNj0r4/psniFFK8eZGLLY+oYa8s
	KwTltevt5Ftc3gs5Ah3Mwa7aUZlLxQjCPWawi5ESST8pE/dcupcJ8Wl0tM2Z233bkAKrwI
	17rfG2B5XKeJOkU2L6boF4KA+KnFqu5/uRLV7WIWnO8O1oNfNB9oetDk5DdwSZSuSJYwnY
	SPHU9jw30y4sDZbu8svP2dwSy2aH5SFUk/ZNuEaFBQw5q7ol7is0TMU2lTicmmri1EE8ih
	Fcs4/yu4McIbb39ylMw6FsRDDehEtNLntPu8K7BpXNxnPZtPAdsEfDMRGrI1pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H40AVSvvEcHg5Rq3CT2bT9OK8RhNqrYyg3NOCXsh+XA=;
	b=PNMsTBQJWcRmIFTf9Y7KeZDhcm0RKZ65Z6524fuwzvaYG4vF7462Q9mutwFJGGbugMOsiS
	nMV0pBFUWKWic8BA==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86: hfi: Parse CPU core ranking data
 from shared memory
Cc: Perry Yuan <Perry.Yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-6-superm1@kernel.org>
References: <20250609200518.3616080-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903913.406.13066096125394547831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     d4e95ea7a78e46be2f2fe529fe578d3834c453a2
Gitweb:        https://git.kernel.org/tip/d4e95ea7a78e46be2f2fe529fe578d3834c=
453a2
Author:        Perry Yuan <Perry.Yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:10 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 21:17:16 +02:00

platform/x86: hfi: Parse CPU core ranking data from shared memory

When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
to retrieve the shared memory address which contains the CPU core ranking
table. This table includes a header that specifies the number of ranking
data entries to be parsed and rank each CPU core with the Performance and
Energy Efficiency capability as implemented by the CPU power management
firmware.

Once the table has been parsed, each CPU is assigned a ranking score
within its class. Subsequently, when the scheduler selects cores, it
chooses from the ranking list based on the assigned scores in each class,
thereby ensuring the optimal selection of CPU cores according to their
predefined classifications and priorities.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-6-superm1@kernel.org
---
 drivers/platform/x86/amd/hfi/hfi.c | 198 ++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
index 9fac918..690b7b1 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -18,21 +18,71 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>
+#include <linux/topology.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu_device_id.h>
+
+#include <acpi/pcc.h>
+#include <acpi/cppc_acpi.h>
=20
 #define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HFI_MAILBOX_COUNT		1
+#define AMD_HETERO_RANKING_TABLE_VER	2
=20
 #define AMD_HETERO_CPUID_27	0x80000027
=20
 static struct platform_device *device;
=20
+/**
+ * struct amd_shmem_info - Shared memory table for AMD HFI
+ *
+ * @header:	The PCCT table header including signature, length flags and comm=
and.
+ * @version_number:		Version number of the table
+ * @n_logical_processors:	Number of logical processors
+ * @n_capabilities:		Number of ranking dimensions (performance, efficiency, =
etc)
+ * @table_update_context:	Command being sent over the subspace
+ * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
+ *				This is based on the maximum APIC ID enumerated in the system
+ * @reserved:			24 bit spare
+ * @table_data:			Bit Map(s) of enabled logical processors
+ *				Followed by the ranking data for each logical processor
+ */
+struct amd_shmem_info {
+	struct acpi_pcct_ext_pcc_shared_memory header;
+	u32	version_number		:8,
+		n_logical_processors	:8,
+		n_capabilities		:8,
+		table_update_context	:8;
+	u32	n_bitmaps		:8,
+		reserved		:24;
+	u32	table_data[];
+};
+
 struct amd_hfi_data {
 	const char	*name;
 	struct device	*dev;
+
+	/* PCCT table related */
+	struct pcc_mbox_chan	*pcc_chan;
+	void __iomem		*pcc_comm_addr;
+	struct acpi_subtable_header	*pcct_entry;
+	struct amd_shmem_info	*shmem;
 };
=20
+/**
+ * struct amd_hfi_classes - HFI class capabilities per CPU
+ * @perf:	Performance capability
+ * @eff:	Power efficiency capability
+ *
+ * Capabilities of a logical processor in the ranking table. These capabilit=
ies
+ * are unitless and specific to each HFI class.
+ */
 struct amd_hfi_classes {
 	u32	perf;
 	u32	eff;
@@ -41,21 +91,107 @@ struct amd_hfi_classes {
 /**
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		CPU index
+ * @apic_id:		APIC id of the current CPU
  * @class_index:	workload class ID index
  * @nr_class:		max number of workload class supported
+ * @ipcc_scores:	ipcc scores for each class
  * @amd_hfi_classes:	current CPU workload class ranking data
  *
  * Parameters of a logical processor linked with hardware feedback class.
  */
 struct amd_hfi_cpuinfo {
 	int		cpu;
+	u32		apic_id;
 	s16		class_index;
 	u8		nr_class;
+	int		*ipcc_scores;
 	struct amd_hfi_classes	*amd_hfi_classes;
 };
=20
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) =3D {.class_i=
ndex =3D -1};
=20
+static int find_cpu_index_by_apicid(unsigned int target_apicid)
+{
+	int cpu_index;
+
+	for_each_possible_cpu(cpu_index) {
+		struct cpuinfo_x86 *info =3D &cpu_data(cpu_index);
+
+		if (info->topo.apicid =3D=3D target_apicid) {
+			pr_debug("match APIC id %u for CPU index: %d\n",
+				 info->topo.apicid, cpu_index);
+			return cpu_index;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext =3D
+		(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
+	void __iomem *pcc_comm_addr;
+	u32 apic_start =3D 0;
+
+	pcc_comm_addr =3D acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_addr,
+					amd_hfi_data->pcc_chan->shmem_size);
+	if (!pcc_comm_addr) {
+		dev_err(amd_hfi_data->dev, "failed to ioremap PCC common region mem\n");
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
+	iounmap(pcc_comm_addr);
+
+	if (amd_hfi_data->shmem->header.signature !=3D PCC_SIGNATURE) {
+		dev_err(amd_hfi_data->dev, "invalid signature in shared memory\n");
+		return -EINVAL;
+	}
+	if (amd_hfi_data->shmem->version_number !=3D AMD_HETERO_RANKING_TABLE_VER) {
+		dev_err(amd_hfi_data->dev, "invalid version %d\n",
+			amd_hfi_data->shmem->version_number);
+		return -EINVAL;
+	}
+
+	for (unsigned int i =3D 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
+		u32 bitmap =3D amd_hfi_data->shmem->table_data[i];
+
+		for (unsigned int j =3D 0; j < BITS_PER_TYPE(u32); j++) {
+			u32 apic_id =3D i * BITS_PER_TYPE(u32) + j;
+			struct amd_hfi_cpuinfo *info;
+			int cpu_index, apic_index;
+
+			if (!(bitmap & BIT(j)))
+				continue;
+
+			cpu_index =3D find_cpu_index_by_apicid(apic_id);
+			if (cpu_index < 0) {
+				dev_warn(amd_hfi_data->dev, "APIC ID %u not found\n", apic_id);
+				continue;
+			}
+
+			info =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			info->apic_id =3D apic_id;
+
+			/* Fill the ranking data for each logical processor */
+			info =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+			apic_index =3D apic_start * info->nr_class * 2;
+			for (unsigned int k =3D 0; k < info->nr_class; k++) {
+				u32 *table =3D amd_hfi_data->shmem->table_data +
+					     amd_hfi_data->shmem->n_bitmaps +
+					     i * info->nr_class;
+
+				info->amd_hfi_classes[k].eff =3D table[apic_index + 2 * k];
+				info->amd_hfi_classes[k].perf =3D table[apic_index + 2 * k + 1];
+			}
+			apic_start++;
+		}
+	}
+
+	return 0;
+}
+
 static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 {
 	struct amd_hfi_cpuinfo *hfi_cpuinfo;
@@ -72,6 +208,7 @@ static int amd_hfi_alloc_class_data(struct platform_device=
 *pdev)
=20
 	for_each_possible_cpu(idx) {
 		struct amd_hfi_classes *classes;
+		int *ipcc_scores;
=20
 		classes =3D devm_kcalloc(dev,
 				       nr_class_id,
@@ -79,14 +216,71 @@ static int amd_hfi_alloc_class_data(struct platform_devi=
ce *pdev)
 				       GFP_KERNEL);
 		if (!classes)
 			return -ENOMEM;
+		ipcc_scores =3D devm_kcalloc(dev, nr_class_id, sizeof(int), GFP_KERNEL);
+		if (!ipcc_scores)
+			return -ENOMEM;
 		hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, idx);
 		hfi_cpuinfo->amd_hfi_classes =3D classes;
+		hfi_cpuinfo->ipcc_scores =3D ipcc_scores;
 		hfi_cpuinfo->nr_class =3D nr_class_id;
 	}
=20
 	return 0;
 }
=20
+static int amd_hfi_metadata_parser(struct platform_device *pdev,
+				   struct amd_hfi_data *amd_hfi_data)
+{
+	struct acpi_pcct_ext_pcc_slave *pcct_ext;
+	struct acpi_subtable_header *pcct_entry;
+	struct mbox_chan *pcc_mbox_channels;
+	struct acpi_table_header *pcct_tbl;
+	struct pcc_mbox_chan *pcc_chan;
+	acpi_status status;
+	int ret;
+
+	pcc_mbox_channels =3D devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+					 sizeof(*pcc_mbox_channels), GFP_KERNEL);
+	if (!pcc_mbox_channels)
+		return -ENOMEM;
+
+	pcc_chan =3D devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
+				sizeof(*pcc_chan), GFP_KERNEL);
+	if (!pcc_chan)
+		return -ENOMEM;
+
+	status =3D acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+	if (ACPI_FAILURE(status) || !pcct_tbl)
+		return -ENODEV;
+
+	/* get pointer to the first PCC subspace entry */
+	pcct_entry =3D (struct acpi_subtable_header *) (
+			(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
+
+	pcc_chan->mchan =3D &pcc_mbox_channels[0];
+
+	amd_hfi_data->pcc_chan =3D pcc_chan;
+	amd_hfi_data->pcct_entry =3D pcct_entry;
+	pcct_ext =3D (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
+
+	if (pcct_ext->length <=3D 0)
+		return -EINVAL;
+
+	amd_hfi_data->shmem =3D devm_kzalloc(amd_hfi_data->dev, pcct_ext->length, G=
FP_KERNEL);
+	if (!amd_hfi_data->shmem)
+		return -ENOMEM;
+
+	pcc_chan->shmem_base_addr =3D pcct_ext->base_address;
+	pcc_chan->shmem_size =3D pcct_ext->length;
+
+	/* parse the shared memory info from the PCCT table */
+	ret =3D amd_hfi_fill_metadata(amd_hfi_data);
+
+	acpi_put_table(pcct_tbl);
+
+	return ret;
+}
+
 static const struct acpi_device_id amd_hfi_platform_match[] =3D {
 	{"AMDI0104", 0},
 	{ }
@@ -112,6 +306,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
+	ret =3D amd_hfi_metadata_parser(pdev, amd_hfi_data);
+	if (ret)
+		return ret;
+
 	return 0;
 }
=20

