Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A416128A8F6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgJKSAH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgJKR5b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:31 -0400
Date:   Sun, 11 Oct 2020 17:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fg9+JhaJHpc8C6uClQJYh3IgB8dBPVgMTsuOLr9IP4=;
        b=bCVZg82JukD8Xk2lxijZdrL+VyTRcJvObbHpv7SqfkSoOGB3vAyMwQi0p7zGWdXNmgquzC
        KgV2/HEMHrNRPg3uycFU7+b5bhAauB1uVMbhLalSbAvPvs6/N98sy5Cr8zcaTRjm6jVR8l
        EQ7K9E9uZcr7wLZ0fKvqNrUpRvqbUwQ2A2pNLvcirxWO/IniQuS8rRxSp8+KU7OQnIw7Im
        +m8iCw12vweOq+Z39Ia7cQUzGG+Lw4lrzCkF7j3LpqXLOYhTev23iAEOrPB6nMbeBUFG3+
        i7ikRLbIM52MCZNxWs+gtijFJQogHVZk386GbwtKjob9NnaEP4kC7FXozNEqEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fg9+JhaJHpc8C6uClQJYh3IgB8dBPVgMTsuOLr9IP4=;
        b=c4C538zqm0hMQdLm41UQfRu2nBZG6hFRX2WKh9lmUEj4nLUunctXnwrhXJYq1dJi7IphQs
        xstVygAzHf8IOrDQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: Fix -Wunused-function warning when !CONFIG_HOTPLUG_CPU
Cc:     YueHaibing <yuehaibing@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200918123318.23764-1-yuehaibing@huawei.com>
References: <20200918123318.23764-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160243904896.7002.4752846439055319246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9d9edb962e910552c9c008800ec907293a47852e
Gitweb:        https://git.kernel.org/tip/9d9edb962e910552c9c008800ec907293a4=
7852e
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Fri, 18 Sep 2020 20:33:18 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 18 Sep 2020 16:59:20 +01:00

arm64: Fix -Wunused-function warning when !CONFIG_HOTPLUG_CPU

If CONFIG_HOTPLUG_CPU is n, gcc warns:

arch/arm64/kernel/smp.c:967:13: warning: =E2=80=98ipi_teardown=E2=80=99 defin=
ed but not used [-Wunused-function]
 static void ipi_teardown(int cpu)
             ^~~~~~~~~~~~

Use #ifdef guard this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200918123318.23764-1-yuehaibing@huawei.com
---
 arch/arm64/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde26..82e75fc 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -82,9 +82,9 @@ static int nr_ipi __read_mostly =3D NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
=20
 static void ipi_setup(int cpu);
-static void ipi_teardown(int cpu);
=20
 #ifdef CONFIG_HOTPLUG_CPU
+static void ipi_teardown(int cpu);
 static int op_cpu_kill(unsigned int cpu);
 #else
 static inline int op_cpu_kill(unsigned int cpu)
@@ -964,6 +964,7 @@ static void ipi_setup(int cpu)
 		enable_percpu_irq(ipi_irq_base + i, 0);
 }
=20
+#ifdef CONFIG_HOTPLUG_CPU
 static void ipi_teardown(int cpu)
 {
 	int i;
@@ -974,6 +975,7 @@ static void ipi_teardown(int cpu)
 	for (i =3D 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
 }
+#endif
=20
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
