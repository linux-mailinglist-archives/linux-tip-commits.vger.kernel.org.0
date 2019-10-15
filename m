Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3727DD775B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfJONWA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 09:22:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfJONV7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 09:21:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKMls-0000Un-DJ; Tue, 15 Oct 2019 15:21:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F061E1C0105;
        Tue, 15 Oct 2019 15:21:51 +0200 (CEST)
Date:   Tue, 15 Oct 2019 13:21:51 -0000
From:   "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/hyperv: Set pv_info.name to "Hyper-V"
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191015103502.13156-1-parri.andrea@gmail.com>
References: <20191015103502.13156-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Message-ID: <157114571175.29376.11945481236719792102.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     628270ef628af6712ee99771b583feb667a7f1bc
Gitweb:        https://git.kernel.org/tip/628270ef628af6712ee99771b583feb667a7f1bc
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Tue, 15 Oct 2019 12:35:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2019 15:18:17 +02:00

x86/hyperv: Set pv_info.name to "Hyper-V"

Michael reported that the x86/hyperv initialization code prints the
following dmesg when running in a VM on Hyper-V:

  [    0.000738] Booting paravirtualized kernel on bare hardware

Let the x86/hyperv initialization code set pv_info.name to "Hyper-V" so
dmesg reports correctly:

  [    0.000172] Booting paravirtualized kernel on Hyper-V

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20191015103502.13156-1-parri.andrea@gmail.com

---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 267daad..e7f0776 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -216,6 +216,8 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
 
+	pv_info.name = "Hyper-V";
+
 	/*
 	 * Extract the features and hints
 	 */
