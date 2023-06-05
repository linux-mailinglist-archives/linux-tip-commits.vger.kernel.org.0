Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479967228A9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jun 2023 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjFEOUn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jun 2023 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjFEOPJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE44E6B;
        Mon,  5 Jun 2023 07:14:43 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4Le0FTPYxCXbV2Zr5oearYrg3ZFBDwKL41nZQePApU=;
        b=qLD6PBs5Daq8xOhPm6BnZ5/mkuP4l/27k1deb4fiHF8PgQaVpOQ8xc3iws21kg/rDfWCn3
        v2gizUn5RjvYJWc75Ap3Lqo1kSR2axWDJv0zd9q3eetIhO79q0+kdvC97APu/xTHpDb20U
        Nf9KhJMj9fzizw3Mr+n5O/AIO6iMYCNeBrO34FY1E082WGE4bprQ2JqV7g0/nX/NqEnCLB
        MKx00sur1nMVnJDP3c2F7KBGRBgtF9tP/iC4cSqSmqR5a9XHGo1j9W5q71qDTJccfZpa0d
        UG2JK5clFINyh5/TO1crTSM8XJPxB2hs0oRBaRuwbfJ+CiEG2uYsQY4zttg1uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4Le0FTPYxCXbV2Zr5oearYrg3ZFBDwKL41nZQePApU=;
        b=xUHYUWu8EowneAky6JyXY7A2FH9NdvItsZDYDxZqyUriWLwvZFeaqt9Fu5KPanCmPVqhUQ
        53vSPTAglCtYs5BQ==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Add support for AMD heterogeneous Family
 19h Model 30h-3Fh
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515113537.1052146-5-muralimk@amd.com>
References: <20230515113537.1052146-5-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <168597448152.404.16116665121944342890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9c42edd571aa4f8b2125b71e3924eeb0f6a54af1
Gitweb:        https://git.kernel.org/tip/9c42edd571aa4f8b2125b71e3924eeb0f6a54af1
Author:        Muralidhara M K <muralidhara.mk@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:36 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:27:18 +02:00

EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh

AMD Family 19h Model 30h-3Fh systems can be connected to AMD MI200
accelerator/GPU devices such that the CPU and GPU data fabrics are
connected together. In this configuration, the CPU manages error logging
and reporting for MCA banks located on the GPUs. This includes HBM memory
errors reported from Unified Memory Controllers (UMCs) on the GPUs.
The GPU memory errors are handled like CPU memory errors.

AMD CPU UMC support in EDAC can be re-used for GPU UMC support. However,
keeping them separate means drastic changes in one path (e.g. to support
newer products) should have less impact on the other path.

Also, simplify the "gpu_" helper functions where possible. GPU product
configuration, like memory type and channel count, is fixed compared to
CPU products.

GPU UMCs each have four physical connections (phys) connected to eight
channels. There is a single "chip select". This differs from CPUs where
each UMC has one physical connection connected to one channel, and each
channel has up to four "chip selects".

Enumerate each UMC "phy" as an EDAC CSROW, since there is only a single
chip select for each physical connection. This is similar to how a CPU
UMC "phy" is enumerated as an EDAC CHANNEL, since there is only a single
channel for each physical connection.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-5-muralimk@amd.com
---
 drivers/edac/amd64_edac.c | 310 +++++++++++++++++++++++++++++++++----
 1 file changed, 279 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5c4292e..28155b0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1426,12 +1426,47 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
+static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
+				  int csrow_nr, int dimm)
+{
+	u32 msb, weight, num_zero_bits;
+	u32 addr_mask_deinterleaved;
+	int size = 0;
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
+	 */
+	msb = fls(addr_mask_orig) - 1;
+	weight = hweight_long(addr_mask_orig);
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
+
+	/* Take the number of zero bits off from the top of the mask. */
+	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+
+	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
+	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+
+	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
+	size = (addr_mask_deinterleaved >> 2) + 1;
+
+	/* Return size in MBs. */
+	return size >> 10;
+}
+
 static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
 	int cs_mask_nr = csrow_nr;
+	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1475,33 +1510,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
 
-	/*
-	 * The number of zero bits in the mask is equal to the number of bits
-	 * in a full mask minus the number of bits in the current mask.
-	 *
-	 * The MSB is the number of bits in the full mask because BIT[0] is
-	 * always 0.
-	 *
-	 * In the special 3 Rank interleaving case, a single bit is flipped
-	 * without swapping with the most significant bit. This can be handled
-	 * by keeping the MSB where it is and ignoring the single zero bit.
-	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
-
-	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
-
-	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
-
-	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
-
-	/* Return size in MBs. */
-	return size >> 10;
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3675,6 +3684,221 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 	return 0;
 }
 
