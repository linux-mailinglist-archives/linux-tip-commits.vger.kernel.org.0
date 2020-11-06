Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD002AA122
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgKFX1n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgKFX1c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:32 -0500
Date:   Fri, 06 Nov 2020 23:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pY7DA9qbI5XRfZrVzIAfdYa2nRBVxh972fm02NL9VrQ=;
        b=t/ubHeWnFI3TtT8dRwHG1re+yGQPOhkkpsUTYCYPR/P0zGgB3/8nDEat4Ec+IIkgGkcTJM
        BXjYIeZgAesy0G6dNhGTcPKz02jtPO+TiyEWEwuUd+kJatGWFu9VGIaAgioMDhFBSYVsKx
        ihsYhkxh4xXf+sj0OcVtApORf+1YtHWu7i7AueDUlEYVnF8LHm5pKm80HvIYZRXfhmEc6H
        ehjQYYf+68dHa5Gk73QvCU3lWND3aRfq51FUPnj0liUQYohUtGwNjBOND+nDn5ORiHt/d9
        kDsR43SP2q1MZOtue9l2css78TuNdoEUqT5AK19fTTsGgePCJ4gKij8L4MCdgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pY7DA9qbI5XRfZrVzIAfdYa2nRBVxh972fm02NL9VrQ=;
        b=m5RcE2LTURfX+es8IR3EAIJn1gKV9r0qAoUEAXi/pltUuAqP5NO8s2zPO/MJ7OrwD62+nq
        /XvLUF6JrHb4PbBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] highmem: Remove unused functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095856.732891880@linutronix.de>
References: <20201103095856.732891880@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524907.397.8217098587465620351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     b819fd9da38508e0504624b87d9983fcc4237f3c
Gitweb:        https://git.kernel.org/tip/b819fd9da38508e0504624b87d9983fcc4237f3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:53 +01:00

highmem: Remove unused functions

Nothing uses totalhigh_pages_dec() and totalhigh_pages_set().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095856.732891880@linutronix.de

---
 include/linux/highmem.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 14e6202..f5c3133 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -104,21 +104,11 @@ static inline void totalhigh_pages_inc(void)
 	atomic_long_inc(&_totalhigh_pages);
 }
 
-static inline void totalhigh_pages_dec(void)
-{
-	atomic_long_dec(&_totalhigh_pages);
-}
-
 static inline void totalhigh_pages_add(long count)
 {
 	atomic_long_add(count, &_totalhigh_pages);
 }
 
-static inline void totalhigh_pages_set(long val)
-{
-	atomic_long_set(&_totalhigh_pages, val);
-}
-
 void kmap_flush_unused(void);
 
 struct page *kmap_to_page(void *addr);
