Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9F28A8A4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbgJKR5i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgJKR51 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:27 -0400
Date:   Sun, 11 Oct 2020 17:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y/Av0WpOa5U/LqSakiQrMQ3TCP7ViKgFBuz8AV9Atuc=;
        b=vMHOwEmd19oy+VLw7wuJ7UbPa1BvxpbBWB4BhveCdltaV1Ytt+yA9B37NSbi+8QZdyxbEo
        1xWYbc6+CArrC0qtKw7NU0C0ZNLII22ypvg4/4OBVHVRqQFXE+tDXfRBYXL07S4nNBftr3
        uKuMm7rwWUhqoWBhC7wma61yoLJSYtaYFSIZKEhsXYnqrvnPSmbV0si+f3qFMH1mI+eqyF
        iwqF+gjHOH/0THlX+W3t6zmnUL6N5Hy+iY7+1QLNO1wHO3rkfMyOxosDGQ8AFDuArWAEV8
        VMguEcuTdcYCSVY6uZ5IHhjt8XH1N7Uv2hZcJ2ov+fB1jBbSduGFM0ZelQrGaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y/Av0WpOa5U/LqSakiQrMQ3TCP7ViKgFBuz8AV9Atuc=;
        b=DmDfju7JJ4ytwN46mTqvAwbc791fgwLV6XrRUfatrCI2uRRPWAE0T9UMe8JHuhN/kVfCja
        r3kIM9PrR2KmP5AA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: Handle no IPI being registered in show_ipi_list()
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243904427.7002.9696332039937365454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     220387048d859896ccc362c0ebf9bc1e0fa62eb9
Gitweb:        https://git.kernel.org/tip/220387048d859896ccc362c0ebf9bc1e0fa62eb9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 25 Sep 2020 16:22:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Sep 2020 11:32:04 +01:00

ARM: Handle no IPI being registered in show_ipi_list()

As SMP-on-UP is a valid configuration on 32bit ARM, do not assume that
IPIs are populated in show_ipi_list().

Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: kernelci.org bot <bot@kernelci.org>
Tested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8425da5..48099c6 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -541,7 +541,12 @@ void show_ipi_list(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
-		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
+		unsigned int irq;
+
+		if (!ipi_desc[i])
+			continue;
+
+		irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
