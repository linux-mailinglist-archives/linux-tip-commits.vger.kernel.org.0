Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131C435FC1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUK5V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUK5V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 06:57:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3CC06161C;
        Thu, 21 Oct 2021 03:55:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w14so977884edv.11;
        Thu, 21 Oct 2021 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKFZzH+HUyjpXqrV3CVv7tC90Gn+rq5JqtpXE+wjsM8=;
        b=S20HXSTMGRa0dnI5vnzANDI1eE6WjONuYiAdSkEizoWxgL/kYQl9iTm+CVx6GG6myO
         FMfdt5wC/tD7QBagyL7kQGs4k0IxRgqr+NYvmMEcODoZZLj1G5XrnaVE/hHsE2PREogi
         OUSmLoUoAeZ5nLqryEVImvM5lcEZ+Yy9NSS/bxBONTp+9tRD2JIlGAG030PYDm6xh5bw
         /idWmv8RoMqdq+hFKVO0U8Ba+tV36NJwU+sYRILeBWhDPn2JWYnVbXeiiVn1qT7/2y4S
         EQ8FPTx5fvXb1jaK/yVZ9Z6Uw46a0KGB80BLoGeBIgnZPgmgdYuLgRYw7oeYIy42sWBa
         +lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKFZzH+HUyjpXqrV3CVv7tC90Gn+rq5JqtpXE+wjsM8=;
        b=xoMt4vW3Snj8b3rwSaJ3fhYf1Hmm1KU32dB3SVuuq0qwjiLRzIj04IjsRhcBpZThZr
         oP072LP2fdzrt88BtYYVtKC3DCadgvEzg9aFiNY4nxv7m6ruuRTuKmwPDnI13jm5VxDR
         p1a7R3Z6NdYNncZIG15Ab1m1cuAC8wyRBaiVlMvJRdOrmJSWfO0HoMmFiYml/EB7VMyW
         WkNiHgnq4Rni9YQnX6S566CZIGV7LLHDG7YZUFSr2byk31cLu3fEKnf8o8ew+V2PMHZG
         cFrV26v1b/ayYOQy3rSW18ikg1aFj7rRGuMQVQDqM2NCldJfInQs5uwaZtKAMAxn6jTV
         GK4w==
X-Gm-Message-State: AOAM533ZxR1qMYJhEtI6MW1tSW4GjTNtRifewGwcOAuS6TV19z1vRBmH
        JGAQQ0bNZpXpnEhzGvXEY7QxAfK1t1UlgzY8TTt9LIGPzNw=
X-Google-Smtp-Source: ABdhPJyoiwD2qpHLR7Bfg1W8oLJVc6+BMCio16mo7ByZk7mnGyoI1HAT+lDeVpQjjQ1YeaWyn381FTbVwnCXZLEX6rU=
X-Received: by 2002:a17:907:767a:: with SMTP id kk26mr6581796ejc.134.1634813704219;
 Thu, 21 Oct 2021 03:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210924085104.44806-4-21cnbao@gmail.com> <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com> <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com> <20211020202542.GU174703@worktop.programming.kicks-ass.net>
 <20211020203619.GC174730@worktop.programming.kicks-ass.net>
 <20211020204056.GD174730@worktop.programming.kicks-ass.net> <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xNYz8ZpLz_1Fyd-FzTWG9HuoONqCGApX+to5Zpw5P67g@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 21 Oct 2021 23:54:52 +1300
Message-ID: <CAGsJ_4y3z4OcbZO-UujTWmg+favNv-s2S0s6V7RXQHWQMNZOVA@mail.gmail.com>
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

On Thu, Oct 21, 2021 at 11:32 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Oct 21, 2021 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 20, 2021 at 10:36:19PM +0200, Peter Zijlstra wrote:
> >
> > > OK, I think I see what's happening.
> > >
> > > AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
> > > means it's set to BAD_APICID.
> > >
> > > This then results in match_l2c() to never match. And as a direct
> > > consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
> > > just the one CPU set.
> > >
> > > And we have the above result and things come unstuck if we assume:
> > >   SMT <= L2 <= LLC
> > >
> > > Now, the big question, how to fix this... Does AMD have means of
> > > actually setting l2c_id or should we fall back to using match_smt() for
> > > l2c_id == BAD_APICID ?
> >
> > The latter looks something like the below and ought to make EPYC at
> > least function as it did before.
> >
> >
> > ---
> >  arch/x86/kernel/smpboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 849159797101..c2671b2333d1 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -472,7 +472,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> >
> >         /* Do not match if we do not have a valid APICID for cpu: */
> >         if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
> > -               return false;
> > +               return match_smt(c, o); /* assume at least SMT shares L2 */
>
> Rather than making a fake cluster_cpus and cluster_cpus_list which
> will expose to userspace
> through /sys/devices/cpus/cpux/topology, could we just fix the
> sched_domain mask by the
> below?
> It will be odd to users that a cpu has BAD cluster_id but has
> "meaningful" cluster_cpus and
> cluster_cpus_list in sys.
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 5094ab0bae58..0f9d706a7507 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -687,6 +687,15 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>
>  const struct cpumask *cpu_clustergroup_mask(int cpu)
>  {
> +       /*
> +        * if L2(cluster) is not represented, make cluster sched_domain
> +        * same with smt domain, so that this redundant sched_domain can
> +        * be dropped and we can avoid the complaint "the SMT domain not
> +        * a subset of the cluster domain"
> +        */
> +       if (cpumask_subset(cpu_l2c_shared_mask(cpu), cpu_smt_mask(cpu)))
> +               return cpu_smt_mask(cpu);
> +
>         return cpu_l2c_shared_mask(cpu);
>  }

needs to change this line as well, otherwise, sys is still using the
cpu_clustergroup_mask:

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cc164777e661..c8cd4e9732bd 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -116,7 +116,7 @@ extern unsigned int __max_die_per_package;
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)               (per_cpu(cpu_l2c_id, cpu))
 #define topology_die_cpumask(cpu)              (per_cpu(cpu_die_map, cpu))
-#define topology_cluster_cpumask(cpu)          (cpu_clustergroup_mask(cpu))
+#define topology_cluster_cpumask(cpu)          (cpu_l2c_shared_mask(cpu))
 #define topology_core_cpumask(cpu)             (per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)          (per_cpu(cpu_sibling_map, cpu))

so sys will use topology_cluster_cpumask which describes hardware as it is;
cpu_clustergroup_mask() describes what is given to the scheduler.

>
>
>
> >
> >         /* Do not match if L2 cache id does not match: */
> >         if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
>
> Thanks
> Barry

Thanks
barry
