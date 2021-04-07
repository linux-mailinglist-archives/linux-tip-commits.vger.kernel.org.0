Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08BB3568C8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350618AbhDGKEY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350516AbhDGKDn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:43 -0400
Date:   Wed, 07 Apr 2021 10:03:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8zs9F+Uvfh643CkArrL2kRjedrEap8jFGvwGzRwIKs=;
        b=isGwk0n49f/sY1eS5J5G0RzPkvqPpKWT81ZAEHaZwiIP5Wsu6mjogc7xp64jFUdsvfKDR6
        vO1ZTS0goqKkOH22YOJzfcoHitHqRKRH25npE+kkp7vi2eDgzojYwy2SwvKLWzm4wdg2Lq
        0tnJTY4CHJszth1MwqM/6DWlxL9e3hSSN4q6KnTmU3+GH68eVffU35izhXJYF3k9ANVVUJ
        yJsx5q3izcR4GINj5V4IoOobb3UFKNsdMd3XCZ9HIMsDvi+c0aOazDV9hyOv7yRsrTE73S
        cqEwbIwdDqKqyozoCUYl0w83Ue58FB4VCSJjQnVOZKB/jU8i7PKlppYhqFNJpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8zs9F+Uvfh643CkArrL2kRjedrEap8jFGvwGzRwIKs=;
        b=wgWmc0ZjfmbEzfS8Ihk4mymDIdkJF2iJ38vlEholW9SLxNyESGXKcV4nCtnfjCv6fO/2oi
        61w2k8mQuZAcPLBg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Initialize virtual EPC driver even when SGX
 driver is disabled
Cc:     Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d35d17a02bbf8feef83a536cec8b43746d4ea557.1616136308.git.kai.huang@intel.com>
References: <d35d17a02bbf8feef83a536cec8b43746d4ea557.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981256.29796.1413620154236553864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     faa7d3e6f3b983a28bf0f88f82dcb1c162e61105
Gitweb:        https://git.kernel.org/tip/faa7d3e6f3b983a28bf0f88f82dcb1c162e61105
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:02 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:41 +02:00

x86/sgx: Initialize virtual EPC driver even when SGX driver is disabled

Modify sgx_init() to always try to initialize the virtual EPC driver,
even if the SGX driver is disabled.  The SGX driver might be disabled
if SGX Launch Control is in locked mode, or not supported in the
hardware at all.  This allows (non-Linux) guests that support non-LC
configurations to use SGX.

 [ bp: De-silli-fy the test. ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/d35d17a02bbf8feef83a536cec8b43746d4ea557.1616136308.git.kai.huang@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b227629..1c8a228 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -743,8 +743,17 @@ static int __init sgx_init(void)
 		goto err_page_cache;
 	}
 
+	/*
+	 * Always try to initialize the native *and* KVM drivers.
+	 * The KVM driver is less picky than the native one and
+	 * can function if the native one is not supported on the
+	 * current system or fails to initialize.
+	 *
+	 * Error out only if both fail to initialize.
+	 */
 	ret = sgx_drv_init();
-	if (ret)
+
+	if (sgx_vepc_init() && ret)
 		goto err_kthread;
 
 	return 0;
