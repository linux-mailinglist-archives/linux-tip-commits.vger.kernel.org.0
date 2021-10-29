Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39243FA76
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJ2KKJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhJ2KKI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 06:10:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC9C061714;
        Fri, 29 Oct 2021 03:07:40 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635502058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiD/6piFdeaLjv0yk5mGnbN6jQp8m6Qq4MOUx8wr5Lo=;
        b=1ufIVKzCi8Ufj0Sxr4ngpK9lvbSbMUQAXaFg+lqaBvkDbnud200xf/oYgQbvd8RsqQW71R
        u/QBn1eZJlKKVExtYiN+D0ZaQueZYEi5c4BiWEypLhxdTORAjKfF6HD3cuxrRbjU7CF5+G
        GuZX9ND6j2+xbUAX6GZD5yJRNUUZcLmzk8DZccrxlPjNv61a5MbWIqqkyQdC850R1aSwKD
        6+V7QyNusPkj9twmGzOkAc9K7JxB5FTzMyaPi0Xn+q9NijNKPEyGDMdUNMRSvhIen3qYV+
        HG5oxxhN+DXhCTsPw7bNXXTupdgTa3N/BeoayYdqlMtFu39g4osdU6sqjuRG0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635502058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiD/6piFdeaLjv0yk5mGnbN6jQp8m6Qq4MOUx8wr5Lo=;
        b=ftnaSiEorxea0jsrO/B8khLKa88RzWznG6bcb2mUGV/6odax7MWc3bcF1BC21zYU3Vuvxh
        SntWuyF6pesL5rBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-5.16' into irq/core
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20211029083332.3680101-1-maz@kernel.org>
References: <20211029083332.3680101-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163550205770.626.12733408561607603295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2258a6fc33d56227a981a45069fc651d85a0076f
Gitweb:        https://git.kernel.org/tip/2258a6fc33d56227a981a45069fc651d85a0076f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 29 Oct 2021 11:58:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 29 Oct 2021 11:58:35 +02:00

Merge tag 'irqchip-5.16' into irq/core

Merge irqchip updates for Linux 5.16 from Marc Zyngier:

- A large cross-arch rework to move irq_enter()/irq_exit() into
  the arch code, and removing it from the generic irq code.
  Thanks to Mark Rutland for the huge effort!

- A few irqchip drivers are made modular (broadcom, meson), because
  that's apparently a thing...

- A new driver for the Microchip External Interrupt Controller

- The irq_cpu_offline()/irq_cpu_online() API is now deprecated and
  can only be selected on the Cavium Octeon platform. Once this
  platform is removed, the API will be removed at the same time.

- A sprinkle of devm_* helper, as people seem to love that.

- The usual spattering of small fixes and minor improvements.

* tag 'irqchip-5.16': (912 commits)
  h8300: Fix linux/irqchip.h include mess
  dt-bindings: irqchip: renesas-irqc: Document r8a774e1 bindings
  MIPS: irq: Avoid an unused-variable error
  genirq: Hide irq_cpu_{on,off}line() behind a deprecated option
  irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()
  MIPS: loongson64: Drop call to irq_cpu_offline()
  irq: remove handle_domain_{irq,nmi}()
  irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
  irq: riscv: perform irqentry in entry code
  irq: openrisc: perform irqentry in entry code
  irq: csky: perform irqentry in entry code
  irq: arm64: perform irqentry in entry code
  irq: arm: perform irqentry in entry code
  irq: add a (temporary) CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
  irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
  irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ
  irq: add generic_handle_arch_irq()
  irq: unexport handle_irq_desc()
  irq: simplify handle_domain_{irq,nmi}()
  irq: mips: simplify do_domain_IRQ()
  ...

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211029083332.3680101-1-maz@kernel.org
---
