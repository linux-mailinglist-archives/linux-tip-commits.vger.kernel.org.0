Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88E01FC29D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Jun 2020 02:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQALd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQALd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 20:11:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C7C061573
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Jun 2020 17:11:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so93797plo.7
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Jun 2020 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kmhNDfQNJXO7hJjKTrMFRtUAQoboP57XjXJsRdtwLc=;
        b=KVjdG0xGsNAP+iBrZQFtPpU2KZSHZCCjm3KBV/jssT/5iobGKg3jpwP8jT6qN/sBoO
         gZIoEPF4VR/E6AqWPrkzP5L8RRdbEtNB2B4BgOj9qcksqrirQzCXaa5jcWoHZImWv+S9
         gkyg7/BC0+6Wpg0zIphK4G2PD3XKJAbpJycMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kmhNDfQNJXO7hJjKTrMFRtUAQoboP57XjXJsRdtwLc=;
        b=qF+nYXCZdbDD6yl8SNhQ/U7rcV8FxEszcU1Nn1pCqrP8S6csVlZ6bWh87BsiGqlIbS
         rX+ZPYW15hM57lph8EWTW/BaCmEIJ55dqm3JvdGmufG8DxFhN+aBFjYBCSlsxOAlt0T1
         JM2OATspNuLuYT60BYuDqUABx4/yM6BiMGP42drQNakerIC+eKqrT6NhtzTsSh7BqMb5
         JfderbbwrrKMoSXvuqdj1N39pP87bmBl/vWCzNxhnb45BZMOd1LHX1g8XnCw2MrstmTA
         Nj9dBc6wPpl91A7vEfD/5YF49MMm1cHbrxTgWj35OZAatF5annElKTF3h92YW5S9xrOv
         mxDw==
X-Gm-Message-State: AOAM530PBWCjbywFeUlQJVQOSvpJ2Ztm3lYPRxcVp8Sd0Ax1TrurTYlM
        7c2YoputBs0hCmwLtS+yXBsicA==
X-Google-Smtp-Source: ABdhPJxNcrIoyau+3OONR7kGcda1pQTKvdJb7jjXMH3fna2AEp/BvXQRIc+lCG/st65ey5B4ks8M3Q==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr4077107plp.50.1592352691138;
        Tue, 16 Jun 2020 17:11:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oc6sm3816845pjb.43.2020.06.16.17.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:11:29 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:11:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Use sh_info to find the base for
 .rela sections
Message-ID: <202006161708.8CC6F4974@keescook>
References: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
 <202006161057.E6D5D84@keescook>
 <20200616192749.GB2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616192749.GB2531@hirez.programming.kicks-ass.net>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Jun 16, 2020 at 09:27:49PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 11:00:59AM -0700, Kees Cook wrote:
> > On Wed, Apr 22, 2020 at 10:24:44PM -0000, tip-bot2 for Sami Tolvanen wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > > 
> > > Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > > Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
> > > Author:        Sami Tolvanen <samitolvanen@google.com>
> > > AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
> > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00
> > > 
> > > objtool: Use sh_info to find the base for .rela sections
> > > 
> > > ELF doesn't require .rela section names to match the base section. Use
> > > the section index in sh_info to find the section instead of looking it
> > > up by name.
> > > 
> > > LLD, for example, generates a .rela section that doesn't match the base
> > > section name when we merge sections in a linker script for a binary
> > > compiled with -ffunction-sections.
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Hi!
> > 
> > Where did this commit end up? It seems to have vanished (404 on the
> > Gitweb link) and isn't in -next nor Linus's tree.
> > 
> > This is needed for LTO, FGKASLR, and link speed improvements[1]. Is it
> > possible to get this landed in -rc2 so all the things depending on it
> > can rebase happily?
> 
> I can't remember why this happened, however I think this patch is in
> josh's objtool tree that I was going to stick in objtool/core
> tomorrow-ish.

Okay, thanks!

> Are those things you mentioned still slated for this release?

No, the three things I mentioned aren't for v5.8 (they're still under
development), but sending their respective series without the -tip
patches in -rc2 will result in redundant patches. (So, it's hardly the
end of the world, but it's just a confusing state to be in since they
appeared in -tip and then never ended up in the merge window. It'd be
helpful to have them in place for things that will base their latest
tree on v5.8-rc2.)

-- 
Kees Cook
