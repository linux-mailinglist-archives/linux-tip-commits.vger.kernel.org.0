Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F103F3EA2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 22 Aug 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhHVIcg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 22 Aug 2021 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIcf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 22 Aug 2021 04:32:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC81C061757;
        Sun, 22 Aug 2021 01:31:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so11918845wme.1;
        Sun, 22 Aug 2021 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQ1yNU4vqIEk40OUz0tg5WSaqqsqtlnlUdKNR5VO9VA=;
        b=Mvb3peLYT99udPhc3kp/xiFcNHy+IP2iSKQkBXBiSVnYur/V9iVzfVkRofYp1diwlF
         DWKJ8hGP9rmYIL96HRP9fDsCfT96XE1Gp6Q4Gf0YDaXYvRqvU04tQqrT0ZPnsGiVdyoM
         B0/ERAWGHgM7tQtTFD/ydMpTk/EWMAu62FNA0cbpn+Y22Iv2I+ZhkWzuEnX1FxZMC1FT
         LnaTn3YvZlc1/mcYAb01DDJLEPS821z6sPM7qNMaOg9GYwWMHv+e1LWjGxZSBIxahdCf
         IC7hJTaxlFUT7/TEzNziR2WzsrxXXrw8LQn0Z0gmHOS78oUx6DEqEtPuzryeqASpOmBl
         QcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EQ1yNU4vqIEk40OUz0tg5WSaqqsqtlnlUdKNR5VO9VA=;
        b=aXkxrTeMzDKtHeVmA1i77yQDxLiha4VK55cvT2/Wt/b1KfKtj/JtItZZ0ctqCMFoju
         pmpGqLT6qh9VC51Y+IeBQJu84zMSInpTvjkEwOPkHzRyJ4mIOYYIBUcp4c02nJvw7NPa
         17yZpJdBhRRUf+OEAfyAf5c4JYr46gJblO+tAGQIBT50Ro198ui0p7bdjo43aNgy35X1
         8KtdwTtvDbzrnvMQaUhLo6b7bGraaVoe/pEb0aXg14od04aPvzchyOIR9ZHwRb6Sr8uG
         EVDtIvg63jYz42cx92dAZyKPv1jN4ECbbbAmLc8SRQR2o+2YyNP/4JFKDmmglelYbrF6
         AB9A==
X-Gm-Message-State: AOAM5309C63F//k417YMRnKPDrRBRzmOqQVcRaXw5Xo7LFhdRT3+Imhq
        KHp/a1LFci260WhV0C/jL2VBWD4yZgQ=
X-Google-Smtp-Source: ABdhPJxqYfTTZO/o/S/mdaOgrUMzUjpqSPUcgGCdoVdq9rummmN2bVcFZZTCJtILBsdSOTh4/kpbyQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr10887299wmc.95.1629621113533;
        Sun, 22 Aug 2021 01:31:53 -0700 (PDT)
Received: from gmail.com ([79.120.162.160])
        by smtp.gmail.com with ESMTPSA id d145sm14944487wmd.3.2021.08.22.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 01:31:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 22 Aug 2021 10:31:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/build: Remove stale cc-option checks
Message-ID: <YSILd/Dc0dYKK2qk@gmail.com>
References: <20210812183848.1519994-1-ndesaulniers@google.com>
 <162902143957.395.7404280890417854945.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162902143957.395.7404280890417854945.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* tip-bot2 for Nick Desaulniers <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/build branch of tip:
> 
> Commit-ID:     1463c2a27d59c69358ad1cbd869d3a8649695d8c
> Gitweb:        https://git.kernel.org/tip/1463c2a27d59c69358ad1cbd869d3a8649695d8c
> Author:        Nick Desaulniers <ndesaulniers@google.com>
> AuthorDate:    Thu, 12 Aug 2021 11:38:48 -07:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Sun, 15 Aug 2021 10:32:52 +02:00
> 
> x86/build: Remove stale cc-option checks
> 
> -mpreferred-stack-boundary= is specific to GCC, while -mstack-alignment=
> is specific to Clang. Rather than test for this three times via
> cc-option and __cc-option, rely on CONFIG_CC_IS_* from Kconfig.
> 
> GCC did not support values less than 4 for -mpreferred-stack-boundary=
> until GCC 7+. Change the cc-option test to check for a value of 2,
> rather than 4.

> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -14,10 +14,13 @@ endif
>  
>  # For gcc stack alignment is specified with -mpreferred-stack-boundary,
>  # clang has the option -mstack-alignment for that purpose.
> -ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +ifdef CONFIG_CC_IS_GCC
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=2),)
>        cc_stack_align4 := -mpreferred-stack-boundary=2
>        cc_stack_align8 := -mpreferred-stack-boundary=3
> -else ifneq ($(call cc-option, -mstack-alignment=16),)
> +endif
> +endif
> +ifdef CONFIG_CC_IS_CLANG
>        cc_stack_align4 := -mstack-alignment=4
>        cc_stack_align8 := -mstack-alignment=8

So I spent most of yesterday bisecting a hard to diagnose bug that looked 
like a GPU driver bug - but the bisect somewhat surprisingly ended up at 
this commit.

Doing the partial revert below solves the regression - as the above hunk is 
not obviously an identity transformation. I have a pretty usual GCC 10.3.0 
build environment with nothing exotic.

I amdended the commit with the partial revert in tip:x86/build.

Thanks,

	Ingo

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0d33ba013683..88fb2bca6a3e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,13 +14,10 @@ endif
 
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
-ifdef CONFIG_CC_IS_GCC
-ifneq ($(call cc-option, -mpreferred-stack-boundary=2),)
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
       cc_stack_align4 := -mpreferred-stack-boundary=2
       cc_stack_align8 := -mpreferred-stack-boundary=3
-endif
-endif
-ifdef CONFIG_CC_IS_CLANG
+else ifneq ($(call cc-option, -mstack-alignment=16),)
       cc_stack_align4 := -mstack-alignment=4
       cc_stack_align8 := -mstack-alignment=8
 endif
