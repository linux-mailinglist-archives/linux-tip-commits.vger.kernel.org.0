Return-Path: <linux-tip-commits+bounces-3170-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D41A00D8D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DFD3A469C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FE1FC111;
	Fri,  3 Jan 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNV1j+AO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58QSTkje"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9551FC0FF;
	Fri,  3 Jan 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928327; cv=none; b=mbPz33/0bxF5u6G+HmcmGZXjM9J9HnnBE+aWsjdRtOyfsEw0wLyckFhM/nq/mXd+Nsxa/5ti5IzBZ281Ymzds2r5kyKD+ebuiNgIU+OAQZ4iv2UImn4oJQfV4lkisS0EWGZSu6eilZ+bmbp4yKiuie7IQndIq8cWfMClS3cd4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928327; c=relaxed/simple;
	bh=v3sNqoyKjijSiy3CAPw6wiWQHOQHl3nZWnuEGG8auS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bdkIPR1O4NnG5PsqM4OZ6dGsX2iDl0Kyp5nwfDsGqMhCg+d3q4PCc13RkAl6XEDoMeWo5TeX6mu4KYyjd+77axQJ91h8n/akA0bsafCy4b5lX6rCdNiCiTr9yzl2GQwxeVpsScSNnAZPKH0bLhUMpmR8GKTljtgr4iI3xrChSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNV1j+AO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58QSTkje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 03 Jan 2025 18:18:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735928323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cArCcLuxf8YSdLp6MVDKwyp4LB+h40yqi+EPPMkipVA=;
	b=mNV1j+AODFYeliiDVhMkLF2y8GbXiIgPxB6F5QSH6wRN0lZ4VmYQZdNSH3U+LoXqkBQn3O
	fo9lm0EZEG+U6jIk+tDKtgJfgFZbSq5zWmcDeN7/f9p0Y58MlxVU0eCmm24ef5uAW19f/M
	OyKFPIs7UJcWHhIuOj4ySOghk+z/aPeFu0tSQBNJa6mBbcdJNLC7K1oNtSuiH6qefH4NEf
	txTaGycxJ0I7b8OIwAnnLIm4ZZAmyIcR0cL9V9xp2LR1sK/MVfaaGjpQoFZMF7idqNw6lU
	0csu60e2+RVRw/zIVTLYC/K53l3oAICjYdROYpzYsXWqOc2Cc7AYGE6fo7UVSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735928323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cArCcLuxf8YSdLp6MVDKwyp4LB+h40yqi+EPPMkipVA=;
	b=58QSTkjeN4AwROPML5NHwafxFRKYzdoZE3DPsN6T5NOfsg5rhngHDWdoGW1KzkVS5T8hfr
	0ethGsUdNLQu/TAg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Remove shared threshold bank plumbing
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-2-yazen.ghannam@amd.com>
References: <20241206161210.163701-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173592832068.399.2557146594507913537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d35fb3121a36170bba951c529847a630440e4174
Gitweb:        https://git.kernel.org/tip/d35fb3121a36170bba951c529847a630440e4174
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:54 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 03 Jan 2025 19:05:35 +01:00

x86/mce/amd: Remove shared threshold bank plumbing

Legacy AMD systems include an integrated Northbridge that is represented
by MCA bank 4. This is the only non-core MCA bank in legacy systems. The
Northbridge is physically shared by all the CPUs within an AMD "Node".

However, in practice the "shared" MCA bank can only by managed by a
single CPU within that AMD Node. This is known as the "Node Base Core"
(NBC). For example, only the NBC will be able to read the MCA bank 4
registers; they will be Read-as-Zero for other CPUs. Also, the MCA
Thresholding interrupt will only signal the NBC; the other CPUs will not
receive it. This is enforced by hardware, and it should not be managed by
software.

The current AMD Thresholding code attempts to deal with the "shared" MCA
bank by micromanaging the bank's sysfs kobjects. However, this does not
follow the intended kobject use cases. It is also fragile, and it has
caused bugs in the past.

Modern AMD systems do not need this shared MCA bank support, and it
should not be needed on legacy systems either.

Remove the shared threshold bank code. Also, move the threshold struct
definitions to mce/amd.c, since they are no longer needed in amd_nb.c.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-2-yazen.ghannam@amd.com
---
 arch/x86/Kconfig              |   2 +-
 arch/x86/include/asm/amd_nb.h |  31 +--------
 arch/x86/kernel/cpu/mce/amd.c | 127 ++++++---------------------------
 3 files changed, 27 insertions(+), 133 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0a..e4e27d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1189,7 +1189,7 @@ config X86_MCE_INTEL
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
-	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
+	depends on X86_MCE && X86_LOCAL_APIC
 	help
 	  Additional support for AMD specific MCE features such as
 	  the DRAM Error Threshold.
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index d0caac2..4f586fc 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,7 +4,6 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/refcount.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
@@ -29,41 +28,11 @@ struct amd_l3_cache {
 	u8	 subcaches[4];
 };
 
