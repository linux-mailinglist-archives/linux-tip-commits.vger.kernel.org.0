Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB23A451D1F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbhKPAZQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347448AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BDC061767;
        Mon, 15 Nov 2021 12:22:41 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOHdZ50zXPHRB5zs2Xck8ACLpnGDwk+Waf97Ka7BF9c=;
        b=jHSlTHjsxL3JSF9PVxlbR0qpQwDumsPN+gKU+Uhhdjn48pfszbNxXg9JwQUScaoqnsF8my
        nXlgOUYi6qKySqORw7aVnpwfQaZAzhPImfliCSjTzACe6lLCtZmK+zC3YNNGat/g/IWd9h
        iVTVGkj7nr75htbgzHzP5gry61d+4uW4IyKsJNTRv+NYdwGE7GKakwZl39faRV+rFAr/bG
        fX0LcApklKSJv6k7GwjaOHbkZYiRP6P3iVoQozrI2vZpeDNdHXvQRDW9WXoYGvhn56eG9x
        ZpyEijRwjyW5dr8+bL/VgN6XaXhXzIJCuKokLzGR9Xc/qnv247iIjxvSuTg/7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOHdZ50zXPHRB5zs2Xck8ACLpnGDwk+Waf97Ka7BF9c=;
        b=wm2I8JuOLkcFdSsJm10HwEdPIfj+eFRXIS6zvRelKCKok2Nik/8NFV7e3hcg3rGUZJGGdg
        oKBuznwVIjNKc6Aw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add new sgx_epc_page flag bit to mark free pages
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026220050.697075-2-tony.luck@intel.com>
References: <20211026220050.697075-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163700775344.414.12167149752458370459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     d6d261bded8a57aed4faa12d08a5b193418d3aa4
Gitweb:        https://git.kernel.org/tip/d6d261bded8a57aed4faa12d08a5b193418d3aa4
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 26 Oct 2021 15:00:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:13:16 -08:00

x86/sgx: Add new sgx_epc_page flag bit to mark free pages

SGX EPC pages go through the following life cycle:

        DIRTY ---> FREE ---> IN-USE --\
                    ^                 |
                    \-----------------/

Recovery action for poison for a DIRTY or FREE page is simple. Just
make sure never to allocate the page. IN-USE pages need some extra
handling.

Add a new flag bit SGX_EPC_PAGE_IS_FREE that is set when a page
is added to a free list and cleared when the page is allocated.

Notes:

1) These transitions are made while holding the node->lock so that
   future code that checks the flags while holding the node->lock
   can be sure that if the SGX_EPC_PAGE_IS_FREE bit is set, then the
   page is on the free list.

2) Initially while the pages are on the dirty list the
   SGX_EPC_PAGE_IS_FREE bit is cleared.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20211026220050.697075-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 2 ++
 arch/x86/kernel/cpu/sgx/sgx.h  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de0..825aa91 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -472,6 +472,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
 	sgx_nr_free_pages--;
+	page->flags = 0;
 
 	spin_unlock(&node->lock);
 
@@ -626,6 +627,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
+	page->flags = SGX_EPC_PAGE_IS_FREE;
 
 	spin_unlock(&node->lock);
 }
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628ace..5906471 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -26,6 +26,9 @@
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
+/* Pages on free list */
+#define SGX_EPC_PAGE_IS_FREE		BIT(1)
+
 struct sgx_epc_page {
 	unsigned int section;
 	unsigned int flags;
