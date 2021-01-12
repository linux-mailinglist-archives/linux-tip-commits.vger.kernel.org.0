Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA682F3CEF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436832AbhALVhX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436947AbhALUaS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:30:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451BC06179F;
        Tue, 12 Jan 2021 12:29:37 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:29:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610483376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeqVsDioK3lQgkhcnCI1f5fYDadLxqsi6t2A7TUygYo=;
        b=mYIFuslZlIFWoOdWT6SLMlGORtHlI8tDbP4qr4RAPccFAOPa/xfyldIYdrCh28iYVZmpOb
        X1aLnQQ7MAUjKL0x0FL+ZnvrheJLiYqPJ6No/BHr1daYXMPU+BjaTCVLmh11XPKfQowvEJ
        4i4rzfJeaj4t5Th3Kn5j9GZyLrsMU7i7s8w2M2u/7iWpeqiG6E7+Ft/F9D5VmfZYhWhgRB
        kVukYST/bDrWh8WXQ+8VHQNUw98lWRfkx7Z0olKS8C6bfXECC5sTusi0dbfjIqKpOQqhkE
        uXc9r79qYBIOe/PbOQLnnGRAEIdmX5abMvf7GgAUIOjk78TjHw99sVPCeNSD9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610483376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeqVsDioK3lQgkhcnCI1f5fYDadLxqsi6t2A7TUygYo=;
        b=dSM8CAMddp1XtZ3y5jJsoyaCnckyinbe7V0B/+YvxWx22xZUYsiu4fYWGzanXfp/7vKKC2
        9MfrwwVJ+nmbhgBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.11-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210110110001.2328708-1-maz@kernel.org>
References: <20210110110001.2328708-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161048337540.414.10902407884598163996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4bae052dde14c5538eca39592777b1d1987234ba
Gitweb:        https://git.kernel.org/tip/4bae052dde14c5538eca39592777b1d1987234ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Jan 2021 21:23:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:23:55 +01:00

Merge tag 'irqchip-fixes-5.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Fix the MIPS CPU interrupt controller hierarchy
 - Simplify the PRUSS Kconfig entry
 - Eliminate trivial build warnings on the MIPS Loongson liointc
 - Fix error path in devm_platform_get_irqs_affinity()
 - Turn the BCM2836 IPI irq_eoi callback into irq_ack
 - Fix initialisation of on-stack msi_alloc_info
 - Cleanup spurious comma in irq-sl28cpld

Link: https://lore.kernel.org/r/20210110110001.2328708-1-maz@kernel.org
---