-struct threshold_block {
-	unsigned int	 block;			/* Number within bank */
-	unsigned int	 bank;			/* MCA bank the block belongs to */
-	unsigned int	 cpu;			/* CPU which controls MCA bank */
-	u32		 address;		/* MSR address for the block */
-	u16		 interrupt_enable;	/* Enable/Disable APIC interrupt */
-	bool		 interrupt_capable;	/* Bank can generate an interrupt. */
-
-	u16		 threshold_limit;	/*
-						 * Value upon which threshold
-						 * interrupt is generated.
-						 */
-
-	struct kobject	 kobj;			/* sysfs object */
-	struct list_head miscj;			/*
-						 * List of threshold blocks
-						 * within a bank.
-						 */
-};
-
-struct threshold_bank {
-	struct kobject		*kobj;
-	struct threshold_block	*blocks;
-
-	/* initialized to the number of CPUs on the node sharing this bank */
-	refcount_t		cpus;
-	unsigned int		shared;
-};
-
 struct amd_northbridge {
 	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
-	struct threshold_bank *bank4;
 };
 
 struct amd_northbridge_info {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 018874b..1075a90 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -4,8 +4,6 @@
  *
  *  Written by Jacob Shin - AMD, Inc.
  *  Maintained by: Borislav Petkov <bp@alien8.de>
- *
- *  All MC4_MISCi registers are shared between cores on a node.
  */
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
@@ -20,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 
-#include <asm/amd_nb.h>
 #include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
@@ -221,6 +218,32 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 #define MAX_MCATYPE_NAME_LEN	30
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
+struct threshold_block {
+	/* This block's number within its bank. */
+	unsigned int		block;
+	/* MCA bank number that contains this block. */
+	unsigned int		bank;
+	/* CPU which controls this block's MCA bank. */
+	unsigned int		cpu;
+	/* MCA_MISC MSR address for this block. */
+	u32			address;
+	/* Enable/Disable APIC interrupt. */
+	bool			interrupt_enable;
+	/* Bank can generate an interrupt. */
+	bool			interrupt_capable;
+	/* Value upon which threshold interrupt is generated. */
+	u16			threshold_limit;
+	/* sysfs object */
+	struct kobject		kobj;
+	/* List of threshold blocks within this block's MCA bank. */
+	struct list_head	miscj;
+};
+
+struct threshold_bank {
+	struct kobject		*kobj;
+	struct threshold_block	*blocks;
+};
+
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
 
 /*
@@ -333,19 +356,6 @@ struct thresh_restart {
 	u16			old_limit;
 };
 
-static inline bool is_shared_bank(int bank)
-{
-	/*
-	 * Scalable MCA provides for only one core to have access to the MSRs of
-	 * a shared bank.
-	 */
-	if (mce_flags.smca)
-		return false;
-
-	/* Bank 4 is for northbridge reporting and is thus shared */
-	return (bank == 4);
-}
-
 static const char *bank4_names(const struct threshold_block *b)
 {
 	switch (b->address) {
@@ -1198,35 +1208,10 @@ out_free:
 	return err;
 }
 
-static int __threshold_add_blocks(struct threshold_bank *b)
-{
-	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-	int err = 0;
-
-	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
-	if (err)
-		return err;
-
-	list_for_each_entry_safe(pos, tmp, head, miscj) {
-
-		err = kobject_add(&pos->kobj, b->kobj, pos->kobj.name);
-		if (err) {
-			list_for_each_entry_safe_reverse(pos, tmp, head, miscj)
-				kobject_del(&pos->kobj);
-
-			return err;
-		}
-	}
-	return err;
-}
-
 static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 				 unsigned int bank)
 {
 	struct device *dev = this_cpu_read(mce_device);
-	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
 	const char *name = get_name(cpu, bank, NULL);
 	int err = 0;
@@ -1234,26 +1219,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	if (!dev)
 		return -ENODEV;
 
-	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(topology_amd_node_id(cpu));
-
-		/* threshold descriptor already initialized on this node? */
-		if (nb && nb->bank4) {
-			/* yes, use it */
-			b = nb->bank4;
-			err = kobject_add(b->kobj, &dev->kobj, name);
-			if (err)
-				goto out;
-
-			bp[bank] = b;
-			refcount_inc(&b->cpus);
-
-			err = __threshold_add_blocks(b);
-
-			goto out;
-		}
-	}
-
 	b = kzalloc(sizeof(struct threshold_bank), GFP_KERNEL);
 	if (!b) {
 		err = -ENOMEM;
@@ -1267,17 +1232,6 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		goto out_free;
 	}
 
-	if (is_shared_bank(bank)) {
-		b->shared = 1;
-		refcount_set(&b->cpus, 1);
-
-		/* nb is already initialized, see above */
-		if (nb) {
-			WARN_ON(nb->bank4);
-			nb->bank4 = b;
-		}
-	}
-
 	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
@@ -1310,40 +1264,11 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 	kobject_put(&bank->blocks->kobj);
 }
 
-static void __threshold_remove_blocks(struct threshold_bank *b)
-{
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-
-	kobject_put(b->kobj);
-
-	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_put(b->kobj);
-}
-
 static void threshold_remove_bank(struct threshold_bank *bank)
 {
-	struct amd_northbridge *nb;
-
 	if (!bank->blocks)
 		goto out_free;
 
-	if (!bank->shared)
-		goto out_dealloc;
-
-	if (!refcount_dec_and_test(&bank->cpus)) {
-		__threshold_remove_blocks(bank);
-		return;
-	} else {
-		/*
-		 * The last CPU on this node using the shared bank is going
-		 * away, remove that bank now.
-		 */
-		nb = node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
-		nb->bank4 = NULL;
-	}
-
-out_dealloc:
 	deallocate_threshold_blocks(bank);
 
 out_free:

