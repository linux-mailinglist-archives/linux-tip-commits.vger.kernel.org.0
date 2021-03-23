Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6C346D79
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhCWWos (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 18:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhCWWol (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 18:44:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE9C061574;
        Tue, 23 Mar 2021 15:44:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so171536pjg.5;
        Tue, 23 Mar 2021 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4mIqrxpL0hv9pFkU59tSylHTm8hWiP5P63sXNpwmS5Y=;
        b=mBW9sXhbyxuhGaI8Snrq/JRwe38NlscZpQj992EaRA1rQ8RmOtCQZa6bY9ocScx2YW
         CIPVyKJrVaEeuB4QwKpXc3+rhuqXY3jnJcVrikoCVBgglpF+sBu4gQKpFWnldYY20ILq
         jZTNnbqOEoINg88g85bhsUfvVztd38S40UQ948d/nAATVn4FdZLnIeBoYuHhHwqavynR
         OEtCkALKofjiKhelnI2xs+Krd4utSgnyFO3FNCETAw6j1057m1ZU7stfaB7fnnv9MtDA
         V/OvmlkCuG9I7iPYTAPMwWJy3ln1wDJKDAXRGuO91Q0tGp1fQS9SkbmuTLfsNvoksjwO
         hjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mIqrxpL0hv9pFkU59tSylHTm8hWiP5P63sXNpwmS5Y=;
        b=VZceWb9Qrh1frNup35++DCMOsfq430klex/kTbbhU0yQ9dqoInslifOm97n/nUxA0c
         fkCkwzjVmK9JyY7Ipr1XtuzSPdxMcj3y2ZNpa4MxZh0GHcLtAhpWzOJqXlX+DJ6M1hh3
         gw+FlB0X+xYYLfoAc/yL57Kmdg8VQQAVpOc7LdDmNk+2IYtbcOOzdZV+XK55yS0rXueI
         HaCq61WIzLnRm2Aci36I+x70xL4eWB83C3i5H6vk1uifvHgX4pFC7eNFU23uBSlEl+am
         d2by+/N4v/+x/xIuZvDPCfE68WbekauTnUlgGpw0rNaPYnZrSPypbjyrrIjMhXCyrB5h
         lBog==
X-Gm-Message-State: AOAM533Fk3WCC1KQwWQVNCoNM7Y5l79PSWxwcQk8Va9lViSl+LPu1ZJw
        g6xKBq7XgkgKCGg3zed0ejKwhg2OJlk=
X-Google-Smtp-Source: ABdhPJzkliZ6sBh19wxNSYosYbjLj2Cb3ACaEuIFIGdtdI1t7V4NWQiAgPXbm9joDasgARKeVRi/Vg==
X-Received: by 2002:a17:90a:7045:: with SMTP id f63mr319012pjk.35.1616539480289;
        Tue, 23 Mar 2021 15:44:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4d6b:ca5a:c720:f5c9])
        by smtp.gmail.com with ESMTPSA id 22sm198388pjl.31.2021.03.23.15.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:44:38 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:44:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     tip-bot2 for Barry Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
Message-ID: <YFpvU30bKEZu0CSh@google.com>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com>
 <161485523394.398.10007682711343433706.tip-bot2@tip-bot2>
 <87zgzj5gpo.fsf@nanos.tec.linutronix.de>
 <87o8fy69e0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8fy69e0.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Thomas,

On Thu, Mar 04, 2021 at 07:50:31PM +0100, Thomas Gleixner wrote:
> Dmitry,
> 
> On Thu, Mar 04 2021 at 11:57, Thomas Gleixner wrote:
> > On Thu, Mar 04 2021 at 10:53, tip-bot wrote:
> >
> >> The following commit has been merged into the irq/core branch of tip:
> >>
> >> Commit-ID:     e749df1bbd23f4472082210650514548d8a39e9b
> >> Gitweb:        https://git.kernel.org/tip/e749df1bbd23f4472082210650514548d8a39e9b
> >> Author:        Barry Song <song.bao.hua@hisilicon.com>
> >> AuthorDate:    Wed, 03 Mar 2021 11:49:15 +13:00
> >> Committer:     Thomas Gleixner <tglx@linutronix.de>
> >> CommitterDate: Thu, 04 Mar 2021 11:47:52 +01:00
> >>
> >> genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
> >
> > this commit is immutable and I tagged it so you can pull it into your
> > tree to add the input changes on top:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-no-autoen-2021-03-04
> 
> Please hold on:
> 
>   https://lkml.kernel.org/r/CAHk-=wgZjJ89jeH72TC3i6N%2Bz9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com
> 
> I'll recreate a tag for you once rc2 is out.

It looks like the change has been picked up as
cbe16f35bee6880becca6f20d2ebf6b457148552i on top of -rc2,
but I don't think there is tag for it?

Thanks!

-- 
Dmitry
