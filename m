Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132EF2867C6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgJGSx3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgJGSx2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 14:53:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86768C0613D3
        for <linux-tip-commits@vger.kernel.org>; Wed,  7 Oct 2020 11:53:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so4468886ejg.9
        for <linux-tip-commits@vger.kernel.org>; Wed, 07 Oct 2020 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rdre9jrmRp+/9/Y6RnzGhKU8N5YkFWVxUCgScft3zmU=;
        b=OFMCe2fA7ENUSEpSD1GFyoJSxPtUoTVyvWQ0nTA6wRiRt3SeCvMFuQ4bQDkdqLvM/7
         /4/nQ7dvOnsthrJcz2BG09maCJRRIa5jdEe9z525GK+fBvhK5hoj+nY4WiqXn/+83XDh
         S1DVmBDjd9f3ZJU+WCAmMSwUQKH5R7gZLwd0KA+PNuih6PquuL2Ls5p5Cm2oRCwrTKVb
         gE//eAYWWZWyOQ2AUskNBJ2OZS/7EWasnYJSqWZCGBpRxgRegLepOnSxQGG0NnrrjdRF
         A9Ig8OW1Jz0RU6RtM10weytdPGoUgw+vqeM8WxFQLNtnef/z4F/K2lWeKD/tuNez14nM
         kYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rdre9jrmRp+/9/Y6RnzGhKU8N5YkFWVxUCgScft3zmU=;
        b=Y9Gq/Pl6C00pQcFsL5cb1klml9VfhSwOzC1AQYyxpxB/7IYeBx5xOdxl01L1U+hScz
         IVPtj5j1TvjXlGXf4xNfd6TwXhFkpqcSFUNv1askPDYZ7s1LKF6wLP5ygqhnSiZ1BxoS
         ULfkyJBWK9cQDH6zUR179kNsmiNdH/H/NsrMDTWfBYJT0vctjgh36v44FN5TBkVwu96G
         lF3xqAgR9Tga4iPqs6j2xa/XJYht7ve1R6LhxPZ5oErVQgtux8bp/EkOpMAgUssigZiv
         QLfPRXJJxPlW1xNC9k2Tz2SniARV8xnA514jMkeTIPuANjIOhPfvXHUTmsIvvILXU07W
         Y5bQ==
X-Gm-Message-State: AOAM5314G4YxTq2R6X1vXjhe7pYmZuxG/fDLceLIiUOW6n0qh+4jitNY
        9VYmb3tv6uCtZHOgC0VWEqQ3z0tyIhkjmZghf/ge1g==
X-Google-Smtp-Source: ABdhPJwTY40tXBoCGJvpR0HSEuM3/x/Oubwtv2I1I6/MuM6iQLQYOQ6MDqfOLpfRHPqQEuX+JWoAr7Ap/AtWi0NxOJA=
X-Received: by 2002:a17:906:7e47:: with SMTP id z7mr4723987ejr.418.1602096807136;
 Wed, 07 Oct 2020 11:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <160197822988.7002.13716982099938468868.tip-bot2@tip-bot2>
 <20201007111447.GA23257@zn.tnic> <20201007164536.GJ5607@zn.tnic> <20201007170305.GK5607@zn.tnic>
In-Reply-To: <20201007170305.GK5607@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Oct 2020 11:53:15 -0700
Message-ID: <CAPcyv4jgLRzDzXkbdHwA-XUwWuSoA1tZfVqgvFQ5jxq=m2P_Bg@mail.gmail.com>
Subject: Re: [tip: ras/core] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        stable <stable@vger.kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 7, 2020 at 11:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 07, 2020 at 06:45:36PM +0200, Borislav Petkov wrote:
> > It doesn't look like it is toolchain-specific and in both cases,
> > copy_mc_fragile's checksum is 0.
> >
> > SUSE Leap 15.1:
> >
> > Name           : binutils
> > Version        : 2.32-lp151.3.6.1
> >
> > $ grep -E "(copy_mc_fragile|copy_user_generic_unrolled)" Module.symvers
> > 0x00000000      copy_mc_fragile vmlinux EXPORT_SYMBOL_GPL
> > 0xecdcabd2      copy_user_generic_unrolled      vmlinux EXPORT_SYMBOL
> >
> > debian testing:
> >
> > Package: binutils
> > Version: 2.35-2
> >
> > $ grep -E "(copy_mc_fragile|copy_user_generic_unrolled)" Module.symvers
> > 0x00000000      copy_mc_fragile vmlinux EXPORT_SYMBOL_GPL
> > 0xecdcabd2      copy_user_generic_unrolled      vmlinux EXPORT_SYMBOL
>
> Ok, I think I have it:
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 7 Oct 2020 18:55:35 +0200
> Subject: [PATCH] x86/mce: Allow for copy_mc_fragile symbol checksum to be generated
>
> Add asm/mce.h to asm/asm-prototypes.h so that that asm symbol's checksum
> can be generated in order to support CONFIG_MODVERSIONS with it and fix:
>
>   WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version \
>           generation failed, symbol will not be versioned.
>
> For reference see:
>
>   4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
>   334bb7738764 ("x86/kbuild: enable modversions for symbols exported from asm")

Oh nice! I just sent a patch [1] to fix this up as well, but mine goes
after minimizing when it is exported, I think perhaps both are needed.

http://lore.kernel.org/r/160209507277.2768223.9933672492157583642.stgit@dwillia2-desk3.amr.corp.intel.com