+/*
+ * The CPUs have one channel per UMC, so UMC number is equivalent to a
+ * channel number. The GPUs have 8 channels per UMC, so the UMC number no
+ * longer works as a channel number.
+ *
+ * The channel number within a GPU UMC is given in MCA_IPID[15:12].
+ * However, the IDs are split such that two UMC values go to one UMC, and
+ * the channel numbers are split in two groups of four.
+ *
+ * Refer to comment on gpu_get_umc_base().
+ *
+ * For example,
+ * UMC0 CH[3:0] = 0x0005[3:0]000
+ * UMC0 CH[7:4] = 0x0015[3:0]000
+ * UMC1 CH[3:0] = 0x0025[3:0]000
+ * UMC1 CH[7:4] = 0x0035[3:0]000
+ */
+static void gpu_get_err_info(struct mce *m, struct err_info *err)
+{
+	u8 ch = (m->ipid & GENMASK(31, 0)) >> 20;
+	u8 phy = ((m->ipid >> 12) & 0xf);
+
+	err->channel = ch % 2 ? phy + 4 : phy;
+	err->csrow = phy;
+}
+
+static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+}
+
+static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
+{
+	int size, cs_mode, cs = 0;
+
+	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
+
+	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	for_each_chip_select(cs, ctrl, pvt) {
+		size = gpu_addr_mask_to_cs_size(pvt, ctrl, cs_mode, cs);
+		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
+	}
+}
+
+static void gpu_dump_misc_regs(struct amd64_pvt *pvt)
+{
+	struct amd64_umc *umc;
+	u32 i;
+
+	for_each_umc(i) {
+		umc = &pvt->umc[i];
+
+		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
+		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
+		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+
+		gpu_debug_display_dimm_sizes(pvt, i);
+	}
+}
+
+static u32 gpu_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr)
+{
+	u32 nr_pages;
+	int cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	nr_pages   = gpu_addr_mask_to_cs_size(pvt, dct, cs_mode, csrow_nr);
+	nr_pages <<= 20 - PAGE_SHIFT;
+
+	edac_dbg(0, "csrow: %d, channel: %d\n", csrow_nr, dct);
+	edac_dbg(0, "nr_pages/channel: %u\n", nr_pages);
+
+	return nr_pages;
+}
+
+static void gpu_init_csrows(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+	struct dimm_info *dimm;
+	u8 umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			dimm = mci->csrows[umc]->channels[cs]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+				 pvt->mc_node_id, cs);
+
+			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->mtype = MEM_HBM2;
+			dimm->dtype = DEV_X16;
+			dimm->grain = 64;
+		}
+	}
+}
+
+static void gpu_setup_mci_misc_attrs(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+
+	mci->mtype_cap		= MEM_FLAG_HBM2;
+	mci->edac_ctl_cap	= EDAC_FLAG_SECDED;
+
+	mci->edac_cap		= EDAC_FLAG_EC;
+	mci->mod_name		= EDAC_MOD_STR;
+	mci->ctl_name		= pvt->ctl_name;
+	mci->dev_name		= pci_name(pvt->F3);
+	mci->ctl_page_to_phys	= NULL;
+
+	gpu_init_csrows(mci);
+}
+
+/* ECC is enabled by default on GPU nodes */
+static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
+{
+	return true;
+}
+
+static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
+{
+	/*
+	 * On CPUs, there is one channel per UMC, so UMC numbering equals
+	 * channel numbering. On GPUs, there are eight channels per UMC,
+	 * so the channel numbering is different from UMC numbering.
+	 *
+	 * On CPU nodes channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * On GPU nodes channels are selected in 3rd nibble
+	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
+	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 */
+	umc *= 2;
+
+	if (channel >= 4)
+		umc++;
+
+	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+}
+
+static void gpu_read_mc_regs(struct amd64_pvt *pvt)
+{
+	u8 nid = pvt->mc_node_id;
+	struct amd64_umc *umc;
+	u32 i, umc_base;
+
+	/* Read registers from each UMC */
+	for_each_umc(i) {
+		umc_base = gpu_get_umc_base(i, 0);
+		umc = &pvt->umc[i];
+
+		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
+		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
+		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+	}
+}
+
+static void gpu_read_base_mask(struct amd64_pvt *pvt)
+{
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			base_reg = gpu_get_umc_base(umc, cs) + UMCCH_BASE_ADDR;
+			base = &pvt->csels[umc].csbases[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+			}
+
+			mask_reg = gpu_get_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask = &pvt->csels[umc].csmasks[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
+				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+			}
+		}
+	}
+}
+
+static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 8;
+		pvt->csels[umc].m_cnt = 8;
+	}
+}
+
+static int gpu_hw_info_get(struct amd64_pvt *pvt)
+{
+	pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+	if (!pvt->umc)
+		return -ENOMEM;
+
+	gpu_prep_chip_selects(pvt);
+	gpu_read_base_mask(pvt);
+	gpu_read_mc_regs(pvt);
+
+	return 0;
+}
+
 static void hw_info_put(struct amd64_pvt *pvt)
 {
 	pci_dev_put(pvt->F1);
@@ -3690,6 +3914,14 @@ static struct low_ops umc_ops = {
 	.get_err_info			= umc_get_err_info,
 };
 
+static struct low_ops gpu_ops = {
+	.hw_info_get			= gpu_hw_info_get,
+	.ecc_enabled			= gpu_ecc_enabled,
+	.setup_mci_misc_attrs		= gpu_setup_mci_misc_attrs,
+	.dump_misc_regs			= gpu_dump_misc_regs,
+	.get_err_info			= gpu_get_err_info,
+};
+
 /* Use Family 16h versions for defaults and adjust as needed below. */
 static struct low_ops dct_ops = {
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
@@ -3813,6 +4045,16 @@ static int per_family_init(struct amd64_pvt *pvt)
 		case 0x20 ... 0x2f:
 			pvt->ctl_name			= "F19h_M20h";
 			break;
+		case 0x30 ... 0x3f:
+			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
+				pvt->ctl_name		= "MI200";
+				pvt->max_mcs		= 4;
+				pvt->ops		= &gpu_ops;
+			} else {
+				pvt->ctl_name		= "F19h_M30h";
+				pvt->max_mcs		= 8;
+			}
+			break;
 		case 0x50 ... 0x5f:
 			pvt->ctl_name			= "F19h_M50h";
 			break;
@@ -3846,11 +4088,17 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	struct edac_mc_layer layers[2];
 	int ret = -ENOMEM;
 
+	/*
+	 * For Heterogeneous family EDAC CHIP_SELECT and CHANNEL layers should
+	 * be swapped to fit into the layers.
+	 */
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
+			 pvt->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = pvt->max_mcs;
+	layers[1].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
+			 pvt->csels[0].b_cnt : pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
