Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED9135A7C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgAINrk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Jan 2020 08:47:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbgAINrk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Jan 2020 08:47:40 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipY9w-00033a-5t; Thu, 09 Jan 2020 14:47:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 552461C2CE2;
        Thu,  9 Jan 2020 14:47:35 +0100 (CET)
Date:   Thu, 09 Jan 2020 13:47:34 -0000
From:   "tip-bot2 for Julia Lawall" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/crash: Use resource_size()
Cc:     Julia Lawall <Julia.Lawall@inria.fr>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1577900990-8588-10-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-10-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Message-ID: <157857765487.30329.12185541615823835729.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1429b568ad71943a374aa4a8d3772d5a8816ddba
Gitweb:        https://git.kernel.org/tip/1429b568ad71943a374aa4a8d3772d5a8816ddba
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Wed, 01 Jan 2020 18:49:49 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 09 Jan 2020 14:40:03 +01:00

x86/crash: Use resource_size()

Use resource_size() rather than a verbose computation on
the end and start fields.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1577900990-8588-10-git-send-email-Julia.Lawall@inria.fr
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 00fc55a..fd87b59 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -370,7 +370,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
-		ei.size = crashk_low_res.end - crashk_low_res.start + 1;
+		ei.size = resource_size(&crashk_low_res);
 		ei.type = E820_TYPE_RAM;
 		add_e820_entry(params, &ei);
 	}
