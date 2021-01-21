Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFED72FF60A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 21:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbhAUUiE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 15:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbhAUHuN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 02:50:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4991C0613C1;
        Wed, 20 Jan 2021 23:49:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g24so1284908edw.9;
        Wed, 20 Jan 2021 23:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n0kVyilkbftdlhrZGBzYXl+bMHX+Nzyhy+1J+qK9jjI=;
        b=fv3ivvntYxxPUhrJb3+zPJxO8OIJuhpnp9BZ7IMLgLKd7i0n80zEGOlQePgYYjWbU9
         44MmOi9vxggwQ9j6BAo27frRmyI6koeynqELS9CCAeXeOp/DVbkuu1HOdKET49ELVadr
         8Pt9ngTFvf9hHBouOyg45MkXl+XhujYr2j7vd1JiyF4Ml8eZ1qO42xr9D/EKUhaA36F7
         Ho66gRxB/g/cdSgXgHE0SwO5PVQnPX4Ca9sg7Karft29NtUjz7eDTa9m/ey1ApivI9lD
         EoeymaoX1B6l6UPfM6yl0Qq/T+da4RzVQh9YFZt7I94ZUO1cvLkLV0Qc8Qt4qLZGQPEw
         CEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n0kVyilkbftdlhrZGBzYXl+bMHX+Nzyhy+1J+qK9jjI=;
        b=Yc+g0eevkSSs+Tmw4srzCnBReEInBuKzqthkSqG02T3ddtB7vLFvln/RPnLUQl822q
         ycqMurdMR7QGnDsuxE+6AJHUkca6YE6qquPFpvIwrf0cgFh35u3bOwoM/AZ3k5dOgYI2
         yU1RSryLT6Gi7uY4xCyxb6Juk3jFgdp6GLxakfVD2KH3t+cpkQQPUkkUc+zr2BF7lq6+
         9Uyrrkfvxmyyygo1Z6ucbKnczCW+LCBfKhaTRUDAC/vJ93veZiEDCs20th6uuunTWD7j
         pB6SyeZ99vkwOZeSjR5dQxLzKF2Grmb2yiNbELwFdo7v2tnMA0+K7pHUjYR+DR6as8Te
         u/eA==
X-Gm-Message-State: AOAM531y8yQhYPkeUoMJZtVX+yuff93b90vHWmsuQmodXCrDcIvgtdgP
        DndY90/EVP9LEpB6lvnAgL1qX2dbMHk=
X-Google-Smtp-Source: ABdhPJxkJJ8mCPvmxZOt0+ncQM1iIBTaVCp6iEK8CWEH+NfAjrAuyOjerE6XoqZKGigy6eZEGeGLPA==
X-Received: by 2002:a05:6402:1549:: with SMTP id p9mr10319164edx.387.1611215371583;
        Wed, 20 Jan 2021 23:49:31 -0800 (PST)
Received: from gmail.com (20014C4E1C877B00F0D36816790CCC7F.dsl.pool.telekom.hu. [2001:4c4e:1c87:7b00:f0d3:6816:790c:cc7f])
        by smtp.gmail.com with ESMTPSA id u23sm2276091edt.78.2021.01.20.23.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 23:49:30 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 21 Jan 2021 08:49:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andrea Righi <andrea.righi@canonical.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/entry] x86/entry: Build thunk_$(BITS) only if
 CONFIG_PREEMPTION=y
Message-ID: <20210121074928.GA1346795@gmail.com>
References: <YAAvk0UQelq0Ae7+@xps-13-7390>
 <161121327995.414.14890124942899525500.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161121327995.414.14890124942899525500.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* tip-bot2 for Andrea Righi <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/entry branch of tip:
> 
> Commit-ID:     e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> Gitweb:        https://git.kernel.org/tip/e6d92b6680371ae1aeeb6c5eb2387fdc5d9a2c89
> Author:        Andrea Righi <andrea.righi@canonical.com>
> AuthorDate:    Thu, 14 Jan 2021 12:48:35 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 21 Jan 2021 08:11:52 +01:00
> 
> x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
> 
> With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_64.o is just an
> empty object file.
> 
> With the newer binutils (tested with 2.35.90.20210113-1ubuntu1) the GNU
> assembler doesn't generate a symbol table for empty object files and
> objtool fails with the following error when a valid symbol table cannot
> be found:
> 
>   arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table
> 
> To prevent this from happening, build thunk_$(BITS).o only if
> CONFIG_PREEMPTION is enabled.
> 
>   BugLink: https://bugs.launchpad.net/bugs/1911359
> 
> Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Link: https://lore.kernel.org/r/YAAvk0UQelq0Ae7+@xps-13-7390

Hm, this fails to build on UML defconfig:

 /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_thunk':
 /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:34: undefined reference to `preempt_schedule'
 /home/mingo/gcc/cross/lib/gcc/x86_64-linux/9.3.1/../../../../x86_64-linux/bin/ld: arch/x86/um/../entry/thunk_64.o: in function `preempt_schedule_notrace_thunk':
 /home/mingo/tip.cross/arch/x86/um/../entry/thunk_64.S:35: undefined reference to `preempt_schedule_notrace'

Thanks,

	Ingo
