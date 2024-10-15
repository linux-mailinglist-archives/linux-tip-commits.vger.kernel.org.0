Return-Path: <linux-tip-commits+bounces-2445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB2299F8F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 23:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57996B20D59
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A678176228;
	Tue, 15 Oct 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMzCwXOa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0uSlpQH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD591F80BC;
	Tue, 15 Oct 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027143; cv=none; b=l8s1KI3GLDAxXgl/ixvIOLDq4HYevm717mtFhjIyuBqOqUyTZsQ0F68kQpxucF16pterf6LYrBkpyKbGN9KwjJnV4nkl/n2npf92pRMba+92qm/IUXIF2Khwqb/KVymbr92oLbpotMkmwU+NjxLtBTUl/ZUYre5+xVNYkDCsiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027143; c=relaxed/simple;
	bh=lzCi6iGOatafE9aZ4G3mjwjwAGpRQ12FEeuWFZ6t/Qc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BY49INSLDpTcy0bNcMPkR7uUgzkG1xAezQ10qL2c+11fnqiZXCvIet/gtv8ARsTW/tyihzYKnPWBTlfAK/rkC8QamnQ/49kZW53B+G4w5WXuzhSCIhbRM5aElPHeuO8glFpCm370t9Phk46r24qZd5scwleGDbif2CCCxxGTZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMzCwXOa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0uSlpQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 21:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729027137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4iYpyOdNDmsi0oFEdjrnW+kJsotysukE0rF7ltM4fw=;
	b=lMzCwXOa5zO3uhfTyA93JuiLb2PfpX3JV5JlPAXLcjNMKhEe1sfEGtSaU//3L/P4h9aTxI
	OCZv7srufnfJbYGPze6gHpqXgt67xDxpuFrEoyNpPb63/OW2O3foh/CN3avfgfoXAVWhSI
	hLK2DR8ULe0Brndam4sLCfZQ4HgKq0jWLUmguxD5DNdTroKJZ2A8cku2kECD6Y6qAIl4fU
	e/SNae2WN//q0luorqAWvge0aJblbs0ng0/7CO+N6coKIVU476u7tAAOx7Su5vuO2oTZIr
	tnNtBr4IPQHdlj9SRm5mWMHM74jgAue+EdGJFttl47KOKwZ+gdAK5k3b3hdJzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729027137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4iYpyOdNDmsi0oFEdjrnW+kJsotysukE0rF7ltM4fw=;
	b=b0uSlpQHuelR3KnCApYlCig7UUAiNB94gexgTUYPnZ8XBevQbj57c4ok+Xyxn/mDgdnrlN
	xTG37mphLHoI4iDQ==
From: "tip-bot2 for Sunil V L" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-intc: Fix SMP=n boot with ACPI
Cc: bjorn@kernel.org, Sunil V L <sunilvl@ventanamicro.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241014065739.656959-1-sunilvl@ventanamicro.com>
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172902713689.1442.17389879630721887035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a98a0f050ced4bd4ecb59e92412916012b7c2917
Gitweb:        https://git.kernel.org/tip/a98a0f050ced4bd4ecb59e92412916012b7=
c2917
Author:        Sunil V L <sunilvl@ventanamicro.com>
AuthorDate:    Mon, 14 Oct 2024 12:27:39 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 23:14:25 +02:00

irqchip/riscv-intc: Fix SMP=3Dn boot with ACPI

When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
NR_CPUS is not sufficient to hold all RINTC structures passed from the
firmware.

All RINTC structures are required to configure IMSIC/APLIC/PLIC properly
irrespective of SMP in the OS. So, allocate dynamic memory based on the
number of RINTC structures in MADT to fix this issue.

Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/all/20241014065739.656959-1-sunilvl@ventanamicr=
o.com
Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/11280997511/j=
ob/31375229012
---
 drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index 8c54113..f653c13 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -265,7 +265,7 @@ struct rintc_data {
 };
=20
 static u32 nr_rintc;
-static struct rintc_data *rintc_acpi_data[NR_CPUS];
+static struct rintc_data **rintc_acpi_data;
=20
 #define for_each_matching_plic(_plic_id)				\
 	unsigned int _plic;						\
@@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struct re=
source *res)
 	return 0;
 }
=20
+static int __init riscv_intc_acpi_match(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	return 0;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
 	struct acpi_madt_rintc *rintc;
 	struct fwnode_handle *fn;
+	int count;
 	int rc;
=20
+	if (!rintc_acpi_data) {
+		count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_matc=
h, 0);
+		if (count <=3D 0)
+			return -EINVAL;
+
+		rintc_acpi_data =3D kcalloc(count, sizeof(*rintc_acpi_data), GFP_KERNEL);
+		if (!rintc_acpi_data)
+			return -ENOMEM;
+	}
+
 	rintc =3D (struct acpi_madt_rintc *)header;
 	rintc_acpi_data[nr_rintc] =3D kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERN=
EL);
 	if (!rintc_acpi_data[nr_rintc])

