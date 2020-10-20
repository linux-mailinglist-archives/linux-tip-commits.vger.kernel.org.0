Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560A028AC59
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgJLDLT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJLDLT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 23:11:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE25C0613CE;
        Sun, 11 Oct 2020 20:11:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x20so9591875qkn.1;
        Sun, 11 Oct 2020 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G2namSrFdlEfdylppeIW9iy/yPAlpoTHkI+B7Y+ofos=;
        b=KfwfdldUnWthBc8bONcS0VaS4bA/17RQDGYJ33p/ygpDSDdZFDWXMBj39HyglaG03G
         P755L8Jpp0YvTpAuHZMqRSbwxJgvGOurSUR8HLROXfBkdDt0bvzFKEcu+qOLlg+VA98l
         NlzE0eXLdjqDND0UhThCcWMjTVj/NN/yj6oZlZXurMVIlZMudl2VsseBiLZyeqwA2FVR
         F5716PYxdnvFmIvqKmvQemT8fVuHT9xTBsQxC6tIEvcXdERSmJ8qhMm4bTFe3yjKNNYK
         TW0lJpDe/ydaNNsGqmpzgspLOePYO6E6xWQqtPyjI8SX/BMTHEBLpLtWO6X+VXIXlRRR
         1iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2namSrFdlEfdylppeIW9iy/yPAlpoTHkI+B7Y+ofos=;
        b=aL0UDBiLVzLIM4OIjnlmPma4/socdLEwSzeUT1zKhSZuSIGBNMoj+q+TjTI9Y66SNQ
         jAQjfXCFTkGfqYM77+swclk1CPXpfLskzdVUzjSY7BkI3/pSNNXRXxd1OEPhEPSFiLXa
         R+Pu1Ej2WHZRYQoCQlR7NAdtDtSXfllk8x3nJXnxBQSDtc8hEWi0pHijxXu2TLe2gkwW
         1+YL0QGx0BA6DBsCWLV9pxlgZeJHe8likm9eylgKjiuo7GNFCljZFmibeqmGRNuKCKhX
         JcBeMSFqsYDFGRQXX4p0iUtwlx5mx0UjdwpEDn063XnNURTvjbY6binjtjlWvGKBZohQ
         dP/Q==
X-Gm-Message-State: AOAM532snV6fGFdcvabKjdN/i0uqRXKF1U1N84OArtRSHUJHOMBUJah+
        xtdMvKg+hHLX47xXVIBiOFw=
X-Google-Smtp-Source: ABdhPJx1ly4jE/z7dXF7/Lo/su8+7I4ZociuezNcJxsCQ7hc/DBgEP1g55cw3AjKj70gzgPiqLY7FA==
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr8401711qkb.184.1602472277701;
        Sun, 11 Oct 2020 20:11:17 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p3sm11446876qkj.113.2020.10.11.20.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 20:11:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 836EA27C0054;
        Sun, 11 Oct 2020 23:11:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 11 Oct 2020 23:11:15 -0400
X-ME-Sender: <xms:UMmDX46jSedaHZh55sCJKvwlIunfPzaZ3DRsMEhSB0sXS35YT2Vokg>
    <xme:UMmDX55TKtYLDEXCXLMXgB_gOLFNcNIftKqE5zV9VNBuyM8_giZuWd4Faa0pjr270
    U3paM-qFx0PBQpqSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduud
    drjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:UMmDX3fmLUiMt4thP1YYDeqt4rAr9gbm7mwp-Y-KNRkuYcpCJoV7Mw>
    <xmx:UMmDX9J2MeXDDb7VQ4i1sSu36NkAedn8gGda3JOlgrvQXO89L2lUVg>
    <xmx:UMmDX8IHrOhiFSdS8hoBbCTrqHtHeIvMcr1jY6oVAcLnfpENV17RuA>
    <xmx:U8mDX79aD_UYujOq-L693JVz4izAcYE15AaxIrmn3xAYb4UQyWYtdEzx-0U>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E3BC328005E;
        Sun, 11 Oct 2020 23:11:12 -0400 (EDT)
