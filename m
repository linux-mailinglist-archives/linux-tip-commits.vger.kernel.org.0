Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637C52E76EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Dec 2020 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgL3IJj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Dec 2020 03:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3IJj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Dec 2020 03:09:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FEC061799;
        Wed, 30 Dec 2020 00:08:58 -0800 (PST)
Date:   Wed, 30 Dec 2020 08:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609315734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjBo9fZcHkmUBKB+OWzrTv2MgULgW9Ys9v0CTVWiIY8=;
        b=ujmGG2rf4T4VV/2Ae/H9ZsoT1AxqeLFDbhl5J4aE5MC89PvTU0QTNF13suoeljsMfOIIpD
        XzGqrz2XkoMlOH3nPsCHhM18Bk7qTB9A4KJZkvd7eIkmxvymdIOYESqsr27u+49dyRI3BZ
        lbnMxtVnZE0ejEmIyvs3zjJ/0tUSUwOU09f3VGUu5X0//PPw+NoIEM/QlcmZzDRsbwxS2W
        4QrD8yDmSevNVu4i+MdZI/ob7itvqP/7tAL3hQ+w90wtYLLlO1sHsLGgU8NLNSUKxpHET9
        0X4TpMKIUZm2hr2vOiu8R0MHIW39VTUJb9tLVwwLcq+7+Ts35E9EYdCkXPw1hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609315734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RjBo9fZcHkmUBKB+OWzrTv2MgULgW9Ys9v0CTVWiIY8=;
        b=MJMD+xb83lDxnuDGr4081/Hjht+uZOm0wdf8/npD1NDorZ5WBlIZkNQWjYm4hukN2IBPzT
        rQIfF8ko3kga7SBA==
From:   "tip-bot2 for Zheng Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Convert comma to semicolon
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201216131159.14393-1-zhengyongjun3@huawei.com>
References: <20201216131159.14393-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <160931573372.414.13001763722317437714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3052636aa9aa2492ccac973449be63cae5b93a67
Gitweb:        https://git.kernel.org/tip/3052636aa9aa2492ccac973449be63cae5b93a67
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Wed, 16 Dec 2020 21:11:59 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Dec 2020 08:56:35 +01:00

x86/mtrr: Convert comma to semicolon

Replace a comma between expression statements with a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201216131159.14393-1-zhengyongjun3@huawei.com
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 5bd0117..9231640 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -537,9 +537,9 @@ static void __init print_out_mtrr_range_state(void)
 		if (!size_base)
 			continue;
 
-		size_base = to_size_factor(size_base, &size_factor),
+		size_base = to_size_factor(size_base, &size_factor);
 		start_base = range_state[i].base_pfn << (PAGE_SHIFT - 10);
-		start_base = to_size_factor(start_base, &start_factor),
+		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;
 
 		pr_debug("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
