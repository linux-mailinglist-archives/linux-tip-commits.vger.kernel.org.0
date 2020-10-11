Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B092F28A8FE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgJKSAW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbgJKR5a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:30 -0400
Date:   Sun, 11 Oct 2020 17:57:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5ktlsKbmEu3ydfPh9gd5b5z5SmSFaYkbgf8PJT8+/4=;
        b=k3R8vl+cPEpDOY53mfoRPX1YZjU6dShTrObrGT7JHJm9qwg30U76Roja75jC10zZk4IS2R
        2yKnIbulVSPyF+B1eJEoeFsXahBMPJrZ8txq0iBToSt3/slhDMOzpuvxhiHJqYdudUZcje
        5cbA5+EXB+fQL8tfkbVFQeYtGCF8FfuWCtMMPgDnyPBuH/Y9TqYviBIYlv4Pblv0djBYOG
        mP+S8jrbgIQPzy18gOlEgO9wvImf2YwK8RDceKgKoQQQMZQWM9iag0bESGl3cybM6rN0Lg
        6vl3Dh+JNdYSwlMycFXOBF942WU3/8xu/NKQyZVAREEWhxK9jGeSsqdFYYzGFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5ktlsKbmEu3ydfPh9gd5b5z5SmSFaYkbgf8PJT8+/4=;
        b=+T6DOGIqMbWDMKrl2uo7PZRcB7ul6mTPu8qsrlh1XJuXMRrQgVtXOmjf7pY4p2W9KME7/n
        m8z3eoJdngqyKKBw==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: dw-apb-ictl: Update binding to describe
 use as primary interrupt controller
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924071754.4509-5-thunder.leizhen@huawei.com>
References: <20200924071754.4509-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160243904641.7002.779093701720103039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8156b80fd4885d0ca9748e736441cc37f4eb476a
Gitweb:        https://git.kernel.org/tip/8156b80fd4885d0ca9748e736441cc37f4eb476a
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Thu, 24 Sep 2020 15:17:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:49:15 +01:00

dt-bindings: dw-apb-ictl: Update binding to describe use as primary interrupt controller

Add the required updates to describe the use of dw-apb-ictl as a primary
interrupt controller.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200924071754.4509-5-thunder.leizhen@huawei.com
---
 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
index 086ff08..2db59df 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
@@ -2,7 +2,8 @@ Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
 
 Synopsys DesignWare provides interrupt controller IP for APB known as
 dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
-APB bus, e.g. Marvell Armada 1500.
+APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
+controller in some SoCs, e.g. Hisilicon SD5203.
 
 Required properties:
 - compatible: shall be "snps,dw-apb-ictl"
@@ -10,6 +11,8 @@ Required properties:
   region starting with ENABLE_LOW register
 - interrupt-controller: identifies the node as an interrupt controller
 - #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
+
+Additional required property when it's used as secondary interrupt controller:
 - interrupts: interrupt reference to primary interrupt controller
 
 The interrupt sources map to the corresponding bits in the interrupt
@@ -21,6 +24,7 @@ registers, i.e.
 - (optional) fast interrupts start at 64.
 
 Example:
+	/* dw_apb_ictl is used as secondary interrupt controller */
 	aic: interrupt-controller@3000 {
 		compatible = "snps,dw-apb-ictl";
 		reg = <0x3000 0xc00>;
@@ -29,3 +33,11 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	/* dw_apb_ictl is used as primary interrupt controller */
+	vic: interrupt-controller@10130000 {
+		compatible = "snps,dw-apb-ictl";
+		reg = <0x10130000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