Date:   Mon, 12 Oct 2020 11:11:10 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qian Cai <cai@redhat.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Fix lockdep recursion
Message-ID: <20201012031110.GA39540@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <160223032121.7002.1269740091547117869.tip-bot2@tip-bot2>
 <e438b231c5e1478527af6c3e69bf0b37df650110.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e438b231c5e1478527af6c3e69bf0b37df650110.camel@redhat.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

On Fri, Oct 09, 2020 at 09:41:24AM -0400, Qian Cai wrote:
> On Fri, 2020-10-09 at 07:58 +0000, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the locking/core branch of tip:
> > 
> > Commit-ID:     4d004099a668c41522242aa146a38cc4eb59cb1e
> > Gitweb:        
> > https://git.kernel.org/tip/4d004099a668c41522242aa146a38cc4eb59cb1e
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Fri, 02 Oct 2020 11:04:21 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 09 Oct 2020 08:53:30 +02:00
> > 
> > lockdep: Fix lockdep recursion
> > 
> > Steve reported that lockdep_assert*irq*(), when nested inside lockdep
> > itself, will trigger a false-positive.
> > 
> > One example is the stack-trace code, as called from inside lockdep,
> > triggering tracing, which in turn calls RCU, which then uses
> > lockdep_assert_irqs_disabled().
> > 
> > Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu
> > variables")
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Reverting this linux-next commit fixed booting RCU-list warnings everywhere.
> 

I think this happened because in this commit debug_lockdep_rcu_enabled()
didn't adopt to the change that made lockdep_recursion a percpu
variable?

Qian, mind to try the following?

Although, arguably the problem still exists, i.e. we still have an RCU
read-side critical section inside lock_acquire(), which may be called on
a yet-to-online CPU, which RCU doesn't watch. I think this used to be OK
because we don't "free" anything from lockdep, IOW, there is no
synchronize_rcu() or call_rcu() that _needs_ to wait for the RCU
read-side critical sections inside lockdep. But now we lock class
recycling, so it might be a problem.

That said, currently validate_chain() and lock class recycling are
mutually excluded via graph_lock, so we are safe for this one ;-)

