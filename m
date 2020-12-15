Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78C2DAA75
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Dec 2020 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgLOJzX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Dec 2020 04:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLOJzV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Dec 2020 04:55:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E9C06179C;
        Tue, 15 Dec 2020 01:54:40 -0800 (PST)
Date:   Tue, 15 Dec 2020 09:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608026078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkkZ1bnfhidQ9s+9M5c8h3pn9iOV5knY3H32OkphY6E=;
        b=lczz4rpH4wzI0oTzDPJQyDPSRFelzEQQXdXvQD3LRRwhyFFjotQx80DRP6hb6Vn2YjEk1/
        1TGVrrPm8iTlbsWEJEjq3LGNPpU5Ak2+lll2Jjd6IOjJZrvUXMynJ8t9QliZPLwZcvWoFM
        FlY6zJmgwwTAUzI+tFKkyXYqiqJMLHNGmIOU1lQxKyVfSTwupXKjPaYbmDqXwqQJKWaTmm
        Fohs0+VdOsfcK1CEZttP8NQu6StlU4+KKaG0deoH/UH7iApvs5QDp7A2oCftP+R/L4aAuh
        rVBBXz2MziilZRvi/iQ8H1Qpzsd1TGhwjQvvDMv1CutWLe93TUkPDl8RKNtFiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608026078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkkZ1bnfhidQ9s+9M5c8h3pn9iOV5knY3H32OkphY6E=;
        b=kIZIMAnaa8r723AQU3R/uEh7H/pBkZBbIKQvfFgsq9sCV4UJS/56jFUehKZynpMwdTSGcC
        CXCnk+iRlMbivFBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.11' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201212135626.1479884-1-maz@kernel.org>
References: <20201212135626.1479884-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160802607773.3364.11177787714362053582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3c41e57a1e168d879e923c5583adeae47eec9f64
Gitweb:        https://git.kernel.org/tip/3c41e57a1e168d879e923c5583adeae47eec9f64
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 10:48:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Dec 2020 10:48:07 +01:00

Merge tag 'irqchip-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates for 5.11 from Marc Zyngier:

  - Preliminary support for managed interrupts on platform devices
  - Correctly identify allocation of MSIs proxyied by another device
  - Remove the fasteoi IPI flow which has been proved useless
  - Generalise the Ocelot support to new SoCs
  - Improve GICv4.1 vcpu entry, matching the corresponding KVM optimisation
  - Work around spurious interrupts on Qualcomm PDC
  - Random fixes and cleanups

Link: https://lore.kernel.org/r/20201212135626.1479884-1-maz@kernel.org
---
