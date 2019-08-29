Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88957A184D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2019 13:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfH2LWL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Aug 2019 07:22:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2LWL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Aug 2019 07:22:11 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3IV5-0000zc-VP; Thu, 29 Aug 2019 13:22:00 +0200
Date:   Thu, 29 Aug 2019 13:21:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>,
        kbuild-all@01.org, linux-tip-commits@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: timers/core] posix-cpu-timers: Use common permission check
 in posix_cpu_clock_get()
In-Reply-To: <201908291858.PW3xOkIL%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.1908291320010.1938@nanos.tec.linutronix.de>
References: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2> <201908291858.PW3xOkIL%lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 29 Aug 2019, kbuild test robot wrote:
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190828]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

I have no idea what you are testing there.

>    kernel/time/posix-cpu-timers.c: In function 'posix_cpu_clock_get':
> >> kernel/time/posix-cpu-timers.c:275:8: error: implicit declaration of function 'get_task_for_clock'; did you mean 'get_task_struct'? [-Werror=implicit-function-declaration]
>      tsk = get_task_for_clock(clock);
>            ^~~~~~~~~~~~~~~~~~
>            get_task_struct
> >> kernel/time/posix-cpu-timers.c:275:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      tsk = get_task_for_clock(clock);
>          ^
>    cc1: some warnings being treated as errors

That commit comes _after_ the commit which introduced the function and
get_task_for_clock() is defined above posix_cpu_clock_get(), so I assume
you missed to apply the commit on which this depends on.

Thanks,

	tglx
