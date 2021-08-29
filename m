Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426A73FAE03
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Aug 2021 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhH2T3a (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 29 Aug 2021 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhH2T3a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 29 Aug 2021 15:29:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CFC061575;
        Sun, 29 Aug 2021 12:28:37 -0700 (PDT)
Date:   Sun, 29 Aug 2021 19:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630265314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuZBXIGF3gU4xhLyoJf+sJ78djKKn5izyrGC0zoExVs=;
        b=d12GBYtjXJHehAsrciEuzcMA3TK837iUXzNADu+3vtcKkv6WgsVvZkeJ6bvttnVfl0lKu7
        A28WpnKwKwRFbbgUFGyoCG+gCL4qBhmB1YrJWmF/m3bDwl+IYH5J73Ys3WjTPT4UqtF9pv
        aGX5YHOWNwSPqIa+6lIYUtLAJ9xKeovKMlNsdreg89Z7XFDR7QxhiEQLXDyezY4XpMBN+x
        vZZSw2Ju/ewFLGZczjHnyPZjSKKOq/U4AcyKvtepqEhcKlspPStCx3sMT8pEzzbwLo3jYd
        VZibVVN0V/tmIhTi7mlHFAWF4d2v7O8gpwXk7CbitwT4ZIVFxXIOBqTIfO9Otw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630265314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuZBXIGF3gU4xhLyoJf+sJ78djKKn5izyrGC0zoExVs=;
        b=4M7mmnAvdbTvwVSW2rp4bl9KVfwMoafYQZ/svua32vzRaXSwlTd8w7udrUGZgwtlu2+U2r
        kHbkh8R1p+eOtxAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.15' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210828121013.2647964-1-maz@kernel.org>
References: <20210828121013.2647964-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163026531340.25758.15073464033059744433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
Gitweb:        https://git.kernel.org/tip/47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 29 Aug 2021 21:19:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 29 Aug 2021 21:19:50 +02:00

Merge tag 'irqchip-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

- API updates:

  - Treewide conversion to generic_handle_domain_irq() for anything
    that looks like a chained interrupt controller

  - Update the irqdomain documentation

  - Use of bitmap_zalloc() throughout the tree

- New functionalities:

  - Support for GICv3 EPPI partitions

- Fixes:

  - Qualcomm PDC hierarchy fixes

  - Yet another priority decoding fix for the GICv3 pseudo-NMIs

  - Fix the apple-aic driver irq_eoi() callback to always unmask
    the interrupt

  - Properly handle edge interrupts on loongson-pch-pic

  - Let the mtk-sysirq driver advertise IRQCHIP_SKIP_SET_WAKE

Link: https://lore.kernel.org/r/20210828121013.2647964-1-maz@kernel.org
---
