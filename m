Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30C349C21
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCYWO3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCYWOZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 18:14:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F6C06174A;
        Thu, 25 Mar 2021 15:14:25 -0700 (PDT)
Date:   Thu, 25 Mar 2021 22:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616710463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBygGIDo+ubwKGFZSDpa4w5asYeP8qGGmWRO1AGK8s4=;
        b=z22L3U8gwEwQ4qHfhulzhQZoC8F2moQmfQz+Wwz24/yv/2MluDEYNH/OsC/+S7cIUZOOrB
        KjTh3RrA6jBFPEb63pc7ubux1Pzp5yBVjiTYDjJzYTAPayD6ZjiWic+2GxfSTGLTkUqpO6
        raWGrYZGJLjYlCMuptHIrGnQDVNVzEIF/NIit5BAMsn4tqopMdfCnjJ11QHvRrC8rw04SM
        9mRak2HkYGoaZx8iljiWHkaLDXqh6OkS8Z/kij2tt41uh/zwqYszUckArfinh9Q1hm6Ytq
        DdEmQB0xN0qsNhhjQS768p2Qgd0JIl+hUw8bMZwYwFMLJRivwkPU0C4P9xpJmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616710463;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBygGIDo+ubwKGFZSDpa4w5asYeP8qGGmWRO1AGK8s4=;
        b=nQGpoHpxL8ZgYe3iu7U+1gSCNHZsDoaAqCBitezY6BgSstu6EfYBxlGRhVT7lQnGjqudFX
        vk/k9C0/IeCVKEDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] tools/turbostat: Unmark non-kernel-doc comment
Cc:     Randy Dunlap <rdunlap@infradead.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210325201333.16792-1-rdunlap@infradead.org>
References: <20210325201333.16792-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <161671046209.398.1030054058250095628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     800c120ef4e3abb45d67a36d3e5532eb051efc3c
Gitweb:        https://git.kernel.org/tip/800c120ef4e3abb45d67a36d3e5532eb051efc3c
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 13:13:33 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Mar 2021 23:10:45 +01:00

tools/turbostat: Unmark non-kernel-doc comment

Do not mark a comment as kernel-doc notation when it is not meant to be
in kernel-doc notation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210325201333.16792-1-rdunlap@infradead.org
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f07..5939615 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2449,7 +2449,7 @@ dump_knl_turbo_ratio_limits(void)
 	fprintf(outf, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n",
 		base_cpu, msr);
 
-	/**
+	/*
 	 * Turbo encoding in KNL is as follows:
 	 * [0] -- Reserved
 	 * [7:1] -- Base value of number of active cores of bucket 1.
