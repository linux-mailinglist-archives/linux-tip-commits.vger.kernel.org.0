Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BB330C9A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCHLlQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 06:41:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHLlC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 06:41:02 -0500
Date:   Mon, 08 Mar 2021 11:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615203661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nwDCLHhhwHRnil5SA8c4cMC244WlNuluCG1JbTYoiM=;
        b=REydwh/rVh1lyHcanAd2ReZm9MuGmBepREAyDYm9I4FxF/2tvZ/uZoVrziF5aQ6xb4fWJM
        sdryUrLpQKT/7irxXJ6U1I3AH1HvZaW8mgDJCNzewZVTi0lS2xeKfTghrlMvY12LjIRCB7
        CnvEq/oeLD7HtbAaD+gYeHbHSLwSG70zwibgqXRp6Os9bokxVxzFuviOmC6PtbOS7lnN4l
        Ghc9SUppKfvHvKS/AndDTtUSrDk/B5AlEqGxwNUgbhphQXxCwwsCs1Z8fffthREGjJ7dCN
        cFffZJYCnK7XVqTZKfKisgUB1cR/0Q3bzZRwxZZkDFZmAWwnSLI5Ie8vKkLaVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615203661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nwDCLHhhwHRnil5SA8c4cMC244WlNuluCG1JbTYoiM=;
        b=y1ITC2/0h6klA7WBXfSyPV5blLeJi1cqhL0KLPL3dmhuf9w/TQDGY6DPBlkWQJF8lb9mch
        MKIERXjmGvRlRyDw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Set section block size for
 hubless architectures
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210305162853.299892-1-mike.travis@hpe.com>
References: <20210305162853.299892-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <161520366063.398.17015803098326869178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     6840a150b9daf35e4d21ab9780d0a03b4ed74a5b
Gitweb:        https://git.kernel.org/tip/6840a150b9daf35e4d21ab9780d0a03b4ed74a5b
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Fri, 05 Mar 2021 10:28:53 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 12:17:53 +01:00

x86/platform/uv: Set section block size for hubless architectures

Commit

  bbbd2b51a2aa ("x86/platform/UV: Use new set memory block size function")

added a call to set the block size value that is needed by the kernel
to set the boundaries in the section list. This was done for UV Hubbed
systems but missed in the UV Hubless setup. Fix that mistake by adding
that same set call for hubless systems, which support the same NVRAMs
and Intel BIOS, thus the same problem occurs.

 [ bp: Massage commit message. ]

Fixes: bbbd2b51a2aa ("x86/platform/UV: Use new set memory block size function")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20210305162853.299892-1-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 52bc217..c9ddd23 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1671,6 +1671,9 @@ static __init int uv_system_init_hubless(void)
 	if (rc < 0)
 		return rc;
 
+	/* Set section block size for current node memory */
+	set_block_size();
+
 	/* Create user access node */
 	if (rc >= 0)
 		uv_setup_proc_files(1);
