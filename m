Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891AB3F5AFE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Aug 2021 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhHXJ2c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Aug 2021 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhHXJ2c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Aug 2021 05:28:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB32C061757;
        Tue, 24 Aug 2021 02:27:48 -0700 (PDT)
Date:   Tue, 24 Aug 2021 09:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629797267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPhM15sS7uHWi7ZsroKW7dkJMk1jrQ9AzQx0QYOhu1s=;
        b=GBX56r566UpwQHsD30/8BUxcBK3QYkoLgPo0l8mwkiDwXS03QJ6c/ijMC7N4bgAHR1WycG
        U3YavPb8emQUPLU/krzTmLk47aoDGjUgp62NyodUZFVGItuayeQuaawlFBnmCBOpqbwNQz
        YHHqZ2MP0gTqjxi2Jjm+zl/UCdEWGjn6UvqcOl/uleP9YsIi1Re88YfJbqgNKMO6TyfcMf
        z53Dr2uxj5gHYKCLmA6GJl31+HQs2uipOjy1eUAE91l+h/TKEPz3Kl698P3UtQnIdar36e
        qFW4Dj/GcULmDxZ8SRLIWV8yON7cM2VPyn9uu5Yvb/B0/kvOq+veVL8ZjDIJ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629797267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPhM15sS7uHWi7ZsroKW7dkJMk1jrQ9AzQx0QYOhu1s=;
        b=YJ6WNCKNC7cdFcMUoMaVPjXi4NtUcA+Ei9+EqnKXoFRncxnd9A9QD7nkuL06FT74lTGeGb
        HuJ0scB0fOYA5tAA==
From:   "tip-bot2 for Jing Yangyang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kaslr: Have process_mem_region() return a boolean
Cc:     Zeal Robot <zealci@zte.com.cn>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210824070515.61065-1-deng.changcheng@zte.com.cn>
References: <20210824070515.61065-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Message-ID: <162979726622.25758.13276488886487213050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5b3fd8aa5df0244fc19f2572598dee406bcc6b07
Gitweb:        https://git.kernel.org/tip/5b3fd8aa5df0244fc19f2572598dee406bcc6b07
Author:        Jing Yangyang <jing.yangyang@zte.com.cn>
AuthorDate:    Tue, 24 Aug 2021 00:05:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Aug 2021 10:54:15 +02:00

x86/kaslr: Have process_mem_region() return a boolean

Fix the following coccicheck warning:

  ./arch/x86/boot/compressed/kaslr.c:671:10-11:WARNING:return of 0/1
  in function 'process_mem_region' with return type bool

Generated by: scripts/coccinelle/misc/boolreturn.cocci

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210824070515.61065-1-deng.changcheng@zte.com.cn
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e366907..67c3208 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -668,7 +668,7 @@ static bool process_mem_region(struct mem_vector *region,
 
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820/efi memmap scan when walking immovable regions(slot_areas full)!\n");
-			return 1;
+			return true;
 		}
 	}
 #endif
