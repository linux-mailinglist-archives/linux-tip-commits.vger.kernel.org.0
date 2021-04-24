Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD136A2C7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 24 Apr 2021 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDXTX3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 24 Apr 2021 15:23:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXTX3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 24 Apr 2021 15:23:29 -0400
Date:   Sat, 24 Apr 2021 19:22:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619292169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVg6UASrmOhYIGd3W45fEoM1+D6Wpd+ADc8akHmD790=;
        b=IKeCuAhJRezxErSY1cc3qf9ZxtpZ0IAMKZwTN7AGb8R303yO0t/sO5kIIknvvmavgha47L
        w7Jsmrshe4e0P3RoMJYo7Ww1/eJq6rFUHyKnhtu7mXNq28aaJ7BBmINxBNU6oM1qi1W0t5
        o2nFTnb7g2685IhhLCuJcxxTfHLnWGbZUOAoqOygImwfx/GhzL9r42NRweaBYqRCZrF9RC
        FzlhnFW1JuqDc+ImMOkN+fPh+DroVLKrFATY0TXJZUj/2+nVc/fP9D2QTy1DXNs+GaDcv4
        Hf1zjEdSGdrv1Q/Sf7Y5qNMJq3Cc069FHIzktJbq5vGcQs9eNJZkzbYSVVePOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619292169;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVg6UASrmOhYIGd3W45fEoM1+D6Wpd+ADc8akHmD790=;
        b=j+H6/8Va2B2/3RWqmVA8/QxPtFrCl7WmopE7WCiJCfSe7tVCl4Mz9bhoeTu4SRcV/OuFkA
        Wm+YzF8yRaeFKhBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.13' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210424094640.1731920-1-maz@kernel.org>
References: <20210424094640.1731920-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161929216888.29796.12906825332751670437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     765822e1569a37aab5e69736c52d4ad4a289eba6
Gitweb:        https://git.kernel.org/tip/765822e1569a37aab5e69736c52d4ad4a289eba6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Apr 2021 21:18:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 24 Apr 2021 21:18:44 +02:00

Merge tag 'irqchip-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip and irqdomain updates from Marc Zyngier:

 New HW support:

  - New driver for the Nuvoton WPCM450 interrupt controller
  - New driver for the IDT 79rc3243x interrupt controller
  - Add support for interrupt trigger configuration to the MStar irqchip
  - Add more external interrupt support to the STM32 irqchip
  - Add new compatible strings for QCOM SC7280 to the qcom-pdc binding

 Fixes and cleanups:

  - Drop irq_create_strict_mappings() and irq_create_identity_mapping()
    from the irqdomain API, with cleanups in a couple of drivers
  - Fix nested NMI issue with spurious interrupts on GICv3
  - Don't allow GICv4.1 vSGIs when the CPU doesn't support them
  - Various cleanups and minor fixes

Link: https://lore.kernel.org/r/20210424094640.1731920-1-maz@kernel.org
---
