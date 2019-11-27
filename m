Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73810B4B7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2019 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfK0RpE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Nov 2019 12:45:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0RpE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Nov 2019 12:45:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so6733717pfd.11
        for <linux-tip-commits@vger.kernel.org>; Wed, 27 Nov 2019 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTwVNHGfaslmzIOZLky3qVmqZLhSuuddPt+3vhSrt20=;
        b=Y3gBej2pMAYaD135FmDz7wFd7CKGnPhq2UTsznJ4G4NRkUC/4EcBYtTw8E5IPxcoER
         K0KlpmIxhtAv3XIL/PWz6hESe7un5DV/xFeK2XtzMnuCAo/kLSROivitXUZUVk0k2VYK
         i+8WNUaBz6md3cdIzzmfWsssffOF/uxi7Zrsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTwVNHGfaslmzIOZLky3qVmqZLhSuuddPt+3vhSrt20=;
        b=C7O2otUodhk7pZwQq8BksMifJI226domIkfbwwGCmQM8YIG0T02qWP9/HZAfLRuTh7
         BkjQLO0+E6qMrT5RANTPuPUe0roDlwVuROPmIWh5z6IKYnL2/771+Vxch1gM44iaZytj
         QQuJRAWBoCV+8rTzIOSOZAs6A/0ZmUuQLRWDET6NSYTOZwHOdezk7VDsjhm0vEUj7EB+
         9ruAgtszU/x2xUef+tWciSRwo54vPetDHFlDYoRb8li3RPSn5dHOY9+k10ZEd8FVakAR
         LIJYDwKALnR/MWY0CKgW66mehSM0hqTfc1YQAyxqkOFlHgH1sFEpAfvF1hrKw1d78a57
         I6zg==
X-Gm-Message-State: APjAAAWrd/hg60ZbRSFLNcXBaivzY9V3CiQ6WpmiinIobeetZlc803b5
        aSJeY7CDAE+zF2lJaewqljocPw==
X-Google-Smtp-Source: APXvYqzbGSwKUJ4Noau1bQM4eNgbwqA6hn7o9JrHTNxVF5DVVi7DHYmfOkLXN+C7ZQwdjV/oYCLKSQ==
X-Received: by 2002:a63:da13:: with SMTP id c19mr6164709pgh.435.1574876701803;
        Wed, 27 Nov 2019 09:45:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f26sm16293199pgf.22.2019.11.27.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:45:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 09:44:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/urgent] lkdtm: Add a DOUBLE_FAULT crash type on x86
Message-ID: <201911270942.0F120BF82@keescook>
References: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Nov 27, 2019 at 08:19:30AM -0000, tip-bot2 for Andy Lutomirski wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     b09511c253e5c739a60952b97c071a93e92b2e88
> Gitweb:        https://git.kernel.org/tip/b09511c253e5c739a60952b97c071a93e92b2e88
> Author:        Andy Lutomirski <luto@kernel.org>
> AuthorDate:    Sun, 24 Nov 2019 21:18:04 -08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00
> 
> lkdtm: Add a DOUBLE_FAULT crash type on x86
> 
> The DOUBLE_FAULT crash does INT $8, which is a decent approximation
> of a double fault.  This is useful for testing the double fault
> handling.  Use it like:
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c  | 39 +++++++++++++++++++++++++++++++++++++-
>  drivers/misc/lkdtm/core.c  |  3 +++-
>  drivers/misc/lkdtm/lkdtm.h |  3 +++-
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 7284a22..a4fdad0 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -12,6 +12,10 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/uaccess.h>
>  
> +#ifdef CONFIG_X86_32
> +#include <asm/desc.h>
> +#endif
> +
>  struct lkdtm_list {
>  	struct list_head node;
>  };
> @@ -337,3 +341,38 @@ void lkdtm_UNSET_SMEP(void)
>  	pr_err("FAIL: this test is x86_64-only\n");
>  #endif
>  }
> +
> +#ifdef CONFIG_X86_32
> +void lkdtm_DOUBLE_FAULT(void)
> +{
> +	/*
> +	 * Trigger #DF by setting the stack limit to zero.  This clobbers
> +	 * a GDT TLS slot, which is okay because the current task will die
> +	 * anyway due to the double fault.
> +	 */
> +	struct desc_struct d = {
> +		.type = 3,	/* expand-up, writable, accessed data */
> +		.p = 1,		/* present */
> +		.d = 1,		/* 32-bit */
> +		.g = 0,		/* limit in bytes */
> +		.s = 1,		/* not system */
> +	};
> +
> +	local_irq_disable();
> +	write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
> +			GDT_ENTRY_TLS_MIN, &d, DESCTYPE_S);
> +
> +	/*
> +	 * Put our zero-limit segment in SS and then trigger a fault.  The
> +	 * 4-byte access to (%esp) will fault with #SS, and the attempt to
> +	 * deliver the fault will recursively cause #SS and result in #DF.
> +	 * This whole process happens while NMIs and MCEs are blocked by the
> +	 * MOV SS window.  This is nice because an NMI with an invalid SS
> +	 * would also double-fault, resulting in the NMI or MCE being lost.
> +	 */
> +	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
> +		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
> +
> +	panic("tried to double fault but didn't die\n");

I'll modify this in some later patches, but I prefer the #ifdef inside
the function so that all tests are visible on all
architectures/configurations. And it should not panic on a test failure,
it should continue (see the others) with something like:

	pr_err("FAIL: did not double fault!\n");

E.g. an external system monitor would see the double-fault and the panic as
both causing a system reboot, but only the double-fault should do that.

> +}
> +#endif
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index cbc4c90..ee0d6e7 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -171,6 +171,9 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(USERCOPY_KERNEL_DS),
>  	CRASHTYPE(STACKLEAK_ERASING),
>  	CRASHTYPE(CFI_FORWARD_PROTO),
> +#ifdef CONFIG_X86_32
> +	CRASHTYPE(DOUBLE_FAULT),
> +#endif

And then ifdefs aren't needed here either.

>  };
>  
>  
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index ab446e0..c56d23e 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -28,6 +28,9 @@ void lkdtm_CORRUPT_USER_DS(void);
>  void lkdtm_STACK_GUARD_PAGE_LEADING(void);
>  void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
>  void lkdtm_UNSET_SMEP(void);
> +#ifdef CONFIG_X86_32
> +void lkdtm_DOUBLE_FAULT(void);
> +#endif

Same.

>  
>  /* lkdtm_heap.c */
>  void __init lkdtm_heap_init(void);

-- 
Kees Cook
