Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D12AA11F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgKFX1m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgKFX1c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3AC0613D2;
        Fri,  6 Nov 2020 15:27:32 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvS06tEzm0MB64sKlcv2+qhjzvYI0LbIRqB0hdkViM=;
        b=g8xo3/xZvhV1I5quv4FFaXIGqzFRnE+Y/wkx+Cdn8a42CGupbtfT7U2QhsrSxpMXRtAT+l
        Uu0GijrmoUD2q0+ighi8tEhWyMiIFPeUU2k0urxnM7G3KVYIJ58JEnFaPEV/gL9dk/eecw
        IWwZlPlgNYdU+cthjGc9eYXMb5JnyxUB0oFB2ltLcMN0YI3GcsLXoP6ZkEdJo2QE4m5jK6
        5pPmCiLpi1ZiZ4nem24W5kdZpKeHqZuIvv9G0tAArxH+4GqI3XPYztuasdrhKtrF7qPZW7
        JE+lJUVu5W6NXXP8aWGA/E0IM0QhpRHHXDZGfw9bk8dJ3zPWI4QF5agr/ZIG9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhvS06tEzm0MB64sKlcv2+qhjzvYI0LbIRqB0hdkViM=;
        b=MH0EG2KH1/TmxWaq7yYUqrffhdgDm6y1hkMFVWXYpsEJ0cQmIwUQXPWSQOH/34Y9uVlKS8
        FCL1R4iczUip/UCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm/highmem: Un-EXPORT __kmap_atomic_idx()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095856.595767588@linutronix.de>
References: <20201103095856.595767588@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524997.397.14415419131958119018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     16675dda9355505245b89dd50723a2754819594b
Gitweb:        https://git.kernel.org/tip/16675dda9355505245b89dd50723a2754819594b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:53 +01:00

mm/highmem: Un-EXPORT __kmap_atomic_idx()

Nothing in modules can use that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095856.595767588@linutronix.de

---
 mm/highmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 1352a27..6abfd76 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -108,8 +108,6 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 atomic_long_t _totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(_totalhigh_pages);
 
-EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
-
 unsigned int nr_free_highpages (void)
 {
 	struct zone *zone;
