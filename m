Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B429D31BB91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBOO4t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhBOO4g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:36 -0500
Date:   Mon, 15 Feb 2021 14:55:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAwJHyt/Rqc25Jrx90im2EMtgjRxpoKIgRc2JmuX4js=;
        b=tlztCrRV5JY0eEW132ueF4hgkSIchWz8UAvnDuWPmOZfirSTQPvxNfmp/D1qXmGCoLJl67
        sb+vano+OTRB48F1+6XbwtQ0tK4fQgtr/6kQRTxM5wkEYhYDs6s+beptXQJVLnwDft2w1N
        Kqw2bOKfM3o08Yz8z/yVkeXnaFLLQJktt3gZmU4q1l2yNvQ7S5C3xQtRXEo7k1PE0C2Cfl
        yzHoueJpPqe0uUgMeGNEcNOvgtzCVEit63XlLzwXKKESZExlwmQopAfsT7mGsqFt082FV6
        w20vO3BXH0sCY0uy4OMUTGWJSGalOcm9s3iJSwKbxcD6CAxCHCkUe8PoQZAlqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAwJHyt/Rqc25Jrx90im2EMtgjRxpoKIgRc2JmuX4js=;
        b=5CaZHFDC67oOElh2weDE1YA3yB1Xi61n4+cKRl39etGWQus69m6nUGdkXuMOWtbWAHPMYZ
        PurEFVENoIaaJbAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.12' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210214124015.3333457-1-maz@kernel.org>
References: <20210214124015.3333457-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161340095444.20312.16322248366213568513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b6d70e571a1c764ab079e5c31d4156feee4b06b
Gitweb:        https://git.kernel.org/tip/0b6d70e571a1c764ab079e5c31d4156feee4b06b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Feb 2021 15:41:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Feb 2021 15:41:56 +01:00

Merge tag 'irqchip-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier

 - New driver for the MIPS-based Realtek RTL838x/RTL839x SoC
 - Conversion of the sun6i-r support code to a hierarchical setup
 - Fix wake-up interrupts for the ls-extirq driver
 - Fix MSI allocation for the loongson-pch-msi driver
 - Add compatible strings for new Qualcomm SoCs
 - Tidy up a few Kconfig entries (IMX, CSKY)
 - Spelling phyksiz
 - Remove the sirfsoc and tango drivers

Link: https://lore.kernel.org/r/20210214124015.3333457-1-maz@kernel.org
---
