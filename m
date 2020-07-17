Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE7223EBE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGQOv0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 10:51:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41192 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGQOvY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:24 -0400
Date:   Fri, 17 Jul 2020 14:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O79EWLgxuNX4YZ3YfoTedqtLm778sEg3BkVJQdiZYb0=;
        b=g2EIMc3bUPr5Z38mbhfjUlVjRA/9nCIMAISGN8hT0lqFScmkAwnushYQ8Oxr8xP3O3eT8M
        io2PpOeu5rgmvgpaJtYkuNlNBnl8dhcCsNS7jKHs6sHwHmEudwcJrpX3v+mqU4mwr9Ybjl
        6JLulhw2T0dH0Z2RdeIyLl/yJ7mtlpEzXapJuNYXFroKG3W+2GeZyt4Ax21mHbbCXMmnPo
        XCP4fSuC/X89Sw/fS+Ha2NpvIt/yBMFhSKhHrvDGDbTF1VT5ZUIbdkqhN4XYrHp/lqEyv5
        ytWwgoiQpXWPgcpdZNJX9aVTVBX+EbjtwwQNMNqaaDDkk4MBdJ0siC1+34oLeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O79EWLgxuNX4YZ3YfoTedqtLm778sEg3BkVJQdiZYb0=;
        b=y0KbXjzB7owpkI2nOQ1y3o+MT9SXp+ReBEllQs1viP/FMBJqRekSjd2KZ7VeYFxOGRyfUH
        5zYv1zvd4+kVwHBg==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for UV1 platform
 from uv_mmrs
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212954.964332370@hpe.com>
References: <20200713212954.964332370@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747177.4006.6326659962208419166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     3736e82d3a31bdea5a38877d968366dfa60c766e
Gitweb:        https://git.kernel.org/tip/3736e82d3a31bdea5a38877d968366dfa60c766e
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:29:58 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:44 +02:00

x86/platform/uv: Remove support for UV1 platform from uv_mmrs

UV1 is not longer supported.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212954.964332370@hpe.com

---
 arch/x86/include/asm/uv/uv_mmrs.h | 712 +-----------------------------
 1 file changed, 712 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 9ee5ed6..775bf14 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -19,7 +19,6 @@
  *
  * UVH  - definitions common to all UV hub types.
  * UVXH - definitions common to all UV eXtended hub types (currently 2, 3, 4).
- * UV1H - definitions specific to UV type 1 hub.
  * UV2H - definitions specific to UV type 2 hub.
  * UV3H - definitions specific to UV type 3 hub.
  * UV4H - definitions specific to UV type 4 hub.
@@ -35,19 +34,6 @@
  *
  * If the MMR exists on all hub types but have different addresses,
  * use a conditional operator to define the value at runtime.
