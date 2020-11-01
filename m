Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206C2A1FB3
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgKARAL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgKARAL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE57C061A04;
        Sun,  1 Nov 2020 09:00:10 -0800 (PST)
Date:   Sun, 01 Nov 2020 17:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z24KCw26SI/i8tvtphq2lnupjg7U+HCKvoU06qTriQg=;
        b=3QmrRb7+R7F67tnDnaIR+maUjAd4vEZu3wlv7OJAEA8yLpUFxE35OWouM55z+Of69h45eQ
        NDE6aNqjhGqPDh6mLzm5wyrehT801I1p34CKtfjQwz/nPjzsl8jhgP6/Sd6JmCX+WixfzV
        wqilVs83V+Xa+YajWjWHK6EB/repxFwGX/GV5TzmeUoGc4C2kKb4d9TIKPk2tlfgDlruLA
        3Yi3kYBb4G71km8XRRPNKDaVoy5jHIjkesA7Ocl3PFvLJEHnCDfpNYiqERNO+73OKgjCuK
        gNwxqjU8A0+o+HenUxEn9f1k/T7pMc/tT/+Y3fJWgd+9hPxnapf3tj/qW85tzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z24KCw26SI/i8tvtphq2lnupjg7U+HCKvoU06qTriQg=;
        b=24o1yqgBqrBFz/ZnU1HDKpkVP61H9a6JHJekICkzKaUkIWw6E8F3/Xx2IeTwlpKZ1qOkyo
        tv/IVyRmXNs4OvBA==
From:   "tip-bot2 for Peter Ujfalusi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] dt-bindings: irqchip: ti, sci-inta: Update for
 unmapped event handling
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020073243.19255-2-peter.ujfalusi@ti.com>
References: <20201020073243.19255-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Message-ID: <160425000793.397.16218233475336649509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     bb2bd7c7f3d0946acc2104db31df228d10f7b598
Gitweb:        https://git.kernel.org/tip/bb2bd7c7f3d0946acc2104db31df228d10f7b598
Author:        Peter Ujfalusi <peter.ujfalusi@ti.com>
AuthorDate:    Tue, 20 Oct 2020 10:32:42 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 01 Nov 2020 12:00:50 

dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling

The new DMA architecture introduced with AM64 introduced new event types:
unampped events.

These events are mapped within INTA in contrast to other K3 devices where
the events with similar function was originating from the UDMAP or ringacc.

The ti,unmapped-event-sources should contain phandle array to the devices
in the system (typically DMA controllers) from where the unmapped events
originate.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20201020073243.19255-2-peter.ujfalusi@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index c7cd056..cc79549 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -32,6 +32,11 @@ description: |
                        | | vint  | bit  |  | 0 |.....|63| vintx  |
                        | +--------------+  +------------+        |
                        |                                         |
+                       |      Unmap                              |
+                       | +--------------+                        |
+ Unmapped events ----->| |   umapidx    |-------------------------> Globalevents
+                       | +--------------+                        |
+                       |                                         |
                        +-----------------------------------------+
 
   Configuration of these Intmap registers that maps global events to vint is
@@ -70,6 +75,11 @@ properties:
         - description: |
             "limit" specifies the limit for translation
 
+  ti,unmapped-event-sources:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description:
+      Array of phandles to DMA controllers where the unmapped events originate.
+
 required:
   - compatible
   - reg
