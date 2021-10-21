Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE3435F14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJUKfF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKfF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 06:35:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FFC06161C;
        Thu, 21 Oct 2021 03:32:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y30so1570960edi.0;
        Thu, 21 Oct 2021 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcQBJYHczgNY22raKWrYZwNKqI8gBwnBc19MF5JGLC0=;
        b=nBjPvuTh4/ybSswtpeaMTiH+OnwsXhlzvuUgTRTNk54CPe0YtYcy4acQC8qVgbHFZe
         tltTqP9RILOppfKH4nOs9WIKR5R4HOdOzPCmaGICWogz+DtoMTX6TsnCVwXHT5cnODWj
         FRL77JpyiS/q0dVmgiwoqgEiSW91U+J6O0/AoXeAHgzrDIrjQWEEh1b8uQKFke6cMwLx
         6+euGEwnifGnd+43uj8Y1Z7VwrCSvB8QfnCc86TR6cT1qE0JMgA/licA3YAADaMpZDu6
         b9YFL++uL8e6KnD+pzB7ZzZPMZ0ck66iw2DOJ8RA1JQDdUa5quMWSZv1oZ+Fdyqp/fFl
         0zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcQBJYHczgNY22raKWrYZwNKqI8gBwnBc19MF5JGLC0=;
        b=r3S+3u+QuEY5O7vpQp0qtxtHOAcraUg2fnJT11CSasSYtFvAkxSAlmJN7aEDb4WeuH
         AXklTJxjB/OYNhYyv3dbYleBjUaZQUTNlMW3cKeSSf4iVn92mIwGa916+GrgIYQNiN70
         YVq+JA/Eax6y7Vr7/ixlEARjchuO+LZzWzd/RSvyECpLxqrUudn7HS8GGKTmIE06CQUH
         A1r/LZ9wfcq8iCnpKZembKIq5iYEh187sSZPJ+Eoc2iUTjvDQjzO3x3F2JgXbafqioZW
         zJs4qs9CLTZOq9OKnZDAGXDLK8yqLhyNnA+ZXciQwDv0Qhrp5SpxHuC9BrIsvCKWmLFr
         jLcQ==
X-Gm-Message-State: AOAM531uE8LZtAIhyI/aIETBlIUVTRGV93tZMFFwmcNJwlBdktlbu96y
        QQhe7Rz8l8YpCO2sHCvNB4c+cOEG7RNErytZPHA=
X-Google-Smtp-Source: ABdhPJwjyI9TKoXiqIB3u0Gl0eHvJf81SFGrm7/gOGmiR/HG7qVKePv8j+H6/1GUDsKpqidcq7UQRfTytK09k6Y+X/w=
X-Received: by 2002:a17:906:94da:: with SMTP id d26mr6328926ejy.213.1634812367929;
 Thu, 21 Oct 2021 03:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-4-21cnbao@gmail.com> <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com> <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com> <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net> <20211020204056.GD174730@worktop.programming.kicks-ass.net>
In-Reply-To: <20211020204056.GD174730@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 21 Oct 2021 23:32:36 +1300
Message-ID: <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Oct 21, 2021 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:
>
> > OK, I think I see what's happening.
> >
> > AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> > means it's set to BAD_APICID.
> >
> > This then results in match_l2c() to never match. And as a direct
> > consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> > just the one CPU set.
> >
> > And we have the above result and things come unstuck if we assume:
> >   SMT <= L2 <= LLC
> >
> > Now, the big question, how to fix this... Does AMD have means of
> > actually setting l2c_id or should we fall back to using match_smt() for
> > l2c_id == BAD_APICID ?
>
> The latter looks something like the below and ought to make EPYC at
> least function as it did before.
>
>
> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 849159797101..c2671b2333d1 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>
>         /* Do not match if we do not have a valid APICID for cpu: */
>         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> -               return false;
> +               return match_smt(c, o); /* assume at least SMT shares L2 */

Rather than making a fake cluster_cpus and cluster_cpus_list which
will expose to userspace
through /sys/devices/cpus/cpux/topology, could we just fix the
sched_domain mask by the
below?
It will be odd to users that a cpu has BAD cluster_id but has
"meaningful" cluster_cpus and
cluster_cpus_list in sys.

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5094ab0bae58..0f9d706a7507 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -687,6 +687,15 @@ const struct cpumask *cpu_coregroup_mask(int cpu)

 const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
+       /*
+        * if L2(cluster) is not represented, make cluster sched_domain
+        * same with smt domain, so that this redundant sched_domain can
+        * be dropped and we can avoid the complaint "the SMT domain not
+        * a subset of the cluster domain"
+        */
+       if (cpumask_subset(cpu_l2c_shared_mask(cpu), cpu_smt_mask(cpu)))
+               return cpu_smt_mask(cpu);
+
        return cpu_l2c_shared_mask(cpu);
 }



>
>         /* Do not match if L2 cache id does not match: */
>         if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))

Thanks
Barry