- *	#define UV1Hxxx	a
- *	#define UV2Hxxx	b
- *	#define UV3Hxxx	c
- *	#define UV4Hxxx	d
- *	#define UV4AHxxx e
- *	#define UVHxxx	(is_uv1_hub() ? UV1Hxxx :
- *			(is_uv2_hub() ? UV2Hxxx :
- *			(is_uv3_hub() ? UV3Hxxx :
- *			(is_uv4a_hub() ? UV4AHxxx :
- *					UV4Hxxx))
- *
- * If the MMR exists on all hub types > 1 but have different addresses, the
- * variation using "UVX" as the prefix exists.
  *	#define UV2Hxxx	b
  *	#define UV3Hxxx	c
  *	#define UV4Hxxx	d
@@ -61,8 +47,6 @@
  *		unsigned long       v;
  *		struct uvh_xxx_s {	 # Common fields only
  *		} s;
- *		struct uv1h_xxx_s {	 # Full UV1 definition (*)
- *		} s1;
  *		struct uv2h_xxx_s {	 # Full UV2 definition (*)
  *		} s2;
  *		struct uv3h_xxx_s {	 # Full UV3 definition (*)
@@ -92,7 +76,6 @@
 
 #define UV_MMR_ENABLE		(1UL << 63)
 
-#define UV1_HUB_PART_NUMBER	0x88a5
 #define UV2_HUB_PART_NUMBER	0x8eb8
 #define UV2_HUB_PART_NUMBER_X	0x1111
 #define UV3_HUB_PART_NUMBER	0x9578
@@ -107,12 +90,10 @@ extern unsigned long uv_undefined(char *str);
 /* ========================================================================= */
 #define UVH_BAU_DATA_BROADCAST 0x61688UL
 
-#define UV1H_BAU_DATA_BROADCAST_32 0x440
 #define UV2H_BAU_DATA_BROADCAST_32 0x440
 #define UV3H_BAU_DATA_BROADCAST_32 0x440
 #define UV4H_BAU_DATA_BROADCAST_32 0x360
 #define UVH_BAU_DATA_BROADCAST_32 (					\
-	is_uv1_hub() ? UV1H_BAU_DATA_BROADCAST_32 :			\
 	is_uv2_hub() ? UV2H_BAU_DATA_BROADCAST_32 :			\
 	is_uv3_hub() ? UV3H_BAU_DATA_BROADCAST_32 :			\
 	/*is_uv4_hub*/ UV4H_BAU_DATA_BROADCAST_32)
@@ -134,12 +115,10 @@ union uvh_bau_data_broadcast_u {
 /* ========================================================================= */
 #define UVH_BAU_DATA_CONFIG 0x61680UL
 
-#define UV1H_BAU_DATA_CONFIG_32 0x438
 #define UV2H_BAU_DATA_CONFIG_32 0x438
 #define UV3H_BAU_DATA_CONFIG_32 0x438
 #define UV4H_BAU_DATA_CONFIG_32 0x358
 #define UVH_BAU_DATA_CONFIG_32 (					\
-	is_uv1_hub() ? UV1H_BAU_DATA_CONFIG_32 :			\
 	is_uv2_hub() ? UV2H_BAU_DATA_CONFIG_32 :			\
 	is_uv3_hub() ? UV3H_BAU_DATA_CONFIG_32 :			\
 	/*is_uv4_hub*/ UV4H_BAU_DATA_CONFIG_32)
@@ -189,117 +168,6 @@ union uvh_bau_data_config_u {
 #define UVH_EVENT_OCCURRED0_LB_HCERR_MASK		0x0000000000000001UL
 #define UVH_EVENT_OCCURRED0_RH_AOERR0_MASK		0x0000000000000800UL
 
-#define UV1H_EVENT_OCCURRED0_GR0_HCERR_SHFT		1
-#define UV1H_EVENT_OCCURRED0_GR1_HCERR_SHFT		2
-#define UV1H_EVENT_OCCURRED0_LH_HCERR_SHFT		3
-#define UV1H_EVENT_OCCURRED0_RH_HCERR_SHFT		4
-#define UV1H_EVENT_OCCURRED0_XN_HCERR_SHFT		5
-#define UV1H_EVENT_OCCURRED0_SI_HCERR_SHFT		6
-#define UV1H_EVENT_OCCURRED0_LB_AOERR0_SHFT		7
-#define UV1H_EVENT_OCCURRED0_GR0_AOERR0_SHFT		8
-#define UV1H_EVENT_OCCURRED0_GR1_AOERR0_SHFT		9
-#define UV1H_EVENT_OCCURRED0_LH_AOERR0_SHFT		10
-#define UV1H_EVENT_OCCURRED0_XN_AOERR0_SHFT		12
-#define UV1H_EVENT_OCCURRED0_SI_AOERR0_SHFT		13
-#define UV1H_EVENT_OCCURRED0_LB_AOERR1_SHFT		14
-#define UV1H_EVENT_OCCURRED0_GR0_AOERR1_SHFT		15
-#define UV1H_EVENT_OCCURRED0_GR1_AOERR1_SHFT		16
-#define UV1H_EVENT_OCCURRED0_LH_AOERR1_SHFT		17
-#define UV1H_EVENT_OCCURRED0_RH_AOERR1_SHFT		18
-#define UV1H_EVENT_OCCURRED0_XN_AOERR1_SHFT		19
-#define UV1H_EVENT_OCCURRED0_SI_AOERR1_SHFT		20
-#define UV1H_EVENT_OCCURRED0_RH_VPI_INT_SHFT		21
-#define UV1H_EVENT_OCCURRED0_SYSTEM_SHUTDOWN_INT_SHFT	22
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_0_SHFT		23
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_1_SHFT		24
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_2_SHFT		25
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_3_SHFT		26
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_4_SHFT		27
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_5_SHFT		28
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_6_SHFT		29
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_7_SHFT		30
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_8_SHFT		31
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_9_SHFT		32
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_10_SHFT		33
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_11_SHFT		34
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_12_SHFT		35
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_13_SHFT		36
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_14_SHFT		37
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_15_SHFT		38
-#define UV1H_EVENT_OCCURRED0_L1_NMI_INT_SHFT		39
-#define UV1H_EVENT_OCCURRED0_STOP_CLOCK_SHFT		40
-#define UV1H_EVENT_OCCURRED0_ASIC_TO_L1_SHFT		41
-#define UV1H_EVENT_OCCURRED0_L1_TO_ASIC_SHFT		42
-#define UV1H_EVENT_OCCURRED0_LTC_INT_SHFT		43
-#define UV1H_EVENT_OCCURRED0_LA_SEQ_TRIGGER_SHFT	44
-#define UV1H_EVENT_OCCURRED0_IPI_INT_SHFT		45
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT0_SHFT		46
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT1_SHFT		47
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT2_SHFT		48
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT3_SHFT		49
-#define UV1H_EVENT_OCCURRED0_PROFILE_INT_SHFT		50
-#define UV1H_EVENT_OCCURRED0_RTC0_SHFT			51
-#define UV1H_EVENT_OCCURRED0_RTC1_SHFT			52
-#define UV1H_EVENT_OCCURRED0_RTC2_SHFT			53
-#define UV1H_EVENT_OCCURRED0_RTC3_SHFT			54
-#define UV1H_EVENT_OCCURRED0_BAU_DATA_SHFT		55
-#define UV1H_EVENT_OCCURRED0_POWER_MANAGEMENT_REQ_SHFT	56
-#define UV1H_EVENT_OCCURRED0_GR0_HCERR_MASK		0x0000000000000002UL
-#define UV1H_EVENT_OCCURRED0_GR1_HCERR_MASK		0x0000000000000004UL
-#define UV1H_EVENT_OCCURRED0_LH_HCERR_MASK		0x0000000000000008UL
-#define UV1H_EVENT_OCCURRED0_RH_HCERR_MASK		0x0000000000000010UL
-#define UV1H_EVENT_OCCURRED0_XN_HCERR_MASK		0x0000000000000020UL
-#define UV1H_EVENT_OCCURRED0_SI_HCERR_MASK		0x0000000000000040UL
-#define UV1H_EVENT_OCCURRED0_LB_AOERR0_MASK		0x0000000000000080UL
-#define UV1H_EVENT_OCCURRED0_GR0_AOERR0_MASK		0x0000000000000100UL
-#define UV1H_EVENT_OCCURRED0_GR1_AOERR0_MASK		0x0000000000000200UL
-#define UV1H_EVENT_OCCURRED0_LH_AOERR0_MASK		0x0000000000000400UL
-#define UV1H_EVENT_OCCURRED0_XN_AOERR0_MASK		0x0000000000001000UL
-#define UV1H_EVENT_OCCURRED0_SI_AOERR0_MASK		0x0000000000002000UL
-#define UV1H_EVENT_OCCURRED0_LB_AOERR1_MASK		0x0000000000004000UL
-#define UV1H_EVENT_OCCURRED0_GR0_AOERR1_MASK		0x0000000000008000UL
-#define UV1H_EVENT_OCCURRED0_GR1_AOERR1_MASK		0x0000000000010000UL
-#define UV1H_EVENT_OCCURRED0_LH_AOERR1_MASK		0x0000000000020000UL
-#define UV1H_EVENT_OCCURRED0_RH_AOERR1_MASK		0x0000000000040000UL
-#define UV1H_EVENT_OCCURRED0_XN_AOERR1_MASK		0x0000000000080000UL
-#define UV1H_EVENT_OCCURRED0_SI_AOERR1_MASK		0x0000000000100000UL
-#define UV1H_EVENT_OCCURRED0_RH_VPI_INT_MASK		0x0000000000200000UL
-#define UV1H_EVENT_OCCURRED0_SYSTEM_SHUTDOWN_INT_MASK	0x0000000000400000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_0_MASK		0x0000000000800000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_1_MASK		0x0000000001000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_2_MASK		0x0000000002000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_3_MASK		0x0000000004000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_4_MASK		0x0000000008000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_5_MASK		0x0000000010000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_6_MASK		0x0000000020000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_7_MASK		0x0000000040000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_8_MASK		0x0000000080000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_9_MASK		0x0000000100000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_10_MASK		0x0000000200000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_11_MASK		0x0000000400000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_12_MASK		0x0000000800000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_13_MASK		0x0000001000000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_14_MASK		0x0000002000000000UL
-#define UV1H_EVENT_OCCURRED0_LB_IRQ_INT_15_MASK		0x0000004000000000UL
-#define UV1H_EVENT_OCCURRED0_L1_NMI_INT_MASK		0x0000008000000000UL
-#define UV1H_EVENT_OCCURRED0_STOP_CLOCK_MASK		0x0000010000000000UL
-#define UV1H_EVENT_OCCURRED0_ASIC_TO_L1_MASK		0x0000020000000000UL
-#define UV1H_EVENT_OCCURRED0_L1_TO_ASIC_MASK		0x0000040000000000UL
-#define UV1H_EVENT_OCCURRED0_LTC_INT_MASK		0x0000080000000000UL
-#define UV1H_EVENT_OCCURRED0_LA_SEQ_TRIGGER_MASK	0x0000100000000000UL
-#define UV1H_EVENT_OCCURRED0_IPI_INT_MASK		0x0000200000000000UL
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT0_MASK		0x0000400000000000UL
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT1_MASK		0x0000800000000000UL
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT2_MASK		0x0001000000000000UL
-#define UV1H_EVENT_OCCURRED0_EXTIO_INT3_MASK		0x0002000000000000UL
-#define UV1H_EVENT_OCCURRED0_PROFILE_INT_MASK		0x0004000000000000UL
-#define UV1H_EVENT_OCCURRED0_RTC0_MASK			0x0008000000000000UL
-#define UV1H_EVENT_OCCURRED0_RTC1_MASK			0x0010000000000000UL
-#define UV1H_EVENT_OCCURRED0_RTC2_MASK			0x0020000000000000UL
-#define UV1H_EVENT_OCCURRED0_RTC3_MASK			0x0040000000000000UL
-#define UV1H_EVENT_OCCURRED0_BAU_DATA_MASK		0x0080000000000000UL
-#define UV1H_EVENT_OCCURRED0_POWER_MANAGEMENT_REQ_MASK	0x0100000000000000UL
-
 #define UVXH_EVENT_OCCURRED0_RH_HCERR_SHFT		2
 #define UVXH_EVENT_OCCURRED0_LH0_HCERR_SHFT		3
 #define UVXH_EVENT_OCCURRED0_LH1_HCERR_SHFT		4
@@ -605,7 +473,6 @@ union uvh_bau_data_config_u {
 #define UV4H_EVENT_OCCURRED0_EXTIO_INT3_MASK		0x8000000000000000UL
 
 #define UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT (				\
-	is_uv1_hub() ? UV1H_EVENT_OCCURRED0_EXTIO_INT0_SHFT :		\
 	is_uv2_hub() ? UV2H_EVENT_OCCURRED0_EXTIO_INT0_SHFT :		\
 	is_uv3_hub() ? UV3H_EVENT_OCCURRED0_EXTIO_INT0_SHFT :		\
 	/*is_uv4_hub*/ UV4H_EVENT_OCCURRED0_EXTIO_INT0_SHFT)
@@ -718,12 +585,10 @@ union uvh_event_occurred0_u {
 /* ========================================================================= */
 #define UVH_EXTIO_INT0_BROADCAST 0x61448UL
 
-#define UV1H_EXTIO_INT0_BROADCAST_32 0x3f0
 #define UV2H_EXTIO_INT0_BROADCAST_32 0x3f0
 #define UV3H_EXTIO_INT0_BROADCAST_32 0x3f0
 #define UV4H_EXTIO_INT0_BROADCAST_32 0x310
 #define UVH_EXTIO_INT0_BROADCAST_32 (					\
-	is_uv1_hub() ? UV1H_EXTIO_INT0_BROADCAST_32 :			\
 	is_uv2_hub() ? UV2H_EXTIO_INT0_BROADCAST_32 :			\
 	is_uv3_hub() ? UV3H_EXTIO_INT0_BROADCAST_32 :			\
 	/*is_uv4_hub*/ UV4H_EXTIO_INT0_BROADCAST_32)
@@ -821,12 +686,10 @@ union uvh_gr0_tlb_int1_config_u {
 /* ========================================================================= */
 /*                         UVH_GR0_TLB_MMR_CONTROL                           */
 /* ========================================================================= */
-#define UV1H_GR0_TLB_MMR_CONTROL 0x401080UL
 #define UV2H_GR0_TLB_MMR_CONTROL 0xc01080UL
 #define UV3H_GR0_TLB_MMR_CONTROL 0xc01080UL
 #define UV4H_GR0_TLB_MMR_CONTROL 0x601080UL
 #define UVH_GR0_TLB_MMR_CONTROL (					\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_CONTROL :			\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_CONTROL :			\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_CONTROL :			\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_CONTROL)
@@ -841,29 +704,6 @@ union uvh_gr0_tlb_int1_config_u {
 #define UVH_GR0_TLB_MMR_CONTROL_MMR_WRITE_MASK		0x0000000040000000UL
 #define UVH_GR0_TLB_MMR_CONTROL_MMR_READ_MASK		0x0000000080000000UL
 
-#define UV1H_GR0_TLB_MMR_CONTROL_INDEX_SHFT		0
-#define UV1H_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT		12
-#define UV1H_GR0_TLB_MMR_CONTROL_AUTO_VALID_EN_SHFT	16
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_SHFT	20
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_WRITE_SHFT		30
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_READ_SHFT		31
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_CON_SHFT	48
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBRAM_SHFT	52
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBPGSIZE_SHFT	54
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBRREG_SHFT	56
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBLRUV_SHFT	60
-#define UV1H_GR0_TLB_MMR_CONTROL_INDEX_MASK		0x0000000000000fffUL
-#define UV1H_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK		0x0000000000003000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_AUTO_VALID_EN_MASK	0x0000000000010000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_MASK	0x0000000000100000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_WRITE_MASK		0x0000000040000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_READ_MASK		0x0000000080000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_CON_MASK	0x0001000000000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBRAM_MASK	0x0010000000000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBPGSIZE_MASK	0x0040000000000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBRREG_MASK	0x0100000000000000UL
-#define UV1H_GR0_TLB_MMR_CONTROL_MMR_INJ_TLBLRUV_MASK	0x1000000000000000UL
-
 #define UVXH_GR0_TLB_MMR_CONTROL_INDEX_SHFT		0
 #define UVXH_GR0_TLB_MMR_CONTROL_AUTO_VALID_EN_SHFT	16
 #define UVXH_GR0_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_SHFT	20
@@ -932,17 +772,14 @@ union uvh_gr0_tlb_int1_config_u {
 #define UV4H_GR0_TLB_MMR_CONTROL_PAGE_SIZE_MASK		0xf800000000000000UL
 
 #define UVH_GR0_TLB_MMR_CONTROL_INDEX_MASK (				\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_CONTROL_INDEX_MASK :		\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_CONTROL_INDEX_MASK :		\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_CONTROL_INDEX_MASK :		\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_CONTROL_INDEX_MASK)
 #define UVH_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK (				\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK :		\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK :		\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK :		\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_CONTROL_MEM_SEL_MASK)
 #define UVH_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT (				\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT :		\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT :		\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT :		\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_CONTROL_MEM_SEL_SHFT)
@@ -961,28 +798,6 @@ union uvh_gr0_tlb_mmr_control_u {
 		unsigned long	rsvd_49_51:3;
 		unsigned long	rsvd_52_63:12;
 	} s;
-	struct uv1h_gr0_tlb_mmr_control_s {
-		unsigned long	index:12;			/* RW */
-		unsigned long	mem_sel:2;			/* RW */
-		unsigned long	rsvd_14_15:2;
-		unsigned long	auto_valid_en:1;		/* RW */
-		unsigned long	rsvd_17_19:3;
-		unsigned long	mmr_hash_index_en:1;		/* RW */
-		unsigned long	rsvd_21_29:9;
-		unsigned long	mmr_write:1;			/* WP */
-		unsigned long	mmr_read:1;			/* WP */
-		unsigned long	rsvd_32_47:16;
-		unsigned long	mmr_inj_con:1;			/* RW */
-		unsigned long	rsvd_49_51:3;
-		unsigned long	mmr_inj_tlbram:1;		/* RW */
-		unsigned long	rsvd_53:1;
-		unsigned long	mmr_inj_tlbpgsize:1;		/* RW */
-		unsigned long	rsvd_55:1;
-		unsigned long	mmr_inj_tlbrreg:1;		/* RW */
-		unsigned long	rsvd_57_59:3;
-		unsigned long	mmr_inj_tlblruv:1;		/* RW */
-		unsigned long	rsvd_61_63:3;
-	} s1;
 	struct uvxh_gr0_tlb_mmr_control_s {
 		unsigned long	rsvd_0_15:16;
 		unsigned long	auto_valid_en:1;		/* RW */
@@ -1055,27 +870,16 @@ union uvh_gr0_tlb_mmr_control_u {
 /* ========================================================================= */
 /*                       UVH_GR0_TLB_MMR_READ_DATA_HI                        */
 /* ========================================================================= */
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI 0x4010a0UL
 #define UV2H_GR0_TLB_MMR_READ_DATA_HI 0xc010a0UL
 #define UV3H_GR0_TLB_MMR_READ_DATA_HI 0xc010a0UL
 #define UV4H_GR0_TLB_MMR_READ_DATA_HI 0x6010a0UL
 #define UVH_GR0_TLB_MMR_READ_DATA_HI (					\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_READ_DATA_HI :			\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_READ_DATA_HI :			\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_READ_DATA_HI :			\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_READ_DATA_HI)
 
 #define UVH_GR0_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
 
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_GAA_SHFT		41
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_DIRTY_SHFT	43
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_LARGER_SHFT	44
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_PFN_MASK		0x000001ffffffffffUL
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_GAA_MASK		0x0000060000000000UL
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_DIRTY_MASK	0x0000080000000000UL
-#define UV1H_GR0_TLB_MMR_READ_DATA_HI_LARGER_MASK	0x0000100000000000UL
-
 #define UVXH_GR0_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
 
 #define UV2H_GR0_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
@@ -1118,13 +922,6 @@ union uvh_gr0_tlb_mmr_control_u {
 
 union uvh_gr0_tlb_mmr_read_data_hi_u {
 	unsigned long	v;
-	struct uv1h_gr0_tlb_mmr_read_data_hi_s {
-		unsigned long	pfn:41;				/* RO */
-		unsigned long	gaa:2;				/* RO */
-		unsigned long	dirty:1;			/* RO */
-		unsigned long	larger:1;			/* RO */
-		unsigned long	rsvd_45_63:19;
-	} s1;
 	struct uv2h_gr0_tlb_mmr_read_data_hi_s {
 		unsigned long	pfn:41;				/* RO */
 		unsigned long	gaa:2;				/* RO */
@@ -1156,12 +953,10 @@ union uvh_gr0_tlb_mmr_read_data_hi_u {
 /* ========================================================================= */
 /*                       UVH_GR0_TLB_MMR_READ_DATA_LO                        */
 /* ========================================================================= */
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO 0x4010a8UL
 #define UV2H_GR0_TLB_MMR_READ_DATA_LO 0xc010a8UL
 #define UV3H_GR0_TLB_MMR_READ_DATA_LO 0xc010a8UL
 #define UV4H_GR0_TLB_MMR_READ_DATA_LO 0x6010a8UL
 #define UVH_GR0_TLB_MMR_READ_DATA_LO (					\
-	is_uv1_hub() ? UV1H_GR0_TLB_MMR_READ_DATA_LO :			\
 	is_uv2_hub() ? UV2H_GR0_TLB_MMR_READ_DATA_LO :			\
 	is_uv3_hub() ? UV3H_GR0_TLB_MMR_READ_DATA_LO :			\
 	/*is_uv4_hub*/ UV4H_GR0_TLB_MMR_READ_DATA_LO)
@@ -1173,13 +968,6 @@ union uvh_gr0_tlb_mmr_read_data_hi_u {
 #define UVH_GR0_TLB_MMR_READ_DATA_LO_ASID_MASK		0x7fffff8000000000UL
 #define UVH_GR0_TLB_MMR_READ_DATA_LO_VALID_MASK		0x8000000000000000UL
 
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_VPN_SHFT		0
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_ASID_SHFT		39
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_VALID_SHFT	63
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_VPN_MASK		0x0000007fffffffffUL
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_ASID_MASK		0x7fffff8000000000UL
-#define UV1H_GR0_TLB_MMR_READ_DATA_LO_VALID_MASK	0x8000000000000000UL
-
 #define UVXH_GR0_TLB_MMR_READ_DATA_LO_VPN_SHFT		0
 #define UVXH_GR0_TLB_MMR_READ_DATA_LO_ASID_SHFT		39
 #define UVXH_GR0_TLB_MMR_READ_DATA_LO_VALID_SHFT	63
@@ -1216,11 +1004,6 @@ union uvh_gr0_tlb_mmr_read_data_lo_u {
 		unsigned long	asid:24;			/* RO */
 		unsigned long	valid:1;			/* RO */
 	} s;
-	struct uv1h_gr0_tlb_mmr_read_data_lo_s {
-		unsigned long	vpn:39;				/* RO */
-		unsigned long	asid:24;			/* RO */
-		unsigned long	valid:1;			/* RO */
-	} s1;
 	struct uvxh_gr0_tlb_mmr_read_data_lo_s {
 		unsigned long	vpn:39;				/* RO */
 		unsigned long	asid:24;			/* RO */
@@ -1246,12 +1029,10 @@ union uvh_gr0_tlb_mmr_read_data_lo_u {
 /* ========================================================================= */
 /*                         UVH_GR1_TLB_INT0_CONFIG                           */
 /* ========================================================================= */
-#define UV1H_GR1_TLB_INT0_CONFIG 0x61f00UL
 #define UV2H_GR1_TLB_INT0_CONFIG 0x61f00UL
 #define UV3H_GR1_TLB_INT0_CONFIG 0x61f00UL
 #define UV4H_GR1_TLB_INT0_CONFIG 0x62100UL
 #define UVH_GR1_TLB_INT0_CONFIG (					\
-	is_uv1_hub() ? UV1H_GR1_TLB_INT0_CONFIG :			\
 	is_uv2_hub() ? UV2H_GR1_TLB_INT0_CONFIG :			\
 	is_uv3_hub() ? UV3H_GR1_TLB_INT0_CONFIG :			\
 	/*is_uv4_hub*/ UV4H_GR1_TLB_INT0_CONFIG)
@@ -1293,12 +1074,10 @@ union uvh_gr1_tlb_int0_config_u {
 /* ========================================================================= */
 /*                         UVH_GR1_TLB_INT1_CONFIG                           */
 /* ========================================================================= */
-#define UV1H_GR1_TLB_INT1_CONFIG 0x61f40UL
 #define UV2H_GR1_TLB_INT1_CONFIG 0x61f40UL
 #define UV3H_GR1_TLB_INT1_CONFIG 0x61f40UL
 #define UV4H_GR1_TLB_INT1_CONFIG 0x62140UL
 #define UVH_GR1_TLB_INT1_CONFIG (					\
-	is_uv1_hub() ? UV1H_GR1_TLB_INT1_CONFIG :			\
 	is_uv2_hub() ? UV2H_GR1_TLB_INT1_CONFIG :			\
 	is_uv3_hub() ? UV3H_GR1_TLB_INT1_CONFIG :			\
 	/*is_uv4_hub*/ UV4H_GR1_TLB_INT1_CONFIG)
@@ -1340,12 +1119,10 @@ union uvh_gr1_tlb_int1_config_u {
 /* ========================================================================= */
 /*                         UVH_GR1_TLB_MMR_CONTROL                           */
 /* ========================================================================= */
-#define UV1H_GR1_TLB_MMR_CONTROL 0x801080UL
 #define UV2H_GR1_TLB_MMR_CONTROL 0x1001080UL
 #define UV3H_GR1_TLB_MMR_CONTROL 0x1001080UL
 #define UV4H_GR1_TLB_MMR_CONTROL 0x701080UL
 #define UVH_GR1_TLB_MMR_CONTROL (					\
-	is_uv1_hub() ? UV1H_GR1_TLB_MMR_CONTROL :			\
 	is_uv2_hub() ? UV2H_GR1_TLB_MMR_CONTROL :			\
 	is_uv3_hub() ? UV3H_GR1_TLB_MMR_CONTROL :			\
 	/*is_uv4_hub*/ UV4H_GR1_TLB_MMR_CONTROL)
@@ -1360,29 +1137,6 @@ union uvh_gr1_tlb_int1_config_u {
 #define UVH_GR1_TLB_MMR_CONTROL_MMR_WRITE_MASK		0x0000000040000000UL
 #define UVH_GR1_TLB_MMR_CONTROL_MMR_READ_MASK		0x0000000080000000UL
 
-#define UV1H_GR1_TLB_MMR_CONTROL_INDEX_SHFT		0
-#define UV1H_GR1_TLB_MMR_CONTROL_MEM_SEL_SHFT		12
-#define UV1H_GR1_TLB_MMR_CONTROL_AUTO_VALID_EN_SHFT	16
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_SHFT	20
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_WRITE_SHFT		30
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_READ_SHFT		31
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_CON_SHFT	48
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBRAM_SHFT	52
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBPGSIZE_SHFT	54
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBRREG_SHFT	56
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBLRUV_SHFT	60
-#define UV1H_GR1_TLB_MMR_CONTROL_INDEX_MASK		0x0000000000000fffUL
-#define UV1H_GR1_TLB_MMR_CONTROL_MEM_SEL_MASK		0x0000000000003000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_AUTO_VALID_EN_MASK	0x0000000000010000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_MASK	0x0000000000100000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_WRITE_MASK		0x0000000040000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_READ_MASK		0x0000000080000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_CON_MASK	0x0001000000000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBRAM_MASK	0x0010000000000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBPGSIZE_MASK	0x0040000000000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBRREG_MASK	0x0100000000000000UL
-#define UV1H_GR1_TLB_MMR_CONTROL_MMR_INJ_TLBLRUV_MASK	0x1000000000000000UL
-
 #define UVXH_GR1_TLB_MMR_CONTROL_INDEX_SHFT		0
 #define UVXH_GR1_TLB_MMR_CONTROL_AUTO_VALID_EN_SHFT	16
 #define UVXH_GR1_TLB_MMR_CONTROL_MMR_HASH_INDEX_EN_SHFT	20
@@ -1465,28 +1219,6 @@ union uvh_gr1_tlb_mmr_control_u {
 		unsigned long	rsvd_49_51:3;
 		unsigned long	rsvd_52_63:12;
 	} s;
-	struct uv1h_gr1_tlb_mmr_control_s {
-		unsigned long	index:12;			/* RW */
-		unsigned long	mem_sel:2;			/* RW */
-		unsigned long	rsvd_14_15:2;
-		unsigned long	auto_valid_en:1;		/* RW */
-		unsigned long	rsvd_17_19:3;
-		unsigned long	mmr_hash_index_en:1;		/* RW */
-		unsigned long	rsvd_21_29:9;
-		unsigned long	mmr_write:1;			/* WP */
-		unsigned long	mmr_read:1;			/* WP */
-		unsigned long	rsvd_32_47:16;
-		unsigned long	mmr_inj_con:1;			/* RW */
-		unsigned long	rsvd_49_51:3;
-		unsigned long	mmr_inj_tlbram:1;		/* RW */
-		unsigned long	rsvd_53:1;
-		unsigned long	mmr_inj_tlbpgsize:1;		/* RW */
-		unsigned long	rsvd_55:1;
-		unsigned long	mmr_inj_tlbrreg:1;		/* RW */
-		unsigned long	rsvd_57_59:3;
-		unsigned long	mmr_inj_tlblruv:1;		/* RW */
-		unsigned long	rsvd_61_63:3;
-	} s1;
 	struct uvxh_gr1_tlb_mmr_control_s {
 		unsigned long	rsvd_0_15:16;
 		unsigned long	auto_valid_en:1;		/* RW */
@@ -1559,27 +1291,16 @@ union uvh_gr1_tlb_mmr_control_u {
 /* ========================================================================= */
 /*                       UVH_GR1_TLB_MMR_READ_DATA_HI                        */
 /* ========================================================================= */
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI 0x8010a0UL
 #define UV2H_GR1_TLB_MMR_READ_DATA_HI 0x10010a0UL
 #define UV3H_GR1_TLB_MMR_READ_DATA_HI 0x10010a0UL
 #define UV4H_GR1_TLB_MMR_READ_DATA_HI 0x7010a0UL
 #define UVH_GR1_TLB_MMR_READ_DATA_HI (					\
-	is_uv1_hub() ? UV1H_GR1_TLB_MMR_READ_DATA_HI :			\
 	is_uv2_hub() ? UV2H_GR1_TLB_MMR_READ_DATA_HI :			\
 	is_uv3_hub() ? UV3H_GR1_TLB_MMR_READ_DATA_HI :			\
 	/*is_uv4_hub*/ UV4H_GR1_TLB_MMR_READ_DATA_HI)
 
 #define UVH_GR1_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
 
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_GAA_SHFT		41
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_DIRTY_SHFT	43
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_LARGER_SHFT	44
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_PFN_MASK		0x000001ffffffffffUL
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_GAA_MASK		0x0000060000000000UL
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_DIRTY_MASK	0x0000080000000000UL
-#define UV1H_GR1_TLB_MMR_READ_DATA_HI_LARGER_MASK	0x0000100000000000UL
-
 #define UVXH_GR1_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
 
 #define UV2H_GR1_TLB_MMR_READ_DATA_HI_PFN_SHFT		0
@@ -1622,13 +1343,6 @@ union uvh_gr1_tlb_mmr_control_u {
 
 union uvh_gr1_tlb_mmr_read_data_hi_u {
 	unsigned long	v;
-	struct uv1h_gr1_tlb_mmr_read_data_hi_s {
-		unsigned long	pfn:41;				/* RO */
-		unsigned long	gaa:2;				/* RO */
-		unsigned long	dirty:1;			/* RO */
-		unsigned long	larger:1;			/* RO */
-		unsigned long	rsvd_45_63:19;
-	} s1;
 	struct uv2h_gr1_tlb_mmr_read_data_hi_s {
 		unsigned long	pfn:41;				/* RO */
 		unsigned long	gaa:2;				/* RO */
@@ -1660,12 +1374,10 @@ union uvh_gr1_tlb_mmr_read_data_hi_u {
 /* ========================================================================= */
 /*                       UVH_GR1_TLB_MMR_READ_DATA_LO                        */
 /* ========================================================================= */
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO 0x8010a8UL
 #define UV2H_GR1_TLB_MMR_READ_DATA_LO 0x10010a8UL
 #define UV3H_GR1_TLB_MMR_READ_DATA_LO 0x10010a8UL
 #define UV4H_GR1_TLB_MMR_READ_DATA_LO 0x7010a8UL
 #define UVH_GR1_TLB_MMR_READ_DATA_LO (					\
-	is_uv1_hub() ? UV1H_GR1_TLB_MMR_READ_DATA_LO :			\
 	is_uv2_hub() ? UV2H_GR1_TLB_MMR_READ_DATA_LO :			\
 	is_uv3_hub() ? UV3H_GR1_TLB_MMR_READ_DATA_LO :			\
 	/*is_uv4_hub*/ UV4H_GR1_TLB_MMR_READ_DATA_LO)
@@ -1677,13 +1389,6 @@ union uvh_gr1_tlb_mmr_read_data_hi_u {
 #define UVH_GR1_TLB_MMR_READ_DATA_LO_ASID_MASK		0x7fffff8000000000UL
 #define UVH_GR1_TLB_MMR_READ_DATA_LO_VALID_MASK		0x8000000000000000UL
 
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_VPN_SHFT		0
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_ASID_SHFT		39
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_VALID_SHFT	63
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_VPN_MASK		0x0000007fffffffffUL
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_ASID_MASK		0x7fffff8000000000UL
-#define UV1H_GR1_TLB_MMR_READ_DATA_LO_VALID_MASK	0x8000000000000000UL
-
 #define UVXH_GR1_TLB_MMR_READ_DATA_LO_VPN_SHFT		0
 #define UVXH_GR1_TLB_MMR_READ_DATA_LO_ASID_SHFT		39
 #define UVXH_GR1_TLB_MMR_READ_DATA_LO_VALID_SHFT	63
@@ -1720,11 +1425,6 @@ union uvh_gr1_tlb_mmr_read_data_lo_u {
 		unsigned long	asid:24;			/* RO */
 		unsigned long	valid:1;			/* RO */
 	} s;
-	struct uv1h_gr1_tlb_mmr_read_data_lo_s {
-		unsigned long	vpn:39;				/* RO */
-		unsigned long	asid:24;			/* RO */
-		unsigned long	valid:1;			/* RO */
-	} s1;
 	struct uvxh_gr1_tlb_mmr_read_data_lo_s {
 		unsigned long	vpn:39;				/* RO */
 		unsigned long	asid:24;			/* RO */
@@ -1770,9 +1470,6 @@ union uvh_int_cmpb_u {
 #define UVH_INT_CMPC 0x22100UL
 
 
-#define UV1H_INT_CMPC_REAL_TIME_CMPC_SHFT		0
-#define UV1H_INT_CMPC_REAL_TIME_CMPC_MASK		0x00ffffffffffffffUL
-
 #define UVXH_INT_CMPC_REAL_TIME_CMP_2_SHFT		0
 #define UVXH_INT_CMPC_REAL_TIME_CMP_2_MASK		0x00ffffffffffffffUL
 
@@ -1791,9 +1488,6 @@ union uvh_int_cmpc_u {
 #define UVH_INT_CMPD 0x22180UL
 
 
-#define UV1H_INT_CMPD_REAL_TIME_CMPD_SHFT		0
-#define UV1H_INT_CMPD_REAL_TIME_CMPD_MASK		0x00ffffffffffffffUL
-
 #define UVXH_INT_CMPD_REAL_TIME_CMP_3_SHFT		0
 #define UVXH_INT_CMPD_REAL_TIME_CMP_3_MASK		0x00ffffffffffffffUL
 
@@ -1811,12 +1505,10 @@ union uvh_int_cmpd_u {
 /* ========================================================================= */
 #define UVH_IPI_INT 0x60500UL
 
-#define UV1H_IPI_INT_32 0x348
 #define UV2H_IPI_INT_32 0x348
 #define UV3H_IPI_INT_32 0x348
 #define UV4H_IPI_INT_32 0x268
 #define UVH_IPI_INT_32 (						\
-	is_uv1_hub() ? UV1H_IPI_INT_32 :				\
 	is_uv2_hub() ? UV2H_IPI_INT_32 :				\
 	is_uv3_hub() ? UV3H_IPI_INT_32 :				\
 	/*is_uv4_hub*/ UV4H_IPI_INT_32)
@@ -1849,24 +1541,16 @@ union uvh_ipi_int_u {
 /* ========================================================================= */
 /*                   UVH_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST                     */
 /* ========================================================================= */
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST 0x320050UL
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST 0x320050UL
 #define UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST 0x320050UL
 #define UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST uv_undefined("UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST")
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST (				\
-	is_uv1_hub() ? UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST :		\
 	is_uv2_hub() ? UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST :		\
 	is_uv3_hub() ? UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST)
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_32 0x9c0
 
 
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_ADDRESS_SHFT 4
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_NODE_ID_SHFT 49
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_ADDRESS_MASK 0x000007fffffffff0UL
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_NODE_ID_MASK 0x7ffe000000000000UL
-
-
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_ADDRESS_SHFT 4
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_NODE_ID_SHFT 49
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_FIRST_ADDRESS_MASK 0x000007fffffffff0UL
@@ -1880,13 +1564,6 @@ union uvh_ipi_int_u {
 
 union uvh_lb_bau_intd_payload_queue_first_u {
 	unsigned long	v;
-	struct uv1h_lb_bau_intd_payload_queue_first_s {
-		unsigned long	rsvd_0_3:4;
-		unsigned long	address:39;			/* RW */
-		unsigned long	rsvd_43_48:6;
-		unsigned long	node_id:14;			/* RW */
-		unsigned long	rsvd_63:1;
-	} s1;
 	struct uv2h_lb_bau_intd_payload_queue_first_s {
 		unsigned long	rsvd_0_3:4;
 		unsigned long	address:39;			/* RW */
@@ -1906,22 +1583,16 @@ union uvh_lb_bau_intd_payload_queue_first_u {
 /* ========================================================================= */
 /*                    UVH_LB_BAU_INTD_PAYLOAD_QUEUE_LAST                     */
 /* ========================================================================= */
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST 0x320060UL
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST 0x320060UL
 #define UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST 0x320060UL
 #define UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST uv_undefined("UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST")
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_LAST (				\
-	is_uv1_hub() ? UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST :		\
 	is_uv2_hub() ? UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST :		\
 	is_uv3_hub() ? UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST)
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_LAST_32 0x9c8
 
 
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST_ADDRESS_SHFT 4
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST_ADDRESS_MASK 0x000007fffffffff0UL
-
-
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST_ADDRESS_SHFT 4
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_LAST_ADDRESS_MASK 0x000007fffffffff0UL
 
@@ -1931,11 +1602,6 @@ union uvh_lb_bau_intd_payload_queue_first_u {
 
 union uvh_lb_bau_intd_payload_queue_last_u {
 	unsigned long	v;
-	struct uv1h_lb_bau_intd_payload_queue_last_s {
-		unsigned long	rsvd_0_3:4;
-		unsigned long	address:39;			/* RW */
-		unsigned long	rsvd_43_63:21;
-	} s1;
 	struct uv2h_lb_bau_intd_payload_queue_last_s {
 		unsigned long	rsvd_0_3:4;
 		unsigned long	address:39;			/* RW */
@@ -1951,22 +1617,16 @@ union uvh_lb_bau_intd_payload_queue_last_u {
 /* ========================================================================= */
 /*                    UVH_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL                     */
 /* ========================================================================= */
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL 0x320070UL
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL 0x320070UL
 #define UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL 0x320070UL
 #define UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL uv_undefined("UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL")
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL (				\
-	is_uv1_hub() ? UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL :		\
 	is_uv2_hub() ? UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL :		\
 	is_uv3_hub() ? UV3H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL)
 #define UVH_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL_32 0x9d0
 
 
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL_ADDRESS_SHFT 4
-#define UV1H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL_ADDRESS_MASK 0x000007fffffffff0UL
-
-
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL_ADDRESS_SHFT 4
 #define UV2H_LB_BAU_INTD_PAYLOAD_QUEUE_TAIL_ADDRESS_MASK 0x000007fffffffff0UL
 
@@ -1976,11 +1636,6 @@ union uvh_lb_bau_intd_payload_queue_last_u {
 
 union uvh_lb_bau_intd_payload_queue_tail_u {
 	unsigned long	v;
-	struct uv1h_lb_bau_intd_payload_queue_tail_s {
-		unsigned long	rsvd_0_3:4;
-		unsigned long	address:39;			/* RW */
-		unsigned long	rsvd_43_63:21;
-	} s1;
 	struct uv2h_lb_bau_intd_payload_queue_tail_s {
 		unsigned long	rsvd_0_3:4;
 		unsigned long	address:39;			/* RW */
@@ -1996,52 +1651,16 @@ union uvh_lb_bau_intd_payload_queue_tail_u {
 /* ========================================================================= */
 /*                   UVH_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE                    */
 /* ========================================================================= */
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE 0x320080UL
 #define UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE 0x320080UL
 #define UV3H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE 0x320080UL
 #define UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE uv_undefined("UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE")
 #define UVH_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE (				\
-	is_uv1_hub() ? UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE :		\
 	is_uv2_hub() ? UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE :		\
 	is_uv3_hub() ? UV3H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE)
 #define UVH_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_32 0xa68
 
 
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_0_SHFT 0
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_1_SHFT 1
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_2_SHFT 2
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_3_SHFT 3
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_4_SHFT 4
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_5_SHFT 5
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_6_SHFT 6
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_7_SHFT 7
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_0_SHFT 8
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_1_SHFT 9
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_2_SHFT 10
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_3_SHFT 11
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_4_SHFT 12
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_5_SHFT 13
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_6_SHFT 14
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_7_SHFT 15
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_0_MASK 0x0000000000000001UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_1_MASK 0x0000000000000002UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_2_MASK 0x0000000000000004UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_3_MASK 0x0000000000000008UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_4_MASK 0x0000000000000010UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_5_MASK 0x0000000000000020UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_6_MASK 0x0000000000000040UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_7_MASK 0x0000000000000080UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_0_MASK 0x0000000000000100UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_1_MASK 0x0000000000000200UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_2_MASK 0x0000000000000400UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_3_MASK 0x0000000000000800UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_4_MASK 0x0000000000001000UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_5_MASK 0x0000000000002000UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_6_MASK 0x0000000000004000UL
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_TIMEOUT_7_MASK 0x0000000000008000UL
-
-
 #define UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_0_SHFT 0
 #define UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_1_SHFT 1
 #define UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_PENDING_2_SHFT 2
@@ -2111,25 +1730,6 @@ union uvh_lb_bau_intd_payload_queue_tail_u {
 
 union uvh_lb_bau_intd_software_acknowledge_u {
 	unsigned long	v;
-	struct uv1h_lb_bau_intd_software_acknowledge_s {
-		unsigned long	pending_0:1;			/* RW, W1C */
-		unsigned long	pending_1:1;			/* RW, W1C */
-		unsigned long	pending_2:1;			/* RW, W1C */
-		unsigned long	pending_3:1;			/* RW, W1C */
-		unsigned long	pending_4:1;			/* RW, W1C */
-		unsigned long	pending_5:1;			/* RW, W1C */
-		unsigned long	pending_6:1;			/* RW, W1C */
-		unsigned long	pending_7:1;			/* RW, W1C */
-		unsigned long	timeout_0:1;			/* RW, W1C */
-		unsigned long	timeout_1:1;			/* RW, W1C */
-		unsigned long	timeout_2:1;			/* RW, W1C */
-		unsigned long	timeout_3:1;			/* RW, W1C */
-		unsigned long	timeout_4:1;			/* RW, W1C */
-		unsigned long	timeout_5:1;			/* RW, W1C */
-		unsigned long	timeout_6:1;			/* RW, W1C */
-		unsigned long	timeout_7:1;			/* RW, W1C */
-		unsigned long	rsvd_16_63:48;
-	} s1;
 	struct uv2h_lb_bau_intd_software_acknowledge_s {
 		unsigned long	pending_0:1;			/* RW */
 		unsigned long	pending_1:1;			/* RW */
@@ -2173,12 +1773,10 @@ union uvh_lb_bau_intd_software_acknowledge_u {
 /* ========================================================================= */
 /*                UVH_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS                 */
 /* ========================================================================= */
-#define UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS 0x320088UL
 #define UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS 0x320088UL
 #define UV3H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS 0x320088UL
 #define UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS uv_undefined("UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS")
 #define UVH_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS (			\
-	is_uv1_hub() ? UV1H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS :	\
 	is_uv2_hub() ? UV2H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS :	\
 	is_uv3_hub() ? UV3H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS :	\
 	/*is_uv4_hub*/ UV4H_LB_BAU_INTD_SOFTWARE_ACKNOWLEDGE_ALIAS)
@@ -2188,22 +1786,18 @@ union uvh_lb_bau_intd_software_acknowledge_u {
 /* ========================================================================= */
 /*                         UVH_LB_BAU_MISC_CONTROL                           */
 /* ========================================================================= */
-#define UV1H_LB_BAU_MISC_CONTROL 0x320170UL
 #define UV2H_LB_BAU_MISC_CONTROL 0x320170UL
 #define UV3H_LB_BAU_MISC_CONTROL 0x320170UL
 #define UV4H_LB_BAU_MISC_CONTROL 0xc8170UL
 #define UVH_LB_BAU_MISC_CONTROL (					\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL :			\
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL :			\
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL :			\
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL)
 
-#define UV1H_LB_BAU_MISC_CONTROL_32 0xa10
 #define UV2H_LB_BAU_MISC_CONTROL_32 0xa10
 #define UV3H_LB_BAU_MISC_CONTROL_32 0xa10
 #define UV4H_LB_BAU_MISC_CONTROL_32 0xa18
 #define UVH_LB_BAU_MISC_CONTROL_32 (					\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL_32 :			\
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL_32 :			\
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL_32 :			\
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL_32)
@@ -2237,39 +1831,6 @@ union uvh_lb_bau_intd_software_acknowledge_u {
 #define UVH_LB_BAU_MISC_CONTROL_ENABLE_PROGRAMMED_INITIAL_PRIORITY_MASK 0x0000000010000000UL
 #define UVH_LB_BAU_MISC_CONTROL_FUN_MASK		0xffff000000000000UL
 
-#define UV1H_LB_BAU_MISC_CONTROL_REJECTION_DELAY_SHFT	0
-#define UV1H_LB_BAU_MISC_CONTROL_APIC_MODE_SHFT		8
-#define UV1H_LB_BAU_MISC_CONTROL_FORCE_BROADCAST_SHFT	9
-#define UV1H_LB_BAU_MISC_CONTROL_FORCE_LOCK_NOP_SHFT	10
-#define UV1H_LB_BAU_MISC_CONTROL_QPI_AGENT_PRESENCE_VECTOR_SHFT 11
-#define UV1H_LB_BAU_MISC_CONTROL_DESCRIPTOR_FETCH_MODE_SHFT 14
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT 15
-#define UV1H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT 16
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_DUAL_MAPPING_MODE_SHFT 20
-#define UV1H_LB_BAU_MISC_CONTROL_VGA_IO_PORT_DECODE_ENABLE_SHFT 21
-#define UV1H_LB_BAU_MISC_CONTROL_VGA_IO_PORT_16_BIT_DECODE_SHFT 22
-#define UV1H_LB_BAU_MISC_CONTROL_SUPPRESS_DEST_REGISTRATION_SHFT 23
-#define UV1H_LB_BAU_MISC_CONTROL_PROGRAMMED_INITIAL_PRIORITY_SHFT 24
-#define UV1H_LB_BAU_MISC_CONTROL_USE_INCOMING_PRIORITY_SHFT 27
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_PROGRAMMED_INITIAL_PRIORITY_SHFT 28
-#define UV1H_LB_BAU_MISC_CONTROL_FUN_SHFT		48
-#define UV1H_LB_BAU_MISC_CONTROL_REJECTION_DELAY_MASK	0x00000000000000ffUL
-#define UV1H_LB_BAU_MISC_CONTROL_APIC_MODE_MASK		0x0000000000000100UL
-#define UV1H_LB_BAU_MISC_CONTROL_FORCE_BROADCAST_MASK	0x0000000000000200UL
-#define UV1H_LB_BAU_MISC_CONTROL_FORCE_LOCK_NOP_MASK	0x0000000000000400UL
-#define UV1H_LB_BAU_MISC_CONTROL_QPI_AGENT_PRESENCE_VECTOR_MASK 0x0000000000003800UL
-#define UV1H_LB_BAU_MISC_CONTROL_DESCRIPTOR_FETCH_MODE_MASK 0x0000000000004000UL
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK 0x0000000000008000UL
-#define UV1H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK 0x00000000000f0000UL
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_DUAL_MAPPING_MODE_MASK 0x0000000000100000UL
-#define UV1H_LB_BAU_MISC_CONTROL_VGA_IO_PORT_DECODE_ENABLE_MASK 0x0000000000200000UL
-#define UV1H_LB_BAU_MISC_CONTROL_VGA_IO_PORT_16_BIT_DECODE_MASK 0x0000000000400000UL
-#define UV1H_LB_BAU_MISC_CONTROL_SUPPRESS_DEST_REGISTRATION_MASK 0x0000000000800000UL
-#define UV1H_LB_BAU_MISC_CONTROL_PROGRAMMED_INITIAL_PRIORITY_MASK 0x0000000007000000UL
-#define UV1H_LB_BAU_MISC_CONTROL_USE_INCOMING_PRIORITY_MASK 0x0000000008000000UL
-#define UV1H_LB_BAU_MISC_CONTROL_ENABLE_PROGRAMMED_INITIAL_PRIORITY_MASK 0x0000000010000000UL
-#define UV1H_LB_BAU_MISC_CONTROL_FUN_MASK		0xffff000000000000UL
-
 #define UVXH_LB_BAU_MISC_CONTROL_REJECTION_DELAY_SHFT	0
 #define UVXH_LB_BAU_MISC_CONTROL_APIC_MODE_SHFT		8
 #define UVXH_LB_BAU_MISC_CONTROL_FORCE_BROADCAST_SHFT	9
@@ -2469,28 +2030,24 @@ union uvh_lb_bau_intd_software_acknowledge_u {
 #define UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK	\
 	uv_undefined("UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK")
 #define UVH_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK (	\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK : \
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK : \
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK : \
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_MASK)
 #define UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT	\
 	uv_undefined("UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT")
 #define UVH_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT (	\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT : \
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT : \
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT : \
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL_ENABLE_INTD_SOFT_ACK_MODE_SHFT)
 #define UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK	\
 	uv_undefined("UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK")
 #define UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK (	\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK : \
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK : \
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK : \
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_MASK)
 #define UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT	\
 	uv_undefined("UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT")
 #define UVH_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT (	\
-	is_uv1_hub() ? UV1H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT : \
 	is_uv2_hub() ? UV2H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT : \
 	is_uv3_hub() ? UV3H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT : \
 	/*is_uv4_hub*/ UV4H_LB_BAU_MISC_CONTROL_INTD_SOFT_ACK_TIMEOUT_PERIOD_SHFT)
@@ -2515,25 +2072,6 @@ union uvh_lb_bau_misc_control_u {
 		unsigned long	rsvd_29_47:19;
 		unsigned long	fun:16;				/* RW */
 	} s;
-	struct uv1h_lb_bau_misc_control_s {
-		unsigned long	rejection_delay:8;		/* RW */
-		unsigned long	apic_mode:1;			/* RW */
-		unsigned long	force_broadcast:1;		/* RW */
-		unsigned long	force_lock_nop:1;		/* RW */
-		unsigned long	qpi_agent_presence_vector:3;	/* RW */
-		unsigned long	descriptor_fetch_mode:1;	/* RW */
-		unsigned long	enable_intd_soft_ack_mode:1;	/* RW */
-		unsigned long	intd_soft_ack_timeout_period:4;	/* RW */
-		unsigned long	enable_dual_mapping_mode:1;	/* RW */
-		unsigned long	vga_io_port_decode_enable:1;	/* RW */
-		unsigned long	vga_io_port_16_bit_decode:1;	/* RW */
-		unsigned long	suppress_dest_registration:1;	/* RW */
-		unsigned long	programmed_initial_priority:3;	/* RW */
-		unsigned long	use_incoming_priority:1;	/* RW */
-		unsigned long	enable_programmed_initial_priority:1;/* RW */
-		unsigned long	rsvd_29_47:19;
-		unsigned long	fun:16;				/* RW */
-	} s1;
 	struct uvxh_lb_bau_misc_control_s {
 		unsigned long	rejection_delay:8;		/* RW */
 		unsigned long	apic_mode:1;			/* RW */
@@ -2648,22 +2186,18 @@ union uvh_lb_bau_misc_control_u {
 /* ========================================================================= */
 /*                     UVH_LB_BAU_SB_ACTIVATION_CONTROL                      */
 /* ========================================================================= */
-#define UV1H_LB_BAU_SB_ACTIVATION_CONTROL 0x320020UL
 #define UV2H_LB_BAU_SB_ACTIVATION_CONTROL 0x320020UL
 #define UV3H_LB_BAU_SB_ACTIVATION_CONTROL 0x320020UL
 #define UV4H_LB_BAU_SB_ACTIVATION_CONTROL 0xc8020UL
 #define UVH_LB_BAU_SB_ACTIVATION_CONTROL (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_CONTROL :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_CONTROL :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_CONTROL :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_CONTROL)
 
-#define UV1H_LB_BAU_SB_ACTIVATION_CONTROL_32 0x9a8
 #define UV2H_LB_BAU_SB_ACTIVATION_CONTROL_32 0x9a8
 #define UV3H_LB_BAU_SB_ACTIVATION_CONTROL_32 0x9a8
 #define UV4H_LB_BAU_SB_ACTIVATION_CONTROL_32 0x9c8
 #define UVH_LB_BAU_SB_ACTIVATION_CONTROL_32 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_CONTROL_32 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_CONTROL_32 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_CONTROL_32 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_CONTROL_32)
@@ -2689,22 +2223,18 @@ union uvh_lb_bau_sb_activation_control_u {
 /* ========================================================================= */
 /*                    UVH_LB_BAU_SB_ACTIVATION_STATUS_0                      */
 /* ========================================================================= */
-#define UV1H_LB_BAU_SB_ACTIVATION_STATUS_0 0x320030UL
 #define UV2H_LB_BAU_SB_ACTIVATION_STATUS_0 0x320030UL
 #define UV3H_LB_BAU_SB_ACTIVATION_STATUS_0 0x320030UL
 #define UV4H_LB_BAU_SB_ACTIVATION_STATUS_0 0xc8030UL
 #define UVH_LB_BAU_SB_ACTIVATION_STATUS_0 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_STATUS_0 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_STATUS_0 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_STATUS_0 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_STATUS_0)
 
-#define UV1H_LB_BAU_SB_ACTIVATION_STATUS_0_32 0x9b0
 #define UV2H_LB_BAU_SB_ACTIVATION_STATUS_0_32 0x9b0
 #define UV3H_LB_BAU_SB_ACTIVATION_STATUS_0_32 0x9b0
 #define UV4H_LB_BAU_SB_ACTIVATION_STATUS_0_32 0x9d0
 #define UVH_LB_BAU_SB_ACTIVATION_STATUS_0_32 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_STATUS_0_32 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_STATUS_0_32 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_STATUS_0_32 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_STATUS_0_32)
@@ -2723,22 +2253,18 @@ union uvh_lb_bau_sb_activation_status_0_u {
 /* ========================================================================= */
 /*                    UVH_LB_BAU_SB_ACTIVATION_STATUS_1                      */
 /* ========================================================================= */
-#define UV1H_LB_BAU_SB_ACTIVATION_STATUS_1 0x320040UL
 #define UV2H_LB_BAU_SB_ACTIVATION_STATUS_1 0x320040UL
 #define UV3H_LB_BAU_SB_ACTIVATION_STATUS_1 0x320040UL
 #define UV4H_LB_BAU_SB_ACTIVATION_STATUS_1 0xc8040UL
 #define UVH_LB_BAU_SB_ACTIVATION_STATUS_1 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_STATUS_1 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_STATUS_1 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_STATUS_1 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_STATUS_1)
 
-#define UV1H_LB_BAU_SB_ACTIVATION_STATUS_1_32 0x9b8
 #define UV2H_LB_BAU_SB_ACTIVATION_STATUS_1_32 0x9b8
 #define UV3H_LB_BAU_SB_ACTIVATION_STATUS_1_32 0x9b8
 #define UV4H_LB_BAU_SB_ACTIVATION_STATUS_1_32 0x9d8
 #define UVH_LB_BAU_SB_ACTIVATION_STATUS_1_32 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_ACTIVATION_STATUS_1_32 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_ACTIVATION_STATUS_1_32 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_ACTIVATION_STATUS_1_32 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_ACTIVATION_STATUS_1_32)
@@ -2757,32 +2283,24 @@ union uvh_lb_bau_sb_activation_status_1_u {
 /* ========================================================================= */
 /*                      UVH_LB_BAU_SB_DESCRIPTOR_BASE                        */
 /* ========================================================================= */
-#define UV1H_LB_BAU_SB_DESCRIPTOR_BASE 0x320010UL
 #define UV2H_LB_BAU_SB_DESCRIPTOR_BASE 0x320010UL
 #define UV3H_LB_BAU_SB_DESCRIPTOR_BASE 0x320010UL
 #define UV4H_LB_BAU_SB_DESCRIPTOR_BASE 0xc8010UL
 #define UVH_LB_BAU_SB_DESCRIPTOR_BASE (					\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_DESCRIPTOR_BASE :			\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_DESCRIPTOR_BASE :			\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_DESCRIPTOR_BASE :			\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_DESCRIPTOR_BASE)
 
-#define UV1H_LB_BAU_SB_DESCRIPTOR_BASE_32 0x9a0
 #define UV2H_LB_BAU_SB_DESCRIPTOR_BASE_32 0x9a0
 #define UV3H_LB_BAU_SB_DESCRIPTOR_BASE_32 0x9a0
 #define UV4H_LB_BAU_SB_DESCRIPTOR_BASE_32 0x9c0
 #define UVH_LB_BAU_SB_DESCRIPTOR_BASE_32 (				\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_DESCRIPTOR_BASE_32 :		\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_DESCRIPTOR_BASE_32 :		\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_DESCRIPTOR_BASE_32 :		\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_DESCRIPTOR_BASE_32)
 
 #define UVH_LB_BAU_SB_DESCRIPTOR_BASE_PAGE_ADDRESS_SHFT	12
 
-#define UV1H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT	49
-#define UV1H_LB_BAU_SB_DESCRIPTOR_BASE_PAGE_ADDRESS_MASK 0x000007fffffff000UL
-#define UV1H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK	0x7ffe000000000000UL
-
 #define UV2H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT	49
 #define UV2H_LB_BAU_SB_DESCRIPTOR_BASE_PAGE_ADDRESS_MASK 0x000007fffffff000UL
 #define UV2H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK	0x7ffe000000000000UL
@@ -2800,21 +2318,18 @@ union uvh_lb_bau_sb_activation_status_1_u {
 #define UV4AH_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK	0xffe0000000000000UL
 
 #define UVH_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT (			\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT :	\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT :	\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT :	\
 	is_uv4a_hub() ? UV4AH_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT :	\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_SHFT)
 
 #define UVH_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK (			\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK :	\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK :	\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK :	\
 	is_uv4a_hub() ? UV4AH_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK :	\
 	/*is_uv4_hub*/ UV4H_LB_BAU_SB_DESCRIPTOR_PAGE_ADDRESS_MASK)
 
 #define UVH_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK (			\
-	is_uv1_hub() ? UV1H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK :	\
 	is_uv2_hub() ? UV2H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK :	\
 	is_uv3_hub() ? UV3H_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK :	\
 	is_uv4a_hub() ? UV4AH_LB_BAU_SB_DESCRIPTOR_BASE_NODE_ID_MASK :	\
@@ -2824,7 +2339,6 @@ union uvh_lb_bau_sb_activation_status_1_u {
 /*                               UVH_NODE_ID                                 */
 /* ========================================================================= */
 #define UVH_NODE_ID 0x0UL
-#define UV1H_NODE_ID 0x0UL
 #define UV2H_NODE_ID 0x0UL
 #define UV3H_NODE_ID 0x0UL
 #define UV4H_NODE_ID 0x0UL
@@ -2840,21 +2354,6 @@ union uvh_lb_bau_sb_activation_status_1_u {
 #define UVH_NODE_ID_REVISION_MASK			0x00000000f0000000UL
 #define UVH_NODE_ID_NODE_ID_MASK			0x00007fff00000000UL
 
-#define UV1H_NODE_ID_FORCE1_SHFT			0
-#define UV1H_NODE_ID_MANUFACTURER_SHFT			1
-#define UV1H_NODE_ID_PART_NUMBER_SHFT			12
-#define UV1H_NODE_ID_REVISION_SHFT			28
-#define UV1H_NODE_ID_NODE_ID_SHFT			32
-#define UV1H_NODE_ID_NODES_PER_BIT_SHFT			48
-#define UV1H_NODE_ID_NI_PORT_SHFT			56
-#define UV1H_NODE_ID_FORCE1_MASK			0x0000000000000001UL
-#define UV1H_NODE_ID_MANUFACTURER_MASK			0x0000000000000ffeUL
-#define UV1H_NODE_ID_PART_NUMBER_MASK			0x000000000ffff000UL
-#define UV1H_NODE_ID_REVISION_MASK			0x00000000f0000000UL
-#define UV1H_NODE_ID_NODE_ID_MASK			0x00007fff00000000UL
-#define UV1H_NODE_ID_NODES_PER_BIT_MASK			0x007f000000000000UL
-#define UV1H_NODE_ID_NI_PORT_MASK			0x0f00000000000000UL
-
 #define UVXH_NODE_ID_FORCE1_SHFT			0
 #define UVXH_NODE_ID_MANUFACTURER_SHFT			1
 #define UVXH_NODE_ID_PART_NUMBER_SHFT			12
@@ -2934,18 +2433,6 @@ union uvh_node_id_u {
 		unsigned long	node_id:15;			/* RW */
 		unsigned long	rsvd_47_63:17;
 	} s;
-	struct uv1h_node_id_s {
-		unsigned long	force1:1;			/* RO */
-		unsigned long	manufacturer:11;		/* RO */
-		unsigned long	part_number:16;			/* RO */
-		unsigned long	revision:4;			/* RO */
-		unsigned long	node_id:15;			/* RW */
-		unsigned long	rsvd_47:1;
-		unsigned long	nodes_per_bit:7;		/* RW */
-		unsigned long	rsvd_55:1;
-		unsigned long	ni_port:4;			/* RO */
-		unsigned long	rsvd_60_63:4;
-	} s1;
 	struct uvxh_node_id_s {
 		unsigned long	force1:1;			/* RO */
 		unsigned long	manufacturer:11;		/* RO */
@@ -3001,12 +2488,10 @@ union uvh_node_id_u {
 /* ========================================================================= */
 #define UVH_NODE_PRESENT_TABLE 0x1400UL
 
-#define UV1H_NODE_PRESENT_TABLE_DEPTH 16
 #define UV2H_NODE_PRESENT_TABLE_DEPTH 16
 #define UV3H_NODE_PRESENT_TABLE_DEPTH 16
 #define UV4H_NODE_PRESENT_TABLE_DEPTH 4
 #define UVH_NODE_PRESENT_TABLE_DEPTH (					\
-	is_uv1_hub() ? UV1H_NODE_PRESENT_TABLE_DEPTH :			\
 	is_uv2_hub() ? UV2H_NODE_PRESENT_TABLE_DEPTH :			\
 	is_uv3_hub() ? UV3H_NODE_PRESENT_TABLE_DEPTH :			\
 	/*is_uv4_hub*/ UV4H_NODE_PRESENT_TABLE_DEPTH)
@@ -3025,12 +2510,10 @@ union uvh_node_present_table_u {
 /* ========================================================================= */
 /*                 UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR 0x16000c8UL
 #define UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR 0x16000c8UL
 #define UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR 0x16000c8UL
 #define UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR 0x4800c8UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR)
@@ -3042,13 +2525,6 @@ union uvh_node_present_table_u {
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_M_ALIAS_MASK 0x001f000000000000UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_ENABLE_MASK 0x8000000000000000UL
 
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_M_ALIAS_SHFT 48
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_ENABLE_SHFT 63
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_BASE_MASK 0x00000000ff000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_M_ALIAS_MASK 0x001f000000000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_ENABLE_MASK 0x8000000000000000UL
-
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_M_ALIAS_SHFT 48
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_0_MMR_ENABLE_SHFT 63
@@ -3088,14 +2564,6 @@ union uvh_rh_gam_alias210_overlay_config_0_mmr_u {
 		unsigned long	rsvd_53_62:10;
 		unsigned long	enable:1;			/* RW */
 	} s;
-	struct uv1h_rh_gam_alias210_overlay_config_0_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	base:8;				/* RW */
-		unsigned long	rsvd_32_47:16;
-		unsigned long	m_alias:5;			/* RW */
-		unsigned long	rsvd_53_62:10;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uvxh_rh_gam_alias210_overlay_config_0_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	base:8;				/* RW */
@@ -3133,12 +2601,10 @@ union uvh_rh_gam_alias210_overlay_config_0_mmr_u {
 /* ========================================================================= */
 /*                 UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR 0x16000d8UL
 #define UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR 0x16000d8UL
 #define UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR 0x16000d8UL
 #define UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR 0x4800d8UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR)
@@ -3150,13 +2616,6 @@ union uvh_rh_gam_alias210_overlay_config_0_mmr_u {
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_M_ALIAS_MASK 0x001f000000000000UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_ENABLE_MASK 0x8000000000000000UL
 
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_M_ALIAS_SHFT 48
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_ENABLE_SHFT 63
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_BASE_MASK 0x00000000ff000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_M_ALIAS_MASK 0x001f000000000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_ENABLE_MASK 0x8000000000000000UL
-
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_M_ALIAS_SHFT 48
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_1_MMR_ENABLE_SHFT 63
@@ -3196,14 +2655,6 @@ union uvh_rh_gam_alias210_overlay_config_1_mmr_u {
 		unsigned long	rsvd_53_62:10;
 		unsigned long	enable:1;			/* RW */
 	} s;
-	struct uv1h_rh_gam_alias210_overlay_config_1_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	base:8;				/* RW */
-		unsigned long	rsvd_32_47:16;
-		unsigned long	m_alias:5;			/* RW */
-		unsigned long	rsvd_53_62:10;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uvxh_rh_gam_alias210_overlay_config_1_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	base:8;				/* RW */
@@ -3241,12 +2692,10 @@ union uvh_rh_gam_alias210_overlay_config_1_mmr_u {
 /* ========================================================================= */
 /*                 UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR 0x16000e8UL
 #define UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR 0x16000e8UL
 #define UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR 0x16000e8UL
 #define UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR 0x4800e8UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR)
@@ -3258,13 +2707,6 @@ union uvh_rh_gam_alias210_overlay_config_1_mmr_u {
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_M_ALIAS_MASK 0x001f000000000000UL
 #define UVH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_ENABLE_MASK 0x8000000000000000UL
 
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_M_ALIAS_SHFT 48
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_ENABLE_SHFT 63
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_BASE_MASK 0x00000000ff000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_M_ALIAS_MASK 0x001f000000000000UL
-#define UV1H_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_ENABLE_MASK 0x8000000000000000UL
-
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_M_ALIAS_SHFT 48
 #define UVXH_RH_GAM_ALIAS210_OVERLAY_CONFIG_2_MMR_ENABLE_SHFT 63
@@ -3304,14 +2746,6 @@ union uvh_rh_gam_alias210_overlay_config_2_mmr_u {
 		unsigned long	rsvd_53_62:10;
 		unsigned long	enable:1;			/* RW */
 	} s;
-	struct uv1h_rh_gam_alias210_overlay_config_2_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	base:8;				/* RW */
-		unsigned long	rsvd_32_47:16;
-		unsigned long	m_alias:5;			/* RW */
-		unsigned long	rsvd_53_62:10;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uvxh_rh_gam_alias210_overlay_config_2_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	base:8;				/* RW */
@@ -3349,12 +2783,10 @@ union uvh_rh_gam_alias210_overlay_config_2_mmr_u {
 /* ========================================================================= */
 /*                UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR 0x16000d0UL
 #define UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR 0x16000d0UL
 #define UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR 0x16000d0UL
 #define UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR 0x4800d0UL
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR)
@@ -3362,9 +2794,6 @@ union uvh_rh_gam_alias210_overlay_config_2_mmr_u {
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_SHFT 24
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_MASK 0x00003fffff000000UL
-
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
@@ -3385,11 +2814,6 @@ union uvh_rh_gam_alias210_redirect_config_0_mmr_u {
 		unsigned long	dest_base:22;			/* RW */
 		unsigned long	rsvd_46_63:18;
 	} s;
-	struct uv1h_rh_gam_alias210_redirect_config_0_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	dest_base:22;			/* RW */
-		unsigned long	rsvd_46_63:18;
-	} s1;
 	struct uvxh_rh_gam_alias210_redirect_config_0_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	dest_base:22;			/* RW */
@@ -3415,12 +2839,10 @@ union uvh_rh_gam_alias210_redirect_config_0_mmr_u {
 /* ========================================================================= */
 /*                UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR 0x16000e0UL
 #define UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR 0x16000e0UL
 #define UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR 0x16000e0UL
 #define UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR 0x4800e0UL
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR)
@@ -3428,9 +2850,6 @@ union uvh_rh_gam_alias210_redirect_config_0_mmr_u {
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_SHFT 24
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_MASK 0x00003fffff000000UL
-
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_1_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
@@ -3451,11 +2870,6 @@ union uvh_rh_gam_alias210_redirect_config_1_mmr_u {
 		unsigned long	dest_base:22;			/* RW */
 		unsigned long	rsvd_46_63:18;
 	} s;
-	struct uv1h_rh_gam_alias210_redirect_config_1_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	dest_base:22;			/* RW */
-		unsigned long	rsvd_46_63:18;
-	} s1;
 	struct uvxh_rh_gam_alias210_redirect_config_1_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	dest_base:22;			/* RW */
@@ -3481,12 +2895,10 @@ union uvh_rh_gam_alias210_redirect_config_1_mmr_u {
 /* ========================================================================= */
 /*                UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR                  */
 /* ========================================================================= */
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR 0x16000f0UL
 #define UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR 0x16000f0UL
 #define UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR 0x16000f0UL
 #define UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR 0x4800f0UL
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR (			\
-	is_uv1_hub() ? UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR :	\
 	is_uv2_hub() ? UV2H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR :	\
 	is_uv3_hub() ? UV3H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR)
@@ -3494,9 +2906,6 @@ union uvh_rh_gam_alias210_redirect_config_1_mmr_u {
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_SHFT 24
 #define UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_SHFT 24
-#define UV1H_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_MASK 0x00003fffff000000UL
-
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_SHFT 24
 #define UVXH_RH_GAM_ALIAS210_REDIRECT_CONFIG_2_MMR_DEST_BASE_MASK 0x00003fffff000000UL
 
@@ -3517,11 +2926,6 @@ union uvh_rh_gam_alias210_redirect_config_2_mmr_u {
 		unsigned long	dest_base:22;			/* RW */
 		unsigned long	rsvd_46_63:18;
 	} s;
-	struct uv1h_rh_gam_alias210_redirect_config_2_mmr_s {
-		unsigned long	rsvd_0_23:24;
-		unsigned long	dest_base:22;			/* RW */
-		unsigned long	rsvd_46_63:18;
-	} s1;
 	struct uvxh_rh_gam_alias210_redirect_config_2_mmr_s {
 		unsigned long	rsvd_0_23:24;
 		unsigned long	dest_base:22;			/* RW */
@@ -3547,12 +2951,10 @@ union uvh_rh_gam_alias210_redirect_config_2_mmr_u {
 /* ========================================================================= */
 /*                          UVH_RH_GAM_CONFIG_MMR                            */
 /* ========================================================================= */
-#define UV1H_RH_GAM_CONFIG_MMR 0x1600000UL
 #define UV2H_RH_GAM_CONFIG_MMR 0x1600000UL
 #define UV3H_RH_GAM_CONFIG_MMR 0x1600000UL
 #define UV4H_RH_GAM_CONFIG_MMR 0x480000UL
 #define UVH_RH_GAM_CONFIG_MMR (						\
-	is_uv1_hub() ? UV1H_RH_GAM_CONFIG_MMR :				\
 	is_uv2_hub() ? UV2H_RH_GAM_CONFIG_MMR :				\
 	is_uv3_hub() ? UV3H_RH_GAM_CONFIG_MMR :				\
 	/*is_uv4_hub*/ UV4H_RH_GAM_CONFIG_MMR)
@@ -3560,13 +2962,6 @@ union uvh_rh_gam_alias210_redirect_config_2_mmr_u {
 #define UVH_RH_GAM_CONFIG_MMR_N_SKT_SHFT		6
 #define UVH_RH_GAM_CONFIG_MMR_N_SKT_MASK		0x00000000000003c0UL
 
-#define UV1H_RH_GAM_CONFIG_MMR_M_SKT_SHFT		0
-#define UV1H_RH_GAM_CONFIG_MMR_N_SKT_SHFT		6
-#define UV1H_RH_GAM_CONFIG_MMR_MMIOL_CFG_SHFT		12
-#define UV1H_RH_GAM_CONFIG_MMR_M_SKT_MASK		0x000000000000003fUL
-#define UV1H_RH_GAM_CONFIG_MMR_N_SKT_MASK		0x00000000000003c0UL
-#define UV1H_RH_GAM_CONFIG_MMR_MMIOL_CFG_MASK		0x0000000000001000UL
-
 #define UVXH_RH_GAM_CONFIG_MMR_N_SKT_SHFT		6
 #define UVXH_RH_GAM_CONFIG_MMR_N_SKT_MASK		0x00000000000003c0UL
 
@@ -3591,13 +2986,6 @@ union uvh_rh_gam_config_mmr_u {
 		unsigned long	n_skt:4;			/* RW */
 		unsigned long	rsvd_10_63:54;
 	} s;
-	struct uv1h_rh_gam_config_mmr_s {
-		unsigned long	m_skt:6;			/* RW */
-		unsigned long	n_skt:4;			/* RW */
-		unsigned long	rsvd_10_11:2;
-		unsigned long	mmiol_cfg:1;			/* RW */
-		unsigned long	rsvd_13_63:51;
-	} s1;
 	struct uvxh_rh_gam_config_mmr_s {
 		unsigned long	rsvd_0_5:6;
 		unsigned long	n_skt:4;			/* RW */
@@ -3623,12 +3011,10 @@ union uvh_rh_gam_config_mmr_u {
 /* ========================================================================= */
 /*                    UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR                      */
 /* ========================================================================= */
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR 0x1600010UL
 #define UV2H_RH_GAM_GRU_OVERLAY_CONFIG_MMR 0x1600010UL
 #define UV3H_RH_GAM_GRU_OVERLAY_CONFIG_MMR 0x1600010UL
 #define UV4H_RH_GAM_GRU_OVERLAY_CONFIG_MMR 0x480010UL
 #define UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_GRU_OVERLAY_CONFIG_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_GRU_OVERLAY_CONFIG_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_GRU_OVERLAY_CONFIG_MMR)
@@ -3638,15 +3024,6 @@ union uvh_rh_gam_config_mmr_u {
 #define UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_N_GRU_MASK	0x00f0000000000000UL
 #define UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_ENABLE_MASK	0x8000000000000000UL
 
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT	28
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_GR4_SHFT	48
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_N_GRU_SHFT	52
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_ENABLE_SHFT	63
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK	0x00003ffff0000000UL
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_GR4_MASK	0x0001000000000000UL
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_N_GRU_MASK	0x00f0000000000000UL
-#define UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_ENABLE_MASK	0x8000000000000000UL
-
 #define UVXH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_N_GRU_SHFT	52
 #define UVXH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_ENABLE_SHFT	63
 #define UVXH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_N_GRU_MASK	0x00f0000000000000UL
@@ -3676,12 +3053,10 @@ union uvh_rh_gam_config_mmr_u {
 #define UV4H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_ENABLE_MASK	0x8000000000000000UL
 
 #define UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK (			\
-	is_uv1_hub() ? UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK :	\
 	is_uv2_hub() ? UV2H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK :	\
 	is_uv3_hub() ? UV3H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_MASK)
 #define UVH_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT (			\
-	is_uv1_hub() ? UV1H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT :	\
 	is_uv2_hub() ? UV2H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT :	\
 	is_uv3_hub() ? UV3H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_GRU_OVERLAY_CONFIG_MMR_BASE_SHFT)
@@ -3694,16 +3069,6 @@ union uvh_rh_gam_gru_overlay_config_mmr_u {
 		unsigned long	rsvd_56_62:7;
 		unsigned long	enable:1;			/* RW */
 	} s;
-	struct uv1h_rh_gam_gru_overlay_config_mmr_s {
-		unsigned long	rsvd_0_27:28;
-		unsigned long	base:18;			/* RW */
-		unsigned long	rsvd_46_47:2;
-		unsigned long	gr4:1;				/* RW */
-		unsigned long	rsvd_49_51:3;
-		unsigned long	n_gru:4;			/* RW */
-		unsigned long	rsvd_56_62:7;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uvxh_rh_gam_gru_overlay_config_mmr_s {
 		unsigned long	rsvd_0_45:46;
 		unsigned long	rsvd_46_51:6;
@@ -3742,12 +3107,10 @@ union uvh_rh_gam_gru_overlay_config_mmr_u {
 /* ========================================================================= */
 /*                   UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR                    */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR")
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR")
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR 0x1603000UL
 #define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR 0x483000UL
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG0_MMR)
@@ -3823,12 +3186,10 @@ union uvh_rh_gam_mmioh_overlay_config0_mmr_u {
 /* ========================================================================= */
 /*                   UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR                    */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
 #define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR)
@@ -3898,27 +3259,15 @@ union uvh_rh_gam_mmioh_overlay_config1_mmr_u {
 /* ========================================================================= */
 /*                   UVH_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR                     */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR 0x1600030UL
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR 0x1600030UL
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR uv_undefined("UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR")
 #define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR uv_undefined("UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR")
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR)
 
 
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT	30
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_M_IO_SHFT	46
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_N_IO_SHFT	52
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_ENABLE_SHFT 63
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_MASK	0x00003fffc0000000UL
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_M_IO_MASK	0x000fc00000000000UL
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_N_IO_MASK	0x00f0000000000000UL
-#define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_ENABLE_MASK 0x8000000000000000UL
-
-
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT	27
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_M_IO_SHFT	46
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_N_IO_SHFT	52
@@ -3931,14 +3280,6 @@ union uvh_rh_gam_mmioh_overlay_config1_mmr_u {
 
 union uvh_rh_gam_mmioh_overlay_config_mmr_u {
 	unsigned long	v;
-	struct uv1h_rh_gam_mmioh_overlay_config_mmr_s {
-		unsigned long	rsvd_0_29:30;
-		unsigned long	base:16;			/* RW */
-		unsigned long	m_io:6;				/* RW */
-		unsigned long	n_io:4;				/* RW */
-		unsigned long	rsvd_56_62:7;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uv2h_rh_gam_mmioh_overlay_config_mmr_s {
 		unsigned long	rsvd_0_26:27;
 		unsigned long	base:19;			/* RW */
@@ -3952,22 +3293,18 @@ union uvh_rh_gam_mmioh_overlay_config_mmr_u {
 /* ========================================================================= */
 /*                  UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR                    */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR uv_undefined("UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR")
 #define UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR uv_undefined("UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR")
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR 0x1603800UL
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR 0x483800UL
 #define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR)
 
-#define UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH uv_undefined("UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH")
 #define UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH uv_undefined("UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH")
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH 128
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH 128
 #define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH (			\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH :	\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH :	\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_MMR_DEPTH)
@@ -4005,22 +3342,18 @@ union uvh_rh_gam_mmioh_redirect_config0_mmr_u {
 /* ========================================================================= */
 /*                  UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR                    */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR")
 #define UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR")
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR 0x1604800UL
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR 0x484800UL
 #define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR)
 
-#define UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH uv_undefined("UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH")
 #define UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH uv_undefined("UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH")
 #define UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH 128
 #define UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH 128
 #define UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH (			\
-	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH :	\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH :	\
 	is_uv3_hub() ? UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH :	\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_MMR_DEPTH)
@@ -4058,12 +3391,10 @@ union uvh_rh_gam_mmioh_redirect_config1_mmr_u {
 /* ========================================================================= */
 /*                    UVH_RH_GAM_MMR_OVERLAY_CONFIG_MMR                      */
 /* ========================================================================= */
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR 0x1600028UL
 #define UV2H_RH_GAM_MMR_OVERLAY_CONFIG_MMR 0x1600028UL
 #define UV3H_RH_GAM_MMR_OVERLAY_CONFIG_MMR 0x1600028UL
 #define UV4H_RH_GAM_MMR_OVERLAY_CONFIG_MMR 0x480028UL
 #define UVH_RH_GAM_MMR_OVERLAY_CONFIG_MMR (				\
-	is_uv1_hub() ? UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMR_OVERLAY_CONFIG_MMR :		\
 	is_uv3_hub() ? UV3H_RH_GAM_MMR_OVERLAY_CONFIG_MMR :		\
 	/*is_uv4_hub*/ UV4H_RH_GAM_MMR_OVERLAY_CONFIG_MMR)
@@ -4073,13 +3404,6 @@ union uvh_rh_gam_mmioh_redirect_config1_mmr_u {
 #define UVH_RH_GAM_MMR_OVERLAY_CONFIG_MMR_BASE_MASK	0x00003ffffc000000UL
 #define UVH_RH_GAM_MMR_OVERLAY_CONFIG_MMR_ENABLE_MASK	0x8000000000000000UL
 
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_BASE_SHFT	26
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_DUAL_HUB_SHFT 46
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_ENABLE_SHFT	63
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_BASE_MASK	0x00003ffffc000000UL
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_DUAL_HUB_MASK 0x0000400000000000UL
-#define UV1H_RH_GAM_MMR_OVERLAY_CONFIG_MMR_ENABLE_MASK	0x8000000000000000UL
-
 #define UVXH_RH_GAM_MMR_OVERLAY_CONFIG_MMR_BASE_SHFT	26
 #define UVXH_RH_GAM_MMR_OVERLAY_CONFIG_MMR_ENABLE_SHFT	63
 #define UVXH_RH_GAM_MMR_OVERLAY_CONFIG_MMR_BASE_MASK	0x00003ffffc000000UL
@@ -4109,13 +3433,6 @@ union uvh_rh_gam_mmr_overlay_config_mmr_u {
 		unsigned long	rsvd_46_62:17;
 		unsigned long	enable:1;			/* RW */
 	} s;
-	struct uv1h_rh_gam_mmr_overlay_config_mmr_s {
-		unsigned long	rsvd_0_25:26;
-		unsigned long	base:20;			/* RW */
-		unsigned long	dual_hub:1;			/* RW */
-		unsigned long	rsvd_47_62:16;
-		unsigned long	enable:1;			/* RW */
-	} s1;
 	struct uvxh_rh_gam_mmr_overlay_config_mmr_s {
 		unsigned long	rsvd_0_25:26;
 		unsigned long	base:20;			/* RW */
@@ -4145,12 +3462,10 @@ union uvh_rh_gam_mmr_overlay_config_mmr_u {
 /* ========================================================================= */
 /*                                 UVH_RTC                                   */
 /* ========================================================================= */
-#define UV1H_RTC 0x340000UL
 #define UV2H_RTC 0x340000UL
 #define UV3H_RTC 0x340000UL
 #define UV4H_RTC 0xe0000UL
 #define UVH_RTC (							\
-	is_uv1_hub() ? UV1H_RTC :					\
 	is_uv2_hub() ? UV2H_RTC :					\
 	is_uv3_hub() ? UV3H_RTC :					\
 	/*is_uv4_hub*/ UV4H_RTC)
@@ -4209,22 +3524,18 @@ union uvh_rtc1_int_config_u {
 /* ========================================================================= */
 /*                               UVH_SCRATCH5                                */
 /* ========================================================================= */
-#define UV1H_SCRATCH5 0x2d0200UL
 #define UV2H_SCRATCH5 0x2d0200UL
 #define UV3H_SCRATCH5 0x2d0200UL
 #define UV4H_SCRATCH5 0xb0200UL
 #define UVH_SCRATCH5 (							\
-	is_uv1_hub() ? UV1H_SCRATCH5 :					\
 	is_uv2_hub() ? UV2H_SCRATCH5 :					\
 	is_uv3_hub() ? UV3H_SCRATCH5 :					\
 	/*is_uv4_hub*/ UV4H_SCRATCH5)
 
-#define UV1H_SCRATCH5_32 0x778
 #define UV2H_SCRATCH5_32 0x778
 #define UV3H_SCRATCH5_32 0x778
 #define UV4H_SCRATCH5_32 0x798
 #define UVH_SCRATCH5_32 (						\
-	is_uv1_hub() ? UV1H_SCRATCH5_32 :				\
 	is_uv2_hub() ? UV2H_SCRATCH5_32 :				\
 	is_uv3_hub() ? UV3H_SCRATCH5_32 :				\
 	/*is_uv4_hub*/ UV4H_SCRATCH5_32)
@@ -4243,22 +3554,18 @@ union uvh_scratch5_u {
 /* ========================================================================= */
 /*                            UVH_SCRATCH5_ALIAS                             */
 /* ========================================================================= */
-#define UV1H_SCRATCH5_ALIAS 0x2d0208UL
 #define UV2H_SCRATCH5_ALIAS 0x2d0208UL
 #define UV3H_SCRATCH5_ALIAS 0x2d0208UL
 #define UV4H_SCRATCH5_ALIAS 0xb0208UL
 #define UVH_SCRATCH5_ALIAS (						\
-	is_uv1_hub() ? UV1H_SCRATCH5_ALIAS :				\
 	is_uv2_hub() ? UV2H_SCRATCH5_ALIAS :				\
 	is_uv3_hub() ? UV3H_SCRATCH5_ALIAS :				\
 	/*is_uv4_hub*/ UV4H_SCRATCH5_ALIAS)
 
-#define UV1H_SCRATCH5_ALIAS_32 0x780
 #define UV2H_SCRATCH5_ALIAS_32 0x780
 #define UV3H_SCRATCH5_ALIAS_32 0x780
 #define UV4H_SCRATCH5_ALIAS_32 0x7a0
 #define UVH_SCRATCH5_ALIAS_32 (						\
-	is_uv1_hub() ? UV1H_SCRATCH5_ALIAS_32 :				\
 	is_uv2_hub() ? UV2H_SCRATCH5_ALIAS_32 :				\
 	is_uv3_hub() ? UV3H_SCRATCH5_ALIAS_32 :				\
 	/*is_uv4_hub*/ UV4H_SCRATCH5_ALIAS_32)
@@ -4267,12 +3574,10 @@ union uvh_scratch5_u {
 /* ========================================================================= */
 /*                           UVH_SCRATCH5_ALIAS_2                            */
 /* ========================================================================= */
-#define UV1H_SCRATCH5_ALIAS_2 0x2d0210UL
 #define UV2H_SCRATCH5_ALIAS_2 0x2d0210UL
 #define UV3H_SCRATCH5_ALIAS_2 0x2d0210UL
 #define UV4H_SCRATCH5_ALIAS_2 0xb0210UL
 #define UVH_SCRATCH5_ALIAS_2 (						\
-	is_uv1_hub() ? UV1H_SCRATCH5_ALIAS_2 :				\
 	is_uv2_hub() ? UV2H_SCRATCH5_ALIAS_2 :				\
 	is_uv3_hub() ? UV3H_SCRATCH5_ALIAS_2 :				\
 	/*is_uv4_hub*/ UV4H_SCRATCH5_ALIAS_2)
@@ -4719,23 +4024,6 @@ union uvxh_lb_bau_sb_activation_status_2_u {
 };
 
 /* ========================================================================= */
-/*                   UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK                    */
-/* ========================================================================= */
-#define UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK		0x320130UL
-#define UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK_32		0x9f0
-
-#define UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK_BIT_ENABLES_SHFT 0
-#define UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK_BIT_ENABLES_MASK 0x00000000ffffffffUL
-
-union uv1h_lb_target_physical_apic_id_mask_u {
-	unsigned long	v;
-	struct uv1h_lb_target_physical_apic_id_mask_s {
-		unsigned long	bit_enables:32;			/* RW */
-		unsigned long	rsvd_32_63:32;
-	} s1;
-};
-
-/* ========================================================================= */
 /*                          UV3H_GR0_GAM_GR_CONFIG                           */
 /* ========================================================================= */
 #define UV3H_GR0_GAM_GR_CONFIG				0xc00028UL
