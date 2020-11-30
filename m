Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE62C80E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Nov 2020 10:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgK3JXm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 30 Nov 2020 04:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgK3JXl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 30 Nov 2020 04:23:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940EC0613D4;
        Mon, 30 Nov 2020 01:23:01 -0800 (PST)
Date:   Mon, 30 Nov 2020 09:22:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606728178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVySK87KiEC5eQir1K/CIAWTPMBHfuQx2J3VlxQ5xpo=;
        b=N7V0ynWLF1lpzs48TBA1jZIcAO6UxL+uCYvNm3SCfhNRh+d4vFgh1ml8PLvucoy1SuvDBJ
        NCguiAQhXL2LjxyHBwxeL7YoIr1iE5utW/QC45HkS8esWw2QoAEsthP62NpC06HV4mNgne
        Wh1+cQVLWEsoOpIGbK+govfNICfEJPTU2FynqXrmbA86JFxbNshm7kIIpSee5p8bsrUiKf
        qEHzcwZoc6vIVa7V5MsIKkKVbT3XFeVAaKEGo9Jg41OX5AVAvNGLnuDjFGOM2q1ehD/wKr
        QgtvUVha/W6EyMWFtBD+M4haacv5w8tvMS7gEgJX343Lju2jpOzVslE79n0wfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606728178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVySK87KiEC5eQir1K/CIAWTPMBHfuQx2J3VlxQ5xpo=;
        b=saencdVHn1dhaLsV1VBtkYI8zux4S3XF5VATK4f/fT6tn4se9n6rptN+t0nfxq/ohibUIb
        oqztkq9TSEG4NjDQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] MAINTAINERS: Move Jason Cooper to CREDITS
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201128103707.332874-1-maz@kernel.org>
References: <20201128103707.332874-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160672817751.3364.7459472481507223428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     509920aee72ae23235615a009c5148cdb38794c3
Gitweb:        https://git.kernel.org/tip/509920aee72ae23235615a009c5148cdb38794c3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 28 Nov 2020 10:37:07 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 30 Nov 2020 10:20:34 +01:00

MAINTAINERS: Move Jason Cooper to CREDITS

Jason's email address has now been bouncing for weeks, and no
reply was received when trying to reach out on other addresses.

We really hope he is OK. But until we hear of his whereabouts,
let's move him to the CREDITS file so that people stop Cc-ing
him.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20201128103707.332874-1-maz@kernel.org

---
 CREDITS     | 5 +++++
 MAINTAINERS | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 7483019..e88d1a7 100644
--- a/CREDITS
+++ b/CREDITS
@@ -740,6 +740,11 @@ S: (ask for current address)
 S: Portland, Oregon
 S: USA
 
+N: Jason Cooper
+D: ARM/Marvell SOC co-maintainer
+D: irqchip co-maintainer
+D: MVEBU PCI DRIVER co-maintainer
+
 N: Robin Cornelius
 E: robincornelius@users.sourceforge.net
 D: Ralink rt2x00 WLAN driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee..4f27f43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2014,7 +2014,6 @@ M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
 ARM/Marvell Dove/MV78xx0/Orion SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 M:	Gregory Clement <gregory.clement@bootlin.com>
@@ -2031,7 +2030,6 @@ F:	arch/arm/plat-orion/
 F:	drivers/soc/dove/
 
 ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@bootlin.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
@@ -9248,7 +9246,6 @@ F:	kernel/irq/
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -13394,7 +13391,6 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
