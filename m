Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6539F2CC774
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgLBUH7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 15:07:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgLBUH7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 15:07:59 -0500
Date:   Wed, 02 Dec 2020 20:07:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606939637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0bf1BObtlOiK1XGhzRvbwJpfCuy1RwtsxA4SYzDfWY=;
        b=170e1J5pPjvg9EZ6ZrjjO3lKHbn2Gz1icT9B/DfQJW5InqQ5c1eR9IYNWkojAud8jhUzLs
        PDo9+wBbnEc27mcsoulxHNcgINXxmb1xMlcOc43VV71MKNX+zFT57MeZBm5d2yOYgQjq57
        deJCPDt6Qf/Zn8pmPW2wA6NSCuUpU6ya5Uoa8+hl2x19cgt1ks+8MZTPcsnh05B8xC/GVE
        TwwKY9QpZ8zlXuTeIInW9wPQffbN8gef1v0AUNYQcLDZyHP3VptT8sbb6OHnlKjCLJFDIP
        tnMZAzM9ROWq/ZHkgn6xHp6SVVQUbmPkdpue+XjY5gbcOS7tKS8wqH09rBclcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606939637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0bf1BObtlOiK1XGhzRvbwJpfCuy1RwtsxA4SYzDfWY=;
        b=KDrUCllkvNDQczI5ktZEYVMo9z8IzdUpSKf14u7E7gJhYOtJYKSOOb6y5AZ4MHngn5rwkx
        Q/iCh/9PYmnzF1Dg==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Fix an error code in uv_hubs_init()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <jMAJb3H3iv@mwanda>
References: <jMAJb3H3iv@mwanda>
MIME-Version: 1.0
Message-ID: <160693963638.3364.15126718535201940817.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     fa4a379ecfa0c735e8979bb732fe5a1705a64052
Gitweb:        https://git.kernel.org/tip/fa4a379ecfa0c735e8979bb732fe5a1705a64052
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Wed, 02 Dec 2020 17:44:07 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Dec 2020 20:51:53 +01:00

x86/platform/uv: Fix an error code in uv_hubs_init()

Return -ENOMEM on allocation failure instead of returning random stack
memory contents.

Fixes: 4fc2cf1f2daf ("x86/platform/uv: Add new uv_sysfs platform driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
 
