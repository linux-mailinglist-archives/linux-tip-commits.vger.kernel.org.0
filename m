Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8222BB0F0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgKTQum (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 11:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgKTQul (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 11:50:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80065C0613CF;
        Fri, 20 Nov 2020 08:50:41 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:50:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605891039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+9g7ppAZ6gq8mGwFM65WXuEXeuVXze9ykXF/9uwAaE=;
        b=2aoYJbhsMKqnbfwJgjcRuUhdxj33pyAs0ULyyEoEhiPjVjowMtAm11ng91WdPE/D7doyau
        wxVsagJ0c5nej3VFN563rismCcTyagTj/SOmb3KR/ySqudXRdLdYwWpmwxtppv76nHNXwu
        7s8t4aBkRJ+vJYZ2nZBHKlgEzefaY2Lp6ThZwlo9ZkejF1gg8wJStNIz7mOfRyPhHix2jv
        SmKcsMAEj4EPeYluZEbNB8tpneIoVlWXvAETCaeRCMvQa5aDpaMiDllUFBxfwsInWXPYLs
        nlAqMs6YrazETG6TNgfWCZrt5LCoSzuAgK/PKce9t0oZzcZrU9HmKxr7I4/QpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605891039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+9g7ppAZ6gq8mGwFM65WXuEXeuVXze9ykXF/9uwAaE=;
        b=t0Vap+7Wk4IweaAX6SM/24EWV/8lu83m2o0JVqXWoBATE4z4ivv6mMFvm7db0dVKrz4mQO
        jxU5rueHOeoq5KCg==
From:   "tip-bot2 for Wang Qing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/head64: Remove duplicate include
Cc:     Wang Qing <wangqing@vivo.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1604893542-20961-1-git-send-email-wangqing@vivo.com>
References: <1604893542-20961-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Message-ID: <160589103814.11244.14763975533616682453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     61b39ad9a7d26fe14a2f5f23e5e940e7f9664d41
Gitweb:        https://git.kernel.org/tip/61b39ad9a7d26fe14a2f5f23e5e940e7f9664d41
Author:        Wang Qing <wangqing@vivo.com>
AuthorDate:    Mon, 09 Nov 2020 11:45:41 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 Nov 2020 17:43:15 +01:00

x86/head64: Remove duplicate include

Remove duplicate header include.

Signed-off-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1604893542-20961-1-git-send-email-wangqing@vivo.com
---
 arch/x86/kernel/head64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05e1171..5e9beb7 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -37,7 +37,6 @@
 #include <asm/kasan.h>
 #include <asm/fixmap.h>
 #include <asm/realmode.h>
-#include <asm/desc.h>
 #include <asm/extable.h>
 #include <asm/trapnr.h>
 #include <asm/sev-es.h>
