Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FEC252443
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Aug 2020 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHYXlD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 Aug 2020 19:41:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgHYXlB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:01 -0400
Date:   Tue, 25 Aug 2020 23:40:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UV7nJnAhrW3GKe575JOj8//iNajmOzCWHzckEFhvL0E=;
        b=fSiRkZxQi+BN2mUCZWsYqej+90dVmi5jiuqytYvXYKT2BlQrf7NLyMon3/TZn5LLxiupMB
        PGdYeh9DOH2oYkcZhGO0IRldczGNknPFfaKKavH0VDSGe24WI+iUIMjDu4kklaKAc/Fxiw
        zUzhC1NVlw9etiVQWwiHscFu6W+rRnvGIJn/aTyur6jEUl1D4bQP8tfKcBV7bvavoY1W9r
        nad+sV/xM6FbWD37tzhEjQx0lkvpuZHU4SpgWUPbB8fqcrQrJlAnks6Sk8ThooVw9iF3By
        OmzUl5uqtDWz/f2Y3f4BsbUnzGnaIiBjGv6Fn9YwIasCYWHPhTsnhvZqeFk0iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UV7nJnAhrW3GKe575JOj8//iNajmOzCWHzckEFhvL0E=;
        b=pugshXmTumupnT+MMh9W/OA2wCS9MGN0172zOlyiM7RjvhPzzuiBon45ne8A742LXZxaHX
        4WKboHrLxmk2KlAQ==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] dt-bindings: irqchip: ti, sci-inta: Update docs to
 support different parent.
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-8-lokeshvutla@ti.com>
References: <20200806074826.24607-8-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839885813.389.9491882139813708120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6dde29dc31aa265a79d9e6b3571987cfa4b179cc
Gitweb:        https://git.kernel.org/tip/6dde29dc31aa265a79d9e6b3571987cfa4b179cc
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:20 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:00:23 +01:00

dt-bindings: irqchip: ti, sci-inta: Update docs to support different parent.

Drop the firmware related interrupt ranges and use the hardware specified
interrupt numbers within Interrupt Aggregator. This ensures interrupt
aggregator DT node need not assume any interrupt parent type.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200806074826.24607-8-lokeshvutla@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
index 7841cb0..5fd3ee0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
@@ -43,13 +43,14 @@ TISCI Interrupt Aggregator Node:
 - msi-controller:	Identifies the node as an MSI controller.
 - interrupt-parent:	phandle of irq parent.
 - ti,sci:		Phandle to TI-SCI compatible System controller node.
-- ti,sci-dev-id:	TISCI device ID of the Interrupt Aggregator.
-- ti,sci-rm-range-vint:	Array of TISCI subtype ids representing vints(inta
-			outputs) range within this INTA, assigned to the
-			requesting host context.
-- ti,sci-rm-range-global-event:	Array of TISCI subtype ids representing the
-			global events range reaching this IA and are assigned
-			to the requesting host context.
+- ti,sci-dev-id:	TISCI device id of interrupt controller.
+- ti,interrupt-ranges:	Set of triplets containing ranges that convert
+			the INTA output interrupt numbers to parent's
+			interrupt number. Each triplet has following entries:
+			- First entry specifies the base for vint
+			- Second entry specifies the base for parent irqs
+			- Third entry specifies the limit
+
 
 Example:
 --------
@@ -61,6 +62,5 @@ main_udmass_inta: interrupt-controller@33d00000 {
 	interrupt-parent = <&main_navss_intr>;
 	ti,sci = <&dmsc>;
 	ti,sci-dev-id = <179>;
-	ti,sci-rm-range-vint = <0x0>;
-	ti,sci-rm-range-global-event = <0x1>;
+	ti,interrupt-ranges = <0 0 256>;
 };
