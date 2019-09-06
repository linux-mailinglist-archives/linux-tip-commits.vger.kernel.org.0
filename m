Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8395EAB6AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2019 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfIFLI2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Sep 2019 07:08:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392313AbfIFLI1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6L-000773-1H; Fri, 06 Sep 2019 13:08:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9ACA21C0E25;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: arm,gic-v3:
 Describe EPPI range support
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809659.24167.16212984069713889174.tip-bot2@tip-bot2>
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

Commit-ID:     4b049063e0bcbfd302f6bf867de9d55a965d622e
Gitweb:        https://git.kernel.org/tip/4b049063e0bcbfd302f6bf867de9d55a965d622e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 18 Jul 2019 13:18:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:35 +01:00

dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range support

Update the GICv3 binding to allow interrupts in the EPPI range.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 98a3ecd..1fe147d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -44,12 +44,13 @@ properties:
       be at least 4.
 
       The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-      interrupts, 2 for interrupts in the Extended SPI range. Other values
-      are reserved for future use.
+      interrupts, 2 for interrupts in the Extended SPI range, 3 for the
+      Extended PPI range. Other values are reserved for future use.
 
       The 2nd cell contains the interrupt number for the interrupt type.
       SPI interrupts are in the range [0-987]. PPI interrupts are in the
       range [0-15]. Extented SPI interrupts are in the range [0-1023].
+      Extended PPI interrupts are in the range [0-127].
 
       The 3rd cell is the flags, encoded as follows:
       bits[3:0] trigger type and level flags.
