Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15E1EA477
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jun 2020 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFANL7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Jun 2020 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgFANL5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B7C08C5CA;
        Mon,  1 Jun 2020 06:11:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEL-00078J-1e; Mon, 01 Jun 2020 15:11:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B440C1C0481;
        Mon,  1 Jun 2020 15:11:47 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:47 -0000
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: dts: Add 32KHz clock as default clock source
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159101710759.17951.10094833069617639382.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ac819eda7cc96656df50897848ffe5dfe9a3cb7c
Gitweb:        https://git.kernel.org/tip/ac819eda7cc96656df50897848ffe5dfe9a3cb7c
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Mon, 27 Apr 2020 22:56:04 +05:30
Committer:     Tony Lindgren <tony@atomide.com>
CommitterDate: Tue, 05 May 2020 10:56:42 -07:00

ARM: dts: Add 32KHz clock as default clock source

Clocksource to timer configured in pwm mode can be selected using the DT
property ti,clock-source. There are few pwm timers which are not
selecting the clock source and relying on default value in hardware or
selected by driver. Instead of relying on default value, always select
the clock source from DT.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Reviewed-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-guardian.dts            | 1 +
 arch/arm/boot/dts/am3517-evm.dts                 | 1 +
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi | 1 +
 arch/arm/boot/dts/omap3-gta04.dtsi               | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 81e0f63..0ebe9e2 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -105,6 +105,7 @@
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dmtimer7_pins>;
+		ti,clock-source = <0x01>;
 	};
 
 	vmmcsd_fixed: regulator-3v3 {
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index a1fd3e6..92466b9 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -156,6 +156,7 @@
 		pinctrl-0 = <&pwm_pins>;
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 	/* HS USB Host PHY on PORT 1 */
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index f7b82ce..381f0e8 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -65,6 +65,7 @@
 		pinctrl-0 = <&pwm_pins>;
 		ti,timers = <&timer10>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 };
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 409a758..ecc4586 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -150,6 +150,7 @@
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
+		ti,clock-source = <0x01>;
 	};
 
 	hsusb2_phy: hsusb2_phy {
