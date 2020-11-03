Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9D2A49C4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Nov 2020 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKCPah (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Nov 2020 10:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgKCP3d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4403C061A48;
        Tue,  3 Nov 2020 07:29:32 -0800 (PST)
Date:   Tue, 03 Nov 2020 15:29:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604417371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8/e5IFrTqIwtRICO+bpxRvUanylygCEjoO3F833h/k=;
        b=OPlf+EVX4boAw207TXQeMEifISEFY9mvubdEE8XvztkwD8L5J+hSbPCbx3nha4azxSVFz6
        Yj2abSmK/2WkAZ1lNkT47/SzAC9+ZiXIiC6l1gcqSFJSjxBOgwMOOGgtIo95GVV93/hobV
        iFYUX/4blP9pljTv55RrrOmtolSmeFLuzKrh9OPkbjAP0jlxFeP4DDv/kIzAtkSPwK4z3A
        p+6bUO55GREeCDydbY/h5teTjx09mMoISyQiCMBXxPRrEGSi5U9IVQGRGS2zQ88J76NKXA
        QPk79eONOZMTImcszqhDBhMOCB2kwVOQn/Epmj+Oesb5ZyocbrYVmn6x5ca7oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604417371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8/e5IFrTqIwtRICO+bpxRvUanylygCEjoO3F833h/k=;
        b=lL86WPsWS3SsVPk8wnBs+qygHGjATRbtVYOjhxtIF/4PCL2KPx/fRAJDJv4WUl/gAtrlFY
        iTuyfhUpYxIJYzCA==
From:   "tip-bot2 for Peter Ujfalusi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] dt-bindings: irqchip: ti, sci-inta: Fix diagram
 indentation for unmapped events
Cc:     Rob Herring <robh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103135004.2363-1-peter.ujfalusi@ti.com>
References: <20201103135004.2363-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Message-ID: <160441736983.397.807773403524844790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     82768a86c64659c7181571ebfbc41ec9f2e52dde
Gitweb:        https://git.kernel.org/tip/82768a86c64659c7181571ebfbc41ec9f2e52dde
Author:        Peter Ujfalusi <peter.ujfalusi@ti.com>
AuthorDate:    Tue, 03 Nov 2020 15:50:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Nov 2020 16:25:55 +01:00

dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for unmapped events

One space has been missing by the diagram update.

Fixes: bb2bd7c7f3d0 ("dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201103135004.2363-1-peter.ujfalusi@ti.com

---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index cc79549..8d90bc5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -34,7 +34,7 @@ description: |
                        |                                         |
                        |      Unmap                              |
                        | +--------------+                        |
- Unmapped events ----->| |   umapidx    |-------------------------> Globalevents
+  Unmapped events ---->| |   umapidx    |-------------------------> Globalevents
                        | +--------------+                        |
                        |                                         |
                        +-----------------------------------------+
