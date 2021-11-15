Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313C450961
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhKOQUr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 11:20:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKOQUq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 11:20:46 -0500
Date:   Mon, 15 Nov 2021 16:17:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636993067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6T6vIXpHQQ/T09SMgZuAD+p/TLo/4KkBFHYAxi4Rjts=;
        b=Ymj1mAWU4daMh+OP3ePG61d1Rqtkn9+LytvM0SeIqBBRak8loXlvO5eYHjF1EAMJS2tRrM
        2my2q5NkEiCcbgn7w0hrucIQHqp9shsZzEDSk3zwbefVXMI0+MQNxjGL91BgA7nnGBPXLr
        pCEBaDX3ErIQsSY6Z1Vz3NM2M/NZTt/INty1NxQ7w5wB9g7im6iAeI0/CIciEB9JLGll+V
        5ciBmaVH1lgUF4XQGh0IJDp7AToee88SzzyA875Ww1ldbbe9lbtNWXZ3CGtKDnNKfDwBGm
        V0o5DG3mtH5XDYluKjwG9hy44FcZAqTDMovD1i2xJuL/mnLjVoHvjViy3+ba4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636993067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6T6vIXpHQQ/T09SMgZuAD+p/TLo/4KkBFHYAxi4Rjts=;
        b=/dW08N395I1zuoDvr3hn6JpcZd//LHjwPNaPFo0SPalF4AbPeuBPh9X6vlrIOzDFD+Mgtg
        ZhU2ut9D3OGjyFBg==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211028175728.121452-3-yazen.ghannam@amd.com>
References: <20211028175728.121452-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <163699306654.414.4924626954602375307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     b3218ae47771f943b3e222f35fc46afacba39929
Gitweb:        https://git.kernel.org/tip/b3218ae47771f943b3e222f35fc46afacba39929
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 28 Oct 2021 17:56:57 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 12:44:47 +01:00

x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC

df_indirect_read() is used only for address translation. Move it to EDAC
along with the translation code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211028175728.121452-3-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_nb.h |  1 +-
 arch/x86/kernel/amd_nb.c      | 49 +---------------------------------
 drivers/edac/amd64_edac.c     | 50 ++++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a..00d1a40 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -24,7 +24,6 @@ extern int amd_set_subcaches(int, unsigned long);
 
 extern int amd_smn_read(u16 node, u32 address, u32 *value);
 extern int amd_smn_write(u16 node, u32 address, u32 value);
-extern int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c92c9c7..f814d5f 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -29,7 +29,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 
-/* Protect the PCI config register pairs used for SMN and DF indirect access. */
+/* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
@@ -182,53 +182,6 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- */
-int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_northbridges.num)
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&smn_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_df_indirect_read);
 
 int amd_cache_northbridges(void)
 {
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d2ad9f0..034d986 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -988,6 +988,56 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/* Protect the PCI config register pairs used for DF indirect access. */
+static DEFINE_MUTEX(df_indirect_mutex);
+
+/*
+ * Data Fabric Indirect Access uses FICAA/FICAD.
+ *
+ * Fabric Indirect Configuration Access Address (FICAA): Constructed based
+ * on the device's Instance Id and the PCI function and register offset of
+ * the desired register.
+ *
+ * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
+ * and FICAD HI registers but so far we only need the LO register.
+ */
+static int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
+{
+	struct pci_dev *F4;
+	u32 ficaa;
+	int err = -ENODEV;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	F4 = node_to_amd_nb(node)->link;
+	if (!F4)
+		goto out;
+
+	ficaa  = 1;
+	ficaa |= reg & 0x3FC;
+	ficaa |= (func & 0x7) << 11;
+	ficaa |= instance_id << 16;
+
+	mutex_lock(&df_indirect_mutex);
+
+	err = pci_write_config_dword(F4, 0x5C, ficaa);
+	if (err) {
+		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
+		goto out_unlock;
+	}
+
+	err = pci_read_config_dword(F4, 0x98, lo);
+	if (err)
+		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
+
+out_unlock:
+	mutex_unlock(&df_indirect_mutex);
+
+out:
+	return err;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
