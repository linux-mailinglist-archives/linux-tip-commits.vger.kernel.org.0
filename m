Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25B1FBD75
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgFPSBE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbgFPSBD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 14:01:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA4C06174E
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so2525003pgk.4
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5GCoVo3uSDTWQdQpZhO042AIJ0zFlBqyDGrSyWAiePU=;
        b=WDs3XP+J3ALMihggY9JVpUa4ZbnzxJIUYt17zfaqy4aZfhpfFWZ8eisdsc+D9uZ+Qh
         oyrf1b9w/CjZxuNfDOJx8mVHk/fULXeKXDyD7NCRpjnDvNzuTdgoUHBR9BWzOly5em3t
         1gnbPzqoyH/5uuABy4M7C7ROENSCevi+NKSGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GCoVo3uSDTWQdQpZhO042AIJ0zFlBqyDGrSyWAiePU=;
        b=pgwYhyjFccCu1kzid4NJKUDHmRsH0Gi8CPOhUR4Dq4N4N3fo0iPNw1gt/DLB7hyi4O
         jB85h1vMNee497S0EVy6iPFHHysxkeFAErFKm6n4ZEVDaNb/z7Zan5aG6l3dgBS5Er1I
         ZIgELK8AbpDonHLpxZU+t7134k4e2WSMUKLa3PVdv3jTC2QlyR4uqJhXOu7DU2SyyXXH
         BcEs6angWJtn0bKvhXSkSMnKxPmnXSkAro6z3HmdeuZV9LK+/o+24QV/0tSM2i3KGp6g
         Ee8APgln1l2UaWVw//3yVOSY2WIWGv3301km4FVbYtCdnYijzLUOAPQ9ttlvxDFhOtdI
         /xmA==
X-Gm-Message-State: AOAM533OF23nVgQ6vAdVPd0w9w+SOY347EE1l5xyAg1NZgjNJ5vvG8Qk
        eiEtwPi9bRVi7Kj89MpVMq3bnA==
X-Google-Smtp-Source: ABdhPJzt1gHmWoNLYadZ8B/Bl+/WxivybW57fLERVIucPwVkj8rz4lMFMIHrw0GZ4ySHeU7bQohkVA==
X-Received: by 2002:a63:124a:: with SMTP id 10mr2942412pgs.336.1592330462065;
        Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm17239435pff.37.2020.06.16.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:01:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:00:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Use sh_info to find the base for
 .rela sections
Message-ID: <202006161057.E6D5D84@keescook>
References: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Apr 22, 2020 at 10:24:44PM -0000, tip-bot2 for Sami Tolvanen wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
> Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
> Author:        Sami Tolvanen <samitolvanen@google.com>
> AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
> Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00
> 
> objtool: Use sh_info to find the base for .rela sections
> 
> ELF doesn't require .rela section names to match the base section. Use
> the section index in sh_info to find the section instead of looking it
> up by name.
> 
> LLD, for example, generates a .rela section that doesn't match the base
> section name when we merge sections in a linker script for a binary
> compiled with -ffunction-sections.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi!

Where did this commit end up? It seems to have vanished (404 on the
Gitweb link) and isn't in -next nor Linus's tree.

This is needed for LTO, FGKASLR, and link speed improvements[1]. Is it
possible to get this landed in -rc2 so all the things depending on it
can rebase happily?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com/

> ---
>  tools/objtool/elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c4857fa..c20dfe1 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -468,7 +468,7 @@ static int read_relas(struct elf *elf)
>  		if (sec->sh.sh_type != SHT_RELA)
>  			continue;
>  
> -		sec->base = find_section_by_name(elf, sec->name + 5);
> +		sec->base = find_section_by_index(elf, sec->sh.sh_info);
>  		if (!sec->base) {
>  			WARN("can't find base section for rela section %s",
>  			     sec->name);

-- 
Kees Cook
