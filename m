Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B534518F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Mar 2021 22:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCVVMN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Mar 2021 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhCVVLk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Mar 2021 17:11:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FAC061574;
        Mon, 22 Mar 2021 14:11:38 -0700 (PDT)
Date:   Mon, 22 Mar 2021 21:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616447497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rojIO89mEGlFRARFePTFk8tEEDNyJO1Urkm/8tbKYOA=;
        b=xaW/L/9zROQKNGDnLpeOXT530jC14GFlxH6+j9M62JeKnPO+pKUA4y3KFlNIPrRses9DE2
        N24qSQHtUz84JazaPheJyEmcq4qzxhFEDIP2gD15H2neufEVLkPHGxxZpZd8TYvXAwYlKU
        F+VOgMK7bR42xZ6yZv+j/9gFPFxbVsYZA3Q7XX28b2pP3e6CXYtaS2OxSpGdjiLT+eKvwM
        LgKY027dNqn0TMskHyEEZUSphNRyqbgUN8nAoklwkRYaUVKTN8Wp+xV6eAGATMpj9QsHR4
        dBnNt+WQIqUqi0xzfwJy1ekkoolFd/kDOYZeqkh422yMy6ZuBxeY5nGc9zKuiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616447497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rojIO89mEGlFRARFePTFk8tEEDNyJO1Urkm/8tbKYOA=;
        b=lWHTQyUcAO39ZsiMzXLphckpPmcBzerbK1RcIsCne5AdfbEurUKx9XwaXKZ9iwpfilU2d7
        txJ3TI+T9/ZFW4Bw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] lockdep: Address clang -Wformat warning printing for %hd
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210322115531.3987555-1-arnd@kernel.org>
References: <20210322115531.3987555-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161644749627.398.4415880937638801207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6d48b7912cc72275dc7c59ff961c8bac7ef66a92
Gitweb:        https://git.kernel.org/tip/6d48b7912cc72275dc7c59ff961c8bac7ef66a92
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 Mar 2021 12:55:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 22 Mar 2021 22:07:09 +01:00

lockdep: Address clang -Wformat warning printing for %hd

Clang doesn't like format strings that truncate a 32-bit
value to something shorter:

  kernel/locking/lockdep.c:709:4: error: format specifies type 'short' but the argument has type 'int' [-Werror,-Wformat]

In this case, the warning is a slightly questionable, as it could realize
that both class->wait_type_outer and class->wait_type_inner are in fact
8-bit struct members, even though the result of the ?: operator becomes an
'int'.

However, there is really no point in printing the number as a 16-bit
'short' rather than either an 8-bit or 32-bit number, so just change
it to a normal %d.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210322115531.3987555-1-arnd@kernel.org
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c30eb88..f160f1c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -705,7 +705,7 @@ static void print_lock_name(struct lock_class *class)
 
 	printk(KERN_CONT " (");
 	__print_lock_name(class);
-	printk(KERN_CONT "){%s}-{%hd:%hd}", usage,
+	printk(KERN_CONT "){%s}-{%d:%d}", usage,
 			class->wait_type_outer ?: class->wait_type_inner,
 			class->wait_type_inner);
 }
