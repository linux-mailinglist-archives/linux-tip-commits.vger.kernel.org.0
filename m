Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B192F6298
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 15:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhANOAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbhANOAV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 09:00:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9DC061574;
        Thu, 14 Jan 2021 05:59:40 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610632779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogUHp5aiq/8iZeUtNqms1TJD2XrHTDH5G7wD1ffdJjc=;
        b=HKf+URE829XVMa9gd06K9BOTKBNKGoWhhmtJ5G8gu4WYDAao9pqHTs7CygEpsBo8q5e34X
        5BPRb8HGIllKDV0xhIITRqQaISsOhA5hfvUgFIAawVrNye+SKkrUXR4dORP7Lv7O8Az1ZY
        dLjh0h8D87IIR4LhiayyWY83DuG/6CEIPqrANwBR8pZVMZS/Sq6X/OubEdEhgAtz/BtLDh
        jGoR2jxwHFxlGFAgekYjj+waRAEWGIqW7PtQAON4VjSnj++F2JvorSf4KFTQE0ZmwrrHuA
        wbOagLxSpEuj4szjWxenO6A+2gwRdhwGVW8HIlbu7tSp7x0zzUvoJcrfeDvdHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610632779;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogUHp5aiq/8iZeUtNqms1TJD2XrHTDH5G7wD1ffdJjc=;
        b=d7dMMz91CbpGO8cdu2e9zrzwlioyDCWQm7dpEDsmqwhrKgcchXuaXH/FGLgLtvlpAgZCct
        feBEXn7IA6i6R5Aw==
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix the return type of sgx_init()
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@suse.de>,
        Darren Kenny <darren.kenny@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210113232311.277302-1-samitolvanen@google.com>
References: <20210113232311.277302-1-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <161063277811.414.15752543711619531745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     745b56b065618aaee7c2ab4ca3c85e2cdbebc1d6
Gitweb:        https://git.kernel.org/tip/745b56b065618aaee7c2ab4ca3c85e2cdbebc1d6
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Wed, 13 Jan 2021 15:23:11 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jan 2021 14:50:54 +01:00

x86/sgx: Fix the return type of sgx_init()

device_initcall() expects a function of type initcall_t, which returns
an integer. Change the signature of sgx_init() to match.

Fixes: e7e0545299d8c ("x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Link: https://lkml.kernel.org/r/20210113232311.277302-1-samitolvanen@google.com
---
 arch/x86/kernel/cpu/sgx/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c519fc5..8df81a3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -700,25 +700,27 @@ static bool __init sgx_page_cache_init(void)
 	return true;
 }
 
-static void __init sgx_init(void)
+static int __init sgx_init(void)
 {
 	int ret;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SGX))
-		return;
+		return -ENODEV;
 
 	if (!sgx_page_cache_init())
-		return;
+		return -ENOMEM;
 
-	if (!sgx_page_reclaimer_init())
+	if (!sgx_page_reclaimer_init()) {
+		ret = -ENOMEM;
 		goto err_page_cache;
+	}
 
 	ret = sgx_drv_init();
 	if (ret)
 		goto err_kthread;
 
-	return;
+	return 0;
 
 err_kthread:
 	kthread_stop(ksgxd_tsk);
@@ -728,6 +730,8 @@ err_page_cache:
 		vfree(sgx_epc_sections[i].pages);
 		memunmap(sgx_epc_sections[i].virt_addr);
 	}
+
+	return ret;
 }
 
 device_initcall(sgx_init);
