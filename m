Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83B647D723
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Dec 2021 19:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbhLVSsq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Dec 2021 13:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhLVSsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Dec 2021 13:48:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68AC061574;
        Wed, 22 Dec 2021 10:48:42 -0800 (PST)
Date:   Wed, 22 Dec 2021 18:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640198920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxMxrotv61zOssaXJWYSazH/pl1kalzyCWEhLkweGxY=;
        b=aexdxzg31YX1G/baGbr9h5p+Ffnwmq2tQjrSGbpFWZ8E0tRNfqHfPlUJbUE/sEmG9XgJDA
        gaFh71FCdK2w7X3NKdTQ60+G3MKFOeO3P748e1D1OcpgFtuIEKOwYMXH1NjGSs8BQvSMHw
        YqxkoO0iSzzXonCMNG8utZ79SBvS3WwD1VfutJLdWaAFpKsU/024lST8FEQ/2YFJyzP3eM
        BDSuIoFOVvXhKzklTjPvlzxDro4jHlQ+ohIvDPAJTfpJCRce8HU87zkm8UH8jBDgSVyDPu
        /wSC6iHfPLCDEAAXtPwo8/cRbBm7bBqBcA5vFtU5WnHX8+SMl8dOB+Pnf0HwgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640198920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxMxrotv61zOssaXJWYSazH/pl1kalzyCWEhLkweGxY=;
        b=XuHjiQ3tXUWCEdt2TGi6dzbs87y1wWXBPxE+ypHq0njLkSBRva6An6tPCbpDwAdtbUcv4I
        s57PKPmWVeuiDcDQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA
 bank type enumeration
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211216162905.4132657-3-yazen.ghannam@amd.com>
References: <20211216162905.4132657-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <164019891907.16921.1221908392370822768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     91f75eb481cfaee5c4ed8fb5214bf2fbfa04bd7b
Gitweb:        https://git.kernel.org/tip/91f75eb481cfaee5c4ed8fb5214bf2fbfa04bd7b
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 16 Dec 2021 16:29:05 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Dec 2021 17:22:09 +01:00

x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type enumeration

AMD systems currently lay out MCA bank types such that the type of bank
number "i" is either the same across all CPUs or is Reserved/Read-as-Zero.

For example:

  Bank # | CPUx | CPUy
    0      LS     LS
    1      RAZ    UMC
    2      CS     CS
    3      SMU    RAZ

Future AMD systems will lay out MCA bank types such that the type of
bank number "i" may be different across CPUs.

For example:

  Bank # | CPUx | CPUy
    0      LS     LS
    1      RAZ    UMC
    2      CS     NBIO
    3      SMU    RAZ

Change the structures that cache MCA bank types to be per-CPU and update
smca_get_bank_type() to handle this change.

Move some SMCA-specific structures to amd.c from mce.h, since they no
longer need to be global.

Break out the "count" for bank types from struct smca_hwid, since this
should provide a per-CPU count rather than a system-wide count.

Apply the "const" qualifier to the struct smca_hwid_mcatypes array. The
values in this array should not change at runtime.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211216162905.4132657-3-yazen.ghannam@amd.com
---
 arch/x86/include/asm/mce.h              | 18 +-------
 arch/x86/kernel/cpu/mce/amd.c           | 59 ++++++++++++++----------
 drivers/edac/mce_amd.c                  | 11 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 52d2b35..cc73061 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -329,22 +329,6 @@ enum smca_bank_types {
 	N_SMCA_BANK_TYPES
 };
 
-#define HWID_MCATYPE(hwid, mcatype) (((hwid) << 16) | (mcatype))
-
-struct smca_hwid {
-	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
-	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
-	u8 count;		/* Number of instances. */
-};
-
-struct smca_bank {
-	struct smca_hwid *hwid;
-	u32 id;			/* Value of MCA_IPID[InstanceId]. */
-	u8 sysfs_id;		/* Value used for sysfs name. */
-};
-
-extern struct smca_bank smca_banks[MAX_NR_BANKS];
-
 extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
 
@@ -352,7 +336,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-enum smca_bank_types smca_get_bank_type(unsigned int bank);
+enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9407cdc..a1e2f41 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -71,6 +71,22 @@ static const char * const smca_umc_block_names[] = {
 	"misc_umc"
 };
 
