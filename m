Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC90F3F8C19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhHZQ0O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33202 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbhHZQ0J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:09 -0400
Date:   Thu, 26 Aug 2021 16:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFf1lgfEsz/W0h0fAvDpMNSZIUdFbLOsa0npIn0Lmbs=;
        b=mxTi12v+4I6s7pgry0hGXXKclgnkdSEy+MF9J8L7G+c2QGAomaQ5fpVk5kCO9oraEZbE7X
        HmHzccQY2SHWm5AtrwfR46QPTZIopeDrDJ9HYz/HLK5E3VkCV7PS5INnLWibI1HPoKVnMn
        JYq7Cny9hvPjl5UzQinnnqZF/a/Kt1ju+cWP3HM8EM7asbP4R0n61H5Xh72ueVKCI2zQFf
        eNZfZyaAMwn1wLehyqmA0XpxdH8KdvxV8SHuGfQVA4OKiJnlFBgbgG9ez9Y5ggWixvthuu
        y+7iXQKAqYq63B28oghxqSqC6TyXmgNowpFzD4zBCK2ZfGgSAHwECCQSrxQtsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFf1lgfEsz/W0h0fAvDpMNSZIUdFbLOsa0npIn0Lmbs=;
        b=veH0JNn7jHVN1s7iAsniXMmXBupah1VxJ2RI2fRcKTMc/qU5woMJ2yCqmvdBDUqzju6S5R
        hxOsfxkW8hiSNQAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.15' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c14ad27a-b1c6-6043-0f5e-71dd984bb4ba@linaro.org>
References: <c14ad27a-b1c6-6043-0f5e-71dd984bb4ba@linaro.org>
MIME-Version: 1.0
Message-ID: <162999512074.25758.15399163408785476185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     127c92feb74a6721f62587f1b89128808f049cf1
Gitweb:        https://git.kernel.org/tip/127c92feb74a6721f62587f1b89128808f049cf1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Aug 2021 18:20:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Aug 2021 18:20:50 +02:00

Merge tag 'timers-v5.15' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull timer driver updates from Daniel Lezcano:

 - Prioritize the ARM architected timer on Exynos platform when the
   architecture is ARM64 (Will Deacon)

 - Mark the Exynos timer as a per CPU timer (Will Deacon)

 - DT conversion to yaml for the rockchip platform (Ezequiel Garcia)

 - Fix IRQ setup if there are two channels on the sh_cmt timer (Phong
   Hoang)

 - Use bitfield helper macros in the Ingenic timer (Zhou Yanjie)

 - Clear any pending interrupt to prevent an abort of the suspend on
   the Mediatek platform (Fengquan Chen)

 - Add DT bindings for new Ingenic SoCs (Zhou Yanjie)

Link: https://lore.kernel.org/r/c14ad27a-b1c6-6043-0f5e-71dd984bb4ba@linaro.org
---
