Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA32D89CD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 20:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407785AbgLLTkR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 14:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406740AbgLLTkQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 14:40:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB34C0613CF;
        Sat, 12 Dec 2020 11:39:36 -0800 (PST)
Date:   Sat, 12 Dec 2020 19:39:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607801974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDYwAzyElCvXYFsbd5ktPcqPDvAo95UX4JW6sIh+rN4=;
        b=uOTBBxtrKJ7/YvIxcPgRe3kdI8EbGvjDM73Q2d6UPx1XNPeejjOMudXLCtS3SEtN6oQdyB
        AbBeMmyz6osmm5CjBHnAwf2gcjxQ5wffMxrMUsV87hUgz5AolQFisVp+gqlgKNJjy1Zrmy
        w/BflINHWumCsEX5Dm+UJxYBr/2rd9NoN83CD9O83qhZxHFtaL7lBMqZo8RWd3aTH4iB5Q
        kTIwMgYH+I9kiD5rGhxtjDar93NJCcmYDU1gcMlzAbGdzamt//aI9DqVX+//2iKr+Fe6dU
        IqqNYy+pjtad5wCc8tFT10PNLUQONTfHkNi35HuaMFIkmEtsllF9BdOWYTz5lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607801974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDYwAzyElCvXYFsbd5ktPcqPDvAo95UX4JW6sIh+rN4=;
        b=O4Dwck/4MrxNR0YNqJoGhaZZg1hE/wFj1Pvv/ysPD/ckDZT0NCqSw2dlLzam6ba+TCcLY+
        N6MMp9mP+5fRPaCg==
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
Message-ID: <160780197311.3364.14666601044973734196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     559db8c7e6ed1f24baf7264a6966ee4f051c6446
Gitweb:        https://git.kernel.org/tip/559db8c7e6ed1f24baf7264a6966ee4f051c6446
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Dec 2020 20:35:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 20:35:24 +01:00

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
