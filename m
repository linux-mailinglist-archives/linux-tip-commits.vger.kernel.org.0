Return-Path: <linux-tip-commits+bounces-5964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4BAEFB89
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3FF7A62C6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761B278172;
	Tue,  1 Jul 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3rHRKgx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rabLSFzr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CB1DFD84;
	Tue,  1 Jul 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378349; cv=none; b=tbObRkcWxROdrOhu3QMNdkQZ0/wV6YeJIHdrfzDPBagELRvMwutdqua5WuU20oixM4ULoWDa2LJyb8P9dZtePRe2AUxOhx9Wcpr6+rgXggXf+wBEyy0nkKs1uGrIC22pZCEHTm0Q2lPVaaMiqnEH3saWxVqj7/2eq2mVhfKyLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378349; c=relaxed/simple;
	bh=YDAs/yy5BDW5YEdnu/IjZsu0Zxsl8OT7gYtDFmAi1kY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EpC+X/sThVfI1FZSDd0x6+yzp0fQyVaSWVcdGB7JleQrlYC+UMlENejo0ecM70d/eROMcUBCPikTo+eJBT6QYlGuck3nvk084E54de82eNDusp14NTSYEafa8jkrjY9wTP8VK7lI1/Z4oWhc7IGNXH3lEqN74mkyka05n9Af9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3rHRKgx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rabLSFzr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VuiLoh9iOioo5mI47fLj+N97CvIDTRPG3KbYMwoqMs=;
	b=M3rHRKgxDEoiSzJMUBh4pbmtG+8LKHspva6aCJj7Vyh+WXDFhYQkTxBuxo/PpG/XqMNLAT
	dVEnajJpDDHwGx9AKEPWe/fQkIGs4x0gz+c9rfGIt4MrXpasoFNb2J4IkjMa/HPlBznfHw
	Zz9y8Cv2a203okSCVZ6yxZG6z8MsvzDp56bVZIiEr1q4c29M5riyctSpVuQx+EkghqW0Ku
	7XodAITXXYf/eZzTp1qMYN//ZvLH+M1CcYpxzHeqJqKAyRI5f3ruyux/Q1QiH/mp4oFfbB
	68vdUr1aovQZKuOXbvOnIbdpRcLOOzuh2xmH+uVnd+cLISbhRfpAKHRorIHVMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VuiLoh9iOioo5mI47fLj+N97CvIDTRPG3KbYMwoqMs=;
	b=rabLSFzrREyonhp0qru2FGmbdc5x7Azh31Y8Z20cCdSE3NuEdlrgtNC4qi8auLg/chbGsZ
	XkbbPmWdWImtGdCg==
From: "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] time/timecounter: Fix the lie that struct
 cyclecounter is const
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <2025070124-backyard-hurt-783a@gregkh>
References: <2025070124-backyard-hurt-783a@gregkh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137834402.406.2758221585644809899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e78f70bad29c5ae1e1076698b690b15794e9b81e
Gitweb:        https://git.kernel.org/tip/e78f70bad29c5ae1e1076698b690b15794e9b81e
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Tue, 01 Jul 2025 14:32:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:38:25 +02:00

time/timecounter: Fix the lie that struct cyclecounter is const

In both the read callback for struct cyclecounter, and in struct
timecounter, struct cyclecounter is declared as a const pointer.

Unfortunatly, a number of users of this pointer treat it as a non-const
pointer as it is burried in a larger structure that is heavily modified by
the callback function when accessed.  This lie had been hidden by the fact
that container_of() "casts away" a const attribute of a pointer without any
compiler warning happening at all.

Fix this all up by removing the const attribute in the needed places so
that everyone can see that the structure really isn't const, but can,
and is, modified by the users of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/2025070124-backyard-hurt-783a@gregkh
---
 arch/microblaze/kernel/timer.c                        | 2 +-
 drivers/clocksource/arm_arch_timer.c                  | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c   | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c   | 2 +-
 drivers/net/can/usb/gs_usb.c                          | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.h                      | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c                       | 6 +++---
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c              | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c      | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c         | 2 +-
 drivers/net/ethernet/cavium/common/cavium_ptp.c       | 2 +-
 drivers/net/ethernet/freescale/fec_ptp.c              | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c            | 2 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c              | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c          | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c    | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_phc.c       | 2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c           | 2 +-
 drivers/net/ethernet/ti/cpts.c                        | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c           | 2 +-
 drivers/ptp/ptp_mock.c                                | 2 +-
 drivers/ptp/ptp_vclock.c                              | 2 +-
 include/linux/timecounter.h                           | 6 +++---
 kernel/time/timecounter.c                             | 2 +-
 sound/hda/hdac_stream.c                               | 2 +-
 28 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index ccb4b4b..a2ab67b 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -193,7 +193,7 @@ static struct timecounter xilinx_tc = {
 	.cc = NULL,
 };
 
