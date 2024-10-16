Return-Path: <linux-tip-commits+bounces-2486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A819A1354
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C981C23A02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023521BAF3;
	Wed, 16 Oct 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQ3yb/cP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sqj0mb4/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124B21B451;
	Wed, 16 Oct 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109068; cv=none; b=WqpdJD9UHFS6/rJkD1no14y92OINbPgWa5osMANZNTWJmJm0hBzHbwRbI4Q3QGLB1pNV27/zMzVNaDUyhnuusM94t7+pJzkc73qzrhMQnsXlMx3M13q9xs91DA5VzqjYD2ua7FgUWdFdcI+C3ayXMCNgsjiW+3m1ZnaUxwDVYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109068; c=relaxed/simple;
	bh=HKw+N75Fm5ld1Xwig70e6UA63ooMuYirrYiOM/F/ZQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NeUHenF2jct/h0h39hf2C95CEHrzDyZt07ZjHA8Uh+4open+d4DcZVzClBiLMuRqbCC8EAD2TpyfjqpFbg0ulCIwFK+Tx7Wo4Ck9PGCDnwgGOZSwU+by6Ck22gxkOvlqCg4Yg3LsGoOZg/g7FHn2tw/8q052XD1EU8SoK5kpVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQ3yb/cP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sqj0mb4/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/KR7hUE6f7QyitpJ+bTJNSYQuR7xPChMH3Ub2/nemU=;
	b=mQ3yb/cP+4jBMwy4rFH9uSxt6XWKrwYAB1F19nkom3aMKajPvMnVOvz93ClsXJrAm0Io9D
	bmyT/0lSO+Qjaf+ziMw4KqK9NaP1AGvt13RSZ3qs0Hy+gw5zjzXZxwjDffkRlviFPVxcah
	dgu5BfNg1VD3Ru3nomT/BCNcVbHHStnfpjtdZfPndqbnP3Fj7/tV7t7uIDiWZ7rNT5mVMX
	RkDWUo9ScbbWLHTUAY4yxJ7aYab07sFMoT36T8pU8ocaMdpoDC8GGEPMU2JpipxIwHMWT3
	JfRpA5NH2JfVZjOOOe0JwowIa+6tv3dXNcY+Skl+DMFi7PalQS/ZGWVeH+cxLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/KR7hUE6f7QyitpJ+bTJNSYQuR7xPChMH3Ub2/nemU=;
	b=Sqj0mb4/EMCVdJB+1ucc5bQ/3GPPYqcDuZq3mY2IZ2+1xnr1161lh0XcQw7KvEmsEuNlHF
	BXOxx8bTv1XXfoBA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-7-bvanassche@acm.org>
References: <20241015190953.1266194-7-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906379.1442.12860628614900870674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f642974c0b772a18675602f2a366aa49d07baf8c
Gitweb:        https://git.kernel.org/tip/f642974c0b772a18675602f2a366aa49d07baf8c
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:37 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. Prepare for changing 'nr_irqs' from an
exported global variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-7-bvanassche@acm.org

---
 arch/x86/kernel/acpi/boot.c   | 6 ++++--
 arch/x86/kernel/apic/vector.c | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4efecac..3a44a9d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1171,7 +1171,8 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	}
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
-				      acpi_parse_int_src_ovr, nr_irqs);
+				      acpi_parse_int_src_ovr,
+				      irq_get_nr_irqs());
 	if (count < 0) {
 		pr_err("Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -1191,7 +1192,8 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	mp_config_acpi_legacy_irqs();
 
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE,
-				      acpi_parse_nmi_src, nr_irqs);
+				      acpi_parse_nmi_src,
+				      irq_get_nr_irqs());
 	if (count < 0) {
 		pr_err("Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 5573181..736f628 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -712,8 +712,8 @@ int __init arch_probe_nr_irqs(void)
 {
 	int nr;
 
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs = NR_VECTORS * nr_cpu_ids;
+	if (irq_get_nr_irqs() > NR_VECTORS * nr_cpu_ids)
+		irq_set_nr_irqs(NR_VECTORS * nr_cpu_ids);
 
 	nr = (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
 #if defined(CONFIG_PCI_MSI)
@@ -725,8 +725,8 @@ int __init arch_probe_nr_irqs(void)
 	else
 		nr += gsi_top * 16;
 #endif
-	if (nr < nr_irqs)
-		nr_irqs = nr;
+	if (nr < irq_get_nr_irqs())
+		irq_set_nr_irqs(nr);
 
 	/*
 	 * We don't know if PIC is present at this point so we need to do

