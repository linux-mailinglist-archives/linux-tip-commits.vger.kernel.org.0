Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3D2CAA7F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbgLASGl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 13:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLASGh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 13:06:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DBC0613CF;
        Tue,  1 Dec 2020 10:05:56 -0800 (PST)
Date:   Tue, 01 Dec 2020 18:05:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606845954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4lTlrkm8ctcas/2C3X/NZASVBAixZTUMF83HJxl+pw=;
        b=3QdQ0KnconRr91JSPcQH8v4db7ce3A0IpmG2fx9IIn/g0UGmxq5681TO1uu02cxzLcMqwy
        vzX9pa7RV5+n+uU/sO4ZIBV5q/0Nl9EyMO6+eGDwQOlrXFk+xIk5yFqs5GrfI75EYnZJNN
        Al5d/KW+qaulZ9NTk2DQROYOs4qknfRSfDb+g82twtzxIuRdtV7fhj+TbGlcfDzVn53Jwd
        9fiMLhkZDec/ChHr5oDXj7sqgnTwVVGhLAYUWQSD7P1rX84FraLzA+h0x+1VlPBCeKz6a1
        PBYa5keHuzqES3B7C4HXfF9Q7VUffCLpHNz15QQAMDOXWw9P0xy6ktz7AgrVWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606845954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4lTlrkm8ctcas/2C3X/NZASVBAixZTUMF83HJxl+pw=;
        b=zq5flsItCjSN0jBnMhmmJp0yRG5jJOVbhM+uU+NoJIM1kEJQYIzPoAWeGkM8ZZSDqSvX5Y
        3Q3k+DHlqTqUvYBQ==
From:   "tip-bot2 for Gabriele Paoloni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Panic for LMCE only if mca_cfg.tolerant < 3
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201127161819.3106432-4-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-4-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Message-ID: <160684595431.3364.7177958752136781622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3a866b16fd2360a9c4ebf71cfbf7ebfe968c1409
Gitweb:        https://git.kernel.org/tip/3a866b16fd2360a9c4ebf71cfbf7ebfe968c1409
Author:        Gabriele Paoloni <gabriele.paoloni@intel.com>
AuthorDate:    Fri, 27 Nov 2020 16:18:17 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 18:49:29 +01:00

x86/mce: Panic for LMCE only if mca_cfg.tolerant < 3

Right now for LMCE, if no_way_out is set, mce_panic() is called
regardless of mca_cfg.tolerant. This is not correct as, if
mca_cfg.tolerant = 3, the code should never panic.

Add that check.

 [ bp: use local ptr 'cfg'. ]

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20201127161819.3106432-4-gabriele.paoloni@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ebaa52a..99da2e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1368,7 +1368,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * to see it will clear it.
 	 */
 	if (lmce) {
-		if (no_way_out)
+		if (no_way_out && cfg->tolerant < 3)
 			mce_panic("Fatal local machine check", &m, msg);
 	} else {
 		order = mce_start(&no_way_out);
