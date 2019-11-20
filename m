Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47D103B1D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfKTNWb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 08:22:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfKTNVW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv5-0007EA-4l; Wed, 20 Nov 2019 14:21:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2EBEB1C1A1D;
        Wed, 20 Nov 2019 14:21:06 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:06 -0000
From:   "tip-bot2 for Florian Fainelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: Document brcm, int-fwd-mask property for
 bcm7038-l1-intc
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191024201415.23454-5-f.fainelli@gmail.com>
References: <20191024201415.23454-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <157425606600.12247.11850709804199534144.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e14b5e5ff0841270e6262e3e5fd69ad764a80aee
Gitweb:        https://git.kernel.org/tip/e14b5e5ff0841270e6262e3e5fd69ad764a80aee
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Thu, 24 Oct 2019 13:14:14 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:47 

dt-bindings: Document brcm, int-fwd-mask property for bcm7038-l1-intc

Indicate that the brcm,int-fwd-mask property is optional and can be set
on platforms which require to leave specific interrupts unmanaged by
Linux and need to retain the firmware configuration.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-5-f.fainelli@gmail.com
---
 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
index 4eb0432..5ddef1d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
@@ -36,6 +36,12 @@ Optional properties:
 - brcm,irq-can-wake: If present, this means the L1 controller can be used as a
   wakeup source for system suspend/resume.
 
+Optional properties:
+
+- brcm,int-fwd-mask: if present, a bit mask to indicate which interrupts
+  have already been configured by the firmware and should be left unmanaged.
+  This should have one 32-bit word per status/set/clear/mask group.
+
 If multiple reg ranges and interrupt-parent entries are present on an SMP
 system, the driver will allow IRQ SMP affinity to be set up through the
 /proc/irq/ interface.  In the simplest possible configuration, only one
