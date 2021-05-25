Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC4390852
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhEYSBq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhEYSBo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 14:01:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CAC061574;
        Tue, 25 May 2021 11:00:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621965612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKSV89E/6EiSVlVjhoAd4jt3GiLGZVtIU+F/LgVrtdw=;
        b=vVkGgQH93Lgt5QEtsQIHjDUQ1vPUsDVdoNFy39FEgMj33Q4sFUBoqe97mj99aNdhtTGkrc
        6tH4hij+q/wLno+L4QRxYk4LmY80pEmSpDcQXlnLEvlyB5Om6QJHQOhfEdAehXlvBPgVFi
        y17B6cX9U/Qf2EmRPwWpy9/zwNMEZHN9kbL9nfoF24+6FQLp1rncyyddO4ZREVoqgtk72Z
        R6eH+a1mZQ1J/kmvbrMJhiTvDtVLFpDY2BSTkV8pXfcqqh/arcXG6CiZgx2/vw3WyDlpph
        bXPjiAHk2MzKaNGftDa5CCXUpadsYtbrFeAjhHnB8h5ZOcrNAIj7cREHagmCnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621965612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKSV89E/6EiSVlVjhoAd4jt3GiLGZVtIU+F/LgVrtdw=;
        b=P1g/A7Xb52/fy6IIW7+cCIlHncl/zsJqew/anHCMWH4DwSzRtdBTwsDY442pE0M161GOeS
        hVww1RpWfD3W49BQ==
To:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing fpregs and xstates
In-Reply-To: <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com> <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2> <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com> <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
Date:   Tue, 25 May 2021 20:00:12 +0200
Message-ID: <87y2c28zir.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 25 2021 at 10:44, Yu-cheng Yu wrote:
> On 5/24/2021 9:34 AM, Andy Lutomirski wrote:
>> So I'm guessing that syzbot may have misattributed the problem.  But
>> we definitely need to clean up the XRSTOR #GP handling before CET
>> lands.
>> 
>  From the crash dump, the system is doing syscall_exit_to_user_mode() 
> for __x64_sys_futex().  The futex syscall does not seem to modify 
> xstates,

Of course does the futex syscall not modify anything, but the task can
schedule out before returning from the syscall so it has to restore the
FPU state.

> but upon returning to user mode, XRSTORS gets a GP.  Can this 
> be some memory corruption?  fpu__clear() is merely helping to clear the 
> mess and seems to be innocent.

What kind of analysis is that?

Thanks,

        tglx
