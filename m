Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C940441719F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Sep 2021 14:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhIXMUM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Sep 2021 08:20:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41780 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhIXMUM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Sep 2021 08:20:12 -0400
Date:   Fri, 24 Sep 2021 12:18:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632485918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUKnLTnBgXcQgH9joaZ/AUNwsjfzp2yh3/6UtniDmvY=;
        b=fgv4eCu/a7tUDSNOBKAdDTM1WmcwliqJ/bLlykNPVfLG0WmZPAqS/y8EtD3pSow0yCC7mC
        YNGhOQRm3HzRks6/11J3bgKnnNrS2V8Jh3BQP8M3J6L2rF24ks/lXFbwZGukFP3bXxfFcS
        /RnBUwB8e2iCfGnHPChWYdTZvqRFzlvlWJx7GBLlUKII8hw126+jqZSR82f1FVk1pju7/b
        vbvD5wDLE3IjaXVuCnLfKg+YPysItT/wxvK3NBwYh55b/dJJ8PG+1HsUSMkPA8kR+LfOpW
        CgkwUE3hHM8BAoZsk8h/TBdZnK4ltepDHpYBcKImjL7b/uCgQydmT/uh5fo/7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632485918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUKnLTnBgXcQgH9joaZ/AUNwsjfzp2yh3/6UtniDmvY=;
        b=mibxwUVAHCUwEXpZ4Zb9smpJiDnIPLW91OkNMAKLXVXLJj06wL+wHMmsv9fMxuOuZvrT8+
        GwQV2eSsuOCi7PCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.15-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210924090933.2766857-1-maz@kernel.org>
References: <20210924090933.2766857-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163248591729.25758.12136481276210509832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f9bfed3ad5b1662426479be2c7b26a608560b7d4
Gitweb:        https://git.kernel.org/tip/f9bfed3ad5b1662426479be2c7b26a608560b7d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 24 Sep 2021 14:11:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Sep 2021 14:11:04 +02:00

Merge tag 'irqchip-fixes-5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Work around a bad GIC integration on a Renesas platform, where the
   interconnect cannot deal with byte-sized MMIO accesses

 - Cleanup another Renesas driver abusing the comma operator

 - Fix a potential GICv4 memory leak on an error path

 - Make the type of 'size' consistent with the rest of the code in
   __irq_domain_add()

 - Fix a regression in the Armada 370-XP IPI path

 - Fix the build for the obviously unloved goldfish-pic

 - Some documentation fixes

Link: https://lore.kernel.org/r/20210924090933.2766857-1-maz@kernel.org
---
