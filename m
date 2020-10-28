Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484D929D65E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgJ1WO1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 18:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgJ1WO0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2FC0613CF;
        Wed, 28 Oct 2020 15:14:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 13:56:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603893372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAvI7dHJx8wfahjko7XQ1ABYhbCwCkyHVzhFN8A1ygU=;
        b=E5uz2HTICYHzGXw5ZYiy/+yBdTDS6u57xqxSe4g+gBFI4aUVexvQH39Y80k5tqUI5BRfhk
        UqTWu0PhM5g9fDg74F4koNJasCKkA6NsIuELkUefftvmD3mtxFGgGh0FbN5g39VfiVY6sl
        nsY/ShNCdt7rLsALBX1llxhzcefQpkx5bB+ZWWeBniRUEaM+TARCllN+nsL5GBThS8q9Sg
        JZZMZyQZv46ZcSUAao44pzZ7Ir49Np1L+SKYaHPfbtVNqxwwRwNA/sOK+wThe1z2yfno/B
        Cq+WsDmYyJgPmVM9BuRlrgAMsWYk4AnbSqxPxUdWnpK5RGvdNoaGkiMAlLAzMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603893372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAvI7dHJx8wfahjko7XQ1ABYhbCwCkyHVzhFN8A1ygU=;
        b=1zLNqNSgg67VMV43CcBi7SqLpnB0p3bbn2areaRCcBwzRV0ukphUpEYMpDkAxTdmv26G4B
        qlAQPU6cxj9TT1CA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/ident_map: Check for errors from ident_pud_init()
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201027230648.1885111-1-nivedita@alum.mit.edu>
References: <20201027230648.1885111-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160389337110.397.17976376777109994425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1fcd009102ee02e217f2e7635ab65517d785da8e
Gitweb:        https://git.kernel.org/tip/1fcd009102ee02e217f2e7635ab65517d785da8e
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 27 Oct 2020 19:06:48 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 28 Oct 2020 14:48:30 +01:00

x86/mm/ident_map: Check for errors from ident_pud_init()

Commit

  ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")

added ident_p4d_init() to support 5-level paging, but this function
doesn't check and return errors from ident_pud_init().

For example, the decompressor stub uses this code to create an identity
mapping. If it runs out of pages while trying to allocate a PMD
pagetable, the error will be currently ignored.

Fix this to propagate errors.

 [ bp: Space out statements for better readability. ]

Fixes: ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20201027230648.1885111-1-nivedita@alum.mit.edu
---
 arch/x86/mm/ident_map.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index fe7a125..968d700 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -62,6 +62,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 			  unsigned long addr, unsigned long end)
 {
 	unsigned long next;
+	int result;
 
 	for (; addr < end; addr = next) {
 		p4d_t *p4d = p4d_page + p4d_index(addr);
@@ -73,13 +74,20 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			ident_pud_init(info, pud, addr, next);
+			result = ident_pud_init(info, pud, addr, next);
+			if (result)
+				return result;
+
 			continue;
 		}
 		pud = (pud_t *)info->alloc_pgt_page(info->context);
 		if (!pud)
 			return -ENOMEM;
-		ident_pud_init(info, pud, addr, next);
+
+		result = ident_pud_init(info, pud, addr, next);
+		if (result)
+			return result;
+
 		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
 	}
 
