Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB74354B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTUnX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUnX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:43:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E033C06161C;
        Wed, 20 Oct 2021 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GSSJzXt/khP6ZNIaBJYLijAMX07CMH8JEjGm8gAUT4g=; b=fsX6Wq6hiUu+YBgkRD5GyePprm
        yK+4/F0kkmm3otS+tWwbE4jyU7tTFMCMnud6UfGVXTbaud9FvLP7y8XVWV39pZ4HaxpE/gI+NsOjx
        BNqgRwpj66xPB1iG6RmRqW0s7bZhJdRhy19pr5D6E1MdG0QPbCgmG1TUXT/V+fO4OWRbXkY5ZqmQk
        IGVZbDq8wHIS0nhYM7nOlEvKzhfEz3l6jLYagxI9I0nn3yESpogoWqzOVEPDZO0hUume1s7W1N+FL
        tyC/tH+rU+LBgKPE4goKiQQMB0wTAaKJSDDnVAmpic1iKyMnzcRV0CJWxo59yjKaNu1KAg+kgG4np
        it1SkQYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdIOP-00B25l-AP; Wed, 20 Oct 2021 20:40:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5EB1986DD9; Wed, 20 Oct 2021 22:40:56 +0200 (CEST)
Date:   Wed, 20 Oct 2021 22:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <20211020204056.GD174730@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020203619.GC174730@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:

> OK, I think I see what's happening.
> 
> AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> means it's set to BAD_APICID.
> 
> This then results in match_l2c() to never match. And as a direct
> consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> just the one CPU set.
> 
> And we have the above result and things come unstuck if we assume:
>   SMT <= L2 <= LLC
> 
> Now, the big question, how to fix this... Does AMD have means of
> actually setting l2c_id or should we fall back to using match_smt() for
> l2c_id == BAD_APICID ?

The latter looks something like the below and ought to make EPYC at
least function as it did before.


---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 849159797101..c2671b2333d1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
 	/* Do not match if we do not have a valid APICID for cpu: */
 	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
-		return false;
+		return match_smt(c, o); /* assume at least SMT shares L2 */
 
 	/* Do not match if L2 cache id does not match: */
 	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
