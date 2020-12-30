Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD32E7708
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Dec 2020 09:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL3Icc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Dec 2020 03:32:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3Icc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Dec 2020 03:32:32 -0500
Date:   Wed, 30 Dec 2020 08:31:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609317109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkcS4Kn8DsWp728R/9ppRhr+Ekra8DGkRSsNPoaZhpw=;
        b=RS4XBR2OzI+W32x2rTRtxxn8bxyzNKGeBVwnQlELTAD7gH2LDsxRqZ4R07tsBY9WBXr3lU
        0RpqCdbIhqLL5t1i110B/s8vn/TalLJhJmd9iQm592hUXSZ/IqXe3mZaqLq3SMj1+lQ1Yw
        wC8ZAPu2EPbnEkdLs9SP8XIVowSq82gRjRDsqbMYFkIMs1KZ2C3KiTyRe7D/JOluVYw0zu
        YbfcYi0UhidVkSpKKXYFJZH1dEF2vo9Pn2S0ZzYqcjOZwSYdU7BjzgDby1Zg8sHx270OU1
        59ho8ZHOuxt5jwo3zoIweooKKjhTbox8IlKlbAnR11sk6yx8BDRjq6bvCwryBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609317109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkcS4Kn8DsWp728R/9ppRhr+Ekra8DGkRSsNPoaZhpw=;
        b=N1HPFQCUPtBbzE/s3jAwyHzWtvCC45+Wn0YjSoVoVJjIjgLTo5fNWYbX33Mqkrdm7WmGsV
        vk8lOORXwBZSoHCA==
From:   "tip-bot2 for Zheng Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/intel-mid: Convert comma to semicolon
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201216131107.14339-1-zhengyongjun3@huawei.com>
References: <20201216131107.14339-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <160931710867.414.3027150956562454767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bdb154f074a6d73d520b1fdee6b4143e2e311dfb
Gitweb:        https://git.kernel.org/tip/bdb154f074a6d73d520b1fdee6b4143e2e311dfb
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Wed, 16 Dec 2020 21:11:07 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Dec 2020 09:27:38 +01:00

x86/platform/intel-mid: Convert comma to semicolon

Replace a comma between expression statements with a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20201216131107.14339-1-zhengyongjun3@huawei.com
---
 arch/x86/platform/intel-mid/device_libs/platform_bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
index 31dda18..2930b6e 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -88,8 +88,8 @@ static int __init bt_sfi_init(void)
 	memset(&info, 0, sizeof(info));
 	info.fwnode	= ddata->dev->fwnode;
 	info.parent	= ddata->dev;
-	info.name	= ddata->name,
-	info.id		= PLATFORM_DEVID_NONE,
+	info.name	= ddata->name;
+	info.id		= PLATFORM_DEVID_NONE;
 
 	pdev = platform_device_register_full(&info);
 	if (IS_ERR(pdev))
