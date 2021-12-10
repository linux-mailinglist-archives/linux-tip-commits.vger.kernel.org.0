Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04C470B94
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Dec 2021 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbhLJUOv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Dec 2021 15:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhLJUOu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Dec 2021 15:14:50 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B805C0617A2
        for <linux-tip-commits@vger.kernel.org>; Fri, 10 Dec 2021 12:11:15 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n66so14690059oia.9
        for <linux-tip-commits@vger.kernel.org>; Fri, 10 Dec 2021 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=KOuxIJMKNYTeFBZJypgba4fX+/Q0qIYXKhuuL8rsgx0=;
        b=jVoZIrcMIhcs34MqmEu4ybtJ5mLwAIvoFS0tyZsRHN4vdJAK/w845YZOVWqDs0cTJ9
         zyZqSqx4fdy9fgwK5vH4S+kbFps3bK2u+/N34wWhw5m9GiKK5/JsNEvB5noC2KjZCY3F
         Xqb+ha3f/RuGPuLBdlIDA3m2rXEfI0QOkqwmn4Iil6ZoshZlDPnAMQhpGISk2HbeumEX
         Unit1NJWJd3ryBpOJKu5EMDpLo/4/Cjl3i6TCaOHcWmh0GamQpWIXnzjtmbU89W+c+nt
         0x68acITGXIkgSXRJkuzZUwV6BTrVCDCYMNJTDKK/9bWdlX+i20vygzsV62Qz14DvYYN
         Y6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=KOuxIJMKNYTeFBZJypgba4fX+/Q0qIYXKhuuL8rsgx0=;
        b=w9aZ2l9h+GfX97aCujyQ72bDR5aXE+GU3XhQ0/UO1Nia6NxZJgyNsdshiGAjepFIgB
         QkgSDkWwWXyF2Eamn5L1/+Iuthli5Y/LpI/IWROhLY1rwU0HLVFKLkQNXKhDjApRkRu4
         KJUVReKa/6FH5C/2vdWzR/DyGxFKR4GCYFdCsDJMlMWB5Rf6++Mc10s/7tnjQfqg1noJ
         5Rity7rJE0G+304YuN7g0j4KOsTIbDFFfFpUnc0Mwo7r6xPtwaUZDJOLC09ME7E+TTj8
         cm+d8rLVAYZVIAdMwPR0VnIL00TOdCUBBK0coJpMl764bnJI46dYfGTKlifspFj79Q3X
         ip2A==
X-Gm-Message-State: AOAM531J5KmjIiq5weeB7T64PBFtRFX5HCiv/sBNskn1AF49bkVIJ+rJ
        X+TDaSvknHNUnUvrAZ74cHaHLw==
X-Google-Smtp-Source: ABdhPJyii/gnYmnJibARTLGKVefuQ1oitr4zcIVcaAzq7IipapeLfzuP8rfZ9812r9rqo2jWSqft+g==
X-Received: by 2002:a54:480b:: with SMTP id j11mr14297800oij.102.1639167074440;
        Fri, 10 Dec 2021 12:11:14 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f20sm991153oiw.48.2021.12.10.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:11:14 -0800 (PST)
Date:   Fri, 10 Dec 2021 12:11:02 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@alien8.de>
cc:     Mike Rapoport <rppt@kernel.org>, Juergen Gross <jgross@suse.com>,
        John Dorminy <jdorminy@redhat.com>, tip-bot2@linutronix.de,
        anjaneya.chagam@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        stable@vger.kernel.org, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Subject: Re: [tip: x86/urgent] x86/boot: Pull up cmdline preparation and
 early param parsing
In-Reply-To: <YbM5yR+Hy+kwmMFU@zn.tnic>
Message-ID: <297f4912-907-bb45-75df-a030b0d88a8e@google.com>
References: <163697618022.414.12673958553611696646.tip-bot2@tip-bot2> <20211209143810.452527-1-jdorminy@redhat.com> <YbIeYIM6JEBgO3tG@zn.tnic> <50f25412-d616-1cc6-f07f-a29d80b4bd3b@suse.com> <YbIgsO/7oQW9h6wv@zn.tnic> <YbIu55LZKoK3IVaF@kernel.org>
 <YbIw1nUYJ3KlkjJQ@zn.tnic> <YbM5yR+Hy+kwmMFU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, 10 Dec 2021, Borislav Petkov wrote:
> On Thu, Dec 09, 2021 at 05:37:42PM +0100, Borislav Petkov wrote:
> > Whatever we do, it needs to be tested by all folks on Cc who already
> > reported regressions, i.e., Anjaneya, Hugh, John and Patrick.
> 
> Ok, Mike is busy so here are some patches for testing:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc4-boot
> 
> I'd appreciate it if folks who reported an issue, verify those.
> 
> The first two are reverts which should address the issues with mem=
> folks have reported. And the last one should address Anjaneya's issue.
> 
> I guess doing it the way as Mike suggested is cleaner/better.

Yes, mem= works fine for me, on both machines, 64-bit and 32-bit,
thanks; but I'm not exercising the troublesome EFI case at all.

Hugh
