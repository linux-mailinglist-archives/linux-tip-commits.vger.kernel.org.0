Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681091927CA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Mar 2020 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCYMGQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Mar 2020 08:06:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbgCYMGP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nL-0000jJ-05; Wed, 25 Mar 2020 13:06:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 947DC1C0470;
        Wed, 25 Mar 2020 13:06:02 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:02 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] parisc: Replace cpu_up/down() with add/remove_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-13-qais.yousef@arm.com>
References: <20200323135110.30522-13-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796223.28353.763403470362233835.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     02addaeaa7e5fa238963972d7030fa7ad57d9f1a
Gitweb:        https://git.kernel.org/tip/02addaeaa7e5fa238963972d7030fa7ad57d9f1a
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:05 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:36 +01:00

parisc: Replace cpu_up/down() with add/remove_cpu()

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down().

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down() a private interface of the CPU
subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://lkml.kernel.org/r/20200323135110.30522-13-qais.yousef@arm.com

---
 arch/parisc/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 13f771f..7f2d0c0 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -212,7 +212,7 @@ static int __init processor_probe(struct parisc_device *dev)
 #ifdef CONFIG_SMP
 	if (cpuid) {
 		set_cpu_present(cpuid, true);
-		cpu_up(cpuid);
+		add_cpu(cpuid);
 	}
 #endif
 
