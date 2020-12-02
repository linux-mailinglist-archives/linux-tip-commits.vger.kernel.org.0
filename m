Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E32CBC8D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 13:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgLBMMh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 07:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgLBMMh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 07:12:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A0C0613CF;
        Wed,  2 Dec 2020 04:11:57 -0800 (PST)
Date:   Wed, 02 Dec 2020 12:11:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606911114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KG8wQsly4u9F6yV+AsFpIO8VtDCWXKG4ZqoLK+MgegY=;
        b=MiCZQM4gvgm/xEx+6v9BylIHZtzIqUTR2TwZhFJmDZDnUYDu0gmLNXd0kGeqVlFiunnT4y
        vqqT5BczqqUxeC62ZfjvRBjAKQgBjVIQ2cwQRSq1d+AWKGCU8+kgp7XAM/7BIgEBv9NYRs
        iIFpTKGfnhaZMn0bif4SvnU8OYWHMgVWepIWH2VooORm0RAz+dMa2yByvUkxIStkvdTzv8
        r5tvoNmlzOgZ0ZCMLe1YLl5xcHvxSX6LlmQpTTh5U/AFRG6FWbL4Tgy7yp2kWg46foydWf
        wh1TsfEgTsQROSP7yh34UAZcA6P4Vz2UJM/DT2qSdZ/D3zEiQvYXjhvVaMcvkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606911114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KG8wQsly4u9F6yV+AsFpIO8VtDCWXKG4ZqoLK+MgegY=;
        b=oJ6aiVfFWousKKB3U4Ab5hBZJp1A8qT/lxyHUk7eQXWGpqJKORGONbhQymuyaF7TG7bJRc
        Fs2Rwp5Ge0ul6EBA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix a typo in kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cca11a4540d981cbd5f026b6cbc8931aa55654e00=2E16068?=
 =?utf-8?q?97462=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3Cca11a4540d981cbd5f026b6cbc8931aa55654e00=2E160689?=
 =?utf-8?q?7462=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160691111323.3364.16384786016052912723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     bab8c183d1d452f5fdc059aef2f0788bd2986231
Gitweb:        https://git.kernel.org/tip/bab8c183d1d452f5fdc059aef2f0788bd2986231
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 09:27:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Dec 2020 12:54:47 +01:00

x86/sgx: Fix a typo in kernel-doc markup

Fix the following kernel-doc warning:

  arch/x86/include/uapi/asm/sgx.h:19: warning: expecting prototype \
    for enum sgx_epage_flags. Prototype was for enum sgx_page_flags instead

 [ bp: Launder the commit message. ]

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/ca11a4540d981cbd5f026b6cbc8931aa55654e00.1606897462.git.mchehab+huawei@kernel.org
---
 arch/x86/include/uapi/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 791e453..9034f30 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -9,7 +9,7 @@
 #include <linux/ioctl.h>
 
 /**
- * enum sgx_epage_flags - page control flags
+ * enum sgx_page_flags - page control flags
  * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
  *			ENCLS[EEXTEND] operations.
  */
