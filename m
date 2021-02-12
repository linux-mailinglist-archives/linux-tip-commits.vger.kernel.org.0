Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF2319E7D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBLMhs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:37:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhBLMhq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:46 -0500
Date:   Fri, 12 Feb 2021 12:37:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kXQwtKkD08F/lBydHMjkr/aNup2oOyRwUYr+QcQBRSM=;
        b=u5NzL8fePR16bAzzt9zQnm6baisNjbItKLzfemsMqGyJcLlWKut43yIuLchCYcON/8qzoe
        jif6noqNMhN0wXp7OsqyuszgdY7SWwGFXhgOkWHw/1p5JebshhKMpidGiRWQawIwlgSbz3
        yQuNR7AjdSLtIYripita9lvx0NdhzYl9ZikvvY8XRrHHiQ4FV4KuU6qLNzfRHkFI6kWFGg
        ioIiDnXluIlq16vVdy3SM0pA2TlbMXPSKD9zK6XHHMfQATIUxTuEawPkhvYRAPqvZUOcr7
        IZkSSQJOX4bYlgrBxoHBlWXKyD2ECASskVRNY4eraAMtJXq0w42hq6RGj3BG8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kXQwtKkD08F/lBydHMjkr/aNup2oOyRwUYr+QcQBRSM=;
        b=sstL6EXJmuSBjDFVVwyWAwVdKn3kljn7rJJSAno2IuOe+YlM6mZxajljb1i42JD28tBrW1
        goDOXIsYBJVynXCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm: Make mem_obj_dump() vmalloc() dumps include start
 and length
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342351.23325.639107146733675689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bd34dcd4120d7e358baac9c22ef1321bd0c22079
Gitweb:        https://git.kernel.org/tip/bd34dcd4120d7e358baac9c22ef1321bd0c22079
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 09 Dec 2020 15:15:27 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 22 Jan 2021 15:24:10 -08:00

mm: Make mem_obj_dump() vmalloc() dumps include start and length

This commit adds the starting address and number of pages to the vmalloc()
information dumped by way of vmalloc_dump_obj().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c274ea4..e3229ff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3456,7 +3456,8 @@ bool vmalloc_dump_obj(void *object)
 	vm = find_vm_area(objp);
 	if (!vm)
 		return false;
-	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
+		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
 
