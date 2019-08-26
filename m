Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02469D359
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2019 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfHZPuu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Aug 2019 11:50:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPuu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Aug 2019 11:50:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2HGY-0008Gf-0q; Mon, 26 Aug 2019 17:50:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9E6721C0DDA;
        Mon, 26 Aug 2019 17:50:45 +0200 (CEST)
Date:   Mon, 26 Aug 2019 15:50:45 -0000
From:   tip-bot2 for Bandan Das <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Include the LDR when clearing out APIC registers
Cc:     Bandan Das <bsd@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <r20190826101513.5080-3-bsd@redhat.com>
References: <r20190826101513.5080-3-bsd@redhat.com>
MIME-Version: 1.0
Message-ID: <156683464551.2626.4210379148616708417.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cfa16294b1c5b320c0a0e1cac37c784b92366c87
Gitweb:        https://git.kernel.org/tip/cfa16294b1c5b320c0a0e1cac37c784b92366c87
Author:        Bandan Das <bsd@redhat.com>
AuthorDate:    Mon, 26 Aug 2019 06:15:13 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Aug 2019 17:47:24 +02:00

x86/apic: Include the LDR when clearing out APIC registers

Although APIC initialization will typically clear out the LDR before
setting it, the APIC cleanup code should reset the LDR.

This was discovered with a 32-bit KVM guest jumping into a kdump
kernel. The stale bits in the LDR triggered a bug in the KVM APIC
implementation which caused the destination mapping for VCPUs to be
corrupted.

Note that this isn't intended to paper over the KVM APIC bug. The kernel
has to clear the LDR when resetting the APIC registers except when X2APIC
is enabled.

This lacks a Fixes tag because missing to clear LDR goes way back into pre
git history.

Signed-off-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r20190826101513.5080-3-bsd@redhat.com
---
 arch/x86/kernel/apic/apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa5495d..e75f378 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1179,6 +1179,10 @@ void clear_local_APIC(void)
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
+	if (!x2apic_enabled) {
+		v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+		apic_write(APIC_LDR, v);
+	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);
