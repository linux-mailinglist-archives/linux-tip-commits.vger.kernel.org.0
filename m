Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC04E2CD0B8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgLCICl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgLCICl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 03:02:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FEC061A4F;
        Thu,  3 Dec 2020 00:02:01 -0800 (PST)
Date:   Thu, 03 Dec 2020 08:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606982518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6BgxEmxKkozwk8mZoVi8ciZYSw10ivYCIXxs+1D0s8=;
        b=La43T1XMg7IIadZsN+ZiFhU46coAkeBXzBw1XkjApNHaMH+WZ9MNRc1i4VRxtPb/X2dyBg
        eIjzb1UNhDcVENUnKq0pTqrUvDrUw5NrQBLqdnhvmX1LppQjBMsRvWtsME1fWpKiQElfKW
        Q3w5fvhQgHuy68YU3/fCQC+ej6+/iWQJRRgoaXPyWr4mknB4hAat8KjMCAbqJ+KHCDgpcu
        qnrvm8BWvS9XbC3ucpwdvE+9+PP9RTNcFNqxck4pXqJyG23fLp/lflTHlQGN3vuOw46MqL
        uc3WdvgfngfUi3nqY/nPYf3MMwVmjEHQQU45Nqcm+3GcDyTvFdbXSM+wmz1H9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606982518;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6BgxEmxKkozwk8mZoVi8ciZYSw10ivYCIXxs+1D0s8=;
        b=fHVlzY0NH3miIdrzZfeZcEka4Uvx2cfi+7Q2/SueEViwHrFjCps+yTOJEIXe8DVEEero55
        nwt0R8Px+EvzuVBQ==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Fix an error code in uv_hubs_init()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <jMAJb3H3iv@mwanda>
References: <jMAJb3H3iv@mwanda>
MIME-Version: 1.0
Message-ID: <160698251832.3364.1308727905551541129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     18d047bd89b8c1f9ba3c9b2d2f7309c953b3ce97
Gitweb:        https://git.kernel.org/tip/18d047bd89b8c1f9ba3c9b2d2f7309c953b3ce97
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Wed, 02 Dec 2020 17:44:07 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Dec 2020 08:51:06 +01:00

x86/platform/uv: Fix an error code in uv_hubs_init()

Return -ENOMEM on allocation failure instead of returning random stack
memory contents.

Fixes: 4fc2cf1f2daf ("x86/platform/uv: Add new uv_sysfs platform driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Justin Ernst <justin.ernst@hpe.com>
Link: https://lkml.kernel.org/r/X8eoN/jMAJb3H3iv@mwanda
---
 drivers/platform/x86/uv_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 54c3425..e17ce8c 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -248,6 +248,7 @@ static int uv_hubs_init(void)
 		uv_hubs[i] = kzalloc(sizeof(*uv_hubs[i]), GFP_KERNEL);
 		if (!uv_hubs[i]) {
 			i--;
+			ret = -ENOMEM;
 			goto err_hubs;
 		}
 
