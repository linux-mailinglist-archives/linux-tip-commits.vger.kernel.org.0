Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84C39080A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhEYRpl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 13:45:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:15706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhEYRpk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 13:45:40 -0400
IronPort-SDR: /byLTI5JQF5tTtLPB3U1HOXqOkUWjzA/pLFzd5a8ui5jf/j74yGYi8KtdgDdeBShUpJCy5/ZoT
 yhew8XmkankQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="181897563"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181897563"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:44:09 -0700
IronPort-SDR: uWshkxUNnbiX9UjDXkzNRFlgix7S4kdr+qVh9X9TFv2Pm7rioso6HagobCgZO8H5b9xjF3TzBw
 LC5dm4CJdBcg==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="546865626"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.101]) ([10.209.133.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:44:08 -0700
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com>
 <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
 <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
Date:   Tue, 25 May 2021 10:44:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 5/24/2021 9:34 AM, Andy Lutomirski wrote:
> On Sat, May 16, 2020 at 8:10 AM tip-bot2 for Fenghua Yu
> <tip-bot2@linutronix.de> wrote:
>>
>> The following commit has been merged into the x86/fpu branch of tip:
>>
>> Commit-ID:     b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
>> Gitweb:        https://git.kernel.org/tip/b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
>> Author:        Fenghua Yu <fenghua.yu@intel.com>
>> AuthorDate:    Tue, 12 May 2020 07:54:39 -07:00
>> Committer:     Borislav Petkov <bp@suse.de>
>> CommitterDate: Wed, 13 May 2020 13:41:50 +02:00
>>
>> x86/fpu/xstate: Define new functions for clearing fpregs and xstates
> 
> syzbot says this is busted.  I've made no effort to identify the
> precise bug that is making syzbot complain, but:
> 
>>   /*
>> - * Clear FPU registers by setting them up from
>> - * the init fpstate:
>> + * Clear FPU registers by setting them up from the init fpstate.
>> + * Caller must do fpregs_[un]lock() around it.
>>    */
>> -static inline void copy_init_fpstate_to_fpregs(void)
>> +static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
>>   {
>> -       fpregs_lock();
>> -
> 
> 
> 
>>          if (use_xsave())
>> -               copy_kernel_to_xregs(&init_fpstate.xsave, -1);
>> +               copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
>>          else if (static_cpu_has(X86_FEATURE_FXSR))
>>                  copy_kernel_to_fxregs(&init_fpstate.fxsave);
>>          else
>> @@ -307,9 +305,6 @@ static inline void copy_init_fpstate_to_fpregs(void)
>>
>>          if (boot_cpu_has(X86_FEATURE_OSPKE))
>>                  copy_init_pkru_to_fpregs();
> 
> if (boot_cpu_has(X86_FEATURE_OSPKE) && (features_mask & PKRU)), perhaps?
> 
>> -
>> -       fpregs_mark_activate();
>> -       fpregs_unlock();
>>   }
>>
>>   /*
>> @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
>>    * Called by sys_execve(), by the signal handler code and by various
>>    * error paths.
>>    */
>> -void fpu__clear(struct fpu *fpu)
>> +static void fpu__clear(struct fpu *fpu, bool user_only)
>>   {
>> -       WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
>> +       WARN_ON_FPU(fpu != &current->thread.fpu);
>>
>> -       fpu__drop(fpu);
>> +       if (!static_cpu_has(X86_FEATURE_FPU)) {
>> +               fpu__drop(fpu);
>> +               fpu__initialize(fpu);
>> +               return;
>> +       }
>>
>> -       /*
>> -        * Make sure fpstate is cleared and initialized.
>> -        */
>> -       fpu__initialize(fpu);
>> -       if (static_cpu_has(X86_FEATURE_FPU))
>> -               copy_init_fpstate_to_fpregs();
>> +       fpregs_lock();
>> +
>> +       if (user_only) {
>> +               if (!fpregs_state_valid(fpu, smp_processor_id()) &&
>> +                   xfeatures_mask_supervisor())
>> +                       copy_kernel_to_xregs(&fpu->state.xsave,
>> +                                            xfeatures_mask_supervisor());
> 
> This looks correct to me.
> 
> So I'm guessing that syzbot may have misattributed the problem.  But
> we definitely need to clean up the XRSTOR #GP handling before CET
> lands.
> 

 From the crash dump, the system is doing syscall_exit_to_user_mode() 
for __x64_sys_futex().  The futex syscall does not seem to modify 
xstates, but upon returning to user mode, XRSTORS gets a GP.  Can this 
be some memory corruption?  fpu__clear() is merely helping to clear the 
mess and seems to be innocent.

I also run the syz repro on my Tiger Lake machine, and it only produces 
segfaults (no Bad FPU state, etc.).

Yu-cheng