+#define HWID_MCATYPE(hwid, mcatype) (((hwid) << 16) | (mcatype))
+
+struct smca_hwid {
+	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
+	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
+};
+
+struct smca_bank {
+	const struct smca_hwid *hwid;
+	u32 id;			/* Value of MCA_IPID[InstanceId]. */
+	u8 sysfs_id;		/* Value used for sysfs name. */
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
+static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
+
 struct smca_bank_name {
 	const char *name;	/* Short name for sysfs */
 	const char *long_name;	/* Long name for pretty-printing */
@@ -126,14 +142,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-enum smca_bank_types smca_get_bank_type(unsigned int bank)
+enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 {
 	struct smca_bank *b;
 
 	if (bank >= MAX_NR_BANKS)
 		return N_SMCA_BANK_TYPES;
 
-	b = &smca_banks[bank];
+	b = &per_cpu(smca_banks, cpu)[bank];
 	if (!b->hwid)
 		return N_SMCA_BANK_TYPES;
 
@@ -141,7 +157,7 @@ enum smca_bank_types smca_get_bank_type(unsigned int bank)
 }
 EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
-static struct smca_hwid smca_hwid_mcatypes[] = {
+static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
@@ -202,9 +218,6 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
-struct smca_bank smca_banks[MAX_NR_BANKS];
-EXPORT_SYMBOL_GPL(smca_banks);
-
 /*
  * In SMCA enabled processors, we can have multiple banks for a given IP type.
  * So to define a unique name for each bank, we use a temp c-string to append
@@ -260,8 +273,9 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
+	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
-	struct smca_hwid *s_hwid;
 	u32 high, low;
 	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
 
@@ -297,10 +311,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	smca_set_misc_banks_map(bank, cpu);
 
-	/* Return early if this bank was already initialized. */
-	if (smca_banks[bank].hwid && smca_banks[bank].hwid->hwid_mcatype != 0)
-		return;
-
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
@@ -311,10 +321,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
 		s_hwid = &smca_hwid_mcatypes[i];
+
 		if (hwid_mcatype == s_hwid->hwid_mcatype) {
-			smca_banks[bank].hwid = s_hwid;
-			smca_banks[bank].id = low;
-			smca_banks[bank].sysfs_id = s_hwid->count++;
+			this_cpu_ptr(smca_banks)[bank].hwid = s_hwid;
+			this_cpu_ptr(smca_banks)[bank].id = low;
+			this_cpu_ptr(smca_banks)[bank].sysfs_id = bank_counts[s_hwid->bank_type]++;
 			break;
 		}
 	}
@@ -600,7 +611,7 @@ out:
 
 bool amd_filter_mce(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
@@ -638,7 +649,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	} else if (c->x86 == 0x17 &&
 		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-		if (smca_get_bank_type(bank) != SMCA_IF)
+		if (smca_get_bank_type(smp_processor_id(), bank) != SMCA_IF)
 			return;
 
 		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
@@ -706,7 +717,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1022,7 +1033,7 @@ static struct kobj_type threshold_ktype = {
 	.release		= threshold_block_release,
 };
 
-static const char *get_name(unsigned int bank, struct threshold_block *b)
+static const char *get_name(unsigned int cpu, unsigned int bank, struct threshold_block *b)
 {
 	enum smca_bank_types bank_type;
 
@@ -1033,7 +1044,7 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	bank_type = smca_get_bank_type(bank);
+	bank_type = smca_get_bank_type(cpu, bank);
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
@@ -1043,12 +1054,12 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return NULL;
 	}
 
-	if (smca_banks[bank].hwid->count == 1)
+	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)
 		return smca_get_name(bank_type);
 
 	snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
-		 "%s_%x", smca_get_name(bank_type),
-			  smca_banks[bank].sysfs_id);
+		 "%s_%u", smca_get_name(bank_type),
+			  per_cpu(smca_banks, cpu)[bank].sysfs_id);
 	return buf_mcatype;
 }
 
@@ -1104,7 +1115,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	else
 		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1159,7 +1170,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
-	const char *name = get_name(bank, NULL);
+	const char *name = get_name(cpu, bank, NULL);
 	int err = 0;
 
 	if (!dev)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cfd3f7a..cc5c63f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1166,20 +1166,13 @@ static void decode_mc6_mce(struct mce *m)
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-	struct smca_hwid *hwid;
-	enum smca_bank_types bank_type;
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
-	if (m->bank >= ARRAY_SIZE(smca_banks))
+	if (bank_type >= N_SMCA_BANK_TYPES)
 		return;
 
-	hwid = smca_banks[m->bank].hwid;
-	if (!hwid)
-		return;
-
-	bank_type = hwid->bank_type;
-
 	if (bank_type == SMCA_RESERVED) {
 		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de..75dad02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2647,7 +2647,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	 * and error occurred in DramECC (Extended error code = 0) then only
 	 * process the error, else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
+	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
 		    (XEC(m->status, 0x3f) == 0x0)))
 		return NOTIFY_DONE;
 
