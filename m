Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2535888F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Apr 2021 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhDHPdt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Apr 2021 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHPds (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Apr 2021 11:33:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B6C061760;
        Thu,  8 Apr 2021 08:33:37 -0700 (PDT)
Date:   Thu, 08 Apr 2021 15:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617896010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EBDtl2GG8j+KGRCdxwbbVvVVzdvXaqVRFU2f6OBLdw=;
        b=OREsbSlLBQjHK65zBkglocu5I84w+LMKlmqflcrrlcs+k/eYJ0EXV9rHfalbupfafPEhDm
        OAWN74ZD1dP4QFCif0FRkvi4QIhgqKuRW0R2lorLDNhRto8vczG7sTlr9NKoPuOSKUeKeJ
        Et6DrjHDrd0kPcM1t8cwbaFsZRvUCckYgfLvSqV+tsaUCkVwQCsryGMHY6ek7gGgGzv9s6
        hgWhXZeWEF4cNv3TH17iPgvFi+vHSieHlLbMMoXVCUxqr1k9gUKiaoT/i+Yrjrwx9o9gfU
        owan0t+bhItCfpXvTnUOazBPpJ/W0zq9k6lCPEX/Cr+IjtnFZ0cxlXXPSyM57w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617896010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EBDtl2GG8j+KGRCdxwbbVvVVzdvXaqVRFU2f6OBLdw=;
        b=DUyNzga1O5v1+1P11xZ+5wxTMGjc8bhSc3ZxgoPT6mVNrRuhglSIxdP6UNTgO1jM68RqWH
        NcDC6hC9XMg+hQDw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Do not update sgx_nr_free_pages in
 sgx_setup_epc_section()
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210408092924.7032-1-jarkko@kernel.org>
References: <20210408092924.7032-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <161789600921.29796.11515347973623709051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     ae40aaf6bdbf0354a75b8284a0de453fcf5f4d32
Gitweb:        https://git.kernel.org/tip/ae40aaf6bdbf0354a75b8284a0de453fcf5f4d32
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Thu, 08 Apr 2021 12:29:24 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 08 Apr 2021 17:24:42 +02:00

x86/sgx: Do not update sgx_nr_free_pages in sgx_setup_epc_section()

The commit in Fixes: changed the SGX EPC page sanitization to end up in
sgx_free_epc_page() which puts clean and sanitized pages on the free
list.

This was done for the reason that it is best to keep the logic to assign
available-for-use EPC pages to the correct NUMA lists in a single
location.

sgx_nr_free_pages is also incremented by sgx_free_epc_pages() but those
pages which are being added there per EPC section do not belong to the
free list yet because they haven't been sanitized yet - they land on the
dirty list first and the sanitization happens later when ksgxd starts
massaging them.

So remove that addition there and have sgx_free_epc_page() do that
solely.

 [ bp: Sanitize commit message too. ]

Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210408092924.7032-1-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 92cb11d..ad90474 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -656,7 +656,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
-	sgx_nr_free_pages += nr_pages;
 	return true;
 }
 