-static u64 xilinx_cc_read(const struct cyclecounter *cc)
+static u64 xilinx_cc_read(struct cyclecounter *cc)
 {
 	return xilinx_read(NULL);
 }
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 981a578..80ba6a5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -243,7 +243,7 @@ static u64 arch_counter_read(struct clocksource *cs)
 	return arch_timer_read_counter();
 }
 
-static u64 arch_counter_read_cc(const struct cyclecounter *cc)
+static u64 arch_counter_read_cc(struct cyclecounter *cc)
 {
 	return arch_timer_read_counter();
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index fa85a75..72774cd 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -8,7 +8,7 @@
 
 #include "rockchip_canfd.h"
 
-static u64 rkcanfd_timestamp_read(const struct cyclecounter *cc)
+static u64 rkcanfd_timestamp_read(struct cyclecounter *cc)
 {
 	const struct rkcanfd_priv *priv = container_of(cc, struct rkcanfd_priv, cc);
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 202ca0d..413a5cb 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -11,7 +11,7 @@
 
 #include "mcp251xfd.h"
 
-static u64 mcp251xfd_timestamp_raw_read(const struct cyclecounter *cc)
+static u64 mcp251xfd_timestamp_raw_read(struct cyclecounter *cc)
 {
 	const struct mcp251xfd_priv *priv;
 	u32 ts_raw = 0;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bb63352..c9482d6 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -420,7 +420,7 @@ static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 	return 0;
 }
 
-static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev->tc_lock)
+static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
 	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 	u32 timestamp = 0;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 7d00482..feddf50 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -732,7 +732,7 @@ struct mv88e6xxx_avb_ops {
 };
 
 struct mv88e6xxx_ptp_ops {
-	u64 (*clock_read)(const struct cyclecounter *cc);
+	u64 (*clock_read)(struct cyclecounter *cc);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on);
 	int (*ptp_verify)(struct ptp_clock_info *ptp, unsigned int pin,
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 1d3b2c9..e8c9207 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -138,7 +138,7 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 }
 
-static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6352_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
@@ -152,7 +152,7 @@ static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
 
-static u64 mv88e6165_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 	u16 phc_time[2];
@@ -483,7 +483,7 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
 
-static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
index 978c4dd..e8d5c05 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -13,7 +13,7 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
-static u64 xgbe_cc_read(const struct cyclecounter *cc)
+static u64 xgbe_cc_read(struct cyclecounter *cc)
 {
 	struct xgbe_prv_data *pdata = container_of(cc,
 						   struct xgbe_prv_data,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index c9a1a1d..48ad2d6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -15176,7 +15176,7 @@ void bnx2x_set_rx_ts(struct bnx2x *bp, struct sk_buff *skb)
 }
 
 /* Read the PHC */
-static u64 bnx2x_cyclecounter_read(const struct cyclecounter *cc)
+static u64 bnx2x_cyclecounter_read(struct cyclecounter *cc)
 {
 	struct bnx2x *bp = container_of(cc, struct bnx2x, cyclecounter);
 	int port = BP_PORT(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 0669d43..7542b6d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -702,7 +702,7 @@ static void bnxt_unmap_ptp_regs(struct bnxt *bp)
 		  (BNXT_PTP_GRC_WIN - 1) * 4);
 }
 
-static u64 bnxt_cc_read(const struct cyclecounter *cc)
+static u64 bnxt_cc_read(struct cyclecounter *cc)
 {
 	struct bnxt_ptp_cfg *ptp = container_of(cc, struct bnxt_ptp_cfg, cc);
 	u64 ns = 0;
diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 984f0dd..61e2616 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -209,7 +209,7 @@ static int cavium_ptp_enable(struct ptp_clock_info *ptp_info,
 	return -EOPNOTSUPP;
 }
 
-static u64 cavium_ptp_cc_read(const struct cyclecounter *cc)
+static u64 cavium_ptp_cc_read(struct cyclecounter *cc)
 {
 	struct cavium_ptp *clock =
 		container_of(cc, struct cavium_ptp, cycle_counter);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 876d908..c28ca17 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -96,7 +96,7 @@
  * cyclecounter structure used to construct a ns counter from the
  * arbitrary fixed point registers
  */
-static u64 fec_ptp_read(const struct cyclecounter *cc)
+static u64 fec_ptp_read(struct cyclecounter *cc)
 {
 	struct fec_enet_private *fep =
 		container_of(cc, struct fec_enet_private, cc);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7719e15..b27a61f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4436,7 +4436,7 @@ u64 e1000e_read_systim(struct e1000_adapter *adapter,
  * e1000e_cyclecounter_read - read raw cycle counter (used by time counter)
  * @cc: cyclecounter structure
  **/
-static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
+static u64 e1000e_cyclecounter_read(struct cyclecounter *cc)
 {
 	struct e1000_adapter *adapter = container_of(cc, struct e1000_adapter,
 						     cc);
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 793c960..2f1fae2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -73,7 +73,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter);
 static void igb_ptp_sdp_init(struct igb_adapter *adapter);
 
 /* SYSTIM read access for the 82576 */
-static u64 igb_ptp_read_82576(const struct cyclecounter *cc)
+static u64 igb_ptp_read_82576(struct cyclecounter *cc)
 {
 	struct igb_adapter *igb = container_of(cc, struct igb_adapter, cc);
 	struct e1000_hw *hw = &igb->hw;
@@ -90,7 +90,7 @@ static u64 igb_ptp_read_82576(const struct cyclecounter *cc)
 }
 
 /* SYSTIM read access for the 82580 */
-static u64 igb_ptp_read_82580(const struct cyclecounter *cc)
+static u64 igb_ptp_read_82580(struct cyclecounter *cc)
 {
 	struct igb_adapter *igb = container_of(cc, struct igb_adapter, cc);
 	struct e1000_hw *hw = &igb->hw;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index eef25e1..eafb614 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -327,7 +327,7 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
  * result of SYSTIME is 32bits of "billions of cycles" and 32 bits of
  * "cycles", rather than seconds and nanoseconds.
  */
-static u64 ixgbe_ptp_read_X550(const struct cyclecounter *cc)
+static u64 ixgbe_ptp_read_X550(struct cyclecounter *cc)
 {
 	struct ixgbe_adapter *adapter =
 		container_of(cc, struct ixgbe_adapter, hw_cc);
@@ -364,7 +364,7 @@ static u64 ixgbe_ptp_read_X550(const struct cyclecounter *cc)
  * cyclecounter structure used to construct a ns counter from the
  * arbitrary fixed point registers
  */
-static u64 ixgbe_ptp_read_82599(const struct cyclecounter *cc)
+static u64 ixgbe_ptp_read_82599(struct cyclecounter *cc)
 {
 	struct ixgbe_adapter *adapter =
 		container_of(cc, struct ixgbe_adapter, hw_cc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 63130ba..e52cc6b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -193,7 +193,7 @@ static int ptp_pps_on(struct otx2_ptp *ptp, int on, u64 period)
 	return otx2_sync_mbox_msg(&ptp->nic->mbox);
 }
 
-static u64 ptp_cc_read(const struct cyclecounter *cc)
+static u64 ptp_cc_read(struct cyclecounter *cc)
 {
 	struct otx2_ptp *ptp = container_of(cc, struct otx2_ptp, cycle_counter);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index d73a204..2aeaafc 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -38,7 +38,7 @@
 
 /* mlx4_en_read_clock - read raw cycle counter (to be used by time counter)
  */
-static u64 mlx4_en_read_clock(const struct cyclecounter *tc)
+static u64 mlx4_en_read_clock(struct cyclecounter *tc)
 {
 	struct mlx4_en_dev *mdev =
 		container_of(tc, struct mlx4_en_dev, cycles);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index cec18ef..214d732 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -343,7 +343,7 @@ static u64 mlx5_read_time(struct mlx5_core_dev *dev,
 			   (u64)timer_l | (u64)timer_h1 << 32;
 }
 
-static u64 read_internal_timer(const struct cyclecounter *cc)
+static u64 read_internal_timer(struct cyclecounter *cc)
 {
 	struct mlx5_timer *timer = container_of(cc, struct mlx5_timer, cycles);
 	struct mlx5_clock *clock = container_of(timer, struct mlx5_clock, timer);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index e8182dd..5b9f084 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -131,7 +131,7 @@ static u64 __mlxsw_sp1_ptp_read_frc(struct mlxsw_sp1_ptp_clock *clock,
 	return (u64) frc_l | (u64) frc_h2 << 32;
 }
 
-static u64 mlxsw_sp1_ptp_read_frc(const struct cyclecounter *cc)
+static u64 mlxsw_sp1_ptp_read_frc(struct cyclecounter *cc)
 {
 	struct mlxsw_sp1_ptp_clock *clock =
 		container_of(cc, struct mlxsw_sp1_ptp_clock, cycles);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
index 7505efd..9f5c81d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -290,7 +290,7 @@ static u64 ionic_hwstamp_read(struct ionic *ionic,
 	return (u64)tick_low | ((u64)tick_high << 32);
 }
 
-static u64 ionic_cc_read(const struct cyclecounter *cc)
+static u64 ionic_cc_read(struct cyclecounter *cc)
 {
 	struct ionic_phc *phc = container_of(cc, struct ionic_phc, cc);
 	struct ionic *ionic = phc->lif->ionic;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
index 9d6399a..a38f1e7 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -181,7 +181,7 @@ static void qede_ptp_task(struct work_struct *work)
 }
 
 /* Read the PHC. This API is invoked with ptp_lock held. */
-static u64 qede_ptp_read_cc(const struct cyclecounter *cc)
+static u64 qede_ptp_read_cc(struct cyclecounter *cc)
 {
 	struct qede_dev *edev;
 	struct qede_ptp *ptp;
diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index dbbea91..2ba4c87 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -181,7 +181,7 @@ void cpts_misc_interrupt(struct cpts *cpts)
 }
 EXPORT_SYMBOL_GPL(cpts_misc_interrupt);
 
-static u64 cpts_systim_read(const struct cyclecounter *cc)
+static u64 cpts_systim_read(struct cyclecounter *cc)
 {
 	struct cpts *cpts = container_of(cc, struct cpts, cc);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 2c39b87..44f3e65 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -652,7 +652,7 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	return 0;
 }
 
-static u64 wx_ptp_read(const struct cyclecounter *hw_cc)
+static u64 wx_ptp_read(struct cyclecounter *hw_cc)
 {
 	struct wx *wx = container_of(hw_cc, struct wx, hw_cc);
 
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index e7b459c..bbd14ce 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -41,7 +41,7 @@ struct mock_phc {
 	spinlock_t lock;
 };
 
-static u64 mock_phc_cc_read(const struct cyclecounter *cc)
+static u64 mock_phc_cc_read(struct cyclecounter *cc)
 {
 	return ktime_get_raw_ns();
 }
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 7febfdc..2fdeedd 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -164,7 +164,7 @@ static const struct ptp_clock_info ptp_vclock_info = {
 	.do_aux_work	= ptp_vclock_refresh,
 };
 
-static u64 ptp_vclock_read(const struct cyclecounter *cc)
+static u64 ptp_vclock_read(struct cyclecounter *cc)
 {
 	struct ptp_vclock *vclock = cc_to_vclock(cc);
 	struct ptp_clock *ptp = vclock->pclock;
diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index 0982d1d..dce03a5 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -28,7 +28,7 @@
  * @shift:		cycle to nanosecond divisor (power of two)
  */
 struct cyclecounter {
-	u64 (*read)(const struct cyclecounter *cc);
+	u64 (*read)(struct cyclecounter *cc);
 	u64 mask;
 	u32 mult;
 	u32 shift;
@@ -53,7 +53,7 @@ struct cyclecounter {
  * @frac:		accumulated fractional nanoseconds
  */
 struct timecounter {
-	const struct cyclecounter *cc;
+	struct cyclecounter *cc;
 	u64 cycle_last;
 	u64 nsec;
 	u64 mask;
@@ -100,7 +100,7 @@ static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
  * the time stamp counter by the number of elapsed nanoseconds.
  */
 extern void timecounter_init(struct timecounter *tc,
-			     const struct cyclecounter *cc,
+			     struct cyclecounter *cc,
 			     u64 start_tstamp);
 
 /**
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index e628528..3d2a354 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -6,7 +6,7 @@
 #include <linux/timecounter.h>
 
 void timecounter_init(struct timecounter *tc,
-		      const struct cyclecounter *cc,
+		      struct cyclecounter *cc,
 		      u64 start_tstamp)
 {
 	tc->cc = cc;
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index e7f6208..4a87bef 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -634,7 +634,7 @@ int snd_hdac_stream_set_params(struct hdac_stream *azx_dev,
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_set_params);
 
-static u64 azx_cc_read(const struct cyclecounter *cc)
+static u64 azx_cc_read(struct cyclecounter *cc)
 {
 	struct hdac_stream *azx_dev = container_of(cc, struct hdac_stream, cc);
 