----------->8
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39334d2d2b37..35d9bab65b75 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -275,8 +275,8 @@ EXPORT_SYMBOL_GPL(rcu_callback_map);
 
 noinstr int notrace debug_lockdep_rcu_enabled(void)
 {
-	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
-	       current->lockdep_recursion == 0;
+	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE &&
+	       __lockdep_enabled;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
 

> == x86 ==
> [    8.101841][    T1] rcu: Hierarchical SRCU implementation.
> [    8.110615][    T5] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    8.153506][    T1] smp: Bringing up secondary CPUs ...
> [    8.163075][    T1] x86: Booting SMP configuration:
> [    8.167843][    T1] .... node  #0, CPUs:        #1
> [    4.002695][    T0] 
> [    4.002695][    T0] =============================
> [    4.002695][    T0] WARNING: suspicious RCU usage
> [    4.002695][    T0] 5.9.0-rc8-next-20201009 #2 Not tainted
> [    4.002695][    T0] -----------------------------
> [    4.002695][    T0] kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> [    4.002695][    T0] 
> [    4.002695][    T0] other info that might help us debug this:
> [    4.002695][    T0] 
> [    4.002695][    T0] 
> [    4.002695][    T0] RCU used illegally from offline CPU!
> [    4.002695][    T0] rcu_scheduler_active = 1, debug_locks = 1
> [    4.002695][    T0] no locks held by swapper/1/0.
> [    4.002695][    T0] 
> [    4.002695][    T0] stack backtrace:
> [    4.002695][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc8-next-20201009 #2
> [    4.002695][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> [    4.002695][    T0] Call Trace:
> [    4.002695][    T0]  dump_stack+0x99/0xcb
> [    4.002695][    T0]  __lock_acquire.cold.76+0x2ad/0x3e0
> lookup_chain_cache at kernel/locking/lockdep.c:3497
> (inlined by) lookup_chain_cache_add at kernel/locking/lockdep.c:3517
> (inlined by) validate_chain at kernel/locking/lockdep.c:3572
> (inlined by) __lock_acquire at kernel/locking/lockdep.c:4837
> [    4.002695][    T0]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
> [    4.002695][    T0]  lock_acquire+0x1c8/0x820
> lockdep_recursion_finish at kernel/locking/lockdep.c:435
> (inlined by) lock_acquire at kernel/locking/lockdep.c:5444
> (inlined by) lock_acquire at kernel/locking/lockdep.c:5407
> [    4.002695][    T0]  ? __debug_object_init+0xb4/0xf50
> [    4.002695][    T0]  ? memset+0x1f/0x40
> [    4.002695][    T0]  ? rcu_read_unlock+0x40/0x40
> [    4.002695][    T0]  ? mce_gather_info+0x170/0x170
> [    4.002695][    T0]  ? arch_freq_get_on_cpu+0x270/0x270
> [    4.002695][    T0]  ? mce_cpu_restart+0x40/0x40
> [    4.002695][    T0]  _raw_spin_lock_irqsave+0x30/0x50
> [    4.002695][    T0]  ? __debug_object_init+0xb4/0xf50
> [    4.002695][    T0]  __debug_object_init+0xb4/0xf50
> [    4.002695][    T0]  ? mce_amd_feature_init+0x80c/0xa70
> [    4.002695][    T0]  ? debug_object_fixup+0x30/0x30
> [    4.002695][    T0]  ? machine_check_poll+0x2d0/0x2d0
> [    4.002695][    T0]  ? mce_cpu_restart+0x40/0x40
> [    4.002695][    T0]  init_timer_key+0x29/0x220
> [    4.002695][    T0]  identify_cpu+0xfcb/0x1980
> [    4.002695][    T0]  identify_secondary_cpu+0x1d/0x190
> [    4.002695][    T0]  smp_store_cpu_info+0x167/0x1f0
> [    4.002695][    T0]  start_secondary+0x5b/0x290
> [    4.002695][    T0]  secondary_startup_64_no_verify+0xb8/0xbb
> [    8.379508][    T1]   #2
> [    8.389728][    T1]   #3
> [    8.399901][    T1] 
> 
> == s390 ==
> 00: [    1.539768] rcu: Hierarchical SRCU implementation.                       
> 00: [    1.561622] smp: Bringing up secondary CPUs ...                          
> 00: [    1.568677]                                                              
> 00: [    1.568681] =============================                                
> 00: [    1.568682] WARNING: suspicious RCU usage                                
> 00: [    1.568688] 5.9.0-rc8-next-20201009 #2 Not tainted                       
> 00: [    1.568688] -----------------------------                                
> 00: [    1.568691] kernel/locking/lockdep.c:3497 RCU-list traversed in non-reade
> 00: r section!!                                                                 
> 00: [    1.568692]                                                              
> 00: [    1.568692] other info that might help us debug this:                    
> 00: [    1.568692]                                                              
> 00: [    1.568694]                                                              
> 00: [    1.568694] RCU used illegally from offline CPU!                         
> 00: [    1.568694] rcu_scheduler_active = 1, debug_locks = 1                    
> 00: [    1.568697] no locks held by swapper/1/0.                                
> 00: [    1.568697]                                                              
> 00: [    1.568697] stack backtrace:                                             
> 00: [    1.568702] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc8-next-2020
> 00: 1009 #2                                                                     
> 00: [    1.568704] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
> 00: [    1.568706] Call Trace:                                                  
> 00: [    1.568719]  [<000000011fb85370>] show_stack+0x158/0x1f0                 
> 00: [    1.568723]  [<000000011fb90402>] dump_stack+0x1f2/0x238                 
> 00: [    1.568730]  [<000000011ebd89d8>] __lock_acquire+0x2640/0x4dd0   
> lookup_chain_cache at kernel/locking/lockdep.c:3497
> (inlined by) lookup_chain_cache_add at kernel/locking/lockdep.c:3517
> (inlined by) validate_chain at kernel/locking/lockdep.c:3572
> (inlined by) __lock_acquire at kernel/locking/lockdep.c:4837
> 00: [    1.568732]  [<000000011ebdd230>] lock_acquire+0x3a8/0xd08 
> lockdep_recursion_finish at kernel/locking/lockdep.c:435
> (inlined by) lock_acquire at kernel/locking/lockdep.c:5444
> (inlined by) lock_acquire at kernel/locking/lockdep.c:5407
> 00: [    1.568738]  [<000000011fbb5ca8>] _raw_spin_lock_irqsave+0xc0/0xf0
> __raw_spin_lock_irqsave at include/linux/spinlock_api_smp.h:117
> (inlined by) _raw_spin_lock_irqsave at kernel/locking/spinlock.c:159
> 00: [    1.568745]  [<000000011ec6e7e8>] clockevents_register_device+0xa8/0x528 
> 00:                                                                             
> 00: [    1.568748]  [<000000011ea55246>] init_cpu_timer+0x33e/0x468             
> 00: [    1.568754]  [<000000011ea7f4d2>] smp_init_secondary+0x11a/0x328         
> 00: [    1.568757]  [<000000011ea7f3b2>] smp_start_secondary+0x82/0x88
> smp_start_secondary at arch/s390/kernel/smp.c:892
> 00: [    1.568759] no locks held by swapper/1/0.                                
> 00: [    1.569956] smp: Brought up 1 node, 2 CPUs
> 
> > ---
> >  include/linux/lockdep.h  |  13 +++--
> >  kernel/locking/lockdep.c |  99 ++++++++++++++++++++++----------------
> >  2 files changed, 67 insertions(+), 45 deletions(-)
> > 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 6a584b3..b1227be 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -534,6 +534,7 @@ do {								
> > 	\
> >  
> >  DECLARE_PER_CPU(int, hardirqs_enabled);
> >  DECLARE_PER_CPU(int, hardirq_context);
> > +DECLARE_PER_CPU(unsigned int, lockdep_recursion);
> >  
> >  /*
> >   * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
> > @@ -543,25 +544,27 @@ DECLARE_PER_CPU(int, hardirq_context);
> >   * read the value from our previous CPU.
> >   */
> >  
> > +#define __lockdep_enabled	(debug_locks &&
> > !raw_cpu_read(lockdep_recursion))
> > +
> >  #define lockdep_assert_irqs_enabled()					
> > \
> >  do {									\
> > -	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
> > +	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirqs_enabled)); \
> >  } while (0)
> >  
> >  #define lockdep_assert_irqs_disabled()					
> > \
> >  do {									\
> > -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> > +	WARN_ON_ONCE(__lockdep_enabled && raw_cpu_read(hardirqs_enabled)); \
> >  } while (0)
> >  
> >  #define lockdep_assert_in_irq()						
> > \
> >  do {									\
> > -	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
> > +	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirq_context)); \
> >  } while (0)
> >  
> >  #define lockdep_assert_preemption_enabled()				\
> >  do {									\
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> > -		     debug_locks			&&		\
> > +		     __lockdep_enabled			&&		\
> >  		     (preempt_count() != 0		||		\
> >  		      !raw_cpu_read(hardirqs_enabled)));		\
> >  } while (0)
> > @@ -569,7 +572,7 @@ do {								
> > 	\
> >  #define lockdep_assert_preemption_disabled()				\
> >  do {									\
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> > -		     debug_locks			&&		\
> > +		     __lockdep_enabled			&&		\
> >  		     (preempt_count() == 0		&&		\
> >  		      raw_cpu_read(hardirqs_enabled)));			\
> >  } while (0)
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index a430fbb..85d15f0 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -76,6 +76,23 @@ module_param(lock_stat, int, 0644);
> >  #define lock_stat 0
> >  #endif
> >  
> > +DEFINE_PER_CPU(unsigned int, lockdep_recursion);
> > +EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
> > +
> > +static inline bool lockdep_enabled(void)
> > +{
> > +	if (!debug_locks)
> > +		return false;
> > +
> > +	if (raw_cpu_read(lockdep_recursion))
> > +		return false;
> > +
> > +	if (current->lockdep_recursion)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  /*
> >   * lockdep_lock: protects the lockdep graph, the hashes and the
> >   *               class/list/hash allocators.
> > @@ -93,7 +110,7 @@ static inline void lockdep_lock(void)
> >  
> >  	arch_spin_lock(&__lock);
> >  	__owner = current;
> > -	current->lockdep_recursion++;
> > +	__this_cpu_inc(lockdep_recursion);
> >  }
> >  
> >  static inline void lockdep_unlock(void)
> > @@ -101,7 +118,7 @@ static inline void lockdep_unlock(void)
> >  	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
> >  		return;
> >  
> > -	current->lockdep_recursion--;
> > +	__this_cpu_dec(lockdep_recursion);
> >  	__owner = NULL;
> >  	arch_spin_unlock(&__lock);
> >  }
> > @@ -393,10 +410,15 @@ void lockdep_init_task(struct task_struct *task)
> >  	task->lockdep_recursion = 0;
> >  }
> >  
> > +static __always_inline void lockdep_recursion_inc(void)
> > +{
> > +	__this_cpu_inc(lockdep_recursion);
> > +}
> > +
> >  static __always_inline void lockdep_recursion_finish(void)
> >  {
> > -	if (WARN_ON_ONCE((--current->lockdep_recursion) &
> > LOCKDEP_RECURSION_MASK))
> > -		current->lockdep_recursion = 0;
> > +	if (WARN_ON_ONCE(__this_cpu_dec_return(lockdep_recursion)))
> > +		__this_cpu_write(lockdep_recursion, 0);
> >  }
> >  
> >  void lockdep_set_selftest_task(struct task_struct *task)
> > @@ -3659,7 +3681,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
> >  	if (unlikely(in_nmi()))
> >  		return;
> >  
> > -	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
> > +	if (unlikely(__this_cpu_read(lockdep_recursion)))
> >  		return;
> >  
> >  	if (unlikely(lockdep_hardirqs_enabled())) {
> > @@ -3695,7 +3717,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
> >  
> >  	current->hardirq_chain_key = current->curr_chain_key;
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__trace_hardirqs_on_caller();
> >  	lockdep_recursion_finish();
> >  }
> > @@ -3728,7 +3750,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
> >  		goto skip_checks;
> >  	}
> >  
> > -	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
> > +	if (unlikely(__this_cpu_read(lockdep_recursion)))
> >  		return;
> >  
> >  	if (lockdep_hardirqs_enabled()) {
> > @@ -3781,7 +3803,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
> >  	if (in_nmi()) {
> >  		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
> >  			return;
> > -	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
> > +	} else if (__this_cpu_read(lockdep_recursion))
> >  		return;
> >  
> >  	/*
> > @@ -3814,7 +3836,7 @@ void lockdep_softirqs_on(unsigned long ip)
> >  {
> >  	struct irqtrace_events *trace = &current->irqtrace;
> >  
> > -	if (unlikely(!debug_locks || current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	/*
> > @@ -3829,7 +3851,7 @@ void lockdep_softirqs_on(unsigned long ip)
> >  		return;
> >  	}
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	/*
> >  	 * We'll do an OFF -> ON transition:
> >  	 */
> > @@ -3852,7 +3874,7 @@ void lockdep_softirqs_on(unsigned long ip)
> >   */
> >  void lockdep_softirqs_off(unsigned long ip)
> >  {
> > -	if (unlikely(!debug_locks || current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	/*
> > @@ -4233,11 +4255,11 @@ void lockdep_init_map_waits(struct lockdep_map *lock,
> > const char *name,
> >  	if (subclass) {
> >  		unsigned long flags;
> >  
> > -		if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion))
> > +		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
> >  			return;
> >  
> >  		raw_local_irq_save(flags);
> > -		current->lockdep_recursion++;
> > +		lockdep_recursion_inc();
> >  		register_lock_class(lock, subclass, 1);
> >  		lockdep_recursion_finish();
> >  		raw_local_irq_restore(flags);
> > @@ -4920,11 +4942,11 @@ void lock_set_class(struct lockdep_map *lock, const
> > char *name,
> >  {
> >  	unsigned long flags;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	check_flags(flags);
> >  	if (__lock_set_class(lock, name, key, subclass, ip))
> >  		check_chain_key(current);
> > @@ -4937,11 +4959,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned
> > long ip)
> >  {
> >  	unsigned long flags;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	check_flags(flags);
> >  	if (__lock_downgrade(lock, ip))
> >  		check_chain_key(current);
> > @@ -4979,7 +5001,7 @@ static void verify_lock_unused(struct lockdep_map *lock,
> > struct held_lock *hlock
> >  
> >  static bool lockdep_nmi(void)
> >  {
> > -	if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
> > +	if (raw_cpu_read(lockdep_recursion))
> >  		return false;
> >  
> >  	if (!in_nmi())
> > @@ -5000,7 +5022,10 @@ void lock_acquire(struct lockdep_map *lock, unsigned
> > int subclass,
> >  
> >  	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
> >  
> > -	if (unlikely(current->lockdep_recursion)) {
> > +	if (!debug_locks)
> > +		return;
> > +
> > +	if (unlikely(!lockdep_enabled())) {
> >  		/* XXX allow trylock from NMI ?!? */
> >  		if (lockdep_nmi() && !trylock) {
> >  			struct held_lock hlock;
> > @@ -5023,7 +5048,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int
> > subclass,
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__lock_acquire(lock, subclass, trylock, read, check,
> >  		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
> >  	lockdep_recursion_finish();
> > @@ -5037,13 +5062,13 @@ void lock_release(struct lockdep_map *lock, unsigned
> > long ip)
> >  
> >  	trace_lock_release(lock, ip);
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	if (__lock_release(lock, ip))
> >  		check_chain_key(current);
> >  	lockdep_recursion_finish();
> > @@ -5056,13 +5081,13 @@ noinstr int lock_is_held_type(const struct lockdep_map
> > *lock, int read)
> >  	unsigned long flags;
> >  	int ret = 0;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return 1; /* avoid false negative lockdep_assert_held() */
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	ret = __lock_is_held(lock, read);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> > @@ -5077,13 +5102,13 @@ struct pin_cookie lock_pin_lock(struct lockdep_map
> > *lock)
> >  	struct pin_cookie cookie = NIL_COOKIE;
> >  	unsigned long flags;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return cookie;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	cookie = __lock_pin_lock(lock);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> > @@ -5096,13 +5121,13 @@ void lock_repin_lock(struct lockdep_map *lock, struct
> > pin_cookie cookie)
> >  {
> >  	unsigned long flags;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__lock_repin_lock(lock, cookie);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> > @@ -5113,13 +5138,13 @@ void lock_unpin_lock(struct lockdep_map *lock, struct
> > pin_cookie cookie)
> >  {
> >  	unsigned long flags;
> >  
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> >  
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__lock_unpin_lock(lock, cookie);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> > @@ -5249,15 +5274,12 @@ void lock_contended(struct lockdep_map *lock, unsigned
> > long ip)
> >  
> >  	trace_lock_acquired(lock, ip);
> >  
> > -	if (unlikely(!lock_stat || !debug_locks))
> > -		return;
> > -
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lock_stat || !lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__lock_contended(lock, ip);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> > @@ -5270,15 +5292,12 @@ void lock_acquired(struct lockdep_map *lock, unsigned
> > long ip)
> >  
> >  	trace_lock_contended(lock, ip);
> >  
> > -	if (unlikely(!lock_stat || !debug_locks))
> > -		return;
> > -
> > -	if (unlikely(current->lockdep_recursion))
> > +	if (unlikely(!lock_stat || !lockdep_enabled()))
> >  		return;
> >  
> >  	raw_local_irq_save(flags);
> >  	check_flags(flags);
> > -	current->lockdep_recursion++;
> > +	lockdep_recursion_inc();
> >  	__lock_acquired(lock, ip);
> >  	lockdep_recursion_finish();
> >  	raw_local_irq_restore(flags);
> 
