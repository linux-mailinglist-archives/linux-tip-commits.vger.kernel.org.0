Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5EC44F7F9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Nov 2021 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhKNNGv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 14 Nov 2021 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNNGt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 14 Nov 2021 08:06:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C91C061746;
        Sun, 14 Nov 2021 05:03:53 -0800 (PST)
Date:   Sun, 14 Nov 2021 13:03:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636895030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9uUm9BPe4ECGRm4+Hlp3ugKcj9V2VsAPrRzO8b0TAA=;
        b=078tqxjsgit7mw4Omh/Iaq3nWc2hKuBc376oLoENjPn4W2mmbuDk6CTmf85HENYeI4go6S
        YlisNh3vRETXMgOJGH0HF0Ql1Aa2L5HWC5KBb4SYVrkf0j8nKMhmEg0rXtKbmzZ44kmuKM
        YeAaV9ZcepsybHPWVQqZab5aaIj1mxGgeUXmHhEhvj6rUwfvRPznwNGpB+bfgClIlbJhyB
        NCpcAsV6XK9aw+c5c+k96Zpdma1VJb7Il/wHA9FxBL+J4rwKyIeQiPsMVP2e+C01Jljn0C
        /kfTl4qqPpV0YbhzXY3JNnvLRVZkBn6vGmV/GyQjcb/JlfoTvaJFK3x2EJ6pZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636895030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9uUm9BPe4ECGRm4+Hlp3ugKcj9V2VsAPrRzO8b0TAA=;
        b=osrmlRAlVY+D89upBiAXxBUKKQmHzg1cqCnVtv48/1FmMhg+//ep7fm0L51fs04IUJs6ox
        uAJFlO4vIwuL68Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.16-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20211112173459.4015233-1-maz@kernel.org>
References: <20211112173459.4015233-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163689502969.414.13062032877252854469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     979292af5b512c27803316de2cd06970c54251e5
Gitweb:        https://git.kernel.org/tip/979292af5b512c27803316de2cd06970c54251e5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 14 Nov 2021 13:59:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 14 Nov 2021 13:59:05 +01:00

Merge tag 'irqchip-fixes-5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - Address an issue with the SiFive PLIC being unable to EOI
    a masked interrupt

  - Move the disable/enable methods in the CSky mpintc to
    mask/unmask

  - Fix a regression in the OF irq code where an interrupt-controller
    property in the same node as an interrupt-map property would get
    ignored

Link: https://lore.kernel.org/all/20211112173459.4015233-1-maz@kernel.org
---
